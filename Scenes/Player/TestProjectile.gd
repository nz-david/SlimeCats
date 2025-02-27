extends RigidBody2D

var speed = 5
var velocity := Vector2(0, 0)

func _ready() -> void:
	pass



func _process(delta: float) -> void:
	var collision := move_and_collide(velocity)
	
	if collision:
		print("Has Entered :3")
		var other =collision.get_collider()
		print(other.get_class())
		if(other.is_in_group("Enemies")):
			other.damage()
			queue_free()
		elif(other.is_in_group("den")):
			queue_free()
	
	velocity = transform.y * speed
