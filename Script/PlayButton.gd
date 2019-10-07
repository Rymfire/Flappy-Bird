# Project: Flappy Bird
# Script: PlayButton.gd
# Associated to: Game.tcsn
# Description: GameOver - PlayButton behaviour script

extends TextureButton

onready var score_container = Utils.get_main_node().find_node("FinalScoreContainer")

func _ready():
	self.connect("pressed", self, "on_play_button_pressed")
	if score_container:
		score_container.connect("lerp_finished", self, "grab_focus")

func on_play_button_pressed():
	StageManager.change_stage(StageManager.STAGE_GAME)
	pass
