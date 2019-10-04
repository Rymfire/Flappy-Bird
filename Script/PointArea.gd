# Project: Flappy Bird
# Script: PointArea.gd
# Associated to: PointArea.tcsn
# Description: --

extends Area2D

# _ready() will be called as soon as PointArea is set in a scene
# defines the behaviour when a body enters the area (set the fonction called)
func _ready():
	self.connect("body_entered", self, "_on_body_entered")
	print("PointArea >> _ready")

# updates the 'Score.current_score' variables when a BIRD enteres the 'self' area
func _on_body_entered(body):
	if body.is_in_group(Group.BIRDS):
		print("PointArea >> _on_body_entered >> current_score = ", Score.current_score, " + 1")
		Score.current_score += 1
