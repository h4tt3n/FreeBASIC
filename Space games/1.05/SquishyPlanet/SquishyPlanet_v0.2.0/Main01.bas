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
ThisWorld.Particles_.Reserve( 50 )
Thisworld.LinearSprings_.Reserve( 50 )
ThisWorld.PressureBodys_.Reserve( 1 )

''	populate array of particles
For i As Integer = 0 To 49
	
	Dim As Particle P = Particle()
	
	P.Mass( 1.0 + Rnd() * 10.0 )
	P.InverseMass( 1.0 / P.Mass )
	P.Position( Vec2( 800, 500 ) + Vec2( 180 * Cos( ( i ) * TWO_PI/50 ), 180 * Sin( ( i ) * TWO_PI/50 ) ))
	'P.Position( Vec2( Rnd() * 1600, Rnd() * 1000 ) )
	'P.Velocity( Vec2().Randomizecircle( 100 ) )
	
	ThisWorld.Particles_.push_back( P )
	
Next

'' create a pressurebody
Dim As PressureBody Ptr PBody1 = ThisWorld.PressureBodys_.push_back( PressureBody() )

PBody1->Particles_.Reserve( 50 )
PBody1->ClosedLoopSprings_.Reserve( 50 )
PBody1->PressureCoeff( 0.01 )

For i As Integer = 0 To 49
	
	Dim As Particle Ptr P = ThisWorld.Particles_[i]
	PBody1->Particles_.push_back( P )
	
Next

''
For i As Integer = 0 To 49
	
	Dim As LinearSpring L = LinearSpring( 1.0, _
	                                      1.0, _
	                                      ThisWorld.Particles_[ i ], _
	                                      ThisWorld.Particles_[ ( i + 1 ) Mod 50 ] )
	
	'L.ComputeMass()
	'L.ComputeInverseMass()
	
	Dim As LinearSpring Ptr P = ThisWorld.LinearSprings_.push_back( L )
	
	PBody1->ClosedLoopSprings_.push_back( P )
	
Next

PBody1->ComputeMass()
PBody1->ComputeStateVectors()
PBody1->ComputeInertia()
Pbody1->ComputeArea()
PBody1->RestArea( Pbody1->Area )

'Dim As LinearSpring Ptr L1 = ThisWorld.LinearSprings_.push_Back( LinearSpring( 0.1, 0.1, (*Pbody1->Particles_.Back ), (*Pbody2->Particles_.Back ) ) )

PBody1->AngularImpulse( 1.0 )
PBody1->ApplyImpulseDispersion()
PBody1->ApplyImpulseConcentration( 1.0 )
PBody1->ApplyImpulseDispersion()
'PBody1->ApplyImpulseConcentration( 1.0 )
'PBody1->ApplyImpulseDispersion()

Thisworld.ComputeData()

Do
	
	ScreenLock
		
		Cls
		
		For P As Particle Ptr = ThisWorld.Particles_.Front To ThisWorld.Particles_.Back
			
			Circle( P->Position.x, P->Position.y ), 2 + P->Mass, RGB( 128, 128, 128 ),,,1,f
			
		Next
		
		For B As PressureBody Ptr = ThisWorld.PressureBodys_.Front To ThisWorld.PressureBodys_.Back
			
			Circle( B->Position.x, B->Position.y ), 4, RGB( 255, 0, 128 ),,,1,f
			
		Next
		
		For L As LinearSpring Ptr = ThisWorld.LinearSprings_.Front To ThisWorld.LinearSprings_.Back
			
			Line( L->ParticleA->Position.x, L->ParticleA->Position.y )-_
			    ( L->ParticleB->Position.x, L->ParticleB->Position.y ),  RGB( 0, 255, 0 )
			
			Circle( L->Position.x, L->Position.y ), 2, RGB( 255, 0, 128 ),,,1,f
			
		Next

		Locate  6, 2: Print PBody1->RestArea
		Locate  8, 2: Print PBody1->Area
		Locate 10, 2: Print PBody1->AngularVelocity
		
	ScreenUnLock
	
	Thisworld.ApplyWarmStart()
	
	Thisworld.ApplyImpulses()
	
	ThisWorld.Solve()
	
	Thisworld.ComputeData()
	
	Sleep 1, 1
	
Loop Until MultiKey(1)
