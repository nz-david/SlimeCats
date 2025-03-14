extends CharacterBody2D


var SPEED = 300.0
@onready var cat_run = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var is_up_pressed :=Input.is_action_pressed ("up")
	var is_down_pressed :=Input.is_action_pressed ("down")
	var is_right_pressed :=Input.is_action_pressed ("right")
	var is_left_pressed :=Input.is_action_pressed ("left")
	if is_right_pressed:
		cat_run.flip_h=false
		if is_down_pressed:
			cat_run.play("3_4 view forward run")
		elif is_up_pressed:
			cat_run.play("3_4 view backward run")
		elif is_left_pressed:
			cat_run.stop()
		else:
			cat_run.play("side view run")
	elif is_left_pressed:
		cat_run.flip_h=true
		if is_down_pressed:
			cat_run.play("3_4 view forward run")
		elif is_up_pressed:
			cat_run.play("3_4 view backward run")
		else:
			cat_run.play("side view run")
	elif is_down_pressed:
		if is_up_pressed:
			cat_run.stop()
		else:
			cat_run.play("forward view run")
	elif is_up_pressed:
		cat_run.play("backward view run")
	else:
		cat_run.stop()
	var direction := Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
	
