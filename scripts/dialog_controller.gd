extends Node

func _ready():
	
	$ButtonHolder/GoodDialogButton.pressed.connect(good_button_pressed)
	$ButtonHolder/BadDialogButton.pressed.connect(bad_button_pressed)
	$ComedyLevel.value = 50
	$ButtonHolder.visible = false
	start_timer()
	
	
func _on_timer_timeout():
	$ButtonHolder.visible = true

func good_button_pressed():
	print('good was pressed')
	$ButtonHolder.visible = false
	$ComedyLevel.value += 1
	start_timer()
	

func bad_button_pressed():
	print('bad was pressed')
	$ButtonHolder.visible = false
	$ComedyLevel.value -= 1
	start_timer()
	
func start_timer():
	get_tree().create_timer(3).connect("timeout", _on_timer_timeout)
