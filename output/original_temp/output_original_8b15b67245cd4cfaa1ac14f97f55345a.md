**JavaScript Code Explanation**

### Selecting HTML Elements

The code starts by selecting various HTML elements using `document.querySelectorAll`:

- **Steps**: An array of elements with the class `step` within a `form` element.
- **Next Button**: An array of elements with the class `next-btn` within a `form` element.
- **Previous Button**: An array of elements with the class `previous-btn` within a `form` element.
- **Form**: The first `form` element found in the document.

### Event Listeners

#### Next Button Click

- **Event Listener**: Adds an event listener to each button with the class `next-btn`.
- **Action**: When clicked, calls the `changeStep` function with the argument `"next"`.

#### Previous Button Click

- **Event Listener**: Adds an event listener to each button with the class `previous-btn`.
- **Action**: When clicked, calls the `changeStep` function with the argument `"prev"`.

#### Form Submission

- **Event Listener**: Adds an event listener to the form element.
- **Action**: When the form is submitted:
  - **Prevents Default Form Submission**: Prevents the form from submitting normally.
  - **Collects Form Data**: Iterates over all `input` elements within the form, collecting their `name` and `value`.
  - **Logs Form Data**: Logs the collected form data to the console.
  - **Resets the Form**: Resets the form to its initial state.

### `changeStep` Function

- **Purpose**: Changes the active step based on the direction (`"next"` or `"prev"`).
- **Steps**:
  1. **Find the Active Step**: Finds the currently active step by its class `active`.
  2. **Remove Active Class**: Removes the `active` class from the current active step.
  3. **Determine New Index**:
    - If moving to the next step, increments the index.
    - If moving to the previous step, decrements the index.
  4. **Add Active Class**: Adds the `active` class to the new step.

This JavaScript code is designed to manage a form with multiple steps. It allows users to navigate through these steps using next and previous buttons. When the form is submitted, it collects the form data and logs it to the console before resetting the form.