extends Control
class_name Menu
signal resume()

@onready var continue_button: Button = $MarginContainer/PanelContainer/VBoxContainer/ContinueButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_continue_button_pressed() -> void:
	# close the menu, unpause processing
	resume.emit()

func _on_reset_button_pressed() -> void:
	# just reload everything
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://game.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func focus_continue() -> void:
	continue_button.grab_focus()
