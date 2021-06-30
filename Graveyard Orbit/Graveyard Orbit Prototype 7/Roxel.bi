''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 7, february 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  Roxel (rock + pixel) base physical component
''
''*******************************************************************************

Type RoxelType Extends LinearStateType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub ComputeRadius()
	
	As Single radius
	As Single density
	As Single temperature
	
	As UInteger colour
	As UInteger material
	
End Type

Constructor RoxelType()
	
	Base()
	
	radius      = 0.0
	density     = 0.0
	temperature = 0.0
	
	colour   = 0
	material = 0
	
End Constructor

Destructor RoxelType()

End Destructor
