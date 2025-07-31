extends Node3D
class_name EnemyGroup

@export var player : Player


func spawn(pl: Player, p: Vector3, spawn_signal: Signal, despawn_signal: Signal):
	position = p
	for c in get_children():
		c.player = pl
		spawn_signal.emit()
		c.tree_exited.connect(despawn_signal.emit)

func _process(_delta: float) -> void:
	if get_child_count() == 0:
		queue_free()
