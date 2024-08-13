extends TextureRect

@onready var item_visual : Sprite2D = $Item
@onready var amount_text : Label = $Quantity
@onready var main_inventory: Inv = preload("res://inventory/main_inventory.tres")
@onready var chest_inventory: ChestInv = preload("res://inventory/chest_inventory.tres")

var milk_white: InvItem = load("res://inventory/items/milk_white.tres")
var milk_purple: InvItem = load("res://inventory/items/milk_purple.tres")
var milk_blue: InvItem = load("res://inventory/items/milk_blue.tres")
var milk_brown: InvItem = load("res://inventory/items/milk_brown.tres")
var milk_green: InvItem = load("res://inventory/items/milk_green.tres")
var milk_orange: InvItem = load("res://inventory/items/milk_orange.tres")
var milk_pink: InvItem = load("res://inventory/items/milk_pink.tres")
var milk_yellow: InvItem = load("res://inventory/items/milk_yellow.tres")
var veg_white: InvItem = load("res://inventory/items/cauliflower.tres")
var veg_blue: InvItem = load("res://inventory/items/starfruit.tres")
var veg_brown: InvItem = load("res://inventory/items/wheat.tres")
var veg_green: InvItem = load("res://inventory/items/cucumber.tres")
var veg_orange: InvItem = load("res://inventory/items/carrot.tres")
var veg_pink: InvItem = load("res://inventory/items/tomato.tres")
var veg_purple: InvItem = load("res://inventory/items/eggplant.tres")
var veg_yellow: InvItem = load("res://inventory/items/corn.tres")
var seeds_white: InvItem = load("res://inventory/items/cauliflower_seeds.tres")
var seeds_blue: InvItem = load("res://inventory/items/starfruit_seeds.tres")
var seeds_brown: InvItem = load("res://inventory/items/wheat_seeds.tres")
var seeds_green: InvItem = load("res://inventory/items/cucumber_seeds.tres")
var seeds_orange: InvItem = load("res://inventory/items/carrot_seeds.tres")
var seeds_pink: InvItem = load("res://inventory/items/tomato_seeds.tres")
var seeds_purple: InvItem = load("res://inventory/items/eggplant_seeds.tres")
var seeds_yellow: InvItem = load("res://inventory/items/corn_seeds.tres")

var items = [
	milk_white,
	milk_blue,
	milk_brown,
	milk_green,
	milk_orange,
	milk_pink,
	milk_purple,
	milk_yellow,
	veg_white,
	veg_blue,
	veg_brown,
	veg_green,
	veg_orange,
	veg_pink,
	veg_purple,
	veg_yellow,
	seeds_white,
	seeds_blue,
	seeds_brown,
	seeds_green,
	seeds_orange,
	seeds_pink,
	seeds_purple,
	seeds_yellow,
]

var inventory
var isChestSlot := false

func _ready():
	if ("Chest" in self.name):
		isChestSlot = true
		inventory = chest_inventory
	else:
		inventory = main_inventory
			
func update(slot: InvSlot):
	if !slot.item:
		amount_text.visible = false
		item_visual.texture = null
	else:
		amount_text.visible = true
		item_visual.texture = slot.item.texture
		amount_text.text = str(slot.amount)

func get_item():
	for item in items:
			if (item.texture == Global.clicked_item):
				return item

func get_slot_idx():
	var slotsArr = get_tree().get_nodes_in_group('main_slots')
	var chestSlotsArr = get_tree().get_nodes_in_group('chest_slots')
	if (isChestSlot):
		for slot in chestSlotsArr:
			if (slot == self):
				return int(slot.name.substr(8, -1)) - 1
	else:
		for slot in slotsArr:
			if (slot == self):
				return int(slot.name.substr(4, -1)) - 1
	
func _on_gui_input(event):
	if (event is InputEventMouseButton and event.pressed):
		var item = get_item()
		# when nothing selected
		if (Global.clicked_item == null and item_visual.texture != null):
			Global.clicked_item = item_visual.texture
			Input.set_custom_mouse_cursor(item_visual.texture)
			inventory.remove(get_slot_idx())
		# when item selected is the same as in the slot
		elif (Global.clicked_item == item_visual.texture):
			inventory.insert(item, -1)
			Global.clicked_item = null
			Input.set_custom_mouse_cursor(null)
		# when placing item in new slot
		elif (Global.clicked_item != null and item_visual.texture == null):
			inventory.insert(item, get_slot_idx())
			Global.clicked_item = null
			Input.set_custom_mouse_cursor(null)
