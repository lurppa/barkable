extends Node

var current_jokes = []
var chosen_joke

var typing_speed = 0.04
var read_time = 0.03

var odds_to_get_good = 0.4

var current_message = 0
var display = ""
var current_char = 0

# LIGHTS STATE
const STAGELIGHTS_OFF = 0
const STAGELIGHTS_GREEN = 1
const STAGELIGHTS_RED = 2 

@export var stagelight_applause : TextureRect
@export var stagelight_attack: TextureRect

# Remove already seen jokes and dont display the same joke multiple times
var jokes_array = [
		{
		"topic": "Monkey", 
		"content": "What did the monkey say after it ate a banana? \n\nThat was ape-peeling!",
		},{
		"topic": "Zebra", 
		"content": "Why did the zebra get a speeding ticket?\n\n Because he was horse-power crazy!"
		},{
		"topic":"Gaming", "content": "What do you call a gamer who is really good at finding Easter eggs? \n\nAn egg-cellent gamer."
		},{
			"topic":"Gamer",
			"content" :"Why did the gamer get kicked out of the library?\n\n Because he kept checking out the books to read the cheat codes."
		},{
			"topic":"Lottery",
			"content" :"What did the lottery ticket say to the winning ticket? \n\nYou're one in a million!"
		},{
			"topic":"Ice hockey",
			"content" :"How do ice hockey players stay cool during the game? \n\nThey stay close to the fans!"
		},{
			"topic":"Youtubers",
			"content" :"What's a YouTuber's favorite kind of sandwich? \n\nA sub-scription"
		},{
			"topic":"University student",
			"content" :"What's the difference between a university student and a pizza?\n\n A pizza can feed a family of four."
		},{
			"topic":"Homework",
			"content" :"Why did the university student eat his homework?\n\n Because the teacher told him it was a piece of cake!"
		},{
			"topic":"Computer",
			"content" :"Why was the computer cold? \n\nBecause it left its Windows open!"
		},{
			"topic":"Programmers",
			"content" :"Why don't programmers like nature? \n\nIt has too many bugs!"
		},{
			"topic":"Letter play",
			"content" :"What do you call a fish with no eyes? \n\nFsh!"
		},{
			"topic":"Chicken",
			"content" :"Why did the chicken go to school? \n\nTo improve its eggucation!"
		},{
			"topic":"Banana",
			"content" :"Why did the banana go to the doctor? \n\nIt wasn't peeling well."
		},{
			"topic":"Elephant",
			"content" :"Why did the elephant get kicked out of the pool? \n\nBecause he made a big splash! "
		},{
			"topic":"Pizza",
			"content" :"Why did the pizza get a job at the bank? \n\nTo make dough!"
		},{
			"topic":"Astronaut",
			"content" :"What did the astronaut say when he crashed into the moon? \n\nI Apollo-gize!"
		},{
			"topic":"Robot",
			"content" :"Why did the robot cross the road?\n\n To get to the other circuit board"
		},{
			"topic":"Penguin",
			"content" :"What did the penguin say when he stubbed his toe?\n\n Ow, my flipper!"
		},{
			"topic":"Unicorn",
			"content" :"Why did the unicorn join the track team? \n\nBecause it wanted to run for a horn of gold! "
		},{
			"topic":"Potato",
			"content" :"What do you call a potato that has been in the ground too long? \n\nA couch potato!"
		},{
			"topic":"Guitar",
			"content" :"What's the difference between a guitar and a fish? \n\nYou can tuna fish, but you can't guitar fish"
		},{
			"topic":"Balloon",
			"content" :"What did one balloon say to the other balloon? \n\nYou blow me away!"
		},{
			"topic":"Coffee",
			"content" :"What did the coffee say to the teabag? \n\nLet's leaf each other alone!"
		},{
			"topic":"Ninja",
			"content" : "What\'s a ninja\'s favorite food? \n\n Shuri-kens"
		},{
			"topic":"T-Rex",
			"content" :"Why was the T-rex so good at hide and seek? \n\nBecause it could always blend in with the fossils!"
		},{
			"topic":"Llama",
			"content" :"What did the llama say before leaving to work? \n\n Alpaca lunch!"
		},{
			"topic":"Rainbow",
			"content" :"Why did the rainbow cross the road? \n\nTo get to the pot of gold!"
		}
		]


