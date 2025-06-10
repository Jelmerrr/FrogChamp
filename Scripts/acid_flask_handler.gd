extends CharacterBody2D

@onready var area_2d: Area2D = $Area2D
@onready var life_timer: Timer = $"Life Timer"
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var mesh_instance_2d: MeshInstance2D = $CollisionShape2D/MeshInstance2D
@onready var sprite_2d: Sprite2D = $Sprite2D

var dir : float
var spawnPos : Vector2
var spawnRot : float
var zdex : int
var projectile_damage : int = 7
var bullet_speed : int = 100
var arrivedAtLocation = false

var end_position

func _ready():
	end_position = get_global_mouse_position()
	global_position = spawnPos
	global_rotation = spawnRot
	z_index = zdex
	collision_shape_2d.shape.radius = PlayerstatLibrary.acidFlaskSize
	mesh_instance_2d.scale.x = PlayerstatLibrary.acidFlaskSize * 2
	mesh_instance_2d.scale.y = PlayerstatLibrary.acidFlaskSize * 2
	mesh_instance_2d.modulate = Color(0.2, 1, 0.3, 0.3)
	life_timer.wait_time = PlayerstatLibrary.acidFlaskDuration
	life_timer.start()

func _physics_process(_delta: float) -> void:
	if arrivedAtLocation == false:
		velocity = global_position.direction_to(end_position) * bullet_speed
		global_rotation += -0.1
		move_and_slide()
	if int(global_position.x) >= int(end_position.x)-1 && int(global_position.x) <= int(end_position.x)+1 && int(global_position.y) >= int(end_position.y)-1 && int(global_position.y) <= int(end_position.y)+1:
		arrivedAtLocation = true
		mesh_instance_2d.visible = true
		sprite_2d.visible = false

func _on_life_timer_timeout() -> void:
	queue_free()

func _on_damage_tick_timer_timeout() -> void:
	if arrivedAtLocation == true:
		for body in area_2d.get_overlapping_bodies():
			body.Get_Damaged(projectile_damage)
