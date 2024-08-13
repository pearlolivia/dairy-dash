extends Control

@onready var inventory: Inv = preload("res://inventory/main_inventory.tres")
@export var item: ShopItem

@onready var shop_keeper = get_node("/root/Main/Shop UI/NinePatchRect/Container/Teemo")
@onready var purchases = get_node("/root/Main/Shop UI/NinePatchRect/Purchases")
@onready var shop_items_holder = get_node("/root/Main/Shop UI/NinePatchRect/ScrollContainer/GridContainer")
var seed_purchase_scene: PackedScene = load("res://scenes/seed_purchase.tscn")

func seed_already_purchased(sprite):
	return purchases.get_children().filter(func(purchase):
		if (purchase.texture == sprite):
			return purchase
		else:
			return null
	)
	
func _on_container_gui_input(event):
	var item_cost = int($Container/Price.text)
	if (event is InputEventMouseButton and event.button_mask == 1):
		if(Global.coins >= item_cost):
			var addedToInventory = inventory.insert(item.item, -1)
			if (addedToInventory != false):
				Global.coins = Global.coins - item_cost
				shop_keeper.play()
				
				var shop_items = shop_items_holder.get_children()
				for shop_item in shop_items:
					if (int(shop_item.get_node("./Container/Price").text) > Global.coins):
						shop_item.get_node("./Container").modulate = "ffffff80"
				
				var seedPurchased = seed_already_purchased(item.item.texture)
				if (seedPurchased.size() > 0):
					var seed_quantity = seedPurchased[0].get_node("./Quantity").text
					seedPurchased[0].get_node("./Quantity").text = str(int(seed_quantity) + 1)
				else:
					var seed_purchase = seed_purchase_scene.instantiate()
					seed_purchase.get_node(".").texture = item.item.texture
					seed_purchase.get_node("./Quantity").text = str(1)
					purchases.add_child(seed_purchase)
