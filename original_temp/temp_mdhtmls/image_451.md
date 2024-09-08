To write a first-person controller script in GDScript and apply it to a KinematicBody-node in Godot Engine 3.x, you can follow these steps:

1. Create a new script file and name it "FirstPersonController.gd".
2. In the script, define the following variables:
```gd
export var speed = 10
export var mouse_sensitivity = 0.2
var velocity = Vector3.ZERO
var camera = null
```
3. In the `_ready()` function, assign the camera node to the `camera` variable:
```gd
func _ready():
    camera = get_node("Camera")
```
4. In the `_process()` function, update the player's movement based on the input:
```gd
func _process(delta):
    var input_vector = Vector2()
    input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
    input_vector.y = Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward")
    input_vector = input_vector.normalized()
    
    if input_vector != Vector2.ZERO:
        velocity = transform.basis.x * input_vector.x * speed + transform.basis.z * input_vector.y * speed
        camera.rotation.y += input_vector.x * mouse_sensitivity
        camera.rotation.x = clamp(camera.rotation.x, -90, 90)
```
5. In the `_physics_process()` function, apply the velocity to the player's position and update the camera's position:
```gd
func _physics_process(delta):
    move_and_slide(velocity)
    camera.global_transform.origin = transform.origin + camera.global_transform.basis.z * 2
```
To use this script in Godot Engine 4.x, you can follow these steps:

1. Create a new script file and name it "FirstPersonController.gd".
2. In the script, define the following variables:
```gd
export var speed = 10
export var mouse_sensitivity = 0.2
var velocity = Vector3.ZERO
var camera = null
```
3. In the `_ready()` function, assign the camera node to the `camera` variable:
```gd
func _ready():
    camera = get_node("Camera")
```
4. In the `_process()` function, update the player's movement based on the input:
```gd
func _process(delta):
    var input_vector = Vector2()
    input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
    input_vector.y = Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward")
    input_vector = input_vector.normalized()
    
    if input_vector != Vector2.ZERO:
        velocity = transform.basis.x * input_vector.x * speed + transform.basis.z * input_vector.y * speed
        camera.rotation.y += input_vector.x * mouse_sensitivity
        camera.rotation.x = clamp(camera.rotation.x, -90, 90)
```
5. In the `_physics_process()` function, apply the velocity to the player's position and update the camera's position:
```gd
func _physics_process(delta):
    move_and_slide(velocity)
    camera.global_transform.origin = transform.origin + camera.global_transform.basis.z * 2
```
Note that in Godot Engine 4.x, the KinematicBody2D-node has been replaced by the KinematicBody-node, which is used for 3D physics simulation. Therefore, you can apply this script to a KinematicBody-node in Godot Engine 4.x without any changes.