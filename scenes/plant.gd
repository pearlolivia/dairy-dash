extends RigidBody2D

var fully_grown := false
@export var plant_spot: ColorRect
@export var plant_colour: String

@onready var inventory: Inv = preload("res://inventory/main_inventory.tres")

var veg_white: InvItem = load("res://inventory/items/cauliflower.tres")
var veg_blue: InvItem = load("res://inventory/items/starfruit.tres")
var veg_brown: InvItem = load("res://inventory/items/wheat.tres")
var veg_green: InvItem = load("res://inventory/items/cucumber.tres")
var veg_orange: InvItem = load("res://inventory/items/carrot.tres")
var veg_pink: InvItem = load("res://inventory/items/tomato.tres")
var veg_purple: InvItem = load("res://inventory/items/eggplant.tres")
var veg_yellow: InvItem = load("res://inventory/items/corn.tres")

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
	$AnimatedSprite2D.play()

func get_veg():
	var veg = veg_items.filter(func(item): return item.name.substr(4, -1) == plant_colour)
	if (veg.size() == 1):
		return veg[0]
	else:
		return null
				
func _on_plant_collider_body_entered(body):
	if (body.name == "Player" and fully_grown == true):
		#add veg to inventory
		var addedToInventory = inventory.insert(get_veg(), -1)
		if (addedToInventory != false):
			plant_spot.seeds_planted = false
			queue_free()

func _on_animated_sprite_2d_animation_finished():
	fully_grown = true 
	Global.veg_grown += 1
