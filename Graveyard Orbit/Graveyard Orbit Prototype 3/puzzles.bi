''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 3, April 2017
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  Controls:
''  
''  Puzzles                    :  F1 - F6
''  Double / halve iterations  :  1 - 9
''  Inc. / dec. iterations     :  I + up / down
''  Inc. / dec. stiffness      :  S + up / down
''  Inc. / dec. damping        :  D + up / down
''  Inc. / dec. warmstart      :  W + up / down
''  Warmstart on / off         :  Space bar
''  Exit demo                  :  Escape key
''  
''******************************************************************************* 


Sub GameType.Puzzle1()
	
	'' Wrecking ball
	
	iterations   = 10
	warmstart    = 1
	cStiffness   = 1.0    
	cDamping     = 1.0
	cWarmstart   = 0.5
	
	Dim As Integer num_Particles = 13
	Dim As Integer num_Springs   = 12
	Dim As Integer SpringLength  = 30 
	
	PuzzleText = "Demo 1: Wrecking ball. "
	
	ClearAllArrays()
	
	'' create particles
	Dim As LinearStateType R
		
	R.mass         = 1.0
	R.inverse_mass = 0
	R.position.x   = 0.5 * screen_wid
	R.position.y   = 0.25 * screen_hgt
	
	LinearStates.push_back( R )
	
	For i As integer = 2 To num_Particles
		
		Dim As LinearStateType R
		
		R.mass         = 1.0
		R.inverse_mass = 1.0 / R.mass
		
		If i = num_Particles Then
			
			R.mass         = 10.0
			R.inverse_mass = 1.0 / R.mass
			R.velocity.y   = 50
			
		EndIf
		
		R.position.x   = 0.5 * screen_wid + ( i - 1 ) * SpringLength
		R.position.y   = 0.25 * screen_hgt
		
		LinearStates.push_back( R )
		
	Next
	
	''  create springs
	For i As Integer = 0 To num_Springs-1
		
		Dim As LinearSpringType S
		
		S.LinearLink.a    = LinearStates[i]
		S.LinearLink.b    = LinearStates[i+1]
		S.rest_distance = (S.LinearLink.b->position - S.LinearLink.a->position).length()
		
		Dim As Single inverseMass = S.LinearLink.a->inverse_mass + S.LinearLink.b->inverse_mass
		
		S.LinearLink.reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
		
		LinearSprings.push_back( S )
		
	Next

End Sub

Sub GameType.Puzzle2()
	
	'' 
	
	iterations   = 10
	warmstart    = 0
	
	cStiffness   = 1.0 
	cDamping     = 1.0
	cWarmstart   = 0.0
	
	cAstiffness  = 0.01
	cAdamping    = 1.0
	cAwarmstart  = 0.0
	
	Dim As Integer num_Particles       = 128
	Dim As Integer num_Springs         = 127
	Dim As Integer num_angular_Springs = 126
	Dim As Integer SpringLength        = 100.0
	Dim As Single  Angle               = 0.0
	Dim As Single  delta_direction     = 0.5
	
	PuzzleText = ""
	
	ClearAllArrays()
	
	Randomize
	
	'' create particles
	Dim As LinearStateType R
	
	R.mass         = 1.0
	R.inverse_mass = 1.0
	R.position.x   = 0.5 * screen_wid
	R.position.y   = 0.5 * screen_hgt
	
	LinearStates.push_back(R)
	
	For i As integer = 1 To num_Particles - 1
		
		Dim As LinearStateType R
		
		R.mass = 1.0' + Rnd() * 9.0
		
		R.inverse_mass = 1.0 / R.mass
		
		R.position = 0.5 * Vec2( screen_wid, screen_hgt ) + Vec2( Cos(Angle), Sin(Angle) ) * SpringLength
		
		delta_direction -= 0.001
		Angle += delta_direction
		'SpringLength += 4
		
		LinearStates.push_back(R)
		
	Next
	
	'' create springs
	For i As Integer = 0 To num_Springs - 1
		
		Dim As LinearSpringType S
				
		S.LinearLink.a    = LinearStates[i]
		S.LinearLink.b    = LinearStates[i+1]
		S.rest_distance = ( S.LinearLink.b->position - S.LinearLink.a->position ).length()
		S.LinearLink.unit_vector = ( S.LinearLink.b->position - S.LinearLink.a->position ).unit()
		
		Dim As Single inverseMass = S.LinearLink.a->inverse_mass + S.LinearLink.b->inverse_mass
		
		S.LinearLink.reduced_mass = IIf( inverseMass > 0.0 , 1.0 / inverseMass , 0.0 )
		
		LinearSprings.push_back( S )
		
	Next
	
	'' create angular springs
	For i As Integer = 0 To num_angular_Springs-1 
		
		Dim As AngularConstraintType A
		
		A.AngularLink.a = @LinearSprings[ i ].AngularState
		A.AngularLink.b = @LinearSprings[i + 1].AngularState
		
		'A.rest_direction = Vec2( A.spring_a->unit.dot( A.spring_b->unit ), _
		'                         A.spring_a->unit.perpdot( A.spring_b->unit ) )
		
		A.rest_delta_direction = Vec2( Cos( 0.5 * 2 * PI ), Sin( 0.5 * 2 * PI ) )
		'
		AngularConstraints.push_back( A )
		
	Next
	
	'AngularConstraints.pop_back()
	
