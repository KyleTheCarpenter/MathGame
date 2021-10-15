extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func tutorialPressed():
	var newGame = preload("res://scenes/Tutorial.tscn").instance()
	get_parent().add_child(newGame)
	#get_parent().remove_child(self)
	visible = false
func creditPressed():
	var newGame = preload("res://scenes/credits.tscn").instance()
	get_parent().add_child(newGame)
	#get_parent().remove_child(self)
	visible = false
func playPressed():
	var newGame = preload("res://scenes/loader.tscn").instance()
	get_parent().add_child(newGame)
	#get_parent().remove_child(self)
	visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
