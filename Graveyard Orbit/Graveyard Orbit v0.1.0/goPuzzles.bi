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
Sub Game.Intro()
	
	ResetAll()
	
	''
	Dim As Planet Ptr P1 = CreatePlanet( 8E7, 0.0 , 2000.0)
	Dim As Planet Ptr P2 = CreatePlanet( 2E7, 0.0 , 2000.0)
	
	P1->SetColour( RGB( 80, 128, 64 ) )
	P2->SetColour( RGB( 128, 80, 64 ) )
	
	Dim As KeplerOrbit Ptr K1 = GameWorld.CreateKeplerOrbit( P1, P2 )
	
	k1->ApplyOrbit( Vec2( -3000.0, 2000.0 ), 0.0, 1000, -0.25 * TWO_PI, 0.5 * TWO_PI, CCW )
	
	GameWorld.CreateNewtonGravity( P1, P2 )
	
	
	''
	Dim As Planet Ptr P3 = CreatePlanet( 7E7, 0.0 , 2000.0)
	Dim As Planet Ptr P4 = CreatePlanet( 3E7, 0.0 , 2000.0)
	
	P3->SetColour( RGB( 80, 128, 64 ) )
	P4->SetColour( RGB( 128, 80, 64 ) )
	
	Dim As KeplerOrbit Ptr K2 = GameWorld.CreateKeplerOrbit( P3, P4 )
	
	k2->ApplyOrbit( Vec2( -1000.0, 2000.0 ), 0.0, 1000, -0.25 * TWO_PI, 0.5 * TWO_PI, CCW )
	
	GameWorld.CreateNewtonGravity( P3, P4 )
	
	
	''
	Dim As Planet Ptr P5 = CreatePlanet( 6E7, 0.0 , 2000.0)
	Dim As Planet Ptr P6 = CreatePlanet( 4E7, 0.0 , 2000.0)
	
	P5->SetColour( RGB( 80, 128, 64 ) )
	P6->SetColour( RGB( 128, 80, 64 ) )
	
	Dim As KeplerOrbit Ptr K3 = GameWorld.CreateKeplerOrbit( P5, P6 )
	
	k3->ApplyOrbit( Vec2( 1000.0, 2000.0 ), 0.0, 1000, -0.25 * TWO_PI, 0.5 * TWO_PI, CCW )
	
	GameWorld.CreateNewtonGravity( P5, P6 )
	
	
	''
	Dim As Planet Ptr P7 = CreatePlanet( 5E7, 0.0 , 2000.0)
	Dim As Planet Ptr P8 = CreatePlanet( 5E7, 0.0 , 2000.0)
	
	P7->SetColour( RGB( 80, 128, 64 ) )
	P8->SetColour( RGB( 128, 80, 64 ) )
	
	Dim As KeplerOrbit Ptr K4 = GameWorld.CreateKeplerOrbit( P7, P8 )
	
	k4->ApplyOrbit( Vec2( 3000.0, 2000.0 ), 0.0, 1000, -0.25 * TWO_PI, 0.5 * TWO_PI, CCW )
	
	GameWorld.CreateNewtonGravity( P7, P8 )
	
	
	''
	Dim As Planet Ptr P9  = CreatePlanet( 8E7, 0.0 , 2000.0)
	Dim As Planet Ptr P10 = CreatePlanet( 2E7, 0.0 , 2000.0)
	
	P9->SetColour( RGB( 80, 128, 64 ) )
	P10->SetColour( RGB( 128, 80, 64 ) )
	
	Dim As KeplerOrbit Ptr K5 = GameWorld.CreateKeplerOrbit( P9, P10 )
	
	k5->ApplyOrbit( Vec2( -3000.0, 0.0 ), 0.3, 1000, -0.25 * TWO_PI, 0.5 * TWO_PI, CCW )
	
	GameWorld.CreateNewtonGravity( P9, P10 )
	
	
	''
	Dim As Planet Ptr P11 = CreatePlanet( 7E7, 0.0 , 2000.0)
	Dim As Planet Ptr P12 = CreatePlanet( 3E7, 0.0 , 2000.0)
	
	P11->SetColour( RGB( 80, 128, 64 ) )
	P12->SetColour( RGB( 128, 80, 64 ) )
	
	Dim As KeplerOrbit Ptr K6 = GameWorld.CreateKeplerOrbit( P11, P12 )
	
	k6->ApplyOrbit( Vec2( -1000.0, 0.0 ), 0.3, 1000, -0.25 * TWO_PI, 0.5 * TWO_PI, CCW )
	
	GameWorld.CreateNewtonGravity( P11, P12 )
	
	
	''
	Dim As Planet Ptr P13 = CreatePlanet( 6E7, 0.0 , 2000.0)
	Dim As Planet Ptr P14 = CreatePlanet( 4E7, 0.0 , 2000.0)
	
	P13->SetColour( RGB( 80, 128, 64 ) )
	P14->SetColour( RGB( 128, 80, 64 ) )
	
	Dim As KeplerOrbit Ptr K7 = GameWorld.CreateKeplerOrbit( P13, P14 )
	
	k7->ApplyOrbit( Vec2( 1000.0, 0.0 ), 0.3, 1000, -0.25 * TWO_PI, 0.5 * TWO_PI, CCW )
	
	GameWorld.CreateNewtonGravity( P13, P14 )
	
	
	''
	Dim As Planet Ptr P15 = CreatePlanet( 5E7, 0.0 , 2000.0)
	Dim As Planet Ptr P16 = CreatePlanet( 5E7, 0.0 , 2000.0)
	
	P15->SetColour( RGB( 80, 128, 64 ) )
	P16->SetColour( RGB( 128, 80, 64 ) )
	
	Dim As KeplerOrbit Ptr K8 = GameWorld.CreateKeplerOrbit( P15, P16 )
	
	k8->ApplyOrbit( Vec2( 3000.0, 0.0 ), 0.3, 1000, -0.25 * TWO_PI, 0.5 * TWO_PI, CCW )
	
	GameWorld.CreateNewtonGravity( P15, P16 )
	
	
	''
	Dim As Planet Ptr P17 = CreatePlanet( 8E7, 0.0 , 2000.0)
	Dim As Planet Ptr P18 = CreatePlanet( 2E7, 0.0 , 2000.0)
	
	P17->SetColour( RGB( 80, 128, 64 ) )
	P18->SetColour( RGB( 128, 80, 64 ) )
	
	Dim As KeplerOrbit Ptr K9 = GameWorld.CreateKeplerOrbit( P17, P18 )
	
	k9->ApplyOrbit( Vec2( -3000.0, -2000.0 ), 0.6, 1000, -0.25 * TWO_PI, 0.5 * TWO_PI, CCW )
	
	GameWorld.CreateNewtonGravity( P17, P18 )
	
	
	''
	Dim As Planet Ptr P19 = CreatePlanet( 7E7, 0.0 , 2000.0)
	Dim As Planet Ptr P20 = CreatePlanet( 3E7, 0.0 , 2000.0)
	
	P19->SetColour( RGB( 80, 128, 64 ) )
	P20->SetColour( RGB( 128, 80, 64 ) )
	
	Dim As KeplerOrbit Ptr K10 = GameWorld.CreateKeplerOrbit( P19, P20 )
	
	k10->ApplyOrbit( Vec2( -1000.0, -2000.0 ), 0.6, 1000, -0.25 * TWO_PI, 0.5 * TWO_PI, CCW )
	
	GameWorld.CreateNewtonGravity( P19, P20 )
	
	
	''
	Dim As Planet Ptr P21 = CreatePlanet( 6E7, 0.0 , 2000.0)
	Dim As Planet Ptr P22 = CreatePlanet( 4E7, 0.0 , 2000.0)
	
	P21->SetColour( RGB( 80, 128, 64 ) )
	P22->SetColour( RGB( 128, 80, 64 ) )
	
	Dim As KeplerOrbit Ptr K11 = GameWorld.CreateKeplerOrbit( P21, P22 )
	
	k11->ApplyOrbit( Vec2( 1000.0, -2000.0 ), 0.6, 1000, -0.25 * TWO_PI, 0.5 * TWO_PI, CCW )
	
	GameWorld.CreateNewtonGravity( P21, P22 )
	
	
	''
	Dim As Planet Ptr P23 = CreatePlanet( 5E7, 0.0 , 2000.0)
	Dim As Planet Ptr P24 = CreatePlanet( 5E7, 0.0 , 2000.0)
	
	P23->SetColour( RGB( 80, 128, 64 ) )
	P24->SetColour( RGB( 128, 80, 64 ) )
	
	Dim As KeplerOrbit Ptr K12 = GameWorld.CreateKeplerOrbit( P23, P24 )
	
	k12->ApplyOrbit( Vec2( 3000.0, -2000.0 ), 0.6, 1000, -0.25 * TWO_PI, 0.5 * TWO_PI, CCW )
	
	GameWorld.CreateNewtonGravity( P23, P24 )
	
	
	''
	GameCamera.Zoom( CAMERA_ZOOM_MAX )
	GameCamera.RestZoom( 10.0 )
	GameCamera.RestPosition( Vec2( 0.0, 0.0 ) )
	
