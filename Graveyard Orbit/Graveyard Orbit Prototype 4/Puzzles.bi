''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 4, July 201717
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
	
	iterations   = 4
	warmstart    = 1
	cStiffness   = 0.2    
	cDamping     = 1.0
	cWarmstart   = 0.5
	
	Dim As Integer num_Particles = 13
	Dim As Integer num_Springs   = 12
	Dim As Integer SpringLength  = 30 
	
	PuzzleText = "Demo 1: Wrecking ball. "
	
	ClearAllArrays()
	
	'' create particles
	Dim As LinearStateType L
		
	L.mass       = 1.0
	L.inv_mass   = 0
	L.position.x = 0.5 * screen_wid
	L.position.y = 0.25 * screen_hgt
	
	LinearStates.push_back( L )
	
	For i As integer = 2 To num_Particles - 1
		
		Dim As LinearStateType L
		
		L.mass         = 1.0
		L.inv_mass = 1.0 / L.mass
		
		L.position.x   = 0.5 * screen_wid + ( i - 1 ) * SpringLength
		L.position.y   = 0.25 * screen_hgt
		
		LinearStates.push_back( L )
		
	Next
	
	Dim As RoxelType R
		
	R.LinearState.mass         = 1000.0
	R.LinearState.inv_mass = 1.0 / R.LinearState.mass
	R.radius                   = 20.0
	R.LinearState.position.x   = 0.5 * screen_wid + ( num_Particles - 1 ) * SpringLength
	R.LinearState.position.y   = 0.25 * screen_hgt
	
	Roxels.push_back( R )
	
	''  create springs
	For i As Integer = 0 To num_Springs-2
		
		Dim As LinearSpringType S
		
		S.LinearLink.a    = LinearStates[i]
		S.LinearLink.b    = LinearStates[i+1]
		
		S.rest_distance = (S.LinearLink.b->position - S.LinearLink.a->position).length()
		
		S.LinearLink.mass = S.LinearLink.a->mass + S.LinearLink.b->mass
		
		S.LinearLink.inv_Mass = IIf( S.LinearLink.mass = 0.0 , 0.0 , 1.0 / S.LinearLink.mass )
		
		S.LinearLink.reduced_mass = 1.0 / ( S.LinearLink.a->inv_mass + S.LinearLink.b->inv_mass )
		
		LinearSprings.push_back( S )
		
	Next
	
	Dim As LinearSpringType S
	
	S.LinearLink.a    = LinearStates[num_Springs-1]
	S.LinearLink.b    = @Roxels[0]->LinearState
	S.rest_distance = (S.LinearLink.b->position - S.LinearLink.a->position).length()
	
	S.LinearLink.mass = S.LinearLink.a->mass + S.LinearLink.b->mass
		
	S.LinearLink.inv_Mass = IIf( S.LinearLink.mass = 0.0 , 0.0 , 1.0 / S.LinearLink.mass )
		
	S.LinearLink.reduced_mass = 1.0 / ( S.LinearLink.a->inv_mass + S.LinearLink.b->inv_mass )
	
	LinearSprings.push_back( S )

End Sub

Sub GameType.Puzzle2()
	
	'' 
	
	iterations = 4
	warmstart    = 1
	
	cStiffness   = 0.2 
	cDamping     = 1.0
	cWarmstart   = 0.5
	
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
	R.inv_mass = 1.0
	R.position.x   = 0.5 * screen_wid
	R.position.y   = 0.5 * screen_hgt
	
	LinearStates.push_back(R)
	
	For i As integer = 1 To num_Particles - 1
		
		Dim As LinearStateType R
		
		R.mass = 1.0' + Rnd() * 9.0
		
		R.inv_mass = 1.0 / R.mass
		
		R.position = 0.5 * Vec2( screen_wid, screen_hgt ) + Vec2( Cos(Angle), Sin(Angle) ) * SpringLength
		
		'delta_direction -= 0.001
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
		
		'Dim As Single invMass = S.LinearLink.a->inv_mass + S.LinearLink.b->inv_mass
		'S.LinearLink.reduced_mass = IIf( invMass > 0.0 , 1.0 / invMass , 0.0 )
		
		S.LinearLink.mass = S.LinearLink.a->mass + S.LinearLink.b->mass
			
		S.LinearLink.inv_Mass = IIf( S.LinearLink.mass = 0.0 , 0.0 , 1.0 / S.LinearLink.mass )
			
		S.LinearLink.reduced_mass = 1.0 / ( S.LinearLink.a->inv_mass + S.LinearLink.b->inv_mass )
		
		LinearSprings.push_back( S )
		
	Next
	
	
