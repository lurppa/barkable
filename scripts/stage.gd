extends Node3D

signal item_hit_player(item)
signal throwing_stopped

const TARGET_OFFSET = Vector3(0, 10, 0)
const THROW_VELOCITY = 10.0
const THROW_X_RANDOMNESS = 1.0
const CHANCE_OF_GOOD_ITEMS = 0.4
const ROUND_TIME = 10.0

@export_node_path var player_path
@export_node_path var throw_point1_path
@export_node_path var throw_point2_path
@export var throwable_bads: Array[PackedScene]
@export var throwable_goods: Array[PackedScene]
@export_node_path var front_of_stage_path

@onready var player = get_node(player_path)
@onready var throw_point1 = get_node(throw_point1_path)
@onready var throw_point2 = get_node(throw_point2_path)
@onready var front_of_stage = get_node(front_of_stage_path)


func start_throwing(count_of_items: int):
	var timeout = ROUND_TIME / count_of_items
	for i in range(count_of_items):
		await get_tree().create_timer(timeout).timeout
		throw_item()
	emit_signal("throwing_stopped")


func throw_item():
	# Get a random point between throw points
	var throw_point = throw_point1.position.lerp(throw_point2.position, randf())

	# Get a normalized vector direction from chosen point to around the player
	var horizontal_offset = Vector3(THROW_X_RANDOMNESS * 2 * randf() - THROW_X_RANDOMNESS, 0, 0)
	var dir_to_player = (player.position + horizontal_offset + TARGET_OFFSET - throw_point).normalized()

	var throw_good_item = randf() <= CHANCE_OF_GOOD_ITEMS
	var array = throwable_goods if throw_good_item else throwable_bads

	# Instantiate a random item with values calculated earlier
	var item = array[randf() * len(array)].instantiate()
	item.position = throw_point
	item.linear_velocity = dir_to_player * THROW_VELOCITY * item.throw_speed_modifier
	item.rotation_degrees = Vector3(randf() * 1000, randf() * 1000, randf() * 1000)
	item.connect("hit_player", func(item2): emit_signal("item_hit_player", item2))
	add_child(item)


# Locks player and moves them to the front of the stage
func lock_player():
	player.disable_movement = true
	get_tree().create_tween() \
			.tween_property(player, "transform", front_of_stage.transform, 2.0) \
			.set_ease(Tween.EASE_IN_OUT) \
			.set_trans(Tween.TRANS_CUBIC)


# Unlocks player movement
func unlock_player():
	player.disable_movement = false