End Sub

Sub Game.Puzzle1()
	
	'' 
	
	ResetAll()
	
	World_description_ = "World 1: Two moon orbits with different eccentricity. Same semimajor axis means same orbital period."
	
	Puzzle_description_ = "Puzzle: Make the ship orbit the plants and moons."
	
	Dim As ShapeBody Ptr Asteroid1 = GameWorld.CreateShapeBody( 32, 200, Vec2( 0.0, 0.0 ) )
	
	'Dim As RigidBody Ptr Rigid1 = GameWorld.CreateRigidBody( 256, 128, Vec2( 0.0, 0.0 ) )
	'Dim As RigidBody Ptr Rigid2 = GameWorld.CreateRigidBody(  64,  64, Vec2( 400.0, 0.0 ) )
	
	'Dim As Roxel Ptr Roxel1 = CreateRoxel( 1.0, 50.0, RGB( 32, 32, 32 ), RGB( 128, 96, 80 ) )
	
	'Dim As RigidBody Ptr Asteroid1 = CreateAsteroid( 1.0, 32, Vec2( 128.0, 1024.0 ) )
	Dim As RigidBody Ptr Asteroid2 = CreateAsteroid( 1.0, 31, Vec2( 128.0, 512.0 ) )
	
	'Asteroid1->AddAngle(  -0.25 * TWO_PI )
	'Asteroid2->AddAngle( --0.25 * TWO_PI )
	
	'Roxel1->SetPosition( Vec2( 2000.0, 2000.0 ) )
	'Asteroid1->SetPosition( Vec2( 3000.0, 2000.0 ) )
	'Asteroid1->SetAngularVelocity( 0.2 )
	
	'Rigid1->AddImpulse( Vec2( 0.0, 80.0 ) )
	'Rigid1->SetAngularVelocity( 1.0 )
	

	
	'Dim As LinearState Ptr LS1 = *(Rigid1->LinearStates_[0])
	
	'LS1->SetImpulse( Vec2( 100.0, 0.0 ) )
	'Rigid1->SetVelocity( Vec2( 10.0, 0.0 ) )
	
	''
	Dim As Planet Ptr P1 = CreatePlanet( 1E9, 0.0 , 1000.0)
	'Dim As Planet Ptr P2 = CreatePlanet( 1E7, 1000.0 )
	'Dim As Planet Ptr P3 = CreatePlanet( 4E7, 1000.0 )
	'Dim As Planet Ptr P4 = CreatePlanet( 1E7, 1000.0 )
	
	P1->SetColour( RGB( 80, 128, 64 ) )
	'P2->SetColour( RGB( 192, 192, 192 ) )
	'P3->SetColour( RGB( 136, 128, 120 ) )
	'P4->SetColour( RGB( 192, 192, 192 ) )
	
	'P1->SetAngularVelocity(  1.0 )
	
	''
	Dim As Rocket Ptr R1 = CreateRocket( 100.0, 20000.0, 0.1, Vec2( 2000.0, 2000.0 ) )
	
	'Rocket1->SetAngle( 0.5 * TWO_PI )
	'Rocket1->ApplyDeltaV( 2000.42 )
	R1->ApplyFuelMass( 50.00 )
	
	''
	Dim As KeplerOrbit Ptr K1 = GameWorld.CreateKeplerOrbit( P1, Asteroid1 )
	Dim As KeplerOrbit Ptr K2 = GameWorld.CreateKeplerOrbit( P1, Asteroid2 )
	
	Dim As KeplerOrbit K3 = KeplerOrbit( P1, R1 )
	
	''
	k1->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 6000, 0.5 * TWO_PI, 0.0 * TWO_PI, CCW )
	k2->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 4000, 0.5 * TWO_PI, -0.25 * TWO_PI, CCW )

	k3.ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 6000, 0.5 * TWO_PI, -0.02 * TWO_PI, CCW )
	
	Dim As LinearSpring Ptr L1 = GameWorld.CreateLinearSpring( 0.2, 1.0, 0.5, R1, *Asteroid1->LinearStates_[0] )
	'Dim As LinearSpring Ptr L1 = GameWorld.CreateLinearSpring( 0.1, 0.1, 0.1, *Asteroid1->LinearStates_[0], *Asteroid2->LinearStates_[0] )
	
	'Dim As LinearSpring Ptr L1 = GameWorld.CreateLinearSpring( 1, 1, 1, *Rigid1->LinearStates_[1], *Rigid2->LinearStates_[1] )
	'Dim As LinearSpring Ptr L1 = GameWorld.CreateLinearSpring( 0.00, 0.01, 0.0, *Rigid1->LinearStates_[1], P1 )
	'Dim As LinearSpring Ptr L1 = GameWorld.CreateLinearSpring( 1.0, 1.0, 1.0, R1, *Rigid1->LinearStates_[1] )

	''
	K1->ComputePeriod()
	K2->ComputePeriod()
	
	Asteroid1->SetAngularVelocity( TWO_PI / K1->Period )
	Asteroid2->SetAngularVelocity( TWO_PI / K2->Period )

	'Asteroid1->AddAngle( -0.25 * TWO_PI )
	'Asteroid2->AddAngle( -0.25 * TWO_PI )
	
	''
	GameWorld.CreateNewtonGravity( P1, R1 )
	GameWorld.CreateNewtonGravity( P1, Asteroid1 )
	GameWorld.CreateNewtonGravity( P1, Asteroid2 )

	
	GameWorld.CreateNewtonGravity( R1, Asteroid1 )
	GameWorld.CreateNewtonGravity( R1, Asteroid2 )
	GameWorld.CreateNewtonGravity( Asteroid1, Asteroid2 )
	
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
	Dim As Planet Ptr P1 = CreatePlanet( 5E7,, 200.0 )
	Dim As Planet Ptr P2 = CreatePlanet( 3E7,, 200.0 )
	Dim As Planet Ptr P3 = CreatePlanet( 4E7,, 200.0 )
	
	P1->SetColour( RGB( 136, 128, 120 ) )
	P2->SetColour( RGB( 136, 128, 120 ) )
	P3->SetColour( RGB( 136, 128, 120 ) )
	
	''
	Dim As Rocket Ptr R1 = CreateRocket( 30.0, 20000.0, 0.002, Vec2( 0.0, 0.0 ) )
	
	R1->ApplyFuelMass( 30.00 )
	
	''
	Dim As KeplerOrbit Ptr K1 = GameWorld.CreateKeplerOrbit( P1, P2 )
	Dim As KeplerOrbit Ptr K2 = GameWorld.CreateKeplerOrbit( K1, P3 )
	
	''
	K1->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0,  2000.0, 0.5 * TWO_PI, -0.25 * TWO_PI, CCW )
	K2->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0,  7000.0, 0.5 * TWO_PI, 0.5 * TWO_PI,  CW )
