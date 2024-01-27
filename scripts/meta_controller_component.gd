extends Node

@onready var initial_window_mode = DisplayServer.window_get_mode()

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_F11:
			var mode = DisplayServer.WINDOW_MODE_FULLSCREEN if DisplayServer.window_get_mode() == initial_window_mode else initial_window_mode
			DisplayServer.window_set_mode(mode)
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().quit()
