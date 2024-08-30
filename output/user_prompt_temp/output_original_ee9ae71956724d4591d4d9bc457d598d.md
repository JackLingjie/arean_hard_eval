<|User Prompt|>
%%writefile app.py
import streamlit as st
import pandas as pd
import io
import joblib
import base64
import matplotlib.pyplot as plt
import seaborn as sns
import datetime
from sklearn import tree
from sklearn.tree import _tree
import numpy as np

# Function to upload and generate predictions
def upload_and_generate_predictions():
    # File upload and prediction code
    def get_base64(bin_file):
        with open(bin_file, "rb") as f:
            data = f.read()
        return base64.b64encode(data).decode()

    def set_background(png_file):
        bin_str = get_base64(png_file)
        page_bg_img = (
            """
        <style>
        .stApp {
        background-image: url("data:image/png;base64,%s");
        background-size: cover;
        }
        </style>
        """
            % bin_str
        )
        st.markdown(page_bg_img, unsafe_allow_html=True)

    set_background("Screenshot (29).png")
    red_title = '<h1 style="color: white;">Equipment Failure Prediction</h1>'

    # Display the red title using st.markdown
    st.markdown(red_title, unsafe_allow_html=True)
    # Display the custom CSS style
    uploaded_file = st.file_uploader(
        "Upload an Excel or CSV file", type=["xlsx", "csv"]
    )
    if uploaded_file is not None:
        # Read the file into a DataFrame
        if (
            uploaded_file.type
            == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        ):  # Excel file
            df = pd.read_excel(uploaded_file, engine="openpyxl")
        else:  # CSV file
            df = pd.read_csv(uploaded_file)
        # st.session_state.predictions_df = df
        # st.session_state.uploaded_file=uploaded_file

        # Display the first screen

        if st.button("Generate predictions"):
            model = joblib.load("des_tree_clss.joblib")
            prediction = ""
            if "machine_status" in df.columns.to_list():
                prediction = model.predict(df.drop(columns=["machine_status"]))
            else:
                prediction = model.predict(df)
            df["Predicted_Status"] = prediction
            st.success("Predictions made successfully!")
            st.session_state.predictions_df = df
            st.session_state.uploaded_file = uploaded_file
            # Display the modified DataFrame with predictions
            # Save the DataFrame with predictions to st.session_state
            # Move to the second screen (graph display)
