extends Node2D

var sps := 25.0
var st := 0.0
var sps2 := 12
var st2 := 0.0
var sps3 := 5
var st3 := 0.0
var sps4 := 12
var st4 := 0.0
var capacity = 10.0
var avail = true

@onready var scene = load("res://Scenes/Player/TestProjectile.tscn")
@onready var scene2 = load("res://Scenes/Player/test_projectile_2.tscn")
@onready var scene3 = load("res://Scenes/Player/slime_spill.tscn")
@onready var scene4 = load("res://Scenes/Player/catapult.tscn")

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
		var Primary = scene.instantiate()
		
		get_tree().get_root().get_node("Test").add_child(Primary)
		var player = $"."
		Primary.global_position = player.global_position
		Primary.global_rotation = player.global_rotation + (5 * PI)
		$"../AudioStreamPlayer2D".play()
		
		capacity = capacity - 1
		st = 0
	st2 += delta
	var ste2 := st2>(4/sps2)
	if Input.is_action_pressed("Secondary Pew") and ste and avail and can_attack.can_attack:
		var Secondary = scene2.instantiate()
		
		get_tree().get_root().get_node("Test").add_child(Secondary)
		var player = $"."
		Secondary.global_position = player.global_position
		Secondary.global_rotation = player.global_rotation + (5 * PI)
		$"../AudioStreamPlayer2D".play()
		
		capacity = capacity - 2
		st = 0
	st3 += delta
	var ste3 := st3>(4/sps3)
	if Input.is_action_pressed("SlimeSpill") and ste and avail and can_attack.can_attack:
		var SlimeSpill = scene3.instantiate()
		
		get_tree().get_root().get_node("Test").add_child(SlimeSpill)
		var player = $"."
		SlimeSpill.global_position = player.global_position
		SlimeSpill.z_index = -1
		
		capacity = capacity - 5
		st = 0
	st4 += delta
	var ste4 := st4>(4/sps4)
	if Input.is_action_pressed("catapult") and ste and avail and can_attack.can_attack:
		var catapult = scene4.instantiate()
		
		get_tree().get_root().get_node("Test").add_child(catapult)
		var player = $"."
		catapult.global_position = player.global_position
		catapult.global_rotation = player.global_rotation + (5 * PI)
		$"../AudioStreamPlayer2D".play()
		
		capacity = capacity - 8
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
