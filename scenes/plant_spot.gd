extends ColorRect

@onready var main = get_node("/root/Main")

var player
var colour
@export var seeds_planted := false
var plant_scene: PackedScene = preload("res://scenes/plant.tscn")
var playerNearby := false
var isSelectedItemSeeds := false

var seed_white: InvItem = load("res://inventory/items/cauliflower_seeds.tres")
var seed_blue: InvItem = load("res://inventory/items/starfruit_seeds.tres")
var seed_brown: InvItem = load("res://inventory/items/wheat_seeds.tres")
var seed_green: InvItem = load("res://inventory/items/cucumber_seeds.tres")
var seed_orange: InvItem = load("res://inventory/items/carrot_seeds.tres")
var seed_pink: InvItem = load("res://inventory/items/tomato_seeds.tres")
var seed_purple: InvItem = load("res://inventory/items/eggplant_seeds.tres")
var seed_yellow: InvItem = load("res://inventory/items/corn_seeds.tres")

var seed_items = [
	seed_white,
	seed_blue,
	seed_brown,
	seed_green,
	seed_orange,
	seed_pink,
	seed_purple,
	seed_yellow
]

func get_seed_colour():
	var seeds = seed_items.filter(func(item): return item.texture == Global.clicked_item)
	if (seeds.size() == 1):
		return seeds[0].name.substr(5, -1)
	else:
		return colour

func _on_plant_collider_body_entered(body):
	if (body.name == "Player"):
		playerNearby = true
	if (playerNearby == true and isSelectedItemSeeds == true and seeds_planted == false):
		self.visible = true

func _on_plant_collider_body_exited(body):
	if (body.name == "Player"):
		playerNearby = false
		self.visible = false

func _on_gui_input(event):
	if (event is InputEventMouseButton and event.pressed and self.visible == true):
		var plant = plant_scene.instantiate()
		main.add_child(plant)
		var plant_position = $Marker2D.global_position
		plant_position.x = plant_position.x - 30
		plant_position.y = plant_position.y - 60
		plant.position = plant_position
		plant.plant_spot = self
		plant.plant_colour = colour
		seeds_planted = true
		plant.get_node("AnimatedSprite2D").animation = "grow_" + str(colour)
		Global.clicked_item = null
		Input.set_custom_mouse_cursor(null)

func _process(_delta):
	isSelectedItemSeeds = seed_items.filter(func(item): return Global.clicked_item == item.texture).size()
	if (isSelectedItemSeeds == true):
			colour = get_seed_colour()
	else:
		colour = null
