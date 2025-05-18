extends Control

var just_toggled = false

@onready var resume_button = $PanelContainer/VBoxContainer/Resume

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	#visible = false
	get_tree().paused = false
	$AnimationPlayer.play("RESET")

func _unhandled_input(event: InputEvent) -> void:
	# Only respond to the exact escape key press, not releases or other actions
	if event.is_action_pressed("escape"):
		# Toggle pause state
		if get_tree().paused:
			resume()
		else:
			pause()
		
		get_viewport().set_input_as_handled()
		
		just_toggled = true


func _process(delta: float) -> void:
	if just_toggled:
		just_toggled = false

# unpauses the game
func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	# Wait for animation to finish before hiding and unpausing
	await $AnimationPlayer.animation_finished
	
	#visible = false
	
func pause():
	# Show menu before pausing
	#visible = true
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	# Set focus to the first button
	resume_button.grab_focus()  # Replace with your actual button name



func _on_resume_pressed() -> void:
	resume()


func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	get_tree().quit()
