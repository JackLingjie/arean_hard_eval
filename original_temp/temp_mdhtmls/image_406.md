Here's a script that saves a dictionary in JSON format to a file in Python:
```python
import json

# Create a dictionary
my_dict = {
    "name": "John",
    "age": 30,
    "city": "New York"
}

# Save the dictionary to a file in JSON format
with open("my_file.json", "w") as file:
    json.dump(my_dict, file, indent=4)
```
In this example, the `my_dict` dictionary is saved to a file named `my_file.json` in the current working directory. The `indent=4` argument specifies that the JSON data should be indented by 4 spaces for readability.