''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 5, june 2018
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''
'' Hooke's law damped linear spring
''
''*******************************************************************************

Type LinearSpringType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub ComputeData()
	Declare Sub ComputeRestImpulse()
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	
	As LinearLinkType LinearLink
	
	As Vec2 accumulated_impulse
	
	As Single c_stiffness
	As Single c_damping
	As Single c_warmstart
	
	As Single rest_distance
	As Single rest_impulse
	
End Type

Constructor LinearSpringType()

	c_stiffness   = 0.2
	c_damping     = 1.0
	c_warmstart   = 0.5

	rest_distance = 0.0
	rest_impulse  = 0.0
	
	accumulated_impulse = Vec2( 0.0, 0.0 )
	
End Constructor

Destructor LinearSpringType

End Destructor

Sub LinearSpringType.ComputeData()
	
	'' spring state vectors
	LinearLink.ComputeData()
	
End Sub

Sub LinearSpringType.ComputeRestImpulse()
	
	'' desired "rest impulse" needed to satisfy the constraint
	Dim As Vec2 distance = LinearLink.b->position - LinearLink.a->position
	Dim As Vec2 velocity = LinearLink.b->velocity - LinearLink.a->velocity
	
	LinearLink.unit_vector = distance.Unit()
	
	Dim As Single distance_error = LinearLink.unit_vector.dot( distance ) - rest_distance
	Dim As Single velocity_error = LinearLink.unit_vector.dot( velocity )
	
	rest_impulse = -c_stiffness * distance_error * INV_DT - c_damping * velocity_error
	
End Sub

Sub LinearSpringType.ApplyCorrectiveImpulse()
	
	''	delta impulse
	Dim As Vec2 delta_impulse = LinearLink.b->impulse - LinearLink.a->impulse
	
	'' impulse error
	Dim As Single impulse_error = LinearLink.unit_vector.dot( delta_impulse ) - rest_impulse
	
	'' corrective impulse
   Dim As Vec2 corrective_impulse = -impulse_error * LinearLink.reduced_mass * LinearLink.unit_vector
	
	LinearLink.a->AddImpulse( -corrective_impulse * LinearLink.a->inv_mass )
	LinearLink.b->AddImpulse(  corrective_impulse * LinearLink.b->inv_mass )
	
	'' save for warmstart
	accumulated_impulse += corrective_impulse
	
End Sub

Sub LinearSpringType.ApplyWarmStart()
	
	Dim As Single projected_impulse = LinearLink.unit_vector.dot( accumulated_impulse )
	
	If ( projected_impulse < 0.0 ) Then
		
		Dim As Vec2 warmstart_impulse = -c_warmstart * projected_impulse * LinearLink.unit_vector
		
		LinearLink.a->AddImpulse( -warmstart_impulse * LinearLink.a->inv_mass )
		LinearLink.b->AddImpulse(  warmstart_impulse * LinearLink.b->inv_mass )
		
	End If
	
	accumulated_impulse = Vec2( 0.0, 0.0 )
	
End Sub
