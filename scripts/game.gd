extends Control

var power: int = 0
var ClickMult: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UpdateLabelText()

func CreatePower() -> void:
