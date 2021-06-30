''******************************************************************************
''    
''  Graveyard Orbit - A 2D space physics puzzle game
''
''  Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''  Version 0.1.0, November 1. 2016
''  
''  Author:
''  Michael "h4tt3n" Schmidt Nissen, michaelschmidtnissen@gmail.com
''    
''******************************************************************************


''
#Ifndef __GO_PUZZLES_BI__
#Define __GO_PUZZLES_BI__


''
Sub Game.Puzzle1()
	
	'' Two simple orbits showing different eccentricities
	
	ResetAll()
	
	World_description_ = "World 1: Two moon orbits with different eccentricity. Same semimajor axis means same orbital period."
	
	Puzzle_description_ = "Puzzle: Make the ship orbit the plants and moons."
	
	Dim As RigidBody Ptr Rigid1 = GameWorld.CreateRigidBody( 128, 256, Vec2( 0.0, 0.0 ) )
	'Dim As SoftBody Ptr Rigid1 = GameWorld.CreateSoftBody( 64, 256, Vec2( 0.0, -500.0 ) )
	'Dim As RigidBody Ptr Rigid2 = GameWorld.CreateRigidBody(  64,  64, Vec2( 0.0,  500.0 ) )
	'
	Rigid1->SetVelocity( Vec2( 10.0, 0.0 ) )
	Rigid1->SetAngularVelocity( 0.2 )
	'Rigid2->SetAngularVelocity( -0.2 )
	
	'Dim As LinearState Ptr LS1 = *(Rigid1->LinearStates_[0])
	
	'LS1->SetImpulse( Vec2( 100.0, 0.0 ) )
	'Rigid1->SetVelocity( Vec2( 10.0, 0.0 ) )
	
	'Dim As LinearSpring Ptr L1 = GameWorld.CreateLinearSpring( 0.01, 0.01, 0.0, Rigid1, *Rigid2->LinearStates_[1] )
	'Dim As LinearSpring Ptr L2 = GameWorld.CreateLinearSpring( 0.01, 0.01, 0.0, Rigid2, *Rigid1->LinearStates_[1] )
	
	''
	Dim As Planet Ptr P1 = CreatePlanet( 4E7, 1000.0 )
	Dim As Planet Ptr P2 = CreatePlanet( 1E7, 1000.0 )
	Dim As Planet Ptr P3 = CreatePlanet( 4E7, 1000.0 )
	Dim As Planet Ptr P4 = CreatePlanet( 1E7, 1000.0 )
	
	P1->SetColour( RGB( 136, 128, 120 ) )
	P2->SetColour( RGB( 192, 192, 192 ) )
	P3->SetColour( RGB( 136, 128, 120 ) )
	P4->SetColour( RGB( 192, 192, 192 ) )
	
	''
	Dim As Rocket Ptr R1 = CreateRocket( 50.0, 10000.0, 0.1, Vec2( 0.0, 0.0 ) )
	
	'Rocket1->SetAngle( 0.5 * TWO_PI )
	'Rocket1->ApplyDeltaV( 2000.42 )
	R1->ApplyFuelMass( 20.00 )
	
	''
	Dim As KeplerOrbit Ptr K1 = GameWorld.CreateKeplerOrbit( P1, P2 )
	Dim As KeplerOrbit Ptr K2 = GameWorld.CreateKeplerOrbit( P3, P4 )
	
	''
	k1->ApplyOrbit( Vec2( -1200.0,    0.0 ), 0.0, 1200, -0.25 * TWO_PI, 0.5 * TWO_PI, CCW )
	k2->ApplyOrbit( Vec2(  1200.0, -400.0 ), 0.5, 1200, -0.25 * TWO_PI, 0.5 * TWO_PI, CCW )
	
	'Dim As LinearSpring Ptr L1 = GameWorld.CreateLinearSpring( 0.00, 0.01, 0.0, *Rigid1->LinearStates_[1], P1 )
	'Dim As LinearSpring Ptr L1 = GameWorld.CreateLinearSpring( 1.0, 1.0, 1.0, R1, *Rigid1->LinearStates_[1] )

	''
	GameWorld.CreateNewtonGravity( P1, P2 )
	GameWorld.CreateNewtonGravity( P3, P4 )
	
	''
	GameWorld.CreateNewtonGravity( P1, R1 )
	GameWorld.CreateNewtonGravity( P2, R1 )
	GameWorld.CreateNewtonGravity( P3, R1 )
	GameWorld.CreateNewtonGravity( P4, R1 )
	
		''
	'GameWorld.CreateNewtonGravity( P1, Rigid1 )
	'GameWorld.CreateNewtonGravity( P2, Rigid1 )
	'GameWorld.CreateNewtonGravity( P3, Rigid1 )
	'GameWorld.CreateNewtonGravity( P4, Rigid1 )
	'
	''
	GameWorld.ComputeData()
	ComputeData()
	
	GameCamera.Zoom( CAMERA_ZOOM_MAX )
	GameCamera.RestZoom( 5.0 )
	GameCamera.RestPosition( Vec2( 0.0, 0.0 ) )
	
End Sub

Sub Game.Puzzle2()
	
	'' 
	
	ResetAll()
	
	''
	World_description_ = "World 2: "
	
	Puzzle_description_ = "Puzzle: "
	
	''
	Dim As Planet Ptr P1 = CreatePlanet( 5E7, 1000.0 )
	Dim As Planet Ptr P2 = CreatePlanet( 3E7, 1000.0 )
	Dim As Planet Ptr P3 = CreatePlanet( 4E7, 1000.0 )
	
	P1->SetColour( RGB( 136, 128, 120 ) )
	P2->SetColour( RGB( 136, 128, 120 ) )
	P3->SetColour( RGB( 136, 128, 120 ) )
	
	''
	Dim As Rocket Ptr R1 = CreateRocket( 30.0, 20000.0, 0.2, Vec2( 0.0, 0.0 ) )
	
	R1->ApplyFuelMass( 30.00 )
	
	''
	Dim As KeplerOrbit Ptr K1 = GameWorld.CreateKeplerOrbit( P1, P2 )
	Dim As KeplerOrbit Ptr K2 = GameWorld.CreateKeplerOrbit( K1, P3 )
	
	''
	K1->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0,  2000.0, 0.0 * TWO_PI, 0.25 * TWO_PI, CCW )
	K2->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0,  7000.0, 0.0 * TWO_PI, 0.5 * TWO_PI,  CW )
'	K3->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 12000.0, 0.0 * TWO_PI, 0.75 * TWO_PI, CCW )
	'K4->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 12000.0, 0.0 * TWO_PI, 0.5 * TWO_PI,  CW )
	
	''
	GameWorld.CreateNewtonGravity( P1, P2 ) 
	GameWorld.CreateNewtonGravity( P1, P3 )
	GameWorld.CreateNewtonGravity( P2, P3 )
	
	''
	GameWorld.CreateNewtonGravity( P1, R1 )
	GameWorld.CreateNewtonGravity( P2, R1 )
	GameWorld.CreateNewtonGravity( P3, R1 )
	
	'Dim As NewtonGravity Ptr N7  = GameWorld.CreateNewtonGravity( P1, R1 )
	'Dim As NewtonGravity Ptr N8  = GameWorld.CreateNewtonGravity( P2, R1 )
	'Dim As NewtonGravity Ptr N9  = GameWorld.CreateNewtonGravity( P3, R1 )
	'Dim As NewtonGravity Ptr N10 = GameWorld.CreateNewtonGravity( P4, R1 )
	
	Dim As SoftBody Ptr GA1 = CreateArchedGirder( Vec2( 24, 2 ), Vec2( 64, 64 ), 0.125 * TWO_PI, 3000, K_TRUSS )
	
	'Dim As SoftBody Ptr G1 = CreateGirder( Vec2( 0.0,   0.0 ), Vec2( Cos(0.0), Sin(0.0) ), Vec2( 32, 2 ), Vec2( 64, 64 ), S_TRUSS ) 
	'Dim As SoftBody Ptr G2 = CreateGirder( Vec2( 0.0, 100.0 ), Vec2( Cos(0.0), Sin(0.0) ), Vec2( 32, 2 ), Vec2( 64, 64 ), Z_TRUSS ) 
	'Dim As SoftBody Ptr G3 = CreateGirder( Vec2( 0.0, 200.0 ), Vec2( Cos(0.0), Sin(0.0) ), Vec2( 16, 2 ), Vec2( 128, 64 ), V_TRUSS ) 
	'Dim As SoftBody Ptr G4 = CreateGirder( Vec2( 0.0, 300.0 ), Vec2( Cos(0.0), Sin(0.0) ), Vec2( 16, 2 ), Vec2( 128, 64 ), X_TRUSS ) 
	'Dim As SoftBody Ptr G5 = CreateGirder( Vec2( 0.0, 400.0 ), Vec2( Cos(0.0), Sin(0.0) ), Vec2( 16, 2 ), Vec2( 96, 64 ), K_TRUSS ) 
	'Dim As SoftBody Ptr G6 = CreateGirder( Vec2( 0.0, 500.0 ), Vec2( Cos(0.0), Sin(0.0) ), Vec2( 32, 2 ), Vec2( 64, 64 ), O_TRUSS ) 
	 
	
	
	'G7->SetPosition( Vec2( 0.0, 0.0) )
	'G7->SetAngle( 0.0 * TWO_PI )
	'G7->ComputeAngleVector()
	
	'Dim As LinearSpring Ptr L1 = GameWorld.CreateLinearSpring( 0.01, 0.01, 0.0, R1, *GA1->LinearStates_[0] )
	
	'GA1->AddAngularVelocity( 0.01 )
	'
	'G1->AddAngularVelocity( 0.01 )
	'G2->AddAngularVelocity( -0.01 )
	'G3->AddAngularVelocity( 0.01 )
	'G4->AddAngularVelocity( -0.01 )
	'G5->AddAngularVelocity( 0.01 )
	'G6->AddAngularVelocity( -0.01 )
	'G7->AddAngularVelocity( 0.01 )
	'
	''
	GameWorld.ComputeData()
	ComputeData()
	
	GameCamera.Zoom( CAMERA_ZOOM_MAX )
	GameCamera.RestZoom( 20.0 )
	GameCamera.RestPosition( Vec2( 0.0, 0.0 ) )
	
End Sub

Sub Game.Puzzle3()
	
	ResetAll()
	
''
	World_description_ = "World 3: "
	
	Puzzle_description_ = "Puzzle: "
	
	''
	Dim As Planet Ptr P1 = CreatePlanet( 1E9, 1e3 )
	Dim As Planet Ptr P2 = CreatePlanet( 1E-9, 2E-14 )
	Dim As Planet Ptr P3 = CreatePlanet( 1E-9, 2E-14 )
	Dim As Planet Ptr P4 = CreatePlanet( 1E-9, 2E-14 )
	Dim As Planet Ptr P5 = CreatePlanet( 1E-9, 2E-14 )
	Dim As Planet Ptr P6 = CreatePlanet( 1E-9, 2E-14 )
	Dim As Planet Ptr P7 = CreatePlanet( 1E-9, 2E-14 )
	Dim As Planet Ptr P8 = CreatePlanet( 1E-9, 2E-14 )
	Dim As Planet Ptr P9 = CreatePlanet( 1E-9, 2E-14 )

	
	P1->SetColour( RGB( 136, 128, 120 ) )
	P2->SetColour( RGB( 255,  64,  64 ) )
	P3->SetColour( RGB( 255, 255,  64 ) )
	P4->SetColour( RGB(  64, 255,  64 ) )
	P5->SetColour( RGB( 255,  64, 255 ) )
	P6->SetColour( RGB( 255,  64,  64 ) )
	P7->SetColour( RGB( 255, 255,  64 ) )
	P8->SetColour( RGB(  64, 255,  64 ) )
	P9->SetColour( RGB( 255, 64,  255 ) )
	
	''
	Dim As Rocket Ptr R1 = CreateRocket( 30.0, 20000.0, 0.2, Vec2( 0.0, 0.0 ) )
	
	R1->ApplyFuelMass( 30.00 )
	
	'Dim As SoftBody Ptr G1 = CreateGirder( Vec2( 32, 2 ), Vec2( 64, 64 ), S_TRUSS ) 
	
	'Dim As SoftBody Ptr G1 = CreateArchedGirder( Vec2( 0.0, 0.0 ), 0.125  * TWO_PI, Vec2( 32, 2 ), _
	'                                             Vec2( 64.0, 64.0 ), 0.25 * TWO_PI, 4500, X_TRUSS )
	
	'Dim As SoftBody Ptr G2 = CreateArchedGirder( Vec2( 0.0, 0.0 ), 0.375  * TWO_PI, Vec2( 32, 2 ), _
	'                                             Vec2( 64.0, 64.0 ), 0.25 * TWO_PI, 4500, X_TRUSS )
	
	'Dim As SoftBody Ptr G3 = CreateArchedGirder( Vec2( 0.0, 0.0 ), 0.625  * TWO_PI, Vec2( 32, 2 ), _
	'                                             Vec2( 64.0, 64.0 ), 0.25 * TWO_PI, 4500, X_TRUSS )
	
	''
	Dim As KeplerOrbit Ptr K1 = GameWorld.CreateKeplerOrbit( P1, P2 )
	Dim As KeplerOrbit Ptr K2 = GameWorld.CreateKeplerOrbit( P1, P3 )
	Dim As KeplerOrbit Ptr K3 = GameWorld.CreateKeplerOrbit( P1, P4 )
	Dim As KeplerOrbit Ptr K4 = GameWorld.CreateKeplerOrbit( P1, P5 )
	Dim As KeplerOrbit Ptr K5 = GameWorld.CreateKeplerOrbit( P1, P6 )
	Dim As KeplerOrbit Ptr K6 = GameWorld.CreateKeplerOrbit( P1, P7 )
	Dim As KeplerOrbit Ptr K7 = GameWorld.CreateKeplerOrbit( P1, P8 )
	Dim As KeplerOrbit Ptr K8 = GameWorld.CreateKeplerOrbit( P1, P9 )
	
	''
	K1->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.5, 3000.0, 0.0 * TWO_PI, 0.0   * TWO_PI, CW )
	K2->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.5, 3000.0, 0.0 * TWO_PI, 0.125 * TWO_PI, CW )
	K3->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.5, 3000.0, 0.0 * TWO_PI, 0.25  * TWO_PI, CW )
	K4->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.5, 3000.0, 0.0 * TWO_PI, 0.375 * TWO_PI, CW )
	K5->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.5, 3000.0, 0.0 * TWO_PI, 0.5   * TWO_PI, CW )
	K6->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.5, 3000.0, 0.0 * TWO_PI, 0.625 * TWO_PI, CW )
	K7->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.5, 3000.0, 0.0 * TWO_PI, 0.75  * TWO_PI, CW )
	K8->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.5, 3000.0, 0.0 * TWO_PI, 0.875 * TWO_PI, CW )
	
	''
	K2->LowerFlag( IS_VISIBLE )
	K3->LowerFlag( IS_VISIBLE )
	K4->LowerFlag( IS_VISIBLE )
	K5->LowerFlag( IS_VISIBLE )
	K6->LowerFlag( IS_VISIBLE )
	K7->LowerFlag( IS_VISIBLE )
	K8->LowerFlag( IS_VISIBLE )
	
	''
	GameWorld.CreateNewtonGravity( P1, P2 )
	GameWorld.CreateNewtonGravity( P1, P3 )
	GameWorld.CreateNewtonGravity( P1, P4 )
	GameWorld.CreateNewtonGravity( P1, P5 )
	GameWorld.CreateNewtonGravity( P1, P6 )
	GameWorld.CreateNewtonGravity( P1, P7 )
	GameWorld.CreateNewtonGravity( P1, P8 )
	GameWorld.CreateNewtonGravity( P1, P9 )

'	Dim As LinearSpring Ptr L1 = GameWorld.CreateLinearSpring( 0.01, 0.01, 0.0, R1, *G1->LinearStates_[0] )
	
	'K2->ComputePeriod( K2->GravParam, K2->SemimajorAxis )
	'G1->AddAngularImpulse( TWO_PI / K2->Period * -K2->OrbitDirection )
	
	'K3->ComputePeriod( K3->GravParam, K3->SemimajorAxis )
	'G2->AddAngularImpulse( TWO_PI / K3->Period * -K3->OrbitDirection )
	
	'K4->ComputePeriod( K4->GravParam, K4->SemimajorAxis )
	'G3->AddAngularImpulse( TWO_PI / K4->Period * -K4->OrbitDirection )
	
	''
	GameWorld.ComputeData()
	ComputeData()
	
	GameCamera.Zoom( CAMERA_ZOOM_MAX )
	GameCamera.RestZoom( 12.0 )
	GameCamera.RestPosition( Vec2( -1000.0, 1000.0 ) )
	
End Sub

Sub Game.Puzzle4()
	
	'' Concentrical orbits. Each planet orbits not only the central sun but 
	'' the center of mass of the sun and all closer planets.
	
	''
	ResetAll()
	
	''
	World_description_ = "World 4: "
	
	Puzzle_description_ = "Puzzle: "
	
	''
	'' Planets
	Dim As Planet Ptr P1 = CreatePlanet( 8E8, 1000.0 )
	Dim As Planet Ptr P2 = CreatePlanet( 4E8, 1000.0 )
	Dim As Planet Ptr P3 = CreatePlanet( 2E8, 1000.0 )
	Dim As Planet Ptr P4 = CreatePlanet( 1E8, 1000.0 )
	
	''
	P1->SetColour( RGB( 255, 244, 192 ) )
	P2->SetColour( RGB( 136, 128, 120 ) )
	P3->SetColour( RGB( 136, 128, 120 ) )
	P4->SetColour( RGB( 136, 128, 120 ) )

	'' Rocket
	Dim As Rocket Ptr R1 = CreateRocket( 50.0, 20000.0, 0.2, Vec2( 0.0, 0.0 ) )
	
	R1->ApplyFuelMass( 20.00 )
	R1->SetPosition( Vec2(-5000.0, 0.0) )
	
	'' Kepler Orbits
	Dim As KeplerOrbit Ptr K1 = GameWorld.CreateKeplerOrbit( P1, P2 )
	Dim As KeplerOrbit Ptr K2 = GameWorld.CreateKeplerOrbit( K1, P3 )
	Dim As KeplerOrbit Ptr K3 = GameWorld.CreateKeplerOrbit( K2, P4 )
	
	''
	K1->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0,  2000, 0.0 * TWO_PI, 0.0  * TWO_PI, CW )
	K2->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0,  4000, 0.0 * TWO_PI, 0.33 * TWO_PI, CW )
	K3->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 8000, 0.0 * TWO_PI, 0.66 * TWO_PI, CW )
	
	'' Newton gravity
	GameWorld.CreateNewtonGravity( P1, P2 )
	GameWorld.CreateNewtonGravity( K1, P3 )
	GameWorld.CreateNewtonGravity( K2, P4 )
	
	'GameWorld.CreateNewtonGravity( P1, P2 )
	'GameWorld.CreateNewtonGravity( P1, P3 )
	'GameWorld.CreateNewtonGravity( P1, P4 )
	'GameWorld.CreateNewtonGravity( P2, P3 )
	'GameWorld.CreateNewtonGravity( P2, P4 )
	'GameWorld.CreateNewtonGravity( P3, P4 )
	
	''
	GameWorld.CreateNewtonGravity( P1, R1 )
	GameWorld.CreateNewtonGravity( P2, R1 )
	GameWorld.CreateNewtonGravity( P3, R1 )
	GameWorld.CreateNewtonGravity( P4, R1 )
	
	''
	GameWorld.ComputeData()
	ComputeData()
	
	GameCamera.Zoom( CAMERA_ZOOM_MAX )
	GameCamera.RestZoom( 40.0 )
	GameCamera.RestPosition( Vec2( 0.0, 0.0 ) )
	
End Sub

Sub Game.Puzzle5()
	
	''
	ResetAll()
		
	''
	World_description_ = "World 5: Triple nested orbits. "
	
	Puzzle_description_ = "Puzzle: "
	
	
	'' Planets
	Dim As Planet Ptr P1 = CreatePlanet( 1E8, 1000.0 )
	Dim As Planet Ptr P2 = CreatePlanet( 1E8, 1000.0 )
	Dim As Planet Ptr P3 = CreatePlanet( 2E8, 1000.0 )
	Dim As Planet Ptr P4 = CreatePlanet( 4E8, 1000.0 )
	Dim As Planet Ptr P5 = CreatePlanet( 8E8, 1000.0 )
	
	''
	P1->SetColour( RGB( 255, 244, 192 ) )
	P2->SetColour( RGB( 136, 128, 120 ) )
	P3->SetColour( RGB( 136, 128, 120 ) )
	P4->SetColour( RGB( 136, 128, 120 ) )
	
	'' Rocket
	Dim As Rocket Ptr R1 = CreateRocket( 50.0, 20000.0, 0.2, Vec2( 0.0, 0.0 ) )
	
	R1->ApplyFuelMass( 20.00 )
	
	'' Kepler Orbits
	Dim As KeplerOrbit Ptr K1 = GameWorld.CreateKeplerOrbit( P1, P2 )
	Dim As KeplerOrbit Ptr K2 = GameWorld.CreateKeplerOrbit( K1, P3 )
	Dim As KeplerOrbit Ptr K3 = GameWorld.CreateKeplerOrbit( K2, P4 )
	Dim As KeplerOrbit Ptr K4 = GameWorld.CreateKeplerOrbit( K3, P5 )
	
	''
	K1->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0,  2000, 0.0 * TWO_PI, 0.0 * TWO_PI, CW )
	K2->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0,  4000, 0.0 * TWO_PI, 0.33 * TWO_PI, CCW )
	K3->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0,  8000, 0.0 * TWO_PI, 0.66 * TWO_PI, CW )
	K4->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 16000, 0.0 * TWO_PI, 0.66 * TWO_PI, CW )
	
	'' Newton gravity
	GameWorld.CreateNewtonGravity( P1, P2 )
	GameWorld.CreateNewtonGravity( K1, P3 )
	GameWorld.CreateNewtonGravity( K2, P4 )
	GameWorld.CreateNewtonGravity( K3, P5 )
	
	'GameWorld.CreateNewtonGravity( P1, P2 )
	'GameWorld.CreateNewtonGravity( P1, P3 )
	'GameWorld.CreateNewtonGravity( P1, P4 )
	'GameWorld.CreateNewtonGravity( P1, P5 )
	'GameWorld.CreateNewtonGravity( P2, P3 )
	'GameWorld.CreateNewtonGravity( P2, P4 )
	'GameWorld.CreateNewtonGravity( P2, P5 )
	'GameWorld.CreateNewtonGravity( P3, P4 )
	'GameWorld.CreateNewtonGravity( P3, P5 )
	'GameWorld.CreateNewtonGravity( P4, P5 )
	
	''
	GameWorld.CreateNewtonGravity( P1, R1 )
	GameWorld.CreateNewtonGravity( P2, R1 )
	GameWorld.CreateNewtonGravity( P3, R1 )
	GameWorld.CreateNewtonGravity( P4, R1 )
	GameWorld.CreateNewtonGravity( P5, R1 )
	
	''
	GameWorld.ComputeData()
	ComputeData()
	
	GameCamera.Zoom( CAMERA_ZOOM_MAX )
	GameCamera.RestZoom( 40.0 )
	GameCamera.RestPosition( Vec2( 0.0, 0.0 ) )
	
