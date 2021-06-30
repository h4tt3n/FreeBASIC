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
GameScreen.Create( 900, 600, 16, 0 )
GameCamera.Create( GameScreen.Width , GameScreen.Height, 1.0 )
Color( RGB( 255, 160, 160 ), RGB( 60, 64, 68 ) )


''
'Dim As LinearState Ptr L1 = Thisworld.CreateLinearState( 10000.0, Vec2( -200.0,  100.0 ) )
'Dim As LinearState Ptr L2 = Thisworld.CreateLinearState( 0.001, Vec2(  200.0, -100.0 ) )
'Dim As LinearState Ptr L3 = Thisworld.CreateLinearState( 0.001, Vec2(  100.0, -200.0 ) )
'Dim As LinearState Ptr L4 = Thisworld.CreateLinearState( 0.001, Vec2(  100.0, -200.0 ) )
'Dim As LinearState Ptr L5 = Thisworld.CreateLinearState( 0.001, Vec2(  100.0, -200.0 ) )
'
'Dim As KeplerOrbit Ptr K1 = ThisWorld.CreateKeplerOrbit( L1, L2 )
'Dim As KeplerOrbit Ptr K2 = ThisWorld.CreateKeplerOrbit( L1, L3 )
'Dim As KeplerOrbit Ptr K3 = ThisWorld.CreateKeplerOrbit( L1, L4 )
'Dim As KeplerOrbit Ptr K4 = ThisWorld.CreateKeplerOrbit( L1, L5 )
'
'K1->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.5, 400.0, 0.0 * TWO_PI, 0.0  * TWO_PI, CCW )
'K2->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.5, 400.0, 0.0 * TWO_PI, 0.25 * TWO_PI, CCW )
'K3->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.5, 400.0, 0.0 * TWO_PI, 0.5  * TWO_PI, CCW )
'K4->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.5, 400.0, 0.0 * TWO_PI, 0.75 * TWO_PI, CCW )

'Dim As LinearState Ptr L1 = Thisworld.CreateLinearState( 100.0, Vec2( -200.0,  100.0 ) )
'Dim As LinearState Ptr L2 = Thisworld.CreateLinearState( 200.0, Vec2(  200.0, -100.0 ) )
'Dim As LinearState Ptr L3 = Thisworld.CreateLinearState( 400.0, Vec2(  100.0, -200.0 ) )
'Dim As LinearState Ptr L4 = Thisworld.CreateLinearState( 800.0, Vec2(  100.0, -200.0 ) )
'
'Dim As KeplerOrbit Ptr K1 = ThisWorld.CreateKeplerOrbit( L1, L2 )
'Dim As KeplerOrbit Ptr K2 = ThisWorld.CreateKeplerOrbit( K1, L3 )
'Dim As KeplerOrbit Ptr K3 = ThisWorld.CreateKeplerOrbit( K2, L4 )
'
'K1->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 100.0, 0.0 * TWO_PI, 0.5 * TWO_PI, CCW )
'K2->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 400.0, 0.0 * TWO_PI, 0.5 * TWO_PI,  CW )
'K3->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 800.0, 0.0 * TWO_PI, 0.5 * TWO_PI, CCW )

'Dim As NewtonGravity Ptr N1 = ThisWorld.CreateNewtonGravity( L1, L2 )
'Dim As NewtonGravity Ptr N2 = ThisWorld.CreateNewtonGravity( L1, L3 )
'Dim As NewtonGravity Ptr N3 = ThisWorld.CreateNewtonGravity( L1, L4 )
'Dim As NewtonGravity Ptr N4 = ThisWorld.CreateNewtonGravity( L1, L5 )
'Dim As NewtonGravity Ptr N4 = ThisWorld.CreateNewtonGravity( L2, L3 )
'Dim As NewtonGravity Ptr N5 = ThisWorld.CreateNewtonGravity( L2, L4 )
'Dim As NewtonGravity Ptr N6 = ThisWorld.CreateNewtonGravity( L3, L4 )

