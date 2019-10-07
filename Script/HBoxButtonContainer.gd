# Project: Flappy Bird
# Script: HBoxButtonContainer.gd
# Associated to: Game.tcsn
# Description: GameOver panel button apearance

extends HBoxContainer

onready var score_container = Utils.get_main_node().find_node("FinalScoreContainer")

# SCORE CONTAINER NULL
func _ready():
	self.hide()
	if score_container:
		score_container.connect("lerp_finished", self, "show")
