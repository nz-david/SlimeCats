extends Label

@onready var Player = $"../CharacterBody2D/Aimer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(is_instance_valid(Player)):
		var capacity2 = $"../CharacterBody2D/Aimer".capacity
		text = str(capacity2)
