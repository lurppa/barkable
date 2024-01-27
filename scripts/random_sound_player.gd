extends Node3D
# Plays a random sound player child when triggered


func play():
	var players = get_children().filter(func(a): return a is AudioStreamPlayer3D or a is AudioStreamPlayer)
	players[randf() * len(players)].play()
