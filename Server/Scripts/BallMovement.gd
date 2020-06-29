extends RigidBody2D

func _physics_process(delta) -> void:
	rpc_unreliable("updateTransform", transform, linear_velocity)
