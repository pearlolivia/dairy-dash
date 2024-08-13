extends Control

@onready var chest_inventory: ChestInv = preload("res://inventory/chest_inventory.tres")
@onready var slots: Array = $Container/GridContainer.get_children()

func _ready():
	chest_inventory.update.connect(update_slots)
	update_slots()

func update_slots():
	for i in range(min(chest_inventory.slots.size(), slots.size())):
		slots[i].update(chest_inventory.slots[i])
		
func _on_chest_toggle_open(isOpen):
	if isOpen:
		self.visible = true
	else:
		self.visible = false
