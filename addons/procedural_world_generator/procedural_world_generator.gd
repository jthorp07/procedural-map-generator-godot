@tool
extends EditorPlugin


func _enter_tree():
	# Initialization of the plugin goes here.
	_make_input_mappings()
	EditorInterface.restart_editor(true)
	pass


func _exit_tree():
	# Clean-up of the plugin goes here.
	_remove_input_mappings()
	EditorInterface.restart_editor(true)
	pass


static func _make_input_mappings():
	var input_map := []
	
	_add_to_input_mappings(&"camera_up", [KEY_UP, KEY_W], [], input_map)
	_add_to_input_mappings(&"camera_down", [KEY_DOWN, KEY_S], [], input_map)
	_add_to_input_mappings(&"camera_left", [KEY_LEFT, KEY_A], [], input_map)
	_add_to_input_mappings(&"camera_right", [KEY_RIGHT, KEY_D], [], input_map)
	_add_to_input_mappings(&"camera_zoom_in", [], [MOUSE_BUTTON_WHEEL_UP], input_map)
	_add_to_input_mappings(&"camera_zoom_out", [], [MOUSE_BUTTON_WHEEL_DOWN], input_map)
	
	for i in range(input_map.size()):
		print("Setting %s\n" % input_map[i].input_name)
		ProjectSettings.set_setting(input_map[i].input_name, input_map[i].input)
	ProjectSettings.save()
	

static func _add_to_input_mappings(input_name: StringName, key_events: Array, mouse_events: Array, input_map: Array):
	var input_events := []
	var input_key := InputEventKey.new()
	var input_mouse := InputEventMouseButton.new()
	for i in range(key_events.size()):
		input_key.physical_keycode = key_events[i]
		input_events.append(input_key.duplicate())
		input_key = InputEventKey.new()
	for i in range(mouse_events.size()):
		input_mouse.button_index = mouse_events[i]
		input_events.append(input_mouse.duplicate())
		input_mouse = InputEventMouseButton.new()
	input_map.append({
		&"input_name": "input/%s" % input_name,
		&"input": {
			&"deadzone": 0.5,
			&"events": input_events.duplicate()
		}
	})


static func _remove_input_mappings():
	const setting_names = [
		&"camera_up",
		&"camera_down",
		&"camera_right",
		&"camera_left",
		&"camera_zoom_in",
		&"camera_zoom_out"
	]
	for i in range(setting_names.size()):
		ProjectSettings.set_setting(setting_names[i], null)