End Sub

Sub GameType.Puzzle3()
	
	'' Horizontal steel girder
	
	iterations   = 10
	warmstart    = 1
	cStiffness   = 1.0
	cDamping     = 1.0
	cWarmstart   = 1.0
	
	Dim As Integer GirderWidth  = 2
	Dim As Integer GirderLength = 32
	Dim As Integer SpringLength = 20
	
	PuzzleText = ""
	
	ClearAllArrays()
	
	CreateGirder( Vec2( 200.0, 200.0 ), _
	              Vec2( Cos( 0.0 * PI ), Sin( 0.0 * PI )), _
	              GirderWidth, _
	              GirderLength, _
	              SpringLength, _
	              S_TRUSS )
	
	CreateGirder( Vec2( 200.0, 400.0 ), _
	              Vec2( Cos( 0.2 * PI ), Sin( 0.2 * PI )), _
	              GirderWidth, _
	              GirderLength, _
	              SpringLength, _
	              Z_TRUSS )
	
	CreateGirder( Vec2( 200.0, 600.0 ), _
	              Vec2( Cos( 0.8 * PI ), Sin( 0.8 * PI )), _
	              GirderWidth, _
	              GirderLength, _
	              SpringLength, _
	              X_TRUSS )
	
End Sub

Sub GameType.Puzzle4()
	
	''
	
	iterations   = 10
	warmstart    = 0
	
	cStiffness   = 1.0   
	cDamping     = 1.0
	cWarmstart   = 0.5
	
	cAstiffness  = 0.2
	cAdamping    = 0.5
	cAwarmstart  = 0.5
	
	PuzzleText = "Gravitational interaction"
	
	ClearAllArrays()
	
	Dim As RigidBodyType Ptr PP1 = CreatePlanet( Vec2( 100, 100 ), 0.5, 40, 80,  8 )
	Dim As RigidBodyType Ptr PP2 = CreatePlanet( Vec2( 900, 400 ), 0.0, 40, 80, 16 )
	Dim As RigidBodyType Ptr PP3 = CreatePlanet( Vec2( 400, 800 ), 0.0, 40, 80, 24 )
	
	'Dim As RoxelType P1
	'
	'P1.LinearState.mass         = 40.0
	'P1.LinearState.inverse_mass = 1.0 / P1.LinearState.mass
	'P1.radius              = 10.0
	'P1.LinearState.position.x   = 200
	'P1.LinearState.position.y   = 200
	'
	'Dim As RoxelType Ptr PP1 = Roxels.push_back(P1)
	'
	'Dim As RoxelType P2
	'
	'P2.LinearState.mass         = 40.0
	'P2.LinearState.inverse_mass = 1.0 / P2.LinearState.mass
	'P2.radius       = 10.0
	'P2.LinearState.position.x   = 900
	'P2.LinearState.position.y   = 500
	'
	'Dim As RoxelType Ptr PP2 = Roxels.push_back(P2)
	'
	'Dim As RoxelType P3
	'
	'P3.LinearState.mass         = 40.0
	'P3.LinearState.inverse_mass = 1.0 / P3.LinearState.mass
	'P3.radius       = 10.0
	'P3.LinearState.position.x   = 300
	'P3.LinearState.position.y   = 700
	'
	'Dim As RoxelType Ptr PP3 = Roxels.push_back(P3)
	
	Dim as GravityType G1
	
	G1.LinearLink.a = @PP1->LinearState
	G1.LinearLink.b = @PP2->LinearState
	
	Gravitys.push_back( G1 )
	
	Dim as GravityType G2
	
	G2.LinearLink.a = @PP3->LinearState
	G2.LinearLink.b = @PP2->LinearState
	
	Gravitys.push_back( G2 )
	
	Dim as GravityType G3
	
	G3.LinearLink.a = @PP1->LinearState
	G3.LinearLink.b = @PP3->LinearState
	
	Gravitys.push_back( G3 )
	
