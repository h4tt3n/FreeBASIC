''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 4, september 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''  Rigid rectangle class
''
''*******************************************************************************

Type BoxType
	
	Declare Constructor()
	
	Declare Constructor( ByVal _position As Vec2, _
	                     ByVal _radius   As Vec2 )
	
	Declare Destructor()
	
	Declare Sub ComputeMass()
	Declare Sub ComputeInertia()
	
	As AngularStateType AngularState
	
	As Vec2 radius
	
	As Single collision_damping
	As Single collision_STIFFNESS
	As Single collision_warmstart
	
	As Single density
	As Single dynamic_friction
	As Single static_friction
	
End Type

Constructor BoxType()
	
	''
	AngularState.ResetAllVars()
	
	''
	radius  = Vec2( 0.0, 0.0 )
	
	''
	density          = 0.0
	dynamic_friction = 0.0
	static_friction  = 0.0
	
End Constructor

Constructor BoxType( ByVal _position As Vec2, _
	                  ByVal _radius   As Vec2 )
	
	
	
End Constructor

Destructor BoxType()

End Destructor

''
Sub BoxType.ComputeMass()
	
	AngularState.mass = ( 2.0 * radius.x ) * ( 2.0 * radius.y ) * density
	
	AngularState.ComputeInvMass()
	
End Sub

Sub BoxType.ComputeInertia()
	
	''	Moment of inertia of a thin rectangle 
	AngularState.Inertia = ( 1.0 / 12.0 ) * AngularState.mass * ( ( 2.0 * radius.x ) ^ 2 + ( 2.0 * radius.y ) ^ 2 )
	
	AngularState.ComputeInvInertia()
	
End Sub
