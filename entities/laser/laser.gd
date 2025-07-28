extends Node3D
class_name Laser

static var scn := preload("res://entities/laser/laser.tscn")

@export var speed := 50.0
@export var velocity := Vector3.ZERO

var total_dist := 0.0

static func create(container: Node, pos: Vector3, v: Vector3, b: Basis):
	var e = scn.instantiate()
	e.position = pos
	e.basis = b
	e.velocity = v
	container.add_child(e)

func _ready() -> void:
	velocity += -basis.z * speed

func _physics_process(delta: float) -> void:
	var dist := delta * speed
	total_dist += dist
	
	if total_dist > 20.0:
		queue_free()
		return

	global_position += velocity * delta

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.get_parent() is Planet:
		area.get_parent().queue_free()
		queue_free()
