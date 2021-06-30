''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 1, october 2018
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''*******************************************************************************

Function GameType.CreateTree( ByVal _position As Vec2, _
	                           ByVal _angle    As Vec2, _
	                           ByVal _type     As integer ) As SoftBodyType Ptr
	
	Dim As SoftBodyType S
	
	Dim As SoftBodyType Ptr SP = SoftBodys.push_back( S )
	
	SP->LinearStates.Reserve( 512 )
	SP->LinearSprings.Reserve( 512 )
	SP->AngularSprings.Reserve( 512 )
	
	If ( _type = SCOTS_PINE ) Then
		
		
		
	EndIf
	
	Return SP
	
End Function

Function GameType.CreateLinearState( ByVal _mass  As Single, _
	                                  ByVal _array As LinearStateArray Ptr ) As LinearStateType Ptr
	
	Dim As LinearStateType L
	
	Dim As LinearStateType Ptr LP = _array->push_back( L )
	
	LP->mass = _mass
	
	LP->ComputeInvMass()
	
	Return LP
	
End Function

Function GameType.CreateLinearState( ByVal _position As Vec2, _
	                                  ByVal _mass     As Single, _
	                                  ByVal _array    As LinearStateArray Ptr ) As LinearStateType Ptr
	
	Dim As LinearStateType L
	
	Dim As LinearStateType Ptr LP = _array->push_back( L )
	
	LP->position = _position
	LP->mass     = _mass
	
	LP->ComputeInvMass()
	
	Return LP
	
End Function
	
Function GameType.CreateRoxel( ByVal _position As Vec2, _
	                            ByVal _mass     As Single, _
	                            ByVal _radius   As Single ) As RoxelType Ptr
	
	Dim As RoxelType R
	
	Dim As RoxelType Ptr RP = Roxels.push_back( R )
	
	RP->position = _position
	RP->mass     = _mass
	
	RP->ComputeInvMass()
	
	RP->radius = IIf( _radius > 0.0, _radius , ( ( _mass / C_DENSITY ) / (4/3) * PI ) ^ (1/3) )
	
	Return RP
	
End Function

Function GameType.CreateBox( ByVal _position As Vec2, _
	                          ByVal _radius   As Vec2 ) As BoxType Ptr
	
	Dim As BoxType B
	
	Dim As BoxType Ptr BP = Boxes.push_back( B )
	
	''
	BP->angularstate.position = _position
	
	''
	BP->radius = _radius
	
	''
	BP->density  = DEFAULT_DENSITY

	''
	BP->ComputeMass()
	BP->ComputeInertia()
	
	Return BP
	
End Function

Function GameType.CreateBox( ByVal _position As Vec2, _
	                          ByVal _radius   As Vec2, _ 
	                          ByVal _angle    As Single) As BoxType Ptr
	
	Dim As BoxType B
	
	Dim As BoxType Ptr BP = Boxes.push_back( B )
	
	''
	BP->angularstate.position = _position
	BP->angularstate.angle    = _angle
	
	BP->angularstate.direction_Vector = Vec2( Cos( _angle ), Sin( _angle ) )
	
	''
	BP->radius = _radius
	
	''
	BP->density  = DEFAULT_DENSITY

	''
	BP->ComputeMass()
	BP->ComputeInertia()
	
	Return BP
	
End Function

Function GameType.CreateBox( ByVal _position As Vec2, _
	                          ByVal _mass     As Single, _
	                          ByVal _radius   As Vec2 ) As BoxType Ptr
	
	Dim As BoxType B
	
	Dim As BoxType Ptr BP = Boxes.push_back( B )
	
	''
	BP->angularstate.position = _position
	BP->angularstate.mass     = _mass
	
	
	''
	BP->radius = _radius
	
	''
	BP->density  = DEFAULT_DENSITY
	
	BP->angularstate.ComputeInvMass()
	
	BP->ComputeInertia()
	
	Return BP
	
End Function

