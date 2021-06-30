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

Sub GameType.Puzzle1()
	
	'' Wrecking ball
	
	iterations  = 4
	warmstart   = 1
	
	PuzzleText = "Demo 1: "
	
	ClearAllArrays()
	
	Dim As RoxelType Ptr R1 = CreateRoxel( Vec2( 0.0, 0.0 ), 10.0,  5.0 )
	Dim As RoxelType Ptr R2 = CreateRoxel( Vec2( 0.0, 0.0 ), 30.0, 10.0 )
	Dim As RoxelType Ptr R3 = CreateRoxel( Vec2( 0.0, 0.0 ), 90.0, 20.0 )
	
	R1->SetPosition( Vec2( 100, 100 ) )
	R2->SetPosition( Vec2( 200, 200 ) )
	R3->SetPosition( Vec2( 300, 300 ) )
	
	Dim As GravityType Ptr G1 = CreateGravity( R1, R2 )
	Dim As GravityType Ptr G2 = CreateGravity( R1, R3 )
	Dim As GravityType Ptr G3 = CreateGravity( R2, R3 )
	'Dim As GravityType Ptr G2 = CreateGravity( @(G1->LinearLink), R3 )
	
	G1->LinearLink.SetPosition( Vec2( 400, 400 ) )
	
	Dim As OrbitType Ptr O1 = CreateOrbit( Vec2( 0.0, 0.0 ), 0.1, 50, 0.0 * TWO_PI, 0.0 * TWO_PI,  1, R1, R2 )
	
	O1->LinearLink.SetPosition( Vec2( 800, 400 ) )
	
	Dim As OrbitType Ptr O2 = CreateOrbit( Vec2( 0.0, 0.0 ), 0.1, 400, 0.0 * TWO_PI, 0.0 * TWO_PI, -1, @(O1->LinearLink), R3 )
	
	O2->LinearLink.SetPosition( Vec2( 600, 400 ) )
	
End Sub

Sub GameType.Puzzle2()
	
	'' 
	iterations = 1
	warmstart  = 1
	
	PuzzleText = "Demo 2: "
	
	ClearAllArrays()
	
	Dim As RoxelBodyType Ptr P1 = CreatePlanet( Vec2( 600, 400 ), 0.0, 5, 5, 10 )
	Dim As RoxelBodyType Ptr P2 = CreatePlanet( Vec2( 600, 400 ), 0.0, 10, 10, 30 )
	Dim As RoxelBodyType Ptr P3 = CreatePlanet( Vec2( 600, 400 ), 0.0, 20, 20, 90 )
	
	P1->SetPosition( Vec2( 100, 100 ) )
	P2->SetPosition( Vec2( 200, 200 ) )
	P3->SetPosition( Vec2( 2000, 2000 ) )
	
	Dim As GravityType Ptr G1 = CreateGravity( P1, P2 )
	Dim As GravityType Ptr G2 = CreateGravity( P1, P3 )
	Dim As GravityType Ptr G3 = CreateGravity( P2, P3 )
	
	G1->LinearLink.SetPosition( Vec2( 400, 400 ) )
	G2->LinearLink.SetPosition( Vec2( 40, 40 ) )
	G3->LinearLink.SetPosition( Vec2( 4000, 4000 ) )
	
	Dim As OrbitType Ptr O1 = CreateOrbit( Vec2( 0.0, 0.0 ), 0.1, 50, 0.0 * TWO_PI, 0.0 * TWO_PI,  1, P1, P2 )
	
	O1->LinearLink.SetPosition( Vec2( 800, 400 ) )
	
	Dim As OrbitType Ptr O2 = CreateOrbit( Vec2( 0.0, 0.0 ), 0.1, 400, 0.0 * TWO_PI, 0.0 * TWO_PI, -1, @(O1->LinearLink), P3 )
	
	O2->LinearLink.SetPosition( Vec2( 600, 400 ) )
	
	'O2->LinearLink.AddImpulse( Vec2( 0.0, 1000.0 ) )
	
End Sub

