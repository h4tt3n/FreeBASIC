''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 4, July 2017
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''*******************************************************************************

Function GameType.CreateLinearState( ByVal _position As Vec2, _
	                                  ByVal _mass     As Single ) As LinearStateType Ptr
	
	Dim As LinearStateType L
	
	Dim As LinearStateType Ptr LP = LinearStates.push_back( L )
	
	Return LP
	
End Function
	
Function GameType.CreateRoxel( ByVal _position As Vec2, _
	                            ByVal _mass     As Single ) As RoxelType Ptr
	
	Dim As RoxelType R
	
	Dim As RoxelType Ptr RP = Roxels.push_back( R )
	
	Return RP
	
End Function
	
Function GameType.CreateGravity( ByVal _linear1 As LinearStateType Ptr, _
	                              ByVal _linear2 As LinearStateType Ptr ) As GravityType Ptr
	
	Dim As GravityType G
	
	Dim As GravityType Ptr GP = Gravitys.push_back( G )
	
	GP->LinearLink.a = _linear1
	GP->LinearLink.b = _linear2
	
	Return GP
	
End Function

Function GameType.CreateFixedSpring( ByVal _stiffness As Single, _
	                                  ByVal _damping   As Single, _
	                                  ByVal _warmstart As Single, _
	                                  ByVal _linear1   As LinearStateType Ptr, _
	                                  ByVal _linear2   As LinearStateType Ptr ) As FixedSpringType Ptr
	
	Dim As FixedSpringType F
	
	Dim As FixedSpringType Ptr FP' = FixedSprings.push_back( F )
	'
	'FP->LinearLink.a = _linear1
	'FP->LinearLink.b = _linear2
	'
	'FP->rest_distance = FP->LinearLink.b->position - FP->LinearLink.a->position

	'FP->LinearLink.mass = FP->LinearLink.a->mass + FP->LinearLink.b->mass
	'	
	'FP->LinearLink.inv_Mass = IIf( FP->LinearLink.mass > 0.0 , 1.0 / FP->LinearLink.mass, 0.0 )
	'	
	'FP->LinearLink.reduced_mass = 1.0 / ( FP->LinearLink.a->inv_mass + FP->LinearLink.b->inv_mass )
	
	Return FP
	
End Function

Function GameType.CreateLinearSpring( ByVal _stiffness  As Single, _
	                                   ByVal _damping    As Single, _
	                                   ByVal _warmstart  As Single, _
	                                   ByVal _linear1    As LinearStateType Ptr, _
	                                   ByVal _linear2    As LinearStateType Ptr ) As LinearSpringType Ptr
	
	Dim As LinearSpringType L
	
	Dim As LinearSpringType Ptr LP = LinearSprings.push_back( L )
	
	LP->LinearLink.a = _linear1
	LP->LinearLink.b = _linear2
	
	LP->rest_distance = ( LP->LinearLink.b->position - LP->LinearLink.a->position ).length()

	LP->LinearLink.mass = LP->LinearLink.a->mass + LP->LinearLink.b->mass
		
	LP->LinearLink.inv_Mass = IIf( LP->LinearLink.mass > 0.0 , 1.0 / LP->LinearLink.mass , 0.0 )
		
	LP->LinearLink.reduced_mass = 1.0 / ( LP->LinearLink.a->inv_mass + LP->LinearLink.b->inv_mass )
	
	Return LP
	
End Function
	
