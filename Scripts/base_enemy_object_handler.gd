extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var health_bar: ProgressBar = $Health_Bar

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
	animated_sprite_2d.look_at(Vector2i(0,0))
	collision_shape_2d.look_at(Vector2i(0,0))

func Get_Damaged(damage):
	current_health -= damage
	health_bar.value -= damage
	
	if current_health <= 0:
		EventBus.on_enemy_kill.emit(XP)
		MetaprogressionHandler.frogcoin += 1
		queue_free()