Function GameType.CreateBox( ByVal _width     As Single, _
	                          ByVal _position1 As Vec2, _
	                          ByVal _position2 As Vec2 ) As BoxType Ptr
	
	Dim As Vec2   position      = ( _position2 + _position1 ) * 0.5
	Dim As Vec2   length_vector = _position2 - _position1
	Dim As Single length        = length_vector.Length()
	Dim As Vec2   angle_vector  = length_vector.Unit()
	Dim As Single angle         = ATan2( angle_vector.y, angle_vector.x )
	
	Dim As BoxType B
	
	Dim As BoxType Ptr BP = Boxes.push_back( B )
	
	''
	BP->angularstate.position = position
	BP->angularstate.angle    = angle
	
	BP->angularstate.direction_Vector = angle_vector
	
	''
	BP->radius = Vec2( length, _width ) * 0.5
	
	''length
	BP->density  = DEFAULT_DENSITY

	''
	BP->ComputeMass()
	BP->ComputeInertia()
	
	Return BP
	
End Function

Function GameType.CreateWheel( ByVal _position As Vec2, _
	                            ByVal _radius   As Single ) As WheelType Ptr
	
	Dim As WheelType W
	
	Dim As WheelType Ptr WP = Wheels.push_back( W )
	
	''
	WP->angularstate.position = _position
	
	''
	WP->radius = _radius
	
	''
	WP->density  = DEFAULT_DENSITY

	''
	WP->ComputeMass()
	WP->ComputeInertia()
	
	Return WP
	
End Function

Function GameType.CreateWheel( ByVal _position As Vec2, _
	                            ByVal _radius   As Single, _ 
	                            ByVal _angle    As Single ) As WheelType Ptr
	
	Dim As WheelType W
	
	Dim As WheelType Ptr WP = Wheels.push_back( W )
	
	''
	WP->angularstate.position = _position
	WP->angularstate.angle    = _angle
	
	WP->angularstate.direction_Vector = Vec2( Cos( _angle ), Sin( _angle ) )
	
	''
	WP->radius = _radius
	
	''
	WP->density  = DEFAULT_DENSITY

	''
	WP->ComputeMass()
	WP->ComputeInertia()
	
	Return WP
	
End Function

'Function GameType.CreateWheel( ByVal _position As Vec2, _
'	                            ByVal _mass     As Single, _
'	                            ByVal _radius   As Single ) As WheelType Ptr
'	
'	Dim As WheelType W
'	
'	Dim As WheelType Ptr WP = Wheels.push_back( W )
'	
'	''
'	WP->angularstate.position = _position
'	WP->angularstate.mass     = _mass
'	
'	''
'	WP->radius = _radius
'	
'	''
'	WP->density = DEFAULT_DENSITY
'	
'	WP->angularstate.ComputeInvMass()
'	
'	WP->ComputeInertia()
'	
'	Return WP
'	
'End Function

Function GameType.CreateAngularSpring( ByVal _stiffness As Single, _
	                                    ByVal _damping   As Single, _
	                                    ByVal _warmstart As Single, _
	                                    ByVal _linear1   As LinearLinkType Ptr, _
	                                    ByVal _linear2   As LinearLinkType Ptr, _
	                                    ByVal _array     As AngularSpringArray Ptr ) As AngularSpringType Ptr
	
	Dim As AngularSpringType A
	
	Dim As AngularSpringType Ptr AP = _array->push_back( A )
	
	AP->c_stiffness = _stiffness
	AP->c_damping   = _damping
	AP->c_warmstart = _warmstart
	
	AP->a = _linear1
	AP->b = _linear2
	
	AP->rest_angle = Vec2( AP->a->unit_vector.dot( AP->b->unit_vector ), _
	                       AP->a->unit_vector.perpdot( AP->b->unit_vector ) )
	
	'AP->ComputeReducedIntertia()
	
	Return AP
	
End Function

Function GameType.CreateFixedSpring( ByVal _stiffness As Single, _
	                                  ByVal _damping   As Single, _
	                                  ByVal _warmstart As Single, _
	                                  ByVal _linear1   As LinearStateType Ptr, _
	                                  ByVal _linear2   As LinearStateType Ptr, _
	                                  ByVal _array     As FixedSpringArray Ptr ) As FixedSpringType Ptr
	
	Dim As FixedSpringType F
	
	Dim As FixedSpringType Ptr FP = _array->push_back( F )
	
	FP->c_stiffness = _stiffness
	FP->c_damping   = _damping
	FP->c_warmstart = _warmstart
	
	FP->LinearLink.a = _linear1
	FP->LinearLink.b = _linear2
	
	FP->rest_distance = FP->LinearLink.b->position - FP->LinearLink.a->position

	FP->LinearLink.mass = FP->LinearLink.a->mass + FP->LinearLink.b->mass
		
	FP->LinearLink.ComputeInvMass()
	
	FP->LinearLink.ComputeReducedMass()
	
	FP->ComputeData()
	
	Return FP
	
