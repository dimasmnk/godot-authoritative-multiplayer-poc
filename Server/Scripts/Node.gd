extends Node

const ROOM = preload("res://Scripts/room.gd")
const ENOUGH_PLAYERS = 2
const PORT: int = 5000
var room_count: int = 0
var peer: NetworkedMultiplayerENet
var players: Array = []

func _ready() -> void:
	_create_server()

func _process(delta) -> void:
	_matchmaking()

func _create_server() -> void:
	peer = NetworkedMultiplayerENet.new()
	peer.create_server(PORT)
	get_tree().set_network_peer(peer)
	print("Server Created")

remote func _register_player(id: int, username: String) -> void:
	players.append({"id": id, "username": username})

func _matchmaking() -> void:
	if players.size() < ENOUGH_PLAYERS:
		# Not enough players to make a room
		return
	var player1 = players.pop_back()
	var player2 = players.pop_back()

	room_count += 1
	var room = ROOM.new(player1, player2)
	room.name = "ROOM_" + str(room_count)
	add_child(room)

	rpc_id(player1.id, "_create_room", room.name)
	rpc_id(player2.id, "_create_room", room.name)
