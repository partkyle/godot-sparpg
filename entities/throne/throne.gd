extends Node3D
class_name Throne

@onready var rings : Array[Node3D] = [
	$Ring1,
	$Ring2,
	$Ring3,
	$Ring4,
	$Ring5,
	$Ring6,
]

func _process(delta: float):
	var i = 1
	for r in rings:
		i += 1
		r.rotate_x(i * delta)
