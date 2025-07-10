extends Panel

var upgradesOpen = false

'''func _process(delta):
	position += position.direction_to(destination) * SPEED * delta'''
	
func _on_upgrades_pressed():
	if upgradesOpen == true:
		var tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "global_position", Vector2(1120, 100), 1.0)
		upgradesOpen = false
		print(upgradesOpen)
		pass
	elif upgradesOpen == false:
		var tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "global_position", Vector2(800, 100), 1.0)
		upgradesOpen = true
		print(upgradesOpen)
		pass
