extends HBoxContainer
class_name ScoreUI


@export var game: Game = null

@onready var other_score: Label = $OtherScore
@onready var player_score: Label = $PlayerScore


func on_game_other_score_changed(value: int) -> void:
	self.other_score.set_text(str(value))


func on_game_player_score_changed(value: int) -> void:
	self.player_score.set_text(str(value))


func _ready() -> void:
	assert(game != null, "A Game node must be provided in the inspector!")
	game.other_score_changed.connect(on_game_other_score_changed)
	game.player_score_changed.connect(on_game_player_score_changed)
