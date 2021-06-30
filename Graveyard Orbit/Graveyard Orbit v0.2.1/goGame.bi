''******************************************************************************
''    
''  Graveyard Orbit - A 2D space physics puzzle game
''
''  Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''  Version 0.2.1, June 2018
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
	Declare Function CreateTree( ByVal _type As integer ) As ShapeBody Ptr
	
	Declare Function CreatePlanet() As Planet Ptr
	
	Declare Function CreatePlanet( ByVal _mass    As Single, _
	                               ByVal _radius  As Single = 0.0, _
	                               ByVal _density As Single = 0.0 ) As Planet Ptr
	
	Declare Function CreateAsteroid( ByVal _mass   As Single, _
	                                 ByVal _roxels As Integer, _
	                                 ByVal _radius As Vec2 ) As RigidBody Ptr
	
	Declare Function CreateAsteroidBelt( ByVal _parent        As LinearState Ptr, _
	                                     ByVal _num_asteroids As Integer, _
	                                     ByVal _asteroid_mass As Vec2, _
	                                     ByVal _eccentricity  As Vec2, _
	                                     ByVal _semimajoraxis As Vec2, _
	                                     ByVal _periapsis     As Vec2, _
	                                     ByVal _direction     As Single ) As Body Ptr
	
	''
	Declare Function CreateThruster( ByVal _mass             As Single, _
	                                 ByVal _position         As Vec2, _
	                                 ByVal _exhaust_velocity As Single, _
	                                 ByVal _fuel_flow_rate   As Single ) As Thruster Ptr
	
	Declare Function CreateSpaceShip() As SpaceShip Ptr
	
	''
	Declare Function CreateRocket() As Rocket Ptr
	
	Declare Function CreateRocket( ByVal _dry_mass         As Single, _
	                               ByVal _exhaust_velocity As Single, _
	                               ByVal _fuel_flow_rate   As Single, _
	                               ByVal _position         As Vec2 ) As Rocket Ptr
	
	''
	Declare Function CreateRoxel() As Roxel Ptr
	
	Declare Function CreateRoxel( ByVal _mass              As Single, _
	                              ByVal _radius            As Single, _
	                              ByVal _background_colour As UInteger, _
	                              ByVal _foreground_colour As UInteger ) As Roxel Ptr
	
	''
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
	
	Declare Function CreateShapeGirder( ByVal _points As Vec2, _
	                                    ByVal _Length As Vec2, _
	                                    ByVal _type   As integer ) As ShapeBody Ptr
	
	Declare Function CreateArchedShapeGirder( ByVal _points  As Vec2, _
	                                          ByVal _Length  As Vec2, _
	                                          ByVal _Radians As Single, _
	                                          ByVal _Radius  As Single, _
	                                          ByVal _type    As integer ) As ShapeBody Ptr
	
	Declare Function FindNearestRoxel( ByVal l As LinearState Ptr, _
	                                    ByVal distance As Single ) As LinearState Ptr
	
	Declare Function FindNearestLinearState( ByVal l As LinearState Ptr, _
	                                         ByVal distance As Single ) As LinearState Ptr
	
	''
	Declare Sub ComputeData()
	Declare Sub ComputeNewState()
	Declare Sub PrepareGame()
	Declare Sub PrintToConsole( ByVal text as String )
	Declare Sub RenderToScreen()
	Declare Sub RunGameLoop()
	
	
	''
	Declare Sub ResetAll()
	Declare Sub ResetImpulses()
	
	''
	Declare Sub Intro()
	Declare Sub Puzzle1()
	Declare Sub Puzzle2()
	Declare Sub Puzzle3()
	Declare Sub Puzzle4()
	Declare Sub Puzzle5()
	Declare Sub Puzzle6()
	Declare Sub Puzzle7()
	Declare Sub Puzzle8()
	Declare Sub Puzzle9()
	
	As fb.EVENT e
	
	'' 
	As World GameWorld
	
	''
	As PlanetContainer    Planets_
	As RocketContainer    Rockets_
	As RoxelContainer     Roxels_
	As SpaceShipContainer SpaceShips_
	As ThrusterContainer  Thrusters_
	
	''
	As Keyboard   GameKeyboard
	As Joystick   GameJoystick
	As Mouse      GameMouse
	As ScreenType GameScreen
	As Camera     GameCamera
	
	'Protected:
	
	''
	As String  World_description_  = ""
	As String  Puzzle_description_ = ""
	As Boolean Focus_on_ship_      = TRUE
	
End Type


''
Constructor Game()
	
	''
	Planets_.Reserve( MAX_PLANETS )
	Rockets_.Reserve( MAX_ROCKETS )
	Roxels_.Reserve( MAX_ROXELS )
	SpaceShips_.Reserve( MAX_SPACE_SHIPS )
	Thrusters_.Reserve( MAX_THRUSTERS )
	
	''
	PrepareGame()
	
