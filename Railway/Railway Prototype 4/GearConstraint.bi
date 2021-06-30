''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 4, september 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  Gear Constraint class
''
''
''  Math:
''
''  
''
''
''
''
''*******************************************************************************

Type GearConstraintType
	
	Declare Constructor()
	
	Declare Constructor( ByVal _Angular1   As AngularStateType Ptr, _
	                     ByVal _Angular2   As AngularStateType Ptr, _
	                     ByVal _Gear_Ratio As Single )
	
	Declare Constructor( ByVal _Angular1 As AngularStateType Ptr, _
	                     ByVal _Angular2 As AngularStateType Ptr, _
	                     ByVal _Radius1  As Single, _ 
	                     ByVal _Radius2  As Single )
	
	Declare Destructor()
	
	Declare Sub ComputeRestImpulse()
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	
	Declare Sub SetGearRatio( ByVal _Gear_Ratio As Single )
	
	Declare Sub SetGearRadii( ByVal _Radius1 As Single, _ 
	                          ByVal _Radius2 As Single )
	
	As Single accumulated_impulse
	As Single gear_ratio
	As Single M
	As Single rest_distance
	As Single rest_impulse
	
	As Single c_stiffness
	As Single c_damping
	As Single c_warmstart
	
	As AngularStateType Ptr body_a
	As AngularStateType Ptr body_b
	
End Type


''
Constructor GearConstraintType()
	
	accumulated_impulse = 0.0
	gear_ratio          = 0.0
	M                   = 0.0
	rest_distance       = 0.0
	rest_impulse        = 0.0
	
	c_stiffness = 0.0
	c_damping   = 0.0
	c_warmstart = 0.0
	
	body_a = 0
	body_b = 0
	
End Constructor

Constructor GearConstraintType( ByVal _Angular1   As AngularStateType Ptr, _
	                             ByVal _Angular2   As AngularStateType Ptr, _
	                             ByVal _Gear_Ratio As Single )
	
	body_a = _Angular1
	body_b = _Angular2
	
	SetGearRatio( _Gear_Ratio )
	
	c_stiffness = DEFAULT_GEAR_CONSTRAINT_STIFFNESS
	c_damping   = DEFAULT_GEAR_CONSTRAINT_DAMPING
	c_warmstart = DEFAULT_GEAR_CONSTRAINT_WARMSTART
	
	accumulated_impulse = 0.0
	rest_impulse        = 0.0
	
End Constructor

Constructor GearConstraintType( ByVal _Angular1 As AngularStateType Ptr, _
	                             ByVal _Angular2 As AngularStateType Ptr, _
	                             ByVal _Radius1  As Single, _ 
	                             ByVal _Radius2  As Single )
	
	body_a = _Angular1
	body_b = _Angular2
	
	SetGearRadii( _Radius1, _Radius2 )
	
	c_stiffness = DEFAULT_GEAR_CONSTRAINT_STIFFNESS
	c_damping   = DEFAULT_GEAR_CONSTRAINT_DAMPING
	c_warmstart = DEFAULT_GEAR_CONSTRAINT_WARMSTART
	
	accumulated_impulse = 0.0
	rest_impulse        = 0.0
	
End Constructor

Destructor GearConstraintType()

End Destructor


''
Sub GearConstraintType.ComputeRestImpulse()
	
	'' State
	Dim As Single distance_a = body_a->angle * gear_ratio
	Dim As Single distance_b = body_b->angle
	
	Dim As Single velocity_a = body_a->angular_velocity * gear_ratio
	Dim As Single velocity_b = body_b->angular_velocity
	
	'' Error
	Dim As Single distance_error = distance_b - distance_a - rest_distance
	Dim As Single velocity_error = velocity_b - velocity_a
	
	'' Correction
	rest_impulse = -( c_stiffness * distance_error * inv_dt + c_damping * velocity_error )
	
End Sub

Sub GearConstraintType.ApplyCorrectiveImpulse()
	
	If ( rest_impulse = 0.0 ) Then Exit Sub
		
	'' State
	Dim As Single impulse_a = body_a->angular_impulse * gear_ratio
	Dim As Single impulse_b = body_b->angular_impulse
	
	Dim As Single impulse = impulse_b - impulse_a
	
	''	Error
	Dim As Single impulse_error = impulse - rest_impulse
	
	'' Correction
	Dim As Single corrective_impulse = -impulse_error * M
	
	'' Apply
	body_a->angular_impulse -= corrective_impulse * body_a->inv_inertia * gear_ratio
	body_b->angular_impulse += corrective_impulse * body_b->inv_inertia

	'' Warmstart
	accumulated_impulse += corrective_impulse
	
End Sub

Sub GearConstraintType.ApplyWarmStart()
	
	If ( accumulated_impulse = 0.0 ) Then Exit Sub
	
	Dim As Single warmstart_impulse = c_warmstart * accumulated_impulse
	
	body_a->angular_impulse -= warmstart_impulse * body_a->inv_inertia * gear_ratio
	body_b->angular_impulse += warmstart_impulse * body_b->inv_inertia
	
	accumulated_impulse = 0.0
	
End Sub

Sub GearConstraintType.SetGearRatio( ByVal _Gear_Ratio As Single )
	
	gear_ratio = IIf( _Gear_Ratio <> 0.0 , _Gear_Ratio , 1.0 )
	
	rest_distance = body_b->angle - body_a->angle * gear_ratio
	
	Dim As Single K = body_a->inv_inertia * gear_ratio * gear_ratio + body_b->inv_inertia
	
	M = IIf( K > 0.0 , 1.0 / K , 0.0 )
	
End Sub

Sub GearConstraintType.SetGearRadii( ByVal _Radius1 As Single, ByVal _Radius2 As Single )
	
	gear_ratio = IIf( _Radius1 <> 0.0 And _Radius2 <> 0.0 , _Radius1 / _Radius2 , 1.0 )
	
	rest_distance = body_b->angle - body_a->angle * gear_ratio
	
	Dim As Single K = body_a->inv_inertia * gear_ratio * gear_ratio + body_b->inv_inertia
	
	M = IIf( K > 0.0 , 1.0 / K , 0.0 )
	
End Sub
