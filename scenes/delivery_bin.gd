extends RigidBody2D

signal toggleOrdersVis(isOpen)

func _ready():
	gravity_scale = 0
	contact_monitor = true


func _on_delivery_bin_collider_area_entered(area):
	if (area.name == "PlayerCollider"):
		toggleOrdersVis.emit(true)


func _on_delivery_bin_collider_area_exited(area):
	if (area.name == "PlayerCollider"):
		toggleOrdersVis.emit(false)
