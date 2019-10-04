# Project: Flappy Bird
# Script: PlayButton.gd
# Associated to: Game.tcsn
# Description: GameOver - PlayButton behaviour script

extends TextureButton

func _ready():
	self.connect("pressed", self, "on_play_button_pressed")

func on_play_button_pressed():
	StageManager.change_stage(StageManager.STAGE_GAME)
# 	Score.current_score = 0
	pass
