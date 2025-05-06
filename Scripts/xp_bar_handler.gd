extends Control

@onready var xp_bar: ProgressBar = $"Xp Bar"

var level = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.on_enemy_kill.connect(Update_Xp)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if xp_bar.value == xp_bar.max_value:
		xp_bar.value = 0
		level += 1
		EventBus.on_level_up.emit(level)
		xp_bar.max_value = 100 * pow(level, 1.8) #+ pow(2 * level, 3.14)

func Update_Xp(_xp):
	xp_bar.value += _xp * MetaprogressionHandler.get_modifier("xpmodifier")