End Function

Function GameType.CreateLinearSpring( ByVal _linear1 As LinearStateType Ptr, _
	                                   ByVal _linear2 As LinearStateType Ptr, _
	                                   ByVal _array   As LinearSpringArray Ptr ) As LinearSpringType Ptr
	Dim As LinearSpringType L
	
	Dim As LinearSpringType Ptr LP = _array->push_back( L )
	
	LP->c_stiffness = DEFAULT_LINEAR_STIFFNESS
	LP->c_damping   = DEFAULT_LINEAR_DAMPING
	LP->c_warmstart = DEFAULT_LINEAR_WARMSTART
	
	LP->LinearLink.a = _linear1
	LP->LinearLink.b = _linear2
	
	LP->rest_distance = ( LP->LinearLink.b->position - LP->LinearLink.a->position ).length()

	LP->LinearLink.mass = LP->LinearLink.a->mass + LP->LinearLink.b->mass
		
	LP->LinearLink.ComputeInvMass()
		
	LP->LinearLink.ComputeReducedMass()
	
	LP->LinearLink.ComputeStateVectors()
	
	LP->LinearLink.ComputeUnitVector()
	
	LP->ComputeData()
	
	Return LP
	
End Function

Function GameType.CreateLinearSpring( ByVal _stiffness  As Single, _
	                                   ByVal _damping    As Single, _
	                                   ByVal _warmstart  As Single, _
	                                   ByVal _linear1    As LinearStateType Ptr, _
	                                   ByVal _linear2    As LinearStateType Ptr, _
	                                   ByVal _array      As LinearSpringArray Ptr ) As LinearSpringType Ptr
	
	Dim As LinearSpringType L
	
	Dim As LinearSpringType Ptr LP = _array->push_back( L )
	
	LP->c_stiffness = _stiffness
	LP->c_damping   = _damping
	LP->c_warmstart = _warmstart
	
	LP->LinearLink.a = _linear1
	LP->LinearLink.b = _linear2
	
	LP->rest_distance = ( LP->LinearLink.b->position - LP->LinearLink.a->position ).length()

	LP->LinearLink.mass = LP->LinearLink.a->mass + LP->LinearLink.b->mass
		
	LP->LinearLink.ComputeInvMass()
		
	LP->LinearLink.ComputeReducedMass()
	
	LP->LinearLink.ComputeStateVectors()
	
	LP->LinearLink.ComputeUnitVector()
	
	LP->ComputeData()
	
	Return LP
	
End Function

Function GameType.CreateRevoluteJoint( ByVal _Position  As Vec2, _ 
	                                    ByVal _Angular1 As AngularStateType Ptr, _
	                                    ByVal _Angular2 As AngularStateType Ptr ) As RevoluteJointType Ptr
	
	Dim As RevoluteJointType J
	
	Dim As RevoluteJointType Ptr JP = Joints.push_back( J )
	
	JP->body_a = _Angular1
	JP->body_b = _Angular2
	
	JP->anchor_a = ( _Position - JP->body_a->Position ).RotateCW( JP->body_a->angle )
	JP->anchor_b = ( _Position - JP->body_b->Position ).RotateCW( JP->body_b->angle )
	
	JP->c_stiffness = DEFAULT_JOINT_STIFFNESS
	JP->c_damping   = DEFAULT_JOINT_DAMPING
	JP->c_warmstart = DEFAULT_JOINT_WARMSTART
	
	Return JP
	
End Function

Function GameType.CreateRevoluteJoint( ByVal _Position  As Vec2, _ 
	                                    ByVal _stiffness As Single, _
	                                    ByVal _damping   As Single, _
	                                    ByVal _warmstart As Single, _
	                                    ByVal _Angular1  As AngularStateType Ptr, _
	                                    ByVal _Angular2  As AngularStateType Ptr ) As RevoluteJointType Ptr
	
	Dim As RevoluteJointType J
	
	Dim As RevoluteJointType Ptr JP = Joints.push_back( J )
	
	JP->body_a = _Angular1
	JP->body_b = _Angular2
	
	JP->anchor_a = ( _Position - JP->body_a->Position ).RotateCW( JP->body_a->angle )
	JP->anchor_b = ( _Position - JP->body_b->Position ).RotateCW( JP->body_b->angle )
	
	JP->c_stiffness = _stiffness
	JP->c_damping   = _damping
	JP->c_warmstart = _warmstart
	
	Return JP
	
