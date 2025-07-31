extends Camera3D

@export var speed := 20.0

func _process(delta: float) -> void:
	var direction = Vector3.ZERO
	if Input.is_action_just_pressed("zoom_in"):
		direction = Vector3.FORWARD
	if Input.is_action_just_pressed("zoom_out"):
		direction = Vector3.BACK
	if direction:
		position += direction * speed * delta
