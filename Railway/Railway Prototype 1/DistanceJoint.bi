''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 1, october 2018
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''  Distance Joint class
''
''*******************************************************************************


Type DistanceJointType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub ComputeRestImpulse()
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	
	As Vec2 accumulated_impulse
	As Vec2 anchor_a
	As Vec2 anchor_b
	As Vec2 r_a
	As Vec2 r_b
	As Vec2 unit
	
	As Single rest_distance
	As Single rest_impulse
	As Single M
	
	As Single c_stiffness
	As Single c_damping
	As Single c_warmstart
	
	As AngularStateType Ptr body_a
	As AngularStateType Ptr body_b
	
End Type


''
Constructor DistanceJointType
	
	accumulated_impulse = Vec2( 0.0, 0.0 )
	anchor_a            = Vec2( 0.0, 0.0 )
	anchor_b            = Vec2( 0.0, 0.0 )
	r_a                 = Vec2( 0.0, 0.0 )
	r_b                 = Vec2( 0.0, 0.0 )
	unit                = Vec2( 0.0, 0.0 )
	
	rest_distance = 0.0
	rest_impulse  = 0.0
	M             = 0.0
	
	c_stiffness = 0.0
	c_damping   = 0.0
	c_warmstart = 0.0
	
	body_a = 0
	body_b = 0

End Constructor

Destructor DistanceJointType
	
End Destructor


''
Sub DistanceJointType.ComputeRestImpulse()
	
	'' State
	r_a = body_a->direction_vector.Rotateccw( anchor_a )
	r_b = body_b->direction_vector.Rotateccw( anchor_b )
	
	Dim As Vec2 position_a = body_a->position + r_a
	Dim As Vec2 position_b = body_b->position + r_b
	
	Dim As Vec2 velocity_a = body_a->velocity + r_a.Perpdot( body_a->angular_velocity )
	Dim As Vec2 velocity_b = body_b->velocity + r_b.Perpdot( body_b->angular_velocity )
	
	Dim As Vec2 distance = position_b - position_a
	Dim As Vec2 velocity = velocity_b - velocity_a
	
	unit = distance.Unit()
	
	'' Error
	Dim As Single distance_error = unit.dot( distance ) - rest_distance
	Dim As Single velocity_error = unit.dot( velocity )
	
	'' Correction
	rest_impulse = -( c_stiffness * distance_error * inv_dt + c_damping * velocity_error )
	
	'' Reduced mass scalar
	Dim As Single K1 = body_a->inv_mass + body_b->inv_mass
	Dim As Single K2 = body_a->inv_inertia * unit.perpdot( r_a ) * unit.perpdot( r_a )
	Dim As Single K3 = body_b->inv_inertia * unit.perpdot( r_b ) * unit.perpdot( r_b )
	
	Dim As Single K = K1 + K2 + K3
	
	M = IIf( K > 0.0 , 1.0 / K , 0.0 )
	
End Sub

Sub DistanceJointType.ApplyCorrectiveImpulse()
	
	Dim As Vec2 impulse_a = body_a->impulse + r_a.PerpDot( body_a->angular_impulse )
	Dim As Vec2 impulse_b = body_b->impulse + r_b.PerpDot( body_b->angular_impulse )
	
	Dim As Vec2 current_impulse = impulse_b - impulse_a
	
	Dim As Single impulse_error = unit.dot( current_impulse ) - rest_impulse
	
	Dim As Vec2 corrective_impulse = -impulse_error * M * Unit
	
	body_a->impulse -= corrective_impulse * body_a->inv_mass
	body_b->impulse += corrective_impulse * body_b->inv_mass
	
	body_a->angular_impulse -= r_a.PerpDot( corrective_impulse ) * body_a->inv_inertia
	body_b->angular_impulse += r_b.PerpDot( corrective_impulse ) * body_b->inv_inertia
	
	accumulated_impulse += corrective_impulse
	
End Sub

Sub DistanceJointType.ApplyWarmStart()
	
	Dim As Single projected_impulse = unit.dot( accumulated_impulse )
	
	If ( projected_impulse < 0.0 ) Then
		
		Dim As Vec2 warmstart_impulse = c_warmstart * projected_impulse * unit
		
		body_a->impulse -= warmstart_impulse * body_a->inv_mass
		body_b->impulse += warmstart_impulse * body_b->inv_mass
		
		body_a->angular_impulse -= r_a.PerpDot( warmstart_impulse ) * body_a->inv_inertia
		body_b->angular_impulse += r_b.PerpDot( warmstart_impulse ) * body_b->inv_inertia
	
	End If
	
	accumulated_impulse = Vec2( 0.0, 0.0 )
	
End Sub
