You want to set up a server with two network interfaces:

1. **4G Dongle (enx344b50000000)**: For outgoing connections to specific ports (25, 465, 587, and 993) and incoming connections on the same ports.
2. **Home Network (eth0)**: For all other outgoing connections and incoming connections on all other ports.

This setup will allow you to:

- Use a static IP from a 4G SIM card for your email server.
- Utilize your home network for other online services.
- Update your DNS records accordingly.

### Step 1: **Configure the Network Interfaces**

First, ensure both network interfaces are configured correctly. You can do this by editing the `/etc/network/interfaces` file.

```bash
sudo nano /etc/network/interfaces
```

Add the following lines:

```bash
# enx344b50000000 (4G Dongle)
auto enx344b50000000
iface enx344b50000000 inet static
    address <4G Static IP>
    netmask <4G Netmask>
    gateway <4G Gateway>

# eth0 (Home Network)
auto eth0
iface eth0 inet dhcp
```

Replace `<4G Static IP>`, `<4G Netmask>`, and `<4G Gateway>` with the actual values provided by your ISP.

### Step 2: **Configure IP Routing**

Next, configure IP routing to direct traffic based on destination ports.

```bash
sudo nano /etc/iproute2/rt_tables
```

Add the following lines:

```bash
# Define a new routing table for the 4G interface
100 enx344b50000000
```

Then, create a new routing table:

```bash
sudo ip route add default via <4G Gateway> table enx344b50000000
```

Replace `<4G Gateway>` with the actual gateway provided by your ISP.

### Step 3: **Configure IP Rules**

Now, configure IP rules to direct traffic based on destination ports.

```bash
sudo nano /etc/iproute2/rt_tables
```

Add the following lines:

```bash
# Define a new routing table for the 4G interface
100 enx344b50000000
```

Then, create a new routing table:

```bash
sudo ip rule add fwmark 1 table enx344b50000000
```

### Step 4: **Configure IP Marking**

Finally, configure IP marking to mark outgoing packets based on destination ports.

```bash
sudo nano /etc/iproute2/rt_tables
```

Add the following lines:

```bash
# Define a new routing table for the 4G interface
100 enx344b50000000
```

Then, create a new routing table:

```bash
sudo ip route add default via <4G Gateway> table enx344b50000000
```

Replace `<4G Gateway>` with the actual gateway provided by your ISP.

### Step 5: **Configure UFW**

Configure UFW to allow incoming connections on the specified ports.

```bash
sudo ufw allow in on enx344b50000000 to any port 25
sudo ufw allow in on enx344b50000000 to any port 465
sudo ufw allow in on enx344b50000000 to any port 587
sudo ufw allow in on enx344b50000000 to any port 993
```

### Step 6: **Update DNS Records**

Update your DNS records to point `mail.mydomain.tld` to the 4G static IP and `mydomain.tld` to your home public IP.

### Step 7: **Test Your Setup**

Test your setup by sending emails and accessing your other online services.

This setup should allow you to use a static IP from a 4G SIM card for your email server while utilizing your home network for other online services.