End Sub

Sub GameType.Puzzle3()
	
	''
	
	iterations = 4
	warmstart    = 1
	cStiffness   = 1.0
	cDamping     = 1.0
	cWarmstart   = 1.0
	
	Dim As Integer GirderWidth  = 2
	Dim As Integer GirderLength = 16
	Dim As Integer SpringLength = 24
	
	PuzzleText = ""
	
	ClearAllArrays()
	
	Dim As ShapeBodyType Ptr G1 = CreateGirder( Vec2( 200.0, 400.0 ), _
	                                            Vec2( Cos( 0.0 * TWO_PI ), Sin( 0.0 * TWO_PI )), _
	                                            Vec2( GirderLength, GirderWidth ), _
	                                            Vec2( SpringLength, SpringLength ), _
	                                            V_TRUSS )
	
	Dim As ShapeBodyType Ptr G2 = CreateGirder( Vec2( 200.0, 400.0 ), _
	                                            Vec2( Cos( 0.0 * TWO_PI ), Sin( 0.0 * TWO_PI )), _
	                                            Vec2( GirderLength, GirderWidth ), _
	                                            Vec2( SpringLength, SpringLength ), _
	                                            K_TRUSS )
	
	Dim As ShapeBodyType Ptr G3 = CreateGirder( Vec2( 200.0, 400.0 ), _
	                                            Vec2( Cos( 0.0 * TWO_PI ), Sin( 0.0 * TWO_PI )), _
	                                            Vec2( GirderLength, GirderWidth ), _
	                                            Vec2( SpringLength, SpringLength ), _
	                                            X_TRUSS )
	
	Dim As ShapeBodyType Ptr G4 = CreateGirder( Vec2( 200.0, 400.0 ), _
	                                            Vec2( Cos( 0.0 * TWO_PI ), Sin( 0.0 * TWO_PI )), _
	                                            Vec2( GirderLength, GirderWidth ), _
	                                            Vec2( SpringLength, SpringLength ), _
	                                            X_TRUSS )
	                                            
	'CreateRope( G3->LinearStates.p_front, G4->LinearStates.p_back, 24 )
	'CreateRope( G2->LinearStates.p_front, G3->LinearStates.p_back, 24 )
	'CreateRope( G3->LinearStates.p_front, G1->LinearStates.p_back, 24 )

	
	'G2->LinearState.Addimpulse( Vec2( -100.0, 0.0 ) )
	G1->AngularState.impulse = -0.001
	G2->AngularState.impulse =  0.5
	G3->AngularState.impulse = -0.5
	G4->AngularState.impulse = -1.0
	
	CreateLinearSpring( 0.2, 1.0, 0.5, G3->LinearStates.p_front + 8, G2->LinearStates.p_back)
	
End Sub