Sub GameType.CreateRope( ByVal _linear1    As LinearStateType Ptr, _
	                      ByVal _linear2    As LinearStateType Ptr, _
	                      ByVal _unitlength As Single )
	
	'If ( Not _linear1 = 0 And Not _linear2 = 0 ) Then 
		
		Dim As Integer first_linear = 0
		
		Dim As Vec2 Length_vector = _linear2->position - _linear1->position
		
		Dim As Vec2 Unit = Length_vector.Unit()
		
		Dim As Single Length = unit.dot( length_vector )
		
		Dim As Integer num_linearstates = Cast( Integer, Length / _unitlength )
		
		_unitlength = Length / num_linearstates
		
		Dim As Integer num_constraints = num_linearstates + 1
		
		Dim As Single mass = ( _linear1->mass + _linear2->mass ) * 0.5
		
		For i As Integer = 1 To num_linearstates - 1
			
			Dim As LinearStateType L
			
			Dim As LinearStateType Ptr LP = LinearStates.push_back( L )
			
			LP->Mass = mass'10.0
			LP->inv_mass = 1.0 / LP->Mass
			
			LP->Position = _linear1->position + Unit * _unitlength * i 
			
			If ( i = 0 ) Then first_linear = LinearStates.i_back
			
		Next
		
		''
		Dim As LinearSpringType S
		
		Dim As LinearSpringType Ptr SP = LinearSprings.push_back( S )
			
		SP->LinearLink.a = _linear1
		SP->LinearLink.b = LinearStates[ first_linear ]
		
		SP->rest_distance = ( SP->LinearLink.b->position - SP->LinearLink.a->position ).length()
	
		SP->LinearLink.mass = SP->LinearLink.a->mass + SP->LinearLink.b->mass
			
		SP->LinearLink.inv_Mass = IIf( SP->LinearLink.mass = 0.0 , 0.0 , 1.0 / SP->LinearLink.mass )
			
		SP->LinearLink.reduced_mass = 1.0 / ( SP->LinearLink.a->inv_mass + SP->LinearLink.b->inv_mass )
		
		For i As Integer = 0 To num_constraints - 4
			
			Dim As LinearSpringType S
		
			Dim As LinearSpringType Ptr SP = LinearSprings.push_back( S )
			
			SP->LinearLink.a = LinearStates[ first_linear + i ]
			SP->LinearLink.b = LinearStates[ first_linear + i + 1 ]
			
			SP->rest_distance = ( SP->LinearLink.b->position - SP->LinearLink.a->position ).length()
		
			SP->LinearLink.mass = SP->LinearLink.a->mass + SP->LinearLink.b->mass
				
			SP->LinearLink.inv_Mass = IIf( SP->LinearLink.mass = 0.0 , 0.0 , 1.0 / SP->LinearLink.mass )
				
			SP->LinearLink.reduced_mass = 1.0 / ( SP->LinearLink.a->inv_mass + SP->LinearLink.b->inv_mass )
			
		Next
		
		SP = LinearSprings.push_back( S )
		
		SP->LinearLink.a = LinearStates.P_back
		SP->LinearLink.b = _linear2
		
		SP->rest_distance = ( SP->LinearLink.b->position - SP->LinearLink.a->position ).length()
	
		SP->LinearLink.mass = SP->LinearLink.a->mass + SP->LinearLink.b->mass
			
		SP->LinearLink.inv_Mass = IIf( SP->LinearLink.mass = 0.0 , 0.0 , 1.0 / SP->LinearLink.mass )
			
		SP->LinearLink.reduced_mass = 1.0 / ( SP->LinearLink.a->inv_mass + SP->LinearLink.b->inv_mass )
		
	'EndIf
	
End Sub

Function GameType.CreatePlanet( ByVal _position As Vec2, _
	                             ByVal _angle    As Single, _
	                             ByVal _width    As Integer, _
	                             ByVal _size     As Integer, _ 
	                             ByVal _roxels   As Integer ) As RoxelBodyType Ptr
	
	Randomize()
	
	Dim As RoxelBodyType P
	
	Dim As RoxelBodyType Ptr PP = Roxelbodys.push_back( P )
	
	PP->Roxels.Reserve( _roxels )
	
	PP->LinearState.position = _position
	PP->LinearState.velocity = Vec2( 0.0, 0.0 )
	
	'Planet.Angular.direction = _angle
	'Planet.Angular.direction_Vector = Vec2( Cos( Planet.Angular.direction ) , Sin( Planet.Angular.direction ) )
	'Planet.AngularState.direction_Vector = Vec2( Cos( _angle ) , Sin( _angle ) )
	
	PP->AngularState.direction_matrix.makeRotation( _angle )
	
	For i As Integer = 0 To _roxels - 1
		
		Dim As RoxelType R
		
		Dim As RoxelType Ptr RP = PP->Roxels.push_back( R )
		
		RP->LinearState.position = PP->LinearState.position + Vec2().RandomizeCircle( 1.0 ) * Vec2( _width, _size )
		
		RP->LinearState.Mass     = 50.0' + Rnd() * 90.0
		RP->LinearState.inv_Mass = 1.0 / RP->LinearState.Mass
		
		RP->Radius = ( ( RP->LinearState.mass / C_DENSITY ) / (4/3) * PI ) ^ (1/3) 
		
		Dim As Integer scale = i * 2 'Rnd() * 64
		
		RP->Colour = RGB( 80 + scale, 64 + scale , 48 + scale )
		
	Next
	
	PP->computeData()
	
	Return PP
	
End Function


