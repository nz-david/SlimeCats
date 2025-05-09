extends StaticBody2D

var velocity := Vector2(0, 0)

func _ready() -> void:
	get_tree().create_timer(15).timeout.connect(goodbye)

func _process(delta: float) -> void:
	var collision := move_and_collide(velocity)
	
	if collision:
		print("Has Entered :3")
		var other = collision.get_collider()
		print(other.get_class())
		if(other.is_in_group("Enemies")):
			other.damage()

func goodbye():
	queue_free()
