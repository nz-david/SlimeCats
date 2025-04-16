extends Camera2D
@onready var player = %TestCat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_instance_valid(player):
		var player_position = player.get_position()
		if position != player_position:
			set_position(player_position)
