extends Node

const ROOM = preload("res://Scripts/room.gd")
const SERVER_ID: int = 1
const LOCAL_IP: String = "127.0.0.1"
const PORT: int = 5000
var peer: NetworkedMultiplayerENet
var id: int
export(String) var username = "User"

func _ready():
	get_tree().connect("connected_to_server", self, "_register")
	_join_server()

func _join_server():
	peer = NetworkedMultiplayerENet.new()
	peer.create_client(LOCAL_IP, PORT)
	get_tree().set_network_peer(peer)

func _register():
	id = get_tree().get_network_unique_id()
	rpc_id(SERVER_ID, "_register_player", id, username)

remote func _create_room(title: String) -> void:
	var room = ROOM.new()
	room.name = title
	room.id = id
	add_child(room)
