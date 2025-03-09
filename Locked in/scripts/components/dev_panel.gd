extends Node

#region |Draggable|
@onready var panel := $CanvasLayer/Panel

func drag_ui():
	if mouse_enter:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			panel.position = panel.get_global_mouse_position() - of

func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			mouse_enter = true
			of = panel.get_global_mouse_position() - panel.global_position

var mouse_enter : bool = false
var of : Vector2 = Vector2.ZERO

func _on_mouse_exited():
	if Input.is_anything_pressed():
		return
	mouse_enter = false
	of = Vector2.ZERO
#endregion

#region |Send spawn enemy signal|
signal spawn_enemy_request

func _on_button_pressed():
	spawn_enemy_request.emit()
#endregion

#
@export var node := []
@export var read := []

func read_value():
	for i in node.size():
		var the_node = get_node(node[i])
		var the_text = get_node("CanvasLayer/Panel/text" + str(i) + "/text")
		the_text.text = read[i] + ": " + str(get_node(node[i]).get(read[i]))

func _process(delta):
	drag_ui()
	read_value()
