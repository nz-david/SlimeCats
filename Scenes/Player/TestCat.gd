extends CharacterBody2D


var SPEED = 300.0


func _physics_process(delta: float) -> void:
	var direction := Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
	
	look_at(get_global_mouse_position())
	rotate(2.5 * PI)
