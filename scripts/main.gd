extends Node3D

@export_node_path var stage_path

@onready var stage = get_node(stage_path)


func _ready():
	await get_tree().create_timer(5.0).timeout
	#await get_tree().create_timer(5.0).timeout
	#stage.throw_items = true
	#await get_tree().create_timer(2.0).timeout
	#stage.throw_items = false
