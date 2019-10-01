# Project: Flappy Bird
# Script: Score.gd
# Associated to: -
# Description: Score related containers

extends Node

# score containers
var best_score = 0 setget set_best_score
var current_score = 0 setget set_current_score

# signal send when current score changed
signal best_score_changed
signal current_score_changed

func _ready():
	print("PointArea >> _ready")

func set_best_score(new_value):
	best_score = new_value
	emit_signal("best_score_changed")
	print("Score >> signal \"best_score_changed\" emitted")
	pass

func set_current_score(new_value):
	current_score = new_value
	emit_signal("current_score_changed")
	print("Score >> signal \"current_score_changed\" emitted")
	pass