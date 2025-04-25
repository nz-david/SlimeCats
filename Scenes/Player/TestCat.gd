extends CharacterBody2D

var characterMap = {
	"ember": {
		"color1": load("res://Scenes/Player/red.tres"),
		"color2": load("res://Scenes/Player/ourple.tres"),
		"color3": load("res://Scenes/Player/geen.tres"),
	},
	"ripple": {
		"color1": load("res://Scenes/Player/ourple.tres"),
		"color2": load("res://Scenes/Player/geen.tres"),
		"color3": load("res://Scenes/Player/red.tres"),
		}
}

func changeCharacter(characterName):
	var characterColors = characterMap[characterName]
	$AnimatedSprite2D.material.set_shader_parameter("pal0", characterColors.color1)
	$AnimatedSprite2D.material.set_shader_parameter("pal1", characterColors.color2)
	$AnimatedSprite2D.material.set_shader_parameter("pal2", characterColors.color3)

	
var MaxHealth = 3
var currentCharacter = 0
var Characters = ["ember", "ripple"]
enum CatAngle {NORTH, NORTHEAST, NORTHWEST, SOUTH, SOUTHEAST, SOUTHWEST, WEST, EAST}
var cat_angle = CatAngle.NORTH
enum PlayerState {IDLE, MOVING, ATTACK}
var player_state = PlayerState.IDLE

var SPEED = 300.0
var is_attacking = false
var being_attacked = false

@onready var cat_run = $AnimatedSprite2D

@onready var hurt_timer = $Hurt_Timer
#@onready var hit_box = $Hit_Box/CollisionShape2D
@onready var melee_timer = $Melee_Timer
@onready var hurt_box = $Hurt_Box/CollisionShape2D
@export var Health = MaxHealth

func play_idle_animation():
	#if cat_run.is_playing():
		#cat_run.stop()
	match cat_angle:
		CatAngle.SOUTHEAST: cat_run.play("3_4 view forward idle")
		CatAngle.NORTHEAST: cat_run.play("3_4 view backward idle")
		CatAngle.EAST: cat_run.play("side view idle")
		CatAngle.SOUTHWEST: cat_run.play("3_4 view forward idle")
		CatAngle.NORTHWEST: cat_run.play("3_4 view backward idle")
		CatAngle.WEST: cat_run.play("side view idle")
		CatAngle.SOUTH: cat_run.play("forward view idle")
		CatAngle.NORTH: cat_run.play("backward view idle")
func on_animation_finished():
	if ($AnimatedSprite2D.animation == "forward view catapult" or $AnimatedSprite2D.animation == "backward view catapult" or $AnimatedSprite2D.animation == "side view catapult" or $AnimatedSprite2D.animation == "3_4 view forward catapult" or $AnimatedSprite2D.animation == "3_4 view backward catapult"):
		player_state = PlayerState.IDLE
		play_idle_animation()
	
func _ready() -> void:
	cat_run.animation_finished.connect(on_animation_finished)
	print("meow")
	


func _physics_process(delta: float) -> void:
	if Health <= 0:
		get_tree().change_scene_to_file("res://gameover.tscn")
	
	animate_based_on_input_controls()
	
	var cat_change:= Input.is_action_just_pressed("catchange")
	if cat_change:
		currentCharacter += 1
		if(currentCharacter>=len(Characters)):
			currentCharacter=0
		changeCharacter(Characters[currentCharacter])

	var direction := Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
	if player_state == PlayerState.MOVING or player_state == PlayerState.IDLE:
		if direction:
			velocity = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)
	elif player_state == PlayerState.ATTACK:
		velocity.x = 0
		velocity.y = 0
	move_and_slide()
	


	if Input.is_action_pressed("melee") and not is_attacking:
		match cat_angle:
			CatAngle.NORTH: $Hit_Box/NorthCollision.disabled = false
			CatAngle.SOUTH: $Hit_Box/SouthCollision.disabled = false
			CatAngle.NORTHEAST: $Hit_Box/NorthEastCollision.disabled = false
			CatAngle.WEST: $Hit_Box/WestCollision.disabled = false
			CatAngle.SOUTHWEST: $Hit_Box/SouthWestCollision.disabled = false
			CatAngle.NORTHWEST: $Hit_Box/NorthWestCollision.disabled = false
			CatAngle.SOUTHEAST: $Hit_Box/SouthEastCollision.disabled = false
			CatAngle.EAST: $Hit_Box/EastCollision.disabled = false
		melee_timer.start()
		is_attacking = true
#func on_Hurt_Box_entered(area):
	#if area.is_in_group("Enemies"):
		#Health -= 1
		#print("Owch Owwie")

func animate_based_on_input_controls():
	var is_up_pressed :=Input.is_action_pressed ("up")
	var is_down_pressed :=Input.is_action_pressed ("down")
	var is_right_pressed :=Input.is_action_pressed ("right")
	var is_left_pressed :=Input.is_action_pressed ("left")
	if player_state == PlayerState.IDLE or player_state == PlayerState.MOVING:
		if is_right_pressed:
			player_state = PlayerState.MOVING
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
			player_state = PlayerState.MOVING
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
			player_state = PlayerState.MOVING
			if is_up_pressed:
				cat_run.play("forward view idle")
			else:
				cat_run.play("forward view run")
				cat_angle = CatAngle.SOUTH
		elif is_up_pressed:
			player_state = PlayerState.MOVING
			cat_run.play("backward view run")
			cat_angle = CatAngle.NORTH
		else:
			play_idle_animation()
	
		var is_catapult_start :=Input.is_action_just_pressed("catapult")
		if is_catapult_start:
			player_state = PlayerState.ATTACK
			match cat_angle:
				CatAngle.SOUTHEAST: cat_run.play("3_4 view forward catapult")
				CatAngle.NORTHEAST: cat_run.play("3_4 view backward catapult")
				CatAngle.EAST: cat_run.play("side view catapult")
				CatAngle.SOUTHWEST: cat_run.play("3_4 view forward catapult")
				CatAngle.NORTHWEST: cat_run.play("3_4 view backward catapult")
				CatAngle.WEST: cat_run.play("side view catapult")
				CatAngle.SOUTH: cat_run.play("forward view catapult")
				CatAngle.NORTH: cat_run.play("backward view catapult")
		
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
	$Hit_Box/NorthCollision.disabled = true
	$Hit_Box/SouthCollision.disabled = true
	$Hit_Box/NorthEastCollision.disabled = true
	$Hit_Box/WestCollision.disabled = true
	$Hit_Box/SouthEastCollision.disabled = true
	$Hit_Box/NorthWestCollision.disabled = true
	$Hit_Box/EastCollision.disabled = true
	$Hit_Box/SouthWestCollision.disabled = true
	is_attacking = false
