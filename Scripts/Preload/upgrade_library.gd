extends Node

enum upgradeTypes {Item, Weapon}

var upgradeLevels = []

var upgradesDict = {
	"FireRate": {"ID": 0, "Available": true, "Type": upgradeTypes.Item, "Name": "FireRate", "Description": "Increases fire rate"},
	"BulletSpeed": {"ID": 1, "Available": true, "Type": upgradeTypes.Item, "Name": "BulletSpeed", "Description": "Increases bullet speed"},
	"Damage": {"ID": 2, "Available": true, "Type": upgradeTypes.Item, "Name": "Damage", "Description": "Increases damage"},
	"MudBomb": {"ID": 3, "Available": true, "Type": upgradeTypes.Weapon, "Name": "Mud Bomb", "Description": "Splosssjjj"},
}

func _ready() -> void:
	EventBus.on_selected_upgrade.connect(Picked_Upgrade_handler)
	EventBus.reset_upgrades.connect(Reset_Upgrades)
	Reset_Upgrades()

func Picked_Upgrade_handler(upgrade):
	if upgrade.Type == upgradeTypes.Item:
		upgradeLevels[upgrade.ID] += 1
	elif upgrade.Type == upgradeTypes.Weapon && upgradeLevels[upgrade.ID] <= 3:
		upgradeLevels[upgrade.ID] += 1
		if upgradeLevels[upgrade.ID] == 4:
			upgrade.Available = false
	EventBus.refresh_upgrades.emit(upgradeLevels)

func Reset_Upgrades():
	upgradeLevels.clear()
	for item in upgradesDict:
		upgradeLevels.append(0)
	EventBus.refresh_upgrades.emit(upgradeLevels)
