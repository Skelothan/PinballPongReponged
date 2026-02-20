extends CanvasLayer


func update_score(player: int, score: int):
	if player == 1:
		$P1_Score.text = str(score)
	elif player == 2:
		$P2_Score.text = str(score)
