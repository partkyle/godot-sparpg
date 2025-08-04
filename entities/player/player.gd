extends CharacterBody3D
class_name Player

@onready var ray_cast_3d: RayCast3D = $Camera3D/RayCast3D
@onready var lasers: Lasers = $Lasers

func _ready():
	DebugUi.add_debug_ui(&'player.basis.x', func(): return "(%f,%f,%f)" % [basis.z.x, basis.z.y, basis.z.z])

func handle_melee():
	if Input.is_action_just_pressed("melee"):
		if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().get_parent() is Planet:
			global_position = lerp(global_position, ray_cast_3d.get_collision_point(), 0.9)

func _physics_process(_delta: float) -> void:
	handle_melee()

	if Input.is_action_pressed("shoot"):
		var point := global_position + basis * ray_cast_3d.target_position

		if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider():
			point = ray_cast_3d.get_collision_point()
			ray_cast_3d.get_collider().get_parent().queue_free()
			Explosion.create(point, get_tree().root)

		lasers.fire_at(point)
