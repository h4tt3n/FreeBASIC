''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 5, june 2018
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
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
	
	CreateLinearState( Vec2( 0.5 * screen_wid, 0.25 * screen_hgt ), 0.0 )
	
	For i As integer = 2 To num_Particles - 1
		
		Dim As vec2 psn = Vec2( 0.5 * screen_wid + ( i - 1 ) * SpringLength, 0.25 * screen_hgt )
		
		CreateLinearState( psn, 1.0 )
		
	Next
	
	CreateRoxel( Vec2( 0.5 * screen_wid + ( num_Particles - 1 ) * SpringLength, 0.25 * screen_hgt ), 500.0, 20.0 )
	
	''  create springs
	For i As Integer = 0 To num_Springs-2
		
		CreateLinearSpring( cStiffness, cDamping, cWarmstart, LinearStates[i], LinearStates[i+1] ) 
		
	Next
	
	CreateLinearSpring( cStiffness, cDamping, cWarmstart, LinearStates[num_Springs-1], @Roxels[0]->LinearState ) 

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
	
	PuzzleText = "Coil spring"
	
	ClearAllArrays()
	
	Randomize
	
	'' create particles
	
	CreateLinearState( Vec2( 0.5 * screen_wid, 0.5 * screen_hgt ), 1.0 )
	
	For i As integer = 1 To num_Particles - 1
		
		Dim As Vec2 psn = 0.5 * Vec2( screen_wid, screen_hgt ) + Vec2( Cos(Angle), Sin(Angle) ) * SpringLength
		
		CreateLinearState( psn, 1.0 )
		
		delta_direction -= 0.001
		Angle += delta_direction
		SpringLength += 1

		
	Next
	
	'' create springs
	For i As Integer = 0 To num_Springs - 1
		
		CreateLinearSpring( cStiffness, cDamping, cWarmstart, LinearStates[i], LinearStates[i+1] ) 
		
	Next
	
	
End Sub

