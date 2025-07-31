extends Control #this means use the properties of 'control' (get its attributes) and then add extra code to it (which is what we're doing below)

@export var counter: RichTextLabel #get information/data/input/output from that label node
@export var multipcounter: Label
@export var kwslabel: Label
@export var timer: Timer
@export var factory: TextureButton

@export var soundfactory: AudioStreamPlayer #export sounds
@export var soundfactorydown: AudioStreamPlayer
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

#export decals for the factory
@export var solaSpriteS: TextureRect
@export var windSpriteS: TextureRect
@export var biomSpriteS: TextureRect
@export var geotSpriteS: TextureRect
@export var hydrSpriteS: TextureRect
@export var fusiSpriteS: TextureRect

@export var inciSpriteN: TextureRect
@export var coalSpriteN: TextureRect
@export var advaSpriteN: TextureRect
@export var natuSpriteN: TextureRect
@export var oilrSpriteN: TextureRect
@export var fissSpriteN: TextureRect
# Called when the node enters the scene tree for the first time.
func _ready() -> void: #this is the scratch 'on start' block
	bgm.play()
	solaSpriteS.hide()
	windSpriteS.hide()
	biomSpriteS.hide()
	geotSpriteS.hide()
	hydrSpriteS.hide()
	fusiSpriteS.hide()

	inciSpriteN.hide()
	coalSpriteN.hide()
	advaSpriteN.hide()
	natuSpriteN.hide()
	oilrSpriteN.hide()
	fissSpriteN.hide()

func _process(delta: float) -> void: #on every frame...
	UpdateLabelText()
	#print(global.susUpgCount, '|', global.totalUpgCount, '|', global.sustainability)

	
func UpdateLabelText() -> void:
	counter.text = "%s kW" %global.power
	multipcounter.text = "Multiplier: %s" %global.multiplier
	global.kws = (
		global.solarpanelcount + global.windturbinecount*5 + global.biomasscount*30 + global.geothermalplantcount*50 + 
		global.hydroelectricdamcount*400 + global.nuclearfusioncount*2000 + global.nonsuscount[0] + 
		global.nonsuscount[1]*5 + global.nonsuscount[2]*30 + global.nonsuscount[3]*50 + global.nonsuscount[4]*400 + 
		global.nonsuscount[5]*2000
		)
	global.multiplier = 1+(
		global.encount[0]*1+global.encount[1]*10+global.encount[2]*200+global.encount[3]*2500+global.encount[4]*5000
		)
	kwslabel.text = '%s kilowatts/sec' %global.kws
	$sustainability/susbar.value = global.sustainability
	$health/healthbar.value = global.health
	#sustainable upgrade text update
	solarpanel.text = 'Solar Panel: %s \n Cost: %d kW \n Produces 1 kW/s' %[global.solarpanelcount,global.costs[0]]
	windturbine.text = 'Wind Turbine: %s \n Cost: %d kW \n Produces 5 kW/s' %[global.windturbinecount,global.costs[1]]
	biomass.text = 'Biomass Boiler: %s \n Cost: %d kW \n Produces 30 kW/s' %[global.biomasscount,global.costs[2]]
	geothermalplant.text = 'Geothermal Plant: %s \n Cost: %d kW \n Produces 50 kW/s' %[global.geothermalplantcount,global.costs[3]]
	hydroelectricdam.text = 'Hydroelectric Dam: %s \n Cost: %d kW \n Produces 400 kW/s' %[global.hydroelectricdamcount,global.costs[4]]
	nuclearfusion.text = 'Nuclear Fusion: %s \n Cost: %d kW \n Produces 2000 kW/s' %[global.nuclearfusioncount,global.costs[5]]
	#unsustainable
	incineratorplant.text = 'Incinerator Plant: %s \n Cost: %d kW \n Produces 1 kW/s' %[global.nonsuscount[0], global.costn[0]]
	coal.text = 'Coal Burner: %s \n Cost: %d kW \n Produces 5 kW/s' %[global.nonsuscount[1], global.costn[1]]
	advcoal.text = 'Advanced Coal: %s \n Cost: %d kW \n Produces 30 kW/s' %[global.nonsuscount[2], global.costn[2]]
	natgas.text = 'Natural Gas: %s \n Cost: %d kW \n Produces 50 kW/s' %[global.nonsuscount[3], global.costn[3]]
	oilrig.text = 'Oil Rig: %s \n Cost: %d kW \n Produces 400 kW/s' %[global.nonsuscount[4], global.costn[4]]
	nfission.text = 'Nuclear Fission: %s \n Cost: %d kW \n Produces 2000 kW/s' %[global.nonsuscount[5], global.costn[5]]

	if global.encount[0] <3: #if there are less than 3 items purchased alr
		tree.text = 'Trees: %s \n Cost: %d kW \n +1 Multiplier' %[global.encount[0], global.coste[0]]
		if global.encount[0] > 0:
			pass
	else:
		tree.text = 'Trees: %s \n MAX UPGRADES \n +1 Multiplier' %(global.encount[0])
		tree.disabled = true

	if global.encount[1] <3: #if there are less than 3 items purchased alr
		bus.text = 'Busses: %s \n Cost: %d kW \n +10 Multiplier' %[global.encount[1], global.coste[1]]
		if global.encount[1] > 0:
			pass
	else:
		bus.text = 'Busses: %s \n MAX UPGRADES \n +10 Multiplier' %(global.encount[1])
		bus.disabled = true

	if global.encount[0] <3: #if there are less than 3 items purchased alr
		tree.text = 'Trees: %s \n Cost: %d kW \n +1 Multiplier' %[global.encount[0], global.coste[0]]
		if global.encount[0] > 0:
			pass
	else:
		tree.text = 'Trees: %s \n MAX UPGRADES \n +1 Multiplier' %(global.encount[0])
		tree.disabled = true

	if global.encount[0] <3: #if there are less than 3 items purchased alr
		tree.text = 'Trees: %s \n Cost: %d kW \n +1 Multiplier' %[global.encount[0], global.coste[0]]
		if global.encount[0] > 0:
			pass
	else:
		tree.text = 'Trees: %s \n MAX UPGRADES \n +1 Multiplier' %(global.encount[0])
		tree.disabled = true

	if global.encount[0] <3: #if there are less than 3 items purchased alr
		tree.text = 'Trees: %s \n Cost: %d kW \n +1 Multiplier' %[global.encount[0], global.coste[0]]
		if global.encount[0] > 0:
			pass
	else:
		tree.text = 'Trees: %s \n MAX UPGRADES \n +1 Multiplier' %(global.encount[0])
		tree.disabled = true





