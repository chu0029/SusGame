extends Control


func _ready():
	pass
	



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/gametest.tscn")



func _on_SETTINGS_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings_menu.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