End Function

Function GameType.CreateDistanceJoint( ByVal _Position1 As Vec2, _ 
	                                    ByVal _Position2 As Vec2, _ 
	                                    ByVal _Angular1  As AngularStateType Ptr, _
	                                    ByVal _Angular2  As AngularStateType Ptr ) As DistanceJointType Ptr
	
	Dim As DistanceJointType J
	
	Dim As DistanceJointType Ptr JP = DistanceJoints.push_back( J )
	
	JP->body_a = _Angular1
	JP->body_b = _Angular2
	
	JP->anchor_a = ( _Position1 - JP->body_a->Position ).RotateCW( JP->body_a->angle )
	JP->anchor_b = ( _Position2 - JP->body_b->Position ).RotateCW( JP->body_b->angle )
	
	JP->c_stiffness = DEFAULT_JOINT_STIFFNESS
	JP->c_damping   = DEFAULT_JOINT_DAMPING
	JP->c_warmstart = DEFAULT_JOINT_WARMSTART
	
	Dim As vec2 p1 = JP->body_a->Position + JP->anchor_a
	Dim As vec2 p2 = JP->body_b->Position + JP->anchor_b
	
	JP->rest_distance = ( p2 - p1 ).Length()
	
	Return JP
	
End Function

Function GameType.CreateSlideJoint( ByVal _Line     As Vec2, _ 
	                                 ByVal _Position As Vec2, _
	                                 ByVal _Angular1 As AngularStateType Ptr, _
	                                 ByVal _Angular2 As AngularStateType Ptr ) As SlideJointType Ptr
	
	Dim As SlideJointType J
	
	Dim As SlideJointType Ptr JP = SlideJoints.push_back( J )
	
	JP->body_a = _Angular1
	JP->body_b = _Angular2
	
	JP->unit = _Line.Unit()
	
	JP->anchor_a = ( _Position - JP->body_a->Position ).RotateCW( JP->body_a->angle )
	JP->anchor_b = ( _Position - JP->body_b->Position ).RotateCW( JP->body_b->angle )
	
	JP->c_stiffness = DEFAULT_JOINT_STIFFNESS
	JP->c_damping   = DEFAULT_JOINT_DAMPING
	JP->c_warmstart = DEFAULT_JOINT_WARMSTART
	
	Return JP
	
End Function

Function GameType.CreateSlideJoint( ByVal _Line      As Vec2, _ 
	                                 ByVal _Position1 As Vec2, _ 
	                                 ByVal _Position2 As Vec2, _ 
	                                 ByVal _Angular1  As AngularStateType Ptr, _
	                                 ByVal _Angular2  As AngularStateType Ptr ) As SlideJointType Ptr
	
	Dim As SlideJointType J
	
	Dim As SlideJointType Ptr JP = SlideJoints.push_back( J )
	
	JP->body_a = _Angular1
	JP->body_b = _Angular2
	
	JP->unit = _Line.Unit()
	
	JP->anchor_a = ( _Position1 - JP->body_a->Position ).RotateCW( JP->body_a->angle )
	JP->anchor_b = ( _Position2 - JP->body_b->Position ).RotateCW( JP->body_b->angle )
	
	JP->c_stiffness = DEFAULT_JOINT_STIFFNESS
	JP->c_damping   = DEFAULT_JOINT_DAMPING
	JP->c_warmstart = DEFAULT_JOINT_WARMSTART
	
	Return JP
	
End Function

Function GameType.CreateAngularJoint( ByVal _Angular1 As AngularStateType Ptr, _
	                                   ByVal _Angular2 As AngularStateType Ptr ) As AngularJointType Ptr
	
	
	Dim As AngularJointType J
	
	Dim As AngularJointType Ptr JP = AngularJoints.push_back( J )
	
	JP->body_a = _Angular1
	JP->body_b = _Angular2
	
	JP->rest_angle = JP->body_b->angle - JP->body_a->angle
	
	JP->M = 1.0 / ( JP->body_a->inv_inertia + JP->body_b->inv_inertia )
	
	JP->c_stiffness = DEFAULT_JOINT_STIFFNESS
	JP->c_damping   = DEFAULT_JOINT_DAMPING
	JP->c_warmstart = DEFAULT_JOINT_WARMSTART
	
	Return JP
	
