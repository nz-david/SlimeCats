extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var collision:= move_and_collide(Vector2(0, 0))
	
	if collision:
		var other = collision.get_collider()
		print(other.get_class())
		if(other.is_in_group("Friends")):
			other.heal()
			queue_free()




func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Friends"):
		area.heal()
		queue_free()
