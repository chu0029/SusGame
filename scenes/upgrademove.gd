extends Panel

const SPEED = 1000

var destination = Vector2(1100, 200)

'''func _process(delta):
	position += position.direction_to(destination) * SPEED * delta'''
	
func _on_upgrades_pressed():
	pass
	self.position.x += 20
	#position += position.direction_to(destination) * SPEED * delta
