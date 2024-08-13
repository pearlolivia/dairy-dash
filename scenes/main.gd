extends Node

var day_complete := false

signal reset_orders
signal open_first_time
signal close_first_time

func _on_delivery_bin_toggle_orders_vis(isOpen):
	$OrderBoard.visible = isOpen
	if (Global.instruct_num == 3 and isOpen):
		Global.instruct_num = 4
		open_first_time.emit()
	if (Global.instruct_num == 4 and !isOpen):
			Global.instruct_num = 5
			close_first_time.emit()

func finish_day():
	$DayTimer.stop()
	$OrderBoard.visible = false
	$EndOfDay.visible = true
	get_node("Player").set_deferred("paused", true)
	get_node("Cows").set_deferred("paused", true)
	get_node("Inventory").set_deferred("paused", true)
	
func _on_day_timer_timeout():
	finish_day()

func _process(_delta):
	Global.day_time_left = $DayTimer.time_left
	if (Global.daily_completed_orders == 20 and !day_complete):
		day_complete = true
		Global.daily_coins = Global.daily_coins * 2
		finish_day()
	if (Input.is_action_just_pressed("new_day")):
		Global.day += 1
		Global.coins = Global.coins + Global.daily_coins
		Global.daily_coins = 0
		Global.daily_completed_orders = 0
		reset_orders.emit()
		day_complete = false
		$EndOfDay.visible = false
		$DayTimer.start()
		get_node("Player").set_deferred("paused", false)
		get_node("Cows").set_deferred("paused", false)
		get_node("Inventory").set_deferred("paused", false)

func _on_instructions_final_instruction():
	$DayTimer.start()
