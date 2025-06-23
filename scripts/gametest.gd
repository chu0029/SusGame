extends Control

@export var counter: RichTextLabel

var power: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UpdateLabelText()
	
func UpdateLabelText() -> void:
	counter.text = "Power: %s" %power

func _on_factory_pressed() -> void:
	power += 1
	UpdateLabelText()
