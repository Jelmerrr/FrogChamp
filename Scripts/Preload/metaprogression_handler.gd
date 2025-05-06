extends Node2D

var frogcoin:int = 0
var frogpoints:int = 0

var metaupgradesdict = {
	"xpmodifier": {
		"level": 0, 
		"value": {0: 1, 1: 2, 2: 3, 3: 4, 4: 5, 5: 6}},
	"damagemodifier": {
		"level": 0, 
		"value": {0: 1, 1: 1.25, 2: 1.5, 3: 1.75, 4: 2, 5: 2.5}},
}

func _physics_process(_delta: float) -> void:
	get_frog_point()

func get_frog_point(): #PLACEHOLDER UNTILL BETTER SYSTEM IS BUILT
	if frogcoin >= 100:
		frogpoints +=1
		frogcoin -= 100

func buy_modifier(modifier):
	if metaupgradesdict[modifier].level == 5:
		pass
	elif frogpoints >= 1:
		frogpoints -= 1
		metaupgradesdict[modifier].level +=1

func get_modifier(modifier):
	return metaupgradesdict[modifier].value[metaupgradesdict[modifier].level]
