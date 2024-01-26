extends Node

func _ready():
	$GoodDialogButton.pressed.connect(good_button_pressed)
	$BadDialogButton.pressed.connect(bad_button_pressed)
	start_timer()
	
func _on_timer_timeout():
	self.visible = true

func good_button_pressed():
	print('good was pressed')
	self.visible = false
	start_timer()

func bad_button_pressed():
	print('bad was pressed')
	self.visible = false
	start_timer()
	
func start_timer():
	get_tree().create_timer(3).connect("timeout", _on_timer_timeout)
