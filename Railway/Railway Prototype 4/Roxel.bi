''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 4, september 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  Roxel (rock + pixel) particle class
''
''*******************************************************************************

Type RoxelType Extends LinearStateType
	
	Declare Constructor()
	Declare Constructor( ByVal _mass As Single )
	Declare Constructor( ByVal _mass As Single, ByVal _position As Vec2 )
	Declare Constructor( ByVal _mass As Single, ByVal _position As Vec2, ByVal _radius As Single )
	
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

Constructor RoxelType( ByVal _mass As Single )
	
	mass = _mass
	
	ComputeRadius()
	
End Constructor

Constructor RoxelType( ByVal _mass As Single, ByVal _position As Vec2 )
	
	mass     = _mass
	position = _position
	
	ComputeRadius()
	
End Constructor

Constructor RoxelType( ByVal _mass As Single, ByVal _position As Vec2, ByVal _radius As Single )
	
	mass     = _mass
	position = _position
	radius   = _radius
	
End Constructor

Destructor RoxelType()

End Destructor

Sub RoxelType.ComputeRadius()
	
	radius = ( ( mass / C_DENSITY ) / (4/3) * PI ) ^ (1/3)
	
End Sub
