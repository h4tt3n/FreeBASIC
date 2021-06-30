''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 7, february 2019
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
	
End Sub

Sub GameType.Puzzle4()
	
	''
	
	iterations  = 4
	warmstart   = 1
	
	PuzzleText = "Demo 4: Gravity and orbits"
	
	ClearAllArrays()
	
End Sub

Sub GameType.Puzzle5()
	
	'' 
	
	iterations   = 4
	warmstart    = 0
	
	PuzzleText = "Demo 5: "
	
	ClearAllArrays()
	
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
	
End Sub

Sub GameType.Puzzle7()
	
	'' 
	
	iterations = 4
	warmstart  = 1
	
	PuzzleText = "Demo 7: "
	
	ClearAllArrays()
	
	Dim As RoxelType Ptr PP1 = CreateRoxel( Vec2( 200, 200 ), 10.0, 10.0 )
	Dim As RoxelType Ptr PP2 = CreateRoxel( Vec2( 800, 600 ), 10.0, 10.0 )
	
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
	Dim As LinearSpringType Ptr LL1 = CreateLinearSpring( 0.1, 0.1, 0.1, RP1, RP2, @LinearSprings )
	Dim As LinearSpringType Ptr LL2 = CreateLinearSpring( 0.1, 0.1, 0.1, RP2, RP3, @LinearSprings )
	Dim As LinearSpringType Ptr LL3 = CreateLinearSpring( 0.1, 0.1, 0.1, RP3, RP4, @LinearSprings )
	'Dim As LinearSpringType Ptr LL3 = CreateLinearSpring( 0.01, 0.01, 0.01, @(LL1->LinearLink), @(LL2->LinearLink), @LinearSprings )
	'Dim As LinearSpringType Ptr LL4 = CreateLinearSpring( 0.0, cDamping, cWarmstart, RP1, @(LL3->LinearLink), @LinearSprings )
	
	Dim As AngularSpringType Ptr AS1 = CreateAngularSpring( 0.1, 0.1, 0.1, @(LL1->LinearLink), @(LL2->LinearLink), @AngularSprings )
	Dim As AngularSpringType Ptr AS2 = CreateAngularSpring( 0.1, 0.1, 0.1, @(LL2->LinearLink), @(LL3->LinearLink), @AngularSprings )
	
	
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