Sub GameType.Puzzle3()
	
	''
	
	iterations = 4
	warmstart    = 0
	cStiffness   = 0.0
	cDamping     = 1.0
	cWarmstart   = 0.0
	
	Dim As Integer GirderWidth  = 2
	Dim As Integer GirderLength = 16
	Dim As Integer SpringLength = 24
	
	PuzzleText = ""
	
	ClearAllArrays()
	
	
	Dim As ShapeBodyType Ptr G3 = CreateShapeGirder( Vec2( 200.0, 400.0 ), _
	                                            Vec2( Cos( 0.0 * TWO_PI ), Sin( 0.0 * TWO_PI )), _
	                                            Vec2( GirderLength, GirderWidth ), _
	                                            Vec2( SpringLength, SpringLength ), _
	                                            X_TRUSS )
	
	Dim As ShapeBodyType Ptr G4 = CreateShapeGirder( Vec2( 200.0, 400.0 ), _
	                                            Vec2( Cos( 0.0 * TWO_PI ), Sin( 0.0 * TWO_PI )), _
	                                            Vec2( GirderLength, GirderWidth ), _
	                                            Vec2( SpringLength, SpringLength ), _
	                                            X_TRUSS )
	
	Dim As SoftBodyType Ptr G5 = CreateSoftGirder( Vec2( 600.0, 400.0 ), _
	                                            Vec2( Cos( 0.0 * TWO_PI ), Sin( 0.0 * TWO_PI )), _
	                                            Vec2( GirderLength, GirderWidth ), _
	                                            Vec2( SpringLength, SpringLength ), _
	                                            X_TRUSS )
	
	Dim As RoxelBodyType Ptr P1 = CreatePlanet( Vec2( 600, 400 ), 0.0, 40, 160, 32 )
	 
	'CreateRope( G3->LinearStates.p_front, G4->LinearStates.p_back, 24 )
	'CreateRope( G2->LinearStates.p_front, G3->LinearStates.p_back, 24 )
	'CreateRope( G3->LinearStates.p_front, G1->LinearStates.p_back, 24 )

	
	'G2->LinearState.Addimpulse( Vec2( -100.0, 0.0 ) )
	'G1->AngularState.impulse = -0.001
	'G2->AngularState.impulse =  0.5
	'G3->AngularState.impulse = -0.5
	'G4->AngularState.impulse = -1.0
	'G5->AngularState.impulse = -1.0
	
	G3->LinearState.impulse = Vec2( 0.0, -200.0 )
	G5->LinearState.impulse = Vec2( 0.0,  200.0 )
	
	G4->LinearState.impulse = Vec2( 0.0, -50.0 )
	P1->LinearState.impulse = Vec2( 0.0,  50.0 )
	
	CreateLinearSpring( 0.2, 1.0, 0.5, G3->LinearStates.p_back, G5->LinearStates.p_front )
	CreateLinearSpring( 0.2, 1.0, 0.5, G4->LinearStates.p_back, @(P1->Roxels[0]->LinearState) )
	
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
	
	'Dim As RoxelBodyType Ptr PP1 = CreatePlanet( Vec2( 500, 200 ), 0.0, 40, 160, 32 )
	'Dim As RoxelBodyType Ptr PP2 = CreatePlanet( Vec2( 500, 600 ), 0.0, 40, 320, 64 )
	
	Dim As RoxelType Ptr PP1 = CreateRoxel( Vec2( 200, 200 ), 100.0, 10.0 )
	Dim As RoxelType Ptr PP2 = CreateRoxel( Vec2( 800, 600 ), 200.0, 20.0 )
	
	'PP1->LinearState.Addimpulse( Vec2(  200.0, 0.0 ) )
	'PP2->LinearState.Addimpulse( Vec2( -100.0, 0.0 ) )
	
	'PP1->AngularState.Impulse +=  0.1
	'PP2->AngularState.Impulse += -0.1
	
	''
	CreateGravity( @(PP1->LinearState), @(PP2->LinearState) )
	
	CreateOrbit( Vec2( 600, 400 ), 0.5, 400, -0.125 * TWO_PI, 0.5 * TWO_PI, -1, @(PP1->LinearState), @(PP2->LinearState) )

End Sub

Sub GameType.Puzzle5()
	
	'' 
	
	iterations   = 4
	warmstart    = 0
	
	PuzzleText = ""
	
	ClearAllArrays()
	
	Dim As Integer GirderWidth  = 2
	Dim As Integer GirderLength = 16
	Dim As Integer SpringLength = 24
	
	
	Dim As RoxelBodyType Ptr P1 = CreatePlanet( Vec2( 600, 400 ), 0.0, 80, 160, 128 )
	
	
	Dim As ShapeBodyType Ptr G1 = CreateShapeGirder( Vec2( 200.0, 400.0 ), _
	                                            Vec2( Cos( 0.25 * TWO_PI ), Sin( 0.25 * TWO_PI )), _
	                                            Vec2( GirderLength, GirderWidth ), _
	                                            Vec2( SpringLength, SpringLength ), _
	                                            V_TRUSS )
	
	Dim As SoftBodyType Ptr G2 = CreateSoftGirder( Vec2( 800.0, 400.0 ), _
	                                            Vec2( Cos( 0.25 * TWO_PI ), Sin( 0.25 * TWO_PI )), _
	                                            Vec2( GirderLength, GirderWidth ), _
	                                            Vec2( SpringLength, SpringLength ), _
	                                            X_TRUSS )
	
	''
	CreateGravity( @(P1->LinearState), @(G1->LinearState) )
	CreateGravity( @(P1->LinearState), @(G2->LinearState) )
	CreateGravity( @(G1->LinearState), @(G2->LinearState) )
	
	''
	'CreateLinearSpring( 0.2, 1.0, 0.5, @(P1->Roxels[0]->LinearState), @(G1->LinearState))
	'CreateLinearSpring( 0.2, 1.0, 0.5, @(P1->LinearState), G2->LinearStates.p_back)
	
	'G1->LinearState.impulse = Vec2( 0.0, -50.0 )
	'G2->LinearState.impulse = Vec2( 0.0,  50.0 )
	
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
	CreateLinearSpring( cStiffness, cDamping, cWarmstart, @Roxelbodys[0]->Roxels[0]->LinearState, @Roxelbodys[1]->LinearState )
	CreateLinearSpring( cStiffness, cDamping, cWarmstart, @Roxelbodys[1]->Roxels[1]->LinearState, @Roxelbodys[2]->LinearState )
	CreateLinearSpring( cStiffness, cDamping, cWarmstart, @Roxelbodys[2]->Roxels[2]->LinearState, @Roxelbodys[3]->LinearState )
	CreateLinearSpring( cStiffness, cDamping, cWarmstart, @Roxelbodys[3]->Roxels[3]->LinearState, @Roxelbodys[0]->LinearState )
	
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
	
	Dim As RoxelType Ptr PP1 = CreateRoxel( Vec2( 200, 200 ), 50.0, 10.0 )
	Dim As RoxelType Ptr PP2 = CreateRoxel( Vec2( 800, 600 ), 50.0, 10.0 )
	
	CreateRope( @PP1->LinearState, @PP2->LinearState, 25 )
	
