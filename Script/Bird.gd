# Project: Flappy Bird
# Script: Bird.gd
# Associated to: Bird.tcsn
# Description: Defines the bird's behaviour (physics, collision, animation, ...)

extends RigidBody2D

# state_ is an attribute that will contain the current state of Bird
var state_ = FlappingState.new(self) # FlyingState.new(self)

# _ready() will be called as soon as Bird is set in a scene.
func _ready():
	pass

# _physics_process() will be called at each frames and will handle Bird-related computing.
func _physics_process(delta):
	state_.update(delta)

# _input() will be called to handle all input related to Bird.
func _input(event):
	state_.input(event)

# Class FlyingState -------------------------------------------------------------
# Will define the Flying state of the player
class FlyingState:
	
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

# Class FlappingState ------------------------------------------------------------
# Will define the Flapping state of the player
class FlappingState:
	
	var bird_
	
	# _init() is called when an object of this class is created.
	# bird_ will be ordered to move to the right without any damp.
	func _init(bird):
		bird_ = bird

		bird_.set_linear_velocity(Vector2(50, bird_.get_linear_velocity().y))
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
		

	# update() is called for all frame by frame actions
	func update(delta):
		pass

	# input() handles all player input 
	func input(event):
		pass

	# exit() is called before changing state
	func exit():
		pass
