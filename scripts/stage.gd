extends Node3D

const THROW_ITEM = preload("res://scenes/thrown_item.tscn")
const TARGET_OFFSET = Vector3(0, 10, 0)
const THROW_VELOCITY = 10.0

@export_node_path var player_path
@export_node_path var throw_point1_path
@export_node_path var throw_point2_path
@export var debug: bool = false:
	set(_val):
		if is_node_ready():
			throw_item()

@onready var player = get_node(player_path)
@onready var throw_point1 = get_node(throw_point1_path)
@onready var throw_point2 = get_node(throw_point2_path)


func _ready():
	_timeout()


func _timeout():
	throw_item()
	get_tree().create_timer(1.0).connect("timeout", _timeout)


func throw_item():
	# Get a random point between throw points
	var throw_point = throw_point1.position.lerp(throw_point2.position, randf())

	# Get a normalized vector direction from chosen point to comedian
	var dir_to_player = (player.position + TARGET_OFFSET - throw_point).normalized()

	var item = THROW_ITEM.instantiate()
	item.position = throw_point
	item.linear_velocity = dir_to_player * THROW_VELOCITY
	add_child(item)
