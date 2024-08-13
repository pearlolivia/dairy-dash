extends Control

var instruct_2_shown := false
var instruct_3_shown := false
var instruct_4_shown := false
var instruct_5_shown := false

signal final_instruction

func _on_texture_rect_gui_input(event):
	if (event is InputEventMouseButton and event.pressed):
		self.visible = false

func _on_cows_cow_milked():
	if (Global.instruct_num == 2 and !instruct_2_shown):
		instruct_2_shown = true
		$Instructions.text = "Nice! The milk will now be in your inventory. Press the space bar to open it."
		self.visible = true

func _on_inventory_open_first_time():
	if (Global.instruct_num == 3 and !instruct_3_shown):
		instruct_3_shown = true
		$Instructions.text = "There it is! Now walk over to the delivery bin on the top right of the island to view today's order."
		self.visible = true

func _on_orders_open_first_time():
	if (Global.instruct_num == 4 and !instruct_4_shown):
		instruct_4_shown = true
		$Instructions.text = "Click on the milk bottle in your inventory to pick it up. Click on the matching flavour in the orders board (if it's there) to ship it."
		self.visible = true

func show_instruct_5():
	if (Global.instruct_num == 5 and !instruct_5_shown):
		instruct_5_shown = true
		$Instructions.text = "Congrats! Now to change the colour of the cows, feed them the correct fruit or vegetable. You can grow them with the seeds from the shop on the tilled ground. Good luck!"
		self.visible = true
		final_instruction.emit()
		
func _on_orders_close_first_time():
	show_instruct_5()

func _on_order_board_close_first_time():
	show_instruct_5()
