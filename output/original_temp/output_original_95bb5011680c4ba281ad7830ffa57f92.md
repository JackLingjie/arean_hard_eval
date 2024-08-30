**Setting Up SSH Key-Based Authentication**

To set up SSH key-based authentication, follow these steps:

### **Step 1: Generate SSH Keys**

1. **Open a terminal** on your local machine.
2. **Generate a new SSH key pair** using the following command:
   ```bash
   ssh-keygen -t ed25519
   ```
   This will create a new pair of keys in the `~/.ssh` directory.

### **Step 2: Copy the Public Key**

1. **Copy the public key** to the server using the following command:
   ```bash
   ssh-copy-id user@server_ip
   ```
   Replace `user` with your username on the server and `server_ip` with the server's IP address.

### **Step 3: Configure SSH**

1. **Edit the SSH configuration file** on your local machine:
   ```bash
   nano ~/.ssh/config
   ```
2. **Add the following lines** to the end of the file:
   ```bash
   Host server_ip
     User user
     IdentityFile ~/.ssh/your_key_file
   ```
   Replace `server_ip` with the server's IP address, `user` with your username on the server, and `your_key_file` with the name of your private key file.

### **Step 4: Test SSH**

1. **Try to SSH into the server** without a password:
   ```bash
   ssh server_ip
   ```
   If everything is set up correctly, you should be logged in without being prompted for a password.

### **Example Use Case**

Here's an example of how to set up SSH key-based authentication:

**Local Machine**

* Generate SSH keys: `ssh-keygen -t ed25519`
* Copy public key: `ssh-copy-id user@server_ip`
* Configure SSH: `nano ~/.ssh/config`

**Server**

* Ensure the `~/.ssh/authorized_keys` file contains the public key.

### **Security Considerations**

* **Keep your private key secure**: Never share your private key with anyone.
* **Use a secure key type**: Use a key type like `ed25519` for better security.
* **Limit access**: Restrict access to your server by only allowing specific IP addresses or users.

By following these steps, you can set up SSH key-based authentication and securely access your server without entering a password.