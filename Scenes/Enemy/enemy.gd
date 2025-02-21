extends Area2D

var speed = 20
var den_pos
var target_pos
@onready var Hit_Box = $Enemy_Hit_Box
@onready var den = %Den


#func _ready() -> void:
	# _ready function isn't used right now ,but probably will be later
	
func _physics_process(delta: float) -> void:
	# Gets den position
	den_pos = den.position
	# Get the difference of the den's position and the enemy's position
	target_pos = (den.position - position).normalized()
# Moves the enemy toward the player
	if position.distance_to(den_pos) > 3:
		position += target_pos * speed * delta

# Disappear once they hit the den
func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().get_parent().get_node("Den"):
		queue_free()
