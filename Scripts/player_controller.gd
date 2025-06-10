extends CharacterBody2D

@onready var main = get_tree().get_root().get_node("Game_Space")

@onready var base_projectile = load("res://Scenes/Base_Projectile.tscn")
@onready var acid_flask = load("res://Scenes/Acid_Flask_Projectile.tscn")
@onready var flamethrower = load("res://Scenes/Flamethrower_Projectile.tscn")

@onready var mud_bomb_timer: Timer = $"Attack Timers/Mud Bomb Timer"
@onready var acid_flask_timer: Timer = $"Attack Timers/Acid Flask Timer"
@onready var flamethrower_timer: Timer = $"Attack Timers/Flamethrower Timer"
@onready var flames_duration_timer: Timer = $"Attack Timers/Flamethrower Timer/Flames Duration Timer"
@onready var spawn_flames_timer: Timer = $"Attack Timers/Flamethrower Timer/Spawn Flames Timer"


var health : int = 50
var flamesActive = false

func _ready() -> void:
	EventBus.refresh_upgrades.connect(Update_Timers)

func _physics_process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	rotation_degrees += 90
	mud_bomb_timer.wait_time = PlayerstatLibrary.firerate
	
	if PlayerstatLibrary.acidFlaskActive == true && acid_flask_timer.is_stopped() == true:
		acid_flask_timer.start()
	elif PlayerstatLibrary.acidFlaskActive == false:
		acid_flask_timer.stop()
	
	if PlayerstatLibrary.mudBombActive == true && mud_bomb_timer.is_stopped() == true:
		mud_bomb_timer.start()
	elif PlayerstatLibrary.mudBombActive == false:
		mud_bomb_timer.stop()
	
	if PlayerstatLibrary.flamethrowerActive == true && flamethrower_timer.is_stopped() == true:
		flamethrower_timer.start()
	elif PlayerstatLibrary.flamethrowerActive == false:
		flamethrower_timer.stop()

func Update_Timers(_upgrade_levels):
	mud_bomb_timer.wait_time =  mud_bomb_timer.wait_time / PlayerstatLibrary.firerate
	acid_flask_timer.wait_time = acid_flask_timer.wait_time / PlayerstatLibrary.firerate


func shoot(angleoffset, attack):
	var instance = attack.instantiate()
	instance.dir = global_rotation + angleoffset
	instance.spawnPos = global_position
	instance.spawnRot = global_rotation + angleoffset
	instance.zdex = z_index - 2
	instance.projectile_damage = instance.projectile_damage * PlayerstatLibrary.damage
	instance.bullet_speed = instance.bullet_speed * PlayerstatLibrary.bulletspeed
	main.add_child.call_deferred(instance)

func _on_timer_timeout() -> void:
	for projectiles in PlayerstatLibrary.mudBombProjectiles:
		shoot(PlayerstatLibrary.mudBombAngleDict[projectiles], base_projectile)



func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()
	health -= body.DAMAGE
	if(health <= 0):
		EventBus.game_over.emit()


func _on_acid_flask_timer_timeout() -> void:
	shoot(0, acid_flask)


func _on_flamethrower_timer_timeout() -> void:
	if flamesActive == false && flames_duration_timer.is_stopped() == true:
		flamesActive = true
	if flames_duration_timer.is_stopped() == true:
		flames_duration_timer.start()

func _on_spawn_flames_timer_timeout() -> void:
	if flamesActive == true:
		shoot(0, flamethrower)

func _on_flames_duration_timer_timeout() -> void:
	flamesActive = false
	flamethrower_timer.start()
