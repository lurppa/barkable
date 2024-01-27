extends Node3D

const STARTING_COMEDY_SCORE = 50.0

@export var comedian_playerr : Comedian
@export_node_path var stage_path
@export_node_path var dialog_path

@onready var stage = get_node(stage_path)
@onready var dialog = get_node(dialog_path)

var comedy_score:
	set(val):
		comedy_score = val
		if comedy_score <= 0.0:
			$Menu/GameOver.visible = true
		dialog.set_comedy_level(comedy_score)


func _ready():
	comedy_score = STARTING_COMEDY_SCORE
	dialog.connect("dialog_chosen", _on_dialog_chosen)
	stage.connect("item_hit_player", _on_item_hit_player)
	$Menu/StartGame/GoodDialogButton.connect("pressed", _start_game)


func _start_game():
	$Menu/StartGame.visible = false
	_show_dialog()


func _show_dialog():
	await get_tree().create_timer(3.0).timeout
	if not $Menu/GameOver.visible:
		dialog.show_dialog(true)


func _on_dialog_chosen(val):
	comedy_score += val
	if val < 0.0:
		stage.throw_multiple_items()
	await get_tree().create_timer(3.0).timeout
	_show_dialog()


func _on_item_hit_player(_item):
	comedy_score -= 10.0

