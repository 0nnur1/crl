extends Node

var current_user: String = "UserName" 
var current_dir: String = "~"
var pc_name: String = "GameName"

# You can even make a helper to get the full prefix string
func get_prefix() -> String:
	return current_user + "@" + pc_name + ":" + current_dir + "$"
