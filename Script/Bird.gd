# Project: Flappy Bird
# Script: Bird.gd
# Associated to: Bird.tcsn
# Description: Defines the bird's behaviour (physics, collision, animation, ...)

extends RigidBody2D

# signals
signal state_changed(state)

# state enum
enum STATE {
	FLYING,
	FLAPPING,
	HIT,
	GROUNDED
}
# state_ is an attribute that will contain the current state of Bird
onready var states_ = [FlyingState.new(self), FlappingState.new(self), HitState.new(self), GroundedState.new(self)]
onready var curr_state_

# constant variables
const SPEED = 50

# _ready() will be called as soon as Bird is set in a scene.
# the very first bird state is set here
func _ready():
	curr_state_ = states_[STATE.FLYING]
	curr_state_.enter()
	print("Bird >> _ready")

# Will be called once Bird enter another body
func _on_Bird_body_entered(body):
	if curr_state_.has_method("on_body_entered"):
		curr_state_.on_body_entered(body)

# _process() will be called to handle all input related to Bird.
func _process(delta):
	curr_state_.process_input()

# _physics_process() will be called at each frames and will handle Bird-related computing.
func _physics_process(delta):
	curr_state_.update_frame(delta)

# set_state() is a setter to set/change the current finite machine state by another
func set_state(id):
	curr_state_.exit()
	curr_state_ = states_[id]
	curr_state_.enter()
	emit_signal("state_changed", self.get_state())
	print("Bird >> set_state >> \"state_changed\" emitted")

# get_state() is a getter to get the current finite machine state
func get_state():
	if curr_state_ is FlyingState:
		return STATE.FLYING
	elif curr_state_ is FlappingState:
		return STATE.FLAPPING
	elif curr_state_ is HitState:
		return STATE.HIT
	elif curr_state_ is GroundedState:
		return STATE.GROUNDED

# Class FlyingState -------------------------------------------------------------
# Will define the Flying state of the player
class FlyingState:
	
	var bird_
	var prev_gravity_

	#_init() is called when an object of this class is created.
	func _init(bird):
		bird_ = bird
		print("Bird >> FlyingState >> _init")

	# enter() will be called as soon as the flying state will be used by bird
	# enter() will set the Flying (looped) animation, the gravity to 0 and the bird's
	# linear velocity.
	func enter():
		bird_.get_node("AnimationPlayer").play("Flying")
		bird_.get_node("AnimationPlayer").get_animation("Flying").set_loop(true)
		prev_gravity_ = bird_.get_gravity_scale()
		bird_.set_gravity_scale(0)
		bird_.set_linear_velocity(Vector2(bird_.SPEED, bird_.get_linear_velocity().y))

	# update_frame() is called for all frame by frame actions
	func update_frame(delta):
		pass

	# input() handles all player input
	func process_input():
		pass

	# exit() is called before changing state
	func exit():
		bird_.set_gravity_scale(prev_gravity_)
		bird_.get_node("AnimationPlayer").stop()
		bird_.get_node("AnimatedSprite").set_position(Vector2(0, 0))

# Class FlappingState ------------------------------------------------------------
# Will define the Flapping state of the player
class FlappingState:

	var bird_

	# _init() is called when an object of this class is created.
	# bird_ will be ordered to move to the right without any damp.
	func _init(bird):
		bird_ = bird
		print("Bird >> FlappingState >> _init")

	# enter() will be called as soon as the flapping state will be used by bird
	# enter*( will set the "idle" animation to reset the animation, set the gravity to 5
	# and set the linear velocity without damp
	func enter():
		bird_.get_node("AnimationPlayer").play("Idle")
		bird_.set_linear_velocity(Vector2(bird_.SPEED, bird_.get_linear_velocity().y))
		bird_.set_gravity_scale(5)
		bird_.set_linear_damp(0)
		self.jump()

	func on_body_entered(body):
		if body.is_in_group(Group.PIPES):
			bird_.set_state(STATE.HIT)
		elif body.is_in_group(Group.GROUNDS):
			bird_.set_state(STATE.GROUNDED)
		pass

	# update_frame() is called for all frame by frame actions
	# update_frame() handles the jump animation (rotation and velocity)
	func update_frame(delta):
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
		print("Bird >> jump >> \"bird_jump\" detected")
		bird_.set_linear_velocity(Vector2(bird_.get_linear_velocity().x, -150))
		bird_.set_angular_velocity(-3)
		bird_.get_node("AnimationPlayer").play("Flap")

	# input() handles all player input during flapping state (bird_jump action)
	func process_input():
		if Input.is_action_just_pressed("bird_jump"):
			jump()

	# exit() is called before changing state
	func exit():
		pass

# Class HitState -----------------------------------------------------------
# Will define the Hit state of the player
class HitState:
	
	var bird_
	var other_body_

	#_init() is called when an object of this class is created.
	func _init(bird):
		self.bird_ = bird
		print("Bird >> HitState >> _init")

	# enter() will be called as soon as the flapping state will be used by bird
	func enter():
		self.bird_.set_linear_velocity(Vector2(0, 0))
		self.bird_.set_angular_velocity(2)
		self.other_body_ = bird_.get_colliding_bodies()[0]
		self.bird_.add_collision_exception_with(self.other_body_)

	# update_frame() is called for all frame by frame actions
	func update_frame(delta):
		pass

	func on_body_entered(body):
		if body.is_in_group(Group.GROUNDS):
			self.bird_.set_state(STATE.GROUNDED)
		pass

	# input() handles all player input 
	func process_input():
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
		print("Bird >> GroundedState >> _init")

	# enter() will be called as soon as the flapping state will be used by bird
	func enter():
		self.bird_.set_linear_velocity(Vector2(0, 0))
		self.bird_.set_angular_velocity(0)

	# update_frame() is called for all frame by frame actions
	func update_frame(delta):
		pass

	# input() handles all player input 
	func process_input():
		pass

	# exit() is called before changing state
	func exit():
		pass
