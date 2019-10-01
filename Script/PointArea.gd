# Project: Flappy Bird
# Script: PointArea.gd
# Associated to: PointArea.tcsn
# Description: --

extends Area2D

func _ready():
	self.connect("body_entered", self, "_on_body_entered")
	print("PointArea >> _ready")

func _on_body_entered(body):
	if body.is_in_group(Group.BIRDS):
		print("PointArea >> _on_body_entered >> current_score = ", Score.current_score, " + 1")
		Score.current_score += 1
