extends Node
class_name Controls

@export var EPSILON := 0.005
@export var acceleration_intensity := 5.0
@export var deceleration_intensity := 5.0
@export var booster_speed := 1.0
@export var rotation_speed := Vector2(0.5, 0.5)
@export var stick_rotation_speed := rotation_speed * 2.0
@export var blink_distance := 10.0

var target : Node3D

var mouse_rotation := Vector2.ZERO

func _ready() -> void:
	target = get_parent()

func handle_blink(direction: Vector3):
	if not direction:
		direction = target.basis * Vector3.FORWARD

	if Input.is_action_just_pressed("blink") and direction:
		target.global_position += direction * blink_distance

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_down", "move_up")

	if direction.length_squared() > 0:
		direction = direction.normalized()
		target.global_position += (target.transform.basis * Vector3(direction.x, direction.y, 0.)) * booster_speed * delta

	handle_blink(Vector3(direction.x, direction.y, 0.))

	target.velocity += (target.transform.basis * Vector3.FORWARD) * Input.get_action_strength("accelerate") * acceleration_intensity * delta

	var decelerate := Input.get_action_strength("decelerate")
	if decelerate > 0.0:
		target.velocity = lerp(target.velocity, Vector3.ZERO, deceleration_intensity * delta)
	
	if target.velocity.length_squared() < EPSILON:
		target.velocity = Vector3.ZERO

	if target.velocity.length_squared() > 0:
		target.global_position += target.velocity * delta
	
	handle_joystick_movement()
	
	if mouse_rotation and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		var rotation = -mouse_rotation * rotation_speed * delta
		handle_rotation(rotation.y, rotation.x)
		mouse_rotation = Vector2.ZERO

func handle_rotation(d_pitch : float, d_yaw : float) -> void:
	# update y rotation sign by using the dot product to tell if the object is upside down
	d_yaw *= Vector3.UP.dot(target.transform.basis.y)

	# Apply rotation to the basis
	# Rotate around the object's local X-axis (pitch)
	# Note: We rotate around the local axes of the object.
	# basis.x is the local right vector, basis.y is the local up vector, basis.z is the local forward vector.
	var new_basis = target.transform.basis.rotated(target.transform.basis.x, d_pitch)

	# Rotate around the global Y-axis (yaw)
	# For a "turntable" like rotation, you often want to rotate around the global Y-axis.
	# If you want to rotate around the *object's local Y-axis*, change Vector3.UP to target.transform.basis.y
	new_basis = new_basis.rotated(Vector3.UP, d_yaw)

	target.transform.basis = new_basis.orthonormalized()

func handle_joystick_movement():
	var axis_rot := Input.get_vector("look_left", "look_right", "look_up", "look_down") * stick_rotation_speed
	
	if axis_rot.length_squared() > 0:
		handle_rotation(axis_rot.y, axis_rot.x)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_rotation = event.relative