End Function

Function GameType.CreateRope( ByVal _linear1    As LinearStateType Ptr, _
	                           ByVal _linear2    As LinearStateType Ptr, _
	                           ByVal _unitlength As Single ) As SoftBodyType Ptr
	
	Dim As SoftBodyType S
	
	Dim As SoftBodyType Ptr SP = SoftBodys.push_back( S )
		
	Dim As Vec2 Length_vector = _linear2->position - _linear1->position
	
	Dim As Vec2 Unit = Length_vector.Unit()
	
	Dim As Single Length = unit.dot( length_vector )
	
	Dim As Integer num_linearstates = Cast( Integer, Length / _unitlength )
		
	Dim As Integer num_springs = num_linearstates + 1
	
	''
	SP->LinearStates.Reserve( num_linearstates )
	SP->LinearSprings.Reserve( num_springs )
	SP->AngularSprings.Reserve( num_springs - 1 )
	
	''
	For i As Integer = 1 To num_linearstates - 1
		
		Dim As LinearStateType Ptr LP = CreateLinearState( 1.0, @(SP->LinearStates) )
		
		LP->Position = _linear1->position + Unit * ( Length / num_linearstates ) * i 
		
	Next
	
	''
	CreateLinearSpring( 0.5, 1.0, 0.5, _linear1, SP->LinearStates.p_front, @( SP->LinearSprings ) )
	
	''
	For i As Integer = 0 To num_springs - 4
		
		CreateLinearSpring( 0.5, 1.0, 0.5, SP->LinearStates[ i ], SP->LinearStates[ i + 1 ], @( SP->LinearSprings ) )
		
	Next
	
	CreateLinearSpring( 0.5, 1.0, 0.5, SP->LinearStates.P_back, _linear2, @( SP->LinearSprings ) )
	
	''
	For i As Integer = 0 To num_springs - 3
		
		CreateAngularSpring( 0.5, 1.0, 0.5, @(SP->LinearSprings[ i ]->LinearLink), @(SP->LinearSprings[ i + 1 ]->LinearLink), @( SP->AngularSprings ) )
		
	Next
	
	
	SP->ComputeData()
	
	Return SP
	
End Function

