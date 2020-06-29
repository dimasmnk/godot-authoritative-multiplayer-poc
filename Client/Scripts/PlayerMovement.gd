extends RigidBody2D

onready var ball : RigidBody2D = get_node("../Ball")
var isKickable = false
var id
var savedTransform : Transform2D = Transform2D(0, Vector2(0,0))
var savedVelocity : Vector2 = Vector2(0, 0)

var isJump = false
var isKick = false

func _integrate_forces(state):
	if(name != id):
		if(isJump):
			state.linear_velocity.y -= 210
			isJump = false
	
		if(isKick && isKickable):
			ball.linear_velocity = (global_transform.origin - ball.global_transform.origin).normalized() * -500
			isKick = false
		return
		
	var input = 0.0
	if (Input.is_action_pressed("move_right")):
		input += 1
	if(Input.is_action_pressed("move_left")):
		input -= 1
	
	rpc_id(1, "setInput", input)
	
	state.linear_velocity.x = 200 * input
	
	if(Input.is_action_just_pressed("jump")):
		rpc_id(1, "setJump")
		state.linear_velocity.y -= 210
	
	if(Input.is_action_just_pressed("kick") && isKickable):
		rpc_id(1, "setKick")
		ball.linear_velocity = (global_transform.origin - ball.global_transform.origin).normalized() * -500

puppet func setId(id):
	self.id = id

puppet func updateTransform(tranform, velocity):
	savedTransform = tranform
	savedVelocity = velocity

puppet func setKick():
	isKick = true
	
puppet func setJump():
	isJump = true

func _physics_process(delta):
	if(name == id):
		if(transform.origin.x - savedTransform.origin.x > 1 || transform.origin.y - savedTransform.origin.y > 1):
				position = position.linear_interpolate(savedTransform.origin, delta * 4)
				linear_velocity = savedVelocity
		return
		
	position = position.linear_interpolate(savedTransform.origin, delta * 4)
	linear_velocity = savedVelocity
	

func _on_PlayerArea_body_shape_entered(body_id, body, body_shape, area_shape):
	if(body.name == "Ball"):
		isKickable = true


func _on_PlayerArea_body_shape_exited(body_id, body, body_shape, area_shape):
	if(body.name == "Ball"):
		isKickable = false
