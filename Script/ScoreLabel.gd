# Project: Flappy Bird
# Script: ScoreLabel.gd
# Associated to: Game.tcsn
# Description: ScoreLabel behaviour

extends Label

# _ready() will be called as soon as ScoreLabel is set in a scene.
func _ready():
	print("ScoreLabel >> _ready")
	Score.connect("current_score_changed", self, "on_current_score_changed")

# will be called to update the 'ScoreLabel' as soon as 'Score.current_score' 
# value is changed
func on_current_score_changed():
	self.set_text(str(Score.current_score))