''******************************************************************************
''    
''  Graveyard Orbit - A 2D space physics puzzle game
''
''  Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''  Version 0.1.0, October 31. 2016
''  
''  Author:
''  Michael "h4tt3n" Schmidt Nissen, michaelschmidtnissen@gmail.com
''
''  Description:
''  
''    
''******************************************************************************


''
#Ifndef __GO_GAME_BI__
#Define __GO_GAME_BI__


''
Type Game
	
	Public:
	
	''
	Declare Constructor()
	
	''
	Declare Destructor()
	
	''
	Declare Function CreatePlanet() As Planet Ptr
	
	Declare Function CreatePlanet( ByVal _mass    As Single, _
	                               ByVal _density As Single ) As Planet Ptr
	
	Declare Function CreateAsteroidBelt( ByVal _Parent        As LinearState Ptr, _
	                                     ByVal _Asteroids     As Integer, _
	                                     ByVal _Eccentricity  As Vec2, _
	                                     ByVal _SemiMajorAxis As Vec2, _
	                                     ByVal _Periapsis     As Vec2, _
	                                     ByVal _Direction     As Single ) As SoftBody Ptr
	
	Declare Function CreateRocket() As Rocket Ptr
	
	Declare Function CreateRocket( ByVal _dry_mass         As Single, _
	                               ByVal _exhaust_velocity As Single, _
	                               ByVal _fuel_flow_rate   As Single, _
	                               ByVal _position         As Vec2 ) As Rocket Ptr
	
	Declare Function CreateGirder( ByVal _points As Vec2, _
	                               ByVal _Length As Vec2, _
	                               ByVal _type   As integer ) As SoftBody Ptr
	
	Declare Function CreateArchedGirder( ByVal _points  As Vec2, _
	                                     ByVal _Length  As Vec2, _
	                                     ByVal _Radians As Single, _
	                                     ByVal _Radius  As Single, _
	                                     ByVal _type    As integer ) As SoftBody Ptr
	
	Declare Function CreateStrongGirder( ByVal _points As Vec2, _
	                                     ByVal _Length As Vec2, _
	                                     ByVal _type   As integer ) As SoftBody Ptr
	
	
	
	''
	Declare Sub ComputeData()
	Declare Sub ComputeNewState()
	Declare Sub PrepareGame()
	Declare Sub PrintToConsole( ByVal text as String )
	Declare Sub RenderToScreen()
	Declare Sub RunGameLoop()
	
	''
	Declare Sub ResetAll()
	
	''
	Declare Sub Puzzle1()
	Declare Sub Puzzle2()
	Declare Sub Puzzle3()
	Declare Sub Puzzle4()
	Declare Sub Puzzle5()
	Declare Sub Puzzle6()
	Declare Sub Puzzle7()
	Declare Sub Puzzle8()
	Declare Sub Puzzle9()
	
	'Protected:
	
	''
	As String  World_description_ = ""
	As String  Puzzle_description_ = ""
	As Boolean Focus_on_ship_     = TRUE
	
	'' 
	As World GameWorld
	
	''
	As Keyboard   GameKeyboard
	As Joystick   GameJoystick
	As Mouse      GameMouse
	As ScreenType GameScreen
	As Camera     GameCamera
	
	''
	As AsteroidContainer Asteroids_
	As PlanetContainer Planets_
	As RocketContainer Rockets_
	As RoxelContainer Roxels_
	'As EngineContainer Engines_
	
End Type


''
Constructor Game()
	
	''
	Planets_.Reserve( MAX_PLANETS )
	Rockets_.Reserve( MAX_ROCKETS )
	'Engines_.Reserve( MAX_ENGINES )
	
	''
	PrepareGame()
	
	''
	RunGameLoop()
	
End Constructor


''
Destructor Game()
	
	''
	Planets_.Destroy()
	Rockets_.Destroy()
	'Engines_.Destroy()
	
End Destructor


''
Sub Game.ComputeData()
	
	''
	For PP As Planet Ptr = Planets_.p_front To Planets_.p_back
		
		'PP->ComputeAngle()
		'PP->ComputeAngleVector()
		
	Next
	
	''
	For RP As Rocket Ptr = Rockets_.p_front To Rockets_.p_back
		
		'RP->ComputeAngle()
		'RP->ComputeAngleVector()
		
	Next
	
End Sub