End Sub

Sub GameType.Puzzle5()
	
	'' 
	
	iterations   = 10
	warmstart    = 0
	
	cStiffness   = 0.1 
	cDamping     = 0.1
	cWarmstart   = 0.1
	
	cAstiffness  = 0.0
	cAdamping    = 0.0
	cAwarmstart  = 0.0
	
	PuzzleText = ""
	
	ClearAllArrays()
	
	''
	Dim As RigidBodyType R
	
	R.LinearState.position = Vec2( 400.0, 400.0 )
	R.LinearState.velocity = Vec2( 0.0, 0.0 )
	
	'R.Angular.direction = 0.0
	'R.Angular.direction_Vector = Vec2( Cos( R.Angular.direction ) , Sin( R.Angular.direction ) )
	R.AngularState.direction_Vector = Vec2( Cos( 0.0 ) , Sin( 0.0 ) )
	'R.Angular.Velocity = 0.0
	
	'R.Linear.mass = 20.0
	'R.Linear.inverse_mass = 1.0 / R.Linear.mass
	
	'R.Angular.inertia = 8000
	'R.Angular.inverse_inertia = 1.0 / R.Angular.inertia
	
	''
	Dim As RoxelType P
	
	P.LinearState.position = R.LinearState.position + Vec2( 0.0, 200.0 )
	P.LinearState.mass = 10.0
	P.LinearState.inverse_mass = 1.0 / P.LinearState.mass
	P.radius = 10.0
	P.colour = RGB( 255, 0, 0 )
	
	R.Roxels.push_back( P )
	
	''
	P.LinearState.position = R.LinearState.position + Vec2( 0.0, -200.0 )
	P.LinearState.mass = 10.0
	P.LinearState.inverse_mass = 1.0 / P.LinearState.mass
	P.radius = 10.0
	P.colour = RGB( 0, 255, 0 )
	
	
	'R.angular.impulse = 0.1
	P.LinearState.impulse = Vec2( 10.0, 0.0 )
	'P.Linear.velocity = Vec2( 10.0, 0.0 )
	
	R.Roxels.push_back( P )
	
	R.computeData()
	
	Dim As rigidbodytype Ptr rbp = rigidbodys.push_Back( R )
	
	''
	Dim As RoxelType P1
	
	P1.LinearState.mass         = 40.0
	P1.LinearState.inverse_mass = 1.0 / P1.LinearState.mass
	P1.radius              = 10.0
	P1.LinearState.position.x   = 700
	P1.LinearState.position.y   = 550
	P1.LinearState.velocity.x   = 200
	
	Dim As RoxelType Ptr PP1 = Roxels.push_back(P1)
	
	
	''
	Dim As LinearSpringType S
	
	S.LinearLink.a = @RigidBodys[0]->Roxels[0]->LinearState
	S.LinearLink.b = @Roxels[0]->LinearState
	
	S.rest_distance = (S.LinearLink.b->position - S.LinearLink.a->position).length()
	
	Dim As Single inverseMass = S.LinearLink.a->inverse_mass + S.LinearLink.b->inverse_mass
	
	S.LinearLink.reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
	
	LinearSprings.push_back( S )
	
	''
	Dim As RoxelType P2
	
	P2.LinearState.mass         = 10.0
	P2.LinearState.inverse_mass = 0'1.0 / P2.Linear.mass
	P2.radius              = 10.0
	P2.LinearState.position.x   = 600
	P2.LinearState.position.y   = 450
	
	Dim As RoxelType Ptr PP2 = Roxels.push_back(P2)
	
	''
	S.LinearLink.a = @RigidBodys[0]->Roxels[1]->LinearState
	S.LinearLink.b = @Roxels[1]->LinearState
	
	S.rest_distance = (S.LinearLink.b->position - S.LinearLink.a->position).length()
	
	inverseMass = S.LinearLink.a->inverse_mass + S.LinearLink.b->inverse_mass
	
	S.LinearLink.reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
	
	LinearSprings.push_back( S )
	
