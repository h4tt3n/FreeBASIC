''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 3, April 2017
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''******************************************************************************* 

Function GameType.CreateRocket( ByVal _position As Vec2 ) As RocketType Ptr
	
	
	Return 0
	
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
		
		For i As Integer = 1 To num_linearstates - 1
			
			Dim As LinearStateType L
			
			L.Mass = 10.0
			L.inverse_mass = 1.0 / L.Mass
			
			L.Position = _linear1->position + Unit * _unitlength * i 
			
			LinearStates.push_back( L )
			
			If ( i = 0 ) Then first_linear = LinearStates.i_back
			
		Next
		
		''
		Dim As LinearSpringType L
			
		L.LinearLink.a = _linear1
		L.LinearLink.b = LinearStates[ first_linear ]
		
		L.rest_distance = (L.LinearLink.b->position - L.LinearLink.a->position).length()
		Dim As Single inverseMass = L.LinearLink.a->inverse_mass + L.LinearLink.b->inverse_mass
		L.LinearLink.reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
		
		LinearSprings.push_back( L )
		
		For i As Integer = 0 To num_constraints - 4
			
			Dim As LinearSpringType L
			
			L.LinearLink.a = LinearStates[ first_linear + i ]
			L.LinearLink.b = LinearStates[ first_linear + i + 1 ]
			
			L.rest_distance = (L.LinearLink.b->position - L.LinearLink.a->position).length()
			Dim As Single inverseMass = L.LinearLink.a->inverse_mass + L.LinearLink.b->inverse_mass
			L.LinearLink.reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
			
			LinearSprings.push_back( L )
			
		Next
		
		L.LinearLink.a = LinearStates.P_back
		L.LinearLink.b = _linear2
		
		L.rest_distance = (L.LinearLink.b->position - L.LinearLink.a->position).length()
		inverseMass = L.LinearLink.a->inverse_mass + L.LinearLink.b->inverse_mass
		L.LinearLink.reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
			
		LinearSprings.push_back( L )
		
	'EndIf
	
End Sub

Function GameType.CreatePlanet( ByVal _position As Vec2, _
	                             ByVal _angle    As Single, _
	                             ByVal _width    As Integer, _
	                             ByVal _length   As Integer, _ 
	                             ByVal _roxels   As Integer ) As RigidBodyType Ptr
	
	Randomize( Timer )
	
	Dim As RigidBodyType Planet
	
	Planet.LinearState.position = _position
	Planet.LinearState.velocity = Vec2( 0.0, 0.0 )
	
	'Planet.Angular.direction = _angle
	'Planet.Angular.direction_Vector = Vec2( Cos( Planet.Angular.direction ) , Sin( Planet.Angular.direction ) )
	Planet.AngularState.direction_Vector = Vec2( Cos( _angle ) , Sin( _angle ) )
	
	For i As Integer = 0 To _roxels - 1
		
		Dim As RoxelType R
		
		R.LinearState.position = Planet.LinearState.position + Vec2().RandomizeCircle( 1.0 ) * Vec2( _width, _length )
		
		R.LinearState.Mass = 10.0 '10.0 + Rnd( 90.0 )
		R.LinearState.inverse_Mass = 1.0 / R.LinearState.Mass
		
		R.Radius = 10 + _roxels - i
		
		Dim As Integer scale = i * 2 'Rnd() * 64
		
		R.Colour = RGB( 80 + scale, 64 + scale , 48 + scale )
		
		Planet.Roxels.push_back( R )
		
	Next
	
	Planet.computeData()
	
	Return RigidBodys.push_back( Planet )
	
End Function