func CreatePower() -> void: #global.power created from clicking the thing
	global.power += 1 * global.multiplier
	global.totalUpgCount += 1*global.multiplier
	global.susUpgCount += 1*global.multiplier

func AutoFactory() -> void: 
	global.sustainability = (global.susUpgCount*1.2/global.totalUpgCount)*100 #1.2 for balencing issues
	#print(global.susUpgCount, '|', global.totalUpgCount, '|', global.sustainability)
	if global.sustainability < 70: #and global.sustainability > 0 ?
		global.health -= 1
	global.susUpgCount += ( #amt of global.power generated by sus upgrades
		global.solarpanelcount + global.windturbinecount*5 + global.biomasscount*30 + global.geothermalplantcount*50 + 
		global.hydroelectricdamcount*400 + global.nuclearfusioncount*2000
	)
	global.totalUpgCount += ( #amt of total global.power
		global.solarpanelcount + global.windturbinecount*5 + global.biomasscount*30 + global.geothermalplantcount*50 + 
		global.hydroelectricdamcount*400 + global.nuclearfusioncount*2000 + global.nonsuscount[0] + 
		global.nonsuscount[1]*5 + global.nonsuscount[2]*30 + global.nonsuscount[3]*50 + global.nonsuscount[4]*400 + 
		global.nonsuscount[5]*2000
	)
	global.power += 1 * global.automult
	global.power += 1 * global.solarpanelcount
	global.power += 5 * global.windturbinecount
	global.power += 30 * global.biomasscount
	global.power += 50 * global.geothermalplantcount
	global.power += 400 * global.hydroelectricdamcount
	global.power += 2000 * global.nuclearfusioncount
	global.power += 1 * global.nonsuscount[0]
	global.power += 5 * global.nonsuscount[1]
	global.power += 30 * global.nonsuscount[2]
	global.power += 50 * global.nonsuscount[3]
	global.power += 400 * global.nonsuscount[4]
	global.power += 2000 * global.nonsuscount[5]
	if global.health <= 0:
		get_tree().change_scene_to_file("res://scenes/death.tscn")