'	K3->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 12000.0, 0.5 * TWO_PI, 0.75 * TWO_PI, CCW )
	'K4->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 12000.0, 0.5 * TWO_PI, 0.5 * TWO_PI,  CW )
	
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
	
	'Dim As SoftBody Ptr GA1 = CreateArchedGirder( Vec2( 24, 2 ), Vec2( 64, 64 ), 0.125 * TWO_PI, 3000, K_TRUSS )
	
	Dim As SoftBody Ptr G1 = CreateStrongGirder(Vec2( 32, 2 ), Vec2( 64, 64 ), S_TRUSS ) 
	
	'Dim As SoftBody Ptr G1 = CreateGirder( Vec2( 0.0,   0.0 ), Vec2( Cos(0.0), Sin(0.0) ), Vec2( 32, 2 ), Vec2( 64, 64 ), S_TRUSS ) 
	'Dim As SoftBody Ptr G2 = CreateGirder( Vec2( 0.0, 100.0 ), Vec2( Cos(0.0), Sin(0.0) ), Vec2( 32, 2 ), Vec2( 64, 64 ), Z_TRUSS ) 
	'Dim As SoftBody Ptr G3 = CreateGirder( Vec2( 0.0, 200.0 ), Vec2( Cos(0.0), Sin(0.0) ), Vec2( 16, 2 ), Vec2( 128, 64 ), V_TRUSS ) 
	'Dim As SoftBody Ptr G4 = CreateGirder( Vec2( 0.0, 300.0 ), Vec2( Cos(0.0), Sin(0.0) ), Vec2( 16, 2 ), Vec2( 128, 64 ), X_TRUSS ) 
	'Dim As SoftBody Ptr G5 = CreateGirder( Vec2( 0.0, 400.0 ), Vec2( Cos(0.0), Sin(0.0) ), Vec2( 16, 2 ), Vec2( 96, 64 ), K_TRUSS ) 
	'Dim As SoftBody Ptr G6 = CreateGirder( Vec2( 0.0, 500.0 ), Vec2( Cos(0.0), Sin(0.0) ), Vec2( 32, 2 ), Vec2( 64, 64 ), O_TRUSS ) 
	 
	
	
	'G7->SetPosition( Vec2( 0.0, 0.0) )
	'G7->SetAngle( 0.5 * TWO_PI )
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
	GameCamera.RestZoom( 10.0 )
	GameCamera.RestPosition( Vec2( 0.0, 0.0 ) )
	
