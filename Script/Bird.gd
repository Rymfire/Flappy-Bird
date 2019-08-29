# Project: Flappy Bird
# Script: Bird.gd
# Associated to: Bird.tcsn
# Description: Defines the bird's behaviour (physics, collision, animation, ...)

extends RigidBody2D

# state_ is an attribute that will contain the current state of Bird
onready var state_ = FlyingState.new(self)
const SPEED = 50
# state enum
const STATE_FLYING = 0
const STATE_FLAPPING = 1
const STATE_HIT = 2
const STATE_GROUNDED = 3

# _ready() will be called as soon as Bird is set in a scene.
func _ready():
	pass

# _physics_process() will be called at each frames and will handle Bird-related computing.
func _physics_process(delta):
	state_.update(delta)

# _input() will be called to handle all input related to Bird.
func _input(event):
	state_.input(event)

func set_state(new_state):
	state_.exit()
	if new_state == STATE_FLYING:
		state_ = FlyingState.new(self)
	elif new_state == STATE_FLAPPING:
		state_ = FlappingState.new(self)
	elif new_state == STATE_HIT:
		state_ = HitState.new(self)
	elif new_state == STATE_GROUNDED:
		state_ = GroundedState.new(self)

func get_state():
	if state_ is FlyingState:
		return STATE_FLYING
	elif state_ is FlyingState:
		return STATE_FLYING
	elif state_ is FlyingState:
		return STATE_FLYING
	elif state_ is FlyingState:
		return STATE_FLYING

# Class FlyingState -------------------------------------------------------------
# Will define the Flying state of the player
class FlyingState:
	
	var bird_
	var prev_gravity_

	#_init() is called when an object of this class is created.
	func _init(bird):
		bird_ = bird

		bird_.get_node("AnimationPlayer").play("Flying")
		bird_.get_node("AnimationPlayer").get_animation("Flying").set_loop(true)
		bird_.set_linear_velocity(Vector2(bird_.SPEED, bird_.get_linear_velocity().y))
		prev_gravity_ = bird_.get_gravity_scale()
		bird_.set_gravity_scale(0)

	# update() is called for all frame by frame actions
	func update(delta):
		pass

	# input() handles all player input 
	func input(event):
		pass

	# exit() is called before changing state
	func exit():
		bird_.set_gravity_scale(prev_gravity_)

# Class FlappingState ------------------------------------------------------------
# Will define the Flapping state of the player
class FlappingState:

	var bird_

	# _init() is called when an object of this class is created.
	# bird_ will be ordered to move to the right without any damp.
	func _init(bird):
		bird_ = bird

		bird_.set_linear_velocity(Vector2(bird_.SPEED, bird_.get_linear_velocity().y))
		bird_.set_linear_damp(0)

	# update() is called for all frame by frame actions
	# update() handles the jump animation (rotation and velocity)
	func update(delta):
		if rad2deg(bird_.get_rotation()) < -30:
			bird_.set_rotation(deg2rad(-30))
			bird_.set_angular_velocity(0)
		if bird_.get_linear_velocity().y > 0:
			bird_.set_angular_velocity(1.5)

	# jump() will be called each time bird_jump is catched to make Bird jump.
	# jump() will apply a new force replacing the previous one to make Bird go up.
	# Then, Bird will start rotating upward. Bird rotating is handled in
	# update() method.
	func jump():
		bird_.set_linear_velocity(Vector2(bird_.get_linear_velocity().x, -150))
		bird_.set_angular_velocity(-3)
		bird_.get_node("AnimationPlayer").play("Flap")

	# input() handles all player input during flapping state (bird_jump action)
	func input(event):
		if event.is_action_pressed("bird_jump"):
			jump()

	# exit() is called before changing state
	func exit():
		pass

# Class HitState -----------------------------------------------------------
# Will define the Hit state of the player
class HitState:
	
	var bird_
	
	#_init() is called when an object of this class is created.
	func _init(bird):
		bird_ = bird
		pass

	# update() is called for all frame by frame actions
	func update(delta):
		pass

	# input() handles all player input 
	func input(event):
		pass

	# exit() is called before changing state
	func exit():
		pass

# Class GroundedState -----------------------------------------------------------
# Will define the Grounded state of the player
class GroundedState:

	var bird_

	#_init() is called when an object of this class is created.
	func _init(bird):
		bird_ = bird
		pass

	# update() is called for all frame by frame actions
	func update(delta):
		pass

	# input() handles all player input 
	func input(event):
		pass

	# exit() is called before changing state
	func exit():
		pass
