extends Node2D
class_name Game

@onready var other: CharacterBody2D = $Other
@onready var ball: RigidBody2D = $Ball
@onready var other_shape: CollisionShape2D = $Other/CollisionShape2D

@onready var hit_audio_player: AudioStreamPlayer = $HitAudioPlayer
@onready var rebound_audio_player: AudioStreamPlayer = $ReboundAudioPlayer


var ball_speed := 300
const OTHER_SPEED = 300
const OTHER_MIDDLE = 128/2
const MOVE_LIMIT = 25 # amount of pixels to not move (prevent AI stutters)

var other_score: int = 0
var player_score: int = 0

signal player_score_changed(value: int)
signal other_score_changed(value: int)

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
		player_score += 1
		player_score_changed.emit(player_score)
		ball.start()

func _on_goal_other_body_entered(body: Node2D) -> void:
	if body == ball:
		other_score += 1
		other_score_changed.emit(other_score)
		ball.start()

func _on_ball_hit_sound() -> void:
	hit_audio_player.play()

func _on_ball_rebound_sound() -> void:
	rebound_audio_player.play()
