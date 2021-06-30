''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 5, june 2018
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''
''  Hooke's law damped angular spring
''
''*******************************************************************************

Type AngularSpringType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub ComputeData()
	Declare Sub ComputeRestImpulse()
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	
	As Vec2 angle
	As Vec2 rest_angle
	
	As Single c_stiffness
	As Single c_damping
	As Single c_warmstart
	
	As Single reduced_inertia
	As Single rest_impulse
	As Single accumulated_impulse
	
	As LinearLinkType Ptr a
	As LinearLinkType Ptr b
	
End Type

Constructor AngularSpringType()
	
	angle      = Vec2( 0.0, 0.0 )
	rest_angle = Vec2( 0.0, 0.0 )
	
	c_stiffness = 0.2
	c_damping   = 1.0
	c_warmstart = 0.5
	
	reduced_inertia     = 0.0
	rest_impulse        = 0.0
	accumulated_impulse = 0.0
	
	a = 0
	b = 0
	
End Constructor

Destructor AngularSpringType()

End Destructor
	
Sub AngularSpringType.ComputeData()
	
End Sub

Sub AngularSpringType.ComputeRestImpulse()
	
End Sub

Sub AngularSpringType.ApplyCorrectiveImpulse()
	
End Sub
	
Sub AngularSpringType.ApplyWarmStart()
	
End Sub
