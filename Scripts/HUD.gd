extends CanvasLayer


func ready():
	clear_message()


func update_score(player: int, score: int):
	if player == 1:
		$P1_Score.text = str(score)
	elif player == 2:
		$P2_Score.text = str(score)


func display_message(message: String):
	$GameMessage.text = message
	$GameMessage.show()


func clear_message():
	$GameMessage.text = ""
	$GameMessage.hide()
