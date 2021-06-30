''******************************************************************************
''
''   SquishyPlanet sandbox testbed. This is not part of the physics engine.
''
''
''******************************************************************************


'' Include the library
#Include "SquishyPlanet.bi"

''
#Include "../../GameIO/GameIO.bi"

'' Create a World instance
Dim Shared As World ThisWorld

Dim Shared As Joystick GameJoystick

Dim Shared As ScreenType GameScreen

Dim Shared As Camera GameCamera

'GameScreen.Create()
GameScreen.Create( 1200, 900, 16, 0 )

GameCamera.Create( GameScreen.Width , GameScreen.Height, 20.0 )

Randomize

''
Dim As Particle Ptr SB1 = Thisworld.CreateParticle( 1E6, 100.0, Vec2( 0.0, 0.0 ) )
Dim As Particle Ptr SB2 = Thisworld.CreateParticle( 1E6, 100.0, Vec2( 0.0, 0.0 ) )
Dim As Particle Ptr SB3 = Thisworld.CreateParticle( 2E6, 200.0, Vec2( 0.0, 0.0 ) )
Dim As Particle Ptr SB4 = Thisworld.CreateParticle( 4E6, 400.0, Vec2( 0.0, 0.0 ) )

Dim As SpringBody Ptr Ship = Thisworld.CreateSpringBody( 3, 64.0, Vec2( -1700.0, 8000.0 ) )


''
Dim As KeplerOrbit Ptr K1 = Thisworld.CreateKeplerOrbit( SB1, SB2 )
Dim As KeplerOrbit Ptr K2 = Thisworld.CreateKeplerOrbit( Sb3, K1 )
Dim As KeplerOrbit Ptr K3 = Thisworld.CreateKeplerOrbit( SB4, K2 )
'Dim As KeplerOrbit Ptr K4 = Thisworld.CreateKeplerOrbit( K1, K3 )

'Dim As KeplerOrbit K1 = KeplerOrbit( SB1, SB2 )
'Dim As KeplerOrbit K2 = KeplerOrbit( SB3, @K1 )
'Dim As KeplerOrbit K3 = KeplerOrbit( SB4, @K2 )
'Dim As KeplerOrbit K4 = KeplerOrbit( @K1, @K3 )

'Dim As KeplerOrbit ShipOrbit = KeplerOrbit( @K4, Ship )

''
K1->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 1000, 0.0 * TWO_PI, 0.0 * TWO_PI, -1 )
K2->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 4000, 0.0 * TWO_PI, 0.0 * TWO_PI,  1 )
K3->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 16000, 0.0 * TWO_PI, 0.0 * TWO_PI, -1 )
'K4.ApplyOrbit( Vec2( 0.0, 0.0 ), 0.1, 4000, 0.0 * TWO_PI, 0.5  * TWO_PI,  1 )

'ShipOrbit.ApplyOrbit( Vec2( 0, 0 ), 0.0, 6000, 0.0 * TWO_PI, 0.0 * TWO_PI, 1 )

'SB1->AddPosition(  Vec2( 42.0, 117.0 ) )
'SB1->AddPosition( -Vec2( 42.0, 117.0 ) )

'K4->AddPosition( Vec2( 800.0, 550.0 ) )
'K4->AddAngularImpulse( 1.0 )

'SB1->ApplyImpulse( Vec2( 2000.0, 0.0 ), Vec2( 0.0, 64.0) ) 
'SB1->AddImpulse( Vec2( 100.0, 0.0 ) )

''
'Dim As NewtonGravity Ptr N1 = Thisworld.CreateNewtonGravity( SB2, Ship )
'Dim As NewtonGravity Ptr N2 = Thisworld.CreateNewtonGravity( N1, SB1 )
'Dim As NewtonGravity Ptr N3 = Thisworld.CreateNewtonGravity( SB3, SB4 )
'Dim As NewtonGravity Ptr N4 = Thisworld.CreateNewtonGravity( N2, N3 )

