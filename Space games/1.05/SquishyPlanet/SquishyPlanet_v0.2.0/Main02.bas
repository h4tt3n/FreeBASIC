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
ThisWorld.Particles_.Reserve( 4 )
Thisworld.LinearSprings_.Reserve( 3 )


Dim As Particle Ptr P1 = ThisWorld.Particles_.Push_Back( Particle( 1.0, Vec2( 600,  300) ) )
Dim As Particle Ptr P2 = ThisWorld.Particles_.Push_Back( Particle( 1.0, Vec2( 600,  700) ) )
Dim As Particle Ptr P3 = ThisWorld.Particles_.Push_Back( Particle( 1.0, Vec2( 1000, 300) ) )
Dim As Particle Ptr P4 = ThisWorld.Particles_.Push_Back( Particle( 1.0, Vec2( 1000, 700) ) )


Dim As LinearSpring Ptr S1 = ThisWorld.LinearSprings_.push_Back( LinearSpring( 1.0, 1.0, P1, P2 ) )

S1->ComputeMass()
S1->ComputeReducedMass()
S1->ComputeLengths()
S1->ComputeStateVectors()

Dim As LinearSpring Ptr S2 = ThisWorld.LinearSprings_.push_Back( LinearSpring( 1.0, 1.0, P3, P4 ) )

S2->ComputeMass()
S2->ComputeReducedMass()
S2->ComputeLengths()
S2->ComputeStateVectors()

Dim As LinearSpring Ptr S3 = ThisWorld.LinearSprings_.push_Back( LinearSpring( 1.0, 1.0, S1, S2 ) )

S3->ComputeMass()
S3->ComputeReducedMass()
S3->ComputeLengths()
S3->ComputeStateVectors()

Do
	
	Thisworld.ComputeData()
	
	Thisworld.ApplyWarmStarting()
	
	Thisworld.ApplyImpulses()
	
	ThisWorld.Solver.Solve( ThisWorld.Particles_, ThisWorld.Solver.IM1 )
	
	'ThisWorld.Solver.Solve( ThisWorld.Particles_, ThisWorld.Solver.SE1 )
	
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
		
	ScreenUnLock
	
	Sleep 1, 1
	
Loop Until MultiKey(1)
