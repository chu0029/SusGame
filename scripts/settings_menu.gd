extends Control

'''@export var bgm: AudioStreamPlayer

func _ready() -> void:
	bgm.play()'''
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/gametest.tscn")
