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

'' reserve memory
ThisWorld.Particles_.Reserve( 256 )
Thisworld.AngularSprings_.Reserve( 256 )
Thisworld.LinearSprings_.Reserve( 256 )
Thisworld.ExternalLinearSprings_.Reserve( 256 )
Thisworld.Springbodys_.Reserve( 256 )
Thisworld.Pressurebodys_.Reserve( 256 )

Randomize Timer

''
Dim As SpringBody Ptr SB1 = Thisworld.CreateSpringBody( 16, Vec2( 500, 300 ))
Dim As SpringBody Ptr SB2 = Thisworld.CreateSpringBody( 16, Vec2( 500, 700 ))

'Dim As Particle Ptr P1 = Thisworld.CreateParticle( 1000.0, Vec2( 700, 300 ))

Dim As LinearSpring Ptr L1 = Thisworld.CreateExternalLinearSpring( 0.1, 0.1, ThisWorld.LinearSprings_.Front, ThisWorld.LinearSprings_.Back )
'Dim As LinearSpring Ptr L2 = Thisworld.CreateExternalLinearSpring( 0.1, 0.1, ThisWorld.LinearSprings_.Front, ThisWorld.Springbodys_.Back )

'ThisWorld.Particles_[ 8 ]->velocity( vec2( 2000, 0 ) )

ThisWorld.Springbodys_[0]->AddAngularImpulse( 4.0 )
ThisWorld.Springbodys_[0]->ApplyImpulseDispersion()

Thisworld.ComputeData()

Do
	
	ScreenLock
		
		Cls
		
		For L As AngularSpring Ptr = ThisWorld.AngularSprings_.Front To ThisWorld.AngularSprings_.Back
			
			Line( L->RotateA->Position.x, L->RotateA->Position.y )-_
			    ( L->RotateB->Position.x, L->RotateB->Position.y ),  RGB( 0, 255, 255 )
			
		Next
		
		For P As Particle Ptr = ThisWorld.Particles_.Front To ThisWorld.Particles_.Back
			
			Circle( P->Position.x, P->Position.y ), 3.0 , RGB( 128, 128, 128 ),,,1,f
			
		Next
		
		For L As LinearSpring Ptr = ThisWorld.LinearSprings_.Front To ThisWorld.LinearSprings_.Back
			
			Line( L->ParticleA->Position.x, L->ParticleA->Position.y )-_
			    ( L->ParticleB->Position.x, L->ParticleB->Position.y ),  RGB( 0, 255, 0 )
			
			Circle( L->Position.x, L->Position.y ), 2.0, RGB( 255, 0, 128 ),,,1,f
			
		Next
		
		For P As SpringBody Ptr = ThisWorld.SpringBodys_.Front To ThisWorld.SpringBodys_.Back
			
			Circle( P->Position.x, P->Position.y ), 3.0, RGB( 255, 0, 255 ),,,1,f
			
		Next
		
		For P As PressureBody Ptr = ThisWorld.PressureBodys_.Front To ThisWorld.PressureBodys_.Back
			
			Circle( P->Position.x, P->Position.y ), 3.0, RGB( 0, 255, 0 ),,,1,f
			
		Next
		
	ScreenUnLock
	
	Sleep 1000 * DT
	
	Thisworld.ApplyWarmStart()
	
	Thisworld.ApplyImpulses()
	
	ThisWorld.Solve()
	
	Thisworld.ComputeData()
	
Loop Until MultiKey(1)
