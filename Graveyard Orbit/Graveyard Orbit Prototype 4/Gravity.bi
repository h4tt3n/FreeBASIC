''******************************************************************************* 
'' Newtonian gravitational interaction
''*******************************************************************************

Type GravityType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub ApplyImpulse()
	Declare Sub ComputeData()
	Declare Sub ComputeForceScale()
	
	As LinearLinkType LinearLink
	
	As Single force_scale
  	
End Type

Constructor GravityType()
	
	force_scale = 0.0
	
End Constructor

Destructor GravityType()

End Destructor

Sub GravityType.ApplyImpulse()
	
	Dim As Vec2 distance_vector = LinearLink.b->position - LinearLink.a->position
	
	LinearLink.unit_vector = distance_vector.Unit()
	
	Dim As Single distance_squared = distance_vector.lengthsquared()
	
	Dim As Single gravity_impulse = -( C_GRAVITY * INV_DT * LinearLink.a->mass * LinearLink.b->mass ) / distance_squared
	'Dim As Single gravity_impulse = force_Scale / distance_squared
	
	LinearLink.a->Addimpulse( -gravity_impulse * LinearLink.a->inv_mass * LinearLink.unit_vector )
	LinearLink.b->Addimpulse(  gravity_impulse * LinearLink.b->inv_mass * LinearLink.unit_vector )
	
End Sub

Sub GravityType.ComputeData()
	
	'' state vectors
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

Sub GravityType.ComputeForceScale()
	
	force_scale = -( C_GRAVITY * INV_DT * LinearLink.a->mass * LinearLink.b->mass )
	
End Sub
