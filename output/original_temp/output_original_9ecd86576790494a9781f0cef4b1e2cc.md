To specify the configuration file for your Flask application running in a Docker container, you can use environment variables. Here are a few approaches:

### 1. **Environment Variable**

You can set an environment variable `FLASK_CONFIG_FILE` to the path of your configuration file.

**In your Dockerfile:**

```dockerfile
# Copy the config file into the container
COPY config.json /app/config.json

# Set the environment variable
ENV FLASK_CONFIG_FILE=/app/config.json
```

**In your `docker run` command:**

```bash
docker run -e FLASK_CONFIG_FILE=/app/config.json your-flask-image
```

### 2. **Using a `.env` File**

Another approach is to use a `.env` file to store your environment variables. This is especially useful when you have multiple environment variables.

**In your Dockerfile:**

```dockerfile
# Copy the .env file into the container
COPY .env ./

# Set the environment variable
ENV FLASK_CONFIG_FILE=/app/config.json
```

**In your `.env` file:**

```makefile
FLASK_CONFIG_FILE=/app/config.json
```

**In your `docker run` command:**

```bash
docker run -e FLASK_CONFIG_FILE=/app/config.json your-flask-image
```

### 3. **Using Docker Compose**

If you're using Docker Compose, you can specify environment variables directly in your `docker-compose.yml` file.

**In your `docker-compose.yml` file:**

```yml
version: '3'
services:
  flask-app:
    build: .
    environment:
      - FLASK_CONFIG_FILE=/app/config.json
```

### 4. **Configuring Flask**

In your Flask application, you can then read the configuration file using the environment variable.

**In your Flask application:**

```python
import os

config_file = os.environ.get('FLASK_CONFIG_FILE')
app.config.from_file(config_file, load=json.load)
```

By using environment variables, you can easily switch between different configuration files based on your environment.