End Sub

Sub GameType.Puzzle8()
	
	'' 
	
	iterations = 4
	warmstart  = 1
	cStiffness = 1.0
	cDamping   = 1.0
	cWarmstart = 1.0
	
	PuzzleText = "Demo 8:"
	
	ClearAllArrays()
	
	'' create particles

	
	Dim As RoxelType Ptr RP1 = CreateRoxel( Vec2( 0.25 * screen_wid, 0.25 * screen_hgt ), 3.0, 0.0 )
	Dim As RoxelType Ptr RP2 = CreateRoxel( Vec2( 0.75 * screen_wid, 0.25 * screen_hgt ), 3.0, 0.0 )
	Dim As RoxelType Ptr RP3 = CreateRoxel( Vec2( 0.25 * screen_wid, 0.75 * screen_hgt ), 3.0, 0.0 )
	Dim As RoxelType Ptr RP4 = CreateRoxel( Vec2( 0.75 * screen_wid, 0.75 * screen_hgt ), 3.0, 0.0 )
	
	RP1->colour = RGB( 128, 128, 128 )
	RP2->colour = RGB( 128, 128, 128 )
	RP3->colour = RGB( 128, 128, 128 )
	RP4->colour = RGB( 128, 128, 128 )
	
	'' create springs
	Dim As LinearSpringType Ptr LL1 = CreateLinearSpring( cStiffness, cDamping, cWarmstart, @(RP1->LinearState), @(RP3->LinearState) )
	Dim As LinearSpringType Ptr LL2 = CreateLinearSpring( cStiffness, cDamping, cWarmstart, @(RP2->LinearState), @(RP4->LinearState) )
	Dim As LinearSpringType Ptr LL3 = CreateLinearSpring( cStiffness, cDamping, cWarmstart, @(LL1->LinearLink), @(LL2->LinearLink) )
	
	
	RP1->LinearState.AddImpulse( Vec2(  100.0, 0.0 ) )
	RP3->LinearState.AddImpulse( Vec2( -100.0, 0.0 ) )
	
	RP2->LinearState.AddImpulse( Vec2( -200.0, 0.0 ) )
	RP4->LinearState.AddImpulse( Vec2(  200.0, 0.0 ) )
	
	LL1->LinearLink.AddImpulse( Vec2( 0.0,  50.0 ) )
	LL2->LinearLink.AddImpulse( Vec2( 0.0, -50.0 ) )
	'LL3->LinearLink.AddImpulse( Vec2( 0.0, -10.0 ) )
	
End Sub

