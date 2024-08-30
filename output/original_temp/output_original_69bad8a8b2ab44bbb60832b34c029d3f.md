**Undoing a Docker Build**

To undo a Docker build, you can use the following steps:

### Step 1: **List Running Containers**

First, list all running containers to identify any that might have been created during the build process.

```bash
docker ps -a
```

### Step 2: **Stop and Remove Containers**

Stop and remove any containers created during the build. This will help you regain your original state.

```bash
docker stop $(docker ps -aq)  # Stop all containers
docker rm $(docker ps -aq)    # Remove all containers
```

### Step 3: **Remove Unnecessary Images**

If the build created any unnecessary images, remove them.

```bash
docker image ls -a  # List all images
docker image rm $(docker image ls -aq)  # Remove all images
```

### Step 4: **Verify Your State**

After completing these steps, verify that your system is back to its original state.

```bash
docker ps -a  # List all containers
docker image ls -a  # List all images
```

By following these steps, you can undo a Docker build and return to your original state.

**Example Use Case**

Suppose you ran `docker build .` and created a container. To undo this:

1. List running containers: `docker ps -a`
2. Stop and remove containers: `docker stop $(docker ps -aq)` and `docker rm $(docker ps -aq)`
3. Remove unnecessary images: `docker image rm $(docker image ls -aq)`
4. Verify your state: `docker ps -a` and `docker image ls -a`

This process ensures you regain your original state after undoing a Docker build.