''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 1, october 2018
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''  Soft body
''
''*******************************************************************************

Type SoftBodyType Extends AngularStateType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub ComputeData()
	Declare Sub ComputeNewState()
	Declare Sub ConcentrateImpulses()
	Declare Sub DisperseImpulses()
	
	Declare Virtual Sub SetPosition( ByVal p As Vec2 ) Override
	
	''
	As LinearStateArray  LinearStates
	As LinearSpringArray LinearSprings
	As AngularSpringArray AngularSprings
	
	'As Vec2   linear_prev
	'As Single angular_prev
	
End Type

Constructor SoftBodyType()
	
	'Linear_prev = Vec2( 0.0, 0.0 )
	
	'Angular_prev = 0.0
	
End Constructor

Destructor SoftBodyType()
	
	LinearStates.Destroy()
	LinearSprings.Destroy()
	AngularSprings.Destroy()
	
End Destructor

Sub SoftBodyType.ComputeData()
	
	If ( Not LinearStates.Empty ) Then
	
		'' compute mass and inv
		Mass = 0.0
		
		For L As LinearStateType Ptr = LinearStates.p_front To LinearStates.p_back
			
			Mass += L->mass
			
		Next
		
		inv_mass = IIf( Mass > 0.0 , 1.0 / Mass , 0.0 )
	
		'' State vectors
		Position = Vec2( 0.0, 0.0 )
		Velocity = Vec2( 0.0, 0.0 )
		
		For L As LinearStateType Ptr = LinearStates.p_front To LinearStates.p_back
			
			Position += L->Position * L->Mass
			Velocity += L->Velocity * L->Mass
			
		Next
		
		Position *= inv_mass
		Velocity *= inv_mass
		
		'' Moment of inertia
		Dim As Single Inertia = 0.0
		
		For L As LinearStateType Ptr = LinearStates.p_front To LinearStates.p_back
			
			Dim As Vec2 local_position = L->position - position
			
			Inertia += local_position.LengthSquared() * L->Mass
			
		Next
		
		inv_inertia = IIf( Inertia > 0.0 , 1.0 / Inertia , 0.0 )
		
		'' Angular velocity
		angular_Velocity = 0.0
		
		For L As LinearStateType Ptr = LinearStates.p_front To LinearStates.p_back
			
			Dim As Vec2 local_position = L->position - position
			Dim As Vec2 local_velocity = L->velocity - velocity
			
			angular_Velocity += local_position.Perpdot( local_velocity * L->Mass ) 
			
		Next
		
		angular_velocity *= inv_inertia
		
	EndIf
	
End Sub

Sub SoftBodyType.ComputeNewState()

	'' Angular
	If ( Abs( Angular_impulse ) > MIN_ANGULAR_IMPULSE ) Then
		
		Angular_velocity += Angular_impulse
		
		'velocity_vector = Vec2( Cos( angular_velocity * DT ), _
	   '                        Sin( angular_velocity * DT ) )
		
		'velocity_matrix.makeRotation( Angular_velocity * DT )
		
	EndIf
	
	'direction_Vector = direction_Vector.RotateCCW( velocity_vector )
	
	'direction_matrix = velocity_matrix * direction_matrix
	
End Sub

Sub SoftBodyType.ConcentrateImpulses()
	
	If ( Not LinearStates.Empty ) Then 
				
		'' Sum of "local" particle impulses
		Dim As Vec2   local_linear  = Vec2( 0.0, 0.0 )
		Dim As Single local_angular = 0.0
		
		For L As LinearStateType Ptr = LinearStates.p_front To LinearStates.p_back
			
			Dim As vec2 local_position = L->position - position
			
			local_linear += L->impulse * L->mass
			
			local_angular += local_position.perpdot( L->impulse * L->mass )
			
		Next
		
		'' Add opposite equal to "global" rigid body impulses
		Impulse -= local_linear * inv_mass' - Linear_prev
		angular_impulse -= local_angular * inv_inertia' - Angular_prev
	
	EndIf
	
	'' Save global for next iteration
	'Linear_prev  = LinearState.impulse
	'Angular_prev = AngularState.angular_impulse
	
End Sub

Sub SoftBodyType.DisperseImpulses()
	
	If ( Not LinearStates.Empty ) Then 
				
		'' disperse rigid body impulse back to particles
		For L As LinearStateType Ptr = LinearStates.p_front To LinearStates.p_back
			
			Dim As vec2 local_position = L->position - position
			
			L->impulse += impulse + local_position.perpdot( angular_impulse )
			
		Next
		
	EndIf
	
End Sub

Sub SoftBodyType.SetPosition( ByVal p As Vec2 )
	
	Dim As Vec2 delta_postion = p - Position
	
	'position = p
	Base.SetPosition( p )
	
	For L As LinearStateType Ptr = LinearStates.p_front To LinearStates.p_back
		
		L->Position = L->Position + delta_postion
		
	Next
	
End Sub
