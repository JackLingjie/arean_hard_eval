**Adding a New User Functionality**

To achieve the desired functionality, you'll need to:

1. **Handle Button Click**: Attach a click event to the button.
2. **Get User Input**: Retrieve the user name from the input field.
3. **Make API Call**: Use the user name and a predefined user key to make a POST request to the API.

**Updated HTML Code**

```html
<div class="container-fluid px-md-5">
    <div class="row">
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Add last used RFID card as new user</h5>
                <p class="card-text">Card: <strong>{{ latest_key[:8] + "..." + latest_key[-8:]}}</strong> was triggered at: <strong>20:57AM</strong></p>
                <div class="input-group mb-3">
                    <button class="btn btn-primary add-user-btn" type="button"><i class="bi bi-person-add"></i> Add User</button>  
                    <input type="text" class="form-control" id="user_name" placeholder="User Name">
                </div>
            </div>
        </div>
    </div>
    <div class="py-3">
        <table id="userTable" class="table table-striped table-bordered" style="width:100%">
            <thead>
                <tr>
                    <th>User</th>
                    <th>User Key</th>
                    <th>Permissions</th>
                    <th>Operation</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>
```

**JavaScript Code**

```javascript
// Get the button element
const addUserBtn = document.querySelector('.add-user-btn');

// Add event listener to the button
addUserBtn.addEventListener('click', () => {
    // Get the user name from the input field
    const userName = document.getElementById('user_name').value;

    // Predefined user key
    const userKey = 'd2db5ec4-6e7a-11ee-b962-0242ac120002';

    // Make API call
    fetch(`http://localhost:5000/api/users/${userName}/devices/${userKey}`, {
        method: 'POST',
    })
    .then(response => response.json())
    .then(data => console.log(data))
    .catch(error => console.error(error));
});
```

**Explanation**

1. We added an event listener to the button element.
2. When the button is clicked, we retrieve the user name from the input field.
3. We make a POST request to the API using the user name and predefined user key.
4. The API call is made using the `fetch` API.

**Note**: This code assumes you have the `fetch` API available. If not, you can use a library like Axios or jQuery to make the API call.