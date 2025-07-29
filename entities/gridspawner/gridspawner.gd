extends Node
class_name GridSpawner

const ENEMY_GROUP = preload("res://entities/enemygroup/EnemyGroup.tscn")
const CHUNK_SIZE = Vector3i(25, 25, 25)
const r = 1

@export var player : Player
@export var target : Node

var enemy_groups = {}

func _process(delta: float) -> void:
	assert(player, 'need to set player')

	var chunk = Vector3i(player.global_position) / CHUNK_SIZE
	for x in range(-r, r+1):
		for y in range(-r, r+1):
			for z in range(-r, r+1):
				var slot = chunk + Vector3i(x,y,z)
				if not enemy_groups.has(slot):
					var group = ENEMY_GROUP.instantiate()
					enemy_groups[slot] = true
					group.player = player
					group.position = Vector3(slot * CHUNK_SIZE)
					target.add_child(group)
