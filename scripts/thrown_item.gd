extends RigidBody3D

signal hit_player(item)

const ALIVE_FOR = 1.0

# Affects how much this item affects score if hit by player
@export var score_affect: float = 0.0


func _ready():
	var helper = func(body):
		if body.is_in_group("player"):
			emit_signal("hit_player", self)
			queue_free()
		if body.is_in_group("stage"):
			get_tree().create_timer(ALIVE_FOR).connect("timeout", queue_free)

	connect("body_entered", helper)
