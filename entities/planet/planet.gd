@tool

extends Node3D
class_name Planet

@export var rotation_speed := 1.0
@onready var mesh_instance_3d: MeshInstance3D = $"MeshInstance3D"

@export var player: Player

func _process(delta: float) -> void:
	mesh_instance_3d.rotate_y(rotation_speed * delta)
	
	if player:
		look_at(player.global_position)