''
Function GameType.CreateSoftGirder( ByVal _position As Vec2, _
	                                 ByVal _angle    As Vec2, _
	                                 ByVal _size     As Vec2, _
	                                 ByVal _unit     As Vec2, _
	                                 ByVal _type     As Integer ) As SoftBodyType Ptr
	
	Dim As SoftBodyType S
	
	Dim As SoftBodyType Ptr SP = SoftBodys.push_back( S )
	
	SP->LinearStates.Reserve( _size.x * _size.y + 100 )
	SP->LinearSprings.Reserve( _size.x * _size.y * 2 + 100 )
	
	''	particles
	for y as integer = 0 to _size.y - 1
		for x as integer = 0 to _size.x - 1
			
			Dim As LinearStateType Ptr LP = CreateLinearState( 1.0, @(SP->LinearStates) )
			
		  	LP->position  = _position + Vec2( x * _unit.x, y * _unit.y ).RotateCCW( _angle )
		  	
		  	SP->mass += LP->mass
		  	
		Next
	Next
	
	SP->inv_mass = IIf( SP->mass > 0.0 , 1.0 / SP->mass , 0.0 )
	
	''  Longitudinal springs
	For y as integer = 0 to _size.y - 1
		For x as integer = 0 to _size.x - 2
			
			CreateLinearSpring( 1.0, 1.0, 0.5, _
			                   SP->LinearStates[ x + y * _size.x     ], _
			                   SP->LinearStates[ x + y * _size.x + 1 ], _
			                   @( SP->LinearSprings ) )
			
		Next
	Next
	
	''  Transverse springs
	for y as integer = 0 to _size.y - 2
		For x as integer = 0 to _size.x - 1
			
			CreateLinearSpring( 1.0, 1.0, 0.5, _
			                   SP->LinearStates[ x ], _
			                   SP->LinearStates[ x + _size.x ], _
			                   @( SP->LinearSprings ) )
			
		Next
	Next
	
	''  Diagonal "S" springs
	for y as integer = 0 to _size.y - 2
		For x as integer = 0 to _size.x - 2
			
			CreateLinearSpring( 1.0, 1.0, 0.5, _
			                   SP->LinearStates[ x ], _
			                   SP->LinearStates[ x + _size.x + 1 ], _
			                   @( SP->LinearSprings ) )
			
		Next
	Next
	'
	''  Diagonal "Z" springs
	for y as integer = 0 to _size.y - 2
		For x as integer = 1 to _size.x - 1
			
			CreateLinearSpring( 1.0, 1.0, 0.5, _
			                   SP->LinearStates[ x ], _
			                   SP->LinearStates[ x + _size.x - 1 ], _
			                   @( SP->LinearSprings ) )
			
		Next
	Next
	
	'	'' Diagonal "O" springs
	'For y as integer = 0 to _size.y - 2
	'	For x as integer = 0 to _size.x - 2
	'		
	'		CreateLinearSpring( 0.2, 1.0, 0.5, _
	'		                    @( SP->LinearSprings[ x ]->LinearLink ), _
	'		                    @( SP->LinearSprings[ x + ( _size.x  - 1 ) * 2  ]->LinearLink ), _
	'		                    @(SP->LinearSprings) )
	'		
	'	Next
	'Next
	'
	'For y as integer = 0 to _size.y - 2
	'	For x as integer = 0 to _size.x - 2		
	'		
	'		CreateLinearSpring( 0.2, 1.0, 0.5, _
	'		                    @(SP->LinearSprings[ x + ( _size.x  - 1 ) ]->LinearLink), _
	'		                    @(SP->LinearSprings[ x + ( _size.x  - 1 ) * 2  ]->LinearLink), _
	'		                    @(SP->LinearSprings) )
	'		
	'	Next
	'Next
	'
	'For y as integer = 0 to _size.y - 2
	'	For x as integer = 0 to _size.x - 2
	'		
	'		CreateLinearSpring( 0.2, 1.0, 0.5, _
	'		                    @(SP->LinearSprings[ x ]->LinearLink), _
	'		                    @(SP->LinearSprings[ x + ( _size.x  - 1 ) * 2 + 1  ]->LinearLink), _
	'		                    @(SP->LinearSprings) )
	'		
	'	Next
	'Next
	'
	'For y as integer = 0 to _size.y - 2
	'	For x as integer = 0 to _size.x - 2
	'		
	'		CreateLinearSpring( 0.2, 1.0, 0.5, _
	'		                    @(SP->LinearSprings[ x + ( _size.x  - 1 ) ]->LinearLink), _
	'		                    @(SP->LinearSprings[ x + ( _size.x  - 1 ) * 2 + 1  ]->LinearLink), _
	'		                    @(SP->LinearSprings) )
	'		
	'	Next
	'Next
	
	SP->ComputeData()
	
	Return SP
	
End Function