End Constructor


''
Destructor Game()
	
	
	
	''
	Planets_.Destroy()
	Rockets_.Destroy()
	Roxels_.Destroy()
	
	''
	If ( Not SpaceShips_.Empty ) Then
		
		For SP As SpaceShip Ptr = SpaceShips_.p_front To SpaceShips_.p_back
			
			SP->Thrusters_.Destroy()
			
		Next
		
	EndIf
	
	SpaceShips_.Destroy()
	Thrusters_.Destroy()
	
End Destructor


''
Sub Game.ComputeData()
	
	''
	GameWorld.ComputeData()
	
	'' Planets
	If ( Not Planets_.Empty ) Then 
		
		For PP As Planet Ptr = Planets_.p_front To Planets_.p_back
			
			
		Next
		
	EndIf
	
	'' Rockets
	If ( Not Rockets_.Empty ) Then 
		
		For RP As Rocket Ptr = Rockets_.p_front To Rockets_.p_back
			
			
		Next
		
	EndIf
	
	'' Roxels
	If ( Not Roxels_.Empty ) Then
		
		For RP As Roxel Ptr = Roxels_.p_front To Roxels_.p_back
			
			
		Next
		
	EndIf
	
End Sub

Sub Game.ComputeNewState()
	
	''
	GameWorld.ComputeNewState()
	
	''
	If ( Not Planets_.Empty ) Then 
		
		For PP As Planet Ptr = Planets_.p_front To Planets_.p_back
			
			If PP->GetFlag( IS_ALIVE Or IS_DYNAMIC ) Then
				
				PP->ComputeNewState()
				
			End If
			
		Next
		
	EndIf
	
	''
	If ( Not Rockets_.Empty ) Then 
		
		For RP As Rocket Ptr = Rockets_.p_front To Rockets_.p_back
			
			If RP->GetFlag( IS_ALIVE Or IS_DYNAMIC ) Then
				
				RP->ComputeNewState()
				
			End If
			
		Next
		
	EndIf
	
	''
	If ( Not Roxels_.Empty ) Then
		
		For RP As Roxel Ptr = Roxels_.p_front To Roxels_.p_back
			
			If RP->GetFlag( IS_ALIVE Or IS_DYNAMIC ) Then
				
				RP->ComputeNewState()
				
			End If
			
		Next
		
	EndIf
	
End Sub

Sub Game.PrepareGame()
	
	''
	GameScreen.Create()
	'GameScreen.Create( SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_BIT_DEPTH, SCREEN_FLAGS )
	GameCamera.Create( GameScreen.WIDTH, GameScreen.HEIGHT, CAMERA_ZOOM_MAX )
	
	GameCamera.RestZoom( 5.0 )
	
	Color( RGB( 192, 192, 192 ), RGB( 12, 16, 20 ) )
	
	WindowTitle "Graveyard Orbit - A 2D space physics puzzle game - v. 0.2.1 - Press 1-9 for demo levels"
	
	''
	Intro()
	
End Sub

sub Game.PrintToConsole( ByVal text as String )
	
	open cons for output as #1
	print #1, text
	close #1
	
End Sub

