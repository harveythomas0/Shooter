extends Label


var score: float = 0


func increase_score(increase: float):
	score += increase
	text = str(score)
