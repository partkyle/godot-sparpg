extends CharacterBody3D
class_name Player

const EPSILON := 0.005

@onready var ray_cast_3d: RayCast3D = $RayCast3D

@export var acceleration_intensity := 5.0
@export var deceleration_intensity := 5.0
@export var booster_speed := 1.0
@export var rotation_speed := Vector2(0.02, 0.02)
@export var stick_rotation_speed := rotation_speed * 2.0


func handle_melee():
	if Input.is_action_just_pressed("melee"):
		if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().get_parent() is Planet:
			global_position = lerp(global_position, ray_cast_3d.get_collision_point(), 0.9)

func _physics_process(delta: float) -> void:
	handle_melee()

	if Input.is_action_pressed("shoot"):
		Laser.create(get_tree().root, self.global_position, self.velocity, self.basis)
	
	var direction = Input.get_vector("move_left", "move_right", "move_down", "move_up")

	if direction.length_squared() > 0:
		global_position += (transform.basis * Vector3(direction.x, direction.y, 0.)) * booster_speed * delta

	velocity += (transform.basis * Vector3.FORWARD) * Input.get_action_strength("accelerate") * acceleration_intensity * delta

	var decelerate := Input.get_action_strength("decelerate")
	if decelerate > 0.0:
		velocity = lerp(velocity, Vector3.ZERO, deceleration_intensity * delta)
	
	if velocity.length_squared() < EPSILON:
		velocity = Vector3.ZERO

	if velocity.length_squared() > 0:
		global_position += velocity * delta
	
	handle_joystick_movement()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and MouseHandler.is_mouse_captured():
		# Get relative mouse movement
		var mouse_delta_x = event.relative.x
		var mouse_delta_y = event.relative.y

		# Calculate rotation angles
		var d_pitch = -mouse_delta_y * rotation_speed.y # Negative for intuitive Y-axis rotation (pitch)
		var d_yaw = -mouse_delta_x * rotation_speed.x # Negative for intuitive X-axis rotation (yaw)
		
		handle_rotation(d_pitch, d_yaw)

func handle_rotation(d_pitch : float, d_yaw : float) -> void:
	# update y rotation sign by using the dot product to tell if the object is upside down
	d_yaw *= Vector3.UP.dot(transform.basis.y)

	# Apply rotation to the basis
	# Rotate around the object's local X-axis (pitch)
	# Note: We rotate around the local axes of the object.
	# basis.x is the local right vector, basis.y is the local up vector, basis.z is the local forward vector.
	transform.basis = transform.basis.rotated(transform.basis.x, d_pitch)

	# Rotate around the global Y-axis (yaw)
	# For a "turntable" like rotation, you often want to rotate around the global Y-axis.
	# If you want to rotate around the *object's local Y-axis*, change Vector3.UP to transform.basis.y
	transform.basis = transform.basis.rotated(Vector3.UP, d_yaw)

func handle_joystick_movement():
	var axis_rot := Input.get_vector("look_left", "look_right", "look_up", "look_down") * stick_rotation_speed
	
	if axis_rot.length_squared() > 0:
		handle_rotation(axis_rot.y, axis_rot.x)
	