Function GameType.CreateGirder( ByVal _position As Vec2, _
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
			
			Dim As LinearStateType L
			
			Dim As LinearStateType Ptr LP = SP->LinearStates.push_back( L )
			
			LP->mass     = 1.0' + Rnd() * 9.0
			LP->inv_mass = 1.0 / LP->mass
			
		  	LP->position  = _position + Vec2( x * _unit.x, y * _unit.y ).RotateCCW( _angle ) '+ Vec2().randomizecircle( 5.0 )
		  	
		  	SP->LinearState.mass += LP->mass
		  	
		Next
	Next
	
	SP->LinearState.inv_mass = IIf( SP->LinearState.mass > 0.0 , 1.0 / SP->LinearState.mass , 0.0 )
	
	''  Longitudinal springs
	For y as integer = 0 to _size.y - 1
		For x as integer = 0 to _size.x - 2
			
			Dim As FixedSpringType F
			
			Dim As FixedSpringType Ptr FP = SP->FixedSprings.push_back( F )
			
			FP->LinearLink.a = SP->LinearStates[ x + y * _size.x     ]
			FP->LinearLink.b = SP->LinearStates[ x + y * _size.x + 1 ]
			
			FP->rest_distance = FP->LinearLink.b->position - FP->LinearLink.a->position
			
			FP->LinearLink.mass = FP->LinearLink.a->mass + FP->LinearLink.b->mass
				
			FP->LinearLink.inv_Mass = IIf( FP->LinearLink.mass > 0.0 , 1.0 / FP->LinearLink.mass, 0.0 )
				
			FP->LinearLink.reduced_mass = 1.0 / ( FP->LinearLink.a->inv_mass + FP->LinearLink.b->inv_mass )
			
		Next
	Next
	
	''  Transverse springs
	for y as integer = 0 to _size.y - 2
		For x as integer = 0 to _size.x - 1
			
			Dim As FixedSpringType F
			
			Dim As FixedSpringType Ptr FP = SP->FixedSprings.push_back( F )
			
			FP->LinearLink.a = SP->LinearStates[ x ]
			FP->LinearLink.b = SP->LinearStates[ x + _size.x ]
			
			FP->rest_distance = FP->LinearLink.b->position - FP->LinearLink.a->position
			
			FP->LinearLink.mass = FP->LinearLink.a->mass + FP->LinearLink.b->mass
				
			FP->LinearLink.inv_Mass = IIf( FP->LinearLink.mass > 0.0 , 1.0 / FP->LinearLink.mass, 0.0 )
				
			FP->LinearLink.reduced_mass = 1.0 / ( FP->LinearLink.a->inv_mass + FP->LinearLink.b->inv_mass )
			
		Next
	Next
	
	''  Diagonal "S" springs
	for y as integer = 0 to _size.y - 2
		For x as integer = 0 to _size.x - 2
			
			Dim As FixedSpringType F
			
			Dim As FixedSpringType Ptr FP = SP->FixedSprings.push_back( F )
			
			FP->LinearLink.a = SP->LinearStates[ x ]
			FP->LinearLink.b = SP->LinearStates[ x + _size.x + 1 ]
			
			FP->rest_distance = FP->LinearLink.b->position - FP->LinearLink.a->position
			
			FP->LinearLink.mass = FP->LinearLink.a->mass + FP->LinearLink.b->mass
				
			FP->LinearLink.inv_Mass = IIf( FP->LinearLink.mass > 0.0 , 1.0 / FP->LinearLink.mass, 0.0 )
				
			FP->LinearLink.reduced_mass = 1.0 / ( FP->LinearLink.a->inv_mass + FP->LinearLink.b->inv_mass )
			
		Next
	Next
	
	''  Diagonal "Z" springs
	for y as integer = 0 to _size.y - 2
		For x as integer = 1 to _size.x - 1
			
			Dim As FixedSpringType F
			
			Dim As FixedSpringType Ptr FP = SP->FixedSprings.push_back( F )
			
			FP->LinearLink.a = SP->LinearStates[ x ]
			FP->LinearLink.b = SP->LinearStates[ x + _size.x - 1 ]
			
			FP->rest_distance = FP->LinearLink.b->position - FP->LinearLink.a->position
			
			FP->LinearLink.mass = FP->LinearLink.a->mass + FP->LinearLink.b->mass
				
			FP->LinearLink.inv_Mass = IIf( FP->LinearLink.mass > 0.0 , 1.0 / FP->LinearLink.mass, 0.0 )
				
			FP->LinearLink.reduced_mass = 1.0 / ( FP->LinearLink.a->inv_mass + FP->LinearLink.b->inv_mass )
			
		Next
	Next
	
	SP->ComputeData()
	
	Return SP
	
End Function


'Sub GameType.CreateGirder( ByVal _position As Vec2, _
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