End Sub

Sub Game.Puzzle3()
	
	ResetAll()
	
	''
	World_description_ = "World 3: "
	
	Puzzle_description_ = "Puzzle: "
	
	''
	Dim As Planet Ptr P1 = CreatePlanet( 1E9, 300 )
	Dim As Planet Ptr P2 = CreatePlanet( 1E-9, 100 )
	Dim As Planet Ptr P3 = CreatePlanet( 1E-9, 100 )
	Dim As Planet Ptr P4 = CreatePlanet( 1E-9, 100 )
	Dim As Planet Ptr P5 = CreatePlanet( 1E-9, 100 )
	Dim As Planet Ptr P6 = CreatePlanet( 1E-9, 100 )
	Dim As Planet Ptr P7 = CreatePlanet( 1E-9, 100 )
	Dim As Planet Ptr P8 = CreatePlanet( 1E-9, 100 )
	Dim As Planet Ptr P9 = CreatePlanet( 1E-9, 100 )

	
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
	'                                             Vec2( 64.0, 64.0 ), -0.25 * TWO_PI, 4500, X_TRUSS )
	
	'Dim As SoftBody Ptr G2 = CreateArchedGirder( Vec2( 0.0, 0.0 ), 0.375  * TWO_PI, Vec2( 32, 2 ), _
	'                                             Vec2( 64.0, 64.0 ), -0.25 * TWO_PI, 4500, X_TRUSS )
	
	'Dim As SoftBody Ptr G3 = CreateArchedGirder( Vec2( 0.0, 0.0 ), 0.625  * TWO_PI, Vec2( 32, 2 ), _
	'                                             Vec2( 64.0, 64.0 ), -0.25 * TWO_PI, 4500, X_TRUSS )
	
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
	K1->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.5, 3000.0, 0.5 * TWO_PI, 0.0   * TWO_PI, CW )
	K2->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.5, 3000.0, 0.5 * TWO_PI, 0.125 * TWO_PI, CW )
	K3->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.5, 3000.0, 0.5 * TWO_PI, 0.25  * TWO_PI, CW )
	K4->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.5, 3000.0, 0.5 * TWO_PI, 0.375 * TWO_PI, CW )
	K5->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.5, 3000.0, 0.5 * TWO_PI, 0.5   * TWO_PI, CW )
	K6->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.5, 3000.0, 0.5 * TWO_PI, 0.625 * TWO_PI, CW )
	K7->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.5, 3000.0, 0.5 * TWO_PI, 0.75  * TWO_PI, CW )
	K8->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.5, 3000.0, 0.5 * TWO_PI, 0.875 * TWO_PI, CW )
	
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
	GameCamera.RestZoom( 10.0 )
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
	Dim As Planet Ptr P1 = CreatePlanet( 16E8, 1000.0 )
	Dim As Planet Ptr P2 = CreatePlanet( 1E8,, 1000.0 )
	Dim As Planet Ptr P3 = CreatePlanet( 2E8,, 1000.0 )
	Dim As Planet Ptr P4 = CreatePlanet( 4E8,, 1000.0 )
	
	''
	P1->SetColour( RGB( 255, 244, 192 ) )
	P2->SetColour( RGB( 136, 128, 120 ) )
	P3->SetColour( RGB( 136, 128, 120 ) )
	P4->SetColour( RGB( 136, 128, 120 ) )

	'' Rocket
	Dim As Rocket Ptr R1 = CreateRocket( 50.0, 20000.0, 0.2, Vec2( 0.0, 0.0 ) )
	
	R1->ApplyFuelMass( 50.00 )
	R1->SetPosition( Vec2(-5000.0, 0.0) )
	
	'' Kepler Orbits
	Dim As KeplerOrbit Ptr K1 = GameWorld.CreateKeplerOrbit( P1, P2 )
	Dim As KeplerOrbit Ptr K2 = GameWorld.CreateKeplerOrbit( K1, P3 )
	Dim As KeplerOrbit Ptr K3 = GameWorld.CreateKeplerOrbit( K2, P4 )
	
	''
	K1->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 3000, 0.5 * TWO_PI, 0.0  * TWO_PI, CW )
	K2->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 6000, 0.5 * TWO_PI, 0.33 * TWO_PI, CW )
	K3->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 9000, 0.5 * TWO_PI, 0.66 * TWO_PI, CW )
	
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
	GameCamera.RestZoom( 10.0 )
	GameCamera.RestPosition( Vec2( 0.0, 0.0 ) )
	
