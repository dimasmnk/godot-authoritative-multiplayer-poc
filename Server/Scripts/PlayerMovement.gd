extends RigidBody2D

onready var ball : RigidBody2D = get_node("../Ball")

var isKickable = false
var playerId = 0
var otherPlayerId = 0
var input = 0
var isKick = false
var isJump = false

func _ready():
	rpc_id(playerId, "setId", name)
	
func _integrate_forces(state):
	
	state.linear_velocity.x = 200 * input
	
	if(isJump):
		state.linear_velocity.y -= 210
		isJump = false
	
	if(isKick && isKickable):
		ball.linear_velocity = (global_transform.origin - ball.global_transform.origin).normalized() * -500
		isKick = false
	
	rpc_unreliable("updateTransform", transform, linear_velocity)

master func setInput(inp):
	input = inp

master func setKick():
	rpc_id(otherPlayerId, "setKick")
	isKick = true
	
master func setJump():
	rpc_id(otherPlayerId, "setJump")
	isJump = true

func _on_PlayerArea_body_shape_entered(body_id, body, body_shape, area_shape):
	if(body.name == "Ball"):
		isKickable = true


func _on_PlayerArea_body_shape_exited(body_id, body, body_shape, area_shape):
	if(body.name == "Ball"):
		isKickable = false
