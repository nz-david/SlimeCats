extends Node2D

var sps := 25.0
var st := 0.0
var sps2 := 12.5
var st2 := 0.0
var sps3 := 12.5
var st3 := 0.0
var capacity = 10.0
var avail = true

@onready var scene = load("res://Scenes/Player/TestProjectile.tscn")
@onready var scene2 = load("res://Scenes/Player/test_projectile_2.tscn")
@onready var scene3 = load("res://Scenes/Player/slime_spill.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	rotate(PI/2)
	st += delta
	var ste := st>(4/sps)
	if Input.is_action_pressed("pew") and ste and avail and can_attack.can_attack:
		var TestProjectile = scene.instantiate()
		
		get_tree().get_root().get_node("Test").add_child(TestProjectile)
		var player = $"."
		TestProjectile.global_position = player.global_position
		TestProjectile.global_rotation = player.global_rotation + (5 * PI)
		$"../AudioStreamPlayer2D".play()
		
		capacity = capacity - 1
		st = 0
	st2 += delta
	var ste2 := st2>(4/sps2)
	if Input.is_action_pressed("Secondary Pew") and ste and avail and can_attack.can_attack:
		var TestProjectile2 = scene2.instantiate()
		
		get_tree().get_root().get_node("Test").add_child(TestProjectile2)
		var player = $"."
		TestProjectile2.global_position = player.global_position
		TestProjectile2.global_rotation = player.global_rotation + (5 * PI)
		$"../AudioStreamPlayer2D".play()
		
		capacity = capacity - 2
		st = 0
	st3 += delta
	var ste3 := st3>(4/sps3)
	if Input.is_action_pressed("SlimeSpill") and ste and avail and can_attack.can_attack:
		var TestProjectile3 = scene3.instantiate()
		
		get_tree().get_root().get_node("Test").add_child(TestProjectile3)
		var player = $"."
		TestProjectile3.global_position = player.global_position
		
		capacity = capacity - 5
		st = 0
	if((capacity <= 0) and avail):
		avail = false
		get_tree().create_timer(3).timeout.connect(reload)
		
	if Input.is_action_pressed("reload"):
		capacity = 0
		avail = false
		get_tree().create_timer(3).timeout.connect(reload)

		

		
func reload():
	avail = true
	capacity = 10