# TODO: Main should probably handle showing and hiding the dialogue
signal dialog_chosen(score)
signal dialog_begin()

func _ready():
	$ButtonHolder/FirstButton.pressed.connect(first_button_pressed)
	$ButtonHolder/SecondButton.pressed.connect(second_button_pressed)
	$ButtonHolder/ThirdButton.pressed.connect(third_button_pressed)
	$ButtonHolder/FourthButton.pressed.connect(fourth_button_pressed)
	$ButtonHolder.visible = false
	change_headlight_state(STAGELIGHTS_OFF)

func show_dialog(val: bool):
	current_jokes = []
	for i in range(4):
		var joke = fetch_random_joke()
		current_jokes.append(joke) 
	$ButtonHolder/FirstButton/ButtonText.text = str(current_jokes[0]['topic'])
	$ButtonHolder/SecondButton/ButtonText.text = str(current_jokes[1]['topic'])
	$ButtonHolder/ThirdButton/ButtonText.text = str(current_jokes[2]['topic'])
	$ButtonHolder/FourthButton/ButtonText.text = str(current_jokes[3]['topic'])
	$ButtonHolder.visible = val


func set_comedy_level(val):
	$ComedyLevel.value = val


func first_button_pressed():
	chosen_joke = current_jokes.pop_at(0)
	display_joke_text(chosen_joke['content'])
	$ButtonHolder.visible = false
	$Click.play()
	for joke in current_jokes:
		jokes_array.append(joke)

func second_button_pressed():
	chosen_joke = current_jokes.pop_at(1)
	display_joke_text(chosen_joke['content'])
	$ButtonHolder.visible = false
	$Click.play()

	for joke in current_jokes:
		jokes_array.append(joke)

	
func third_button_pressed():
	chosen_joke = current_jokes.pop_at(2)
	display_joke_text(chosen_joke['content'])
	$ButtonHolder.visible = false
	$Click.play()

	for joke in current_jokes:
		jokes_array.append(joke)
		
func fourth_button_pressed():
	chosen_joke = current_jokes.pop_at(3)
	display_joke_text(chosen_joke['content'])
	$ButtonHolder.visible = false
	$Click.play()

	for joke in current_jokes:
		jokes_array.append(joke)


func fetch_random_joke():
	jokes_array.shuffle()
	return jokes_array.pop_front()
	
func display_joke_text(joke_content : String):
	$JokeSetup.visible = true
	$JokeSetup.visible_ratio = 0
	$JokePunchline.visible = true
	$JokePunchline.visible_ratio = 0
	show_text_slowly(joke_content)
	
func hide_joke_text():
	$JokeSetup.visible = false
	$JokePunchline.visible = false
	
func show_text_slowly(joke_content):
	var joke_parts = joke_content.split("\n\n")
	$JokeSetup.text = joke_parts[0]
	emit_signal("dialog_begin")
	if joke_parts.size() > 1:
		$JokePunchline.text = joke_parts[1]
		show_setup()
	else:
		while $JokeSetup.visible_ratio <1.0:
			await get_tree().create_timer(read_time).timeout
			#print("in while"+ str($JokeContent.visible_ratio))
			increase_setup_visible_ratio()
		print('after while')
		#get_tree().create_timer(4).connect("timeout",hide_joke_text)
	

func increase_setup_visible_ratio():
	$JokeSetup.visible_ratio+=typing_speed

		
func show_setup():
	while $JokeSetup.visible_ratio < 1.0:
		await get_tree().create_timer(read_time).timeout
		increase_setup_visible_ratio()
	get_tree().create_timer(1).connect("timeout", show_punchline)
	
func show_punchline():
	while $JokePunchline.visible_ratio < 1.0:
		await get_tree().create_timer(read_time).timeout
		increase_punchline_visible_ratio()
	print('finished')
	get_tree().create_timer(4).connect("timeout",hide_joke_text)
	var randnum = randf_range(0, 1)
	print(randnum)
	if odds_to_get_good < randnum:
		emit_signal("dialog_chosen", 1.0)
	else:
		emit_signal("dialog_chosen", -1.0)

func increase_punchline_visible_ratio():
	$JokePunchline.visible_ratio+=typing_speed

func change_headlight_state(val:int):
	stagelight_applause.visible = val == STAGELIGHTS_GREEN
	stagelight_attack.visible = val == STAGELIGHTS_RED
