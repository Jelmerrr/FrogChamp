extends Control

@onready var frog_coin_label: Label = $Panel/FrogCoinLabel

@onready var damage_upgrade: Button = $Panel/DamageUpgrade
@onready var xp_upgrade: Button = $Panel/XpUpgrade

func _ready() -> void:
	damage_upgrade.text = str(MetaprogressionHandler.metaupgradesdict.damagemodifier.level) + "/5"
	xp_upgrade.text = str(MetaprogressionHandler.metaupgradesdict.xpmodifier.level) + "/5"

func _physics_process(delta: float) -> void:
	frog_coin_label.text = "Frog Points: " + str(MetaprogressionHandler.frogpoints)

func _on_menu_button_pressed() -> void:
	SceneHandler.switch_scene(SceneHandler.main_menu_path)


func _on_debug_pressed() -> void:
	MetaprogressionHandler.frogcoin += 100


func _on_damage_upgrade_pressed() -> void:
	MetaprogressionHandler.buy_modifier("damagemodifier")
	damage_upgrade.text = str(MetaprogressionHandler.metaupgradesdict.damagemodifier.level) + "/5"
	SaveGameHandler.save_data(SaveGameHandler.SAVE_DIR + SaveGameHandler.FILE_NAME)


func _on_xp_upgrade_pressed() -> void:
	MetaprogressionHandler.buy_modifier("xpmodifier")
	xp_upgrade.text = str(MetaprogressionHandler.metaupgradesdict.xpmodifier.level) + "/5"
	SaveGameHandler.save_data(SaveGameHandler.SAVE_DIR + SaveGameHandler.FILE_NAME)