Sub GameType.Puzzle4()
	
	''
	
	iterations  = 4
	warmstart   = 1
	
	cStiffness  = 1.0   
	cDamping    = 1.0
	cWarmstart  = 1.0
	
	cAstiffness = 0.2
	cAdamping   = 0.5
	cAwarmstart = 0.5
	
	PuzzleText = "Gravitational interaction"
	
	ClearAllArrays()
	
	Dim As RoxelBodyType Ptr PP1 = CreatePlanet( Vec2( 500, 200 ), 0.5, 40, 160, 32 )
	Dim As RoxelBodyType Ptr PP2 = CreatePlanet( Vec2( 500, 600 ), 0.0, 40, 320, 64 )
	
	PP1->ComputeData()
	PP2->ComputeData()
	
	'Dim As RoxelBodyType Ptr PP3 = CreatePlanet( Vec2( 400, 800 ), 0.0, 40, 80, 24 )
	
	''
	'Dim As LinearSpringType S
	'
	'S.LinearLink.a = @Roxelbodys[0]->Roxels[1]->LinearState
	'S.LinearLink.b = @Roxelbodys[1]->Roxels[1]->LinearState
	'
	'S.rest_distance = (S.LinearLink.b->position - S.LinearLink.a->position).length()
	'
	'S.LinearLink.mass = S.LinearLink.a->mass + S.LinearLink.b->mass
	'	
	'S.LinearLink.inv_Mass = IIf( S.LinearLink.mass = 0.0 , 0.0 , 1.0 / S.LinearLink.mass )
	'	
	'S.LinearLink.reduced_mass = 1.0 / ( S.LinearLink.a->inv_mass + S.LinearLink.b->inv_mass )

	'LinearSprings.push_back( S )
	
	'CreateRope( @Roxelbodys[0]->Roxels[1]->LinearState, @Roxelbodys[1]->Roxels[1]->LinearState, 32 )
	
	
	
	'PP1->LinearState.Addimpulse( Vec2(  200.0, 0.0 ) )
	'PP2->LinearState.Addimpulse( Vec2( -100.0, 0.0 ) )
	
	PP1->AngularState.Impulse +=  0.1
	PP2->AngularState.Impulse += -0.1
	
	''
	Dim as GravityType G1
	
	G1.LinearLink.a = @PP1->LinearState
	G1.LinearLink.b = @PP2->LinearState
	
	G1.LinearLink.mass = G1.LinearLink.a->mass + G1.LinearLink.b->mass		
	G1.LinearLink.inv_Mass = IIf( G1.LinearLink.mass > 0.0 , 1.0 / G1.LinearLink.mass, 0.0 )
	
	G1.ComputeForceScale()
	
	Gravitys.push_back( G1 )
	
	'''
	'Dim as GravityType G2
	'
	'G2.LinearLink.a = @PP3->LinearState
	'G2.LinearLink.b = @PP2->LinearState
	'
	'Gravitys.push_back( G2 )
	'
	'''
	'Dim as GravityType G3
	'
	'G3.LinearLink.a = @PP1->LinearState
	'G3.LinearLink.b = @PP3->LinearState
	'
	'Gravitys.push_back( G3 )
	
End Sub

