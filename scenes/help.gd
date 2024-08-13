extends Control

var isOpen := false

func _on_help_button_gui_input(event):
	if (event is InputEventMouseButton and event.pressed):
		if (!isOpen):
			$HelpBox.visible = true
			isOpen = true
		else:
			$HelpBox.visible = false
			isOpen = false
