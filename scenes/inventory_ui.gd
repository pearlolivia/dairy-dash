extends Control

@onready var inventory: Inv = preload("res://inventory/main_inventory.tres")
@onready var slots: Array = $Container/GridContainer.get_children()

var is_open := false
var first_open := 0

signal open_first_time

func _ready():
	inventory.update.connect(update_slots)
	update_slots()
	close()

func update_slots():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])

func _process(_delta):
	if Input.is_action_just_pressed("toggle_inventory"):
		if is_open:
			close()
		else:
			open()

func open():
	$".".visible = true
	is_open = true
	#first_open += 1
	if (Global.instruct_num == 2):
		Global.instruct_num = 3
		open_first_time.emit()
	
func close():
	$".".visible = false
	is_open = false
