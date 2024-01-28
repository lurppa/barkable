extends Node3D
# Handles game loop and orchestrates other objects to work in correct order.

@export var STARTING_COMEDY_SCORE = 1.0
# Amount of items to throw more each round
const DIFFICULTY_RAMPUP = 4
var current_level = 1

@export_node_path var stage_path
@export_node_path var dialog_path
@export_node_path var curtains_path

@onready var stage = get_node(stage_path)
@onready var dialog = get_node(dialog_path)
@onready var curtains = get_node(curtains_path)
@onready var comedian = stage.get_node("Comedian")

var game_over = false
var comedy_score:
	set(val):
		comedy_score = val
		if comedy_score <= 0.0:
			_on_game_lost()
		dialog.set_comedy_level(comedy_score)
var score:
	set(val):
		score = val
		dialog.set_score(score)
var difficulty = 7


func _ready():
	comedy_score = STARTING_COMEDY_SCORE
	score = 0
	dialog.connect("dialog_chosen", _on_dialog_chosen)
	stage.connect("item_hit_player", _on_item_hit_player)
	comedian.connect("death", fell_off_stage)
	$Menu/StartGame/StartButton.connect("pressed", _start_game)
	$Menu/GameOver/RetryButton.connect("pressed", _reset_game)
	$Menu/GameOver/FinalScoreLabel.visible = false
	$Menu/ScoreDisplay.visible = false


func _start_game():
	$Menu/GameOver/FinalScoreLabel/FellOffStageText.visible = false
	stage.lock_player()
	$Menu/StartGame/StartButton.connect("pressed", $Menu/Click.play)
	$Menu/StartGame.visible = false
	$Menu/ScoreDisplay.visible = true
	curtains.open()
	# stage.player.anim_play("idle")
	_show_dialog()


func _reset_game():
	get_tree().reload_current_scene()


func _show_dialog():
	await get_tree().create_timer(3.0).timeout
	#dialog.change_headlight_state(0)
	if not $Menu/GameOver.visible:
		stage.lock_player()
		stage.player.anim_play("idle")
		dialog.show_dialog(true)


func _on_dialog_chosen(_val):
	comedy_score = STARTING_COMEDY_SCORE
	stage.unlock_player()
	await get_tree().create_timer(0.5).timeout
	stage.get_node("Budumtss").play()
	await get_tree().create_timer(1.5).timeout
	$Audience/Negative.play()
	await get_tree().create_timer(1.0).timeout
	$Audience/Booing.play()
	stage.start_throwing(difficulty)
	difficulty += DIFFICULTY_RAMPUP
	#dialog.change_headlight_state(1 if val < 0 else 2)
	await stage.throwing_stopped
	if not game_over:
		score += current_level
		current_level +=1
	await get_tree().create_timer(1.0).timeout
	_show_dialog()


func _on_item_hit_player(item):
	comedy_score += item.score_affect
	if item.score_affect < 0.0:
		comedian.hurt()
	else:
		score += 1
		comedian.get_node("Pickup").play()

func fell_off_stage():
	$Menu/GameOver/FinalScoreLabel/FellOffStageText.visible = true
	_on_game_lost()

func _on_game_lost():
	if game_over:
		return
	game_over = true
	$Audience/Laughter.play()
	$Menu/GameOver.visible = true
	$Menu/GameOver/FinalScoreLabel.visible = true
	$Menu/GameOver/FinalScoreLabel.text = "Jokes landed: " + str(score)
	$Menu/ScoreDisplay.visible = false
	$Dialog.visible = false
	stage.player._pass_out()
	await get_tree().create_timer(2.0).timeout
	curtains.close()
