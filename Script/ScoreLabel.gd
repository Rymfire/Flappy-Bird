# Project: Flappy Bird
# Script: ScoreLabel.gd
# Associated to: Game.tcsn
# Description: ScoreLabel behaviour

extends Label

onready var bird = Utils.get_main_node().get_node("Bird")

# _ready() will be called as soon as ScoreLabel is set in a scene.
func _ready():
	print("ScoreLabel >> _ready")
	Score.connect("current_score_changed", self, "on_current_score_changed")
	if bird:
		bird.connect("state_changed", self, "on_bird_state_changed")

func on_bird_state_changed(new_state):
	if new_state == bird.STATE.GROUNDED:
		$AnimationPlayer.play("fade_out")
	elif new_state == bird.STATE.FLAPPING:
		$AnimationPlayer.play("fade_in")

# will be called to update the 'ScoreLabel' as soon as 'Score.current_score' 
# value is changed
func on_current_score_changed():
	self.set_text(str(Score.current_score))
