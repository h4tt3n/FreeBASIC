''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 6, september 2018
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''
''  Hooke's law damped angular spring
''
''*******************************************************************************

Type AngularSpringType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub ComputeData()
	Declare Sub ComputeReducedIntertia()
	Declare Sub ComputeRestImpulse()
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	
	As Vec2 angle
	As Vec2 rest_angle
	
	As Single c_stiffness
	As Single c_damping
	As Single c_warmstart
	
	As Single reduced_inertia
	As Single rest_impulse
	As Single accumulated_impulse
	
	As LinearLinkType Ptr a
	As LinearLinkType Ptr b
	
End Type

Constructor AngularSpringType()
	
	angle      = Vec2( 0.0, 0.0 )
	rest_angle = Vec2( 0.0, 0.0 )
	
	c_stiffness = 0.0
	c_damping   = 0.0
	c_warmstart = 0.0
	
	reduced_inertia     = 0.0
	rest_impulse        = 0.0
	accumulated_impulse = 0.0
	
	a = 0
	b = 0
	
End Constructor

Destructor AngularSpringType()

End Destructor
	
Sub AngularSpringType.ComputeData()
	
	'' angle between springs
	angle = Vec2( a->unit_vector.dot( b->unit_vector ), a->unit_vector.perpdot( b->unit_vector ) )
	
	ComputeReducedIntertia()
	
End Sub

Sub AngularSpringType.ComputeReducedIntertia()
	
	'reduced_inertia = IIf( ( a->inv_inertia + b->inv_inertia ) > 0.0 , 1.0 / ( a->inv_inertia + b->inv_inertia ) , 0.0 )
	
	If ( a->inv_inertia > 0.0 And b->inv_inertia > 0.0 ) Then
 		
 		reduced_inertia = 1.0 / ( a->inv_inertia + b->inv_inertia )
 		
 	ElseIf ( a->inv_inertia = 0.0 And b->inv_inertia > 0.0 ) Then
 		
 		reduced_inertia = b->inv_inertia
 		
 	ElseIf ( a->inv_inertia > 0.0 And b->inv_inertia = 0.0 ) Then 
 		
 		reduced_inertia = a->inv_inertia
 	
	ElseIf ( a->inv_inertia = 0.0 And b->inv_inertia = 0.0 ) Then 
 		
	Else
 		
 		'' undefined
 		
 	EndIf
	
End Sub

Sub AngularSpringType.ComputeRestImpulse()
	
	'' errors
	Dim As Single angle_error = rest_angle.perpdot( angle ) 
	
	Dim As Single velocity_error = b->angular_velocity - a->angular_velocity
	
	'' angular impulse needed to satisfy the constraint
	rest_impulse = -( c_stiffness * angle_error * inv_dt + c_damping * velocity_error )
	
End Sub

Sub AngularSpringType.ApplyCorrectiveImpulse()
	
	'' distance
	Dim As Vec2 distance_a = a->b->position - a->a->position
	Dim As Vec2 distance_b = b->b->position - b->a->position
	
	'' impulse
	Dim As Vec2 impulse_a = a->b->impulse - a->a->impulse
	Dim As Vec2 impulse_b = b->b->impulse - b->a->impulse
	
	'' current linear perpendicular impulse
	Dim As Single LocalImpulse_a = distance_a.perpdot( impulse_a ) * a->reduced_mass
	Dim As Single LocalImpulse_b = distance_b.perpdot( impulse_b ) * b->reduced_mass
	
	'' convert to angular impulse
	Dim As Single AngularImpulse_a = LocalImpulse_a * a->inv_inertia
	Dim As Single AngularImpulse_b = LocalImpulse_b * b->inv_inertia
	
	'' corrective angular impulse
	Dim As Single delta_impulse = AngularImpulse_b - AngularImpulse_a
		
	'Dim As Single impulse_error = delta_impulse - Rest_Impulse
	Dim As Single impulse_error = IIf( Not rest_impulse = 0.0 , delta_impulse - Rest_Impulse , 0.0 )
	
	Dim As Single corrective_impulse = -impulse_error * Reduced_Inertia
	
	Dim As Single new_Angular_Impulse_a = corrective_impulse * a->Inv_Inertia
	Dim As Single new_Angular_Impulse_b = corrective_impulse * b->Inv_Inertia
	
	'' convert to linear perpendicular impulse
	Dim As Vec2 new_impulse_a = distance_a.perpdot( new_Angular_Impulse_a ) * a->reduced_mass
	Dim As Vec2 new_impulse_b = distance_b.perpdot( new_Angular_Impulse_b ) * b->reduced_mass
	
	'' apply impulse scaled by mass
	a->a->AddImpulse(  new_impulse_a * a->a->inv_mass )
	a->b->AddImpulse( -new_impulse_a * a->b->inv_mass )
	
	b->a->AddImpulse( -new_impulse_b * b->a->inv_mass )
	b->b->AddImpulse(  new_impulse_b * b->b->inv_mass )
	
	'' add to warmstart
	accumulated_impulse += corrective_impulse
	
End Sub
	
Sub AngularSpringType.ApplyWarmStart()
	
	'' distance
	Dim As Vec2 distance_a = a->b->position - a->a->position
	Dim As Vec2 distance_b = b->b->position - b->a->position
	
	'' 
	Dim As Single warmstart_impulse = -c_warmstart * accumulated_impulse
	
	'' corrective angular impulse
	Dim As Single new_Angular_Impulse_a = warmstart_impulse * a->Inv_Inertia 
	Dim As Single new_Angular_Impulse_b = warmstart_impulse * b->Inv_Inertia
	
	'' convert to linear perpendicular impulse
	Dim As Vec2 new_impulse_a = distance_a.perpdot( new_Angular_Impulse_a ) * a->reduced_mass
	Dim As Vec2 new_impulse_b = distance_b.perpdot( new_Angular_Impulse_b ) * b->reduced_mass
	
	'' apply impulse scaled by mass
	a->a->AddImpulse(  new_impulse_a * a->a->inv_mass )
	a->b->AddImpulse( -new_impulse_a * a->b->inv_mass )
	
	b->a->AddImpulse( -new_impulse_b * b->a->inv_mass )
	b->b->AddImpulse(  new_impulse_b * b->b->inv_mass )

	'' clear warmstart
	accumulated_impulse = 0.0
	
End Sub