End Sub

Sub Game.Puzzle6()
	
	''
	ResetAll()
	
	''
	World_description_ = "World 6: "
	
	Puzzle_description_ = "Puzzle: "
	
	'Dim As SoftBody Ptr G1 = CreateGirder( Vec2( 32, 4 ), Vec2( 64, 64 ), S_TRUSS ) 
	'Dim As SoftBody Ptr G2 = CreateGirder( Vec2( 32, 4 ), Vec2( 128, 64 ), Z_TRUSS ) 
	'Dim As SoftBody Ptr G3 = CreateGirder( Vec2( 32, 4 ), Vec2( 128, 64 ), V_TRUSS ) 
	'Dim As SoftBody Ptr G4 = CreateGirder( Vec2( 32, 2 ), Vec2( 128, 64 ), X_TRUSS ) 
	'Dim As SoftBody Ptr G5 = CreateGirder( Vec2( 32, 2 ), Vec2( 96, 64 ), K_TRUSS ) 
	'Dim As SoftBody Ptr G6 = CreateGirder( Vec2( 32, 2 ), Vec2( 128, 64 ), O_TRUSS ) 
	
	'Dim As SoftBody Ptr G7 = CreateStrongGirder( Vec2( 32, 6 ), Vec2( 64, 64 ), X_TRUSS ) 
	
	'Dim As SoftBody Ptr G10 = CreateArchedGirder( Vec2( 24, 2 ), Vec2( 96.0, 64.0 ), 1.0 * TWO_PI, 500, S_TRUSS )
	'Dim As SoftBody Ptr G11 = CreateArchedGirder( Vec2( 24, 2 ), Vec2( 96.0, 64.0 ), 0.875 * TWO_PI, 500, Z_TRUSS )
	Dim As SoftBody Ptr G12 = CreateArchedGirder( Vec2( 24, 2 ), Vec2( 96.0, 64.0 ), 0.5 * TWO_PI, 500, V_TRUSS )
	Dim As SoftBody Ptr G13 = CreateArchedGirder( Vec2( 24, 2 ), Vec2( 96.0, 64.0 ), 0.5 * TWO_PI, 500, X_TRUSS )
	Dim As SoftBody Ptr G14 = CreateArchedGirder( Vec2( 24, 2 ), Vec2( 96.0, 64.0 ), 0.5 * TWO_PI, 500, K_TRUSS )
	Dim As SoftBody Ptr G15 = CreateArchedGirder( Vec2( 24, 2 ), Vec2( 96.0, 64.0 ), 0.5 * TWO_PI, 500, O_TRUSS )
	
	'G1->SetPosition( Vec2().RandomizeSquare( 2000.0 ) )
	'G2->SetPosition( Vec2().RandomizeSquare( 2000.0 ) )
	'G3->SetPosition( Vec2().RandomizeSquare( 2000.0 ) )
	'G4->SetPosition( Vec2().RandomizeSquare( 2000.0 ) )
	'G5->SetPosition( Vec2().RandomizeSquare( 2000.0 ) )
	'G6->SetPosition( Vec2().RandomizeSquare( 2000.0 ) )
	
	'G7->SetPosition( Vec2().RandomizeSquare( 2000.0 ) )
	
	'G10->SetPosition( Vec2().RandomizeSquare( 3000.0 ) )
	'G11->SetPosition( Vec2().RandomizeSquare( 3000.0 ) )
	G12->SetPosition( Vec2().RandomizeSquare( 3000.0 ) )
	G13->SetPosition( Vec2().RandomizeSquare( 3000.0 ) )
	G14->SetPosition( Vec2().RandomizeSquare( 3000.0 ) )
	G15->SetPosition( Vec2().RandomizeSquare( 3000.0 ) )
	
	'G1->AddAngularVelocity( 0.02 )
	'G2->AddAngularVelocity( -0.03 )
	'G3->AddAngularVelocity( 0.04 )
	'G4->AddAngularVelocity( -0.05 )
	'G5->AddAngularVelocity( 0.06 )
	'G6->AddAngularVelocity( -0.07 )
	'
	'G10->AddAngularVelocity( -0.1 )
	'G11->AddAngularVelocity( 0.05 )
	'G12->AddAngularVelocity( 0.02 )
	'G13->AddAngularVelocity( 0.02 )
	'G14->AddAngularVelocity( 0.02 )
	'G15->AddAngularVelocity( 0.02 )
	
	
	'' Planets
	Dim As Planet Ptr P1 = CreatePlanet( 1E5, 1.0 )
	Dim As Planet Ptr P2 = CreatePlanet( 2E5, 1.0 )
	Dim As Planet Ptr P3 = CreatePlanet( 4E5, 1.0 )
	Dim As Planet Ptr P4 = CreatePlanet( 8E5, 1.0 )
	
	''
	P1->SetColour( RGB( 255, 244, 192 ) )
	P2->SetColour( RGB( 136, 128, 120 ) )
	P3->SetColour( RGB( 136, 128, 120 ) )
	P4->SetColour( RGB( 136, 128, 120 ) )
	
	'' Rocket
	Dim As Rocket Ptr R1 = CreateRocket( 50.0, 20000.0, 0.2, Vec2( 0.0, 0.0 ) )
	
	R1->ApplyFuelMass( 20.00 )
	
	'' Kepler Orbits
	Dim As KeplerOrbit Ptr K1 = GameWorld.CreateKeplerOrbit( P1, P2 )
	Dim As KeplerOrbit Ptr K2 = GameWorld.CreateKeplerOrbit( K1, P3 )
	Dim As KeplerOrbit Ptr K3 = GameWorld.CreateKeplerOrbit( K2, P4 )
	
	''
	K1->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0,  1000, 0.0 * TWO_PI, 0.0 * TWO_PI, CW )
	K2->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0,  4000, 0.0 * TWO_PI, 0.33 * TWO_PI, CCW )
	K3->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 16000, 0.0 * TWO_PI, 0.66 * TWO_PI, CW )
	
	'' Newton gravity
	GameWorld.CreateNewtonGravity( P1, P2 )
	GameWorld.CreateNewtonGravity( P1, P3 )
	GameWorld.CreateNewtonGravity( P1, P4 )
	GameWorld.CreateNewtonGravity( P2, P3 )
	GameWorld.CreateNewtonGravity( P2, P4 )
	GameWorld.CreateNewtonGravity( P3, P4 )
	
	'Dim As LinearSpring Ptr L1 = GameWorld.CreateLinearSpring( 0.01, 0.01, 0.0, R1, *G5->LinearStates_[0] )
	
	''
	GameWorld.ComputeData()
	ComputeData()
	
	GameCamera.Zoom( CAMERA_ZOOM_MAX )
	GameCamera.RestZoom( 10.0 )
	GameCamera.RestPosition( Vec2( 0.0, 0.0 ) )
	
