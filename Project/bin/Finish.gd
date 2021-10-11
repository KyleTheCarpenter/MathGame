extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var yPos = 60
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func addQuestion(argS):
	var ques = preload("res://scenes/question.tscn").instance()
	ques.get_node("data").text = argS
	add_child(ques)
	ques.position.y = yPos
	yPos+=30
	
func retryPressed():
	get_parent().get_node("Main").visible = true
	get_parent().remove_child(self)
	
