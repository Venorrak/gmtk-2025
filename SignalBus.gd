extends Node

var tiltDirection : Vector2 = Vector2.ZERO

signal platformDone() #called by platform thingy
signal newPlatfrom(index : int) # called by SM
signal dropPlatform() # called by SM
signal fastDropPlatform() # called by SM
signal stopFastDrop()
signal gameOver() # callded by platform thingy

signal Change3DCameraTarget(body : Node3D)
