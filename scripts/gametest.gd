extends Control

@export var counter: RichTextLabel
@export var multipcounter: Label
@export var timer: Timer

@export var soundfactory: AudioStreamPlayer
@export var soundupgrade: AudioStreamPlayer
@export var bgm: AudioStreamPlayer

@export var autoclicker: Button
@export var solarpanel: Button
@export var windturbine: Button
@export var biomass: Button
@export var geothermalplant: Button

var power: int = 10000
var multiplier : int = 1
var automult : int = 0

var AutoclickC = 10

var solarpanelcount : int = 0
var windturbinecount : int = 0
var biomasscount : int = 0
var geothermalplantcount : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UpdateLabelText()
	bgm.play()
	
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
	power += 2 * windturbinecount
	power += 5 * biomasscount

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
	if power >= 25:
		timer.start()
		solarpanelcount += 1
		power -= 25
		solarpanel.text = 'Solar Panel: %s \n Cost: 25 kW \n Produces 1 kW/s' %solarpanelcount
		soundupgrade.play()

func _on_windturbine_pressed() -> void:
	if power >= 100:
		timer.start()
		windturbinecount += 1
		power -= 100
		windturbine.text = 'Wind Turbine: %s \n Cost: 100 kW \n Produces 2 kW/s' %windturbinecount
		soundupgrade.play()

func _on_biomass_pressed() -> void:
	if power >= 500:
		timer.start()
		biomasscount += 1
		power -= 500
		biomass.text = 'Biomass Boiler: %s \n Cost: 500 kW \n Produces 3 kW/s' %biomasscount
		soundupgrade.play()


func _on_geothermalplant_pressed() -> void:
	pass # Replace with function body.
