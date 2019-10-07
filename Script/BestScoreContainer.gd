# Project: Flappy Bird
# Script: BestScoreContainer.gd
# Associated to: Game.tcsn
# Description: Best Score on game over panel animation in

extends Container

# _ready() will be called as soon as ScoreLabel is set in a scene.
func _ready():
	self.set_score_value(Score.best_score)
	Score.connect("best_score_changed", self, "on_new_best_score")
	print("BestScoreContainer >> _ready")

func on_new_best_score():
	self.set_score_value(Score.best_score)

func set_score_value(value):
	$BestScore.set_text(str(value))
