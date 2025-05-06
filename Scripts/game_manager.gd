extends Node2D

@onready var base_enemy = load("res://Scenes/Base_Enemy_Object.tscn")

@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var marker_2d: Marker2D = $Path2D/PathFollow2D/Marker2D

@onready var enemy_spawn_timer: Timer = $EnemySpawnTimer

var difficulty_value: int

func _ready() -> void:
	if RngHandler.seed_input == "":
		RngHandler.random_seed()
	elif RngHandler.seed_input != "":
		RngHandler.change_seed(RngHandler.seed_input)
	EventBus.reset_upgrades.emit()
	PlayerstatLibrary.Initialize_Values()
	difficulty_value = 0

func _on_enemy_spawn_timer_timeout() -> void:
	path_follow_2d.progress_ratio = RngHandler.rng.randf_range(0,1)
	
	var instance = base_enemy.instantiate()
	instance.dir = global_rotation
	instance.max_health = 30 + (5 * difficulty_value)
	instance.global_position = marker_2d.global_position
	add_child.call_deferred(instance)

func _on_spawn_increase_timer_timeout() -> void:
	enemy_spawn_timer.wait_time /= 1.25
	difficulty_value += 1
