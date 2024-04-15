extends Node
var bestScore = 0;
var lastscore;

func _ready():
	bestScore = 0;

func set_score(newScore : int):
	lastscore = newScore;
	if newScore > bestScore: bestScore = newScore;
