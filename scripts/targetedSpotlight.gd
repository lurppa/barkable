extends SpotLight3D

@export var target:Node3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (target != null):
		look_at(target.global_transform.origin)