Sub GameType.Puzzle5()
	
	'' 
	
	iterations   = 4
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
	Dim As RoxelBodyType R
	
	R.LinearState.position = Vec2( 400.0, 400.0 )
	R.LinearState.velocity = Vec2( 0.0, 0.0 )
	
	'R.Angular.direction = 0.0
	'R.Angular.direction_Vector = Vec2( Cos( R.Angular.direction ) , Sin( R.Angular.direction ) )
	'R.AngularState.direction_Vector = Vec2( Cos( 0.0 ) , Sin( 0.0 ) )
	
	R.AngularState.direction_matrix.MakeIdentity()
	
	'R.Angular.Velocity = 0.0
	
	'R.Linear.mass = 20.0
	'R.Linear.inv_mass = 1.0 / R.Linear.mass
	
	'R.Angular.inertia = 8000
	'R.Angular.inv_inertia = 1.0 / R.Angular.inertia
	
	''
	Dim As RoxelType P
	
	P.LinearState.position = R.LinearState.position + Vec2( 0.0, 100.0 )
	P.LinearState.mass = 10.0
	P.LinearState.inv_mass = 1.0 / P.LinearState.mass
	P.radius = 10.0
	P.colour = RGB( 255, 0, 0 )
	
	R.Roxels.push_back( P )
	
	''
	P.LinearState.position = R.LinearState.position + Vec2( 0.0, -100.0 )
	P.LinearState.mass = 10.0
	P.LinearState.inv_mass = 1.0 / P.LinearState.mass
	P.radius = 10.0
	P.colour = RGB( 0, 255, 0 )
	
	R.Roxels.push_back( P )
	
	''
	P.LinearState.position = R.LinearState.position + Vec2( 100.0, 0.0 )
	P.LinearState.mass = 10.0
	P.LinearState.inv_mass = 1.0 / P.LinearState.mass
	P.radius = 10.0
	P.colour = RGB( 0, 0, 255 )
	
	
	'R.angular.impulse = 0.1
	'P.LinearState.impulse = Vec2( 10.0, 0.0 )
	'P.Linear.velocity = Vec2( 10.0, 0.0 )
	
	R.Roxels.push_back( P )
	
	R.computeData()
	
	Dim As RoxelBodyType Ptr rbp = Roxelbodys.push_Back( R )
	
	''
	Dim As RoxelType P1
	
	P1.LinearState.mass         = 1000.0
	P1.LinearState.inv_mass = 1.0 / P1.LinearState.mass
	P1.radius                   = 30.0
	P1.LinearState.position.x   = 700
	P1.LinearState.position.y   = 550
	'P1.LinearState.velocity.x   = 200
	
	Dim As RoxelType Ptr PP1 = Roxels.push_back(P1)
	
	
	''
	Dim As LinearSpringType S
	
	S.LinearLink.a = @Roxelbodys[0]->Roxels[0]->LinearState
	S.LinearLink.b = @Roxels[0]->LinearState
	
	S.rest_distance = (S.LinearLink.b->position - S.LinearLink.a->position).length()
	
	S.LinearLink.mass = S.LinearLink.a->mass + S.LinearLink.b->mass
		
	S.LinearLink.inv_Mass = IIf( S.LinearLink.mass = 0.0 , 0.0 , 1.0 / S.LinearLink.mass )
		
	S.LinearLink.reduced_mass = 1.0 / ( S.LinearLink.a->inv_mass + S.LinearLink.b->inv_mass )
	
	LinearSprings.push_back( S )
	
	''
	Dim As RoxelType P2
	
	P2.LinearState.mass         = 10.0
	P2.LinearState.inv_mass = 0'1.0 / P2.Linear.mass
	P2.radius                   = 10.0
	P2.LinearState.position.x   = 600
	P2.LinearState.position.y   = 450
	
	Dim As RoxelType Ptr PP2 = Roxels.push_back(P2)
	
	''
	S.LinearLink.a = @Roxelbodys[0]->Roxels[1]->LinearState
	S.LinearLink.b = @Roxels[1]->LinearState
	
	S.rest_distance = (S.LinearLink.b->position - S.LinearLink.a->position).length()
	
	S.LinearLink.mass = S.LinearLink.a->mass + S.LinearLink.b->mass
		
	S.LinearLink.inv_Mass = IIf( S.LinearLink.mass = 0.0 , 0.0 , 1.0 / S.LinearLink.mass )
		
	S.LinearLink.reduced_mass = 1.0 / ( S.LinearLink.a->inv_mass + S.LinearLink.b->inv_mass )
	
	LinearSprings.push_back( S )
	
End Sub

