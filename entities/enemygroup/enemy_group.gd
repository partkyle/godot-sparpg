extends Node3D
class_name EnemyGroup

@export var player : Player


func _ready() -> void:
	for c in get_children():
		c.player = player

func _process(delta: float) -> void:
	if get_child_count() == 0:
		queue_free()
