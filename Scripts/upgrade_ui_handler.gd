extends Control

@onready var upgrade_1_name: Label = $"Upgrade 1/Upgrade 1 name"
@onready var upgrade_1_description: Label = $"Upgrade 1/Upgrade 1 description"
@onready var upgrade_1_sprite: TextureRect = $"Upgrade 1/Upgrade 1 Sprite"

@onready var upgrade_2_name: Label = $"Upgrade 2/Upgrade 2 name"
@onready var upgrade_2_description: Label = $"Upgrade 2/Upgrade 2 description"
@onready var upgrade_2_sprite: TextureRect = $"Upgrade 2/Upgrade 2 Sprite"

@onready var upgrade_3_name: Label = $"Upgrade 3/Upgrade 3 name"
@onready var upgrade_3_description: Label = $"Upgrade 3/Upgrade 3 description"
@onready var upgrade_3_sprite: TextureRect = $"Upgrade 3/Upgrade 3 Sprite"

@onready var paused_rect: ColorRect = %PausedRect


var available_upgrades = []

var upgrade1ID
var upgrade2ID
var upgrade3ID

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.on_level_up.connect(on_level_up)

func on_level_up(level):
	initialize_upgrades()

func initialize_upgrades():
	available_upgrades.clear()
	for item in UpgradeLibrary.upgradesDict:
		if UpgradeLibrary.upgradesDict[item].Available == true:
			available_upgrades.append(item)
	upgrade1ID = null
	upgrade2ID = null
	upgrade3ID = null
	generate_upgrade1()
	generate_upgrade2()
	generate_upgrade3()
	visible = true
	paused_rect.visible = true
	Engine.time_scale = 0

func select_upgrade():
	var selected_upgrade = RngHandler.rng.randi_range(0, available_upgrades.size() - 1)
	for item in UpgradeLibrary.upgradesDict:
		if item == available_upgrades[selected_upgrade]:
			available_upgrades.remove_at(selected_upgrade)
			return item

func generate_upgrade1():
	var selected_upgrade = select_upgrade()
	upgrade_1_name.text = UpgradeLibrary.upgradesDict[selected_upgrade].Name
	upgrade_1_description.text = UpgradeLibrary.upgradesDict[selected_upgrade].Description
	upgrade1ID = UpgradeLibrary.upgradesDict[selected_upgrade]

func generate_upgrade2():
	var selected_upgrade = select_upgrade()
	upgrade_2_name.text = UpgradeLibrary.upgradesDict[selected_upgrade].Name
	upgrade_2_description.text = UpgradeLibrary.upgradesDict[selected_upgrade].Description
	upgrade2ID = UpgradeLibrary.upgradesDict[selected_upgrade]

func generate_upgrade3():
	var selected_upgrade = select_upgrade()
	upgrade_3_name.text = UpgradeLibrary.upgradesDict[selected_upgrade].Name
	upgrade_3_description.text = UpgradeLibrary.upgradesDict[selected_upgrade].Description
	upgrade3ID = UpgradeLibrary.upgradesDict[selected_upgrade]

func _on_select_upgrade_1_pressed() -> void:
	EventBus.on_selected_upgrade.emit(upgrade1ID)
	visible = false
	paused_rect.visible = false
	Engine.time_scale = 1

func _on_select_upgrade_2_pressed() -> void:
	EventBus.on_selected_upgrade.emit(upgrade2ID)
	visible = false
	paused_rect.visible = false
	Engine.time_scale = 1

func _on_select_upgrade_3_pressed() -> void:
	EventBus.on_selected_upgrade.emit(upgrade3ID)
	visible = false
	paused_rect.visible = false
	Engine.time_scale = 1
