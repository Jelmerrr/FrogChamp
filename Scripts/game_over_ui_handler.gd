extends Control

@onready var game_over_timer: Timer = $Game_over_timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.game_over.connect(start_game_over)

func start_game_over():
	game_over_timer.start()
	Engine.time_scale = 0
	visible = true

func _on_game_over_timer_timeout() -> void:
	Engine.time_scale = 1
	SceneHandler.switch_scene(SceneHandler.main_menu_path)
