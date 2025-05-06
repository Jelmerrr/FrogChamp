extends Node

var damage
var firerate : float
var bulletspeed
var projectilescale : float
var mudBombProjectiles

var mudBombAngleDict = {0: 0, 1: 0.15, 2: -0.15, 3: 0.3, 4: -0.3,}
var mudBombProjectilePerLevel = [1, 1, 3, 3, 5]

func _ready() -> void:
	Initialize_Values()
	EventBus.refresh_upgrades.connect(Update_Values)

func Initialize_Values():
	damage = 10 * MetaprogressionHandler.get_modifier("damagemodifier")
	firerate = 1
	bulletspeed = 250
	projectilescale = 1
	mudBombProjectiles = 1

func Update_Values(upgrade_levels):
	firerate = 1.0 / (1.0 + (0.5 * upgrade_levels[0]))
	bulletspeed = 250 + (100 * upgrade_levels[1])
	damage = (10 + (5 * upgrade_levels[2])) * MetaprogressionHandler.get_modifier("damagemodifier")
	projectilescale = 1 + (0.25 * upgrade_levels[3])
	mudBombProjectiles = mudBombProjectilePerLevel[upgrade_levels[3]]
