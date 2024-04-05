extends CharacterBody2D

const SPEED = 300.0


func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_up", "ui_down")
	if direction:
		# move if not out of bound
		velocity.y = direction * SPEED
	else:
		# slows down
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
