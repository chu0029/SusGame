extends Control

var power: int = 0
var Cmult: int = 1
@export var label : RichTextLabel


func _ready() -> void:
	Updatelabel()

func Updatelabel()-> void:
	label.text = "Powah: %s" %power
	
func CreatePower() -> void:
	power += 1 * Cmult
	Updatelabel()

func _on_factory_pressed() -> void:
	CreatePower()
