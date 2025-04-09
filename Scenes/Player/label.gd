extends Label

@onready var Player = %TestCat
@onready var Aimer = %TestCat/Aimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(is_instance_valid(Player)):
		var capacity2 = Aimer.capacity
		text = "Slime Charge = " + str(capacity2)