End Sub

Sub Game.Puzzle5()
	
	''
	ResetAll()
		
	''
	World_description_ = "World 5: Triple nested orbits. "
	
	Puzzle_description_ = "Puzzle: "
	
	
	'' Planets
	Dim As Planet Ptr P1 = CreatePlanet( 1E9, 2E3 )
	Dim As Planet Ptr P2 = CreatePlanet( 1E9, 2E3 )
	Dim As Planet Ptr P3 = CreatePlanet( 2E9, 2E3 )
	Dim As Planet Ptr P4 = CreatePlanet( 4E9, 2E3 )
	Dim As Planet Ptr P5 = CreatePlanet( 8E9, 2E3 )
	
	''
	P1->SetColour( RGB( 255, 244, 192 ) )
	P2->SetColour( RGB( 136, 128, 120 ) )
	P3->SetColour( RGB( 136, 128, 120 ) )
	P4->SetColour( RGB( 136, 128, 120 ) )
	
	'' Rocket
	Dim As Rocket Ptr R1 = CreateRocket( 50.0, 20000.0, 0.2, Vec2( 0.0, 0.0 ) )
	
	R1->ApplyFuelMass( 50.00 )
	
	'' Kepler Orbits
	Dim As KeplerOrbit Ptr K1 = GameWorld.CreateKeplerOrbit( P1, P2 )
	Dim As KeplerOrbit Ptr K2 = GameWorld.CreateKeplerOrbit( K1, P3 )
	Dim As KeplerOrbit Ptr K3 = GameWorld.CreateKeplerOrbit( K2, P4 )
	Dim As KeplerOrbit Ptr K4 = GameWorld.CreateKeplerOrbit( K3, P5 )
	
	''
	K1->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0,  2000, 0.5 * TWO_PI, 0.5 * TWO_PI, CW )
	K2->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0,  4000, 0.5 * TWO_PI, 0.33 * TWO_PI, CCW )
	K3->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0,  8000, 0.5 * TWO_PI, 0.66 * TWO_PI, CW )
	K4->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 16000, 0.5 * TWO_PI, 0.66 * TWO_PI, CW )
	
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
	GameCamera.RestZoom( 10.0 )
	GameCamera.RestPosition( Vec2( 0.0, 0.0 ) )
	
