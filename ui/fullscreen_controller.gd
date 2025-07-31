extends Node

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_0:
			if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
				print('switching to windowed')
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			else:
				print('switching to fullscreen')
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
