extends CharacterBody2D

var MaxHealth = 3
var SPEED = 300.0
var is_attacking = false
var being_attacked = false

@onready var hurt_timer = $Hurt_Timer
@onready var hit_box = $Hit_Box/CollisionShape2D
@onready var melee_timer = $Melee_Timer
@onready var hurt_box = $Hurt_Box/CollisionShape2D
@export var Health = MaxHealth

func _physics_process(delta: float) -> void:
	if Health <= 0:
		get_tree().change_scene_to_file("res://gameover.tscn")
	
	var direction := Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
	
	look_at(get_global_mouse_position())
	rotate(2.5 * PI)

	if Input.is_action_pressed("melee") and not is_attacking:
		hit_box.disabled = false
		melee_timer.start()
		is_attacking = true
#func on_Hurt_Box_entered(area):
	#if area.is_in_group("Enemies"):
		#Health -= 1
		#print("Owch Owwie")
		
func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemies") and not being_attacked:
		Health -= 1
		print("Owch Owwie")
		hurt_timer.start()
		being_attacked = true
		hurt_box.disabled = true

func _on_hurt_timer_timeout() -> void:
	being_attacked = false
	hurt_box.disabled = false



func _on_melee_timer_timeout() -> void:
	hit_box.disabled = true
	is_attacking = false
