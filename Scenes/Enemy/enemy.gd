extends CharacterBody2D

var speed = 60
var den_pos
var target_pos
var MaxHealth = 1
var range = 300
@onready var Hit_Box = $Enemy_Hit_Box
@onready var den = %Den
@onready var Health = MaxHealth
@onready var player = %TestCat/CharacterBody2D


#func _ready() -> void:
	# _ready function isn't used right now ,but probably will be later
	
func _physics_process(delta: float) -> void:
	if Health <= 0:
		queue_free()
	
	den_pos = den.position
	var d = position - player.position
	
	if(d.length() < range):
		velocity = (player.position - position).normalized() * speed
		#print("In Range")
	else:
		velocity = (den.position - position).normalized() * speed
	
	var collided = move_and_slide()
	
	if collided:
		print("collided")
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
	
	
			var other = collision.get_collider()
			if(other.is_in_group("den")):
				other.damage()
				queue_free()
	# Gets den position
	#den_pos = den.position
	# Get the difference of the den's position and the enemy's position
	#target_pos = (den.position - position).normalized()
# Moves the enemy toward the player
	#if position.distance_to(den_pos) > 3:
		#position += target_pos * speed * delta


# Disappear once they hit the den
#func _on_area_entered(area: Area2D) -> void:
	#if area.get_parent().get_parent().get_node("Den"):
		#queue_free()
		
func damage():
	Health -= 1
	print("Owch")
