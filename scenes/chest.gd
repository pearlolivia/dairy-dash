extends StaticBody2D

var open := false
signal toggle_chest_inventory(isOpen)

func _on_chest_collider_area_entered(area):
	if (area.name == "PlayerCollider"):
		$AnimatedSprite2D.play("open")
		open = true
	
func _on_chest_collider_area_exited(area):
	if (area.name == "PlayerCollider"):
		toggle_chest_inventory.emit(false)
		$AnimatedSprite2D.play_backwards("open")
		open = false

func _on_animated_sprite_2d_animation_finished():
	if (open == true):
		toggle_chest_inventory.emit(true)
