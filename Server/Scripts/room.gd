extends Node

var player1
var player2
var player1_is_ready = false
var player2_is_ready = false

func _init(player1, player2):
	self.player1 = player1
	self.player2 = player2

remote func _ready_player(id: int) -> void:
	if id == player1.id:
		player1_is_ready = true
	elif id == player2.id:
		player2_is_ready = true
	if player1_is_ready and player2_is_ready:
		start()

func start():
	var ball = preload("res://Ball.tscn").instance()
	ball.set_name("Ball")
	ball.set_network_master(1)
	ball.position = Vector2(300, 510)
	self.add_child(ball)
	
	var leftPlayer = preload("res://Player.tscn").instance()
	leftPlayer.set_name("Player1")
	leftPlayer.set_network_master(1)
	leftPlayer.playerId = player1.id
	leftPlayer.otherPlayerId = player2.id
	leftPlayer.position = Vector2(192, 300)
	self.add_child(leftPlayer)
	
	var rightPlayer = preload("res://Player.tscn").instance()
	rightPlayer.set_name("Player2")
	rightPlayer.set_network_master(1)
	rightPlayer.playerId = player2.id
	rightPlayer.otherPlayerId = player1.id
	rightPlayer.position = Vector2(832, 300)
	self.add_child(rightPlayer)
	
	print(player1.username, " & ", player2.username, " are both ready in ", self.name)
