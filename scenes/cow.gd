extends CharacterBody2D

var speed : float
var colour : String
var colours = ["white", "purple", "blue", "brown", "green", "pink", "orange", "yellow"]
var rng := RandomNumberGenerator.new()
var saved_velocity : Vector2
var player
var milked := false

signal milking

@export var milk_white: InvItem = load("res://inventory/items/milk_white.tres")
@export var milk_purple: InvItem = load("res://inventory/items/milk_purple.tres")
@export var milk_blue: InvItem = load("res://inventory/items/milk_blue.tres")
@export var milk_brown: InvItem = load("res://inventory/items/milk_brown.tres")
@export var milk_green: InvItem = load("res://inventory/items/milk_green.tres")
@export var milk_orange: InvItem = load("res://inventory/items/milk_orange.tres")
@export var milk_pink: InvItem = load("res://inventory/items/milk_pink.tres")
@export var milk_yellow: InvItem = load("res://inventory/items/milk_yellow.tres")

var veg_white: InvItem = load("res://inventory/items/cauliflower.tres")
var veg_blue: InvItem = load("res://inventory/items/starfruit.tres")
var veg_brown: InvItem = load("res://inventory/items/wheat.tres")
var veg_green: InvItem = load("res://inventory/items/cucumber.tres")
var veg_orange: InvItem = load("res://inventory/items/carrot.tres")
var veg_pink: InvItem = load("res://inventory/items/tomato.tres")
var veg_purple: InvItem = load("res://inventory/items/eggplant.tres")
var veg_yellow: InvItem = load("res://inventory/items/corn.tres")

var milk_items = [
	milk_white,
	milk_blue,
	milk_brown,
	milk_green,
	milk_orange,
	milk_pink,
	milk_purple,
	milk_yellow,
]

var veg_items = [
	veg_white,
	veg_blue,
	veg_brown,
	veg_green,
	veg_orange,
	veg_pink,
	veg_purple,
	veg_yellow,
]

func _ready():
	var directions = [-1, 1]
	var random_x = directions[randi() % directions.size()]
	var random_y = rng.randi_range(-1, 1)
	var random_colour_idx = rng.randi_range(0, 7)
	# randomise colour of cow
	colour = colours[random_colour_idx]
	# randomise speed
	speed = rng.randf_range(0.2, 0.6)
	# randomise direction
	velocity = Vector2(random_x, random_y).normalized() * speed
	$TurnAroundTimer.wait_time = rng.randf_range(5, 25)
	$AnimatedSprite2D.animation = 'walk_' + colour

func _physics_process(_delta):
	move_and_collide(velocity)
	$AnimatedSprite2D.flip_h = velocity.x < 0

func get_veg_colour():
	var veg = veg_items.filter(func(item): return item.texture == Global.clicked_item)
	if (veg.size() == 1):
		return veg[0].name.substr(4, -1)
	else:
		return colour
	
func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton and event.pressed and player != null):
		if (Global.clicked_item):
			colour = get_veg_colour()
			$AnimatedSprite2D.animation = 'idle_' + colour
			Global.clicked_item = null
			Input.set_custom_mouse_cursor(null)
		else:
			for milk in milk_items:
				if (milk.name == "milk_" + colour and milked == false):
					var addedToInventory = player.collect(milk)
					if (addedToInventory != false):
						milking.emit()
						milked = true
						$ProgressBar.visible = true
						$MilkTimer.start()

func change_direction(dir):
	return dir * -1

func _on_area_2d_area_entered(area):
	if (area.name == "PlayerCollider"):
		saved_velocity = velocity
		velocity = Vector2(0, 0)
		$AnimatedSprite2D.animation = 'idle_' + colour
		$TurnAroundTimer.paused = true


func _on_area_2d_area_exited(area):
	if (area.name == "PlayerCollider"):
		velocity = saved_velocity.normalized()  * speed
		$AnimatedSprite2D.animation = 'walk_' + colour
		$TurnAroundTimer.paused = false


func _on_turn_around_timer_timeout():
	# cow pauses before turning around
	saved_velocity = velocity
	velocity = Vector2(0, 0)
	$AnimatedSprite2D.animation = 'idle_' + colour
	$TurnAroundCooldown.start()

func _on_turn_around_cooldown_timeout():
	$AnimatedSprite2D.animation = 'walk_' + colour
	velocity = Vector2(change_direction(saved_velocity.x), change_direction(saved_velocity.y)).normalized() * speed


func _on_cow_collider_body_entered(body):
	if (body.name == "World"):
		$AnimatedSprite2D.animation = 'idle_' + colour
	if (body.name == "Player"):
		player = body


func _on_cow_collider_body_exited(body):
	if (body.name == "World"):
		$AnimatedSprite2D.animation = 'walk_' + colour
	if (body.name == "Player"):
		player = null


func _on_milk_timer_timeout():
	milked = false
	$ProgressBar.visible = false

func _process(_delta):
	if (milked == true):
		$ProgressBar.value = $MilkTimer.time_left
