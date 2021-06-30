''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 4, september 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''  Wheel - Wheel collision response
''
''*******************************************************************************

Type WheelWheelCollisionResponse
	
	Declare Constructor()
	Declare Constructor( ByVal _wheel1 As WheelType Ptr, ByVal _wheel2 As WheelType Ptr )
	
	Declare Destructor()
	
	Declare Sub ComputeData()
	Declare Sub ComputeRestImpulse()
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	
	As Vec2 unit
	
	As Vec2 accumulated_impulse
	As Vec2 rest_impulse
	
	As Single normal_M
	As Single tangent_M
	
	As Single c_stiffness
	As Single c_damping
	As Single c_warmstart
	
	As WheelType Ptr wheel_a
	As WheelType Ptr wheel_b
	
End Type


''
Constructor WheelWheelCollisionResponse()
	
	unit = Vec2( 0.0, 0.0 )
	
	accumulated_impulse = Vec2( 0.0, 0.0 )
	rest_impulse        = Vec2( 0.0, 0.0 )
	
	normal_M  = 0.0
	tangent_M = 0.0
	
	c_stiffness = 0.0
	c_damping   = 0.0
	c_warmstart = 0.0
	
	wheel_a = 0
	wheel_b = 0
	
End Constructor

Constructor WheelWheelCollisionResponse( ByVal _wheel1 As WheelType Ptr, ByVal _wheel2 As WheelType Ptr )
	
	wheel_a = _wheel1
	wheel_b = _wheel2
	
	'' Reduced mass scalar
	Dim As Single K1 = wheel_a->AngularState.inv_mass + wheel_b->AngularState.inv_mass
	Dim As Single K2 = wheel_a->AngularState.inv_inertia * wheel_a->radius * wheel_a->radius
	Dim As Single K3 = wheel_b->AngularState.inv_inertia * wheel_b->radius * wheel_b->radius
	
	Dim As Single K = K1 + K2 + K3
	
	normal_M = IIf( K1 > 0.0 , 1.0 / K1 , 0.0 )
	
	tangent_M = IIf( K > 0.0 , 1.0 / K , 0.0 )
	
	c_stiffness = DEFAULT_COLLISION_STIFFNESS
	c_damping   = DEFAULT_COLLISION_DAMPING
	c_warmstart = DEFAULT_COLLISION_WARMSTART
	
	
	
End Constructor

Destructor WheelWheelCollisionResponse()
	
End Destructor


''
Sub WheelWheelCollisionResponse.ComputeData()
	
	Dim As Vec2 distance = wheel_b->AngularState.position - wheel_a->AngularState.position
	
	Unit = distance.Unit()
	
End Sub

Sub WheelWheelCollisionResponse.ComputeRestImpulse()
	
	Dim As vec2 tangent = Unit.PerpCCW
	Dim As Single rest_distance = wheel_a->radius + wheel_b->radius
	
	'' State
	Dim As Vec2 r_a = -wheel_a->radius * Unit
	Dim As Vec2 r_b =  wheel_b->radius * Unit
	
	Dim As Vec2 contact_position_a = wheel_a->AngularState.position + r_a
	Dim As Vec2 contact_position_b = wheel_b->AngularState.position + r_b
	
	Dim As Vec2 contact_velocity_a = wheel_a->AngularState.velocity + r_a.PerpDot( wheel_a->AngularState.angular_velocity )
	Dim As Vec2 contact_velocity_b = wheel_b->AngularState.velocity + r_b.PerpDot( wheel_b->AngularState.angular_velocity )
	
	Dim As Vec2 delta_position = contact_position_b - contact_position_a
	Dim as Vec2 delta_velocity = contact_velocity_b - contact_velocity_a
	
	Dim as Single contact_velocity_normal  = delta_velocity.dot( unit )
	Dim As Single contact_velocity_tangent = delta_velocity.dot( tangent )
	
	Dim As Single c_friction = IIf( Abs( contact_velocity_tangent ) < STATIC_FRICTION_VELOCITY, _
			                          ( wheel_a->c_static_friction  + wheel_b->c_static_friction  ) * 0.5, _
			                          ( wheel_a->c_dynamic_friction + wheel_b->c_dynamic_friction ) * 0.5 )
	
	'' Error
	Dim As Single distance_error_normal = delta_position.dot( unit )
	Dim As Single velocity_error_normal = delta_velocity.dot( unit )
	
	
	'' Correction
	Dim As Single rest_impulse_normal = -( c_stiffness * distance_error_normal * inv_dt + c_damping * velocity_error_normal )
	
	Dim As Single max_impulse_tangent = -contact_velocity_tangent
	
	Dim As Single rest_impulse_tangent = IIf( Abs( max_impulse_tangent ) < ( c_friction * rest_impulse_normal ), _
			                                    max_impulse_tangent, _
			                                    Sgn( max_impulse_tangent ) * ( c_friction * rest_impulse_normal ) )
	
	
	rest_impulse = rest_impulse_normal * unit + rest_impulse_tangent * tangent
	
End Sub

Sub WheelWheelCollisionResponse.ApplyCorrectiveImpulse()
	
	Dim As vec2 tangent = Unit.PerpCCW
	
	Dim As Vec2 r_a = -wheel_a->radius * Unit
	Dim As Vec2 r_b =  wheel_b->radius * Unit
	
	'' Impulse
	Dim As Vec2 impulse_a = wheel_a->AngularState.impulse + r_a.PerpDot( wheel_a->AngularState.angular_impulse )
	Dim As Vec2 impulse_b = wheel_b->AngularState.impulse + r_b.PerpDot( wheel_b->AngularState.angular_impulse )
	
	Dim As Vec2 current_impulse = impulse_b - impulse_a
	
	'' Error
	Dim As Vec2 impulse_error = current_impulse - rest_impulse
	
	''' Correction
	Dim As Vec2 corrective_impulse = -impulse_error
	
	'' Apply
	wheel_a->AngularState.impulse -= corrective_impulse * wheel_a->AngularState.inv_mass
	wheel_b->AngularState.impulse += corrective_impulse * wheel_b->AngularState.inv_mass
	
	wheel_a->AngularState.angular_impulse -= r_a.PerpDot( corrective_impulse ) * wheel_a->AngularState.inv_inertia
	wheel_b->AngularState.angular_impulse += r_b.PerpDot( corrective_impulse ) * wheel_b->AngularState.inv_inertia
	
	'' Warmstart
	accumulated_impulse += corrective_impulse
	
	
End Sub

Sub WheelWheelCollisionResponse.ApplyWarmStart()
	
	
	
End Sub
