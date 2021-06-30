''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 5, june 2018
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  Roxel (rock + pixel) base physical component
''
''*******************************************************************************

Type RoxelType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub ComputeNewState()
	
	As LinearStateType LinearState
	
	As Single radius
	As Single density
	As Single temperature
	
	As UInteger colour
	As UInteger material
	
End Type

Constructor RoxelType()
	
	radius      = 0.0
	density     = 0.0
	temperature = 0.0
	
	colour   = 0
	material = 0
	
End Constructor

Destructor RoxelType()

End Destructor

Sub RoxelType.ComputeNewState()
	
	LinearState.ComputeNewState()
	
End Sub
