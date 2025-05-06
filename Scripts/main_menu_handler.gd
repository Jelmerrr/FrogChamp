extends Control

func _ready() -> void:
	SaveGameHandler.load_data(SaveGameHandler.SAVE_DIR + SaveGameHandler.FILE_NAME)

func _on_start_game_pressed() -> void:
	SceneHandler.switch_scene(SceneHandler.game_scene_path)

func _on_quit_game_pressed() -> void:
	SaveGameHandler.save_data(SaveGameHandler.SAVE_DIR + SaveGameHandler.FILE_NAME)
	get_tree().quit()

func _on_upgrades_pressed() -> void:
	SceneHandler.switch_scene(SceneHandler.meta_upgrade_path)
