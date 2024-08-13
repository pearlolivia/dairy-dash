extends CanvasLayer

signal close_first_time

var rng := RandomNumberGenerator.new()
var max_orders : int
var milk_white = preload("res://assets/items/milk_white.png")
var milk_yellow = preload("res://assets/items/milk_yellow.png")
var milk_blue = preload("res://assets/items/milk_blue.png")
var milk_brown = preload("res://assets/items/milk_brown.png")
var milk_green = preload("res://assets/items/milk_green.png")
var milk_orange = preload("res://assets/items/milk_orange.png")
var milk_pink = preload("res://assets/items/milk_pink.png")
var milk_purple = preload("res://assets/items/milk_purple.png")

var milk_bottles := [
	milk_white,
	milk_yellow,
	milk_blue,
	milk_brown,
	milk_green,
	milk_orange,
	milk_pink,
	milk_purple
]

func randomise_slots():
	# get all slots in board and randomise milk colour
	for row in $Container.get_children():
		for slot in row.get_children():
			var milk_idx = rng.randi_range(0, 7)
			slot.get_child(0).texture = milk_bottles[milk_idx]
			slot.get_child(1).visible = false
			max_orders += 1

func reset_board():
	$Container/Label2.text = "Day " + str(Global.day)
	randomise_slots()
	
func _ready():
	reset_board()
	
func _on_main_reset_orders():
	reset_board()

func _on_close_button_gui_input(event):
	if (event is InputEventMouseButton and event.pressed):
		self.visible = false
		if (Global.instruct_num == 4):
			Global.instruct_num = 5
			close_first_time.emit()
