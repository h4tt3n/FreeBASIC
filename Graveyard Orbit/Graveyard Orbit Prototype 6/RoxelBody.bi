''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 6, september 2018
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
'' Multi-Roxel rigid body
''
''*******************************************************************************

Type RoxelBodyType Extends AngularStateType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Virtual Sub AddImpulse( ByVal i As Vec2 ) Override
	
	Declare Sub ComputeData()
	Declare Sub ComputeNewState()
	Declare Sub ConcentrateImpulses()
	Declare Sub DisperseImpulses()
	Declare Sub DistributeImpulses()
	
	Declare Virtual Sub SetPosition( ByVal p As Vec2 ) Override
	
	As Vec2   linear_prev
	As Single angular_prev
	
	As RoxelArray Roxels
  	
End Type

Constructor RoxelBodyType()
	
	Base()
	
	direction_vector = Vec2( 1.0, 0.0 )
	velocity_vector  = Vec2( 1.0, 0.0 )
	
	Linear_prev  = Vec2( 0.0, 0.0 )
	Angular_prev = 0.0
	
End Constructor

Destructor RoxelBodyType()
	
	Roxels.Destroy()
	
End Destructor

Sub RoxelBodyType.AddImpulse( ByVal i As Vec2 )
	
	Base.AddImpulse( i )
	
	'If ( Not Roxels.Empty ) Then 
	'	
	'	For P As RoxelType Ptr = Roxels.p_front To Roxels.p_back
	'		
	'		P->Addimpulse( i )
	'		
	'	Next
	'	
	'EndIf
	
End Sub

Sub RoxelBodyType.computeData()
	
	If ( Not Roxels.Empty ) Then
		
		'' compute mass
		Mass = 0.0
		
		For R As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			Mass += R->mass
			
		Next
		
		inv_mass = IIf( Mass > 0.0 , 1.0 / Mass , 0.0 )
		
		'' compute linear state
		Position = Vec2( 0.0, 0.0 )
		Velocity = Vec2( 0.0, 0.0 )
		
		For R As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			Position += R->position * R->mass
			Velocity += R->velocity * R->mass
			
		Next
		
		Position *= inv_mass
		Velocity *= inv_mass
		
		'' compute moment of inertia
		Dim As Single inertia = 0.0
		
		For R As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			Dim As Vec2 local_position = R->Position - Position
			
			inertia += local_position.Dot( local_position ) * R->mass 
			
		Next
		
		inv_inertia = IIf( inertia > 0.0 , 1.0 / inertia , 0.0 )
		
		'' compute angular velocity
		angular_velocity = 0.0
		
		For R As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			Dim As Vec2 local_position = R->Position - Position
			Dim As Vec2 local_velocity = R->Velocity - Velocity
			
			angular_velocity += local_position.Perpdot( local_velocity * R->mass )
			
		Next
		
		angular_velocity *= inv_inertia
		
	EndIf
	
End Sub

Sub RoxelBodyType.ComputeNewState()
	
	'' Linear
	velocity += impulse
	
	Dim As Vec2 delta_position = velocity * DT
	
	position += delta_position
	
	'' Angular
	If ( Abs( angular_impulse ) > MIN_ANGULAR_IMPULSE ) Then
		
		angular_velocity += angular_impulse
		
		velocity_vector = Vec2( Cos( angular_velocity * DT ), _
		                        Sin( angular_velocity * DT ) )
		
		'velocity_matrix.makeRotation( angular_velocity * DT )
		
	EndIf
	
	direction_Vector = direction_Vector.RotateCCW( velocity_vector )
	
	'direction_matrix = velocity_matrix * direction_matrix
	
	'' Roxels
	If ( Not Roxels.Empty ) Then
		
		For P As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			'' Linear
			P->position += delta_position
			
			'' Angular
			Dim As vec2 local_position = P->position - position
			
			P->position = position + local_position.RotateCCW( velocity_vector )
			
			'P->position = position + local_position * velocity_matrix 
			
			P->velocity = velocity + local_position.PerpDot( angular_velocity ) 
			
		Next
		
	EndIf
	
End Sub

Sub RoxelBodyType.ConcentrateImpulses()
	
	If ( Not Roxels.Empty ) Then 
				
		'' Sum of "local" particle impulses
		Dim As Vec2   local_linear  = Vec2( 0.0, 0.0 )
		Dim As Single local_angular = 0.0
		
		For P As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			Dim As vec2 local_position = P->position - position
			
			Dim As single local_inertia  = local_position.Dot( local_position ) * P->mass 
			
			local_linear += P->impulse * P->mass
			
			local_angular += local_position.perpdot( P->impulse * P->mass  )
			
		Next
		
		'' Add to "global" rigid body impulses (subtract previous)
		AddImpulse( local_linear * inv_mass - Linear_prev )
		
		angular_impulse += local_angular * inv_inertia - Angular_prev
		
	EndIf
	
End Sub

Sub RoxelBodyType.DisperseImpulses()
	
	If ( Not Roxels.Empty ) Then 
		
		'' disperse rigid body impulse back to particles
		For P As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			Dim As vec2 local_position = P->position - position
			
			P->impulse = impulse + local_position.perpdot( angular_impulse )
			
		Next
		
		'' Save global for next iteration
		Linear_prev  = impulse
		Angular_prev = angular_impulse
		
	EndIf
	
End Sub

Sub RoxelBodyType.DistributeImpulses()
	
	ConcentrateImpulses()
	DisperseImpulses()
	
End Sub

Sub RoxelBodyType.SetPosition( ByVal p As Vec2 )
	
	Dim As Vec2 delta_postion = p - Position
	
	Base.SetPosition( p )
	
	For P As RoxelType Ptr = Roxels.p_front To Roxels.p_back
		
		P->Position = P->Position + delta_postion
		
	Next
	
End Sub

'Sub RoxelBodyType.SetVelocity( ByVal v As Vec2 )
'	
'	Base.SetVelocity( v )
'	
'	For I as LinearState Ptr Ptr = LinearStates_.p_front To LinearStates_.p_back
'		
'		Dim As LinearState Ptr PP = *I
'		
'		PP->SetVelocity( v )
'		
'	Next
'	
'End Sub
