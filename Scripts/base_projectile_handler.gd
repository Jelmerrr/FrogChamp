extends CharacterBody2D

var dir : float
var spawnPos : Vector2
var spawnRot : float
var zdex : int
var projectile_damage : int

func _ready():
	global_position = spawnPos
	global_rotation = spawnRot
	z_index = zdex

func _physics_process(_delta: float) -> void:
	scale = Vector2(PlayerstatLibrary.projectilescale, PlayerstatLibrary.projectilescale) 
	velocity = Vector2(0, -PlayerstatLibrary.bulletspeed).rotated(dir)
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.Get_Damaged(projectile_damage)
	queue_free()

func _on_life_timer_timeout() -> void:
	queue_free()
