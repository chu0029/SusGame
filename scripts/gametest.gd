extends Control

@export var counter: RichTextLabel
@export var multipcounter: Label
@export var timer: Timer
@export var soundfactory: AudioStreamPlayer

var power: int = 0
var multiplier : int = 1
var automult : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UpdateLabelText()
	
func _process(delta: float) -> void:
	UpdateLabelText()
	
func UpdateLabelText() -> void:
	counter.text = "Power: %s" %power
	multipcounter.text = "Multiplier: %s" %multiplier

func CreatePower() -> void:
	power += 1 * multiplier

func AutoFactory() -> void: 
	power += 1 * automult

func _on_factory_pressed() -> void:
	CreatePower()
	soundfactory.play()

func _on_multiplier_pressed() -> void:
	multiplier += 1

func _on_autoclicker_pressed() -> void:
	timer.start()
	automult += 1

func _on_timer_timeout() -> void:
	AutoFactory()
