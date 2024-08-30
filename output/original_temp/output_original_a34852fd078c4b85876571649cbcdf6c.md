**Running Blender in a Docker Container**

To run Blender in a Docker container, follow these steps:

### Prerequisites

- **Docker**: Ensure Docker is installed on your system.
- **Docker Compose**: Install Docker Compose for easier container management.

### Step 1: **Pull the Official Blender Image**

Pull the official Blender image from Docker Hub:

```bash
docker pull blender:3.5
```

### Step 2: **Run the Blender Container**

Run the Blender container:

```bash
docker run -it --name blender-3.5 -v /path/to/your/project:/project blender:3.5
```

- **`-it`**: Allows interactive mode.
- **`--name`**: Names the container for easier management.
- **`-v`**: Mounts your project directory to the container.

### Step 3: **Accessing the Blender Interface**

Once the container is running, you can access the Blender interface:

- **Blender GUI**: Open a new terminal window and use `docker exec` to access the Blender GUI:
  ```bash
  docker exec -it blender-3.5 blender
  ```
- **Blender CLI**: Use the Blender CLI directly:
  ```bash
  docker exec -it blender-3.5 blender -b /project/your_file.blend
  ```

### Example Use Case

**Running a Script**

To run a script in the Blender container:

```bash
docker exec -it blender-3.5 blender -b /project/your_file.blend -s /path/to/your/script.py
```

### Tips

- **Volume Mounting**: Ensure the project directory is properly mounted to the container.
- **Container Management**: Use Docker Compose for easier container management.

### Troubleshooting

- **Container Not Starting**: Check the Docker logs for errors.
- **Blender Not Responding**: Ensure the container is running and the Blender interface is accessible.

By following these steps, you can successfully run Blender in a Docker container.