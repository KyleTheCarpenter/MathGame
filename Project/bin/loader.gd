extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var diffCount = 1
var opperatorCount = 1
var timeCount = 1
var questionCount = 1
var subjectCount = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("anime").play("load")
	changeOpperator()
	changeTime()
	changeDiff()
	changeSubject()
	changeQuestion()


func startGame():
	var newGame = preload("res://scenes/Game.tscn").instance()
	get_parent().add_child(newGame)




	

	

	match diffCount:
		1: newGame.diff = 10
		2: newGame.diff = 20
		3: newGame.diff = 100
		4: newGame.diff = 1000


	match subjectCount:
		1:newGame.gameMode = "Opperator"
		2:newGame.gameMode = "Algebra"
		3:newGame.gameMode = "Fraction"

	match questionCount:
		2: 
			newGame.timeMode = "Time"
			match timeCount:
				1: newGame.timeMax = 30
				2: newGame.timeMax = 60
				3: newGame.timeMax = 120
				4: newGame.timeMax = 240
				5: newGame.timeMax = 6000
				6: newGame.timed = false


		1: 
			newGame.timeMode = "Ammount"
			match timeCount:
				1: newGame.timeMax = 5
				2: newGame.timeMax = 10
				3: newGame.timeMax = 20
				4: newGame.timeMax = 30
				5: newGame.timeMax = 50
	newGame.opperator = opperatorCount
	newGame.reset()
	get_parent().remove_child(self)
	
func changeSubject():
	match subjectCount:
		1:get_node("choice/data2").text = "Normal"
		2:get_node("choice/data2").text = "Algebra"
		

func changeQuestion():
	match questionCount:
		2:get_node("choice/data3").text = "Time"
		1:get_node("choice/data3").text = "Ammount"

func changeDiff():
	match diffCount:
		1: get_node("choice/diff").text = "Up to 10"
		2: get_node("choice/diff").text = "Up to 20"
		3: get_node("choice/diff").text = "Up to 100"
		4: get_node("choice/diff").text = "Up to 1000"
	
func changeTime():
	match questionCount:
		2:
			match timeCount:
				1: get_node("choice/time").text = "0:30"
				2: get_node("choice/time").text = "1:00"
				3: get_node("choice/time").text = "2:00"
				4: get_node("choice/time").text = "4:00"
				5: get_node("choice/time").text = "10:00"
		1:
			match timeCount:
				1: get_node("choice/time").text = "5"
				2: get_node("choice/time").text = "10"
				3: get_node("choice/time").text = "20"
				4: get_node("choice/time").text = "30"
				5: get_node("choice/time").text = "50"
			

func changeOpperator():
	match opperatorCount:
		1: get_node("choice/oppe").text = "+ - x"
		2: get_node("choice/oppe").text = "+"
		3: get_node("choice/oppe").text = "-"
		4: get_node("choice/oppe").text = "x"
		5: get_node("choice/oppe").text = "+ -"
		6:get_node("choice/oppe").text = "PEMDAS"
		
func timeLeft():
	if timeCount > 1:
		timeCount-=1
		changeTime()

func timeRight():
	if timeCount < 5:
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
	if opperatorCount < 5:
		opperatorCount+=1
		changeOpperator()
	
func timerDone():
	get_node("Timer").stop()
	get_node("choice").visible = true
	get_node("anime").play("blink")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func subjectRight():
	if subjectCount < 2:
		subjectCount+=1
		changeSubject()

func subjectLeft():
	if subjectCount > 1:
		subjectCount-=1
		changeSubject()

func questionRight():
	if questionCount < 2:
		questionCount+=1
		changeQuestion()
		changeTime()

func questionLeft():
	if questionCount > 1:
		questionCount-=1
		changeQuestion()
		changeTime()
