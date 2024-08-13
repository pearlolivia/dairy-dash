extends CanvasLayer

func _process(_delta):
	$Container/Day.text = str(Global.day)
	$Container/Orders.text = str(Global.completed_orders)
	$Container/Coins.text = str(Global.coins)
	$ProgressBar.value = Global.day_time_left
