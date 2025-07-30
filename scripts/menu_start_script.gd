extends Control

@export var bg: TextureRect

func _ready():
	$titlemusic.play(global.musicProgress)

func _on_button_pressed() -> void:
	var tween = get_tree().create_tween() #create 'tween' animation
	tween.set_parallel() #run both aninations at the same tiem
	tween.set_trans(Tween.TRANS_CUBIC) #set all the fancy transitions
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(bg, "global_position", Vector2(0, 0), 2.0)
	tween.tween_property(bg, "scale", Vector2(0.3125, 0.3125), 2.0)
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/gametest.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings_menu.tscn")


#play a sound when a button is hovered over
func _on_settings_mouse_entered() -> void:
	$ESe014.play()

func _on_exit_mouse_entered() -> void:
	$ESe014.play()

func _on_start_mouse_entered() -> void:
	$ESe014.play()
