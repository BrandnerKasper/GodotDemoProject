extends CanvasLayer


signal start_game


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func show_message(text: String):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Game Over!")
	# yield == WAIT
	yield($MessageTimer, "timeout")

	$Message.text = "Dodge the Creeps!"
	$Message.show()

	# You can create a timer in code too for short delays
	yield(get_tree().create_timer(1), "timeout")
	$Start.show()


func update_score(score: int):
	$Score.text = str(score)


func _on_Start_pressed():
	$Start.hide()
	emit_signal("start_game")


func _on_MessageTimer_timeout():
	$Message.hide()
	