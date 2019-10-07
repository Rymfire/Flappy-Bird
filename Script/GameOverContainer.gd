# Project: Flappy Bird
# Script: GameOverContainer.gd
# Associated to: Game.tcsn
# Description: Defines the GameOver panel behaviour

extends Container

onready var bird_ = Utils.get_main_node().get_node("Bird")

func _ready():
	self.hide()
	print("GameOverContainer >> _ready")
	if bird_:
		bird_.connect("state_changed", self, "on_bird_state_changed")

func on_bird_state_changed(state):
	if state == bird_.STATE.GROUNDED:
		self.show()
		$AnimationPlayer.play("show")
