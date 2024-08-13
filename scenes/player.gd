extends CharacterBody2D

var speed := 200

@export var inventory: Inv
	
func get_input():
	# keyboard input
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir.normalized() * speed

func _physics_process(_delta):
	# player movement
	get_input()
	# moves node and detects collision objects
	move_and_slide()
	# animation
	if (Input.is_action_pressed("down")):
		$AnimatedSprite2D.play("walk_down")
	elif (Input.is_action_pressed("up")):
		$AnimatedSprite2D.play("walk_up")
	elif (Input.is_action_pressed("left")):
		$AnimatedSprite2D.play("walk_left")
	elif (Input.is_action_pressed("right")):
		$AnimatedSprite2D.play("walk_right")
	else:
		$AnimatedSprite2D.animation = "walk_down"
		$AnimatedSprite2D.frame = 0
		$AnimatedSprite2D.stop()

func collect(item):
	return inventory.insert(item, -1)
