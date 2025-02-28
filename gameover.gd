extends CanvasLayer



func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Player/Test.tscn")
