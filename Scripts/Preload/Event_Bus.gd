extends Node
#Main bus that handles signal communication between instantiated enemies and persistent scenes.


signal on_enemy_kill(xp_value) #Handles enemy kill event to add for ui manager.

signal on_level_up(new_level) #Handles level up logic between ui manager and game manager.

signal game_over() #Handles everything related to ending the current run both ui and game logic.

signal victory()

signal on_selected_upgrade(upgradeID)
signal reset_upgrades()
signal refresh_upgrades(upgradeLevels)
