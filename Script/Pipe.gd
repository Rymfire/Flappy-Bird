# Project: Flappy Bird
# Script: Pipe.gd
# Associated to: Pipe.tcsn
# Description: Defines Pipe prefab behaviour

extends StaticBody2D

# Signal will be send as the ground is destroyed
signal pipe_destroyed

# Gets the Main camera as soon as it is ready to use
onready var MainCamera = Utils.get_main_node().get_node("Camera2D")

# _ready() will be called as soon as Pipe is set in a scene
func _ready():
	print("Pipe >> _ready")
	self.add_to_group(Group.PIPES)

func _process(delta):
	if MainCamera == null:
		return
	if $DestroyPosition.get_global_position().x <= MainCamera.get_position_with_offset().x:
		queue_free()
		emit_signal("pipe_destroyed")
		print("Pipe >> _process >> \"pipe_destryed\" emitted")