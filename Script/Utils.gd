# Project: Flappy Bird
# Script: Utils.gd
# Associated to: Utils.tcsn
# Description: Defines some utility fonctions

extends Node

# _ready() will be called as soon as Utils is set in a scene.
func _ready():
	pass

# get_main_node() returns the last node from root which correspong to the caller's main node
func get_main_node():
	var root_node = self.get_tree().get_root()
	return root_node.get_child(root_node.get_child_count() - 1)