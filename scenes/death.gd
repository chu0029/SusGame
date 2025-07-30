extends Control

@export var info: Label

var unsus = global.totalUpgCount - global.susUpgCount

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	info.text = "You generated %d kilowatts of un-sustainable power. \n That's the same amount of energy as %d Australians use in a day." %[unsus, unsus*8]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_deadbutton_pressed() -> void:
	global.resetGame()
	get_tree().change_scene_to_file("res://scenes/menu_start.tscn")