Sub GameType.Puzzle3()
	
	''
	
	iterations = 1
	warmstart  = 0
	
	Dim As Integer GirderLength = 8
	Dim As Integer GirderWidth  = 2
	Dim As Integer UnitLength   = 48
	Dim As Integer UnitWidth    = 32
	
	PuzzleText = "Demo 3: "
	
	ClearAllArrays()
	
	
	Dim As SoftBodyType Ptr G3 = CreateSoftGirder( Vec2( 200.0, 400.0 ), _
	                                            Vec2( Cos( 0.0 * TWO_PI ), Sin( 0.0 * TWO_PI )), _
	                                            Vec2( GirderLength, GirderWidth ), _
	                                            Vec2( UnitLength, UnitWidth ), _
	                                            X_TRUSS )
	
	Dim As ShapeBodyType Ptr G4 = CreateShapeGirder( Vec2( 200.0, 400.0 ), _
	                                            Vec2( Cos( 0.0 * TWO_PI ), Sin( 0.0 * TWO_PI )), _
	                                            Vec2( GirderLength, GirderWidth ), _
	                                            Vec2( UnitLength, UnitWidth ), _
	                                            X_TRUSS )
	
	Dim As SoftBodyType Ptr G5 = CreateSoftGirder( Vec2( 600.0, 400.0 ), _
	                                            Vec2( Cos( 0.0 * TWO_PI ), Sin( 0.0 * TWO_PI )), _
	                                            Vec2( GirderLength, GirderWidth ), _
	                                            Vec2( UnitLength, UnitWidth ), _
	                                            X_TRUSS )
	
	Dim As RoxelBodyType Ptr P1 = CreatePlanet( Vec2( 600, 400 ), 0.0, 40, 160, 16 )
	Dim As RoxelBodyType Ptr P2 = CreatePlanet( Vec2( 500, 200 ), 0.0, 40, 80, 32 )
	Dim As RoxelBodyType Ptr P3 = CreatePlanet( Vec2( 500, 600 ), 0.0, 16, 512, 96 )
	 
	'CreateRope( G3->LinearStates.p_front, G4->LinearStates.p_back, 24 )
	'CreateRope( G2->LinearStates.p_front, G3->LinearStates.p_back, 24 )
	'CreateRope( G3->LinearStates.p_front, G1->LinearStates.p_back, 24 )

	
	'G2->LinearState.Addimpulse( Vec2( -100.0, 0.0 ) )
	'G1->AngularState.impulse = -0.001
	'G2->AngularState.impulse =  0.5
	'G3->AngularState.impulse = -0.5
	'G4->AngularState.impulse = -1.0
	'G5->AngularState.impulse = -1.0
	
	G3->Addimpulse( Vec2( 0.0, -2000.0 ) )
	G5->Addimpulse( Vec2( 0.0,  2000.0 ) )
	'
	'G4->Addimpulse( Vec2( 0.0, -50.0 ) )
	'P1->Addimpulse( Vec2( 0.0,  50.0 ) )
	
	'CreateLinearSpring( 0.2, 1.0, 0.5, G3->LinearStates.p_back, G5->LinearStates.p_front )
	
	'CreateLinearSpring( 0.2, 1.0, 0.5, @(G4->FixedSprings.p_back->LinearLink), P1->Roxels[0], @LinearSprings )
	
	CreateLinearSpring( 0.2, 1.0, 0.5, @(G3->LinearSprings.p_back->LinearLink), @(G5->LinearSprings.p_back->LinearLink), @LinearSprings )
	
End Sub

Sub GameType.Puzzle4()
	
	''
	
	iterations  = 4
	warmstart   = 1
	
	PuzzleText = "Demo 4: Gravity and orbits"
	
	ClearAllArrays()
	
	Dim As RoxelBodyType Ptr PP1 = CreatePlanet( Vec2( 500, 200 ), 0.0, 40, 80, 32 )
	Dim As RoxelBodyType Ptr PP2 = CreatePlanet( Vec2( 500, 600 ), 0.0, 60, 120, 128 )
	
	Dim As RoxelType Ptr PP3 = CreateRoxel( Vec2( 0, 0 ), 5.0, 10.0 )
	Dim As RoxelType Ptr PP4 = CreateRoxel( Vec2( 0, 0 ), 10.0, 15.0 )
	
	Dim As ShapeBodyType Ptr G1 = CreateShapeGirder( Vec2( 200.0, 400.0 ), _
	                                            Vec2( Cos( 0.25 * TWO_PI ), Sin( 0.25 * TWO_PI )), _
	                                            Vec2( 16, 2 ), _
	                                            Vec2( 32, 32 ), _
	                                            V_TRUSS )
	
	Dim As SoftBodyType Ptr G2 = CreateSoftGirder( Vec2( 200.0, 400.0 ), _
	                                            Vec2( Cos( 0.0 * TWO_PI ), Sin( 0.0 * TWO_PI )), _
	                                            Vec2( 16, 2 ), _
	                                            Vec2( 48, 32 ), _
	                                            V_TRUSS )
	
	''
	CreateGravity( PP1, G1 )
	CreateGravity( PP2, G2 )
	
	CreateOrbit( Vec2( 400, 400 ), 0.0, 300, 0.0 * TWO_PI, 0.0 * TWO_PI,  1, PP1, G1 )
	CreateOrbit( Vec2( 800, 400 ), 0.0, 300, 0.0 * TWO_PI, 0.0 * TWO_PI, -1, PP2, G2 )

