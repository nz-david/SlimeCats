extends StaticBody2D

var base_health = 15
var health
var open = false
var has_opened = false
@onready var sprite = $Sprite2D
@onready var Hit_box = $CollisionShape2D
@onready var base_entrance = $Area2D/CollisionShape2D
# Health value and Display
func _ready() -> void:
	health = base_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ProgressBar.value = health

	if open and !has_opened:
		base_entrance.disabled = false
		has_opened = true

# Makes den invisible and turns off collisions when den health is less than 1 
# I tried just queue_freeing the den but that makes everything crash. Trust me
	if health < 1:
		sprite.visible = false
		Hit_box.disabled = true
		$ProgressBar.visible = false
		get_tree().change_scene_to_file("res://gameover.tscn")

# Den takes 3.5 damage every time the enemy's hit-box collides with it
func _on_den_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemies"):
		health -= 3.5
		
func damage():
	health -=3.5
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Friends"):
		get_tree().change_scene_to_file("res://den_scene.tscn")
