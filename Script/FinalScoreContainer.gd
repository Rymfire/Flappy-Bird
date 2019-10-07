# Project: Flappy Bird
# Script: FinalScoreContainer.gd
# Associated to: Game.tcsn
# Description: Final Score on game over panel animation in

extends Container

export var lerp_time = 0
export var lerp_duration = 1 # 1 sec.

signal lerp_finished

# _ready() will be called as soon as ScoreLabel is set in a scene.
func _ready():
	print("FinalScoreContainer >> _ready")

func score_animation():
	while lerp_time < lerp_duration:
		lerp_time += get_process_delta_time()
		lerp_time = min(lerp_time, lerp_duration)
		var percent = lerp_time / lerp_duration
		self.set_score_value(int(lerp(0, Score.current_score, percent)))
		yield(get_tree(), "idle_frame")
	Score.best_score = Score.current_score
	emit_signal("lerp_finished")

func set_score_value(value):
	$FinalScore.set_text(str(value))
