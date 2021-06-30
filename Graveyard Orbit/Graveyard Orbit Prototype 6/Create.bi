''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 6, september 2018
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
	
Function GameType.CreateGravity( ByVal _linear1 As LinearStateType Ptr, _
	                              ByVal _linear2 As LinearStateType Ptr ) As GravityType Ptr
	
	Dim As GravityType G
	
	Dim As GravityType Ptr GP = Gravitys.push_back( G )
	
	GP->LinearLink.a = _linear1
	GP->LinearLink.b = _linear2
	
	GP->LinearLink.mass = GP->LinearLink.a->mass + GP->LinearLink.b->mass
		
	GP->LinearLink.ComputeInvMass()
		
	GP->LinearLink.ComputeReducedMass()
	
	GP->LinearLink.ComputeStateVectors()
	
	GP->LinearLink.ComputeUnitVector()
	
	GP->ComputeForceScale()
	
	GP->ComputeData()
	
	Return GP
	
End Function

Function GameType.CreateOrbit( ByVal Position       As Vec2, _
	                            ByVal Eccentricity   As Single, _
	                            ByVal SemiMajorAxis  As Single, _
	                            ByVal Periapsis      As Single, _
	                            ByVal MeanAnomaly    As Single, _
	                            ByVal OrbitDirection As Single, _
	                            ByVal linear1 As LinearStateType Ptr, _
	                            ByVal linear2 As LinearStateType Ptr  ) As OrbitType Ptr
	
	Dim As OrbitType O
	
	Dim As OrbitType Ptr OP = Orbits.push_back( O )
	
	OP->LinearLink.a = linear1
	OP->LinearLink.b = linear2
	
	OP->LinearLink.mass = OP->LinearLink.a->mass + OP->LinearLink.b->mass
	
	OP->LinearLink.ComputeInvMass()
	
	OP->LinearLink.ComputeReducedMass()
	
	OP->ApplyOrbit( Position, Eccentricity, SemiMajorAxis, Periapsis, MeanAnomaly, OrbitDirection )
	
	OP->LinearLink.ComputeStateVectors()
	
	OP->LinearLink.ComputeUnitVector()
	
	'OP->ComputeData()
	
	Return OP
	
End Function

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

Function GameType.CreatePlanet( ByVal _position As Vec2, _
	                             ByVal _angle    As Single, _
	                             ByVal _width    As Integer, _
	                             ByVal _size     As Integer, _ 
	                             ByVal _roxels   As Integer ) As RoxelBodyType Ptr
	
	Randomize()
	
	Dim As RoxelBodyType P
	
	Dim As RoxelBodyType Ptr PP = Roxelbodys.push_back( P )
	
	PP->Roxels.Reserve( _roxels )
	
	PP->position = _position
	PP->velocity = Vec2( 0.0, 0.0 )
	
	'Planet.Angular.direction = _angle
	'Planet.Angular.direction_Vector = Vec2( Cos( Planet.Angular.direction ) , Sin( Planet.Angular.direction ) )
	'Planet.AngularState.direction_Vector = Vec2( Cos( _angle ) , Sin( _angle ) )
	
	'PP->direction_Vector.RotateCCW( _angle )
	
	'PP->direction_matrix.makeRotation( _angle )
	
	For i As Integer = 0 To _roxels - 1
		
		Dim As RoxelType R
		
		Dim As RoxelType Ptr RP = PP->Roxels.push_back( R )
		
		RP->position = PP->position + Vec2().RandomizeCircle( 1.0 ) * Vec2( _width, _size )
		
		RP->Mass     = 1.0' + Rnd() * 90.0
		RP->inv_Mass = 1.0 / RP->Mass
		
		RP->Radius = ( ( RP->mass / C_DENSITY ) / (4/3) * PI ) ^ (1/3) 
		
		Dim As Integer scale = ( Rnd() - Rnd() ) 'i * 2 'Rnd() * 64
		
		RP->Colour = RGB( 128 + ( Rnd() - Rnd() ) * 32, _
		                  96  + scale * 32, _
		                  64  + scale * 32 )
		
	Next
	
	PP->computeData()
	
	PP->SetPosition( _position )
	
	Return PP
	
End Function


