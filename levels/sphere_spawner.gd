extends Node
class_name SphereSpawner

const SCENE = preload("res://entities/enemygroup/EnemyGroup.tscn")

signal spawn_enemy()
signal despawn_enemy()

const min_distance := 10.0
const max_distance := 100.0

@export var player : Player
@export var target : Node
@export var max_units := 200

var current_units := 0
var kills := 0

func _ready() -> void:
	DebugUi.add_debug_ui(&'sphere_spawner.current_units', func(): return str(current_units))
	DebugUi.add_debug_ui(&'sphere_spawner.kills', func(): return str(kills))

func _process(_delta: float) -> void:
	if current_units < max_units:
		var scn := SCENE.instantiate()
		scn.spawn(
			player,
			spawn_location(player),
			spawn_enemy,
			despawn_enemy,
		)

		target.add_child(scn)

func _on_spawn_enemy() -> void:
	current_units += 1

func _on_despawn_enemy() -> void:
	kills += 1
	current_units -= 1

static func spawn_location(p: Player) -> Vector3:
	return p.global_position + Vector3(randf_range(-1., 1.), randf_range(-1., 1.), randf_range(-1., 1.)).normalized() * randf_range(min_distance, max_distance)
