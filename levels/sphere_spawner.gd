extends Node
class_name SphereSpawner

const SCENE = preload("res://entities/enemygroup/EnemyGroup.tscn")

@export var player : Player
@export var target : Node
@export var max_units := 50
@export var min_distance := 10.0
@export var max_distance := 100.0

var current_units := 0

func _process(delta: float) -> void:
	if current_units < max_units:
		print('spawning')
		current_units += 1 
		
		var scn := SCENE.instantiate()
		scn.player = player
		scn.position = player.global_position + Vector3(randf_range(-1., 1.), randf_range(-1., 1.), randf_range(-1., 1.)).normalized() * randf_range(min_distance, max_distance)
		scn.tree_exited.connect(func(): current_units -= 1)
		target.add_child(scn)
