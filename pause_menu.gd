extends Control
class_name PauseMenu



@onready var continue_button: Button = $MarginContainer/PanelContainer/VBoxContainer/ContinueButton


func _ready() -> void:
	self.hide()


func _unhandled_key_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().get_root().set_input_as_handled()
		self.set_visible(not self.is_visible())
	
		if self.is_visible():
			get_tree().set_pause(true)
			continue_button.grab_focus()
		else:
			get_tree().set_pause(false)


func _on_continue_button_pressed() -> void:
	self.hide()
	get_tree().set_pause(false)


func _on_reset_button_pressed() -> void:
	get_tree().set_pause(false)
	get_tree().change_scene_to_file("res://game.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
