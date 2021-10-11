extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var diffCount = 1
var opperatorCount = 1
var timeCount = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("anime").play("load")



func startGame():
	var newGame = preload("res://scenes/Game.tscn").instance()
	get_parent().add_child(newGame)




	match timeCount:
		1: newGame.timeMax = 30
		2: newGame.timeMax = 60
		3: newGame.timeMax = 120
		4: newGame.timed = false
		5: newGame.timed = false
		6: newGame.timed = false



	match diffCount:
		1: newGame.diff = 10
		2: newGame.diff = 50
		3: newGame.diff = 100
		4: newGame.diff = 250


	newGame.opperator = opperatorCount
	newGame.reset()
	get_parent().remove_child(self)
	

func changeDiff():
	match diffCount:
		1: get_node("choice/diff").text = "Easy"
		2: get_node("choice/diff").text = "Medium"
		3: get_node("choice/diff").text = "Hard"
		4: get_node("choice/diff").text = "Insane"
	
func changeTime():
	match timeCount:
		1: get_node("choice/time").text = "0:30"
		2: get_node("choice/time").text = "0:60"
		3: get_node("choice/time").text = "2:00"
		4: get_node("choice/time").text = "10 Q"
		5: get_node("choice/time").text = "20 Q"
		6: get_node("choice/time").text = "40 Q"
		

func changeOpperator():
	match opperatorCount:
		1: get_node("choice/oppe").text = "+-x"
		2: get_node("choice/oppe").text = "+"
		3: get_node("choice/oppe").text = "-"
		4: get_node("choice/oppe").text = "x"
		5: get_node("choice/oppe").text = "Algebra"
		
func timeLeft():
	if timeCount > 1:
		timeCount-=1
		changeTime()

func timeRight():
	if timeCount < 3:
		timeCount+=1
		changeTime()



func diffLeft():
	if diffCount > 1:
		diffCount-=1
		changeDiff()

func diffRight():
	if diffCount < 4:
		diffCount+=1
		changeDiff()

func opperatorLeft():
	if opperatorCount > 1:
		opperatorCount-=1
		changeOpperator()

func opperatorRight():
	if opperatorCount < 4:
		opperatorCount+=1
		changeOpperator()
	
func timerDone():
	get_node("Timer").stop()
	get_node("choice").visible = true
	get_node("anime").play("blink")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
