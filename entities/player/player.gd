extends CharacterBody3D
class_name Player

@onready var ray_cast_3d: RayCast3D = $RayCast3D

func handle_melee():
	if Input.is_action_just_pressed("melee"):
		if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().get_parent() is Planet:
			global_position = lerp(global_position, ray_cast_3d.get_collision_point(), 0.9)

func _physics_process(delta: float) -> void:
	handle_melee()

	if Input.is_action_pressed("shoot"):
		Laser.create(get_tree().root, self.global_position, self.velocity, self.basis)