End Sub

Sub Game.Puzzle6()
	
	''
	ResetAll()
	
	''
	World_description_ = "World 6: "
	
	Puzzle_description_ = "Puzzle: "
	
	Dim As RigidBody Ptr Ri1 = GameWorld.CreateRigidBody( 128, 128, Vec2( 100.0, 0.0 ) )
	
	Dim As SoftBody Ptr G1 = CreateGirder( Vec2( 32, 2 ), Vec2( 96, 64 ), X_TRUSS ) 
	Dim As SoftBody Ptr G2 = CreateGirder( Vec2( 32, 2 ), Vec2( 96, 64 ), K_TRUSS ) 
	'Dim As SoftBody Ptr G3 = CreateGirder( Vec2( 32, 4 ), Vec2( 128, 64 ), V_TRUSS ) 
	'Dim As SoftBody Ptr G4 = CreateGirder( Vec2( 32, 2 ), Vec2( 128, 64 ), X_TRUSS ) 
	'Dim As SoftBody Ptr G5 = CreateGirder( Vec2( 32, 2 ), Vec2( 96, 64 ), K_TRUSS ) 
	'Dim As SoftBody Ptr G6 = CreateGirder( Vec2( 32, 2 ), Vec2( 128, 64 ), O_TRUSS ) 
	
	'Dim As SoftBody Ptr G7 = CreateStrongGirder( Vec2( 32, 6 ), Vec2( 64, 64 ), X_TRUSS ) 
	
	'Dim As SoftBody Ptr G10 = CreateArchedGirder( Vec2( 24, 2 ), Vec2( 96.0, 64.0 ), 1.0 * TWO_PI, 500, S_TRUSS )
	'Dim As SoftBody Ptr G11 = CreateArchedGirder( Vec2( 24, 2 ), Vec2( 96.0, 64.0 ), 0.875 * TWO_PI, 500, Z_TRUSS )
	Dim As SoftBody Ptr G12 = CreateGirder( Vec2( 24, 2 ), Vec2( 96.0, 64.0 ), 0.5 * TWO_PI, 500, V_TRUSS )
	Dim As SoftBody Ptr G13 = CreateGirder( Vec2( 24, 2 ), Vec2( 96.0, 64.0 ), 0.5 * TWO_PI, 500, X_TRUSS )
	Dim As SoftBody Ptr G14 = CreateGirder( Vec2( 24, 2 ), Vec2( 96.0, 64.0 ), 0.5 * TWO_PI, 500, K_TRUSS )
	Dim As SoftBody Ptr G15 = CreateGirder( Vec2( 24, 2 ), Vec2( 96.0, 64.0 ), 0.5 * TWO_PI, 500, O_TRUSS )
	
	G1->SetPosition( Vec2( -200.0, 0.0 ) )
	G2->SetPosition( Vec2( 0.0, 0.0 ) )
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
	G1->AddAngularVelocity( -1 )
	G2->AddAngularVelocity( -1 )
	'G1->AddVelocity( Vec2( 1.0, 0.0 ) )
	Ri1->SetAngularVelocity( -10 )
	G13->AddAngularVelocity( 0.5 )
	G14->AddAngularVelocity( 0.5 )
	G15->AddAngularVelocity( 0.5 )
	
	
	'' Planets
	Dim As Planet Ptr P1 = CreatePlanet(  1E8,, 1000 )
	Dim As Planet Ptr P2 = CreatePlanet(  3E8,, 1000 )
	Dim As Planet Ptr P3 = CreatePlanet(  9E8,, 1000 )
	Dim As Planet Ptr P4 = CreatePlanet( 27E8,, 1000 )
	
	''
	P1->SetColour( RGB( 255, 244, 192 ) )
	P2->SetColour( RGB( 136, 128, 120 ) )
	P3->SetColour( RGB( 136, 128, 120 ) )
	P4->SetColour( RGB( 136, 128, 120 ) )
	
	'' Rocket
	Dim As Rocket Ptr R1 = CreateRocket( 50.0, 20000.0, 0.2, Vec2( 0.0, 0.0 ) )
	'Dim As Rocket Ptr R2 = CreateRocket( 50.0, 20000.0, 0.2, Vec2(  100.0, 10000.0 ) )
	
	R1->ApplyFuelMass( 50.00 )
	'R2->ApplyFuelMass( 50.00 )
	
	'' Kepler Orbits
	Dim As KeplerOrbit Ptr K1 = GameWorld.CreateKeplerOrbit( P1, P2 )
	Dim As KeplerOrbit Ptr K2 = GameWorld.CreateKeplerOrbit( K1, P3 )
	Dim As KeplerOrbit Ptr K3 = GameWorld.CreateKeplerOrbit( K2, P4 )
	
	''
	K1->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0,  1000, 0.5 * TWO_PI, 0.5 * TWO_PI, CW )
	K2->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0,  5000, 0.5 * TWO_PI, 0.33 * TWO_PI, CCW )
	K3->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 16000, 0.5 * TWO_PI, 0.66 * TWO_PI, CW )
	
	'' Newton gravity
	GameWorld.CreateNewtonGravity( P1, P2 )
	GameWorld.CreateNewtonGravity( P1, P3 )
	GameWorld.CreateNewtonGravity( P1, P4 )
	GameWorld.CreateNewtonGravity( P2, P3 )
	GameWorld.CreateNewtonGravity( P2, P4 )
	GameWorld.CreateNewtonGravity( P3, P4 )
	
	'Dim As LinearSpring Ptr L1 = GameWorld.CreateLinearSpring( 1.0, 1.0, 1.0, R1, R2 )
	'Dim As LinearSpring Ptr L1 = GameWorld.CreateLinearSpring( 1.0, 1.0, 1.0, R1, *G1->LinearStates_[0] )
	'Dim As LinearSpring Ptr L1 = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, *G1->LinearStates_[0], *G2->LinearStates_[0] )
	
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
	Dim As Planet Ptr P1 = CreatePlanet( 1E9, 400.0 )
	
	''
	P1->SetColour( RGB( 255, 244, 192 ) )
	
	'' Rocket
	Dim As Rocket Ptr R1 = CreateRocket( 50.0, 50000.0, 0.1, Vec2( -6000.0, 2000.0 ) )
	
	R1->ApplyFuelMass( 50.00 )
	
	'' Newton gravity
	
	'Dim As SoftBody Ptr Asteroids1 = CreateAsteroidBelt( P1, 256, Vec2( 0.6, 0.7 ), Vec2( 7000.0, 8000.0 ), Vec2( -0.3, -0.3 ), CCW )
	Dim As SoftBody Ptr Asteroids2 = CreateAsteroidBelt( P1, 200, Vec2( 1000, 10000 ), Vec2( 0.25, 0.25 ), Vec2( 2000.0, 3000.0 ), Vec2( -0.05, -0.05 ) * TWO_PI, CCW )
	
	'Asteroids2->AddAngularImpulse( -0.001 * TWO_PI )
	'Asteroids2->AddPosition( Vec2( -8000.0, 0.0 ) )
	'Asteroids2->AddImpulse( Vec2( 1000.0, 0.0 ) )
	
	'GameWorld.CreateNewtonGravity( P1, R1 )
	
	''
	GameWorld.ComputeData()
	ComputeData()
	
	GameCamera.Zoom( CAMERA_ZOOM_MAX )
	GameCamera.RestZoom( 10.0 )
	GameCamera.RestPosition( Vec2( 0.0, 0.0 ) )
	
