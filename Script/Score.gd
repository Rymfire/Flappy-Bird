# Project: Flappy Bird
# Script: Score.gd
# Associated to: -
# Description: Score related containers

extends Node

# score containers & their modified setters
var best_score = 0 setget set_best_score
var current_score = 0 setget set_current_score

# signal send when current score changed
signal best_score_changed
signal current_score_changed

# _ready() will be called as soon as ScoreLabel is set in a scene.
func _ready():
	StageManager.connect("stage_changed", self, "on_stage_changed")
	print("PointArea >> _ready")

func on_stage_changed():
	current_score = 0

# modified setter for the 'self.best_score' variable
# emits a signal
func set_best_score(new_value):
	if new_value > best_score:
		best_score = new_value
		emit_signal("best_score_changed")
		print("Score >> signal \"best_score_changed\" emitted")
	pass

# modified setter for the 'self.current_score' variable
# emits a signal
func set_current_score(new_value):
	current_score = new_value
	emit_signal("current_score_changed")
	print("Score >> signal \"current_score_changed\" emitted")
	pass