Sub GameType.CreateGirder( ByVal _position As Vec2, _
	                        ByVal _angle    As Vec2, _
	                        ByVal _width    As Integer, _
	                        ByVal _length   As Integer, _
	                        ByVal _unit     As Integer, _
	                        ByVal _type     As integer )
	
	'' Type 0 - Pratt truss  - SSSS
	'' Type 1 - Howe truss   - ZZZZ
	'' Type 2 - Warren truss - VVVV
	'' Type 3 - Brown truss  - XXXX
	'' Type 4 - K-truss      - KKKK
	'' Type 5 - O-truss      - OOOO
	'' Type 6 - W-truss      - WWWW
	
	Dim As Integer first_linear = 0
	Dim As Single  inverseMass  = 0
	
	''	particles
	for i as integer = 0 to _length - 1
		for j as integer = 0 to _width - 1
			
			Dim As LinearStateType R
			
			R.mass         = 1.0
			R.inverse_mass = 1.0 / R.mass
			
		  	R.position  = _position + Vec2( (i-1), (j-1) ).RotateCCW( _angle ) * _unit 
		  	
		  	LinearStates.push_back( R )
		  	
		  	If ( i = 0 And j = 0 ) Then first_linear = LinearStates.i_back
		  	
		Next
	Next
	
	''  Longitudinal springs, "===="
	for i as integer = 0 to _width - 1
		For j as integer = 0 to _length - 2
			
			Dim As LinearSpringType S 
			
			S.LinearLink.a = LinearStates[ first_linear + i          + j * _width ]
			S.LinearLink.b = LinearStates[ first_linear + i + _width + j * _width ]
			
			S.rest_distance = ( S.LinearLink.b->position - S.LinearLink.a->position ).Length()
			Dim As Single inverseMass     = S.LinearLink.a->inverse_mass + S.LinearLink.b->inverse_mass
			S.LinearLink.reduced_mass  = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
			
			LinearSprings.push_back( S )
			
		Next
	Next
	
	''  Transverse springs, "||||"
	for i as integer = 0 to _length - 1
		For j as integer = 0 to _width - 2
			
			Dim As LinearSpringType S 
			
			S.LinearLink.a = LinearStates[ first_linear + i * _width + j     ]
			S.LinearLink.b = LinearStates[ first_linear + i * _width + j + 1 ]
			
			S.rest_distance = ( S.LinearLink.b->position - S.LinearLink.a->position ).Length()
			Dim As Single inverseMass     = S.LinearLink.a->inverse_mass + S.LinearLink.b->inverse_mass
			S.LinearLink.reduced_mass  = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
			
			LinearSprings.push_back( S )
			
		Next
	Next
	
	''  diagonal springs, "ZZZZ"
	If ( _type = 0 Or _type = 3 ) Then
		
		for i as integer = 0 to _width - 2
			For j as integer = 0 to _length - 2' Step 2
				
				Dim As LinearSpringType S 
				
				S.LinearLink.a = LinearStates[ first_linear +   i + j   * _width         ]
				S.LinearLink.b = LinearStates[ first_linear + ( j + 1 ) * _width + i + 1 ]
				
				S.rest_distance = ( S.LinearLink.b->position - S.LinearLink.a->position ).Length()
				Dim As Single inverseMass     = S.LinearLink.a->inverse_mass + S.LinearLink.b->inverse_mass
				S.LinearLink.reduced_mass  = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
				
				LinearSprings.push_back( S )
				
			Next
		Next
	
	EndIf
	
	''  diagonal springs, "SSSS"
	If ( _type = 1 Or _type = 3 ) Then
		
		For i as integer = 0 to _width - 2
			For j as integer = 0 to _length - 2' Step 2
				
				Dim As LinearSpringType S 
				
				S.LinearLink.a = LinearStates[ first_linear + ( j + 1 ) *_width + i     ]
				S.LinearLink.b = LinearStates[ first_linear +   j       *_width + i + 1 ]
				
				S.rest_distance = ( S.LinearLink.b->position - S.LinearLink.a->position ).Length()
				Dim As Single inverseMass     = S.LinearLink.a->inverse_mass + S.LinearLink.b->inverse_mass
				S.LinearLink.reduced_mass  = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
				
				LinearSprings.push_back( S )
				
			Next
		Next
	
	EndIf
	
End Sub