End Sub

Sub Game.Puzzle7()
	
	''
	ResetAll()
	
	''
	World_description_ = "World 7: "
	
	Puzzle_description_ = "Puzzle: "
	
	'' Planets
	Dim As Planet Ptr P1 = CreatePlanet( 1E9, 1000.0 )
	
	''
	P1->SetColour( RGB( 255, 244, 192 ) )
	
	'' Rocket
	Dim As Rocket Ptr R1 = CreateRocket( 50.0, 50000.0, 0.2, Vec2( -6000.0, 2000.0 ) )
	
	R1->ApplyFuelMass( 20.00 )
	
	'' Newton gravity
	
	'Dim As SoftBody Ptr Asteroids1 = CreateAsteroidBelt( P1, 256, Vec2( 0.6, 0.7 ), Vec2( 7000.0, 8000.0 ), Vec2( -0.3, -0.3 ), CCW )
	Dim As SoftBody Ptr Asteroids2 = CreateAsteroidBelt( P1, 500, Vec2( 0.7, 0.7 ), Vec2( 3000.0, 6000.0 ), Vec2( -0.05, -0.05 ) * TWO_PI, CCW )
	
	'Asteroids->AddPosition( Vec2( -5000.0, 0.0 ) )
	'Asteroids2->AddImpulse( Vec2( 100.0, 0.0 ) )
	
	'GameWorld.CreateNewtonGravity( P1, R1 )
	
	''
	GameWorld.ComputeData()
	ComputeData()
	
	GameCamera.Zoom( CAMERA_ZOOM_MAX )
	GameCamera.RestZoom( 20.0 )
	GameCamera.RestPosition( Vec2( 0.0, 0.0 ) )
	
