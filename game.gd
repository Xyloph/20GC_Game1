extends Node2D
class_name Game

@onready var other: CharacterBody2D = $Other
@onready var ball: RigidBody2D = $Ball
@onready var other_shape: CollisionShape2D = $Other/CollisionShape2D
@onready var hit_audio_player: AudioStreamPlayer = $HitAudioPlayer
@onready var rebound_audio_player: AudioStreamPlayer = $ReboundAudioPlayer
@onready var score_ui: ScoreUI = $CanvasLayer/ScoreUI
@onready var ball_initial_position: Node2D = $BallInitialPosition

var ball_speed := 300
const OTHER_SPEED = 300
const OTHER_MIDDLE = 128/2
const MOVE_LIMIT = 25 # amount of pixels to not move (prevent AI stutters)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Bit of padding (move_limit) to prevent stuttering
	var other_direction := 0
	if (other.position.y + OTHER_MIDDLE > ball.position.y + MOVE_LIMIT):
		other_direction = -1
	elif (other.position.y + OTHER_MIDDLE < ball.position.y - MOVE_LIMIT):
		other_direction = 1
	other.velocity = Vector2(0,other_direction) * OTHER_SPEED
	other.move_and_slide()

# When the game starts, place the ball and shoot it somewhere
func _start() -> void:
	ball.start()

func _on_goal_player_body_entered(body: Node2D) -> void:
	if body == ball:
		score_ui.increment(true)
		ball.start()

func _on_goal_other_body_entered(body: Node2D) -> void:
	if body == ball:
		score_ui.increment(false)
		ball.start()

func _on_ball_hit_sound() -> void:
	hit_audio_player.play()

func _on_ball_rebound_sound() -> void:
	rebound_audio_player.play()