'''
'Dim As AngularState Ptr A1 = Thisworld.CreateAngularState( 1.0,   1.0, 0.0  * TWO_PI, Vec2( -100.0, 100.0 ) )
'Dim As AngularState Ptr A2 = Thisworld.CreateAngularState( 1.0,  10.0, 0.25 * TWO_PI, Vec2(    0.0, 100.0 ) )
'Dim As AngularState Ptr A3 = Thisworld.CreateAngularState( 1.0, 100.0, 0.5  * TWO_PI, Vec2(  100.0, 100.0 ) )
'
'''
'Dim As LinearSpring Ptr LS1 = Thisworld.CreateLinearSpring( 1.0, 1.0, 0.0, L1, L2 )
'Dim As LinearSpring Ptr LS2 = Thisworld.CreateLinearSpring( 1.0, 1.0, 0.0, L2, L3 )
'
'''
'Dim As AngularSpring Ptr AS1 = ThisWorld.CreateAngularSpring( 0.01, 0.001, 0.0, 0.0 * TWO_PI, A1, A2 )


''
'Dim As SoftBody Ptr SB1 = ThisWorld.CreateSoftBody( 16, 128.0, Vec2( 0.0, 0.0 ) )
Dim As ShapeBody Ptr SB1 = ThisWorld.CreateShapeBody( 16, 128.0, Vec2( -200.0, 0.0 ) )
Dim As ShapeBody Ptr SB2 = ThisWorld.CreateShapeBody( 16, 128.0, Vec2(  200.0, 0.0 ) )


'SB1->setPosition( Vec2( -100.0, -100.0 ) )
'SB1->setVelocity( Vec2( 10.0, 10.0 ) )

'SB1->setAngle( -5.5 * TWO_PI )

'Dim As ShapeBody Ptr SB2 = ThisWorld.CreateShapeBody( 12, 64.0, Vec2(  200.0, 0.0 ) )


'Dim As AngularSpring Ptr AS2 = ThisWorld.CreateAngularSpring( 0.00001, 0.0, 0.0, A2, A3 )

'A1->AddAngularVelocity(  1.0 )
'A3->AddAngularVelocity( -2.0 )
'A1->AddAngularImpulse( -1.0 )

Dim As LinearState Ptr P1 = *SB1->LinearStates_[0]
'Dim As LinearState Ptr P2 = *SB1->LinearStates_[0]
'Dim As LinearState Ptr P3 = *SB1->LinearStates_[7]
'Dim As LinearState Ptr P4 = *SB1->LinearStates_[11]

'Thisworld.CreateLinearSpring( 0.0, 0.1, 0.0, P1, P2)
'Thisworld.CreateLinearSpring( 0.001, 0.001, 0.0, SB2, P1)

'SB1->AddAngularImpulse(  -0.5 )
'SB2->AddAngularImpulse( -1.0 )

'SB1->AddImpulse( Vec2( 10.0, 0.0 ) )
'
P1->AddPosition( Vec2(  -40.0, 40.0 ) )
'P2->AddVelocity( Vec2( -200.0, 0.0 ) )

'P1->AddImpulse( Vec2(    0.0,  200.0 ) )
'P2->AddImpulse( Vec2( -200.0,    0.0 ) )
'P3->AddImpulse( Vec2(    0.0, -200.0 ) )
'P4->AddImpulse( Vec2(  200.0,    0.0 ) )


'Thisworld.ComputeData()

'Dim As Single ang = 0.001 * TWO_PI

Do
	'
	'ang += 0.001
	
	
	'A1->AddAngularImpulse( 0.01 )
	
	'If ( GameJoystick ) Then
		
		GameJoystick.Update()
		
		If GameJoystick.Button(3) Then GameCamera.RestZoom_ /= 1.01
		If GameJoystick.Button(0) Then GameCamera.Restzoom_ *= 1.01
		
		If Abs( GameJoystick.Axis(2).x ) > 0.15 Then 
			
			GameCamera.RestPosition_.x += GameJoystick.Axis(2).x * GameScreen.Width  * GameCamera.Zoom_ * 0.01
			
		EndIf
		
		If Abs( GameJoystick.Axis(2).y ) > 0.15 Then 
			
			GameCamera.RestPosition_.y -= GameJoystick.Axis(2).y * GameScreen.Height * GameCamera.Zoom_ * 0.01
			
		EndIf
		
	'EndIf
	
	'If MultiKey( fb.SC_UP ) Then ThisWorld.KeplerOrbits_.Remove(0)
	
	'Thisworld.ApplyWarmStart()
	
	Thisworld.ApplyImpulses()
	
	ThisWorld.ComputeNewState()
	
	'SB1->AddAngle( ang  )
	
	Thisworld.ComputeData()
	
	GameCamera.Update()
	
	Cls
	
'	Locate  2,  2: Print K3->Eccentricity()
	'Locate  4,  2: Print LS1->GetAngularImpulse
	Locate  6,  2: Print SB1->GetAngularVelocity
	'Locate  8,  2: Print LS1->GetAngularVelocityVector.x ; LS1->GetAngularVelocityVector.y
	'Locate 10,  2: Print LS1->GetAngleVector.x ; LS1->GetAngleVector.y
	'
	'Locate  2, 30: Print LS2->GetAngle
	'Locate  4, 30: Print LS2->GetAngularImpulse
	'Locate  6, 30: Print LS2->GetAngularVelocity
	'Locate  8, 30: Print LS2->GetAngularVelocityVector.x ; LS2->GetAngularVelocityVector.y
	'Locate 10, 30: Print LS2->GetAngleVector.x ; LS2->GetAngleVector.y
	
'	Locate  2, 60: Print AS1->RestImpulse_
	
	'FastEllipse( Vec2( 0.0, 0.0 ), Vec2( 400.0, 200.0 ), Vec2( 1.0, 0.0 ), RGB( 32, 128, 32 ) )
	
	For P As KeplerOrbit Ptr = ThisWorld.KeplerOrbits_.p_front To ThisWorld.KeplerOrbits_.p_back
		
		If P->GetFlag( IS_VISIBLE ) Then
				
			P->DrawOrbit()
			
		EndIf
		
	Next
	
	For P As LinearState Ptr = ThisWorld.LinearStates_.p_front To ThisWorld.LinearStates_.p_back
		
		If P->GetFlag( IS_VISIBLE ) Then
				
			Circle( P->GetPosition.x, P->GetPosition.y ), 10.0 , RGB( 128, 128, 128 ),,,1,f
			
		EndIf
		
	Next
	
	For P As AngularState Ptr = ThisWorld.AngularStates_.p_front To ThisWorld.AngularStates_.p_back
		
		If P->GetFlag( IS_VISIBLE ) Then
			
			Circle( P->GetPosition.x, P->GetPosition.y ), 20.0 , RGB( 128, 128, 128 ),,,1,f
			
			Dim As vec2 Angle = P->GetPosition + P->GetAngleVector * 20.0
			
			Line( P->GetPosition.x, P->GetPosition.y )-( Angle.x, Angle.y ), RGB( 255, 255, 0 )
			
		EndIf
		
	Next
	
	'For A As AngularSpring Ptr = ThisWorld.AngularSprings_.p_front To ThisWorld.AngularSprings_.p_back
	'	
	'	Line( A->AngularStateA->Position.x, A->AngularStateA->Position.y )-_
	'	    ( A->AngularStateB->Position.x, A->AngularStateB->Position.y ),  RGB( 0, 255, 255 )
	'	
	'Next
	
	For L As LinearSpring Ptr = ThisWorld.LinearSprings_.p_front To ThisWorld.LinearSprings_.p_back
		
		If L->GetFlag( IS_VISIBLE ) Then
			
			Line( L->GetParticleA->GetPosition.x, L->GetParticleA->GetPosition.y )-_
			    ( L->GetParticleB->GetPosition.x, L->GetParticleB->GetPosition.y ),  RGB( 0, 255, 0 )
			
			Circle( L->GetPosition.x, L->GetPosition.y ), 2.0, RGB( 255, 0, 0 ),,,1,f
			
		EndIf
		
	Next
	
	For F As FixedSpring Ptr = ThisWorld.FixedSprings_.p_front To ThisWorld.FixedSprings_.p_back
		
		If F->GetFlag( IS_VISIBLE ) Then
			
			Line( F->GetParticleA->GetPosition.x, F->GetParticleA->GetPosition.y )-_
			    ( F->GetParticleB->GetPosition.x, F->GetParticleB->GetPosition.y ),  RGB( 255, 0, 255 )
			
			Circle( F->GetPosition.x, F->GetPosition.y ), 2.0, RGB( 255, 0, 0 ),,,1,f
			
		EndIf
		
	Next
	
	For F As NewtonGravity Ptr = ThisWorld.NewtonGravitys_.p_front To ThisWorld.NewtonGravitys_.p_back
		
		If F->GetFlag( IS_VISIBLE ) Then
			
			Line( F->GetParticleA->GetPosition.x, F->GetParticleA->GetPosition.y )-_
			    ( F->GetParticleB->GetPosition.x, F->GetParticleB->GetPosition.y ),  RGB( 255, 0, 255 )
			
			Circle( F->GetPosition.x, F->GetPosition.y ), 2.0, RGB( 128, 0, 128 ),,,1,f
			
		EndIf
		
	Next
	
	For S As SoftBody Ptr = ThisWorld.SoftBodys_.p_front To ThisWorld.SoftBodys_.p_back
		
		If S->GetFlag( IS_VISIBLE ) Then
			
			Dim As Vec2 nrm = S->GetPosition + S->GetAngleVector         * 16
			Dim As Vec2 lft = S->GetPosition + S->GetAngleVector.PerpCCW * 16
			Dim As Vec2 rgt = S->GetPosition + S->GetAngleVector.PerpCW  * 16
			
			Line( S->GetPosition.x, S->GetPosition.y )-( nrm.x, nrm.y ), RGB( 255, 255, 0 )
			Line( S->GetPosition.x, S->GetPosition.y )-( lft.x, lft.y ), RGB( 255, 0, 0 )
			Line( S->GetPosition.x, S->GetPosition.y )-( rgt.x, rgt.y ), RGB( 0, 255, 0 )
			
			Circle( S->GetPosition.x, S->GetPosition.y ), 2.0, RGB( 255, 255, 0 ),,, 1, f
			
		EndIf
			
	Next
	
	For S As ShapeBody Ptr = ThisWorld.ShapeBodys_.p_front To ThisWorld.ShapeBodys_.p_back
		
		If S->GetFlag( IS_VISIBLE ) Then
			
			Dim As Vec2 nrm = S->GetPosition + S->GetAngleVector         * 16
			Dim As Vec2 lft = S->GetPosition + S->GetAngleVector.PerpCCW * 16
			Dim As Vec2 rgt = S->GetPosition + S->GetAngleVector.PerpCW  * 16
			
			Line( S->GetPosition.x, S->GetPosition.y )-( nrm.x, nrm.y ), RGB( 255, 255, 0 )
			Line( S->GetPosition.x, S->GetPosition.y )-( lft.x, lft.y ), RGB( 255, 0, 0 )
			Line( S->GetPosition.x, S->GetPosition.y )-( rgt.x, rgt.y ), RGB( 0, 255, 0 )
			
			Circle( S->GetPosition.x, S->GetPosition.y ), 2.0, RGB( 255, 255, 0 ),,, 1, f
			
		EndIf
			
	Next
	
	'For B As Body Ptr = ThisWorld.Bodys_.p_front To ThisWorld.Bodys_.p_back
	'	
	'	Circle( B->Position.x, B->Position.y ), 3.0, RGB( 0, 255, 0 ),,,1,f
	'	
	'Next
	
	ScreenCopy()
	
	Sleep 1, 1
	
'Loop Until GameJoystick.Button(8)'MultiKey(1)
Loop Until MultiKey(1)
