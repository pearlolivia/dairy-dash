extends Resource

class_name ShopOptions

@export var options: Array[ShopItem]
var cauliflower_seeds: ShopItem = preload("res://shop/items/cauliflower_seeds.tres")
var carrot_seeds: ShopItem = preload("res://shop/items/carrot_seeds.tres")
var cucumber_seeds: ShopItem = preload("res://shop/items/cucumber_seeds.tres")
var eggplant_seeds: ShopItem = preload("res://shop/items/eggplant_seeds.tres")
var starfruit_seeds: ShopItem = preload("res://shop/items/starfruit_seeds.tres")
var corn_seeds: ShopItem = preload("res://shop/items/corn_seeds.tres")
var tomato_seeds: ShopItem = preload("res://shop/items/tomato_seeds.tres")
var wheat_seeds: ShopItem = preload("res://shop/items/wheat_seeds.tres")
	

func _init():
	options = [
		wheat_seeds,
		cauliflower_seeds,
		carrot_seeds,
		corn_seeds,
		cucumber_seeds,
		eggplant_seeds,
		starfruit_seeds,
		tomato_seeds,
		tomato_seeds
	]
