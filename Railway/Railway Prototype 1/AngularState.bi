''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 1, october 2018
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''  Angular motion / rotation base component
''
''*******************************************************************************

Type AngularStateType Extends LinearStateType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub ComputeNewState()
	
	Declare Sub ComputeInvInertia()
	
	As Vec2 direction_vector
	
	As Single angle
	As Single angular_velocity
	As Single angular_impulse
	
	As Single inertia
	As Single inv_inertia
	
End Type

Constructor AngularStateType()
	
	Base()
	
	direction_vector = Vec2( 1.0, 0.0 )
	
	angle            = 0.0
	angular_velocity = 0.0
	angular_impulse  = 0.0
	
	inertia     = 0.0
	inv_inertia = 0.0
	
End Constructor

Destructor AngularStateType()

End Destructor


Sub AngularStateType.ComputeInvInertia()
	
	inv_inertia = IIf( ( Inertia < FLOAT_MAX ) And ( Inertia > 0.0 ) , 1.0 / Inertia , 0.0 )
	
End Sub

Sub AngularStateType.ComputeNewState()
	
	Base.ComputeNewState()
	
	angular_velocity += angular_impulse
	
	angle += angular_velocity * DT
		
	direction_Vector = Vec2( Cos( angle ), Sin( angle  ) )
	
End Sub



