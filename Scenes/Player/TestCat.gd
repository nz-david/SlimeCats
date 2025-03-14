extends CharacterBody2D

var cat_angle = 0
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
			cat_angle = 0
		elif is_up_pressed:
			cat_run.play("3_4 view backward run")
			cat_angle = 1
		elif is_left_pressed:
			cat_run.play("side view idle")
		else:
			cat_run.play("side view run")
			cat_angle = 2
	elif is_left_pressed:
		cat_run.flip_h=true
		if is_down_pressed:
			cat_run.play("3_4 view forward run")
			cat_angle = 3
		elif is_up_pressed:
			cat_run.play("3_4 view backward run")
			cat_angle = 4
		else:
			cat_run.play("side view run")
			cat_angle = 5
	elif is_down_pressed:
		if is_up_pressed:
			cat_run.play("forward view idle")
		else:
			cat_run.play("forward view run")
			cat_angle = 6
	elif is_up_pressed:
		cat_run.play("backward view run")
		cat_angle = 7
	else:
		match cat_angle:
			0: cat_run.play("3_4 view forward idle")
			2: cat_run.play("side view idle")
			3: 
				cat_run.play("3_4 view forward idle")
			5: cat_run.play("side view idle")
			6: cat_run.play("forward view idle")
	var direction := Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
	
