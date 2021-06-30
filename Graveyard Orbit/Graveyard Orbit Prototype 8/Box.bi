''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 2, september 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''  Rigid rectangle class
''
''*******************************************************************************

Type BoxType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub ComputeMass()
	Declare Sub ComputeInertia()
	
	As AngularStateType AngularState
	
	As Vec2 radius
	
	As Single density
	
	As Single dynamic_friction
	As Single static_friction
	
End Type

Constructor BoxType()
	
	''
	AngularState.direction_vector = Vec2( 1.0, 0.0 )
	
	AngularState.angular_velocity = 0.0
	AngularState.angular_impulse  = 0.0
	
	AngularState.inertia     = 0.0
	AngularState.inv_inertia = 0.0
	
	''
	radius  = Vec2( 0.0, 0.0 )
	density = 0.0
	
End Constructor

Destructor BoxType()

End Destructor

''
Sub BoxType.ComputeMass()
	
	AngularState.mass = ( 2.0 * radius.x ) * ( 2.0 * radius.y ) * density
	
	AngularState.ComputeInvMass()
	
End Sub

Sub BoxType.ComputeInertia()
	
	AngularState.Inertia = ( 1.0 / 12.0 ) * AngularState.mass * ( ( 2.0 * radius.x ) ^ 2 + ( 2.0 * radius.y ) ^ 2 )
	
	AngularState.ComputeInvInertia()
	
End Sub
