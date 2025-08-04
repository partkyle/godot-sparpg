extends Node3D
class_name Lasers

@onready var camera_3d: Camera = $"../Camera3D"

@onready var right_laser: Node3D = $RightLaser
@onready var left_laser: Node3D = $LeftLaser
@onready var timer: Timer = $Timer

@onready var right_laser_wrapper: Node3D = $RightLaser/LaserWrapper
@onready var left_laser_wrapper: Node3D = $LeftLaser/LaserWrapper


func fire_at(point: Vector3) -> void:
	left_laser_wrapper.show()
	right_laser_wrapper.show()

	timer.start()

	var distance := global_position.distance_to(point)
	left_laser_wrapper.scale.z = distance
	right_laser.look_at(point)
	right_laser_wrapper.scale.z = distance
	left_laser.look_at(point)

func _on_timer_timeout() -> void:
	left_laser_wrapper.hide()
	right_laser_wrapper.hide()

func _process(delta: float) -> void:
	rotate_z(4. * delta)
