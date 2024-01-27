extends Node3D

@export_node_path var left_curtain
@export_node_path var right_curtain
@export var left_curtains: Array[NodePath]
@export var right_curtains: Array[NodePath]

var initial_positions = {}

const ANIMATION_DURATION = 1.0


func _ready():
	# Remember initial curtain positions
	for curtain in left_curtains + right_curtains:
		initial_positions[curtain] = get_node(curtain).transform

func open():
	for curtain in left_curtains:
		create_tween().tween_property(get_node(curtain), "transform", get_node(left_curtain).transform, ANIMATION_DURATION) \
				.set_ease(Tween.EASE_IN_OUT) \
				.set_trans(Tween.TRANS_CUBIC)
	for curtain in right_curtains:
		create_tween().tween_property(get_node(curtain), "transform", get_node(right_curtain).transform, ANIMATION_DURATION) \
				.set_ease(Tween.EASE_IN_OUT) \
				.set_trans(Tween.TRANS_CUBIC)

func close():
	for i in range(len(initial_positions)):
		var curtain = (left_curtains + right_curtains)[i]
		var initial_position = initial_positions[curtain]
		create_tween().tween_property(get_node(curtain), "transform", initial_position, ANIMATION_DURATION) \
				.set_ease(Tween.EASE_IN_OUT) \
				.set_trans(Tween.TRANS_CUBIC)