End Sub

Sub GameType.Puzzle5()
	
	'' 
	
	iterations   = 4
	warmstart    = 0
	
	PuzzleText = "Demo 5: "
	
	ClearAllArrays()
	
	Dim As Integer GirderWidth  = 2
	Dim As Integer GirderLength = 16
	Dim As Integer SpringLength = 24
	
	
	Dim As RoxelBodyType Ptr P1 = CreatePlanet( Vec2( 600, 400 ), 0.0, 80, 160, 128 )
	
	
	'Dim As ShapeBodyType Ptr G1 = CreateShapeGirder( Vec2( 200.0, 400.0 ), _
	'                                            Vec2( Cos( 0.25 * TWO_PI ), Sin( 0.25 * TWO_PI )), _
	'                                            Vec2( GirderLength, GirderWidth ), _
	'                                            Vec2( SpringLength, SpringLength ), _
	'                                            V_TRUSS )
	'
	'Dim As SoftBodyType Ptr G2 = CreateSoftGirder( Vec2( 800.0, 400.0 ), _
	'                                            Vec2( Cos( 0.25 * TWO_PI ), Sin( 0.25 * TWO_PI )), _
	'                                            Vec2( GirderLength, GirderWidth ), _
	'                                            Vec2( SpringLength, SpringLength ), _
	'                                            X_TRUSS )
	
	''
	'CreateGravity( P1, G1 )
	'CreateGravity( P1, G2 )
	'CreateGravity( G1, G2 )
	
	''
	'CreateLinearSpring( 0.2, 1.0, 0.5, @(P1->Roxels[0]->LinearState), @(G1->LinearState))
	'CreateLinearSpring( 0.2, 1.0, 0.5, @(P1->LinearState), G2->LinearStates.p_back)
	
	'G1->LinearState.impulse = Vec2( 0.0, -50.0 )
	'G2->LinearState.impulse = Vec2( 0.0,  50.0 )
	
End Sub

Sub GameType.Puzzle6()
	
	'' 
	
	iterations   = 5
	warmstart    = 1
	
	Dim As Single cStiffness   = 0.2  
	Dim As Single cDamping     = 1.0
	Dim As Single cWarmstart   = 0.5
	
	PuzzleText   = "Demo 6: "
	
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
	Roxelbodys[0]->angular_velocity = -80.0
	Roxelbodys[1]->angular_velocity =  40.0
	Roxelbodys[2]->angular_velocity = -20.0
	Roxelbodys[3]->angular_velocity =  10.0
	'Roxelbodys[1]->Angular.angular_impulse = -0.1
	
	Roxelbodys[0]->velocity_vector = Vec2( Cos( Roxelbodys[0]->angular_velocity * DT ), Sin( Roxelbodys[0]->angular_velocity * DT ) )
	Roxelbodys[1]->velocity_vector = Vec2( Cos( Roxelbodys[1]->angular_velocity * DT ), Sin( Roxelbodys[1]->angular_velocity * DT ) )
	Roxelbodys[2]->velocity_vector = Vec2( Cos( Roxelbodys[2]->angular_velocity * DT ), Sin( Roxelbodys[2]->angular_velocity * DT ) )
	Roxelbodys[3]->velocity_vector = Vec2( Cos( Roxelbodys[3]->angular_velocity * DT ), Sin( Roxelbodys[3]->angular_velocity * DT ) )
	
	'Roxelbodys[0]->velocity_matrix.makeRotation(Roxelbodys[0]->angular_velocity * DT)
	'Roxelbodys[1]->velocity_matrix.makeRotation(Roxelbodys[1]->angular_velocity * DT)
	'Roxelbodys[2]->velocity_matrix.makeRotation(Roxelbodys[2]->angular_velocity * DT)
	'Roxelbodys[3]->velocity_matrix.makeRotation(Roxelbodys[3]->angular_velocity * DT)
	
	''
	CreateLinearSpring( cStiffness, cDamping, cWarmstart, Roxelbodys[0]->Roxels[0], Roxelbodys[1], @LinearSprings )
	CreateLinearSpring( cStiffness, cDamping, cWarmstart, Roxelbodys[1]->Roxels[1], Roxelbodys[2], @LinearSprings )
	CreateLinearSpring( cStiffness, cDamping, cWarmstart, Roxelbodys[2]->Roxels[2], Roxelbodys[3], @LinearSprings )
	CreateLinearSpring( cStiffness, cDamping, cWarmstart, Roxelbodys[3]->Roxels[3], Roxelbodys[0], @LinearSprings )
	
