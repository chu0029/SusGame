extends Label

@export var headlinetimer: Timer

#array to store messages that the headline can display
var headlines = [
	'Confused? Hover over text to see what stuff does.',
	'Earth is now 1.5 degrees hotter than it was in pre-industrial times.',
	'60 people in a diesel bus would emit 1/6 smog than if they were all in cars.',
	'The country Tuvalu will likely be completely underwater by 2050.',
	"You can't regain health, as this is how it is in real life."
]
var startmsg = [
	'Welcome to INSERT GAME NAME',
	'Here, you get to upgrade a factory to power this city',
	'Try to be sustainable tho',
	'This box will display tips for the game and facts about global warming',
	'Ms Magalona please give us a good score'
]

var i: int = 0

#shuffle the headlines to make it appear random
func _ready() -> void:
	headlines.shuffle()
	#print(headlines)
	for i in range(startmsg.size()): #show start messages
		var tween = get_tree().create_tween()
		await get_tree().create_timer(10).timeout
		tween.tween_property(self, "position", Vector2(16, 36), 0.5) 
		tween.tween_property(self, "position", Vector2(16, 4), 0.5)
		await get_tree().create_timer(0.5).timeout
		self.text = startmsg[i]
		i += 1
	headlinetimer.start()
	print('hello')

#after headlines timer timesout
func _on_headline_timer_timeout() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(16, 36), 0.5) 
	tween.tween_property(self, "position", Vector2(16, 4), 0.5)
	await get_tree().create_timer(0.5).timeout
	self.text = headlines[i] #use i to keep track of what number headline
	print(headlines[i], '|', i)
	if i+1 < headlines.size(): #i+1 is used as i starts at 0
		i += 1
	else: #once end of array reached, shuffle again and reset i
		headlines.shuffle()
		i = 0
	#print('hello')
