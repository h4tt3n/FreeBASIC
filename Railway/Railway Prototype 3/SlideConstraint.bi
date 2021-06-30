''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 3, september 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''  Slide Constraint class
''
''*******************************************************************************

Type SlideConstraintType
	
	Declare Constructor()
	
	Declare Constructor( ByVal _Line     As Vec2, _ 
	                     ByVal _Position As Vec2, _
	                     ByVal _Angular1 As AngularStateType Ptr, _
	                     ByVal _Angular2 As AngularStateType Ptr )
	
	Declare Constructor( ByVal _Line      As Vec2, _ 
	                     ByVal _Position1 As Vec2, _ 
	                     ByVal _Position2 As Vec2, _ 
	                     ByVal _Angular1  As AngularStateType Ptr, _
	                     ByVal _Angular2  As AngularStateType Ptr )
	
	Declare Destructor()
	
	Declare Sub ComputeData()
	Declare Sub ComputeRestImpulse()
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	
	As Vec2 anchor_a
	As Vec2 anchor_b
	As Vec2 r_a
	As Vec2 r_b
	
	As Vec2 unit
	As Vec2 n
	
	As Vec2 accumulated_impulse
	
	As Single M
	As Single rest_impulse
	
	As Single c_stiffness
	As Single c_damping
	As Single c_warmstart
	
	As AngularStateType Ptr body_a
	As AngularStateType Ptr body_b
	
End Type


''
Constructor SlideConstraintType()
	
	anchor_a = Vec2( 0.0, 0.0 )
	anchor_b = Vec2( 0.0, 0.0 )
	r_a      = Vec2( 0.0, 0.0 )
	r_b      = Vec2( 0.0, 0.0 )
	
	unit = Vec2( 0.0, 0.0 )
	n    = Vec2( 0.0, 0.0 )
	
	accumulated_impulse = Vec2( 0.0, 0.0 )
	
	M            = 0.0
	rest_impulse = 0.0
	
	c_stiffness = 0.0
	c_damping   = 0.0
	c_warmstart = 0.0
	
	body_a = 0
	body_b = 0
	
End Constructor

Constructor SlideConstraintType( ByVal _Line     As Vec2, _ 
	                         ByVal _Position As Vec2, _
	                         ByVal _Angular1 As AngularStateType Ptr, _
	                         ByVal _Angular2 As AngularStateType Ptr )
	
	body_a = _Angular1
	body_b = _Angular2
	
	unit = _Line.Unit()
	
	anchor_a = ( _Position - body_a->Position ).RotateCW( body_a->angle )
	anchor_b = ( _Position - body_b->Position ).RotateCW( body_b->angle )
	
	c_stiffness = DEFAULT_SLIDE_CONSTRAINT_STIFFNESS
	c_damping   = DEFAULT_SLIDE_CONSTRAINT_DAMPING
	c_warmstart = DEFAULT_SLIDE_CONSTRAINT_WARMSTART
	
End Constructor

Constructor SlideConstraintType( ByVal _Line      As Vec2, _ 
	                         ByVal _Position1 As Vec2, _ 
	                         ByVal _Position2 As Vec2, _ 
	                         ByVal _Angular1  As AngularStateType Ptr, _
	                         ByVal _Angular2  As AngularStateType Ptr )
	
	body_a = _Angular1
	body_b = _Angular2
	
	unit = _Line.Unit()
	
	anchor_a = ( _Position1 - body_a->Position ).RotateCW( body_a->angle )
	anchor_b = ( _Position2 - body_b->Position ).RotateCW( body_b->angle )
	
	c_stiffness = DEFAULT_SLIDE_CONSTRAINT_STIFFNESS
	c_damping   = DEFAULT_SLIDE_CONSTRAINT_DAMPING
	c_warmstart = DEFAULT_SLIDE_CONSTRAINT_WARMSTART
	
End Constructor

Destructor SlideConstraintType()

End Destructor


''
Sub SlideConstraintType.ComputeData()
	
	n = body_a->direction_vector.Rotateccw( unit )
	
	r_a = body_a->direction_vector.Rotateccw( anchor_a )
	r_b = body_b->direction_vector.Rotateccw( anchor_b )
	
	r_a += n.dot( ( body_b->position + r_b ) - ( body_a->position + r_a ) ) * n
	
	Dim As Vec2 t = n.perpccw()
	
	'' Reduced mass scalar
	Dim As Single K1 = body_a->inv_mass + body_b->inv_mass
	Dim As Single K2 = body_a->inv_inertia * t.perpdot( r_a ) * t.perpdot( r_a )
	Dim As Single K3 = body_b->inv_inertia * t.perpdot( r_b ) * t.perpdot( r_b )
	
	Dim As Single K = K1 + K2 + K3
	
	M = IIf( K > 0.0 , 1.0 / K , FLOAT_MAX )
	
End Sub

Sub SlideConstraintType.ComputeRestImpulse()
			
	'' State
	Dim As Vec2 position_a = body_a->position + r_a
	Dim As Vec2 position_b = body_b->position + r_b
	
	Dim As Vec2 velocity_a = body_a->velocity + r_a.Perpdot( body_a->angular_velocity )
	Dim As Vec2 velocity_b = body_b->velocity + r_b.Perpdot( body_b->angular_velocity )
	
	Dim As Vec2 distance = position_b - position_a
	Dim As Vec2 velocity = velocity_b - velocity_a
	
	'' Error
	Dim As Vec2 t = n.perpccw()
	
	Dim As Single distance_error = t.dot( distance )
	Dim As Single velocity_error = t.dot( velocity )
	
	'' Correction
	rest_impulse = -( c_stiffness * distance_error * inv_dt + c_damping * velocity_error )
	
End Sub

Sub SlideConstraintType.ApplyCorrectiveImpulse()
	
	'' State
	Dim As Vec2 impulse_a = body_a->impulse + r_a.PerpDot( body_a->angular_impulse )
	Dim As Vec2 impulse_b = body_b->impulse + r_b.PerpDot( body_b->angular_impulse )
	
	Dim As Vec2 current_impulse = impulse_b - impulse_a
	
	'' Error
	Dim As Vec2 t = n.perpccw()
	
	Dim As Single impulse_error = t.dot( current_impulse ) - rest_impulse
	
	'' Correction
	Dim As Vec2 corrective_impulse = -impulse_error * M * t
	
	body_a->impulse -= corrective_impulse * body_a->inv_mass
	body_b->impulse += corrective_impulse * body_b->inv_mass
	
	body_a->angular_impulse -= r_a.PerpDot( corrective_impulse ) * body_a->inv_inertia
	body_b->angular_impulse += r_b.PerpDot( corrective_impulse ) * body_b->inv_inertia
	
	accumulated_impulse += corrective_impulse
	
End Sub

Sub SlideConstraintType.ApplyWarmStart()
	
	Dim As Vec2 t = n.perpccw()
	
	Dim As Single projected_impulse = t.dot( accumulated_impulse )
	
	'If ( projected_impulse < 0.0 ) Then
		
		Dim As Vec2 warmstart_impulse = c_warmstart * projected_impulse * t
		
		body_a->impulse -= warmstart_impulse * body_a->inv_mass
		body_b->impulse += warmstart_impulse * body_b->inv_mass
		
		body_a->angular_impulse -= r_a.PerpDot( warmstart_impulse ) * body_a->inv_inertia
		body_b->angular_impulse += r_b.PerpDot( warmstart_impulse ) * body_b->inv_inertia
	
	'End If
	
	accumulated_impulse = Vec2( 0.0, 0.0 )
	
End Sub
