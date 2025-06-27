extends Control

@export var counter: RichTextLabel
@export var multipcounter: Label
@export var timer: Timer
@export var soundfactory: AudioStreamPlayer
@export var soundupgrade: AudioStreamPlayer
@export var autoclicker: Button
@export var solarpanel: Button

var power: int = 0
var multiplier : int = 1
var automult : int = 0

var AutoclickC = 10

var solarpanelcount : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UpdateLabelText()
	
func _process(delta: float) -> void:
	UpdateLabelText()
	
func UpdateLabelText() -> void:
	counter.text = "Power: %s kW" %power
	multipcounter.text = "Multiplier: %s" %multiplier

func CreatePower() -> void:
	power += 1 * multiplier

func AutoFactory() -> void: 
	power += 1 * automult
	power += 1 * solarpanelcount

func _on_factory_pressed() -> void:
	CreatePower()
	soundfactory.play()

func _on_multiplier_pressed() -> void:
	multiplier += 1
	soundupgrade.play()

func _on_autoclicker_pressed() -> void:
	if power >= AutoclickC:
		timer.start()
		automult += 1
		power -= 10
		AutoclickC = round(AutoclickC*1.5)
		autoclicker.text = 'Autoclicker \n %s kWh' %int(AutoclickC)
		soundupgrade.play()

func _on_timer_timeout() -> void:
	AutoFactory()


func _on_solarpanel_pressed() -> void:
	if power >= 10:
		timer.start()
		solarpanelcount += 1
		power -= 10
		solarpanel.text = 'Solar Panel: %s \n Cost: 10 kW \n 1 kW/s' %solarpanelcount
		soundupgrade.play()
		
		
