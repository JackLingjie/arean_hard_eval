To add another IP address on a specific VLAN to a network interface in Linux, you can use the following steps:

### 1. **Check the Current Configuration**

First, check the current configuration of your network interface. You can do this by running:

```bash
ip addr show
```

This command will display all the IP addresses assigned to your network interfaces.

### 2. **Add a New IP Address**

To add a new IP address to a specific VLAN on a network interface, use the following command:

```bash
ip addr add <IP_ADDRESS>/<PREFIX_LENGTH> dev <INTERFACE_NAME> brd + vlan <VLAN_ID>
```

- **`<IP_ADDRESS>`**: The IP address you want to add.
- **`<PREFIX_LENGTH>`**: The prefix length of the IP address (e.g., 24 for a /24 subnet).
- **`<INTERFACE_NAME>`**: The name of the network interface (e.g., `eth0` or `eno1`).
- **`<VLAN_ID>`**: The ID of the VLAN you want to add the IP address to.

### 3. **Example**

Here's an example:

```bash
ip addr add 192.168.1.100/24 dev eth0 brd + vlan 100
```

This command adds the IP address `192.168.1.100` with a prefix length of `/24` to the `eth0` interface on VLAN 100.

### 4. **Verify the Configuration**

After adding the new IP address, verify the configuration by running:

```bash
ip addr show
```

This command will display the updated configuration.

### 5. **Save the Configuration**

To save the configuration, use the following command:

```bash
ip -f json flush
```

This command saves the current network configuration.

### 6. **Reboot or Reload the Network**

Finally, reboot your system or reload the network configuration to apply the changes:

```bash
reboot
```

or

```bash
systemctl reload networking
```

This ensures that the new IP address is applied to the network interface.

By following these steps, you can add another IP address on a specific VLAN to a network interface in Linux.