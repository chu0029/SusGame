extends Control #this means use the properties of 'control' (get its attributes) and then add extra code to it (which is what we're doing below)

@export var counter: RichTextLabel #get information/data/input/output from that label node
@export var multipcounter: Label
@export var kwslabel: Label
@export var timer: Timer
@export var factory: TextureButton

@export var soundfactory: AudioStreamPlayer #export sounds
@export var soundupgrade: AudioStreamPlayer
@export var bgm: AudioStreamPlayer

#exports unsustainable buttons so they can be used in code
@export var incineratorplant: Button
@export var coal: Button
@export var advcoal: Button
@export var natgas: Button
@export var oilrig: Button
@export var nfission: Button

#export store buttons
@export var tree: Button
@export var bus: Button
@export var ev: Button
@export var train: Button
@export var sApartment: Button

#export sustainable buttons
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

var power: int = 9999999999 #set all variables needed to increase power
var multiplier : int = 1
var automult : int = 0

#costs to be stored in an array for tidying purposes
#IN ORDER: 0solar 1wind 2biomass 3geother 4hydroel 5nuclear
var costs = [25,100,500,10000,50000,1000000]
var costn = [10,50,250,5000,25000,500000]
var nonsuscount = [0,0,0,0,0,0]
var coste = [200,1000,5000,10000,50000]
var encount = [0,0,0,0,0]

#couting how many upgrades 
var susUpgCount = 0
var totalUpgCount = 0

#amount of sustainable upgrades player has acquired
var solarpanelcount : int = 0
var windturbinecount : int = 0
var biomasscount : int = 0
var geothermalplantcount : int = 0
var hydroelectricdamcount : int = 0
var nuclearfusioncount : int = 0

#variables that determine sustainability rating and health
var sustainability : int = 100
var susupgrade : int = 1
var unsusupgrade : = 1
var health : int = 100
var kws: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void: #this is the scratch 'on start' block
	bgm.play()
	pass
	
func _process(delta: float) -> void: #on every frame...
	UpdateLabelText()
	
func UpdateLabelText() -> void:
	counter.text = "%s kW" %power
	multipcounter.text = "Multiplier: %s" %multiplier
	kws = (
		solarpanelcount + windturbinecount*2 + biomasscount*5 + geothermalplantcount*15 + 
		hydroelectricdamcount*50 + nuclearfusioncount*1000 + nonsuscount[0] + 
		nonsuscount[1]*2 + nonsuscount[2]*5 + nonsuscount[3]*15 + nonsuscount[4]*50 + 
		nonsuscount[5]*1000
		)
	multiplier = 1+(
		encount[0]*1+encount[1]+encount[2]+encount[3]+encount[4]
		)
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
	power += 1 * nonsuscount[0]
	power += 2 * nonsuscount[1]
	power += 5 * nonsuscount[2]
	power += 15 * nonsuscount[3]
	power += 50 * nonsuscount[4]
	power += 1000 * nonsuscount[5]

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

#DELETE THIS DELETE THIS DELETE THIS DELETE THIS DELETE THIS DELETE THIS 
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

#UNIVERSAL FUNCTION FOR ALL ENHAMCEMENTS
func enhacement(itemCost, itemCount):
	if itemCount <9: #if there are less than 10 items purchased alr
		timer.start()
		itemCount += 1
		power -= itemCost
		itemCost = round(itemCost*2)
		soundupgrade.play()
		return [itemCost, itemCount, 0]
	else:
		return [itemCost, itemCount, 1]
	
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

func _on_hydroelectricdam_pressed() -> void: #costs[4]
	if power >= costs[4]:
		var output = upgradeClicker(costs[4], hydroelectricdamcount)
		costs[4] = output[0]
		hydroelectricdamcount = output[1]
		hydroelectricdam.text = 'Hydroelectric Dam: %s \n Cost: %d kW \n Produces 50 kW/s' %[hydroelectricdamcount,costs[4]]

func _on_nuclearfusion_pressed() -> void: #costs[5]
	if power >= costs[5]:
		var output = upgradeClicker(costs[5], nuclearfusioncount)
		costs[5] = output[0]
		nuclearfusioncount = output[1]
		nuclearfusion.text = 'Nuclear Fusion: %s \n Cost: %d kW \n Produces 1000 kW/s' %[nuclearfusioncount,costs[5]]
	'''if power >= 1000000:
		timer.start()
		nuclearfusioncount += 1
		power -= 1000000
		nuclearfusion.text = 'Nuclear Fusion: %s \n Cost: 1000000 kW \n Produces 1000 kW/s' %nuclearfusioncount
		soundupgrade.play()'''

