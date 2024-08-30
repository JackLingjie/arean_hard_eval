**Apache Reverse Proxy Configuration**

To set up a reverse proxy in Apache that points to a WordPress Docker container running on port `8001` on the same machine, follow these steps:

### Step 1: **Apache Configuration**

1. **Create a new file** named `wordpress.conf` in the Apache configuration directory (`/etc/apache2/conf.d/` on Ubuntu-based systems or `C:\Apache24\conf\extra\` on Windows).

2. **Add the following configuration** to the `wordpress.conf` file:

```apache
<VirtualHost *:80>
    ServerName example.com # Replace with your domain name

    # Proxy settings
    ProxyPreserveHost On
    ProxyPass / http://localhost:8001/
    ProxyPassReverse / http://localhost:8001/

    # Log settings
    ErrorLog ${APACHE_LOG_DIR}/wordpress_error.log
    CustomLog ${APACHE_LOG_DIR}/wordpress_access.log combined
</VirtualHost>
```

- **`ServerName`**: Replace `example.com` with your actual domain name.
- **`ProxyPreserveHost`**: Ensures the original host header is passed to the backend.
- **`ProxyPass`**: Maps the Apache server URL to the Docker container URL.
- **`ProxyPassReverse`**: Ensures internal redirects work properly.

### Step 2: **Enable the Configuration**

1. **Restart Apache** to apply the changes:

```bash
sudo service apache2 restart # On Ubuntu-based systems
net stop apache2.4 # On Windows
net start apache2.4 # On Windows
```

### Step 3: **Verify the Setup**

1. **Access your WordPress site** through the domain name you specified in the `ServerName` directive.

This setup should allow you to access your WordPress site through the domain name, with Apache acting as a reverse proxy to the Docker container.

**Additional Tips**

- Ensure the Docker container is running and accessible on port `8001`.
- Update the `ServerName` directive to match your actual domain name.
- Adjust the log settings as needed for your environment.