extends Node

var id: int

func _ready() -> void:
	var ball = preload("res://Ball.tscn").instance()
	ball.set_name("Ball")
	ball.set_network_master(1)
	ball.position = Vector2(300, 510)
	self.add_child(ball)
	
	var player = preload("res://Player.tscn").instance()
	player.set_name("Player1")
	player.set_network_master(1)
	player.position = Vector2(192, 300)
	self.add_child(player)
	
	var player2 = preload("res://Player.tscn").instance()
	player2.set_name("Player2")
	player2.set_network_master(1)
	player2.position = Vector2(832, 300)
	self.add_child(player2)
	
	_ready_self()

func _ready_self():
	rpc_id(1, "_ready_player", id)
