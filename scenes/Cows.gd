extends Node

var cow_scene : PackedScene = load("res://scenes/cow.tscn")
var max_cows := 5
var rng := RandomNumberGenerator.new()

signal cow_milked

func _ready():
	# add cows to scene (5 max)
	for i in max_cows:
		var windowWidth = get_viewport().get_visible_rect().size[0]
		var windowHeight = get_viewport().get_visible_rect().size[1]
		var random_x = rng.randi_range(175, windowWidth - 230)
		var random_y = rng.randi_range(175, windowHeight - 500)
		var cow = cow_scene.instantiate()
		cow.milking.connect(emit_cow_milked)
		add_child(cow)
		cow.position = Vector2(random_x, random_y)
		cow.add_to_group("cows")

func emit_cow_milked():
	if (Global.instruct_num == 1):
		Global.instruct_num = 2
		cow_milked.emit()
