To achieve this, you need to modify your Flask-Sock code to wait for a specific message (in this case, a UUID string) before calling the `update_firmware_full` function.

Here's how you can do it:

```python
from flask_socketio import SocketIO, emit

# Initialize Flask-Sock
socketio = SocketIO()

@socketio.on('connect')
def connect():
    """Handle the client connection."""
    # You can add any initialization code here

@socketio.on('uuid')
def handle_uuid(uuid):
    """Wait for the UUID string from the client."""
    # Check if the received message is a valid UUID
    try:
        from uuid import UUID
        UUID(uuid)
    except ValueError:
        # Handle invalid UUID
        emit('error', 'Invalid UUID')
        return

    # Call the update_firmware_full function with the received UUID
    update_firmware_full(uuid, device_id)

@socketio.route('/reader_flasher')
def updater():
    """Handle the WebSocket connection."""
    # pylint: disable=redefined-outer-name
    return socketio.connect()

# Run the socketio app
if __name__ == '__main__':
    socketio.run(app)
```

**Key Changes:**

1. **`@socketio.on('connect')`**: This decorator handles the client connection. You can add any initialization code here.

2. **`@socketio.on('uuid')`**: This decorator waits for the UUID string from the client. It checks if the received message is a valid UUID.

3. **`update_firmware_full`**: This function is called with the received UUID after validation.

**Client-Side Code:**

To send the UUID string from the client, you can use the following code:

```javascript
// Establish WebSocket connection
const socket = io('/reader_flasher');

// Send the UUID string
socket.emit('uuid', 'your_uuid_string_here');
```

**Example Use Case:**

1. The client establishes a WebSocket connection to the `/reader_flasher` endpoint.
2. The client sends the UUID string to the server.
3. The server validates the received UUID.
4. If the UUID is valid, the server calls the `update_firmware_full` function with the received UUID.

This approach ensures that the `update_firmware_full` function is called only after the server receives a valid UUID string from the client.