Function GameType.CreateShapeGirder( ByVal _position As Vec2, _
	                                  ByVal _angle    As Vec2, _
	                                  ByVal _size     As Vec2, _
	                                  ByVal _unit     As Vec2, _
	                                  ByVal _type     As integer ) As ShapeBodyType Ptr
	
	Dim As ShapeBodyType S
	
	Dim As ShapeBodyType Ptr SP = ShapeBodys.push_back( S )
	
	SP->LinearStates.Reserve( _size.x * _size.y + 100 )
	SP->FixedSprings.Reserve( _size.x * _size.y * 2 + 100 )
	
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
			
			CreateFixedSpring( 0.2, 1.0, 0.5, _
			                  SP->LinearStates[ x + y * _size.x ], _
			                  SP->LinearStates[ x + y * _size.x + 1 ], _
			                  @(SP->FixedSprings) )
			
		Next
	Next
	
	''  Transverse springs
	for y as integer = 0 to _size.y - 2
		For x as integer = 0 to _size.x - 1
			
			CreateFixedSpring( 0.2, 1.0, 0.5, _
			                   SP->LinearStates[ x ], _
			                   SP->LinearStates[ x + _size.x ], _
			                   @(SP->FixedSprings) )
						
		Next
	Next
	
	'''  Diagonal "S" springs
	'for y as integer = 0 to _size.y - 2
	'	For x as integer = 0 to _size.x - 2
	'		
	'		Dim As FixedSpringType F
	'		
	'		Dim As FixedSpringType Ptr FP = SP->FixedSprings.push_back( F )
	'		
	'		FP->LinearLink.a = SP->LinearStates[ x ]
	'		FP->LinearLink.b = SP->LinearStates[ x + _size.x + 1 ]
	'		
	'		FP->rest_distance = FP->LinearLink.b->position - FP->LinearLink.a->position
	'		
	'		FP->LinearLink.mass = FP->LinearLink.a->mass + FP->LinearLink.b->mass
	'			
	'		FP->LinearLink.inv_Mass = IIf( FP->LinearLink.mass > 0.0 , 1.0 / FP->LinearLink.mass, 0.0 )
	'			
	'		FP->LinearLink.reduced_mass = 1.0 / ( FP->LinearLink.a->inv_mass + FP->LinearLink.b->inv_mass )
	'		
	'		FP->ComputeData()
	'
	'	Next
	'Next
	'
	'''  Diagonal "Z" springs
	'for y as integer = 0 to _size.y - 2
	'	For x as integer = 1 to _size.x - 1
	'		
	'		Dim As FixedSpringType F
	'		
	'		Dim As FixedSpringType Ptr FP = SP->FixedSprings.push_back( F )
	'		
	'		FP->LinearLink.a = SP->LinearStates[ x ]
	'		FP->LinearLink.b = SP->LinearStates[ x + _size.x - 1 ]
	'		
	'		FP->rest_distance = FP->LinearLink.b->position - FP->LinearLink.a->position
	'		
	'		FP->LinearLink.mass = FP->LinearLink.a->mass + FP->LinearLink.b->mass
	'			
	'		FP->LinearLink.inv_Mass = IIf( FP->LinearLink.mass > 0.0 , 1.0 / FP->LinearLink.mass, 0.0 )
	'			
	'		FP->LinearLink.reduced_mass = 1.0 / ( FP->LinearLink.a->inv_mass + FP->LinearLink.b->inv_mass )
	'		
	'		FP->ComputeData()
	'
	'	Next
	'Next
	
	'' Diagonal "O" springs
	For y as integer = 0 to _size.y - 2
		For x as integer = 0 to _size.x - 2
			
			CreateFixedSpring( 0.2, 1.0, 0.5, _
			                   @( SP->FixedSprings[ x ]->LinearLink ), _
			                   @( SP->FixedSprings[ x + ( _size.x  - 1 ) * 2  ]->LinearLink ), _
			                   @(SP->FixedSprings) )
			
		Next
	Next
	
	For y as integer = 0 to _size.y - 2
		For x as integer = 0 to _size.x - 2		
			
			CreateFixedSpring( 0.2, 1.0, 0.5, _
			                   @(SP->FixedSprings[ x + ( _size.x  - 1 ) ]->LinearLink), _
			                   @(SP->FixedSprings[ x + ( _size.x  - 1 ) * 2  ]->LinearLink), _
			                   @(SP->FixedSprings) )
			
		Next
	Next
	
	For y as integer = 0 to _size.y - 2
		For x as integer = 0 to _size.x - 2
			
			CreateFixedSpring( 0.2, 1.0, 0.5, _
			                   @(SP->FixedSprings[ x ]->LinearLink), _
			                   @(SP->FixedSprings[ x + ( _size.x  - 1 ) * 2 + 1  ]->LinearLink), _
			                   @(SP->FixedSprings) )
			
		Next
	Next
	
	For y as integer = 0 to _size.y - 2
		For x as integer = 0 to _size.x - 2
			
			CreateFixedSpring( 0.2, 1.0, 0.5, _
			                   @(SP->FixedSprings[ x + ( _size.x  - 1 ) ]->LinearLink), _
			                   @(SP->FixedSprings[ x + ( _size.x  - 1 ) * 2 + 1  ]->LinearLink), _
			                   @(SP->FixedSprings) )
			
		Next
	Next
	
	SP->ComputeData()
	
	Return SP
	
End Function


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
	
	'''  Diagonal "S" springs
	'for y as integer = 0 to _size.y - 2
	'	For x as integer = 0 to _size.x - 2
	'		
	'		CreateLinearSpring( 0.2, 1.0, 0.5, _
	'		                   SP->LinearStates[ x ], _
	'		                   SP->LinearStates[ x + _size.x + 1 ], _
	'		                   @( SP->LinearSprings ) )
	'		
	'	Next
	'Next
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
