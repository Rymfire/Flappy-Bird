# Project: Flappy Bird
# Script: SpawnerGround.gd
# Associated to: SpawnerGround.tcsn
# Description: Defines ground spawner behaviour

extends Node2D

# constant
const scn_ground = preload("res://Scene/Ground.tscn")
const GROUND_OFFSET = 256
const GROUND_WIDTH = 168
const AMOUNT_TO_FILL_VIEW = 2

# _ready() will be called as soon as SpawnerGround is set in a scene.
func _ready():
	print("SpawnerGround >> _ready")
	for it in range(AMOUNT_TO_FILL_VIEW):
		spawn_then_move()

# spawn_then_move() chains spawn ft with move ft
func spawn_then_move():
	spawn_ground()
	go_next_spawn_location()

# spawn_ground() will instanciate (/spawn) a new Ground
func spawn_ground():
	var new_ground = scn_ground.instance()
	new_ground.set_position(Vector2(self.get_position().x, GROUND_OFFSET))
	new_ground.connect("ground_destroyed", self, "spawn_then_move")
	self.get_node("Container").add_child(new_ground)

# go_next_spawn_location() will make move the spawner to the next spawn location
func go_next_spawn_location():
	self.set_position(self.get_position() + Vector2(GROUND_WIDTH, 0))
