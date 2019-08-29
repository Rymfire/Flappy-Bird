# Project: Flappy Bird
# Script: Ground.gd
# Associated to: Ground.tcsn
# Description: Defines Ground prefab behaviour

extends StaticBody2D

signal ground_destroyed

onready var MainCamera = Utils.get_main_node().get_node("Camera2D")

# _ready() will be called as soon as Ground is set in a scene.
func _ready():
	print("_scene Ground >> _ready")
	pass

# _process(delta) will be called at each frames.
# _process will handle Ground deinstanciation when ou out camera view
func _process(delta):
	if MainCamera == null:
		return
	if $DestroyPosition.get_global_position().x <= MainCamera.get_position_with_offset().x:
		queue_free()
		emit_signal("ground_destroyed")
		print("_scene Ground >> _process >> emit_signal \"destroyed\"")