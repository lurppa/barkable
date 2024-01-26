extends Node

func _ready():
	
	$ButtonHolder/GoodDialogButton.pressed.connect(good_button_pressed)
	$ButtonHolder/BadDialogButton.pressed.connect(bad_button_pressed)
	$ComedyLevel.value = 50
	$ButtonHolder.visible = false
	show_dialog_with_timer()
	
	
func _on_timer_timeout():
	$ButtonHolder.visible = true

func good_button_pressed():
	print('good was pressed')
	$ButtonHolder.visible = false
	$ComedyLevel.value += 1
	$"../Stage".throw_multiple_items()
	show_dialog_with_timer()
	

func bad_button_pressed():
	print('bad was pressed')
	$ButtonHolder.visible = false
	$ComedyLevel.value -= 1
	$"../Stage".throw_multiple_items()
	show_dialog_with_timer()
	
func show_dialog_with_timer():
	get_tree().create_timer(5).connect("timeout", _on_timer_timeout)
