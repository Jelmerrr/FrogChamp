extends Node2D
#WARNING FOR JELMER: ONLY TOUCH THIS SCRIPT IF IT'S IS ABSOLUTELY NEEDED.
#IT WILL ALMOST CERTAINLY BREAK OLDER SAVES IF NOT DONE CAREFULLY.

var account_name = "test"

var SAVE_DIR = "user://saves/"
var FILE_NAME = account_name + ".json"
const FILE_KEY = "HELLOTHERE" #You shouldn't be here.

func _ready(): 
	verify_directory(SAVE_DIR) #Make sure the save directory exists.

func verify_directory(path):
	DirAccess.make_dir_absolute(path) #Make sure there's access to the path.

func save_data(path):
	var file = FileAccess.open_encrypted_with_pass(path, FileAccess.WRITE, FILE_KEY) #Access writing to file.
	if file == null: #If file is unable to be accessed return an error.
		print(FileAccess.get_open_error())
		return
	var data = { #Data being saved, when adding new data double check that it is also loaded.
		"VersionFormat": current_version,
		"Player_data":{
			"FrogCoins": MetaprogressionHandler.frogcoin,
			"FrogPoints": MetaprogressionHandler.frogpoints,
			"Upgrades": MetaprogressionHandler.metaupgradesdict
		}
	}
	var json_string = JSON.stringify(data, "\t") #Parses data to JSON.
	file.store_string(json_string) #Writes JSON to file.
	file.close() #Closes access to file.

func load_data(path):
	if FileAccess.file_exists(path): #If there's a save file at designated path.
		var file = FileAccess.open_encrypted_with_pass(path, FileAccess.READ, FILE_KEY) #Acces reading file.
		if file == null: #If file is unable to be accessed return an error.
			print(FileAccess.get_open_error())
			return
		var content = file.get_as_text() #Get content of file.
		file.close() #Close access to file.
		var data = JSON.parse_string(content) #Parse JSON to string.
		if data == null: #If there's no data return an error.
			print("Parsing data has failed")
			return
		
		#This is all the data that is being stored, when adding new data types list them here.
		if data.VersionFormat == current_version:
			MetaprogressionHandler.frogcoin = data.Player_data.FrogCoins
			MetaprogressionHandler.frogpoints = data.Player_data.FrogPoints
			for item in data.Player_data.Upgrades: #This should be backwards compatible with new upgrades.
				MetaprogressionHandler.metaupgradesdict[item].level = int(data.Player_data.Upgrades[item].level)
		elif data.VersionFormat != current_version: #Don't load the save file if a mismatch is detected for now.
			print("Version mismatch detected! Stopped loading save file to prevent any issues.")

@export var current_version = "0.0.1" #Current version of the save file.
#TODO: Add backwards compatibility.