def display_graph(predictions_df, uploaded_file):
    def get_base64(bin_file):
        with open(bin_file, "rb") as f:
            data = f.read()
        return base64.b64encode(data).decode()

    def set_background(png_file):
        bin_str = get_base64(png_file)
        page_bg_img = (
            """
          <style>
          .stApp {
          background-image: url("data:image/png;base64,%s");
          background-size: cover;
          }
          </style>
          """
            % bin_str
        )
        st.markdown(page_bg_img, unsafe_allow_html=True)

    set_background("Screenshot (32).png")
    st.markdown('<div style="margin-top: 50px;"></div>', unsafe_allow_html=True)
    st.subheader("Early warning Signal:")
    # Create a DataFrame with the first 10 records with prediction status 1
    df_status_1 = predictions_df[predictions_df["Predicted_Status"] == 1].head(10)
    # Create a DataFrame with all records with prediction status 0
    df_status_0 = predictions_df[predictions_df["Predicted_Status"] == 0].head(10)
    # Combine the DataFrames
    df_combined = pd.concat([df_status_0, df_status_1])
    start_timestamp = datetime.datetime(2023, 1, 1)
    df_combined["Synthetic_Timestamp"] = pd.date_range(
        start=start_timestamp, periods=len(df_combined), freq="T"
    )
    # df_combined['Synthetic_Timestamp'] = pd.date_range(start='2023-01-01', periods=len(df_combined), freq='T')
    plt.figure(figsize=(10, 3))
    sns.scatterplot(
        x="Synthetic_Timestamp",
        y="Predicted_Status",
        hue="Predicted_Status",
        marker="o",
        s=200,
        data=df_combined,
        palette={1: "red", 0: "green"},
    )
    plt.xticks(rotation=45, ha="right")
    # plt.title("Machine Status Prediction - Combined")
    plt.xlabel("Timestamp")
    plt.ylabel("Value")
    st.pyplot()
    # Create a download link
    st.subheader("Download the File with Predictions:")
    st.write("Download the File with Predictions:")
    # st.markdown(title1, unsafe_allow_html=True)
    modified_file_name = (
        f"file_with_predictions_{uploaded_file.name}"
        if uploaded_file.name
        else "file_with_predictions.xlsx"
    )

    # Convert DataFrame to binary stream
    modified_file = io.BytesIO()
    if (
        uploaded_file.type
        == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    ):  # Excel file
        predictions_df.to_excel(modified_file, index=False, engine="xlsxwriter")
    else:  # CSV file
        predictions_df.to_csv(modified_file, index=False)
    modified_file.seek(0)
    # Create a download link
    st.download_button(
        label="Download File with Predictions",
        data=modified_file,
        file_name=modified_file_name,
        key="download_file_with_predictions",
    )
    # Rules functions
    def get_rules(tree, feature_names, class_names):
        tree_ = tree.tree_
        feature_name = [
            feature_names[i] if i != _tree.TREE_UNDEFINED else "undefined!"
            for i in tree_.feature
        ]

        paths = []
        path = []

        def recurse(node, path, paths):

            if tree_.feature[node] != _tree.TREE_UNDEFINED:
                name = feature_name[node]
                threshold = tree_.threshold[node]
                p1, p2 = list(path), list(path)
                p1 += [f"({name} <= {np.round(threshold, 3)})"]
                recurse(tree_.children_left[node], p1, paths)
                p2 += [f"({name} > {np.round(threshold, 3)})"]
                recurse(tree_.children_right[node], p2, paths)
            else:
                path += [(tree_.value[node], tree_.n_node_samples[node])]
                paths += [path]

        recurse(0, path, paths)

        # sort by samples count
        samples_count = [p[-1][1] for p in paths]
        ii = list(np.argsort(samples_count))
        paths = [paths[i] for i in reversed(ii)]

        rules = []
        for path in paths:
            rule = "if "

            for p in path[:-1]:
                if rule != "if ":
                    rule += " and "
                rule += str(p)
            rule += " then "
            if class_names is None:
                rule += "response: " + str(np.round(path[-1][0][0][0], 3))
            else:
                classes = path[-1][0][0]
                l = np.argmax(classes)
                rule += f"class: {class_names[l]} (proba: {np.round(100.0*classes[l]/np.sum(classes),2)}%)"
            rule += f" | based on {path[-1][1]:,} samples"
            rules += [rule]

        return rules
    st.subheader("Model Explainability:")
    model = joblib.load("des_tree_clss.joblib")
    rules = get_rules(model, predictions_df.columns, range(2))
    table_list = []
    for r in rules:
            colon_split = r.split(":")
            col_1 = colon_split[0]
            pipe_split = str(colon_split[1] + colon_split[2]).split("|")
            # print(colon_split)
            # print(pipe_split)
            col_2 = pipe_split[0]
            col_3 = pipe_split[1]
            table_list.append([col_1, col_2, col_3])
    table_df = pd.DataFrame(
          table_list, columns=["rule_details", "class_probabilities", "samples_count"]
        )
    rules_data_file = io.BytesIO()
    table_df.to_csv(rules_data_file, index=False)
    rules_data_file.seek(0)

        # Create a download link
    st.download_button(
            label="Model Explainability",
            data=rules_data_file,
            file_name="rules_data.csv",
            key="download_rules_data",
        )
# Run the app
if __name__ == "__main__":
    st.set_option("deprecation.showPyplotGlobalUse", False)
    st.set_page_config(page_title="Equipment Failure Prediction", page_icon="📈")
    pages = ["Upload and Predict", "Graph and Download"]
    page = st.sidebar.selectbox("Select a page", pages)
    if page == "Upload and Predict":
        upload_and_generate_predictions()
    elif page == "Graph and Download":
        if hasattr(st.session_state, "predictions_df"):
            display_graph(
                st.session_state.predictions_df, st.session_state.uploaded_file
            )
        else:
            st.warning("Please upload a file on the 'Upload and Predict' page first.")
this is mu code inthis i have a scatterplot graph i want to modify the code in a way that draw ploltly graph usw click events of ploltly when i click the instance of the circle it should give descion rule for the instance using lime.after graph if i click one circle or instance lime table and rule list should print there it self you can add download predictions and model explananbility in new side bar

<|The Start of Assistant A's Answer|>
To achieve this, you can use the Plotly library to create an interactive scatter plot and use the click events to display the decision rules for the selected instance using LIME. Here's how you can modify your code:

1. Install the Plotly library if you haven't already:

```bash
pip install plotly
```

2. Import the necessary libraries in your `app.py`:

```python
import plotly.express as px
import plotly.graph_objs as go
from lime.lime_tabular import LimeTabularExplainer
```

3. Replace the `sns.scatterplot` code in the `display_graph` function with the following Plotly code:

```python
fig = go.Figure()

fig.add_trace(
    go.Scatter(
        x=df_combined["Synthetic_Timestamp"],
        y=df_combined["Predicted_Status"],
        mode="markers",
        marker=dict(color=df_combined["Predicted_Status"], colorscale="Viridis"),
        text=df_combined.index,
    )
)

fig.update_layout(
    xaxis_title="Timestamp",
    yaxis_title="Value",
    title="Machine Status Prediction - Combined",
)

st.plotly_chart(fig)
```

