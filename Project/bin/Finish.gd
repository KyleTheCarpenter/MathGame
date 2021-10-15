extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var scrollMem = 0
var mouseMem = 0
var newMem = 0
var scrolling = false
var isBorder = false
var yPos = 60
var items = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func addQuestion(argS):
	var ques = preload("res://scenes/question.tscn").instance()
	ques.get_node("data").text = argS
	get_node("scroll").add_child(ques)
	ques.position.y = yPos
	yPos+=30
	if argS.length() > 42:
		ques.get_node("data").rect_scale.y =0.9
		ques.get_node("data").rect_scale.x = 0.9
	items.append(ques)
	
func retryPressed():
	get_parent().get_node("Main").visible = true##########################
	get_parent().remove_child(self)
	
func scrollClicked():
	scrollMem = get_node("scroller").position.y
	mouseMem = get_viewport().get_mouse_position().y
	scrolling = true

func ScrollButtonReleased():
	scrolling = false

func _process(_delta):
	if scrolling:
		if get_viewport().get_mouse_position().y < 50: 
			isBorder = true

		elif get_viewport().get_mouse_position().y > 850:
			 isBorder = true

		else:
			isBorder = false

		if (isBorder == false):
			newMem = get_viewport().get_mouse_position().y
			get_node("scroller").position.y = scrollMem - mouseMem+newMem
			
		
			
			if items.size()> 40:
				get_node("scroll").position.y = -get_node("scroller").position.y*2 
			else:
				get_node("scroll").position.y = -get_node("scroller").position.y 
			
