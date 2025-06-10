extends CharacterBody2D

@onready var area_2d: Area2D = $Area2D
@onready var life_timer: Timer = $"Life Timer"
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

var dir : float
var spawnPos : Vector2
var spawnRot : float
var zdex : int
var projectile_damage : int = 4
var bullet_speed : int = 0

func _ready():
	global_position = spawnPos
	global_rotation = spawnRot
	z_index = zdex


func _on_life_timer_timeout() -> void:
	queue_free()

func _on_damage_tick_timer_timeout() -> void:
	for body in area_2d.get_overlapping_bodies():
		body.Get_Damaged(projectile_damage)
