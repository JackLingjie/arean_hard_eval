<|User Prompt|>


My situation is this: I’m setting up a server running at home Ubuntu to run an email server and a few other online services. As we all know, for my email to work reliably and not get blocked I need to have an unchanging public IP address. Due to my circumstances I am not able to get a static IP address through my ISP or change ISPs at the moment.

The solution I have found is to buy a 4G SIM card with a static IP (from an ISP that offers that), which I can then use with a USB dongle. However this 4G connection costs me substantially per MB to use.

But. Mail is the only server that needs a static IP address. For everything else using my home network connection and updating my DNS records with DDNS would be fine. I have tested this setup previously for other services and it has worked.

So. I was wondering. Would it in theory be possible to: connect the server to two network interfaces at the same time and route traffic depending on destination port. I.e. all outgoing connections to ports 25, 465, 587, and possibly 993 should be sent through the 4G dongle interface (enx344b50000000) and all other connections sent over eth0. Similarly, the server should listen for incoming connections on the same ports on enx344b50000000 and listen on all other ports (if allowed by ufw) on eth0.

I would then need DNS records from mail.mydomain.tld —> <4g static public IP> and mydomain.tld —> <home public IP> (updated with DDNS, and NAT configured on my home router).

Computers on the internet would then be able to seamlessly connect to these two IP addresses, not “realising” that they are in fact the same machine, as long as requests to mail.mydomain.tld are always on the above mentioned ports.

Question: Is this possible? Could it be a robust solution that works the way I hope? Would someone be able to help me set it up?

I have come across a few different guides in my DuckDuckGo-ing, I understand it has to do with setting a mark in iptables and assigning them to a table using ip route. However I haven't managed to get it to work yet, and many of these guides are for VPNs and they all seem to be slightly different to each other. So I thought I would ask about my own specific use case

<|The Start of Assistant A's Answer|>
Yes, this is possible and can be a robust solution if set up correctly. You can achieve this by using a combination of iptables and iproute2. Here's a step-by-step guide to help you set it up:

1. First, make sure you have `iptables` and `iproute2` installed on your Ubuntu server. You can install them using the following commands:

   ```
   sudo apt-get update
   sudo apt-get install iptables iproute2
   ```

2. Next, create a new routing table for the 4G dongle interface. Open `/etc/iproute2/rt_tables` and add the following line at the end:

   ```
   200 4g_dongle
   ```

3. Configure the routing rules for the new table. Replace `4G_DONGLE_GATEWAY` with the gateway IP address of your 4G dongle, and `4G_DONGLE_IP` with the static IP address assigned to your 4G dongle:

   ```
   sudo ip route add default via 4G_DONGLE_GATEWAY dev enx344b50000000 table 4g_dongle
   sudo ip rule add from 4G_DONGLE_IP table 4g_dongle
   ```

4. Now, set up iptables rules to mark packets based on the destination port. Replace `4G_DONGLE_IP` with the static IP address assigned to your 4G dongle:

   ```
   sudo iptables -t mangle -A OUTPUT -p tcp -m multiport --dports 25,465,587,993 -j MARK --set-mark 0x1
   sudo iptables -t nat -A POSTROUTING -o enx344b50000000 -j SNAT --to-source 4G_DONGLE_IP
   ```

5. Add a rule to use the 4g_dongle routing table for marked packets:

   ```
   sudo ip rule add fwmark 0x1 table 4g_dongle
   ```

6. Save the iptables rules and make them persistent across reboots:

   ```
   sudo iptables-save | sudo tee /etc/iptables/rules.v4
   ```

7. To make the iproute2 rules persistent across reboots, create a new file `/etc/network/if-up.d/4g_dongle_routing` with the following content:

   ```
   #!/bin/sh
   IP=/sbin/ip
   $IP route add default via 4G_DONGLE_GATEWAY dev enx344b50000000 table 4g_dongle
   $IP rule add from 4G_DONGLE_IP table 4g_dongle
   $IP rule add fwmark 0x1 table 4g_dongle
   ```

   Replace `4G_DONGLE_GATEWAY` and `4G_DONGLE_IP` with the appropriate values. Make the script executable:

   ```
   sudo chmod +x /etc/network/if-up.d/4g_dongle_routing
   ```

8. Restart your networking service or reboot your server to apply the changes:

   ```
   sudo systemctl restart networking
   ```

Now, your server should route traffic based on the destination port as you described. Incoming connections on ports 25, 465, 587, and 993 will be directed to the 4G dongle interface, while all other connections will be sent over eth0. Make sure to configure your DNS records and NAT settings on your home router as you mentioned.
<|The End of Assistant A's Answer|>

<|The Start of Assistant B's Answer|>
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
<|The End of Assistant B's Answer|>