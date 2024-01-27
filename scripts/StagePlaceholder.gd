extends CSGBox3D

@export var stage_camera: PhantomCamera3D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	print('print')
	stage_camera.set_priority(2)


func _on_area_3d_body_exited(body):
	stage_camera.set_priority(0)
