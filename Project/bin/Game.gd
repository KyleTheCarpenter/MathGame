extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pos = true
var level = 1
var score = 0
var time = 0
var timeMax = 30
var timed = true
var questions = []
var answers = []
var scores = []
var correct = []
var diff = 10
var pause = false
var opperator = 1
var gameMode = "Opperator" #Opperator,Fraction,Algebra
var timeMode = "Time" #Time,Ammount
var alg1 
var alg2 
var algopp = ""
var algans
var bedmas = false
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Clock").start()
	reset()

func reset():
	match gameMode:
		"Opperator":
			get_node("num1").text = setNumbers()
			get_node("num2").text = setNumbers()
			
			if int(get_node("num1").text) < int(get_node("num2").text):
				var temp = get_node("num1").text
				get_node("num1").text = get_node("num2").text
				get_node("num2").text = temp
				print("switched")

			
			get_node("operator").text = setOperator()
			
			get_node("timemax").text = str(timeMax)

		"Algebra":
			get_node("timemax").text = str(timeMax)
			print("algebra")
			algopp = ""
			get_node("num1").visible = false
			get_node("num2").visible = false
			get_node("operator").visible = false
			get_node("num3").visible = true
			get_node("algebra").visible = true

			alg1 = setNumbers()
			alg2 = setNumbers()
			algopp = setOperator()
			
			match algopp:
				"+": algans = int(alg1) + int(alg2)
				"-": algans = int(alg1) - int(alg2)
				"x": algans = int(alg1) * int(alg2)

			get_node("num3").text = "A "+ algopp + " "+ str(alg2) + " = "+str(algans)
			

func insertNumber0():
	if get_node("data").text.length() < 9:
		get_node("data").text+="0"

func insertNumber1():
	if get_node("data").text.length() < 9:
		get_node("data").text+="1"

func insertNumber2():
	if get_node("data").text.length() < 9:
		get_node("data").text+="2"

func insertNumber3():
	if get_node("data").text.length() < 9:
		get_node("data").text+="3"

func insertNumber4():
	if get_node("data").text.length() < 9:
		get_node("data").text+="4"

func insertNumber5():
	if get_node("data").text.length() < 9:
		get_node("data").text+="5"
	
func insertNumber6():
	if get_node("data").text.length() < 9:
		get_node("data").text+="6"

func insertNumber7():
	if get_node("data").text.length() < 9:
		get_node("data").text+="7"

func insertNumber8():
	if get_node("data").text.length() < 9:
		get_node("data").text+="8"

func insertNumber9():
	if get_node("data").text.length() < 9:
		get_node("data").text+="9"

func eraseNumber():
	
	var temp = get_node("data").text
	
	temp.erase(temp.length()-1,1)
	get_node("data").text = temp
	if temp == "":
		pos = true


func insertNegative():

	if pos == true:
		var temp = get_node("data").text
		get_node("data").text = "-"
		get_node("data").text+=temp
		pos = false
	elif pos == false:
		var temp = get_node("data").text
		temp.erase(0,1)
		get_node("data").text =temp
		pos = true
var near = false
func clockout():
	if timeMode == "Ammount":
		get_node("Clock").stop()
	if timeMode == "Time":
		time+=1
		if time >= timeMax-10:    
			if near == false:
				get_node("anime2").play("blink")
				get_node("time2").add_color_override("font_color", Color(255,0,0))
				near = true
		if time >= timeMax+1:
			endGame()
		get_node("time2").text = str(time)

		

func clearNumber():
	get_node("data").text= ""
	pos = true

func setOperator():
	var rand_generate = RandomNumberGenerator.new()
	rand_generate.randomize()

	match opperator:
		1:
			var rand_int = rand_generate.randi_range(1,3)
			match rand_int:
				1:return "+"
				2:return "-"
				3:return "x"
		2: return "+"
		3: return "-"
		4: return "x"
		5: 
			var rand_int = rand_generate.randi_range(1,2)
			match rand_int:
				1:return "+"
				2:return "-"
				
		6:	bedmas = true	

		
		

func setNumbers():
	var rand_generate = RandomNumberGenerator.new()
	rand_generate.randomize()
	var rand_int = rand_generate.randi_range(1,diff)
	
	return str(rand_int)



func submitAnswer():

	if not pause && get_node("data").text != "":
		if gameMode == "Opperator":
			var answer
			var num1 = int(get_node("num1").text)
			var num2 = int(get_node("num2").text)
			
			match get_node("operator").text:
				"+":
					answer = num1+num2
				"-":
					answer = num1-num2
				"x":
					answer = num1*num2
				"/":
					answer = num1/num2
			var sendtoArray = str(num1)+" "+get_node("operator").text+" "+str(num2) + " = " +get_node("data").text
			
			if (answer == int(get_node("data").text)):
				score+=1
				sendtoArray+=" | Correct"
				correct.append("y")
			else:
				sendtoArray+= " | Wrong | "+str(answer)+" is correct"
				correct.append("n")
			questions.append(sendtoArray)

			#RESET
			reset()
			pos = true
			get_node("data").text = ""


			get_node("Timer").start()
			level+=1
			get_node("level").text = str(level)
			get_node("time").text = str(score)
			get_node("anime").play("load")
			pause = true

			if timeMode == "Ammount":
				time+=1
				get_node("time2").text = str(time)
				if time >= timeMax:
					endGame()

		if gameMode == "Algebra":
			var sendtoArray = "A("+get_node("data").text+") "+algopp+" "+alg2 + " = " +str(algans)
			
			if (alg1 == get_node("data").text):
				score+=1
				sendtoArray+=" | Correct"
				correct.append("y")
			else:
				sendtoArray+= " | Wrong | A is " + alg1
				correct.append("n")
			questions.append(sendtoArray)

			#RESET
			reset()
			pos = true
			get_node("data").text = ""


			get_node("Timer").start()
			level+=1
			get_node("level").text = str(level)
			get_node("time").text = str(score)
			get_node("anime").play("load")
			pause = true

			if timeMode == "Ammount":
				time+=1
				get_node("time2").text = str(time)
				if time >= timeMax:
					endGame()


func timeout():
	get_node("Timer").stop() 
	pause = false


func endGame():
	var fin = preload("res://scenes/Finish.tscn").instance()
	get_parent().add_child(fin)
	for items in questions:
		fin.addQuestion(items)
	fin.get_node("data").text = str(score)+" Correct out of "+ str(questions.size())

	var i = 0
	for items in correct: #fin.items:
		if items == "n":
			fin.items[i].get_node("red").visible = true
		i+=1

	get_parent().remove_child(self)

	

	
	#get_parent().remove_child(self)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
