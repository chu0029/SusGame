extends Control

@export var bgm : AudioStreamPlayer

func _ready():
	$titlemusic.play()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/gametest.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings_menu.tscn")
