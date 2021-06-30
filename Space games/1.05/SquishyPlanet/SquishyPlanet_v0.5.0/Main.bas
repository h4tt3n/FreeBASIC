''******************************************************************************
''
''   Squishy2D Test program. This is not part of the physics engine.
''
''
''******************************************************************************


'' Include the library
#Include "Squishy2D.bi"

#Include "../../Graphics/Screen.bi"

'' Create a World instance
Dim As World ThisWorld

Dim As ScreenType GameScreen

GameScreen.Create()

Randomize Timer

''
Dim As SpringBody Ptr SB1 = Thisworld.CreateSpringBody( 32, 64.0, Vec2( 600, 550 ))
Dim As SpringBody Ptr SB2 = Thisworld.CreateSpringBody( 16, 32.0, Vec2( 200, 200 ))
Dim As SpringBody Ptr SB3 = Thisworld.CreateSpringBody(  8, 16.0, Vec2( 100, 0 ))
Dim As SpringBody Ptr SB4 = Thisworld.CreateSpringBody(  4,  8.0, Vec2( 100, 0 ))

''
Dim As KeplerOrbit Ptr K1 = Thisworld.CreateKeplerOrbit( SB1, SB3 )
Dim As KeplerOrbit Ptr K2 = Thisworld.CreateKeplerOrbit( SB2, SB4 )
Dim As KeplerOrbit Ptr K3 = Thisworld.CreateKeplerOrbit( K1, K2 )

''
K1->CreateOrbit( Vec2( 0, 0 )    , 0.0, 200, 0.0, 0.0, -1 )
K2->CreateOrbit( Vec2( 0, 0 )    , 0.0, 100 , 0.0, 0.0, -1 )
K3->CreateOrbit( Vec2( 600, 550 ), 0.5, 700, PI, PI,  1 )

''
Dim As NewtonGravity Ptr N1 = Thisworld.CreateNewtonGravity( SB1, SB2 )
Dim As NewtonGravity Ptr N2 = Thisworld.CreateNewtonGravity( SB1, SB3 )
Dim As NewtonGravity Ptr N3 = Thisworld.CreateNewtonGravity( SB1, SB4 )
Dim As NewtonGravity Ptr N4 = Thisworld.CreateNewtonGravity( SB2, SB3 )
Dim As NewtonGravity Ptr N5 = Thisworld.CreateNewtonGravity( SB2, SB4 )
Dim As NewtonGravity Ptr N6 = Thisworld.CreateNewtonGravity( SB3, SB4 )


Thisworld.ComputeData()

Do
	
	Thisworld.ApplyWarmStart()
	
	Thisworld.ApplyImpulses()
	
	ThisWorld.Solve()
	
	Thisworld.ComputeData()
	
	ScreenLock
		
		Cls
		
		'Locate  2, 2: Print Using "Eccentricity:    ####.####"; K3->Eccentricity
		'Locate  4, 2: Print Using "Semimajor Axis:  ####.####"; K3->SemimajorAxis
		'Locate  6, 2: Print Using "Semiminor Axis:  ####.####"; K3->SemiminorAxis
		'Locate  8, 2: Print Using "Periapsis:       ####.####"; K3->Periapsis
		
		For KP As KeplerOrbit Ptr = ThisWorld.KeplerOrbits_.Front To ThisWorld.KeplerOrbits_.Back
			
			KP->DrawOrbit()
			
		Next
		
		'For A As AngularSpring Ptr = ThisWorld.AngularSprings_.Front To ThisWorld.AngularSprings_.Back
		'	
		'	Line( A->RotateA->Position.x, A->RotateA->Position.y )-_
		'	    ( A->RotateB->Position.x, A->RotateB->Position.y ),  RGB( 0, 255, 255 )
		'	
		'Next
		
		For P As Particle Ptr = ThisWorld.Particles_.Front To ThisWorld.Particles_.Back
			
			Circle( P->Position.x, P->Position.y ), 3.0 , RGB( 128, 128, 128 ),,,1,f
			
		Next
		
		For L As LinearSpring Ptr = ThisWorld.LinearSprings_.Front To ThisWorld.LinearSprings_.Back
			
			Line( L->ParticleA->Position.x, L->ParticleA->Position.y )-_
			    ( L->ParticleB->Position.x, L->ParticleB->Position.y ),  RGB( 0, 255, 0 )
			
'			Circle( L->Position.x, L->Position.y ), 2.0, RGB( 255, 0, 128 ),,,1,f
			
		Next
		
		For S As SpringBody Ptr = ThisWorld.SpringBodys_.Front To ThisWorld.SpringBodys_.Back
			
			'Circle( S->Position.x, S->Position.y ), 3.0, RGB( 0, 255, 0 ),,,1,f
			
		Next
		
		'For P As PressureBody Ptr = ThisWorld.PressureBodys_.Front To ThisWorld.PressureBodys_.Back
		'	
		'	Circle( P->Position.x, P->Position.y ), 3.0, RGB( 0, 255, 0 ),,,1,f
		'	
		'Next
		
		'For B As Body Ptr = ThisWorld.Bodys_.Front To ThisWorld.Bodys_.Back
		'	
		'	Circle( B->Position.x, B->Position.y ), 3.0, RGB( 0, 255, 0 ),,,1,f
		'	
		'Next
		
	ScreenUnLock
	
	Sleep 1, 1
	
Loop Until MultiKey(1)
