extends Node

var damage
var firerate : float
var bulletspeed
var projectilescale : float
var mudBombProjectiles

var mudBombAngleDict = {0: 0, 1: 0.15, 2: -0.15, 3: 0.3, 4: -0.3,}
var mudBombProjectilePerLevel = [1, 1, 3, 3, 5]

var acidFlaskDuration
var acidFlaskSize
var acidFlaskDurationPerLevel = [15, 20, 25, 30, 45]
var acidFlaskSizePerLevel = [15, 20, 25, 30, 50]

var flamethrowerProjectilePerLevel = [1, 1, 3, 3, 5]

var mudBombActive = false
var acidFlaskActive = false
var flamethrowerActive = true

func _ready() -> void:
	Initialize_Values()
	EventBus.refresh_upgrades.connect(Update_Values)

func Initialize_Values():
	damage = 1.0  * MetaprogressionHandler.get_modifier("damagemodifier")
	firerate = 1.0
	bulletspeed = 1.0
	projectilescale = 1
	mudBombProjectiles = 1

func Update_Values(upgrade_levels):
	firerate = 1.0 + (0.1 * upgrade_levels[0])
	bulletspeed = 1.0 + (0.5 * upgrade_levels[1])
	damage = (1.0 + (0.25 * upgrade_levels[2])) * MetaprogressionHandler.get_modifier("damagemodifier")
	mudBombProjectiles = mudBombProjectilePerLevel[upgrade_levels[3]]
	acidFlaskDuration = acidFlaskDurationPerLevel[upgrade_levels[4]]
	acidFlaskSize = acidFlaskSizePerLevel[upgrade_levels[4]]
	
	if upgrade_levels[3] >= 1:
		mudBombActive = true
	if upgrade_levels[4] >= 1:
		acidFlaskActive = true
	if upgrade_levels[5] >= 1:
		flamethrowerActive = true