4. Add a new function to handle click events and display LIME explanations:

```python
def display_lime_explanation(predictions_df, point_index):
    # Load the model
    model = joblib.load("des_tree_clss.joblib")

    # Prepare the data for LIME
    X = predictions_df.drop(columns=["Predicted_Status", "Synthetic_Timestamp"])
    y = predictions_df["Predicted_Status"]

    # Create a LIME explainer
    explainer = LimeTabularExplainer(
        X.values,
        feature_names=X.columns,
        class_names=["Normal", "Failure"],
        mode="classification",
    )

    # Get the explanation for the selected point
    exp = explainer.explain_instance(X.loc[point_index], model.predict_proba)

    # Display the explanation
    st.subheader(f"LIME Explanation for Point {point_index}")
    exp.as_pyplot_figure()
    st.pyplot()
```

5. Add a click event listener to the scatter plot:

```python
# Get the click event data
click_data = st.session_state.get("click_data", None)

# Check if a point was clicked
if click_data is not None:
    point_index = click_data["points"][0]["text"]
    display_lime_explanation(st.session_state.predictions_df, point_index)

# Update the click event data when the plot is clicked
st.session_state.click_data = st.plotly_click(fig)
```

Now, when you click on a point in the scatter plot, the LIME explanation for that point will be displayed below the plot.
<|The End of Assistant A's Answer|>

<|The Start of Assistant B's Answer|>
**Modifying the Code for Interactive Plotly Graph**

To create an interactive Plotly graph with click events, we'll use the `plotly` library. We'll also add a new sidebar for downloading predictions and model explainability.

### **Updated Code**

