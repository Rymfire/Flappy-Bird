# Project: Flappy Bird
# Script: SpawnerPipe.gd
# Associated to: SpawnerPipe.tcsn
# Description: Defines pipe spawner behaviour

extends Node2D

# constants
const scn_pipe = preload("res://Scene/Pipe.tscn")
const GROUND_HEIGHT = 56
const PIPE_WIDTH = 26
const OFFSET_X = 65
const OFFSET_Y = 55
const AMOUNT_TO_FILL_VIEW = 3
const SAFE_ZONE = 100

# variables
onready var bird_ = Utils.get_main_node().get_node("Bird")

# _ready() will be called as soon as SpawnerPipe is set in a scene.
func _ready():
	print("SpawnerPipe >> _ready")
	if bird_:
		bird_.connect("state_changed", self, "_on_bird_state_changed", [], CONNECT_ONESHOT)
		print("SpawnerPipe >> signal \"state_changed\" connected")
	else:
		print("SpawnerPipe >> bird_ null")

# _on_bird_state_changed() will be called when Bird's state is changed
# if this new state is flapping then we can start showing the pipes
func _on_bird_state_changed(state):
	print("SpawnerPipe >> _on_bird_state_changed >> \"state_changed\" detected")
	if state == bird_.STATE.FLAPPING:
		start()

# start() spawns the AMOUNT_TO_FILL_VIEW very firsts pipes in the game scene
func start():
	set_spawner_init_position()
	for it in range(AMOUNT_TO_FILL_VIEW):
		spawn_then_move()

# set_spawner_init_position() will set the spawner position before starting to spawn pipes
func set_spawner_init_position():
	var init_pos = Vector2()
	var camera = Utils.get_main_node().get_node("Camera2D")

	randomize()
	init_pos.x = get_viewport_rect().size.x + PIPE_WIDTH / 2 + SAFE_ZONE
	init_pos.y = rand_range(0 + OFFSET_Y, get_viewport_rect().size.y - GROUND_HEIGHT - OFFSET_Y)
	if camera:
		init_pos.x += camera.get_position_with_offset().x
	self.set_position(init_pos)

# spawn_then_move() will chain spawn ft with move ft
func spawn_then_move():
	spawn_pipe()
	go_next_spawn_location()

# spawn_pipe() will instanciate (/spawn) a new Pipe
func spawn_pipe():
	var new_pipe = scn_pipe.instance()

	new_pipe.set_position(self.get_position())
	new_pipe.connect("pipe_destroyed", self, "spawn_then_move")
	self.get_node("Container").add_child(new_pipe)

# go_next_spawn_location() will make move the spawner to the next spawn location
func go_next_spawn_location():
	var next_pos = self.get_position()
	next_pos.x += PIPE_WIDTH / 2 + OFFSET_X + PIPE_WIDTH / 2
	next_pos.y = rand_range(0 + OFFSET_Y, get_viewport_rect().size.y - GROUND_HEIGHT - OFFSET_Y)
	self.set_position(next_pos)
