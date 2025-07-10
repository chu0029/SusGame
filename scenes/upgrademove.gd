extends Panel

#set upgradesOPEN state to false
var upgradesOpen = false

'''func _process(delta):
	position += position.direction_to(destination) * SPEED * delta'''
	
#when upgrades button pressed
func _on_upgrades_pressed():
	if upgradesOpen == true: #if menu open
		var tween = get_tree().create_tween() #create 'tween' animation
		tween.set_trans(Tween.TRANS_CUBIC) #set all the fancy transitions
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "global_position", Vector2(1200, 150), 1.0) #move golbal position to (1120,100) in 1 sec
		upgradesOpen = false
		#print(upgradesOpen)
		pass
	elif upgradesOpen == false: #if menu closed
		var tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_BOUNCE)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "global_position", Vector2(700, 150), 1.0)
		upgradesOpen = true
		#print(upgradesOpen)
		pass
