extends RigidBody3D


const ALIVE_FOR = 5.0

# Timer to make the thrown item disappear after initialisation
func _ready():
	get_tree().create_timer(ALIVE_FOR).connect("timeout", queue_free)