func _on_factory_button_down() -> void:
	CreatePower()
	soundfactory.play()
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(factory, "scale", Vector2(1.02, 1.02), 0.1)

func _on_factory_button_up() -> void:
	soundfactorydown.play()
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(factory, "scale", Vector2(1, 1), 0.1)

#DELETE THIS DELETE THIS DELETE THIS DELETE THIS DELETE THIS DELETE THIS 
func _on_multiplier_pressed() -> void:
	global.multiplier += 1
	soundupgrade.play()
	bgm.play()
	
'''func _on_autoclicker_pressed() -> void:
	if global.power >= AutoclickC:
		timer.start()
		global.automult += 1
		global.power -= 10
		AutoclickC = round(AutoclickC*1.5)
		autoclicker.text = 'Autoclicker \n %s kWh' %int(AutoclickC)
		soundupgrade.play()'''

func _on_timer_timeout() -> void:
	AutoFactory()

#universal function for upgrading, with two arguments; itemCost and itemCount. Declare these when u call it later.
func upgradeClicker(itemCost, itemCount):
	itemCount += 1
	global.power -= itemCost
	itemCost = round(itemCost*1.25)
	soundupgrade.play()
	#global.totalUpgCount += 1
	return [itemCost, itemCount]

#UNIVERSAL FUNCTION FOR ALL ENHAMCEMENTS
func enhacement(itemCost, itemCount):
	itemCount += 1
	global.power -= itemCost
	if itemCount <3: #if there are less than 3 items purchased alr
		
		
		itemCost = round(itemCost*2)
		soundupgrade.play()
		return [itemCost, itemCount, 0]
	else:
		return [itemCost, itemCount, 1]
	
func _on_solarpanel_pressed() -> void:
	if global.power >= global.costs[0]:
		var output = upgradeClicker(global.costs[0], global.solarpanelcount)
		global.costs[0] = output[0]
		global.solarpanelcount = output[1]
		solaSpriteS.show()
	'''	if global.power >= global.costs[0]:
		timer.start()
		global.solarpanelcount += 1
		global.power -= 100
		global.costs[0] = round(global.costs[0]*1.25)
		global.solarpanel.text = 'Solar Panel: %s \n Cost: %d kW \n Produces 1 kW/s' %[global.solarpanelcount,global.costs[0]]
		print(global.costs[0])
		soundupgrade.play()'''

func _on_windturbine_pressed() -> void:
	if global.power >= global.costs[1]:
		var output = upgradeClicker(global.costs[1], global.windturbinecount)
		global.costs[1] = output[0]
		global.windturbinecount = output[1]
		windSpriteS.show()
		#print(global.costs[1])
		#global.susUpgCount +=1

func _on_biomass_pressed() -> void:
	if global.power >= global.costs[2]:
		var output = upgradeClicker(global.costs[2], global.biomasscount)
		global.costs[2] = output[0]
		global.biomasscount = output[1]
		biomSpriteS.show()

func _on_geothermalplant_pressed() -> void: #global.costs[3]
	if global.power >= global.costs[3]:
		var output = upgradeClicker(global.costs[3], global.geothermalplantcount)
		global.costs[3] = output[0]
		global.geothermalplantcount = output[1]
		geotSpriteS.show()

func _on_hydroelectricdam_pressed() -> void: #global.costs[4]
	if global.power >= global.costs[4]:
		var output = upgradeClicker(global.costs[4], global.hydroelectricdamcount)
		global.costs[4] = output[0]
		global.hydroelectricdamcount = output[1]
		hydrSpriteS.show()

func _on_nuclearfusion_pressed() -> void: #global.costs[5]
	if global.power >= global.costs[5]:
		var output = upgradeClicker(global.costs[5], global.nuclearfusioncount)
		global.costs[5] = output[0]
		global.nuclearfusioncount = output[1]
		fusiSpriteS.show()
	'''if global.power >= 1000000:
		timer.start()
		global.nuclearfusioncount += 1
		global.power -= 1000000
		global.nuclearfusion.text = 'Nuclear Fusion: %s \n Cost: 1000000 kW \n Produces 1000 kW/s' %global.nuclearfusioncount
		soundupgrade.play()'''

