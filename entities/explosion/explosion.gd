extends Node3D
class_name Explosion

const EXPLOSION = preload("res://entities/explosion/explosion.tscn")

@onready var gpu_particles_3d: GPUParticles3D = $GPUParticles3D

static func create(p: Vector3, parent: Node) -> Explosion:
	var e := EXPLOSION.instantiate()
	e.position = p
	parent.add_child(e)
	return e


func _ready() -> void:
	gpu_particles_3d.finished.connect(queue_free)
	gpu_particles_3d.emitting = true
