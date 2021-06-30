''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 2, september 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''  Revolute Joint class
''
''*******************************************************************************

Type RevoluteJointType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub ComputeRestImpulse()
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	
	As Mat22 M
	
	As Vec2 anchor_a
	As Vec2 anchor_b
	As Vec2 r_a
	As Vec2 r_b
	As Vec2 accumulated_impulse
	As Vec2 rest_impulse
	
	As Single c_stiffness
	As Single c_damping
	As Single c_warmstart
	
	As AngularStateType Ptr body_a
	As AngularStateType Ptr body_b
	
End Type

''
Constructor RevoluteJointType()
	
	M.MakeZero()
	
	anchor_a = Vec2( 0.0, 0.0 )
	anchor_b = Vec2( 0.0, 0.0 )
	r_a      = Vec2( 0.0, 0.0 )
	r_b      = Vec2( 0.0, 0.0 )
	
	accumulated_impulse = Vec2( 0.0, 0.0 )
	rest_impulse        = Vec2( 0.0, 0.0 )
	
	c_stiffness = 0.0
	c_damping   = 0.0
	c_warmstart = 0.0
	
	body_a = 0
	body_b = 0
	
End Constructor

Destructor RevoluteJointType()
	
End Destructor

''
Sub RevoluteJointType.ComputeRestImpulse()
	
	'' anchor state
	r_a = body_a->direction_vector.Rotateccw( anchor_a )
	r_b = body_b->direction_vector.Rotateccw( anchor_b )
	
	Dim As Vec2 position_a = body_a->position + r_a
	Dim As Vec2 position_b = body_b->position + r_b
	
	Dim As Vec2 velocity_a = body_a->velocity + r_a.Perpdot( body_a->angular_velocity )
	Dim As Vec2 velocity_b = body_b->velocity + r_b.Perpdot( body_b->angular_velocity )
	
	'' state error
	Dim As Vec2 distance_error = position_b - position_a
	Dim As Vec2 velocity_error = velocity_b - velocity_a
	
	'' correction
	rest_impulse = -( c_stiffness * distance_error * inv_dt + c_damping * velocity_error )
	
	'' Reduced mass matrix
	Dim As Mat22 K1 = Mat22( _
	body_a->inv_mass + body_b->inv_mass, 0.0, _
	0.0									 	  , body_a->inv_mass + body_b->inv_mass )
	
	Dim As Mat22 K2 = Mat22( _
	body_a->inv_inertia, 0.0, _
	0.0,	               body_a->inv_inertia )
	
	Dim As Mat22 K3 = Mat22( _
	body_b->inv_inertia, 0.0, _
	0.0,	               body_b->inv_inertia )
	
	Dim As Mat22 K4 = Mat22( _
	 r_a.y * r_a.y, -r_a.x * r_a.y, _
	-r_a.x * r_a.y,  r_a.x * r_a.x )
	
	Dim As Mat22 K5 = Mat22( _
	 r_b.y * r_b.y, -r_b.x * r_b.y, _
	-r_b.x * r_b.y,  r_b.x * r_b.x )
	
	Dim As Mat22 K = K1 + K2 * K4 + K3 * K5

	M = K.inverse()
	
End Sub

Sub RevoluteJointType.ApplyCorrectiveImpulse()
	
	'' delta impulse
	Dim As Vec2 impulse_a = body_a->impulse + r_a.PerpDot( body_a->angular_impulse )
	Dim As Vec2 impulse_b = body_b->impulse + r_b.PerpDot( body_b->angular_impulse )
	
	Dim As Vec2 current_impulse = impulse_b - impulse_a
	
	'' impulse error
	Dim As Vec2 impulse_error = current_impulse - rest_impulse
	
	'' coreection impulse
	Dim As Vec2 corrective_impulse = -impulse_error * M
	
	'' apply linear
	body_a->impulse -= corrective_impulse * body_a->inv_mass
	body_b->impulse += corrective_impulse * body_b->inv_mass
	
	'' apply angular
	body_a->angular_impulse -= r_a.PerpDot( corrective_impulse ) * body_a->inv_inertia
	body_b->angular_impulse += r_b.PerpDot( corrective_impulse ) * body_b->inv_inertia
	
	''
	accumulated_impulse += corrective_impulse
	
End Sub

Sub RevoluteJointType.ApplyWarmStart()
	
	''' creates jitter, and removes energy.
	'
	'Dim As Vec2 position_a = body_a->position + r_a
	'Dim As Vec2 position_b = body_b->position + r_b
	'
	'Dim As Vec2 Distance = position_b - position_a
	'
	''Dim As Vec2 projected_impulse = accumulated_impulse
	'Dim As Vec2 projected_impulse = Distance.Project( accumulated_impulse )
	'
	'If ( Distance.dot( projected_impulse ) < 0.0 ) Then
	'	
	'	Dim As Vec2 warmstart_impulse = c_warmstart * projected_impulse
	'	
	'	body_a->impulse -= warmstart_impulse * body_a->inv_mass
	'	body_b->impulse += warmstart_impulse * body_b->inv_mass
	'	
	'	body_a->angular_impulse -= r_a.PerpDot( warmstart_impulse ) * body_a->inv_inertia
	'	body_b->angular_impulse += r_b.PerpDot( warmstart_impulse ) * body_b->inv_inertia
	'	
	'EndIf
	'
	'accumulated_impulse = Vec2( 0.0, 0.0 )
	
End Sub
