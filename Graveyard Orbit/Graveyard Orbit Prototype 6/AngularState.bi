''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 6, september 2018
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
	
	As Vec2 direction_vector
	As Vec2 velocity_vector
	
	'As Mat22 direction_matrix
	'As Mat22 velocity_matrix
	
	As Single angular_velocity
	
	As Single angular_impulse
	
	As Single inv_inertia
	
End Type

Constructor AngularStateType()
	
	Base()
	
	direction_vector = Vec2( 1.0, 0.0 )
	velocity_vector  = Vec2( 1.0, 0.0 )
	
	'direction_matrix.makeIdentity()
	'velocity_matrix.makeIdentity()
	
	angular_velocity = 0.0
	angular_impulse  = 0.0
	inv_inertia      = 0.0
	
End Constructor

Destructor AngularStateType()

End Destructor

Sub AngularStateType.ComputeNewState()
	
	''
	If ( Abs( angular_impulse ) > MIN_ANGULAR_IMPULSE ) Then
		
		angular_velocity += angular_impulse
		
		velocity_vector = Vec2( Cos( angular_velocity * DT ), _
	                           Sin( angular_velocity * DT ) )
		
		'velocity_matrix.makeRotation( angular_velocity * DT )
		
	EndIf
	
	direction_Vector = direction_Vector.RotateCCW( velocity_vector )
	
	'direction_matrix = velocity_matrix * direction_matrix
	
End Sub

'' Linear
'R->LinearState.velocity += R->LinearState.impulse
'
'Dim As Vec2 delta_position = R->LinearState.velocity * DT
'
'R->LinearState.position += delta_position
'
''' Angular
'If ( R->AngularState.impulse <> 0.0 ) Then
'	
'	R->AngularState.velocity += R->AngularState.impulse
'	
'	R->AngularState.velocity_vector = Vec2( Cos( R->AngularState.velocity * DT ), _
'	                                        Sin( R->AngularState.velocity * DT ) )
'
'EndIf
'
''R->Angular.direction += R->Angular.velocity * DT
'R->AngularState.direction_Vector = R->AngularState.direction_Vector.RotateCCW( R->AngularState.velocity_vector )
'
''' Roxels
'If ( Not R->Roxels.Empty ) Then
'	
'	For P As RoxelType Ptr = R->Roxels.p_front To R->Roxels.p_back
'		
'		' Linear
'		P->LinearState.position += delta_position
'		
'		' Angular
'		Dim As vec2 local_position = P->LinearState.position - R->LinearState.position
'		
'		P->LinearState.position = R->LinearState.position + local_position.RotateCCW( R->AngularState.velocity_vector )
'		P->LinearState.velocity = R->LinearState.velocity + local_position.PerpDot( R->AngularState.velocity ) 
'		
'		'P->LinearState.impulse = Vec2( 0.0, 0.0 )
'		
'	Next
'	
'EndIf