End Sub

Sub Game.Puzzle8()
	
	''
	ResetAll()
	
	''
	World_description_ = "World 8: "
	
	Puzzle_description_ = "Puzzle: "
		
	'' Planets
	Dim As Planet Ptr P1 = CreatePlanet( 1E5, 1.0 )
	Dim As Planet Ptr P2 = CreatePlanet( 2E5, 1.0 )
	Dim As Planet Ptr P3 = CreatePlanet( 4E5, 1.0 )
	Dim As Planet Ptr P4 = CreatePlanet( 8E5, 1.0 )
	
	''
	P1->SetColour( RGB( 255, 244, 192 ) )
	P2->SetColour( RGB( 136, 128, 120 ) )
	P3->SetColour( RGB( 136, 128, 120 ) )
	P4->SetColour( RGB( 136, 128, 120 ) )
	
	'' Rocket
	Dim As Rocket Ptr R1 = CreateRocket( 50.0, 50000.0, 0.2, Vec2( 0.0, 0.0 ) )
	
	R1->ApplyFuelMass( 20.00 )
	
	'' Kepler Orbits
	Dim As KeplerOrbit Ptr K1 = GameWorld.CreateKeplerOrbit( P1, P2 )
	Dim As KeplerOrbit Ptr K2 = GameWorld.CreateKeplerOrbit( K1, P3 )
	Dim As KeplerOrbit Ptr K3 = GameWorld.CreateKeplerOrbit( K2, P4 )
	
	''
	K1->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0,  1000, 0.0 * TWO_PI, 0.0  * TWO_PI, CW )
	K2->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0,  4000, 0.0 * TWO_PI, 0.33 * TWO_PI, CCW )
	K3->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 16000, 0.0 * TWO_PI, 0.66 * TWO_PI, CW )
	
	'' Newton gravity
	GameWorld.CreateNewtonGravity( P1, P2 )
	GameWorld.CreateNewtonGravity( P1, P3 )
	GameWorld.CreateNewtonGravity( P1, P4 )
	GameWorld.CreateNewtonGravity( P2, P3 )
	GameWorld.CreateNewtonGravity( P2, P4 )
	GameWorld.CreateNewtonGravity( P3, P4 )
	
	''
	GameWorld.ComputeData()
	ComputeData()
	
	GameCamera.Zoom( CAMERA_ZOOM_MAX )
	GameCamera.RestZoom( 40.0 )
	GameCamera.RestPosition( Vec2( 0.0, 0.0 ) )
	
End Sub

Sub Game.Puzzle9()
	
	''
	ResetAll()
	
	''
	World_description_ = "World 9: "
	
	Puzzle_description_ = "Puzzle: "
	
	'' Planets
	Dim As Planet Ptr P1 = CreatePlanet( 1E11, 10000.0 )
	Dim As Planet Ptr P2 = CreatePlanet( 1E8, 1000.0 )

	''
	P1->SetColour( RGB( 0, 0, 0 ) )
	P2->SetColour( RGB( 136, 128, 120 ) )
	
	'' Rocket
	Dim As Rocket Ptr R1 = CreateRocket( 50.0, 20000.0, 0.1, Vec2( 2000.0, 500.0 ) )
	
	R1->ApplyFuelMass( 20.00 )
	
	'' Kepler Orbits
	Dim As KeplerOrbit Ptr K1 = GameWorld.CreateKeplerOrbit( P1, P2 )
	Dim As KeplerOrbit Ptr K2 = GameWorld.CreateKeplerOrbit( K1, R1 )
	
	''
	K1->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 12000, -0.125 * TWO_PI, 0.3 * TWO_PI, CCW )
	K2->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 4000, 0.0 * TWO_PI, 0.0 * TWO_PI, CCW )
	
	K2->LowerFlag( IS_VISIBLE )
	
	'' Newton gravity
	GameWorld.CreateNewtonGravity( P1, P2 )
	GameWorld.CreateNewtonGravity( P1, R1 )
	GameWorld.CreateNewtonGravity( P2, R1 )
	
	''
	GameWorld.ComputeData()
	ComputeData()
	
	GameCamera.Zoom( CAMERA_ZOOM_MAX )
	GameCamera.RestZoom( 9.0 )
	GameCamera.RestPosition( Vec2( 0.0, 500.0 ) )
	
End Sub


''
#EndIf __GO_PUZZLES_BI__