''
Dim As NewtonGravity Ptr N1  = Thisworld.CreateNewtonGravity( SB1, SB2 )
Dim As NewtonGravity Ptr N2  = Thisworld.CreateNewtonGravity( SB1, SB3 )
Dim As NewtonGravity Ptr N3  = Thisworld.CreateNewtonGravity( SB1, SB4 )
Dim As NewtonGravity Ptr N4  = Thisworld.CreateNewtonGravity( SB1, Ship )
Dim As NewtonGravity Ptr N5  = Thisworld.CreateNewtonGravity( SB2, SB3 )
Dim As NewtonGravity Ptr N6  = Thisworld.CreateNewtonGravity( SB2, SB4 )
Dim As NewtonGravity Ptr N7  = Thisworld.CreateNewtonGravity( SB2, Ship )
Dim As NewtonGravity Ptr N8  = Thisworld.CreateNewtonGravity( SB3, SB4 )
Dim As NewtonGravity Ptr N9  = Thisworld.CreateNewtonGravity( SB3, Ship )
Dim As NewtonGravity Ptr N10 = Thisworld.CreateNewtonGravity( SB4, Ship )

Ship->Particles_.Resize( 1000 )

'Ship->AddObject( N1 )
'Ship->RemoveObject( 3 )  ' doesn't work
'Ship->Particles_.pop_back()



'Ship->ComputeMass()
'Ship->ComputeStateVectors()
'Ship->ComputeInertia()
'Ship->ComputeAngularVelocity()

''
'K1->ComputePeriod( K1->GravParam, K1->SemimajorAxis )
'K2->ComputePeriod( K2->GravParam, K2->SemimajorAxis )
'K3->ComputePeriod( K3->GravParam, K3->SemimajorAxis )
'K4->ComputePeriod( K4->GravParam, K4->SemimajorAxis )
'
''
'SB1->AddAngularImpulse( TWO_PI / K2->Period * -K2->OrbitDirection )
'SB2->AddAngularImpulse( TWO_PI / K1->Period * -K1->OrbitDirection )
'SB3->AddAngularImpulse( TWO_PI / K3->Period * -K3->OrbitDirection )
'SB4->AddAngularImpulse( TWO_PI / K3->Period * -K3->OrbitDirection )
'Ship->AddAngularImpulse( TWO_PI / K1->Period * -K1->OrbitDirection )

'Thisworld.ComputeData()

'Dim As LinearSpring Ptr LS1 = Thisworld.CreateLinearSpring( 0.1, 0.1, 0.0, *SB1->LinearSprings_[0], *SB3->LinearSprings_[3] )
'Dim As LinearSpring Ptr LS2 = Thisworld.CreateLinearSpring( 0.01, 0.01, SB2, SB4 )
'Dim As LinearSpring Ptr LS3 = Thisworld.CreateLinearSpring( 0.01, 0.01, LS1, LS2 )
'Dim As LinearSpring Ptr LS4 = Thisworld.CreateLinearSpring( 0.01, 0.01, LS3, Ship )

'SB1->AddAngularImpulse( 50.0 )

''
'Dim As AngularSpring Ptr AS1 = ThisWorld.CreateAngularSpring( 0.02, 0.01, SB1, SB2 )
'Dim As AngularSpring Ptr AS4 = ThisWorld.CreateAngularSpring( 0.02, 0.01, SB4, Ship )
'Dim As AngularSpring Ptr AS2 = ThisWorld.CreateAngularSpring( 0.02, 0.01, SB2, SB3 )
'Dim As AngularSpring Ptr AS3 = ThisWorld.CreateAngularSpring( 0.02, 0.01, SB3, SB4 )
'Dim As AngularSpring Ptr AS4 = ThisWorld.CreateAngularSpring( 0.1, 0.1, *SB1->LinearSprings_[0], SB2 )
'Dim As AngularSpring Ptr AS5 = ThisWorld.CreateAngularSpring( 0.1, 0.1, SB3, *SB2->LinearSprings_[0] )
'Dim As AngularSpring Ptr AS6 = ThisWorld.CreateAngularSpring( 0.001, 0.001, SB3, SB4 )

