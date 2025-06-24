extends Control

@export var counter: RichTextLabel
@export var multipcounter: Label

var power: int = 0

var multiplier : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UpdateLabelText()
	
func _process(delta: float) -> void:
	UpdateLabelText()
	
func UpdateLabelText() -> void:
	counter.text = "Power: %s" %power
	multipcounter.text = "Multiplier: %s" %multiplier

func _on_factory_pressed() -> void:
	power += 1 * multiplier

func _on_multiplier_pressed() -> void:
	multiplier += 1