Sub Game.ComputeNewState()
	
	''
	For PP As Planet Ptr = Planets_.p_front To Planets_.p_back
		
		If PP->GetFlag( IS_ACTIVE Or IS_DYNAMIC ) Then
			
			''' Force
			'PP->AddVelocity( PP->Force * PP->InverseMass * DT )
			'PP->Force( Vec2( 0.0, 0.0 ) )
			
			'' Torque
			
			'' Linear impulse
			PP->AddVelocity( PP->GetImpulse )
			PP->AddPosition( PP->GetVelocity * DT )
			PP->SetImpulse( Vec2( 0.0, 0.0 ) )
			
			'' Angular impulse
			PP->AddAngularVelocity( PP->GetAngularImpulse )
			PP->AddAngle( PP->GetAngularVelocity * DT )
			PP->ComputeAngleVector()
			PP->SetAngularImpulse( 0.0 )
			
		End If
		
	Next
	
	''
	For RP As Rocket Ptr = Rockets_.p_front To Rockets_.p_back
		
		If RP->GetFlag( IS_ACTIVE Or IS_DYNAMIC ) Then
			
			'''
			'RP->AddVelocity( RP->Force * RP->InverseMass * DT )
			'RP->Force( Vec2( 0.0, 0.0 ) )
			
			''
			RP->AddVelocity( RP->GetImpulse )
			RP->AddPosition( RP->GetVelocity * DT )
			RP->SetImpulse( Vec2( 0.0, 0.0 ) )
			
			''
			RP->AddAngularVelocity( RP->GetAngularImpulse )
			RP->AddAngle( RP->GetAngularVelocity * DT )
			RP->ComputeAngleVector()
			RP->SetAngularImpulse( 0.0 )
			
		End If
		
	Next
	
End Sub

Sub Game.PrepareGame()
	
	''
	GameScreen.Create( SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_BIT_DEPTH, SCREEN_FLAGS )
	GameCamera.Create( GameScreen.WIDTH, GameScreen.HEIGHT, CAMERA_ZOOM_MAX )
	
	GameCamera.RestZoom( 5.0 )
	
	Color( RGB( 192, 192, 192 ), RGB( 16, 24, 32 ) )
	
	WindowTitle "Graveyard Orbit - A 2D space physics puzzle game - v. 0.1.0 - Press 1-9 for demo levels"
	
	''
	Puzzle1()
	
End Sub

sub Game.PrintToConsole( ByVal text as String )
	
	open cons for output as #1
	print #1, text
	close #1
	
End Sub

