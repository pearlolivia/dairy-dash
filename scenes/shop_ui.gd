extends Control

var shop_options = load("res://shop/shop_options.gd")
var seeds = shop_options.new()
var option_scene: PackedScene = load("res://scenes/shop_option.tscn")

func _on_close_button_gui_input(event):
	if (event is InputEventMouseButton and event.pressed):
		for purchase in $NinePatchRect/Purchases.get_children():
			$NinePatchRect/Purchases.remove_child(purchase)
		self.visible = false

func _ready():
	for item in seeds.options:
		var option = option_scene.instantiate()
		option.get_node("./Container/SeedName").text =  item.item_name
		option.get_node("./Container/Price").text =  str(item.price)
		option.get_node("./Container/Seeds").texture =  item.item.texture
		option.get_node("./TextureRect/Product").texture =  item.product
		option.item = item
		$NinePatchRect/ScrollContainer/GridContainer.add_child(option)


func _on_teemo_animation_finished():
	$NinePatchRect/Container/Teemo.frame = 0