'Sub GameType.CreateShapeGirder( ByVal _position As Vec2, _
'	                        ByVal _angle    As Vec2, _
'	                        ByVal _size   As Vec2, _
'	                        ByVal _unit     As Vec2, _
'	                        ByVal _type     As integer )
'	
'	'' Type 0 - Pratt truss  - SSSS
'	'' Type 1 - Howe truss   - ZZZZ
'	'' Type 2 - Warren truss - VVVV
'	'' Type 3 - Brown truss  - XXXX
'	'' Type 4 - K-truss      - KKKK
'	'' Type 5 - O-truss      - OOOO
'	'' Type 6 - W-truss      - WWWW
'	
'	Dim As Integer first_linear = 0
'	Dim As Integer first_linear_spring = 0
'	Dim As Single  invMass  = 0
'	
'	''	particles
'	for i as integer = 0 to _size.x - 1
'		for j as integer = 0 to _size.y - 1
'			
'			Dim As LinearStateType R
'			
'			R.mass         = 1.0
'			R.inv_mass = 1.0 / R.mass
'			
'		  	R.position  = _position + Vec2( (i-1) * _unit.x, (j-1) * _unit.y ).RotateCCW( _angle )
'		  	
'		  	LinearStates.push_back( R )
'		  	
'		  	If ( i = 0 And j = 0 ) Then first_linear = LinearStates.i_back
'		  	
'		Next
'	Next
'	
'	''  Longitudinal springs, "===="
'	for i as integer = 0 to _size.y - 1
'		For j as integer = 0 to _size.x - 2
'			
'			Dim As LinearSpringType S 
'			
'			S.LinearLink.a = LinearStates[ first_linear + i           + j * _size.y ]
'			S.LinearLink.b = LinearStates[ first_linear + i + _size.y + j * _size.y ]
'			
'			S.rest_distance = ( S.LinearLink.b->position - S.LinearLink.a->position ).Length()
'			
'			S.LinearLink.mass = S.LinearLink.a->mass + S.LinearLink.b->mass
'				
'			S.LinearLink.inv_Mass = IIf( S.LinearLink.mass = 0.0 , 0.0 , 1.0 / S.LinearLink.mass )
'				
'			S.LinearLink.reduced_mass = 1.0 / ( S.LinearLink.a->inv_mass + S.LinearLink.b->inv_mass )
'			
'			LinearSprings.push_back( S )
'			
'			If ( i = 0 And j = 0 ) Then first_linear_spring = LinearSprings.i_back
'			
'		Next
'	Next
'	
'	''  Transverse springs, "||||"
'	for i as integer = 0 to _size.x - 1
'		For j as integer = 0 to _size.y - 2
'			
'			Dim As LinearSpringType S 
'			
'			S.LinearLink.a = LinearStates[ first_linear + i * _size.y + j     ]
'			S.LinearLink.b = LinearStates[ first_linear + i * _size.y + j + 1 ]
'			
'			S.rest_distance = ( S.LinearLink.b->position - S.LinearLink.a->position ).Length()
'			S.LinearLink.mass = S.LinearLink.a->mass + S.LinearLink.b->mass
'				
'			S.LinearLink.inv_Mass = IIf( S.LinearLink.mass = 0.0 , 0.0 , 1.0 / S.LinearLink.mass )
'				
'			S.LinearLink.reduced_mass = 1.0 / ( S.LinearLink.a->inv_mass + S.LinearLink.b->inv_mass )
'			
'			LinearSprings.push_back( S )
'			
'		Next
'	Next
'	
'	''  diagonal springs, "SSSS"
'	If ( _type = S_TRUSS Or _type = X_TRUSS ) Then
'		
'		for i as integer = 0 to _size.y - 2
'			For j as integer = 0 to _size.x - 2
'				
'				Dim As LinearSpringType S 
'				
'				S.LinearLink.a = LinearStates[ first_linear +   i + j   * _size.y         ]
'				S.LinearLink.b = LinearStates[ first_linear + ( j + 1 ) * _size.y + i + 1 ]
'				
'				S.rest_distance = ( S.LinearLink.b->position - S.LinearLink.a->position ).Length()
'				'Dim As Single invMass     = S.LinearLink.a->inv_mass + S.LinearLink.b->inv_mass
'				'S.LinearLink.reduced_mass  = IIf( invMass = 0.0 , 0.0 , 1.0 / invMass )
'				S.LinearLink.mass = S.LinearLink.a->mass + S.LinearLink.b->mass
'					
'				S.LinearLink.inv_Mass = IIf( S.LinearLink.mass = 0.0 , 0.0 , 1.0 / S.LinearLink.mass )
'					
'				S.LinearLink.reduced_mass = 1.0 / ( S.LinearLink.a->inv_mass + S.LinearLink.b->inv_mass )
'				
'				LinearSprings.push_back( S )
'				
'			Next
'		Next
'	
'	EndIf
'	
'	''  diagonal springs, "ZZZZ"
'	If ( _type = Z_TRUSS Or _type = X_TRUSS ) Then
'		
'		For i as integer = 0 to _size.y - 2
'			For j as integer = 0 to _size.x - 2
'				
'				Dim As LinearSpringType S 
'				
'				S.LinearLink.a = LinearStates[ first_linear + ( j + 1 ) *_size.y + i     ]
'				S.LinearLink.b = LinearStates[ first_linear +   j       *_size.y + i + 1 ]
'				
'				S.rest_distance = ( S.LinearLink.b->position - S.LinearLink.a->position ).Length()
'				'Dim As Single invMass     = S.LinearLink.a->inv_mass + S.LinearLink.b->inv_mass
'				'S.LinearLink.reduced_mass  = IIf( invMass = 0.0 , 0.0 , 1.0 / invMass )
'				S.LinearLink.mass = S.LinearLink.a->mass + S.LinearLink.b->mass
'		
'				S.LinearLink.inv_Mass = IIf( S.LinearLink.mass = 0.0 , 0.0 , 1.0 / S.LinearLink.mass )
'		
'				S.LinearLink.reduced_mass = 1.0 / ( S.LinearLink.a->inv_mass + S.LinearLink.b->inv_mass )
'				
'				LinearSprings.push_back( S )
'				
'			Next
'		Next
'	
'	EndIf
'	
'	''  zig-zagging springs, "VVV"
'	If ( _type = V_TRUSS ) Then
'		
'		for i as integer = 0 to _size.y - 2
'			For j as integer = 0 to _size.x - 2 Step 2
'				
'				Dim As LinearSpringType S 
'				
'				S.LinearLink.a = LinearStates[ first_linear +   i + j   * _size.y         ]
'				S.LinearLink.b = LinearStates[ first_linear + ( j + 1 ) * _size.y + i + 1 ]
'				
'				S.rest_distance = ( S.LinearLink.b->position - S.LinearLink.a->position ).Length()
'				S.LinearLink.mass = S.LinearLink.a->mass + S.LinearLink.b->mass
'					
'				S.LinearLink.inv_Mass = IIf( S.LinearLink.mass = 0.0 , 0.0 , 1.0 / S.LinearLink.mass )
'					
'				S.LinearLink.reduced_mass = 1.0 / ( S.LinearLink.a->inv_mass + S.LinearLink.b->inv_mass )
'				
'				LinearSprings.push_back( S )
'				
'			Next
'		Next
'		
'		For i as integer = 0 to _size.y - 2
'			For j as integer = 1 to _size.x - 2 Step 2
'				
'				Dim As LinearSpringType S 
'				
'				S.LinearLink.a = LinearStates[ first_linear + ( j + 1 ) *_size.y + i     ]
'				S.LinearLink.b = LinearStates[ first_linear +   j       *_size.y + i + 1 ]
'				
'				S.rest_distance = ( S.LinearLink.b->position - S.LinearLink.a->position ).Length()
'				S.LinearLink.mass = S.LinearLink.a->mass + S.LinearLink.b->mass
'					
'				S.LinearLink.inv_Mass = IIf( S.LinearLink.mass = 0.0 , 0.0 , 1.0 / S.LinearLink.mass )
'					
'				S.LinearLink.reduced_mass = 1.0 / ( S.LinearLink.a->inv_mass + S.LinearLink.b->inv_mass )
'				
'				LinearSprings.push_back( S )
'				
'			Next
'		Next
'		
'	EndIf
'	
'		'' K-Truss 
'	If ( _type = K_TRUSS ) Then
'		
'		for i as integer = 0 to _size.y - 2
'			For j as integer = 0 to _size.x - 2
'				
'				Dim As LinearSpringType S
'				
'				'S.LinearLink.a = LinearStates   [ first_linear        + i + j * _size.y ]
'				'S.LinearLink.b = @LinearSprings [ first_linear_spring + i + j * _size.y ]->LinearLink
'				'
'				'S.rest_distance = ( S.LinearLink.b->position - S.LinearLink.a->position ).Length()
'				'S.LinearLink.mass = S.LinearLink.a->mass + S.LinearLink.b->mass
'				'	
'				'S.LinearLink.inv_Mass = IIf( S.LinearLink.mass = 0.0 , 0.0 , 1.0 / S.LinearLink.mass )
'				'	
'				'S.LinearLink.reduced_mass = 1.0 / ( S.LinearLink.a->inv_mass + S.LinearLink.b->inv_mass )
'				'
'				'LinearSprings.push_back( S )
'				
'				'LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
'				'											  *SP->LinearStates_[ x + 1 + y * _points.x ], _
'				'											  *SP->LinearSprings_[ x + y * _points.x + _points.y * ( _points.x - 1 ) ] )
'			
'				'SP->LinearSprings_.push_back( LP )
'				'
'				'LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
'				'											  *SP->LinearStates_[ x + 1 + ( y + 1 ) * _points.x ], _
'				'											  *SP->LinearSprings_[ x + y * _points.x + _points.y * ( _points.x - 1 ) ] )
'			
'				'SP->LinearSprings_.push_back( LP )
'				
'			Next
'		Next
'		
'	EndIf
'	
'	
'End Sub
