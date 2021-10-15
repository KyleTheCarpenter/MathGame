extends Sprite

var nextState = "Start"
func backButPressed():
	get_parent().get_node("Main").visible = true
	get_parent().remove_child(self)

func play():
	get_node("anime").play(nextState)

func _ready():
	play()


func nextPressed():
	match nextState:
		"Start":
			nextState = "one"
			play()
			return
		"one":
			nextState = "two"
			#play()
			return

