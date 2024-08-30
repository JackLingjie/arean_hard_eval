**Efficient Bash Script for VPN User Information**

The following script retrieves VPN user information using SNMP and presents it in a readable format.

### Script

```bash
#!/bin/bash

# Retrieve username base using SNMP
username_base=($(snmpwalk -v 2c -c "$comm" "$host" 
  SNMPv2-SMI::enterprises.9.9.392.1.3.21.1.20 | 
  grep STRING | 
  awk -F"SNMPv2-SMI::enterprises.9.9.392.1.3.21.1.20." '{print $2}' | 
  awk -F" " '{print $1}' | 
  sed 's#[^.]*$##'))

# Count the number of VPN users connected
count_username=${#username_base[@]}
echo "There are $count_username VPN users connected."

# Iterate over each username
for ((i = 0; i < count_username; i++)); do
  # Extract the username OID
  username_oid=${username_base[$i]:0:-1}

  # Convert the OID to a human-readable format
  username_dec=$(echo "$username_oid" | 
    sed 's/^[0-9]*.//' | 
    sed 's/\./ /g')
  for x in $username_dec; do
    printf "\\$(printf %o "$x")"
  done

  # Retrieve VPN agent, external IP, and internal IP using SNMP
  vpn_agent=$(snmpwalk -v 2c -c "$comm" "$host" 
    SNMPv2-SMI::enterprises.9.9.392.1.3.21.1.18.${username_oid} | 
    awk -F"STRING: " '{print $2}' | head -1)
  vpn_extip=$(snmpwalk -v 2c -c "$comm" "$host" 
    SNMPv2-SMI::enterprises.9.9.392.1.3.21.1.10.${username_oid} | 
    awk -F"STRING: " '{print $2}' | head -1)
  vpn_intip=$(snmpwalk -v 2c -c "$comm" "$host" 
    SNMPv2-SMI::enterprises.9.9.392.1.3.21.1.8.${username_oid} | 
    awk -F"STRING: " '{print $2}' | tail -1)

  # Print the VPN user information
  echo ", ${vpn_extip}, ${vpn_agent}, ${vpn_intip}"
done
```

### Explanation

- **SNMP Walk**: The script uses `snmpwalk` to retrieve information from the specified OID.
- **Username Base**: It extracts the username base from the SNMP response.
- **Counting Users**: The number of VPN users connected is determined by the length of the `username_base` array.
- **Iterating Over Users**: The script iterates over each username in the `username_base` array.
- **Username OID**: It extracts the username OID from the array.
- **Decoding OID**: The OID is decoded to a human-readable format.
- **Retrieving VPN Information**: The script uses `snmpwalk` to retrieve the VPN agent, external IP, and internal IP for each user.
- **Printing Information**: The VPN user information is printed in a readable format.

### Example Use Case

To use this script, replace the placeholders (`$comm` and `$host`) with your actual community string and host IP address. Then, execute the script to retrieve and display the VPN user information.