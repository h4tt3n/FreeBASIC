''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 4, september 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''  Wheel - LinearLink collision response
''
''*******************************************************************************

Type WheelLinearLinkCollisionResponse
	
	Declare Constructor()
	Declare Constructor( ByVal _wheel As WheelType Ptr, ByVal _linearlink As LinearLinkType Ptr )
	
	Declare Destructor()
	
	Declare Sub ComputeData()
	Declare Sub ComputeRestImpulse()
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	
	As Vec2 unit
	
	As Vec2 accumulated_impulse
	As Vec2 rest_impulse
	
	As Single normal_M
	As Single tangent_M
	
	As Single c_stiffness
	As Single c_damping
	As Single c_warmstart
	
	As WheelType Ptr wheel
	As LinearLinkType Ptr linearlink
	
End Type