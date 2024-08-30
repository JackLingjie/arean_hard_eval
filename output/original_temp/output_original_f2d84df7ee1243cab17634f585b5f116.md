**Drawing a Cube in SketchUp using Ruby API**

To draw a cube in SketchUp using the Ruby API, follow these steps:

### Step 1: **Open SketchUp and Access the Ruby Console**

- Open SketchUp.
- Go to **Window** > **Ruby Console**.

### Step 2: **Write and Execute the Ruby Code**

- In the Ruby Console, paste the following code:

```ruby
# Define the size of the cube
cube_size = 10

# Create a new SketchUp model
model = Sketchup.active_model

# Get the active layer
layer = model.active_layer

# Create a new group to hold the cube
group = model.entities.add_group

# Define the points of the cube
points = [
  [0, 0, 0], # Point 1
  [cube_size, 0, 0], # Point 2
  [cube_size, cube_size, 0], # Point 3
  [0, cube_size, 0], # Point 4
  [0, 0, cube_size], # Point 5
  [cube_size, 0, cube_size], # Point 6
  [cube_size, cube_size, cube_size], # Point 7
  [0, cube_size, cube_size] # Point 8
]

# Create faces for the cube
faces = [
  ["Face", [points[0], points[1], points[2], points[3]]],
  ["Face", [points[4], points[5], points[6], points[7]]],
  ["Face", [points[0], points[1], points[5], points[4]]],
  ["Face", [points[3], points[2], points[6], points[7]]],
  ["Face", [points[0], points[3], points[7], points[4]]],
  ["Face", [points[1], points[2], points[6], points[5]]]
]

# Add the faces to the group
group.entities.each do |entity|
  entity.erase!
end

faces.each do |face|
  group.entities.add_face(face[1])
end

# Save the model
model.save
```

### Step 3: **Run the Code**

- Press the **Run** button in the Ruby Console to execute the code.

This code will create a new cube in your SketchUp model. You can adjust the `cube_size` variable to change the size of the cube.

**Example Use Cases:**

- **Custom Cube Size**: Modify the `cube_size` variable to create cubes of different sizes.
- **Custom Cube Position**: Adjust the points array to position the cube at a specific location in your SketchUp model.

**Tips and Variations:**

- **Color and Material**: Use SketchUp's API to change the color and material of the cube.
- **Complex Shapes**: Experiment with creating more complex shapes by modifying the points and faces arrays.