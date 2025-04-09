extends Label

@onready var Main = get_tree().current_scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(is_instance_valid(Main)) and Plswork.can_attack:
		var wave = Main.wave
		text = "Wave " + str(wave)
