class_name DebugUISingleton
extends Control


class DebugUIItem:
	var root: Control
	var value_label: Label
	var get_value: Callable
	
	func _init(_root: Control, _value_label: Label, _get_value: Callable) -> void:
		self.root = _root
		self.value_label = _value_label
		self.get_value = _get_value

var items : Array[DebugUIItem] = []
var last_update : int

func add_debug_ui(name: StringName, get_value: Callable) -> void:
	var container = HBoxContainer.new()
   
	var label = Label.new()
	label.text = name
  
	container.add_child(label)

	var spacer = Control.new()
	spacer.grow_horizontal = true

	container.add_child(spacer)

	var value_label = Label.new()
	value_label.text = get_value.call()
	
	container.add_child(value_label)

	items.append(DebugUIItem.new(container, value_label, get_value))
	
	last_update = Time.get_ticks_usec()

func _process(_delta: float) -> void:
	for item in items:
		item.value_label.text = item.get_value.call()