Sub Game.RunGameLoop()
	
	Dim As Rocket Ptr Player = Rockets_.p_front
	
	Do
		
		If ( Focus_on_ship_ = TRUE ) Then 
			
			GameCamera.RestPosition_ = Player->GetPosition + ( Player->GetVelocity * DT ) * ( 70.0 / GameCamera.Zoom_ )
			'GameCamera.Position_ = Player->GetPosition '+ ( Player->GetVelocity * DT * 10.0 ) / ( GameCamera.Zoom_  )
			
		EndIf
		
		'GameCamera.RestPosition_ = IIf( Focus_on_ship_ = TRUE , Player->GetPosition, Vec2( 0.0, 0.0 ) )
		
		''
		If ( ScreenEvent( @e ) ) Then
			
			Select Case e.type
			
			Case fb.EVENT_KEY_PRESS
				
				''
				If ( e.scancode = fb.SC_0 ) Then Intro()
				If ( e.scancode = fb.SC_1 ) Then Puzzle1()
				If ( e.scancode = fb.SC_2 ) Then Puzzle2()
				If ( e.scancode = fb.SC_3 ) Then Puzzle3()
				If ( e.scancode = fb.SC_4 ) Then Puzzle4()
				If ( e.scancode = fb.SC_5 ) Then Puzzle5()
				If ( e.scancode = fb.SC_6 ) Then Puzzle6()
				If ( e.scancode = fb.SC_7 ) Then Puzzle7()
				If ( e.scancode = fb.SC_8 ) Then Puzzle8()
				If ( e.scancode = fb.SC_9 ) Then Puzzle9()
				
				''
				If ( e.scancode = fb.SC_S ) Then 
			 
					If ( Player->Grapple_ = 0 ) Then 
						
						Dim As LinearState Ptr L = FindNearestRoxel( Player, 1000 )
						
						If ( L = 0 ) Then L = FindNearestLinearState( Player, 1000 )
						
						If ( Not L = 0 ) Then
							
							Player->Grapple_ = GameWorld.CreateLinearSpring( 0.2, 0.5, 0.5, Player, L )
						
						End If
						
					Else
						
						If ( GameWorld.LinearSprings_.Remove( Player->Grapple_ ) ) Then
							
							Player->Grapple_ = 0
							
						EndIf
						
					EndIf
					
				EndIf
				
				''
				If ( e.scancode = fb.SC_F ) Then 
					
					Focus_on_ship_ Xor= TRUE
					
					GameCamera.RestZoom_     = IIf( Focus_on_ship_ = TRUE , 5 , 100 )
					GameCamera.RestPosition_ = IIf( Focus_on_ship_ = TRUE , Player->GetPosition, Vec2( 0.0, 0.0 ) )
					
				EndIf
				
				''
				If ( e.scancode = fb.SC_ESCAPE ) Then End
				
			Case fb.EVENT_KEY_RELEASE
				
			Case fb.EVENT_KEY_REPEAT
				
			Case fb.EVENT_MOUSE_MOVE
				
			Case fb.EVENT_MOUSE_BUTTON_PRESS
				
				If ( e.button = fb.BUTTON_LEFT ) Then
					
				End If
				
				If ( e.button = fb.BUTTON_RIGHT ) Then
					
				End If
				
			Case fb.EVENT_MOUSE_BUTTON_RELEASE
				
				If ( e.button = fb.BUTTON_LEFT ) Then
					
				End If
				
				If ( e.button = fb.BUTTON_RIGHT ) Then
					
				End If
				
			Case fb.EVENT_MOUSE_WHEEL
				
			Case fb.EVENT_WINDOW_CLOSE
				
				End
				
			End Select
			
		End If
		
		''
		If MultiKey( fb.SC_PERIOD ) Then GameCamera.RestZoom_ /= 1.01
		If MultiKey( fb.SC_COMMA  ) Then GameCamera.Restzoom_ *= 1.01
		
		''
		If ( focus_on_Ship_ = TRUE ) Then
			
			If MultiKey( fb.SC_UP )    Then GameCamera.RestPosition_.y += SCREEN_HEIGHT * GameCamera.Zoom_ * 0.4
			If MultiKey( fb.SC_DOWN )  Then GameCamera.RestPosition_.y -= SCREEN_HEIGHT * GameCamera.Zoom_ * 0.4
			If MultiKey( fb.SC_LEFT )  Then GameCamera.RestPosition_.x -= SCREEN_WIDTH  * GameCamera.Zoom_ * 0.4
			If MultiKey( fb.SC_RIGHT ) Then GameCamera.RestPosition_.x += SCREEN_WIDTH  * GameCamera.Zoom_ * 0.4
			
		Else
			
			If MultiKey( fb.SC_UP )    Then GameCamera.RestPosition_.y += GameCamera.Zoom_ * 3.0
			If MultiKey( fb.SC_DOWN )  Then GameCamera.RestPosition_.y -= GameCamera.Zoom_ * 3.0
			If MultiKey( fb.SC_LEFT )  Then GameCamera.RestPosition_.x -= GameCamera.Zoom_ * 3.0
			If MultiKey( fb.SC_RIGHT ) Then GameCamera.RestPosition_.x += GameCamera.Zoom_ * 3.0
		
		EndIf
		
		''
		If MultiKey( fb.SC_W ) Then Player->ApplyThrust( ROCKET_THRUST )
		
		''
		If MultiKey( fb.SC_A ) Then Player->AddAngle(  ROCKET_DELTA_ANGLE * TWO_PI )
		If MultiKey( fb.SC_D ) Then Player->AddAngle( -ROCKET_DELTA_ANGLE * TWO_PI )
		
		''
		If MultiKey( fb.SC_PLUS ) Then 
			
			Dim As Roxel Ptr RP = CreateRoxel( 1e7, 32.0, RGB( 0, 0, 0 ), RGB( 128, 64, 32 ) )
			
			RP->LowerFlag( IS_DYNAMIC )
			
			RP->SetPosition( GameWorld.RigidBodys_[0]->getposition + Vec2().RandomizeCircle( 1.0 ) * 1000 )
			
			GameWorld.RigidBodys_[0]->InsertLinearState( RP )
			
		EndIf
		
		If MultiKey( fb.SC_MINUS ) Then 
			
			GameWorld.RigidBodys_[0]->RemoveLinearState( GameWorld.RigidBodys_[0]->LinearStates_.i_back )
			
		EndIf
		
		''
		GameWorld.ApplyImpulses()
		
		''
		If ( Not GameWorld.ShapeBodys_.Empty ) Then 
			
			For I As ShapeBody Ptr = GameWorld.ShapeBodys_.p_front To GameWorld.ShapeBodys_.p_back
				
				If ( I->GetFlag( IS_ALIVE Or IS_DYNAMIC ) ) Then
					
					I->ApplyImpulseDispersion()
					
				End If
				
			Next
			
		End If
		
		''' ???
		'If ( Not GameWorld.SoftBodys_.Empty ) Then 
		'	
		'	For I As Body Ptr = GameWorld.SoftBodys_.p_front To GameWorld.SoftBodys_.p_back
		'		
		'		If ( I->GetFlag( IS_ALIVE Or IS_DYNAMIC ) ) Then
		'			
		'			I->ApplyImpulseDispersion()
		'			
		'		End If
		'		
		'	Next
		'	
		'End If
		
		''
		ComputeNewState()
		
		
		ComputeData()
		
		If ( Not Player->Grapple_ = 0 ) Then 
							
			Player->Grapple_->GetLinearLink->ComputeMass()
			Player->Grapple_->GetLinearLink->ComputeStateVectors()
		
		End If
		
		''
		If ( Not GameWorld.ShapeBodys_.Empty ) Then 
			
			For I As ShapeBody Ptr = GameWorld.ShapeBodys_.p_front To GameWorld.ShapeBodys_.p_back
				
				If ( I->GetFlag( IS_ALIVE Or IS_DYNAMIC ) ) Then
					
					I->ComputeNewState()
					
				End If
				
			Next
			
		End If
		
		If ( Not GameWorld.SoftBodys_.Empty ) Then 
			
			For I As SoftBody Ptr = GameWorld.SoftBodys_.p_front To GameWorld.SoftBodys_.p_back
				
				If ( I->GetFlag( IS_ALIVE Or IS_DYNAMIC ) ) Then
					
					I->ComputeNewState()
					
				End If
				
			Next
			
		End If
		
		GameCamera.Update()
		
		''
		RenderToScreen()
		
		''
		ResetImpulses()
		
		''
		'Sleep( 1, 1 )
		
	Loop Until MultiKey(1)
	
End Sub

Sub Game.RenderToScreen()
	
	''	
	'ScreenSync()
	
	ScreenLock()
	
	Cls()
	
	''
	If ( Not Rockets_.Empty ) Then 
		
		Locate  8, 2: Print "Fuel    : "; Rockets_.p_front->GetFuelMass()
		Locate 10, 2: Print "Delta V : "; Rockets_.p_front->GetDeltaV()
	
	EndIf
	
	''
	If ( Not GameWorld.NewtonGravitys_.Empty ) Then 
		
		For NP As NewtonGravity Ptr = GameWorld.NewtonGravitys_.p_front To GameWorld.NewtonGravitys_.p_back
			
			If NP->GetLinearLink->GetFlag( IS_VISIBLE ) Then
				
				Line( NP->GetLinearLink->GetLinearStateB->GetPosition.x, NP->GetLinearLink->GetLinearStateB->GetPosition.y )-_
				    ( NP->GetLinearLink->GetLinearStateA->GetPosition.x, NP->GetLinearLink->GetLinearStateA->GetPosition.y ), RGB( 64, 32, 64 )
				
				Circle( NP->GetLinearLink->GetPosition.x, NP->GetLinearLink->GetPosition.y ), 4.0, RGB( 96, 48, 96 ),,,1,f
				
			EndIf
			
		Next
	
	EndIf
	
	''
	If ( Not GameWorld.KeplerOrbits_.Empty ) Then 
		
		For KP As KeplerOrbit Ptr = GameWorld.KeplerOrbits_.p_front To GameWorld.KeplerOrbits_.p_back
			
			If KP->GetLinearLink->GetFlag( IS_VISIBLE ) Then
				
				KP->DrawOrbit()
				
			End If
			
		Next
		
	EndIf
	
	If ( Not Rockets_.Empty  ) Then
		
		'GameWorld.FindOrbit( Rockets_[0], @GameWorld.KeplerOrbits_ )
		'GameWorld.FindOrbit( Rockets_[0], Cast( LinearLinkArray Ptr, @GameWorld.KeplerOrbits_ ) )
		'Dim As LinearState Ptr O = GameWorld.FindOrbit( Rockets_[0], Cast( LinearLinkArray Ptr, @GameWorld.KeplerOrbits_ ) )
		
		Dim As LinearState Ptr O = GameWorld.FindOrbit( Rockets_[0], Cast( LinearLinkArray Ptr, @GameWorld.NewtonGravitys_ ) )
		
		'Dim As LinearState Ptr O = GameWorld.FindOrbit( Rockets_[0], @GameWorld.NewtonGravitys_ )
		
		If ( Not O = 0 ) Then
			
			Dim As KeplerOrbit K = KeplerOrbit( Rockets_[0], O )
			
			k.DrawOrbit()
			
		End If
		
		'Dim As KeplerOrbit K = KeplerOrbit( Rockets_[0], GameWorld.KeplerOrbits_[0] )
		'k.DrawOrbit()
		
		'Dim As LinearState Ptr L = GameWorld.FindNearest( Rockets_[0], @GameWorld.LinearStates_ )
		'
		'If ( Not L = 0 ) Then
		'	
		'	Line( L->GetPosition.x, L->GetPosition.y )-_
		'	    ( Rockets_[0]->GetPosition.x, Rockets_[0]->GetPosition.y ), RGB( 255, 255, 0)
		'	
		'	'Circle( N->GetPosition.x, N->GetPosition.y ), 256, RGB( 255, 255, 0),,,1
		'	
		'End If
		'
		'Dim As LinearState Ptr R = GameWorld.FindNearest( Rockets_[0], @Roxels_ )
		'Dim As LinearState Ptr R = GameWorld.FindNearest( Rockets_[0], Cast( LinearStateArray Ptr, @Roxels_ ) )
		
		'If ( Not R = 0 ) Then
		'	
		'	Line( R->GetPosition.x, R->GetPosition.y )-_
		'	    ( Rockets_[0]->GetPosition.x, Rockets_[0]->GetPosition.y ), RGB( 0, 0, 255)
		'	
		'	'Circle( N->GetPosition.x, N->GetPosition.y ), 256, RGB( 255, 255, 0),,,1
		'	
		'End If
		
	EndIf
	
	''
	If ( Not GameWorld.LinearLinks_.Empty ) Then
		
		For L As LinearLink Ptr = GameWorld.LinearLinks_.p_front To GameWorld.LinearLinks_.p_back
			
			If L->GetFlag( IS_VISIBLE ) Then
				
				Line( L->GetLinearStateA->GetPosition.x, L->GetLinearStateA->GetPosition.y )-_
				    ( L->GetLinearStateB->GetPosition.x, L->GetLinearStateB->GetPosition.y ),  RGB( 128, 128, 128 )
				
				Circle( L->GetPosition.x, L->GetPosition.y ), 2.0, RGB( 128, 128, 128 ),,,1,f
				
			EndIf
			
		Next
		
	EndIf
	
	''
	If ( Not GameWorld.LinearSprings_.Empty ) Then
		
		For L As LinearSpring Ptr = GameWorld.LinearSprings_.p_front To GameWorld.LinearSprings_.p_back
			
			If L->GetLinearLink->GetFlag( IS_VISIBLE ) Then
				
				Line( L->GetLinearLink->GetLinearStateA->GetPosition.x, L->GetLinearLink->GetLinearStateA->GetPosition.y )-_
				    ( L->GetLinearLink->GetLinearStateB->GetPosition.x, L->GetLinearLink->GetLinearStateB->GetPosition.y ),  RGB( 128, 128, 128 )
				
				Circle( L->GetLinearLink->GetPosition.x, L->GetLinearLink->GetPosition.y ), 2.0, RGB( 128, 128, 128 ),,,1,f
				
			EndIf
			
		Next
		
	EndIf
	
	''
	If ( Not GameWorld.FixedSprings_.Empty ) Then
		
		For L As FixedSpring Ptr = GameWorld.FixedSprings_.p_front To GameWorld.FixedSprings_.p_back
			
			If L->GetLinearLink->GetFlag( IS_VISIBLE ) Then
				
				Line( L->GetLinearLink->GetLinearStateA->GetPosition.x, L->GetLinearLink->GetLinearStateA->GetPosition.y )-_
				    ( L->GetLinearLink->GetLinearStateB->GetPosition.x, L->GetLinearLink->GetLinearStateB->GetPosition.y ),  RGB( 128, 128, 128 )
				
				Circle( L->GetLinearLink->GetPosition.x, L->GetLinearLink->GetPosition.y ), 2.0, RGB( 128, 128, 128 ),,,1,f
				
			EndIf
			
		Next
		
	EndIf
	
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
	If ( Not Thrusters_.Empty ) Then 
			
		For TP As Thruster Ptr = Thrusters_.p_front To Thrusters_.p_back
			
			If TP->GetFlag( IS_VISIBLE ) Then
				
			
			EndIf
			
		Next
		
	EndIf
	
	''
	If ( Not SpaceShips_.Empty ) Then 
			
		For SP As SpaceShip Ptr = SpaceShips_.p_front To SpaceShips_.p_back
			
			If SP->GetFlag( IS_VISIBLE ) Then
				
			
			EndIf
			
		Next
		
	EndIf
	
	
	''
	If ( Not GameWorld.LinearStates_.Empty ) Then
		
		For P As LinearState Ptr = GameWorld.LinearStates_.p_front To GameWorld.LinearStates_.p_back
			
			If P->GetFlag( IS_VISIBLE ) Then
					
				Circle( P->GetPosition.x, P->GetPosition.y ), 3.0 , RGB( 144, 144, 144 ),,,1,f
				
			EndIf
			
		Next
		
	EndIf
	
	'' Roxels
	If ( Not Roxels_.Empty ) Then
		
		'' Background
		For R As Roxel Ptr = Roxels_.p_front To Roxels_.p_back
			
			If R->GetFlag( IS_VISIBLE ) Then
					
				Circle( R->GetPosition.x, R->GetPosition.y ), R->GetRadius + 16.0 , R->GetBackGroundColour,,, 1, f
				
			EndIf
			
		Next
		
		'' Foreground 
		For R As Roxel Ptr = Roxels_.p_front To Roxels_.p_back
			
			If R->GetFlag( IS_VISIBLE ) Then
					
				Circle( R->GetPosition.x, R->GetPosition.y ), R->GetRadius, R->GetForeGroundColour,,, 1, f
				
			EndIf
			
		Next
		
	EndIf
	
	''
	If ( Not Planets_.Empty ) Then 
		
		For PP As Planet Ptr = Planets_.p_front To Planets_.p_back
			
			If PP->GetFlag( IS_VISIBLE ) Then
				
				Circle( PP->GetPosition.x, PP->GetPosition.y ), PP->GetRadius , PP->GetColour,,, 1, f
				
				Dim As Vec2 nrm = PP->GetPosition + PP->GetAngleVector         * 32
				Dim As Vec2 lft = PP->GetPosition + PP->GetAngleVector.PerpCCW * 32
				Dim As Vec2 rgt = PP->GetPosition + PP->GetAngleVector.PerpCW  * 32
				
				Line( PP->GetPosition.x, PP->GetPosition.y )-( nrm.x, nrm.y ), RGB( 255, 255, 255 )
				Line( PP->GetPosition.x, PP->GetPosition.y )-( lft.x, lft.y ), RGB( 255, 0, 0 )
				Line( PP->GetPosition.x, PP->GetPosition.y )-( rgt.x, rgt.y ), RGB( 0, 255, 0 )
				
				Circle( PP->GetPosition.x, PP->GetPosition.y ), 2.0, RGB( 255, 255, 255 ),,, 1, f
				
			EndIf
			
		Next
		
	EndIf
	
	''
	If ( Not GameWorld.RigidBodys_.Empty ) Then 
		
		For S As RigidBody Ptr = GameWorld.RigidBodys_.p_front To GameWorld.RigidBodys_.p_back
			
			If S->GetFlag( IS_VISIBLE ) Then
				
				Dim As Vec2 nrm = S->GetPosition + S->GetAngleVector         * 32
				Dim As Vec2 lft = S->GetPosition + S->GetAngleVector.PerpCCW * 32
				Dim As Vec2 rgt = S->GetPosition + S->GetAngleVector.PerpCW  * 32
				
				Line( S->GetPosition.x, S->GetPosition.y )-( nrm.x, nrm.y ), RGB( 255, 255, 255 )
				Line( S->GetPosition.x, S->GetPosition.y )-( lft.x, lft.y ), RGB( 255, 0, 0 )
				Line( S->GetPosition.x, S->GetPosition.y )-( rgt.x, rgt.y ), RGB( 0, 255, 0 )
				
				Circle( S->GetPosition.x, S->GetPosition.y ), 2.0, RGB( 255, 255, 255 ),,, 1, f
				
			EndIf
				
		Next
	
	EndIf
	
	''
	If ( Not GameWorld.ShapeBodys_.Empty ) Then 
		
		For S As ShapeBody Ptr = GameWorld.ShapeBodys_.p_front To GameWorld.ShapeBodys_.p_back
			
			If S->GetFlag( IS_VISIBLE ) Then
				
				Dim As Vec2 nrm = S->GetPosition + S->GetAngleVector         * 32
				Dim As Vec2 lft = S->GetPosition + S->GetAngleVector.PerpCCW * 32
				Dim As Vec2 rgt = S->GetPosition + S->GetAngleVector.PerpCW  * 32
				
				Line( S->GetPosition.x, S->GetPosition.y )-( nrm.x, nrm.y ), RGB( 255, 255, 255 )
				Line( S->GetPosition.x, S->GetPosition.y )-( lft.x, lft.y ), RGB( 255, 0, 0 )
				Line( S->GetPosition.x, S->GetPosition.y )-( rgt.x, rgt.y ), RGB( 0, 255, 0 )
				
				Circle( S->GetPosition.x, S->GetPosition.y ), 2.0, RGB( 255, 255, 255 ),,, 1, f
				
			EndIf
				
		Next
	
	EndIf
	
	''
	If ( Not GameWorld.SoftBodys_.Empty ) Then 
		
		For S As SoftBody Ptr = GameWorld.SoftBodys_.p_front To GameWorld.SoftBodys_.p_back
			
			If S->GetFlag( IS_VISIBLE ) Then
				
				Dim As Vec2 nrm = S->GetPosition + S->GetAngleVector         * 32
				Dim As Vec2 lft = S->GetPosition + S->GetAngleVector.PerpCCW * 32
				Dim As Vec2 rgt = S->GetPosition + S->GetAngleVector.PerpCW  * 32
				
				Line( S->GetPosition.x, S->GetPosition.y )-( nrm.x, nrm.y ), RGB( 255, 255, 255 )
				Line( S->GetPosition.x, S->GetPosition.y )-( lft.x, lft.y ), RGB( 255, 0, 0 )
				Line( S->GetPosition.x, S->GetPosition.y )-( rgt.x, rgt.y ), RGB( 0, 255, 0 )
				
				Circle( S->GetPosition.x, S->GetPosition.y ), 2.0, RGB( 255, 255, 255 ),,, 1, f
				
			EndIf
				
		Next
	
	EndIf
	
	''
	If ( Not GameWorld.Bodys_.Empty ) Then 
		
		For S As Body Ptr = GameWorld.Bodys_.p_front To GameWorld.Bodys_.p_back
			
			'If S->GetFlag( IS_VISIBLE ) Then
				
				Dim As Vec2 nrm = S->GetPosition + S->GetAngleVector         * 32
				Dim As Vec2 lft = S->GetPosition + S->GetAngleVector.PerpCCW * 32
				Dim As Vec2 rgt = S->GetPosition + S->GetAngleVector.PerpCW  * 32
				
				Line( S->GetPosition.x, S->GetPosition.y )-( nrm.x, nrm.y ), RGB( 255, 255, 255 )
				Line( S->GetPosition.x, S->GetPosition.y )-( lft.x, lft.y ), RGB( 255, 0, 0 )
				Line( S->GetPosition.x, S->GetPosition.y )-( rgt.x, rgt.y ), RGB( 0, 255, 0 )
				
				Circle( S->GetPosition.x, S->GetPosition.y ), 2.0, RGB( 255, 255, 255 ),,, 1, f
				
			'EndIf
				
		Next
	
	EndIf
	
	''
	Locate 2, 2: Print World_description_
	Locate 4, 2: Print Puzzle_description_
	
	'ScreenCopy()
	ScreenUnLock()
	
End Sub


''
Sub Game.ResetAll()
	
	GameWorld.ResetAll()
	
	Planets_.Clear()
	Rockets_.Clear()
	Roxels_.Clear()
	SpaceShips_.Clear()
	Thrusters_.Clear()
	
	World_description_  = ""
	Puzzle_description_ = ""
	
End Sub

Sub Game.ResetImpulses()
	
	'' Base objects
	GameWorld.ResetImpulses()
	
	'' Planets
	If ( Not Planets_.Empty ) Then 
		
		For PP As Planet Ptr = Planets_.p_front To Planets_.p_back
			
			PP->SetImpulse( Vec2( 0.0, 0.0 ) )
			PP->SetAngularImpulse( 0.0 )
			
		Next
		
	EndIf
	
	'' Rockets
	If ( Not Rockets_.Empty ) Then 
		
		For RP As Rocket Ptr = Rockets_.p_front To Rockets_.p_back
			
			RP->SetImpulse( Vec2( 0.0, 0.0 ) )
			RP->SetAngularImpulse( 0.0 )
			
		Next
		
	EndIf
	
	'' Roxels
	If ( Not Roxels_.Empty ) Then
		
		For RP As Roxel Ptr = Roxels_.p_front To Roxels_.p_back
			
			RP->SetImpulse( Vec2( 0.0, 0.0 ) )
			
		Next
		
	EndIf
	
	'' Thrusters
	If ( Not Thrusters_.Empty ) Then
		
		For RP As Thruster Ptr = Thrusters_.p_front To Thrusters_.p_back
			
			RP->SetImpulse( Vec2( 0.0, 0.0 ) )
			RP->SetAngularImpulse( 0.0 )
			
		Next
		
	EndIf
	
End Sub

Function Game.FindNearestLinearState( ByVal l As LinearState Ptr, ByVal distance As Single ) As LinearState Ptr
	
	'' Return pointer to closest object within threshold distance
	
	Dim As LinearState Ptr Nearest = 0
	
	Dim As Single inv_dst_sqd = 1.0 / ( distance * distance )
	
	''
	If ( Not GameWorld.LinearStates_.Empty ) Then
		
		For N As LinearState Ptr = GameWorld.LinearStates_.p_front To GameWorld.LinearStates_.p_back
			
			Dim As Single this_inv_dist_sqd = 1.0 / ( l->GetPosition - N->GetPosition ).LengthSquared()
			
			If ( this_inv_dist_sqd > inv_dst_sqd ) Then
				
				inv_dst_sqd = this_inv_dist_sqd
				
				Nearest = N
				
			EndIf
			
		Next
		
	EndIf
	
	''
	If ( Not GameWorld.LinearSprings_.Empty ) Then
		
		For N As LinearSpring Ptr = GameWorld.LinearSprings_.p_front To GameWorld.LinearSprings_.p_back
			
			Dim As Single this_inv_dist_sqd = 1.0 / ( l->GetPosition - N->GetLinearLink->GetPosition ).LengthSquared()
			
			If ( this_inv_dist_sqd > inv_dst_sqd ) Then
				
				inv_dst_sqd = this_inv_dist_sqd
				
				Nearest = ( N->GetLinearLink )
				
			EndIf
			
		Next
		
	EndIf
	
	''
	If ( Not GameWorld.FixedSprings_.Empty ) Then
		
		For N As FixedSpring Ptr = GameWorld.FixedSprings_.p_front To GameWorld.FixedSprings_.p_back
			
			Dim As Single this_inv_dist_sqd = 1.0 / ( l->GetPosition - N->GetLinearLink->GetPosition ).LengthSquared()
			
			If ( this_inv_dist_sqd > inv_dst_sqd ) Then
				
				inv_dst_sqd = this_inv_dist_sqd
				
				Nearest = ( N->GetLinearLink )
				
			EndIf
			
		Next
		
	EndIf
	
	''
	If ( Not GameWorld.SoftBodys_.Empty ) Then
		
		For N As SoftBody Ptr = GameWorld.SoftBodys_.p_front To GameWorld.SoftBodys_.p_back
			
			Dim As Single this_inv_dist_sqd = 1.0 / ( l->GetPosition - N->GetPosition ).LengthSquared()
			
			If ( this_inv_dist_sqd > inv_dst_sqd ) Then
				
				inv_dst_sqd = this_inv_dist_sqd
				
				Nearest = N
				
			EndIf
			
		Next
		
	EndIf
	
	''
	If ( Not GameWorld.ShapeBodys_.Empty ) Then
		
		For N As ShapeBody Ptr = GameWorld.ShapeBodys_.p_front To GameWorld.ShapeBodys_.p_back
			
			Dim As Single this_inv_dist_sqd = 1.0 / ( l->GetPosition - N->GetPosition ).LengthSquared()
			
			If ( this_inv_dist_sqd > inv_dst_sqd ) Then
				
				inv_dst_sqd = this_inv_dist_sqd
				
				Nearest = N
				
			EndIf
			
		Next
		
	EndIf
	
	''
	If ( Not GameWorld.RigidBodys_.Empty ) Then
		
		For N As RigidBody Ptr = GameWorld.RigidBodys_.p_front To GameWorld.RigidBodys_.p_back
			
			Dim As Single this_inv_dist_sqd = 1.0 / ( l->GetPosition - N->GetPosition ).LengthSquared()
			
			If ( this_inv_dist_sqd > inv_dst_sqd ) Then
				
				inv_dst_sqd = this_inv_dist_sqd
				
				Nearest = N
				
			EndIf
			
		Next
		
	EndIf
	
	Return Nearest
	
End Function

Function Game.FindNearestRoxel( ByVal l As LinearState Ptr, ByVal distance As Single ) As LinearState Ptr
	
	'' Return pointer to closest object
	
	Dim As LinearState Ptr Nearest = 0
	
	Dim As Single inv_dst_sqd = 1.0 / ( distance * distance )
	
	If ( Not Roxels_.Empty ) Then
		
		For N As Roxel Ptr = Roxels_.p_front To Roxels_.p_back
			
			Dim As Single this_inv_dist_sqd = 1.0 / ( l->GetPosition - N->GetPosition ).LengthSquared()
			
			If ( this_inv_dist_sqd > inv_dst_sqd ) Then
				
				inv_dst_sqd = this_inv_dist_sqd
				
				Nearest = N
				
			EndIf
			
		Next
		
	EndIf
	
	Return Nearest
	
End Function


#EndIf __GO_GAME_BI__
