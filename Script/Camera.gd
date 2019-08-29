# Project: Flappy Bird
# Script: Camera.gd
# Associated to: Game.tcsn
# Description: Defines main camera's behaviour

extends Camera2D

# Variables:
# When Bird instance is _ready(), local bird will be created
# Script will look for Bird under '/Game/*Bird' game's tree
onready var bird = Utils.get_main_node().get_node("Bird")

# _ready() will be called as soon as Camera is set in a scene.
func _ready():
	print("_scene Game >> Camera _ready")

# _physics_process() will be called at each frames and will handle Camera-related computing.
func _physics_process(delta):
	self.set_position(Vector2(bird.get_position().x, self.get_position().y))

# get_position_with_offset() will return the exact position of the camera including the offset
func get_position_with_offset():
	return self.get_position() + self.get_offset()
