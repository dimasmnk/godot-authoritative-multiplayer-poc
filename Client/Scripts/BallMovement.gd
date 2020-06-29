extends RigidBody2D

var savedTransform = Transform2D(0, Vector2(0,0))
var savedVelocity = Vector2(0,0)

puppet func updateTransform(transform : Transform2D, velocity : Vector2):
	savedTransform = transform
	savedVelocity = velocity

func _physics_process(delta):
	position = position.linear_interpolate(savedTransform.origin, delta * 4)
	linear_velocity = savedVelocity
