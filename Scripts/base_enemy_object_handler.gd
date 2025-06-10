extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var health_bar: ProgressBar = $Health_Bar
@onready var damage_timer: Timer = $"Damage timer"


var SPEED : int = 10
var max_health : int = 30
var ARMOR : int = 0
var XP : int = 30
var DAMAGE : int = 10

var current_health : int

var dir : float
var spawnPos : Vector2

func _ready() -> void:
	current_health = max_health
	health_bar.max_value = max_health
	health_bar.value = max_health

func _physics_process(_delta: float) -> void:
	velocity = global_position.direction_to(Vector2(0,0)) * SPEED
	move_and_slide()
	sprite.look_at(Vector2i(0,0))
	collision_shape_2d.look_at(Vector2i(0,0))

func Get_Damaged(damage):
	current_health -= damage
	health_bar.value -= damage
	flash()
	
	if current_health <= 0:
		EventBus.on_enemy_kill.emit(XP)
		MetaprogressionHandler.frogcoin += 1
		queue_free()

func flash():
	sprite.material.set_shader_parameter("flash_modifier", 1)
	damage_timer.start()

func _on_damage_timer_timeout() -> void:
	sprite.material.set_shader_parameter("flash_modifier", 0)
