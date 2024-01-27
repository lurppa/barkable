extends Node

var joke1
var joke2

var can_continue

var typing_speed = 0.04
var read_time = 0.03

var current_message = 0
var display = ""
var current_char = 0

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
		}
		]


# TODO: Main should probably handle showing and hiding the dialogue
signal dialog_chosen(score)
signal dialog_begin()

func _ready():
	$ButtonHolder/GoodDialogButton.pressed.connect(good_button_pressed)
	$ButtonHolder/BadDialogButton.pressed.connect(bad_button_pressed)
	$ButtonHolder.visible = false


func show_dialog(val: bool):
	joke1 = fetch_random_joke()
	joke2 = fetch_random_joke()
	print(joke1)
	$ButtonHolder/GoodDialogButton/ButtonText.text = str(joke1['topic'])
	$ButtonHolder/BadDialogButton/ButtonText2.text = str(joke2['topic'])
	$ButtonHolder.visible = val


func set_comedy_level(val):
	$ComedyLevel.value = val


func good_button_pressed():
	#emit_signal("dialog_chosen", 1.0)
	display_joke_text(joke1['content'])
	$ButtonHolder.visible = false


func bad_button_pressed():
	display_joke_text(joke2['content'])
	$ButtonHolder.visible = false
	
func fetch_random_joke():
	return jokes_array.pick_random()
	
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
	
	#TODO: Change the logic to give points based on answer
		emit_signal("dialog_chosen", -1.0)

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
	emit_signal("dialog_chosen", -1.0)

func increase_punchline_visible_ratio():
	$JokePunchline.visible_ratio+=typing_speed
	
	