Do
	
	GameJoystick.Update()
	
	Ship->AddImpulse( Vec2(GameJoystick.Axis(1).x, GameJoystick.Axis(1).y) * 0.3 )
	
	If Abs( GameJoystick.Axis(4).x ) > 0.15 Then Ship->AddAngle( GameJoystick.Axis(4).x * 0.05 )
	If Abs( GameJoystick.Axis(4).y ) > 0.15 Then Ship->AddImpulse( GameJoystick.Axis(4).y * 0.5 * Ship->AngleVector )
	
	If GameJoystick.Button(3) Then GameCamera.RestZoom_ /= 1.01
	If GameJoystick.Button(0) Then GameCamera.Restzoom_ *= 1.01
	
	GameCamera.RestPosition_ = Ship->Position
	
	If Abs( GameJoystick.Axis(2).x ) > 0.15 Then GameCamera.RestPosition_.x += GameJoystick.Axis(2).x * GameScreen.Width  * GameCamera.Zoom_ * 0.33
	If Abs( GameJoystick.Axis(2).y ) > 0.15 Then GameCamera.RestPosition_.y -= GameJoystick.Axis(2).y * GameScreen.Height * GameCamera.Zoom_ * 0.33
	
	GameCamera.Update()
	
	Thisworld.ApplyWarmStart()
	
	Thisworld.ApplyImpulses()
	
	ThisWorld.ComputeNewState()
	
	Thisworld.ComputeData()
	
	
	'SB1->AddAngle( 0.001 * TWO_PI)
	'SB1->AddAngleVector( AngleToUnit( TWO_PI * 0.001 ) )
		
	Cls
	
	'K1->ComputeHillSpheres()
	'K2->ComputeHillSpheres()
	'K3->ComputeHillSpheres()
	'K4->ComputeHillSpheres()
	'
	'Circle( K1->ParticleA->Position.x, K1->ParticleA->Position.y ), K1->HillSphereA, RGB( 0, 0, 255 ),,,1
	'Circle( K1->ParticleB->Position.x, K1->ParticleB->Position.y ), K1->HillSphereB, RGB( 0, 0, 255 ),,,1
	'
	'Circle( K2->ParticleA->Position.x, K2->ParticleA->Position.y ), K2->HillSphereA, RGB( 0, 0, 255 ),,,1
	'Circle( K2->ParticleB->Position.x, K2->ParticleB->Position.y ), K2->HillSphereB, RGB( 0, 0, 255 ),,,1
	'
	'Circle( K3->ParticleA->Position.x, K3->ParticleA->Position.y ), K3->HillSphereA, RGB( 0, 0, 255 ),,,1
	'Circle( K3->ParticleB->Position.x, K3->ParticleB->Position.y ), K3->HillSphereB, RGB( 0, 0, 255 ),,,1
	'
	'Circle( K4->ParticleA->Position.x, K4->ParticleA->Position.y ), K4->HillSphereA, RGB( 0, 0, 255 ),,,1
	'Circle( K4->ParticleB->Position.x, K4->ParticleB->Position.y ), K4->HillSphereB, RGB( 0, 0, 255 ),,,1
	
	'Locate  2, 2: Print Using "######.##"; SB1->RestArea
	'Locate  4, 2: Print Using "######.##"; SB1->Area
	'Locate  4, 2: Print Using "Semimajor Axis:  ####.####"; K3->SemimajorAxis
	'Locate  6, 2: Print Using "Semiminor Axis:  ####.####"; K3->SemiminorAxis
	'Locate  8, 2: Print Using "Periapsis:       ####.####"; K3->Periapsis
	
	'For N As NewtonGravity Ptr = ThisWorld.NewtonGravitys_.p_front To ThisWorld.NewtonGravitys_.p_back
	'	
	'	If N->GetFlag( IS_VISIBLE ) Then
	'		
	'		Line( N->ParticleA->Position.x, N->ParticleA->Position.y )-_
	'		    ( N->ParticleB->Position.x, N->ParticleB->Position.y ),  RGB( 128, 0, 128 )
	'		
	'		Circle( N->Position.x, N->Position.y ), 2.0, RGB( 255, 0, 255 ),,,1,f
	'		
	'	End If
	'		
	'Next
	
	''
	'ThisWorld.WhatAmIOrbiting( Ship, @ThisWorld.NewtonGravitys_ )
	
	'For P As NewtonGravity Ptr = ThisWorld.NewtonGravitys_.p_front To ThisWorld.NewtonGravitys_.p_back
	'	
	'	If P->GetFlag( IS_VISIBLE ) Then
	'		
	'		ThisWorld.WhatAmIOrbiting( P, @ThisWorld.NewtonGravitys_ )
	'		
	'	EndIf
	'	
	'Next
	'
	'For P As Particle Ptr = ThisWorld.Particles_.p_front To ThisWorld.Particles_.p_back
	'	
	'	If P->GetFlag( IS_VISIBLE ) Then
	'			
	'		ThisWorld.WhatAmIOrbiting( P, @ThisWorld.NewtonGravitys_ )
	'		
	'	EndIf
	'	
	'Next
	
	''
	For KP As KeplerOrbit Ptr = ThisWorld.KeplerOrbits_.p_front To ThisWorld.KeplerOrbits_.p_back
		
		If KP->GetFlag( IS_VISIBLE ) Then
			
			KP->DrawOrbit()
			
		End If
			
	Next
	
	'For A As AngularSpring Ptr = ThisWorld.AngularSprings_.p_front To ThisWorld.AngularSprings_.p_back
	'	
	'	Line( A->RotateA->Position.x, A->RotateA->Position.y )-_
	'	    ( A->RotateB->Position.x, A->RotateB->Position.y ),  RGB( 0, 255, 255 )
	'	
	'Next
	
	For L As LinearSpring Ptr = ThisWorld.LinearSprings_.p_front To ThisWorld.LinearSprings_.p_back
		
		If L->GetFlag( IS_VISIBLE ) Then
			
			Line( L->ParticleA->Position.x, L->ParticleA->Position.y )-_
			    ( L->ParticleB->Position.x, L->ParticleB->Position.y ),  RGB( 0, 255, 0 )
			
			Circle( L->Position.x, L->Position.y ), 2.0, RGB( 255, 0, 0 ),,,1,f
			
		EndIf
		
	Next
	
	For S As SpringBody Ptr = ThisWorld.SpringBodys_.p_front To ThisWorld.SpringBodys_.p_back
		
		If S->GetFlag( IS_VISIBLE ) Then
			
			Circle( S->Position.x, S->Position.y ), 3.0, RGB( 255, 255, 0 ),,,1,f
			
			Circle( S->Position.x + 10.0 * S->AngleVector.x, S->Position.y + 10.0 * S->AngleVector.y ), 3.0, RGB( 255, 255, 0 ),,,1
			
			'Dim As Particle Ptr P = *S->Particles_.p_front
			
			'Line( S->Position.x, S->Position.y )-( P->Position.x, P->Position.y ), RGB( 255, 255, 0 )
			
		EndIf
			
	Next
	
	'Circle( SB1->Position.x, SB1->Position.y ), 96.0, RGB( 255, 0, 0 ),,,1
	
	
	'For P As PressureBody Ptr = ThisWorld.PressureBodys_.p_front To ThisWorld.PressureBodys_.p_back
	'	
	'	Circle( P->Position.x, P->Position.y ), 3.0, RGB( 0, 255, 0 ),,,1,f
	'	
	'Next
	
	'For B As Body Ptr = ThisWorld.Bodys_.p_front To ThisWorld.Bodys_.p_back
	'	
	'	Circle( B->Position.x, B->Position.y ), 3.0, RGB( 0, 255, 0 ),,,1,f
	'	
	'Next
	
	For P As Particle Ptr = ThisWorld.Particles_.p_front To ThisWorld.Particles_.p_back
		
		If P->GetFlag( IS_VISIBLE ) Then
				
			Circle( P->Position.x, P->Position.y ), P->Radius , RGB( 128, 128, 128 ),,,1,f
			
		EndIf
		
	Next
	

	ScreenCopy()
	
	Sleep 1, 1
	
'Loop Until GameJoystick.Button(8)'MultiKey(1)
Loop Until MultiKey(1)
