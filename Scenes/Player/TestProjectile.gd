extends RigidBody2D

var speed = 5
var velocity := Vector2(0, 0)

func _ready() -> void:
	pass



func _process(delta: float) -> void:
	var collision := move_and_collide(velocity)
	
	if collision:
		var other =collision.get_collider()
		if(other.is_in_group("player")):
			other.damage(1)
			queue_free()
	
	
	velocity = transform.y * speed
