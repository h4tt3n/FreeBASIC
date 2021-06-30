''******************************************************************************* 
'' Hooke's law damped fixed angle spring
''*******************************************************************************

Type FixedSpringType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub ComputeData()
	Declare Sub ComputeRestImpulse()
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	
	As LinearLinkType LinearLink
	
	As Vec2 accumulated_impulse
	
	As Vec2 rest_distance
	As Vec2 rest_impulse
	
	As Single c_stiffness
	As Single c_damping
	As Single c_warmstart
	
End Type

Constructor FixedSpringType()
	
	c_stiffness   = 0.02
	c_damping     = 0.1
	c_warmstart   = 0.5
	
	rest_distance = Vec2( 0.0, 0.0 )
	rest_impulse  = Vec2( 0.0, 0.0 )
	
	accumulated_impulse = Vec2( 0.0, 0.0 )
	
End Constructor

Destructor FixedSpringType

End Destructor

Sub FixedSpringType.ComputeData()
	
	'' spring state vectors
	If ( LinearLink.a->inv_mass = 0.0 ) Then
		
		LinearLink.position = LinearLink.a->position
		LinearLink.velocity = Vec2( 0.0, 0.0 )
		
	ElseIf ( LinearLink.b->inv_mass = 0.0 ) Then
		
		LinearLink.position = LinearLink.b->position
		LinearLink.velocity = Vec2( 0.0, 0.0 )
		
	Else
		
		LinearLink.position = ( LinearLink.a->position * LinearLink.a->mass + _
	                           LinearLink.b->position * LinearLink.b->mass ) * LinearLink.inv_mass
		
		LinearLink.velocity = ( LinearLink.a->velocity * LinearLink.a->mass + _
	                           LinearLink.b->velocity * LinearLink.b->mass ) * LinearLink.inv_mass
		
	End If
	
End Sub

Sub FixedSpringType.ComputeRestImpulse()
	
	'' desired "rest impulse" needed to satisfy the constraint
	Dim As Vec2 distance = LinearLink.b->position - LinearLink.a->position
	Dim As Vec2 velocity = LinearLink.b->velocity - LinearLink.a->velocity
	
	Dim As Vec2 distance_error = distance - rest_distance
	Dim As Vec2 velocity_error = velocity
	
	rest_impulse = - c_stiffness * distance_error * INV_DT - c_damping * velocity_error
	
End Sub

Sub FixedSpringType.ApplyCorrectiveImpulse()
	
	''	delta impulse
	Dim As Vec2 delta_impulse = LinearLink.b->impulse - LinearLink.a->impulse
	
	'' impulse error
	Dim As Vec2 impulse_error = delta_impulse - rest_impulse
	
	'' corrective impulse
   Dim As Vec2 corrective_impulse = - impulse_error * LinearLink.reduced_mass
	
	LinearLink.a->AddImpulse( -corrective_impulse * LinearLink.a->inv_mass )
	LinearLink.b->AddImpulse(  corrective_impulse * LinearLink.b->inv_mass )
	
	'' save for warmstart
	accumulated_impulse += corrective_impulse
	
End Sub

Sub FixedSpringType.ApplyWarmStart()
	
	Dim As Vec2 distance = LinearLink.b->position - LinearLink.a->position
	
	Dim As Vec2 projected_impulse = distance.Project( accumulated_impulse )
	
	If ( distance.Dot( projected_impulse ) < 0.0 ) Then
		
		Dim As Vec2 warmstart_impulse = c_warmstart * projected_impulse
		
		LinearLink.a->AddImpulse( -warmstart_impulse * LinearLink.a->inv_mass )
		LinearLink.b->AddImpulse(  warmstart_impulse * LinearLink.b->inv_mass )
		
	End If
	
	Accumulated_impulse = Vec2( 0.0, 0.0 )
	
End Sub
