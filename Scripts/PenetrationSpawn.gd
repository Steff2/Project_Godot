# Variablen die getestet oder verändert werden können:
# exitTime - reguliert die Dauer bis die Szene endet und der export passiert
extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	
	PositionAndCollision.sceneName = "Penetration"
	PositionAndCollision.spawnRate = ""
	PositionAndCollision.exitTime = 5