Sub GameType.Puzzle6()
	
	'' 
	
	iterations   = 4
	warmstart    = 1
	
	cStiffness   = 0.25  
	cDamping     = 1.0
	cWarmstart   = 0.5
	
	cAstiffness  = 0.0
	cAdamping    = 0.0
	cAwarmstart  = 0.0
	
	PuzzleText   = ""
	
	ClearAllArrays()
	
	''
	CreatePlanet( Vec2( 200, 400 ), 0.0, 80, 160,  8 )
	CreatePlanet( Vec2( 400, 400 ), 0.0, 80, 160, 16 )
	CreatePlanet( Vec2( 600, 400 ), 0.0, 80, 160, 32 )
	CreatePlanet( Vec2( 800, 600 ), 0.0, 80, 160, 64 )
	
	'Roxelbodys[0]->Roxels[0]->Linear.impulse = Vec2( 100.0,  0.0 )
	
	
	'Roxelbodys[0]->Linear.impulse = Vec2( 0.0, -96.0 )
	'Roxelbodys[1]->Linear.impulse = Vec2( 0.0,  48.0 )
	''
	Roxelbodys[0]->AngularState.velocity = -80.0
	Roxelbodys[1]->AngularState.velocity =  40.0
	Roxelbodys[2]->AngularState.velocity = -20.0
	Roxelbodys[3]->AngularState.velocity =  10.0
	'Roxelbodys[1]->Angular.impulse = -0.1
	
	Roxelbodys[0]->AngularState.velocity_matrix.makeRotation(Roxelbodys[0]->AngularState.velocity * DT)
	Roxelbodys[1]->AngularState.velocity_matrix.makeRotation(Roxelbodys[1]->AngularState.velocity * DT)
	Roxelbodys[2]->AngularState.velocity_matrix.makeRotation(Roxelbodys[2]->AngularState.velocity * DT)
	Roxelbodys[3]->AngularState.velocity_matrix.makeRotation(Roxelbodys[3]->AngularState.velocity * DT)
	
	''
	'Dim as GravityType G
	'
	'G.Linear.a = @Roxelbodys[0]->Linear
	'G.Linear.b = @Roxelbodys[1]->Linear
	'
	'Gravitys.push_back( G )
	
	''
	'Dim As RoxelType P1
	'
	'P1.Linear.mass         = 1.0
	'P1.Linear.inv_mass = 0'1.0 / P1.Linear.mass
	'P1.radius              = 10.0
	'P1.Linear.position.x   = 200
	'P1.Linear.position.y   = 400
	'
	'Dim As RoxelType Ptr PP1 = Roxels.push_back(P1)
	
	''
	Dim As LinearSpringType S
	
	S.LinearLink.a = @Roxelbodys[0]->Roxels[0]->LinearState
	S.LinearLink.b = @Roxelbodys[1]->LinearState
	
	S.rest_distance = (S.LinearLink.b->position - S.LinearLink.a->position).length()
	
	S.LinearLink.mass = S.LinearLink.a->mass + S.LinearLink.b->mass
		
	S.LinearLink.inv_Mass = IIf( S.LinearLink.mass = 0.0 , 0.0 , 1.0 / S.LinearLink.mass )
		
	S.LinearLink.reduced_mass = 1.0 / ( S.LinearLink.a->inv_mass + S.LinearLink.b->inv_mass )
	
	LinearSprings.push_back( S )
	
	''
	S.LinearLink.a = @Roxelbodys[1]->Roxels[1]->LinearState
	S.LinearLink.b = @Roxelbodys[2]->LinearState
	
	S.rest_distance = (S.LinearLink.b->position - S.LinearLink.a->position).length()
	
	S.LinearLink.mass = S.LinearLink.a->mass + S.LinearLink.b->mass
		
	S.LinearLink.inv_Mass = IIf( S.LinearLink.mass = 0.0 , 0.0 , 1.0 / S.LinearLink.mass )
		
	S.LinearLink.reduced_mass = 1.0 / ( S.LinearLink.a->inv_mass + S.LinearLink.b->inv_mass )
	
	LinearSprings.push_back( S )
	
	'
	S.LinearLink.a = @Roxelbodys[2]->Roxels[2]->LinearState
	S.LinearLink.b = @Roxelbodys[3]->LinearState
	
	S.rest_distance = (S.LinearLink.b->position - S.LinearLink.a->position).length()
	
	S.LinearLink.mass = S.LinearLink.a->mass + S.LinearLink.b->mass
		
	S.LinearLink.inv_Mass = IIf( S.LinearLink.mass = 0.0 , 0.0 , 1.0 / S.LinearLink.mass )
		
	S.LinearLink.reduced_mass = 1.0 / ( S.LinearLink.a->inv_mass + S.LinearLink.b->inv_mass )
	
	LinearSprings.push_back( S )
	
	''
	S.LinearLink.a = @Roxelbodys[3]->Roxels[3]->LinearState
	S.LinearLink.b = @Roxelbodys[0]->LinearState
	
	S.rest_distance = (S.LinearLink.b->position - S.LinearLink.a->position).length()
	
	S.LinearLink.mass = S.LinearLink.a->mass + S.LinearLink.b->mass
		
	S.LinearLink.inv_Mass = IIf( S.LinearLink.mass = 0.0 , 0.0 , 1.0 / S.LinearLink.mass )
		
	S.LinearLink.reduced_mass = 1.0 / ( S.LinearLink.a->inv_mass + S.LinearLink.b->inv_mass )
	
	LinearSprings.push_back( S )
	
