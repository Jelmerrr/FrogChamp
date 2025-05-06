extends CharacterBody2D

@onready var main = get_tree().get_root().get_node("Game_Space")
@onready var base_projectile = load("res://Scenes/Base_Projectile.tscn")
@onready var shoot_timer: Timer = $ShootTimer

var health : int = 50

func _physics_process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	rotation_degrees += 90
	shoot_timer.wait_time = PlayerstatLibrary.firerate

func shoot(angleoffset):
	var instance = base_projectile.instantiate()
	instance.dir = global_rotation + angleoffset
	instance.spawnPos = global_position
	instance.spawnRot = global_rotation + angleoffset
	instance.zdex = z_index - 2
	instance.projectile_damage = PlayerstatLibrary.damage
	main.add_child.call_deferred(instance)

func _on_timer_timeout() -> void:
	for projectiles in PlayerstatLibrary.mudBombProjectiles:
		shoot(PlayerstatLibrary.mudBombAngleDict[projectiles])
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()
	health -= body.DAMAGE
	if(health <= 0):
		EventBus.game_over.emit()
