# Project: Flappy Bird
# Script: ScoreLabel.gd
# Associated to: Game.tcsn
# Description: ScoreLabel behaviour

extends Label

func _ready():
	print("ScoreLabel >> _ready")
	Score.connect("current_score_changed", self, "on_current_score_changed")

func on_current_score_changed():
	self.set_text(str(Score.current_score))