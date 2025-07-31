extends Node3D
class_name Planet

@export var spd := 1.0

@export var rotation_speed := 1.0
@onready var mesh_instance_3d: MeshInstance3D = $"MeshInstance3D"

@export var player: Player

var t : SceneTreeTimer

var velocity : Vector3

func _ready() -> void:
	t = get_tree().create_timer(1.0)
	t.timeout.connect(reset_speed)

func reset_speed() -> void:
	velocity = Vector3.ZERO

func _process(delta: float) -> void:
	mesh_instance_3d.rotate_y(rotation_speed * delta)
	
	if player:
		look_at(player.global_position)
		
		if global_position.distance_squared_to(player.global_position) > pow(200, 2):
			relocate()

func _physics_process(delta: float) -> void:
	if player:
		var direction = player.global_position - global_position
		if direction.length_squared() > 0:
			velocity += direction.normalized() * spd * delta
	
	if velocity:
		global_position += velocity * delta

func relocate():
	print('relocating')	
	global_position = SphereSpawner.spawn_location(player)
	velocity = Vector3.ZERO
