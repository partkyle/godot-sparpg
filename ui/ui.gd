extends CanvasLayer

@export var player: Player

@onready var velocity: Label = %Velocity
@onready var enemy_count: Label = %EnemyCount
@onready var kill_count: Label = %KillCount

var enemies := 0
var kills := 0

func _process(_delta: float) -> void:
	velocity.text = 'Velocity: (%f, %f, %f)' % [player.velocity.x, player.velocity.y, player.velocity.z]
	enemy_count.text = 'Enemies: %d' % [enemies]
	kill_count.text = 'Kills: %d' % [kills]

func _on_sphere_spawner_spawn_enemy() -> void:
	enemies += 1

func _on_sphere_spawner_despawn_enemy() -> void:
	kills += 1
	enemies -= 1
