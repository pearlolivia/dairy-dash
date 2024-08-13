extends TextureRect

@onready var item_visual : Sprite2D = $Item
@onready var complete_visual : TextureRect = $Complete

func _on_gui_input(event):
	if (event is InputEventMouseButton and event.pressed):
		if (item_visual.texture == Global.clicked_item and $Complete.visible == false):
			$Complete.visible = true
			Global.clicked_item = null
			Input.set_custom_mouse_cursor(null)
			Global.completed_orders += 1
			Global.daily_completed_orders += 1
			Global.daily_coins += Global.milk_profit

