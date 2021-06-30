''******************************************************************************* 
'' Multi-Roxel rigid body
''*******************************************************************************

Type RoxelBodyType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub ComputeData()
	Declare Sub ComputeNewState()
	Declare Sub DistributeImpulses()
	
	As LinearStateType  LinearState
	As AngularStateType AngularState
	
	As Vec2   linear_prev
	As Single angular_prev
	
	As RoxelArray Roxels
  	
End Type

Constructor RoxelBodyType()
	
	Linear_prev = Vec2( 0.0, 0.0 )
	
	Angular_prev = 0.0
	
End Constructor

Destructor RoxelBodyType()
	
	Roxels.Destroy()
	
End Destructor

Sub RoxelBodyType.computeData()
	
	If ( Not Roxels.Empty ) Then
		
		'' compute mass and inv
		LinearState.Mass = 0.0
		
		For R As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			LinearState.Mass += R->LinearState.mass
			
		Next
		
		LinearState.inv_mass = IIf( LinearState.Mass > 0.0 , 1.0 / LinearState.Mass , 0.0 )
		
		'' compute linear state
		LinearState.Position = Vec2( 0.0, 0.0 )
		LinearState.Velocity = Vec2( 0.0, 0.0 )
		
		For R As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			LinearState.Position += R->LinearState.position * R->LinearState.mass
			LinearState.Velocity += R->LinearState.velocity * R->LinearState.mass
			
		Next
		
		LinearState.Position *= LinearState.inv_mass
		LinearState.Velocity *= LinearState.inv_mass
		
		'' compute moment of inertial
		AngularState.inertia = 0.0
		
		For R As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			Dim As Vec2 local_position = R->LinearState.Position - LinearState.Position
			
			AngularState.inertia += local_position.LengthSquared() * R->LinearState.mass 
			
		Next
		
		AngularState.inv_inertia = IIf( AngularState.inertia > 0.0 , 1.0 / AngularState.inertia , 0.0 )
		
		'' compute angular velocity
		AngularState.velocity = 0.0
		
		For R As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			Dim As Vec2 local_position = R->LinearState.Position - LinearState.Position
			Dim As Vec2 local_velocity = R->LinearState.Velocity - LinearState.Velocity
			
			AngularState.velocity += local_position.Perpdot( local_velocity * R->LinearState.mass )
			
		Next
		
		AngularState.velocity *= AngularState.inv_inertia
		
	EndIf
	
End Sub

Sub RoxelBodyType.ComputeNewState()
	
	'' Linear
	LinearState.velocity += LinearState.impulse
	
	Dim As Vec2 delta_position = LinearState.velocity * DT
	
	LinearState.position += delta_position
	
	'' Angular
	If ( Abs( AngularState.impulse ) > MIN_ANGULAR_IMPULSE ) Then
		
		AngularState.velocity += AngularState.impulse
		
		AngularState.velocity_matrix.makeRotation( AngularState.velocity * DT )
		
	EndIf
	
	AngularState.direction_matrix = AngularState.velocity_matrix * AngularState.direction_matrix
	
	'' Roxels
	If ( Not Roxels.Empty ) Then
		
		For P As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			'' Linear
			P->LinearState.position += delta_position
			
			'' Angular
			Dim As vec2 local_position = P->LinearState.position - LinearState.position
			
			P->LinearState.position = LinearState.position + local_position * AngularState.velocity_matrix 
			
			P->LinearState.velocity = LinearState.velocity + local_position.PerpDot( AngularState.velocity ) 
			
		Next
		
	EndIf
	
End Sub

Sub RoxelBodyType.DistributeImpulses()
	
	If ( Not Roxels.Empty ) Then 
				
		'' Sum of "local" particle impulses
		Dim As Vec2   local_linear  = Vec2( 0.0, 0.0 )
		Dim As Single local_angular = 0.0
		
		For P As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			Dim As vec2 local_position = P->LinearState.position - LinearState.position
			
			local_linear += P->LinearState.impulse * P->LinearState.mass
			
			local_angular += local_position.perpdot( P->LinearState.impulse * P->LinearState.mass )
			
		Next
		
		'' Add to "global" rigid body impulses (subtract previous)
		LinearState.AddImpulse( local_linear  * LinearState.inv_mass - Linear_prev )
		
		AngularState.impulse += local_angular * AngularState.inv_inertia - Angular_prev
		
		'' disperse rigid body impulse back to particles
		For P As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			Dim As vec2 local_position = P->LinearState.position - LinearState.position
			
			P->LinearState.impulse = LinearState.impulse + local_position.perpdot( AngularState.impulse )
			
		Next
		
		'' Save global for next iteration
		Linear_prev  = LinearState.impulse
		Angular_prev = AngularState.impulse
		
	EndIf
	
End Sub
