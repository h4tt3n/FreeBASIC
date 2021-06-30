''******************************************************************************
''
''   Squishy2D Test program. This is not part of the physics engine.
''
''
''******************************************************************************

Randomize Timer

'' Include the library
#Include "Squishy2D.bi"

#Include "../../Graphics/Screen.bi"

'' Create a World instance
Dim As World ThisWorld

Dim As ScreenType GameScreen

GameScreen.Create()

'' reserve memory
ThisWorld.Particles_.Reserve( 7 )
Thisworld.LinearSprings_.Reserve( 6 )
Thisworld.AngularSprings_.Reserve( 2 )

''
Dim As Particle Ptr P1 = ThisWorld.Particles_.Push_Back( Particle( 1.0 + Rnd() * 9.0, Vec2(  600, 300) ) )
Dim As Particle Ptr P2 = ThisWorld.Particles_.Push_Back( Particle( 1.0 + Rnd() * 9.0, Vec2(  600, 700) ) )
Dim As Particle Ptr P3 = ThisWorld.Particles_.Push_Back( Particle( 1.0 + Rnd() * 9.0, Vec2( 1000, 300) ) )
Dim As Particle Ptr P4 = ThisWorld.Particles_.Push_Back( Particle( 1.0 + Rnd() * 9.0, Vec2( 1000, 700) ) )

''
Dim As LinearSpring Ptr S1 = ThisWorld.LinearSprings_.push_Back( LinearSpring( 1.0, 1.0, P1, P2 ) )
Dim As LinearSpring Ptr S2 = ThisWorld.LinearSprings_.push_Back( LinearSpring( 1.0, 1.0, P3, P4 ) )
Dim As LinearSpring Ptr S3 = ThisWorld.LinearSprings_.push_Back( LinearSpring( 1.0, 1.0, S1, S2 ) )

''
Dim As AngularSpring Ptr A1 = ThisWorld.AngularSprings_.push_back( AngularSpring( 1.0, 1.0, S1, S2 ) )
Dim As AngularSpring Ptr A2 = ThisWorld.AngularSprings_.push_back( AngularSpring( 1.0, 1.0, S2, S3 ) )
Dim As AngularSpring Ptr A3 = ThisWorld.AngularSprings_.push_back( AngularSpring( 1.0, 1.0, S3, S1 ) )


'S3->AngularImpulse( 1.0 )
'S3->ApplyImpulseDispersion()

S2->AngularImpulse( -3.0 )
S2->ApplyImpulseDispersion()

'S1->AngularImpulse( 3.0 )
'S1->ApplyImpulseDispersion()

P1->Position( Vec2( GameScreen.GetWidth, GameScreen.GetHeight ) * 0.5 + Vec2().RandomizeSquare( 500 ) )
P2->Position( Vec2( GameScreen.GetWidth, GameScreen.GetHeight ) * 0.5 + Vec2().RandomizeSquare( 500 ) )
P3->Position( Vec2( GameScreen.GetWidth, GameScreen.GetHeight ) * 0.5 + Vec2().RandomizeSquare( 500 ) )
P4->Position( Vec2( GameScreen.GetWidth, GameScreen.GetHeight ) * 0.5 + Vec2().RandomizeSquare( 500 ) )

Thisworld.ComputeData()

Do
	
	ScreenLock
		
		Cls
		
		For P As Particle Ptr = ThisWorld.Particles_.Front To ThisWorld.Particles_.Back
			
			Circle( P->Position.x, P->Position.y ), 2 + P->Mass, RGB( 128, 128, 128 ),,,1,f
			
		Next
		
		For L As LinearSpring Ptr = ThisWorld.LinearSprings_.Front To ThisWorld.LinearSprings_.Back
			
			Line( L->ParticleA->Position.x, L->ParticleA->Position.y )-_
			    ( L->ParticleB->Position.x, L->ParticleB->Position.y ),  RGB( 0, 255, 0 )
			
			Circle( L->Position.x, L->Position.y ), 2, RGB( 255, 0, 128 ),,,1,f
			
		Next
		
		Locate 2, 2: Print S1->AngularVelocity
		Locate 4, 2: Print S2->AngularVelocity
		Locate 6, 2: Print S3->AngularVelocity
		
	ScreenUnLock
	
	Sleep 1000 * DT
	
	Thisworld.ApplyWarmStart()
	
	Thisworld.ApplyImpulses()
	
	ThisWorld.Solve()
	
	Thisworld.ComputeData()
	
Loop Until MultiKey(1)
