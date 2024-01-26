extends RigidBody3D

signal hit_player(item)

const ALIVE_FOR = 5.0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().create_timer(ALIVE_FOR).connect("timeout", queue_free)
	var helper = func(body):
		if body.is_in_group("player"):
			emit_signal("hit_player", self)
	connect("body_entered", helper)