func _on_inc_plant_pressed() -> void:
	if global.power >= global.costn[0]:
		var output = upgradeClicker(global.costn[0], global.nonsuscount[0])
		global.costn[0] = output[0]
		global.nonsuscount[0] = output[1]
		inciSpriteN.show()

func _on_coal_pressed() -> void:
	if global.power >= global.costn[1]:
		var output = upgradeClicker(global.costn[1], global.nonsuscount[1])
		global.costn[1] = output[0]
		global.nonsuscount[1] = output[1]
		coalSpriteN.show()

func _on_adv_coal_pressed() -> void:
	if global.power >= global.costn[2]:
		var output = upgradeClicker(global.costn[2], global.nonsuscount[2])
		global.costn[2] = output[0]
		global.nonsuscount[2] = output[1]
		advaSpriteN.show()

func _on_nat_gas_pressed() -> void:
	if global.power >= global.costn[3]:
		var output = upgradeClicker(global.costn[3], global.nonsuscount[3])
		global.costn[3] = output[0]
		global.nonsuscount[3] = output[1]
		natuSpriteN.show()

func _on_oil_rig_pressed() -> void:
	if global.power >= global.costn[4]:
		var output = upgradeClicker(global.costn[4], global.nonsuscount[4])
		global.costn[4] = output[0]
		global.nonsuscount[4] = output[1]
		oilrSpriteN.show()

func _on_n_fission_pressed() -> void:
	if global.power >= global.costn[5]:
		var output = upgradeClicker(global.costn[5], global.nonsuscount[5])
		global.costn[5] = output[0]
		global.nonsuscount[5] = output[1]
		fissSpriteN.show()

func _on_tree_pressed() -> void:
	if global.power >= global.coste[0]:
		var output = enhacement(global.coste[0], global.encount[0])
		print(global.encount[0])
		global.coste[0] = output[0]
		global.encount[0] = output[1]
	'''	tree.text = 'Trees: %s \n Cost: %d kW \n +1 Multiplier' %[global.encount[0], global.coste[0]]
		if output[2] == 1:
			tree.disabled = true
			#global.encount +1 because it doesnt like when the button disaables for some reason
			#note: this has been fixed
			tree.text = 'Trees: %s \n MAX UPGRADES \n +1 Multiplier' %(global.encount[0])'''

func _on_bus_pressed() -> void:
	if global.power >= global.coste[1]:
		var output = enhacement(global.coste[1], global.encount[1])
		print(global.encount[1])
		global.coste[1] = output[0]
		global.encount[1] = output[1]

func _on_ev_pressed() -> void:
	if global.power >= global.coste[2]:
		var output = enhacement(global.coste[2], global.encount[2])
		print(global.encount[2])
		global.coste[2] = output[0]
		global.encount[2] = output[1]
		ev.text = 'Electric Cars: %s \n Cost: %d kW \n +200 Multiplier' %[global.encount[2], global.coste[2]]
		if output[2] == 1:
			ev.disabled = true
			ev.text = 'Electric Cars: %s \n MAX UPGRADES \n +200 Multiplier' %(global.encount[2])

func _on_train_pressed() -> void:
	if global.power >= global.coste[3]:
		var output = enhacement(global.coste[3], global.encount[3])
		print(global.encount[3])
		global.coste[3] = output[0]
		global.encount[3] = output[1]
		train.text = 'Metro: %s \n Cost: %d kW \n +2500 Multiplier' %[global.encount[3], global.coste[3]]
		if output[2] == 1:
			train.disabled = true
			train.text = 'Metro: %s \n MAX UPGRADES \n +2500 Multiplier' %(global.encount[3])

func _on_s_apartment_pressed() -> void:
	if global.power >= global.coste[4]:
		var output = enhacement(global.coste[4], global.encount[4])
		print(global.encount[4])
		global.coste[4] = output[0]
		global.encount[4] = output[1]
		sApartment.text = 'Solar Buildings: %s \n Cost: %d kW \n +5000 Multiplier' %[global.encount[4], global.coste[4]]
		if output[2] == 1:
			sApartment.disabled = true
			sApartment.text = 'Solar Buildings: %s \n MAX UPGRADES \n +5000 Multiplier' %(global.encount[4])
