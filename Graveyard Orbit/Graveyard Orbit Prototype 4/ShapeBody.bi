''******************************************************************************* 
'' Shape matching soft body
''*******************************************************************************

Type ShapeBodyType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub ComputeData()
	Declare Sub ComputeNewState()
	Declare Sub ConcentrateImpulses()
	Declare Sub DisperseImpulses()
	
	As LinearStateType  LinearState
	As AngularStateType AngularState
	
	As LinearStateArray LinearStates
	As FixedSpringArray FixedSprings
	
	As Vec2   linear_prev
	As Single angular_prev
	
End Type

Constructor ShapeBodyType()
	
	Linear_prev = Vec2( 0.0, 0.0 )
	
	Angular_prev = 0.0
	
End Constructor

Destructor ShapeBodyType()
	
	LinearStates.Destroy()
	FixedSprings.Destroy()
	
End Destructor

Sub ShapeBodyType.ComputeData()
	
	If ( Not LinearStates.Empty ) Then
	
		'' compute mass and inv
		LinearState.Mass = 0.0
		
		For L As LinearStateType Ptr = LinearStates.p_front To LinearStates.p_back
			
			LinearState.Mass += L->mass
			
		Next
		
		LinearState.inv_mass = IIf( LinearState.Mass > 0.0 , 1.0 / LinearState.Mass , 0.0 )
	
		'' State vectors
		LinearState.Position = Vec2( 0.0, 0.0 )
		LinearState.Velocity = Vec2( 0.0, 0.0 )
		
		For L As LinearStateType Ptr = LinearStates.p_front To LinearStates.p_back
			
			LinearState.Position += L->Position * L->Mass
			LinearState.Velocity += L->Velocity * L->Mass
			
		Next
		
		LinearState.Position *= LinearState.inv_mass
		LinearState.Velocity *= LinearState.inv_mass
		
		'' Moment of inertia
		AngularState.Inertia = 0.0
		
		For L As LinearStateType Ptr = LinearStates.p_front To LinearStates.p_back
			
			Dim As Vec2 local_position = L->position - LinearState.position
			
			AngularState.Inertia += local_position.LengthSquared() * L->Mass
			
		Next
		
		AngularState.inv_inertia = IIf( AngularState.Inertia > 0.0 , 1.0 / AngularState.Inertia , 0.0 )
		
		'' Angular velocity
		AngularState.Velocity = 0.0
		
		For L As LinearStateType Ptr = LinearStates.p_front To LinearStates.p_back
			
			Dim As Vec2 local_position = L->position - LinearState.position
			Dim As Vec2 local_velocity = L->velocity - LinearState.velocity
			
			AngularState.Velocity += local_position.Perpdot( local_velocity * L->Mass ) 
			
		Next
		
		AngularState.Velocity *= AngularState.inv_inertia
	
	EndIf
	
End Sub

Sub ShapeBodyType.ComputeNewState()

	'' Angular
	If ( Abs( AngularState.impulse ) > MIN_ANGULAR_IMPULSE ) Then
		
		AngularState.velocity += AngularState.impulse
		
		AngularState.velocity_matrix.makeRotation( AngularState.velocity * DT )
		
	EndIf
	
	AngularState.direction_matrix = AngularState.velocity_matrix * AngularState.direction_matrix
	
	'' rotate rest length vectors
	If ( Not FixedSprings.Empty ) Then
		
		For F As FixedSpringType Ptr = FixedSprings.P_front To FixedSprings.P_back
			
			F->rest_distance = F->rest_distance * AngularState.velocity_matrix
			
		Next
		
	EndIf
	
End Sub

Sub ShapeBodyType.ConcentrateImpulses()
	
	If ( Not LinearStates.Empty ) Then 
				
		'' Sum of "local" particle impulses
		Dim As Vec2   local_linear  = Vec2( 0.0, 0.0 )
		Dim As Single local_angular = 0.0
		
		For L As LinearStateType Ptr = LinearStates.p_front To LinearStates.p_back
			
			Dim As vec2 local_position = L->position - LinearState.position
			
			local_linear += L->impulse * L->mass
			
			local_angular += local_position.perpdot( L->impulse * L->mass )
			
		Next
		
		'' Add opposite equal to "global" rigid body impulses
		LinearState.Impulse -= local_linear * LinearState.inv_mass' - Linear_prev
		AngularState.impulse -= local_angular * AngularState.inv_inertia' - Angular_prev
	
	EndIf
	
	'' Save global for next iteration
	Linear_prev  = LinearState.impulse
	Angular_prev = AngularState.impulse
	
End Sub

Sub ShapeBodyType.DisperseImpulses()
	
	If ( Not LinearStates.Empty ) Then 
				
		'' disperse rigid body impulse back to particles
		For L As LinearStateType Ptr = LinearStates.p_front To LinearStates.p_back
			
			Dim As vec2 local_position = L->position - LinearState.position
			
			L->impulse += LinearState.impulse + local_position.perpdot( AngularState.impulse )
			
		Next
		
	EndIf
	
End Sub
