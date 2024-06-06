extends CharacterBody2D

const SPEED = 1500.0

func _physics_process(delta: float) -> void:
	
	velocity.x = Input.get_axis("ui_left", "ui_right")
	velocity.y = Input.get_axis("ui_up", "ui_down")
	velocity = velocity.normalized() * SPEED
	move_and_slide()
