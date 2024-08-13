extends Resource
# extends inventory resource therefore contains data
class_name Inv

@export var slots: Array[InvSlot]

signal update()
	
func insert(item: InvItem, index: int):
	# when inserting into new, specific slot
	if (index >= 0 and slots[index].item == null):
		slots[index].item = item
		slots[index].amount = 1
	else:
		# find slots that already contain this item
		var item_slots = slots.filter(func(slot): return slot.item == item)
		# if found add 1 to quantity
		if !item_slots.is_empty():
			item_slots[0].amount += 1
		else:
			# get empty slots
			var empty_slots = slots.filter(func(slot): return slot.item == null)
			# if empty slot(s) found
			if !empty_slots.is_empty():
				# add to first empty slot available
				empty_slots[0].item = item
				empty_slots[0].amount = 1
			else:
				return false
	update.emit()
	
func remove(index: int):
	if (slots[index].amount - 1 == 0):
		slots[index].item = null
	slots[index].amount -= 1
	update.emit()
