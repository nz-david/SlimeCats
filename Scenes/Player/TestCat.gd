extends CharacterBody2D

enum CatAngle {NORTH, NORTHEAST, NORTHWEST, SOUTH, SOUTHEAST, SOUTHWEST, WEST, EAST}
var cat_angle = CatAngle.NORTH
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
			cat_angle = CatAngle.SOUTHEAST
		elif is_up_pressed:
			cat_run.play("3_4 view backward run")
			cat_angle = CatAngle.NORTHEAST
		elif is_left_pressed:
			cat_run.play("side view idle")
		else:
			cat_run.play("side view run")
			cat_angle = CatAngle.EAST
	elif is_left_pressed:
		cat_run.flip_h=true
		if is_down_pressed:
			cat_run.play("3_4 view forward run")
			cat_angle = CatAngle.SOUTHWEST
		elif is_up_pressed:
			cat_run.play("3_4 view backward run")
			cat_angle = CatAngle.NORTHWEST
		else:
			cat_run.play("side view run")
			cat_angle = CatAngle.WEST
	elif is_down_pressed:
		if is_up_pressed:
			cat_run.play("forward view idle")
		else:
			cat_run.play("forward view run")
			cat_angle = CatAngle.SOUTH
	elif is_up_pressed:
		cat_run.play("backward view run")
		cat_angle = CatAngle.NORTH
	else:
		match cat_angle:
			CatAngle.SOUTHEAST: cat_run.play("3_4 view forward idle")
			CatAngle.NORTHEAST: cat_run.play("3_4 view backward idle")
			CatAngle.EAST: cat_run.play("side view idle")
			CatAngle.SOUTHWEST: cat_run.play("3_4 view forward idle")
			CatAngle.NORTHWEST: cat_run.play("3_4 view backward idle")
			CatAngle.WEST: cat_run.play("side view idle")
			CatAngle.SOUTH: cat_run.play("forward view idle")
			CatAngle.NORTH: cat_run.play("backward view idle")
	var direction := Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
	
