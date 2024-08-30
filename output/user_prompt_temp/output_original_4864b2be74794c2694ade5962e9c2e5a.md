<|User Prompt|>
I need bash function 
function create_config_file() {
 local device_id="$1"

 echo "[STATUS:Creating config file]"
 // Here I need logic
 echo "[STATUS:CONFIG FILE CREATED]"
}
In logic i need to create json file config.json with such content:
{
  "SSID":"YOUR_WIFI_SSID", << Here I need to place my wifi SSID of my machine(LINUX)
  "PSK":"YOUR_PASSWORD", << Here I need to place my wifi password of currently connected wifi
  "HOSTNAME":"YOUR_READER_HOSTNAME", << Left as is
  "SERVER":"192.168.0.123:123", << Got from argument
  "DEVICE_ID":"YOUR DEVICE_ID" << Got from argument
}

<|The Start of Assistant A's Answer|>
Here's the updated bash function that creates a config.json file with the required content:

```bash
function create_config_file() {
  local device_id="$1"
  local server="$2"

  echo "[STATUS:Creating config file]"

  # Get WiFi SSID and password
  local wifi_ssid=$(iwgetid -r)
  local wifi_password=$(sudo grep -r '^psk=' /etc/NetworkManager/system-connections/ | awk -F 'psk=' '{print $2}')

  # Create config.json file
  cat > config.json << EOF
{
  "SSID":"$wifi_ssid",
  "PSK":"$wifi_password",
  "HOSTNAME":"YOUR_READER_HOSTNAME",
  "SERVER":"$server",
  "DEVICE_ID":"$device_id"
}
EOF

  echo "[STATUS:CONFIG FILE CREATED]"
}
```

To use this function, you need to pass two arguments: device_id and server. For example:

```bash
create_config_file "YOUR_DEVICE_ID" "192.168.0.123:123"
```

Please note that this function requires root privileges to read the WiFi password from the NetworkManager configuration files. You may need to run the script with `sudo` or as a root user.
<|The End of Assistant A's Answer|>

<|The Start of Assistant B's Answer|>
Here is the Bash function `create_config_file` that meets your requirements:

```bash
function create_config_file() {
  local device_id="$1"
  local server_ip="$2"

  echo "[STATUS:Creating config file]"

  # Get the current WiFi SSID and password
  local wifi_ssid=$(iwgetid -r | cut -d ':' -f 2-)
  local wifi_password=$(iwgetid -r | cut -d ':' -f 3- | cut -d '@' -f 1)

  # Create the JSON content
  local json_content='{
    "SSID": "'${wifi_ssid}'",
    "PSK": "'${wifi_password}'",
    "HOSTNAME": "YOUR_READER_HOSTNAME",
    "SERVER": "'${server_ip}'",
    "DEVICE_ID": "'${device_id}'"
  }'

  # Create the config.json file
  echo "$json_content" > config.json

  echo "[STATUS:CONFIG FILE CREATED]"
}
```

### Explanation:

- **Function Definition**: The function `create_config_file` takes two arguments: `device_id` and `server_ip`.

- **Getting WiFi Details**: It uses `iwgetid` to retrieve the current WiFi SSID and password. The `cut` command is used to extract the relevant information.

- **Creating JSON Content**: The function creates a JSON string with the required details. The WiFi SSID and password are inserted into the string.

- **Creating the Config File**: The JSON content is written to a file named `config.json`.

- **Status Messages**: The function prints status messages to indicate the start and completion of the process.

### Example Usage:

```bash
create_config_file "YOUR_DEVICE_ID" "192.168.0.123:123"
```

Replace `"YOUR_DEVICE_ID"` and `"192.168.0.123:123"` with your actual device ID and server IP address.
<|The End of Assistant B's Answer|>