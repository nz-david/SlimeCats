extends Area2D

@export var dialogic_timeline := "aaa_for_testing"
var player_in_range := false
func _ready():
	print("Area2D ready!")
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	print("CollisionShape Enabled", $CollisionShape2D.disabled)
	print("monitoring", monitoring)

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		print("Dialogue should work at this point!")
		Dialogic.start(dialogic_timeline)

func _on_body_entered(body):
	if body.is_in_group("Friends"):
		print("Entered by", body.name)
		player_in_range = true

func _on_body_exited(body): 
	if body.is_in_group("Friends"):
		print ("player has left area")
		player_in_range = false