Sub Game.RunGameLoop()
	
	''
	'GameWorld.ComputeData()
	
	Do
		
		''
		''GameKeyboard.Update()
		'GameMouse.Update()
		
		''
		If MultiKey( fb.SC_1 ) Then Puzzle1()
		If MultiKey( fb.SC_2 ) Then Puzzle2()
		If MultiKey( fb.SC_3 ) Then Puzzle3()
		If MultiKey( fb.SC_4 ) Then Puzzle4()
		If MultiKey( fb.SC_5 ) Then Puzzle5()
		If MultiKey( fb.SC_6 ) Then Puzzle6()
		If MultiKey( fb.SC_7 ) Then Puzzle7()
		If MultiKey( fb.SC_8 ) Then Puzzle8()
		If MultiKey( fb.SC_9 ) Then Puzzle9()
		
		''
		If ( Focus_on_ship_ = TRUE ) Then GameCamera.RestPosition_ = Rockets_[0]->GetPosition
		
		''
		If MultiKey( fb.SC_PERIOD ) Then GameCamera.RestZoom_ /= 1.01
		If MultiKey( fb.SC_COMMA  ) Then GameCamera.Restzoom_ *= 1.01
		
		''
		If MultiKey( fb.SC_UP )    Then GameCamera.RestPosition_.y += SCREEN_HEIGHT * GameCamera.Zoom_ * 0.4
		If MultiKey( fb.SC_DOWN )  Then GameCamera.RestPosition_.y -= SCREEN_HEIGHT * GameCamera.Zoom_ * 0.4
		If MultiKey( fb.SC_LEFT )  Then GameCamera.RestPosition_.x -= SCREEN_WIDTH  * GameCamera.Zoom_ * 0.4
		If MultiKey( fb.SC_RIGHT ) Then GameCamera.RestPosition_.x += SCREEN_WIDTH  * GameCamera.Zoom_ * 0.4
		
		''
		'If MultiKey( fb.SC_SPACE ) Then Focus_on_ship_ = IIf( Focus_on_ship_ = TRUE, FALSE, TRUE )
		
		Dim As Rocket Ptr Player = Rockets_[0]
		
		''
		If MultiKey( fb.SC_W ) Then Player->ApplyThrustImpulse(  ROCKET_THRUST_IMPULSE )
		If MultiKey( fb.SC_S ) Then Player->ApplyThrustImpulse( -ROCKET_THRUST_IMPULSE )
		
		''
		If MultiKey( fb.SC_A ) Then Player->AddAngle(  ROCKET_DELTA_ANGLE * TWO_PI )
		If MultiKey( fb.SC_D ) Then Player->AddAngle( -ROCKET_DELTA_ANGLE * TWO_PI )
		
		''
		GameJoystick.Update()
		
		If Abs( GameJoystick.Axis(4).x ) > 0.2 Then 
			
			Player->AddAngle( -GameJoystick.Axis(4).x * ROCKET_DELTA_ANGLE * TWO_PI)
			
			Player->SetAngularVelocity( 0.0 )
			
		EndIf
		
		If Abs( GameJoystick.Axis(4).y ) > 0.2 Then 
			
			Player->ApplyThrustImpulse( -GameJoystick.Axis(4).y )
			
		EndIf
		
		If GameJoystick.Button(3) Then GameCamera.RestZoom_ /= 1.01
		If GameJoystick.Button(0) Then GameCamera.Restzoom_ *= 1.01
		
		If Abs( GameJoystick.Axis(2).x ) > 0.2 Then 
			
			GameCamera.RestPosition_.x += ( GameJoystick.Axis(2).x - Sgn( GameJoystick.Axis(2).x ) * 0.2 ) * _
			                                GameScreen.Width  * GameCamera.Zoom_ * 0.4
			
		EndIf
		
		If Abs( GameJoystick.Axis(2).y ) > 0.2 Then 
			
			GameCamera.RestPosition_.y -= ( GameJoystick.Axis(2).y - Sgn( GameJoystick.Axis(2).y ) * 0.2 ) * _
			                                GameScreen.Height * GameCamera.Zoom_ * 0.4 ' 0.01
			
		EndIf
		
		''
		If GameJoystick.Button(8) Then Focus_on_ship_ = IIf( Focus_on_ship_ = TRUE, FALSE, TRUE )
		
		''
		GameWorld.ApplyWarmStart()
		
		''
		GameWorld.ApplyImpulses()
		
		''
		GameWorld.ComputeNewState()
		ComputeNewState()
		
		''
		GameWorld.ComputeData()
		ComputeData()
		
		''
		GameCamera.Update()
		
		''
		RenderToScreen()
		
		''
		'Sleep 1, 1
		
	Loop Until MultiKey(1)' Or GameJoystick.Button(8)
	
End Sub

