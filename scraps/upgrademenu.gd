extends Node2D


@export var solarpanel: Button
@export var timer: Timer
@export var windturbine: Button

var solarpanelcount : int = 0
var windturbinecount : int = 0

func _on_solarpanel_pressed() -> void:
	if global.power >= 25:
		timer.start()
		solarpanelcount += 1
		global.power -= 25
		solarpanel.text = 'Solar Panel: %s \n Cost: 25 kW \n Produces 1 kW/s' %solarpanelcount

func _on_windturbine_pressed() -> void:
	if global.power >= 25:
		timer.start()
		solarpanelcount += 1
		global.power -= 25
		solarpanel.text = 'Solar Panel: %s \n Cost: 25 kW \n Produces 1 kW/s' %solarpanelcount
