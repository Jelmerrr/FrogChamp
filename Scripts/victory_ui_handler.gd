extends Control

@onready var restart_timer: Timer = $restart_timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.victory.connect(start_victory)

func start_victory():
	restart_timer.start()
	Engine.time_scale = 0
	visible = true

func _on_restart_timer_timeout() -> void:
	Engine.time_scale = 1
	SceneHandler.switch_scene(SceneHandler.main_menu_path)