Sub Game.RenderToScreen()
	
	''
	Cls
	
	Locate 2, 2: Print World_description_
	Locate 4, 2: Print Puzzle_description_
	
	''
	If ( Not GameWorld.NewtonGravitys_.Empty ) Then 
		
		For NP As NewtonGravity Ptr = GameWorld.NewtonGravitys_.p_front To GameWorld.NewtonGravitys_.p_back
			
			If NP->GetFlag( IS_VISIBLE ) Then
				
				Line( NP->GetParticleB->GetPosition.x, NP->GetParticleB->GetPosition.y )-_
				    ( NP->GetParticleA->GetPosition.x, NP->GetParticleA->GetPosition.y ), RGB( 96, 48, 96 )
				
				Circle( NP->GetPosition.x, NP->GetPosition.y ), 4.0, RGB( 255, 0, 255 ),,,1,f
				
			EndIf
			
		Next
	
	EndIf
	
	''
	If ( Not GameWorld.KeplerOrbits_.Empty ) Then 
		
		For KP As KeplerOrbit Ptr = GameWorld.KeplerOrbits_.p_front To GameWorld.KeplerOrbits_.p_back
			
			If KP->GetFlag( IS_VISIBLE ) Then
				
				KP->DrawOrbit()
				
			End If
			
		Next
		
	EndIf
	
	'GameWorld.WhatAmIOrbiting( Rockets_[0], @GameWorld.KeplerOrbits_ )
	'GameWorld.WhatAmIOrbiting( Rockets_[0], Cast( LinearLinkArray Ptr, @GameWorld.KeplerOrbits_ ) )
	GameWorld.WhatAmIOrbiting( Rockets_[0], Cast( LinearLinkArray Ptr, @GameWorld.NewtonGravitys_ ) )
	
	'Dim As KeplerOrbit K = KeplerOrbit( Rockets_[0], GameWorld.KeplerOrbits_[0] )
	'k.DrawOrbit()
	
	''
	If ( Not Rockets_.Empty ) Then 
			
		For RP As Rocket Ptr = Rockets_.p_front To Rockets_.p_back
			
			If RP->GetFlag( IS_VISIBLE ) Then
				
				'Locate 2, 2: Print "mass " & Mass_
				'Locate 4, 2: Print "fuel flow rate " & FuelFlowRate
				'Locate 6, 2: Print "exhaust velocity " & ExhaustVelocity
				'Locate 8, 2: Print "fuel mass " & FuelMass
				'Locate 10, 2: Print "delta v " & DeltaV
				'Locate 12, 2: Print "velocity " & Velocity_.Length()
				
				Dim As Vec2 front = RP->GetPosition + RP->GetAngleVector * 48
				Dim As Vec2 back  = RP->GetPosition - RP->GetAngleVector * 32
				Dim As Vec2 Starborad = back + RP->GetAngleVector.PerpCCW * 32
				Dim As Vec2 Port = back - RP->GetAngleVector.PerpCCW * 32
				
				
				'Circle( front.x, front.y ), 2.0, RGB( 255, 255, 0 ),,,1,f
				'Circle( Starborad.x, Starborad.y ), 2.0, RGB( 255, 255, 0 ),,,1,f
				'Circle( Port.x, Port.y ), 2.0, RGB( 255, 255, 0 ),,,1,f
				
				Line( front.x, front.y )-( Starborad.x, Starborad.y )
				Line( Starborad.x, Starborad.y )-( Port.x, Port.y )
				Line( Port.x, Port.y )-( front.x, front.y )
				
			EndIf
			
		Next
		
	EndIf
	
	''
	
	If ( Not Planets_.Empty ) Then 
		
		For PP As Planet Ptr = Planets_.p_front To Planets_.p_back
			
			If PP->GetFlag( IS_VISIBLE ) Then
				
				'Circle( Position_.x, Position_.y ), Radius_ , RGB( 16, 16, 16 ),,, 1, f
				'Circle( Position_.x, Position_.y ), Radius_ - 24.0 , Colour,,, 1, f
				Circle( PP->GetPosition.x, PP->GetPosition.y ), PP->GetRadius , PP->GetColour,,, 1, f
				Circle( PP->GetPosition.x, PP->GetPosition.y ), 4.0 , RGB( 64, 64, 64 ),,, 1, f
				
				'Dim As Vec2 Edge = Position_ + ( Radius_ - 24.0 ) * AngleVector_
				Dim As Vec2 Edge = PP->GetPosition + PP->GetRadius * PP->GetAngleVector
				
				Line( PP->GetPosition.x, PP->GetPosition.y )-( Edge.x, Edge.y ), RGB( 64, 64, 64 )
				
			EndIf
			
		Next
		
	EndIf
	
	If ( Not GameWorld.RigidBodys_.Empty ) Then 
		
		For S As RigidBody Ptr = GameWorld.RigidBodys_.p_front To GameWorld.RigidBodys_.p_back
			
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
	
	EndIf
	
	If ( Not GameWorld.SoftBodys_.Empty ) Then 
		
		For S As SoftBody Ptr = GameWorld.SoftBodys_.p_front To GameWorld.SoftBodys_.p_back
			
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
	
	EndIf
	
	If ( Not GameWorld.LinearSprings_.Empty ) Then
		
		For L As LinearSpring Ptr = GameWorld.LinearSprings_.p_front To GameWorld.LinearSprings_.p_back
			
			If L->GetFlag( IS_VISIBLE ) Then
				
				Line( L->GetParticleA->GetPosition.x, L->GetParticleA->GetPosition.y )-_
				    ( L->GetParticleB->GetPosition.x, L->GetParticleB->GetPosition.y ),  RGB( 128, 128, 128 )
				
				Circle( L->GetPosition.x, L->GetPosition.y ), 2.0, RGB( 128, 128, 128 ),,,1,f
				
			EndIf
			
		Next
		
	EndIf
	
	If ( Not GameWorld.LinearStates_.Empty ) Then
		
		For P As LinearState Ptr = GameWorld.LinearStates_.p_front To GameWorld.LinearStates_.p_back
			
			If P->GetFlag( IS_VISIBLE ) Then
					
				Circle( P->GetPosition.x, P->GetPosition.y ), 4.0 , RGB( 144, 144, 144 ),,,1,f
				
			EndIf
			
		Next
		
	EndIf
	
	ScreenCopy()
	
End Sub


''
Sub Game.ResetAll()
	
	GameWorld.ResetAll()
	
	Planets_.Clear()
	Rockets_.Clear()
	
	World_description_  = ""
	Puzzle_description_ = ""
	
End Sub


#EndIf __GO_GAME_BI__
