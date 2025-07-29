extends Node3D
class_name EnemyGroup

@export var player : Player

func _ready() -> void:
	for c in get_children():
		c.player = player
