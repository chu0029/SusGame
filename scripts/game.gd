extends Control

var power: int = 0
var Cmult: int = 1
var Amult: int = 1
@export var label2 : Label
@export var label : RichTextLabel
@export var autoC : Label
var timer: Timer

func ClickerMultiplier() -> void:
	Cmult += 1

func _ready() -> void:
	Updatelabel()
	Updatelabel2()
	UpdateautoC()

func Updatelabel()-> void:
	label.text = "Powah: %s" %power
	
func Updatelabel2()-> void:
	label2.text = "multiplier: %s" %Cmult
	
func UpdateautoC()-> void:
	autoC.text = "autobots: %s" %Amult
	
func CreatePower() -> void:
	power += 1 * Cmult
	Updatelabel()

func _on_factory_pressed() -> void:
	CreatePower()

func _on_texture_button_pressed() -> void:
	ClickerMultiplier()
	Updatelabel2()

func createApower()->void:
	power+=1*Amult

func _on_button_pressed() -> void:
	createApower()
	UpdateautoC()


func _on_timer_timeout() -> void:
	createApower()
	UpdateautoC()
