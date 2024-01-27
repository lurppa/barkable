extends Node

signal dialog_chosen(score)

func _ready():
	$ButtonHolder/GoodDialogButton.pressed.connect(good_button_pressed)
	$ButtonHolder/BadDialogButton.pressed.connect(bad_button_pressed)
	$ButtonHolder.visible = false


func show_dialog(val: bool):
	$ButtonHolder.visible = val


func set_comedy_level(val):
	$ComedyLevel.value = val


func good_button_pressed():
	print('good was pressed')
	emit_signal("dialog_chosen", 1.0)
	$ButtonHolder.visible = false


func bad_button_pressed():
	print('bad was pressed')
	emit_signal("dialog_chosen", -1.0)
	$ButtonHolder.visible = false
