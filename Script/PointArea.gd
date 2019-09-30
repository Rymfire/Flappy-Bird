# Project: Flappy Bird
# Script: PointArea.gd
# Associated to: PointArea.tcsn
# Description: --

extends Area2D

func _ready():
	self.connect("body_enter", self, "_on_body_entered")
	print("PointArea >> _ready")
	
####################################################################### BUG HERE
func _on_body_entered(body):
	print("score?")
	if body.is_in_group(Group.BIRDS):
#		score++
#		print("PointArea >> _on_body_entered >> Score + 1")
		pass
	pass