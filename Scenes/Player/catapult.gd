extends RigidBody2D

var speed = 5
var velocity := Vector2(0, 0)
var target = Vector2(0, 0)

@onready var Scene = load("res://Scenes/Player/slime_spill.tscn")

func _ready() -> void:
	target = get_global_mouse_position()



func _process(delta: float) -> void:
	
	velocity = (target - position).normalized() * speed
	
	var collision := move_and_collide(velocity)
	
	if Rect2(target - Vector2(10, 10), Vector2(20, 20)).has_point(position):
		print("Made it")
		var slime_spill = Scene.instantiate()
		get_tree().get_root().get_node("Test").add_child(slime_spill)
		slime_spill.position = position
		queue_free()
	
	if collision:
		print("Has Entered :3")
		var other = collision.get_collider()
		print(other.get_class())
		if(other.is_in_group("Enemies")):
			other.damage()
