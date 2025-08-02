extends Label

@export var headlinetimer: Timer

#array to store messages that the headline can display
var headlines = [
	'Confused? Hover over text to see what stuff does.',
	'Earth is now 1.5 degrees hotter than it was in pre-industrial times.',
	'60 people in a diesel bus would emit 1/6 smog than if they were all in cars.',
	'The country Tuvalu will likely be completely underwater by 2050.',
	"You can't regain health, as this how Earth is in real life.",
	"Read more about the UN's sustainability development goal No. 11.",
	"1.12 billion live in slums or informal settlements without basic services.",
	'Press the ESCAPE key to access settings.',
	'90% of coral reefs succumb to bleaching, even the Great Barrier Reef.',
	'Polar bear population set to decline by 30% in 2050',
	"The north of Jakarta, Indonesia's capital, has sunk!",
	'Clicking ever so slightly increases sustainability.'
]
var startmsg = [
	'Welcome to Factory Worker!',
	'Here, you get to upgrade a factory to power this city',
	'Try to be sustainable tho',
	'This box will display tips for the game and facts about global warming',
	'Press the ESCAPE key to access settings.',
	'Ms Magalona please give us a good score'
]

var i: int = 0

#shuffle the headlines to make it appear random, but without repeats
func _ready() -> void:
	headlines.shuffle()
	#print(headlines)
	self.text = ''
	await get_tree().create_timer(0).timeout
	#print(i)
	for i in range(startmsg.size()): #show start messages
		#print(startmsg[i], '|', i)
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(16, 36), 0.5) 
		tween.tween_property(self, "position", Vector2(16, 4), 0.5)
		await get_tree().create_timer(0.5).timeout
		self.text = startmsg[i]
		await get_tree().create_timer(10).timeout
		i += 1
	headlinetimer.start()
	#print('hello')

#after headlines timer timesout
func _on_headline_timer_timeout() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(16, 36), 0.5) 
	tween.tween_property(self, "position", Vector2(16, 4), 0.5)
	await get_tree().create_timer(0.5).timeout
	self.text = headlines[i] #use i to keep track of what number headline
	#print(headlines[i], '|', i)
	if i+1 < headlines.size(): #i+1 is used as i starts at 0
		i += 1
	else: #once end of array reached, shuffle again and reset i
		headlines.shuffle()
		i = 0
	#print('hello')

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/settings_menu.tscn")
