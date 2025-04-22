extends Node2D

@onready var ripple_drip = $AnimatedSprite2D
@onready var ripple_pool = $RippleRipples
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	can_attack.can_attack = false
	ripple_drip.play("default")
	ripple_pool.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
