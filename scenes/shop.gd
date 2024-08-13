extends TileMap

@onready var shop = get_node("/root/Main/Shop UI")
@onready var shop_items_holder = get_node("/root/Main/Shop UI/NinePatchRect/ScrollContainer/GridContainer")

func _on_area_2d_area_entered(area):
	if (area.name == "PlayerCollider"):
		shop.visible = true
		var shop_items = shop_items_holder.get_children()
		for item in shop_items:
			if (int(item.get_node("./Container/Price").text) > Global.coins):
				item.get_node("./Container").modulate = "ffffff80"
			else:
				item.get_node("./Container").modulate = "ffffff"