End Sub

Sub GameType.Puzzle7()
	
	'' 
	
	iterations = 4
	warmstart    = 1
	
	cStiffness   = 0.25   
	cDamping     = 1.0
	cWarmstart   = 0.5
	
	cAstiffness  = 0.2
	cAdamping    = 0.5
	cAwarmstart  = 0.5
	
	PuzzleText = ""
	
	ClearAllArrays()
	
	Dim As RoxelType P1
	
	P1.LinearState.mass         = 50.0
	P1.LinearState.inv_mass = 1.0 / P1.LinearState.mass
	P1.radius              = 10.0
	P1.LinearState.position.x   = 200
	P1.LinearState.position.y   = 200
	
	Dim As RoxelType Ptr PP1 = Roxels.push_back(P1)
	
	Dim As RoxelType P2
	
	P2.LinearState.mass         = 50.0
	P2.LinearState.inv_mass = 1.0 / P1.LinearState.mass
	P2.radius              = 10.0
	P2.LinearState.position.x   = 800
	P2.LinearState.position.y   = 600
	
	Dim As RoxelType Ptr PP2 = Roxels.push_back(P2)
	
	CreateRope( @PP1->LinearState , @PP2->LinearState, 25 )
	
End Sub

Sub GameType.Puzzle8()
	
	'' 
	
	iterations = 4
	warmstart    = 1
	cStiffness   = 1.0
	cDamping     = 1.0
	cWarmstart   = 1.0
	
	PuzzleText = "Demo 8:"
	
	ClearAllArrays()
	
	'' create particles
	Dim As RoxelType R1
		
	R1.LinearState.mass         = 3.0
	R1.LinearState.inv_mass = 1.0 / R1.LinearState.mass
	R1.LinearState.position.x   = 0.25 * screen_wid
	R1.LinearState.position.y   = 0.25 * screen_hgt
	
	R1.Radius = ( ( R1.LinearState.mass / C_DENSITY ) / (4/3) * PI ) ^ (1/3) 
	R1.Colour = RGB( 128, 128, 128 )
	
	Dim As RoxelType Ptr RP1 = Roxels.push_back( R1 )
	
	''
	Dim As RoxelType R2
		
	R2.LinearState.mass         = 3.0
	R2.LinearState.inv_mass = 1.0 / R2.LinearState.mass
	R2.LinearState.position.x   = 0.75 * screen_wid
	R2.LinearState.position.y   = 0.25 * screen_hgt
	
	R2.Radius = ( ( R2.LinearState.mass / C_DENSITY ) / (4/3) * PI ) ^ (1/3) 
	R2.Colour = RGB( 128, 128, 128 )
	
	Dim As RoxelType Ptr RP2 = Roxels.push_back( R2 )
	
	''
	Dim As RoxelType R3
		
	R3.LinearState.mass         = 3.0
	R3.LinearState.inv_mass = 1.0 / R3.LinearState.mass
	R3.LinearState.position.x   = 0.25 * screen_wid
	R3.LinearState.position.y   = 0.75 * screen_hgt
	
	R3.Radius = ( ( R3.LinearState.mass / C_DENSITY ) / (4/3) * PI ) ^ (1/3) 
	R3.Colour = RGB( 128, 128, 128 )
	
	Dim As RoxelType Ptr RP3 = Roxels.push_back( R3 )
	
	''
	Dim As RoxelType R4
		
	R4.LinearState.mass         = 3.0
	R4.LinearState.inv_mass = 1.0 / R4.LinearState.mass
	R4.LinearState.position.x   = 0.75 * screen_wid
	R4.LinearState.position.y   = 0.75 * screen_hgt
	
	R4.Radius = ( ( R4.LinearState.mass / C_DENSITY ) / (4/3) * PI ) ^ (1/3) 
	R4.Colour = RGB( 128, 128, 128 )
	
	Dim As RoxelType Ptr RP4 = Roxels.push_back( R4 )
	
	'' create springs
	Dim As LinearSpringType S1
	
	S1.LinearLink.a = @(RP1->LinearState)
	S1.LinearLink.b = @(RP3->LinearState)
	
	S1.rest_distance = ( S1.LinearLink.b->position - S1.LinearLink.a->position).length()
	
	S1.LinearLink.mass = S1.LinearLink.a->mass + S1.LinearLink.b->mass
	S1.LinearLink.inv_Mass = IIf( S1.LinearLink.mass = 0.0 , 0.0 , 1.0 / S1.LinearLink.mass )
	
	S1.LinearLink.reduced_mass = ( S1.LinearLink.a->mass * S1.LinearLink.b->mass ) / _
	                             ( S1.LinearLink.a->mass + S1.LinearLink.b->mass )
	
	S1.LinearLink.Position = ( S1.LinearLink.a->position * S1.LinearLink.a->mass + _
	                           S1.LinearLink.b->position * S1.LinearLink.b->mass ) * S1.LinearLink.inv_Mass
	
	Dim As LinearSpringType Ptr LL1 = LinearSprings.push_back( S1 )
	
	''
	Dim As LinearSpringType S2
	
	S2.LinearLink.a = @(RP2->LinearState)
	S2.LinearLink.b = @(RP4->LinearState)
	
	S2.rest_distance = ( S2.LinearLink.b->position - S2.LinearLink.a->position).length()
	
	S2.LinearLink.mass = S2.LinearLink.a->mass + S2.LinearLink.b->mass
	S2.LinearLink.inv_Mass = 1.0 / S2.LinearLink.mass
	
	S2.LinearLink.reduced_mass = ( S2.LinearLink.a->mass * S2.LinearLink.b->mass ) / _
	                             ( S2.LinearLink.a->mass + S2.LinearLink.b->mass )
	
	S2.LinearLink.Position = ( S2.LinearLink.a->position * S2.LinearLink.a->mass + _
	                           S2.LinearLink.b->position * S2.LinearLink.b->mass ) * S2.LinearLink.inv_Mass
	
	Dim As LinearSpringType Ptr LL2 = LinearSprings.push_back( S2 )
	
	'
	Dim As LinearSpringType S3
	
	S3.LinearLink.a    = @(LL1->LinearLink)
	S3.LinearLink.b    = @(LL2->LinearLink)
	
	S3.rest_distance = ( S3.LinearLink.b->position - S3.LinearLink.a->position).length()
	
	S3.LinearLink.mass = S3.LinearLink.a->mass + S3.LinearLink.b->mass
	S3.LinearLink.inv_Mass = 1.0 / S3.LinearLink.mass
	
	S3.LinearLink.reduced_mass = ( S3.LinearLink.a->mass * S3.LinearLink.b->mass ) / _
	                             ( S3.LinearLink.a->mass + S3.LinearLink.b->mass )
	
	S3.LinearLink.Position = ( S3.LinearLink.a->position * S3.LinearLink.a->mass + _
	                           S3.LinearLink.b->position * S3.LinearLink.b->mass ) * S3.LinearLink.inv_Mass
	
	Dim As LinearSpringType Ptr LL3 = LinearSprings.push_back( S3 )
	
	
	RP1->LinearState.AddImpulse( Vec2(  100.0, 0.0 ) )
	RP3->LinearState.AddImpulse( Vec2( -100.0, 0.0 ) )
	
	RP2->LinearState.AddImpulse( Vec2( -200.0, 0.0 ) )
	RP4->LinearState.AddImpulse( Vec2(  200.0, 0.0 ) )
	
	LL1->LinearLink.AddImpulse( Vec2( 0.0,  50.0 ) )
	LL2->LinearLink.AddImpulse( Vec2( 0.0, -50.0 ) )
	'LL3->LinearLink.AddImpulse( Vec2( 0.0, -10.0 ) )
	
End Sub

