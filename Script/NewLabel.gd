# Project: Flappy Bird
# Script: NewLabel.gd
# Associated to: Game.tcsn
# Description: "new" best score label on GameOver panel behaviour

extends TextureRect

func _ready():
	self.hide()
	Score.connect("best_score_changed", self, "show")