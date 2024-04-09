class_name Ball extends RigidBody2D
var ball_speed := 300
var velocity := Vector2(0,0)
const BODY_MIDDLE = 64 # middle of the paddle which is 128 tall
signal hitSound(); # have the game play the hit sound
signal reboundSound(); # have t he game play the rebound sound

# Set to a Node2D which will be used as the starting ball position
# The engine can move the node according to the stretching settings
# but we'll always know the correct position to start the ball
# when the Node2D get moved automatically.
@export var initial_position: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var collision_info := move_and_collide(velocity * ball_speed * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
		if collision_info.get_collider().is_class("CharacterBody2D"):
			# play the hit sound
			hitSound.emit()
			
			# faster when hitting player
			ball_speed += 50
			
			# take a further away X value, calculate a new Y which should be between -64 and 64 (paddle is 128 tall)
			velocity = Vector2(velocity.x * 50,  collision_info.get_position().y - (collision_info.get_collider().position.y + BODY_MIDDLE)).normalized()
		else:
			#play rebound sound
			reboundSound.emit()

func start() -> void:
	ball_speed = 300 # reset the ball speed
	position = initial_position.position
	var rand := RandomNumberGenerator.new()
	# random direction
	var direction_x = rand.randi_range(-1,1)
	if direction_x == 0: direction_x = 1 # never straight up/down
	var direction_y = rand.randi_range(-1,1) # some potential diagonal
	velocity = Vector2(direction_x, direction_y).normalized()
