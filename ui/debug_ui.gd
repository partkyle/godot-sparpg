extends VBoxContainer

var last_updated := 0

func _ready() -> void:
	update_ui()

func update_ui():
	for item in DebugUi.items:
		add_child(item.root)
