extends Node3D

var going_forward
# Called when the node enters the scene tree for the first time.
func _ready():
	going_forward = true
	$PhantomCamera3D.set_camera_fov(60)

func _process(_delta):
	if $"..".progress_ratio>0.98:
		going_forward = false
	elif $"..".progress_ratio<0.02:
		going_forward = true
	if going_forward:
		$"..".progress+=0.001
	else:
		$"..".progress-=0.001
	#position.x += .001


func _on_camera_trigger_body_entered(_body):
	$PhantomCamera3DLookAtPlayer.set_priority(2)
	$PhantomCamera3DLookAtPlayer.set_camera_fov(60)
	#$PhantomCamera3D.set_look_at_target($"../../../Stage/Comedian")
	#$PhantomCamera3D.set_look_at_target_offset(Vector3(0,0,0))