End Sub

Sub GameType.Puzzle6()
	
	'' 
	
	iterations   = 10
	warmstart    = 1
	
	cStiffness   = 1.0  
	cDamping     = 1.0
	cWarmstart   = 1.0
	
	cAstiffness  = 0.0
	cAdamping    = 0.0
	cAwarmstart  = 0.0
	
	PuzzleText = ""
	
	ClearAllArrays()
	
	''
	CreatePlanet( Vec2( 200, 400 ), 0.0, 80, 160,  8 )
	CreatePlanet( Vec2( 400, 400 ), 0.0, 80, 160, 16 )
	CreatePlanet( Vec2( 600, 400 ), 0.0, 80, 160, 32 )
	CreatePlanet( Vec2( 800, 600 ), 0.0, 80, 160, 64 )
	
	'RigidBodys[0]->Roxels[0]->Linear.impulse = Vec2( 100.0,  0.0 )
	
	
	'RigidBodys[0]->Linear.impulse = Vec2( 0.0, -96.0 )
	'RigidBodys[1]->Linear.impulse = Vec2( 0.0,  48.0 )
	''
	RigidBodys[0]->AngularState.impulse = -80.0
	RigidBodys[1]->AngularState.impulse =  40.0
	RigidBodys[2]->AngularState.impulse = -20.0
	RigidBodys[3]->AngularState.impulse =  10.0
	'RigidBodys[1]->Angular.impulse = -0.1
	
	''
	'Dim as GravityType G
	'
	'G.Linear.a = @RigidBodys[0]->Linear
	'G.Linear.b = @RigidBodys[1]->Linear
	'
	'Gravitys.push_back( G )
	
	''
	'Dim As RoxelType P1
	'
	'P1.Linear.mass         = 1.0
	'P1.Linear.inverse_mass = 0'1.0 / P1.Linear.mass
	'P1.radius              = 10.0
	'P1.Linear.position.x   = 200
	'P1.Linear.position.y   = 400
	'
	'Dim As RoxelType Ptr PP1 = Roxels.push_back(P1)
	
	''
	Dim As LinearSpringType S
	
	S.LinearLink.a = @RigidBodys[0]->Roxels[0]->LinearState
	S.LinearLink.b = @RigidBodys[1]->LinearState
	
	S.rest_distance = (S.LinearLink.b->position - S.LinearLink.a->position).length()
	
	Dim As Single inverseMass = S.LinearLink.a->inverse_mass + S.LinearLink.b->inverse_mass
	
	S.LinearLink.reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
	
	LinearSprings.push_back( S )
	
	''
	S.LinearLink.a = @RigidBodys[1]->Roxels[1]->LinearState
	S.LinearLink.b = @RigidBodys[2]->LinearState
	
	S.rest_distance = (S.LinearLink.b->position - S.LinearLink.a->position).length()
	
	inverseMass = S.LinearLink.a->inverse_mass + S.LinearLink.b->inverse_mass
	
	S.LinearLink.reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
	
	LinearSprings.push_back( S )
	
	''
	S.LinearLink.a = @RigidBodys[2]->Roxels[2]->LinearState
	S.LinearLink.b = @RigidBodys[3]->LinearState
	
	S.rest_distance = (S.LinearLink.b->position - S.LinearLink.a->position).length()
	
	inverseMass = S.LinearLink.a->inverse_mass + S.LinearLink.b->inverse_mass
	
	S.LinearLink.reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
	
	LinearSprings.push_back( S )
	
	''
	S.LinearLink.a = @RigidBodys[3]->Roxels[3]->LinearState
	S.LinearLink.b = @RigidBodys[0]->LinearState
	
	S.rest_distance = (S.LinearLink.b->position - S.LinearLink.a->position).length()
	
	inverseMass = S.LinearLink.a->inverse_mass + S.LinearLink.b->inverse_mass
	
	S.LinearLink.reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
	
	LinearSprings.push_back( S )
	
