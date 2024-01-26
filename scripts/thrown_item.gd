extends RigidBody3D


const ALIVE_FOR = 5.0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().create_timer(ALIVE_FOR).connect("timeout", queue_free)