End Sub

Sub Game.Puzzle8()
	
	''
	ResetAll()
	
	''
	World_description_ = "World 8: "
	
	Puzzle_description_ = "Puzzle: "
		
	'' Planets
	Dim As Planet Ptr P1 = CreatePlanet( 1E7,, 1000.0 )
	Dim As Planet Ptr P2 = CreatePlanet( 2E7,, 1000.0 )
	Dim As Planet Ptr P3 = CreatePlanet( 4E7,, 1000.0 )
	Dim As Planet Ptr P4 = CreatePlanet( 8E7,, 1000.0 )
	
	''
	P1->SetColour( RGB( 255, 244, 192 ) )
	P2->SetColour( RGB( 136, 128, 120 ) )
	P3->SetColour( RGB( 136, 128, 120 ) )
	P4->SetColour( RGB( 136, 128, 120 ) )
	
	'' Rocket
	Dim As Rocket Ptr R1 = CreateRocket( 50.0, 50000.0, 0.2, Vec2( 0.0, 0.0 ) )
	
	R1->ApplyFuelMass( 50.00 )
	
	'' Kepler Orbits
	Dim As KeplerOrbit Ptr K1 = GameWorld.CreateKeplerOrbit( P1, P2 )
	Dim As KeplerOrbit Ptr K2 = GameWorld.CreateKeplerOrbit( K1, P3 )
	Dim As KeplerOrbit Ptr K3 = GameWorld.CreateKeplerOrbit( K2, P4 )
	
	''
	K1->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0,  1000, 0.5 * TWO_PI, 0.0  * TWO_PI, CW )
	K2->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0,  4000, 0.5 * TWO_PI, 0.33 * TWO_PI, CCW )
	K3->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 16000, 0.5 * TWO_PI, 0.66 * TWO_PI, CW )
	
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
	GameCamera.RestZoom( 10.0 )
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
	
	R1->ApplyFuelMass( 50.00 )
	
	'' Kepler Orbits
	Dim As KeplerOrbit Ptr K1 = GameWorld.CreateKeplerOrbit( P1, P2 )
	Dim As KeplerOrbit Ptr K2 = GameWorld.CreateKeplerOrbit( K1, R1 )
	
	''
	K1->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 12000, -0.125 * TWO_PI, 0.3 * TWO_PI, CCW )
	K2->ApplyOrbit( Vec2( 0.0, 0.0 ), 0.0, 4000, 0.5 * TWO_PI, 0.5 * TWO_PI, CCW )
	
	K2->LowerFlag( IS_VISIBLE )
	
	'' Newton gravity
	GameWorld.CreateNewtonGravity( P1, P2 )
	GameWorld.CreateNewtonGravity( P1, R1 )
	GameWorld.CreateNewtonGravity( P2, R1 )
	
	''
	GameWorld.ComputeData()
	ComputeData()
	
	GameCamera.Zoom( CAMERA_ZOOM_MAX )
	GameCamera.RestZoom( 10.0 )
	GameCamera.RestPosition( Vec2( 0.0, 500.0 ) )
	
End Sub


''
#EndIf __GO_PUZZLES_BI__