End Sub

Sub GameType.Puzzle7()
	
	'' 
	
	iterations   = 10
	warmstart    = 1
	
	cStiffness   = 0.5   
	cDamping     = 0.5
	cWarmstart   = 0.5
	
	cAstiffness  = 0.2
	cAdamping    = 0.5
	cAwarmstart  = 0.5
	
	PuzzleText = ""
	
	ClearAllArrays()
	
	Dim As RoxelType P1
	
	P1.LinearState.mass         = 50.0
	P1.LinearState.inverse_mass = 1.0 / P1.LinearState.mass
	P1.radius              = 10.0
	P1.LinearState.position.x   = 200
	P1.LinearState.position.y   = 200
	
	Dim As RoxelType Ptr PP1 = Roxels.push_back(P1)
	
	Dim As RoxelType P2
	
	P2.LinearState.mass         = 50.0
	P2.LinearState.inverse_mass = 1.0 / P1.LinearState.mass
	P2.radius              = 10.0
	P2.LinearState.position.x   = 800
	P2.LinearState.position.y   = 600
	
	Dim As RoxelType Ptr PP2 = Roxels.push_back(P2)
	
	CreateRope( @PP1->LinearState , @PP2->LinearState, 25 )
	
End Sub

Sub GameType.Puzzle8()
	
	'' Wrecking ball
	
	iterations   = 10
	warmstart    = 1
	cStiffness   = 0.5
	cDamping     = 0.5
	cWarmstart   = 0.5
	
	PuzzleText = "Demo 8:"
	
	ClearAllArrays()
	
	'' create particles
	Dim As RoxelType R1
		
	R1.LinearState.mass         = 4.0
	R1.LinearState.inverse_mass = 1.0 / R1.LinearState.mass
	R1.LinearState.position.x   = 0.25 * screen_wid
	R1.LinearState.position.y   = 0.25 * screen_hgt
	
	R1.Radius = 16.0
	R1.Colour = RGB( 128, 128, 128 )
	
	Dim As RoxelType Ptr RP1 = Roxels.push_back( R1 )
	
	''
	Dim As RoxelType R2
		
	R2.LinearState.mass         = 8.0
	R2.LinearState.inverse_mass = 1.0 / R2.LinearState.mass
	R2.LinearState.position.x   = 0.75 * screen_wid
	R2.LinearState.position.y   = 0.25 * screen_hgt
	
	R2.Radius = 16.0
	R2.Colour = RGB( 128, 128, 128 )
	
	Dim As RoxelType Ptr RP2 = Roxels.push_back( R2 )
	
	''
	Dim As RoxelType R3
		
	R3.LinearState.mass         = 1.0
	R3.LinearState.inverse_mass = 1.0 / R3.LinearState.mass
	R3.LinearState.position.x   = 0.25 * screen_wid
	R3.LinearState.position.y   = 0.75 * screen_hgt
	
	R3.Radius = 16.0
	R3.Colour = RGB( 128, 128, 128 )
	
	Dim As RoxelType Ptr RP3 = Roxels.push_back( R3 )
	
	''
	Dim As RoxelType R4
		
	R4.LinearState.mass         = 2.0
	R4.LinearState.inverse_mass = 1.0 / R4.LinearState.mass
	R4.LinearState.position.x   = 0.75 * screen_wid
	R4.LinearState.position.y   = 0.75 * screen_hgt
	
	R4.Radius = 16.0
	R4.Colour = RGB( 128, 128, 128 )
	
	Dim As RoxelType Ptr RP4 = Roxels.push_back( R4 )
	
	'' create springs
	Dim As LinearSpringType S1
	
	S1.LinearLink.a = @(RP1->LinearState)
	S1.LinearLink.b = @(RP3->LinearState)
	
	S1.rest_distance = ( S1.LinearLink.b->position - S1.LinearLink.a->position).length()
	
	S1.LinearLink.mass = S1.LinearLink.a->mass + S1.LinearLink.b->mass
	S1.LinearLink.inverse_Mass = S1.LinearLink.a->inverse_mass + S1.LinearLink.b->inverse_mass
	
	S1.LinearLink.reduced_mass = IIf( S1.LinearLink.inverse_Mass = 0.0 , 0.0 , 1.0 / S1.LinearLink.inverse_Mass )
	
	S1.LinearLink.Position = ( S1.LinearLink.a->position * S1.LinearLink.a->mass + _
	                           S1.LinearLink.b->position * S1.LinearLink.b->mass ) / _
	                           ( S1.LinearLink.a->mass + S1.LinearLink.b->mass )
	
	Dim As LinearSpringType Ptr LL1 = LinearSprings.push_back( S1 )
	
	''
	Dim As LinearSpringType S2
	
	S2.LinearLink.a = @(RP2->LinearState)
	S2.LinearLink.b = @(RP4->LinearState)
	
	S2.rest_distance = ( S2.LinearLink.b->position - S2.LinearLink.a->position).length()
	
	S2.LinearLink.mass = S2.LinearLink.a->mass + S2.LinearLink.b->mass
	S2.LinearLink.inverse_Mass = S2.LinearLink.a->inverse_mass + S2.LinearLink.b->inverse_mass
	
	S2.LinearLink.reduced_mass = IIf( S2.LinearLink.inverse_Mass = 0.0 , 0.0 , 1.0 / S2.LinearLink.inverse_Mass )
	
	S2.LinearLink.Position = ( S2.LinearLink.a->position * S2.LinearLink.a->mass + _
	                           S2.LinearLink.b->position * S2.LinearLink.b->mass ) / _
	                           ( S2.LinearLink.a->mass + S2.LinearLink.b->mass )
	
	Dim As LinearSpringType Ptr LL2 = LinearSprings.push_back( S2 )
	
	''
	Dim As LinearSpringType S3
	
	S3.LinearLink.a    = @(LL1->LinearLink)
	S3.LinearLink.b    = @(LL2->LinearLink)
	
	S3.rest_distance = ( S3.LinearLink.b->position - S3.LinearLink.a->position).length()
	
	S3.LinearLink.mass = S3.LinearLink.a->mass + S3.LinearLink.b->mass
	S3.LinearLink.inverse_Mass = S3.LinearLink.a->inverse_mass + S3.LinearLink.b->inverse_mass
	
	S3.LinearLink.reduced_mass = IIf( S3.LinearLink.inverse_Mass = 0.0 , 0.0 , 1.0 / S3.LinearLink.inverse_Mass )
	
	S3.LinearLink.Position = ( S3.LinearLink.a->position * S3.LinearLink.a->mass + _
	                           S3.LinearLink.b->position * S3.LinearLink.b->mass ) / _
	                           ( S3.LinearLink.a->mass + S3.LinearLink.b->mass )
	
	Dim As LinearSpringType Ptr LL3 = LinearSprings.push_back( S3 )
	
	
	RP1->LinearState.AddImpulse( Vec2(  10.0, 0.0 ) )
	RP3->LinearState.AddImpulse( Vec2( -40.0, 0.0 ) )
	
	RP2->LinearState.AddImpulse( Vec2( -40.0, 0.0 ) )
	RP4->LinearState.AddImpulse( Vec2( 160.0, 0.0 ) )
	
	LL1->LinearLink.AddImpulse( Vec2( 0.0,  40.0 ) )
	LL2->LinearLink.AddImpulse( Vec2( 0.0, -20.0 ) )
	'LL3->LinearLink.AddImpulse( Vec2( 0.0, -10.0 ) )
	
End Sub

