extends Node

var tiltDirection : Vector2 = Vector2.ZERO

signal platformDone() #called by platform thingy
signal newPlatfrom(index : int) # called by SM
signal dropPlatform() # called by SM
signal gameOver() # callded by platform thingy
