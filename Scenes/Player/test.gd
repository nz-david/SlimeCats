extends Node2D

@export var set_bond_values := "set_initial_levels_check"

var enemydefeated = 0
var enemyammount = 10
var enemyexisting = 0
var ammountspawning = 10
var spawningspeed = 2
var wave = 1
@export var enemy_scene: PackedScene
@onready var timer = $Timer
@onready var den = $"%Den"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	can_attack.can_attack = true
	Dialogic.start(set_bond_values)
	wave_start()


# Called every frame. 'delta' is the elapsed time since the previous frame.

#Progresses to next wave after "4" enemies have been defeated
func _process(delta: float) -> void:
	if enemydefeated >= 5:
		enemydefeated = 0
		wave += 1
		wave_start()
	
	if Global.incoming == true and wave >= 10:
		Global.incoming = false
		den.open = true
	
func OnKilled():
	%SFX/EnemyKilledSFX.play()

func _on_timer_timeout() -> void:

	if Global.incoming:
		if(enemyammount > 0 and enemyexisting <= 4):
			# Create a new instance of the Mob scene.
			var mob = enemy_scene.instantiate()
			# Choose a random location on Path2D.
			var mob_spawn_location = $Path2D/PathFollow2D
			mob_spawn_location.progress_ratio = randf()
			# Set the mob's position to the random location.
			mob.position = mob_spawn_location.position
			# Spawn the mob by adding it to the Main scene.
			add_child(mob)
			enemyexisting += 1
			enemyammount -= 1
		else:
			timer.stop()
			#wave += 1
			get_tree().create_timer(5).timeout.connect(wave_start)


func wave_start():
	print("WAVE START: ", wave)
	ammountspawning = 10 + ((wave - 1) * 5)
	spawningspeed = 2 - (wave * 0.05)
	enemyammount += ammountspawning
	timer.set_wait_time(spawningspeed)
	timer.start()
	var songs = %Music.get_children()
	if wave == 1:
		for song in songs:
			song.stop()
		%Music/BattleAttackSong.play()
	elif wave == 4:
		for song in songs:
			song.stop()
		%Music/ItsHarderAloneButStillPossible.play()
	elif wave == 8:
		for song in songs:
			song.stop()
		%Music/SoThisIsIt.play()
		
