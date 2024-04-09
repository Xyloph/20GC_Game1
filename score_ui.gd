extends HBoxContainer
class_name ScoreUI

@onready var other_score_label: Label = $OtherScore
@onready var player_score_label: Label = $PlayerScore

var player_score : int = 0
var other_score : int = 0

func increment(player:bool) -> void:
	if player:
		player_score += 1
		self.player_score_label.set_text(str(player_score))
	else:
		other_score += 1
		self.other_score_label.set_text(str(other_score))
