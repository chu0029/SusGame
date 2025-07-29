extends Node
#THESE ARE ALL THE GLOBAL VARIABLES IN THE GAME
var power: int = 10000 #set all variables needed to increase power
var multiplier : int = 1
var automult : int = 0

#costs to be stored in an array for tidying purposes
#IN ORDER: 0solar 1wind 2biomass 3geother 4hydroel 5nuclear
var costs = [25,100,500,10000,50000,1000000]
var costn = [10,50,250,5000,25000,500000]
var nonsuscount = [0,0,0,0,0,0]
var coste = [200,1000,5000,10000,50000]
var encount = [0,0,0,0,0]

#amount of sustainable upgrades player has acquired
var solarpanelcount : int = 0
var windturbinecount : int = 0
var biomasscount : int = 0
var geothermalplantcount : int = 0
var hydroelectricdamcount : int = 0
var nuclearfusioncount : int = 0

#variables that determine sustainability rating and health
var sustainability : float = 100 #use float otherwise godot tweaks out when division
var susUpgCount: float = 0
var totalUpgCount: float = 0
var health : int = 100
var kws: int = 0

func resetGame(): #CALLED WHENEVER HEALTH = 0
	power= 0 #set all variables needed to increase power
	multiplier = 1
	automult = 0

	#costs to be stored in an array for tidying purposes
	#IN ORDER: 0solar 1wind 2biomass 3geother 4hydroel 5nuclear
	costs = [25,100,500,10000,50000,1000000]
	costn = [10,50,250,5000,25000,500000]
	nonsuscount = [0,0,0,0,0,0]
	coste = [200,1000,5000,10000,50000]
	encount = [0,0,0,0,0]

	#amount of sustainable upgrades player has acquired
	solarpanelcount = 0
	windturbinecount = 0
	biomasscount = 0
	geothermalplantcount = 0
	hydroelectricdamcount = 0
	nuclearfusioncount = 0

	#variables that determine sustainability rating and health
	sustainability = 100 #use float otherwise godot tweaks out when division
	susUpgCount= 0
	totalUpgCount= 0
	health = 100
	kws= 0
	print('game reset')
