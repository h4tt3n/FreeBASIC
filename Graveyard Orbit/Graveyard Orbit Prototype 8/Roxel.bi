''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 2, september 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  Roxel (rock + pixel) particle class
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