func _on_inc_plant_pressed() -> void:
	if power >= costn[0]:
		var output = upgradeClicker(costn[0], nonsuscount[0])
		costn[0] = output[0]
		nonsuscount[0] = output[1]
		incineratorplant.text = 'Incinerator Plant: %s \n Cost: %d kW \n Produces 1 kW/s' %[nonsuscount[0], costn[0]]

func _on_coal_pressed() -> void:
	if power >= costn[1]:
		var output = upgradeClicker(costn[1], nonsuscount[1])
		costn[1] = output[0]
		nonsuscount[1] = output[1]
		coal.text = 'Coal Burner: %s \n Cost: %d kW \n Produces 2 kW/s' %[nonsuscount[1], costn[1]]

func _on_adv_coal_pressed() -> void:
	if power >= costn[2]:
		var output = upgradeClicker(costn[2], nonsuscount[2])
		costn[2] = output[0]
		nonsuscount[2] = output[1]
		advcoal.text = 'Advanced Coal: %s \n Cost: %d kW \n Produces 5 kW/s' %[nonsuscount[2], costn[2]]

func _on_nat_gas_pressed() -> void:
	if power >= costn[3]:
		var output = upgradeClicker(costn[3], nonsuscount[3])
		costn[3] = output[0]
		nonsuscount[3] = output[1]
		natgas.text = 'Natural Gas: %s \n Cost: %d kW \n Produces 15 kW/s' %[nonsuscount[3], costn[3]]

func _on_oil_rig_pressed() -> void:
	if power >= costn[4]:
		var output = upgradeClicker(costn[4], nonsuscount[4])
		costn[4] = output[0]
		nonsuscount[4] = output[1]
		oilrig.text = 'Oil Rig: %s \n Cost: %d kW \n Produces 50 kW/s' %[nonsuscount[4], costn[4]]

func _on_n_fission_pressed() -> void:
	if power >= costn[5]:
		var output = upgradeClicker(costn[5], nonsuscount[5])
		costn[5] = output[0]
		nonsuscount[5] = output[1]
		nfission.text = 'Nuclear Fission: %s \n Cost: %d kW \n Produces 1000 kW/s' %[nonsuscount[5], costn[5]]

func _on_tree_pressed() -> void:
	if power >= coste[0]:
		var output = enhacement(coste[0], encount[0])
		print(encount[0])
		coste[0] = output[0]
		encount[0] = output[1]
		tree.text = 'Trees: %s \n Cost: %d kW \n +1 Multiplier' %[encount[0], coste[0]]
		if output[2] == 1:
			tree.disabled = true
			#encount +1 because it doesnt like when the button disaables for some reason
			tree.text = 'Trees: %s \n MAX UPGRADES \n +1 Multiplier' %(encount[0]+1)

func _on_bus_pressed() -> void:
	if power >= coste[1]:
		var output = enhacement(coste[1], encount[1])
		print(encount[1])
		coste[1] = output[0]
		encount[1] = output[1]
		bus.text = 'Busses: %s \n Cost: %d kW \n +X Multiplier' %[encount[1], coste[1]]
		if output[2] == 1:
			bus.disabled = true
			bus.text = 'Busses: %s \n MAX UPGRADES \n +X Multiplier' %(encount[1]+1)

func _on_ev_pressed() -> void:
	if power >= coste[2]:
		var output = enhacement(coste[2], encount[2])
		print(encount[2])
		coste[2] = output[0]
		encount[2] = output[1]
		ev.text = 'Electric Cars: %s \n Cost: %d kW \n +X Multiplier' %[encount[2], coste[2]]
		if output[2] == 1:
			ev.disabled = true
			ev.text = 'Electric Cars: %s \n MAX UPGRADES \n +X Multiplier' %(encount[2]+1)

func _on_train_pressed() -> void:
	if power >= coste[3]:
		var output = enhacement(coste[3], encount[3])
		print(encount[3])
		coste[3] = output[0]
		encount[3] = output[1]
		train.text = 'Metro: %s \n Cost: %d kW \n +X Multiplier' %[encount[3], coste[3]]
		if output[2] == 1:
			train.disabled = true
			train.text = 'Metro: %s \n MAX UPGRADES \n +X Multiplier' %(encount[3]+1)

func _on_s_apartment_pressed() -> void:
	if power >= coste[4]:
		var output = enhacement(coste[4], encount[4])
		print(encount[4])
		coste[4] = output[0]
		encount[4] = output[1]
		sApartment.text = 'Solar Buildings: %s \n Cost: %d kW \n +X Multiplier' %[encount[4], coste[4]]
		if output[2] == 1:
			sApartment.disabled = true
			sApartment.text = 'Solar Buildings: %s \n MAX UPGRADES \n +X Multiplier' %(encount[4]+1)
