extends CanvasLayer

func _process(_delta):
	if (self.visible == true):
		$TextureRect/Label.text = "Day " + str(Global.day) + " complete!"
		$TextureRect/GridContainer/MilkOrders.text = str(Global.daily_completed_orders)
		$TextureRect/GridContainer2/VegGrown.text = str(Global.veg_grown)
		$TextureRect/GridContainer3/Coins.text = str(Global.daily_coins)