End Sub

Sub GameType.Puzzle7()
	
	'' 
	
	iterations = 4
	warmstart  = 1
	
	PuzzleText = "Demo 7: "
	
	ClearAllArrays()
	
	Dim As RoxelType Ptr PP1 = CreateRoxel( Vec2( 200, 200 ), 10.0, 10.0 )
	Dim As RoxelType Ptr PP2 = CreateRoxel( Vec2( 800, 600 ), 10.0, 10.0 )
	
	'PP1->AddImpulse( Vec2( -100.0, 0.0 ) )
	
	CreateRope( PP1, PP2, 64 )
	
End Sub

Sub GameType.Puzzle8()
	
	'' 
	
	iterations = 4
	warmstart  = 0
	
	PuzzleText = "Demo 8:"
	
	ClearAllArrays()
	
	'' create particles
	Dim As RoxelType Ptr RP1 = CreateRoxel( Vec2( 0.25 * screen_wid, 0.25 * screen_hgt ), 1.0 + Rnd() * 32.0, 0.0 )
	Dim As RoxelType Ptr RP2 = CreateRoxel( Vec2( 0.75 * screen_wid, 0.25 * screen_hgt ), 1.0 + Rnd() * 32.0, 0.0 )
	Dim As RoxelType Ptr RP3 = CreateRoxel( Vec2( 0.25 * screen_wid, 0.75 * screen_hgt ), 1.0 + Rnd() * 32.0, 0.0 )
	Dim As RoxelType Ptr RP4 = CreateRoxel( Vec2( 0.75 * screen_wid, 0.75 * screen_hgt ), 1.0 + Rnd() * 32.0, 0.0 )
	
	RP1->colour = RGB( 255, 64, 64 )
	RP2->colour = RGB( 64, 255, 64 )
	RP3->colour = RGB( 64, 64, 255 )
	RP4->colour = RGB( 255, 255, 64 )
	
	'' create springs
	Dim As LinearSpringType Ptr LL1 = CreateLinearSpring( 0.0, 0.0, 0.0, RP1, RP2, @LinearSprings )
	Dim As LinearSpringType Ptr LL2 = CreateLinearSpring( 0.0, 0.0, 0.0, RP2, RP3, @LinearSprings )
	Dim As LinearSpringType Ptr LL3 = CreateLinearSpring( 0.0, 0.0, 0.0, RP3, RP4, @LinearSprings )
	'Dim As LinearSpringType Ptr LL3 = CreateLinearSpring( 0.01, 0.01, 0.01, @(LL1->LinearLink), @(LL2->LinearLink), @LinearSprings )
	'Dim As LinearSpringType Ptr LL4 = CreateLinearSpring( 0.0, cDamping, cWarmstart, RP1, @(LL3->LinearLink), @LinearSprings )
	
	'Dim As AngularSpringType Ptr AS1 = CreateAngularSpring( 0.0, 0.0, 0.0, @(LL1->LinearLink), @(LL2->LinearLink), @AngularSprings )
	'Dim As AngularSpringType Ptr AS2 = CreateAngularSpring( 0.0, 0.0, 0.0, @(LL2->LinearLink), @(LL3->LinearLink), @AngularSprings )
	
	
	'RP1->Impulse += Vec2(  100.0, 0.0 )
	'RP3->Impulse += Vec2( -100.0, 0.0 )
	'
	'RP2->AddImpulse( Vec2( -200.0, 0.0 ) )
	'RP4->AddImpulse( Vec2(  200.0, 0.0 ) )
	
	'LL1->LinearLink.AddImpulse( Vec2( 0.0,  100.0 ) )
	'LL2->LinearLink.AddImpulse( Vec2( 0.0, -100.0 ) )
	'LL3->LinearLink.AddImpulse( Vec2( 0.0, -10.0 ) )
	
End Sub

Sub GameType.Puzzle9()
	
	iterations = 4
	warmstart  = 1
	
	PuzzleText = "Demo 9:"
	
	ClearAllArrays()
	
End Sub

Sub GameType.Puzzle0()
	
	iterations = 4
	warmstart  = 1
	
	PuzzleText = "Demo 0:"
	
	ClearAllArrays()
	
End Sub

