extends Area3D


func _on_body_entered(body):
	$"../../../CrowdCamera/PhantomCamera3D".set_priority(2)
