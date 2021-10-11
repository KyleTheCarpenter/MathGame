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
var diff = 10
var opperator = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Clock").start()
	get_node("num1").text = setNumbers()
	get_node("num2").text = setNumbers()
	get_node("operator").text = setOperator()

func reset():
	get_node("num1").text = setNumbers()
	get_node("num2").text = setNumbers()
	get_node("operator").text = setOperator()
	get_node("timemax").text = str(timeMax)
func insertNumber0():
	get_node("data").text+="0"

func insertNumber1():
	get_node("data").text+="1"

func insertNumber2():
	get_node("data").text+="2"

func insertNumber3():
	get_node("data").text+="3"

func insertNumber4():
	get_node("data").text+="4"

func insertNumber5():
	get_node("data").text+="5"
	
func insertNumber6():
	get_node("data").text+="6"

func insertNumber7():
	get_node("data").text+="7"

func insertNumber8():
	get_node("data").text+="8"

func insertNumber9():
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
func clockout():
	time+=1
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
				

		
		

func setNumbers():
	var rand_generate = RandomNumberGenerator.new()
	rand_generate.randomize()
	var rand_int = rand_generate.randi_range(1,diff)
	return str(rand_int)


func submitAnswer():
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
	else:
		sendtoArray+= " | Wrong | "+str(answer)+" is correct"

	questions.append(sendtoArray)
	get_node("Timer").start()
	level+=1
	get_node("level").text = str(level)
	get_node("time").text = str(score)
	get_node("anime").play("load")

func timeout():
	get_node("data").text = ""
	get_node("Timer").stop() 
	pos = true
	get_node("num1").text = setNumbers()
	get_node("num2").text = setNumbers()
	get_node("operator").text = setOperator()


func endGame():
	var fin = preload("res://scenes/Finish.tscn").instance()
	get_parent().add_child(fin)
	for items in questions:
		fin.addQuestion(items)
	fin.get_node("data").text = str(score)
	get_parent().remove_child(self)

	
	#get_parent().remove_child(self)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
