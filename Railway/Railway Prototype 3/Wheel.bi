''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 3, september 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''  Wheel class
''
''*******************************************************************************

Type WheelType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub ComputeMass()
	Declare Sub ComputeInertia()
	
	As AngularStateType AngularState
	
	As Single radius
	As Single density
	
	As Single c_collision_damping
	As Single c_collision_STIFFNESS
	
	As Single c_dynamic_friction
	As Single c_static_friction
	
End Type

Constructor WheelType()
	
	''
	AngularState.direction_vector = Vec2( 1.0, 0.0 )
	
	AngularState.angular_velocity = 0.0
	AngularState.angular_impulse  = 0.0
	
	AngularState.inertia     = 0.0
	AngularState.inv_inertia = 0.0
	
	''
	radius  = 0.0
	density = 0.0
	
	''
	c_collision_damping  = 0.0
	c_collision_STIFFNESS = 0.0
	
	''
	c_dynamic_friction = 0.0
	c_static_friction  = 0.0
	
End Constructor

Destructor WheelType()

End Destructor

''
Sub WheelType.ComputeMass()
	
	AngularState.mass = radius * radius * PI / density
	
	AngularState.ComputeInvMass()
	
End Sub

Sub WheelType.ComputeInertia()
	
	AngularState.Inertia = 0.5 * AngularState.mass * radius * radius
	
	AngularState.ComputeInvInertia()
	
End Sub
