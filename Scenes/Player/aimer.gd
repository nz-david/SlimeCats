extends Node2D

var sps := 25.0
var st := 0.0
var capacity = 10.0
var avail = true

@onready var scene = load("res://Scenes/Player/TestProjectile.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	rotate(PI/2)
	st += delta
	var ste := st>(4/sps)
	if Input.is_action_pressed("pew") and ste and avail and Plswork.can_attack:
		var TestProjectile = scene.instantiate()
		
		get_tree().get_root().get_node("Test").add_child(TestProjectile)
		var player = $"."
		TestProjectile.global_position = player.global_position
		TestProjectile.global_rotation = player.global_rotation + (5 * PI)
		
		capacity = capacity - 1
		st = 0
	if((capacity == 0) and avail):
		avail = false
		get_tree().create_timer(3).timeout.connect(reload)
		
		
func reload():
	avail = true
	capacity = 10
