extends CanvasLayer

@export var player: Player

@onready var velocity: Label = $Control/VBoxContainer/Velocity

func _process(_delta: float) -> void:
	velocity.text = 'Velocity: (%f, %f, %f)' % [player.velocity.x, player.velocity.y, player.velocity.z]
