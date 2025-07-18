extends Control #this means use the properties of 'control' (get its attributes) and then add extra code to it (which is what we're doing below)

@export var counter: RichTextLabel #get information/data/input/output from that label node
@export var multipcounter: Label
@export var kwslabel: Label
@export var timer: Timer
@export var factory: TextureButton

@export var soundfactory: AudioStreamPlayer #export sounds
@export var soundupgrade: AudioStreamPlayer
@export var bgm: AudioStreamPlayer

@export var autoclicker: Button #export buttons (im sure theres a better way to do this)
#update: there IS a better way to do this - use $path-to-file (it autocompletes itself)
@export var solarpanel: Button
@export var windturbine: Button
@export var biomass: Button
@export var geothermalplant: Button
@export var hydroelectricdam: Button
@export var nuclearfusion: Button

#export labels (i forgor why we need this)
@export var healthbutton: Label

var power: int = 10000000 #set all variables needed to increase power
var multiplier : int = 1
var automult : int = 0

#costs to be stored in an array for tidying purposes
#IN ORDER: 0solar 1wind 2biomass 3geother 4hydroel 5nuclear
var costs = [25,100,500,10000,50000,1000000]

#amount of sustainable upgrades player has acquired
var solarpanelcount : int = 0
var windturbinecount : int = 0
var biomasscount : int = 0
var geothermalplantcount : int = 0
var hydroelectricdamcount : int = 0
var nuclearfusioncount : int = 0

#variables that determine sustainability rating and health
var sustainability : int = 0
var susupgrade : int = 1
var unsusupgrade : = 1
var health : int = 100
var kws: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void: #this is the scratch 'on start' block
	pass
	
func _process(delta: float) -> void: #on every frame...
	UpdateLabelText()
	
func UpdateLabelText() -> void:
	counter.text = "%s kW" %power
	multipcounter.text = "Multiplier: %s" %multiplier
	kws = solarpanelcount + windturbinecount*2 + biomasscount*5 + geothermalplantcount*15
	kwslabel.text = '%s kilowatts/sec' %kws
	$sustainability/susbar.value = sustainability
	$health/healthbar.value = health

func CreatePower() -> void: #power created from clicking the thing
	power += 1 * multiplier

func AutoFactory() -> void: 
	sustainability = (susupgrade/unsusupgrade)*100
	if sustainability < 70: #and sustainability > 0 ?
		health -= 1
	power += 1 * automult
	power += 1 * solarpanelcount
	power += 2 * windturbinecount
	power += 5 * biomasscount
	power += 15 * geothermalplantcount
	power += 50 * hydroelectricdamcount
	power += 1000 * nuclearfusioncount

func _on_factory_button_down() -> void:
	CreatePower()
	soundfactory.play()
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(factory, "scale", Vector2(1.05, 1.05), 0.1)

func _on_factory_button_up() -> void:
	soundfactory.play()
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(factory, "scale", Vector2(1, 1), 0.1)

func _on_multiplier_pressed() -> void:
	multiplier += 1
	soundupgrade.play()
	bgm.play()
	
'''func _on_autoclicker_pressed() -> void:
	if power >= AutoclickC:
		timer.start()
		automult += 1
		power -= 10
		AutoclickC = round(AutoclickC*1.5)
		autoclicker.text = 'Autoclicker \n %s kWh' %int(AutoclickC)
		soundupgrade.play()'''

func _on_timer_timeout() -> void:
	AutoFactory()

#universal function for upgrading, with two arguments; itemCost and itemCount. Declare these when u call it later.
func upgradeClicker(itemCost, itemCount):
	timer.start()
	itemCount += 1
	power -= itemCost
	itemCost = round(itemCost*1.25)
	soundupgrade.play()
	return [itemCost, itemCount]
	
func _on_solarpanel_pressed() -> void:
	if power >= costs[0]:
		var output = upgradeClicker(costs[0], solarpanelcount)
		costs[0] = output[0]
		solarpanelcount = output[1]
		solarpanel.text = 'Solar Panel: %s \n Cost: %d kW \n Produces 1 kW/s' %[solarpanelcount,costs[0]]
	'''	if power >= costs[0]:
		timer.start()
		solarpanelcount += 1
		power -= 100
		costs[0] = round(costs[0]*1.25)
		solarpanel.text = 'Solar Panel: %s \n Cost: %d kW \n Produces 1 kW/s' %[solarpanelcount,costs[0]]
		print(costs[0])
		soundupgrade.play()'''

func _on_windturbine_pressed() -> void:
	if power >= costs[1]:
		timer.start()
		windturbinecount += 1
		power -= 100
		costs[1] = round(costs[1]*1.25)
		windturbine.text = 'Wind Turbine: %s \n Cost: %d kW \n Produces 2 kW/s' %[windturbinecount,costs[1]]
		print(costs[1])
		soundupgrade.play()

func _on_biomass_pressed() -> void:
	if power >= costs[2]:
		var output = upgradeClicker(costs[2], biomasscount)
		costs[2] = output[0]
		biomasscount = output[1]
		biomass.text = 'Biomass Boiler: %s \n Cost: %d kW \n Produces 3 kW/s' %[biomasscount,costs[2]]
		soundupgrade.play()

func _on_geothermalplant_pressed() -> void: #costs[3]
	if power >= costs[3]:
		var output = upgradeClicker(costs[3], geothermalplantcount)
		costs[3] = output[0]
		geothermalplantcount = output[1]
		geothermalplant.text = 'Geothermal Plant: %s \n Cost: %d kW \n Produces 15 kW/s' %[geothermalplantcount,costs[3]]

func _on_hydroelectricdam_pressed() -> void: 
	if power >= costs[4]:
		var output = upgradeClicker(costs[4], hydroelectricdamcount)
		costs[4] = output[0]
		hydroelectricdamcount = output[1]
		hydroelectricdam.text = 'Hydroelectric Dam: %s \n Cost: %d kW \n Produces 50 kW/s' %[hydroelectricdamcount,costs[4]]

func _on_nuclearfusion_pressed() -> void:
	if power >= 1000000:
		timer.start()
		nuclearfusioncount += 1
		power -= 1000000
		nuclearfusion.text = 'Nuclear Fusion: %s \n Cost: 1000000 kW \n Produces 1000 kW/s' %nuclearfusioncount
		soundupgrade.play()
