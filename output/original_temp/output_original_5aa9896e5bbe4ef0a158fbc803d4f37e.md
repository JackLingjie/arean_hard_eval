**Matrix Bot in Python**

This example demonstrates a basic Matrix bot written in Python. The bot responds to mentions by echoing the message.

### Prerequisites

- **Python 3.8+**: Ensure you have Python installed on your system.
- **`matrix-python-sdk`**: Install the Matrix SDK using pip:

  ```bash
  pip install matrix-python-sdk
  ```

### Code

```python
import logging
from matrix_client.client import MatrixClient

# Set up logging
logging.basicConfig(level=logging.INFO)

# Matrix bot configuration
MATRIX_HOMESERVER = "https://matrix.org"
MATRIX_ROOM_ID = "!your-room-id:matrix.org"
MATRIX_ACCESS_TOKEN = "your-access-token"

# Create a Matrix client
client = MatrixClient(MATRIX_HOMESERVER)

# Login to the Matrix server
client.login_with_token(MATRIX_ACCESS_TOKEN)

# Get the room
room = client.join_room(MATRIX_ROOM_ID)

# Define a function to handle incoming messages
def handle_message(event):
    """Handle incoming messages."""
    # Check if the message is a mention
    if event["content"].startswith("@"):
        # Extract the mention
        mention = event["content"].split(" ", 1)[0]
        
        # Echo the mention back to the room
        client.room_send(
            room.room_id,
            "m.room.message",
            {"msgtype": "m.text", "body": f"Hey {mention}!"},
        )

# Start listening for messages
client.add_event_callback(handle_message, room.room_id)

# Keep the bot running
while True:
    client.sync_forever(timeout=60)
```

### Explanation

1. **Import Libraries**: The code starts by importing the necessary libraries.

2. **Set Up Logging**: Basic logging is set up to display information messages.

3. **Matrix Bot Configuration**: The bot's configuration is defined, including the Matrix homeserver, room ID, and access token.

4. **Create a Matrix Client**: A Matrix client is created using the `MatrixClient` class.

5. **Login to the Matrix Server**: The client logs in to the Matrix server using the provided access token.

6. **Get the Room**: The bot joins the specified room.

7. **Handle Incoming Messages**: A function `handle_message` is defined to handle incoming messages. It checks if the message is a mention and echoes it back to the room.

8. **Start Listening for Messages**: The bot starts listening for messages by adding an event callback.

9. **Keep the Bot Running**: The bot runs indefinitely, syncing with the Matrix server every 60 seconds.

### Example Use Case

- **Mention the Bot**: To test the bot, mention it in a message within the specified room. The bot will echo the mention back to the room.

### Note

- Replace `"https://matrix.org"`, `!your-room-id:matrix.org`, and `"your-access-token"` with your actual Matrix server, room ID, and access token.

This example provides a basic Matrix bot that responds to mentions. You can extend this code to create more complex bots that perform various tasks.