extends Area2D

@export var dialogic_timeline := "nova_bond1"
var player_in_range := false
func _ready():
	print("Area2d ready!")
	connect("body_entered", _on_body_entered)
	connect ("body_exited", _on_body_exited)
	print("CollisionShape Enabled", $CollisionShape2D.disabled)
	print("Monitoring", monitoring)
func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		print("Dialogue should work at this point!")
		Dialogic.start(dialogic_timeline)

func _on_body_entered(body):
	print("Entered by", body.name)
	if body.is_in_group("Friends"):
		print("Player has entered area!")
		player_in_range = true

func _on_body_exited(body):
	if body.is_in_group("Friends"):
		print("Player has left area")
		player_in_range = false