```python
import streamlit as st
import pandas as pd
import io
import joblib
import base64
import matplotlib.pyplot as plt
import seaborn as sns
import datetime
from sklearn import tree
from sklearn.tree import _tree
import numpy as np
import plotly.express as px

# Function to upload and generate predictions
def upload_and_generate_predictions():
    # File upload and prediction code
    def get_base64(bin_file):
        with open(bin_file, "rb") as f:
            data = f.read()
        return base64.b64encode(data).decode()

    def set_background(png_file):
        bin_str = get_base64(png_file)
        page_bg_img = (
            """
        <style>
        .stApp {
        background-image: url("data:image/png;base64,%s");
        background-size: cover;
        }
        </style>
        """
            % bin_str
        )
        st.markdown(page_bg_img, unsafe_allow_html=True)

    set_background("Screenshot (29).png")
    red_title = '<h1 style="color: white;">Equipment Failure Prediction</h1>'

    # Display the red title using st.markdown
    st.markdown(red_title, unsafe_allow_html=True)
    # Display the custom CSS style
    uploaded_file = st.file_uploader(
        "Upload an Excel or CSV file", type=["xlsx", "csv"]
    )
    if uploaded_file is not None:
        # Read the file into a DataFrame
        if (
            uploaded_file.type
            == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        ):  # Excel file
            df = pd.read_excel(uploaded_file, engine="openpyxl")
        else:  # CSV file
            df = pd.read_csv(uploaded_file)
        # st.session_state.predictions_df = df
        # st.session_state.uploaded_file=uploaded_file

        # Display the first screen

        if st.button("Generate predictions"):
            model = joblib.load("des_tree_clss.joblib")
            prediction = ""
            if "machine_status" in df.columns.to_list():
                prediction = model.predict(df.drop(columns=["machine_status"]))
            else:
                prediction = model.predict(df)
            df["Predicted_Status"] = prediction
            st.success("Predictions made successfully!")
            st.session_state.predictions_df = df
            st.session_state.uploaded_file = uploaded_file
            # Display the modified DataFrame with predictions
            # Save the DataFrame with predictions to st.session_state
            # Move to the second screen (graph display)

def display_graph(predictions_df, uploaded_file):
    def get_base64(bin_file):
        with open(bin_file, "rb") as f:
            data = f.read()
        return base64.b64encode(data).decode()

    def set_background(png_file):
        bin_str = get_base64(png_file)
        page_bg_img = (
            """
          <style>
          .stApp {
          background-image: url("data:image/png;base64,%s");
          background-size: cover;
          }
          </style>
          """
            % bin_str
        )
        st.markdown(page_bg_img, unsafe_allow_html=True)

    set_background("Screenshot (32).png")
    st.markdown('<div style="margin-top: 50px;"></div>', unsafe_allow_html=True)
    st.subheader("Early warning Signal:")
    # Create a DataFrame with the first 10 records with prediction status 1
    df_status_1 = predictions_df[predictions_df["Predicted_Status"] == 1].head(10)
    # Create a DataFrame with all records with prediction status 0
    df_status_0 = predictions_df[predictions_df["Predicted_Status"] == 0].head(10)
    # Combine the DataFrames
    df_combined = pd.concat([df_status_0, df_status_1])
    start_timestamp = datetime.datetime(2023, 1, 1)
    df_combined["Synthetic_Timestamp"] = pd.date_range(
        start=start_timestamp, periods=len(df_combined), freq="T"
    )
    # df_combined['Synthetic_Timestamp'] = pd.date_range(start='2023-01-01', periods=len(df_combined), freq='T')
    fig = px.scatter(
        df_combined,
        x="Synthetic_Timestamp",
        y="Predicted_Status",
        hover_name="Synthetic_Timestamp",
        hover_data=["Predicted_Status"],
        color="Predicted_Status",
        color_discrete_map={0: "green", 1: "red"},
        height=300,
    )
    st.plotly_chart(fig, use_container_width=True)

    # Create a download link
    st.subheader("Download the File with Predictions:")
    st.write("Download the File with Predictions:")
    # st.markdown(title1, unsafe_allow_html=True)
    modified_file_name = (
        f"file_with_predictions_{uploaded_file.name}"
        if uploaded_file.name
        else "file_with_predictions.xlsx"
    )

    # Convert DataFrame to binary stream
    modified_file = io.BytesIO()
    if (
        uploaded_file.type
        == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    ):  # Excel file
        predictions_df.to_excel(modified_file, index=False, engine="xlsxwriter")
    else:  # CSV file
        predictions_df.to_csv(modified_file, index=False)
    modified_file.seek(0)
    # Create a download link
    st.download_button(
        label="Download File with Predictions",
        data=modified_file,
        file_name=modified_file_name,
        key="download_file_with_predictions",
    )

    # Rules functions
    def get_rules(tree, feature_names, class_names):
        tree_ = tree.tree_
        feature_name = [
            feature_names[i] if i != _tree.TREE_UNDEFINED else "undefined!"
            for i in tree_.feature
        ]

        paths = []
        path = []

        def recurse(node, path, paths):

            if tree_.feature[node] != _tree.TREE_UNDEFINED:
                name = feature_name[node]
                threshold = tree_.threshold[node]
                p1, p2 = list(path), list(path)
                p1 += [f"({name} <= {np.round(threshold, 3)})"]
                recurse(tree_.children_left[node], p1, paths)
                p2 += [f"({name} > {np.round(threshold, 3)})"]
                recurse(tree_.children_right[node], p2, paths)
            else:
                path += [(tree_.value[node], tree_.n_node_samples[node])]
                paths += [path]

        recurse(0, path, paths)

        # sort by samples count
        samples_count = [p[-1][1] for p in paths]
        ii = list(np.argsort(samples_count))
        paths = [paths[i] for i in reversed(ii)]

        rules = []
        for path in paths:
            rule = "if "

            for p in path[:-1]:
                if rule != "if ":
                    rule += " and "
                rule += str(p)
            rule += " then "
            if class_names is None:
                rule += "response: " + str(np.round(path[-1][0][0][0], 3))
            else:
                classes = path[-1][0][0]
                l = np.argmax(classes)
                rule += f"class: {class_names[l]} (proba: {np.round(100.0*classes[l]/np.sum(classes),2)}%)"
            rule += f" | based on {path[-1][1]:,} samples"
            rules += [rule]

        return rules

    st.subheader("Model Explainability:")
    model = joblib.load("des_tree_clss.joblib")
    rules = get_rules(model, predictions_df.columns, range(2))
    table_list = []
    for r in rules:
        colon_split = r.split(":")
        col_1 = colon_split[0]
        pipe_split = str(colon_split[1] + colon_split[2]).split("|")
        # print(colon_split)
        # print(pipe_split)
        col_2 = pipe_split[0]
        col_3 = pipe_split[1]
        table_list.append([col_1, col_2, col_3])
    table_df = pd.DataFrame(
        table_list, columns=["rule_details", "class_probabilities", "samples_count"]
    )
    rules_data_file = io.BytesIO()
    table_df.to_csv(rules_data_file, index=False)
    rules_data_file.seek(0)

    # Create a download link
    st.download_button(
        label="Model Explainability",
        data=rules_data_file,
        file_name="rules_data.csv",
        key="download_rules_data",
    )

# Run the app
if __name__ == "__main__":
    st.set_option("deprecation.showPyplotGlobalUse", False)
    st.set_page_config(page_title="Equipment Failure Prediction", page_icon="📈")
    pages = ["Upload and Predict", "Graph and Download"]
    page = st.sidebar.selectbox("Select a page", pages)
    if page == "Upload and Predict":
        upload_and_generate_predictions()
    elif page == "Graph and Download":
        if hasattr(st.session_state, "predictions_df"):
            display_graph(
                st.session_state.predictions_df, st.session_state.uploaded_file
            )
        else:
            st.warning("Please upload a file on the '
<|The End of Assistant B's Answer|>