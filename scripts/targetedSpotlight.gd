extends SpotLight3D

@export var target:Node3D

const list_length = 25

var positions: Array[Vector3] = [];
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	#if (target == null):
		#return
	#
	#if len(positions) > list_length:
		#look_at(positions.pop_at(0))
		#
	#positions.push_back(target.global_transform.origin + Vector3(0,0.5,0).normalized())
	
	look_at(target.global_transform.origin)
	set_color(Color.CORAL)
	light_energy = 1
	shadow_enabled = true
	shadow_blur = 2.25
		
	
		
