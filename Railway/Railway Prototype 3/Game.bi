''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 3, september 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''******************************************************************************* 

Type GameType
	
	''
	Declare Constructor()
	Declare Destructor()
	
	
	''
	Declare Function CreateWinchConstraint( ByVal rope_ As DistanceConstraintType Ptr, _
	                                        ByVal drum_ As AngularStateType Ptr ) As WinchConstraintType Ptr
	
	Declare Function CreateLinearState( ByVal _mass  As Single, _
	                                    ByVal _array As LinearStateArray Ptr  ) As LinearStateType Ptr
	
	Declare Function CreateLinearState( ByVal _position As Vec2, _
	                                    ByVal _mass     As Single, _
	                                    ByVal _array    As LinearStateArray Ptr ) As LinearStateType Ptr
	
	Declare Function CreateRoxel( ByVal _position As Vec2, _
	                              ByVal _mass     As Single, _
	                              ByVal _radius   As Single ) As RoxelType Ptr
	
	Declare Function CreateBox( ByVal _position As Vec2, _
	                            ByVal _radius   As Vec2 ) As BoxType Ptr
	
	Declare Function CreateBox( ByVal _position As Vec2, _
	                            ByVal _radius   As Vec2, _ 
	                            ByVal _angle    As Single) As BoxType Ptr
	
	Declare Function CreateBox( ByVal _position As Vec2, _
	                            ByVal _mass     As Single, _
	                            ByVal _radius   As Vec2 ) As BoxType Ptr
	
	Declare Function CreateBox( ByVal _width     As Single, _
	                            ByVal _position1 As Vec2, _
	                            ByVal _position2 As Vec2 ) As BoxType Ptr
	
	Declare Function CreateWheel( ByVal _position As Vec2, _
	                              ByVal _radius   As Single ) As WheelType Ptr
	
	Declare Function CreateWheel( ByVal _position As Vec2, _
	                              ByVal _radius   As Single, _ 
	                              ByVal _angle    As Single ) As WheelType Ptr
	
	'Declare Function CreateWheel( ByVal _position As Vec2, _
	'                              ByVal _mass     As Single, _
	'                              ByVal _radius   As Single ) As WheelType Ptr
	
	Declare Function CreateAngularSpring( ByVal _STIFFNESS As Single, _
	                                      ByVal _damping   As Single, _
	                                      ByVal _warmstart As Single, _
	                                      ByVal _linear1   As LinearLinkType Ptr, _
	                                      ByVal _linear2   As LinearLinkType Ptr, _
	                                      ByVal _array     As AngularSpringArray Ptr ) As AngularSpringType Ptr
	
	Declare Function CreateFixedSpring( ByVal _STIFFNESS As Single, _
	                                    ByVal _damping   As Single, _
	                                    ByVal _warmstart As Single, _
	                                    ByVal _linear1   As LinearStateType Ptr, _
	                                    ByVal _linear2   As LinearStateType Ptr, _
	                                    ByVal _array     As FixedSPringArray Ptr ) As FixedSpringType Ptr
	
	Declare Function CreateLinearSpring( ByVal _linear1 As LinearStateType Ptr, _
	                                     ByVal _linear2 As LinearStateType Ptr, _
	                                     ByVal _array   As LinearSpringArray Ptr ) As LinearSpringType Ptr
	
	Declare Function CreateLinearSpring( ByVal _STIFFNESS As Single, _
	                                     ByVal _damping   As Single, _
	                                     ByVal _warmstart As Single, _
	                                     ByVal _linear1   As LinearStateType Ptr, _
	                                     ByVal _linear2   As LinearStateType Ptr, _
	                                     ByVal _array     As LinearSpringArray Ptr ) As LinearSpringType Ptr
	
	Declare Function CreateGearConstraint( ByVal _Angular1 As AngularStateType Ptr, _
	                                  ByVal _Angular2 As AngularStateType Ptr, _
	                                  ByVal _Radius1 As Single, _ 
	                                  ByVal _Radius2 As Single  ) As GearConstraintType Ptr
	
	'Declare Function CreateGearConstraint( ByVal _Angular1  As AngularStateType Ptr, _
	'                                  ByVal _Angular2  As AngularStateType Ptr, _
	'                                  ByVal _Gear_Ratio As Single ) As GearConstraintType Ptr
	
	Declare Function CreateRevoluteConstraint( ByVal _Position As Vec2, _ 
	                                      ByVal _Angular1 As AngularStateType Ptr, _
	                                      ByVal _Angular2 As AngularStateType Ptr ) As RevoluteConstraintType Ptr
	
	Declare Function CreateRevoluteConstraint( ByVal _Position  As Vec2, _ 
	                                      ByVal _STIFFNESS As Single, _
	                                      ByVal _damping   As Single, _
	                                      ByVal _warmstart As Single, _
	                                      ByVal _Angular1  As AngularStateType Ptr, _
	                                      ByVal _Angular2  As AngularStateType Ptr ) As RevoluteConstraintType Ptr
	
	Declare Function CreateDistanceConstraint( ByVal _Position1 As Vec2, _ 
	                                      ByVal _Position2 As Vec2, _ 
	                                      ByVal _Angular1  As AngularStateType Ptr, _
	                                      ByVal _Angular2  As AngularStateType Ptr ) As DistanceConstraintType Ptr
	
	Declare Function CreateDistanceConstraint( ByVal _Position1  As Vec2, _ 
	                                      ByVal _Position2  As Vec2, _ 
	                                      ByVal _Restlength As Single, _
	                                      ByVal _Angular1   As AngularStateType Ptr, _
	                                      ByVal _Angular2   As AngularStateType Ptr ) As DistanceConstraintType Ptr
	
	Declare Function CreateSlideConstraint( ByVal _Line     As Vec2, _ 
	                                   ByVal _Position As Vec2, _
	                                   ByVal _Angular1 As AngularStateType Ptr, _
	                                   ByVal _Angular2 As AngularStateType Ptr ) As SlideConstraintType Ptr
	
	Declare Function CreateSlideConstraint( ByVal _Line      As Vec2, _ 
	                                   ByVal _Position1 As Vec2, _ 
	                                   ByVal _Position2 As Vec2, _ 
	                                   ByVal _Angular1  As AngularStateType Ptr, _
	                                   ByVal _Angular2  As AngularStateType Ptr ) As SlideConstraintType Ptr
	
	Declare Function CreateAngularConstraint( ByVal _Angular1 As AngularStateType Ptr, _
	                                     ByVal _Angular2 As AngularStateType Ptr ) As AngularConstraintType Ptr
	
	Declare Function CreateRope( ByVal _unitlength As Single, _ 
	                             ByVal _unitlmass  As Single, _ 
	                             ByVal _linear1    As LinearStateType Ptr, _
	                             ByVal _linear2    As LinearStateType Ptr ) As SoftBodyType Ptr
	
	Declare Function CreateSoftGirder( ByVal _position As Vec2, _
	                                   ByVal _angle    As Vec2, _
	                                   ByVal _size     As Vec2, _
	                                   ByVal _unit     As Vec2, _
	                                   ByVal _type     As integer ) As SoftBodyType Ptr
	
	Declare Function CreateTree( ByVal _position As Vec2, _
	                             ByVal _angle    As Vec2, _
	                             ByVal _type     As integer ) As SoftBodyType Ptr
	
	
	Declare Sub ClearImpulses()
	Declare Sub ClearWarmstart()
	Declare Sub CollisionDetection()
	Declare Sub UpdateInput()
	Declare Sub UpdateScreen()
	Declare Sub RunGame()
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	Declare Sub ComputeData()
	Declare Sub ComputeRestImpulse()
	Declare Sub ComputeNewState()
	Declare Sub ClearAllArrays()
	
	''
	Declare Function FindClosestLinearLink() As LinearLinkType Ptr
	Declare Function FindClosestLinearState() As LinearStateType Ptr
	Declare Function FindClosestRoxel() As RoxelType Ptr
	
	Declare Function ClosestPointOnLinearLink( ByVal lp As LinearLinkType Ptr, ByVal p As Vec2 ) As Vec2
	
	''
	Declare Sub CollisionResponse( ByVal R1 As RoxelType Ptr, ByVal R2 As RoxelType Ptr )
	Declare Sub CollisionResponse( ByVal B1 As BoxType Ptr, ByVal B2 As BoxType Ptr )
	Declare Sub CollisionResponse( ByVal BP As BoxType Ptr, Byval LP As LinearLinkType Ptr )
	Declare Sub CollisionResponse( ByVal BP As BoxType Ptr, ByVal WP As WheelType Ptr )
	Declare Sub CollisionResponse( ByVal WP As WheelType Ptr, Byval LP As LinearLinkType Ptr )
	Declare Sub CollisionResponse( ByVal W1 As WheelType Ptr, ByVal W2 As WheelType Ptr )
	
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
	Declare Sub Puzzle0()
	
	''
	As fb.EVENT e
	
	As ScreenType GameScreen
	As Camera     GameCamera
	As Joystick   GameJoystick
	
	As String PuzzleText
	
	As Integer iterations
	As Integer warmstart
	
	As Vec2 position
	As Vec2 position_prev
	As Vec2 velocity
	
	As Integer button
	As Integer button_prev
	
	As Integer wheel
	As Integer wheel_prev
	
	As ULong Flags
	
	As LinearStateType Ptr picked
	As LinearStateType Ptr nearest
	
	''
	As LinearStateArray   linearstates
	As RoxelArray         roxels
	As AngularSpringArray angularsprings
	As LinearSpringArray  linearsprings
	As SoftBodyArray      softbodys
	
	As BoxArray           boxes
	As WheelArray         wheels
	As RevoluteConstraintArray constraints
	As DistanceConstraintArray distanceconstraints
	As AngularConstraintArray  angularconstraints
	As SlideConstraintArray    slideconstraints
	As GearConstraintArray     gearconstraints
	As WinchConstraintArray	winchconstraints
	
End Type


Constructor GameType()
	
	''
	LinearStates.Reserve( MAX_LINEAR_STATES )
	Roxels.Reserve( MAX_ROXELS )
	AngularSprings.Reserve( MAX_ANGULAR_SPRINGS )
	LinearSprings.Reserve( MAX_LINEAR_SPRINGS )
	SoftBodys.Reserve( MAX_SOFT_BODYS )
	boxes.Reserve( MAX_BOXES )
	wheels.Reserve( MAX_WHEELS )
	constraints.Reserve( MAX_REVOLUTE_CONSTRAINTS )
	distanceconstraints.Reserve( MAX_DISTANCE_CONSTRAINTS )
	angularconstraints.Reserve( MAX_ANGULAR_CONSTRAINTS )
	slideconstraints.Reserve( MAX_SLIDE_CONSTRAINTS )
	gearconstraints.Reserve( MAX_GEAR_CONSTRAINTS )
	winchconstraints.Reserve( MAX_WINCH_CONSTRAINTS )
	
	''
	ClearAllArrays()
	
	''
	'GameScreen.Create()
	GameScreen.Create( SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_BIT_DEPTH, SCREEN_FLAGS )
	GameCamera.Create( GameScreen.WIDTH * 0.5, GameScreen.HEIGHT * 0.5, CAMERA_ZOOM_MAX )
	Color( RGB( 224, 224, 224 ), RGB( 32, 40, 48 ) )
	WindowTitle "A 2D physics railway game engine - v. 0.3.0 - Press 0-9 for demo levels"
	
	''
	GameCamera.RestZoom( 2.0 )
	GameCamera.RestPosition( Vec2( SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5 ) )
	
	''
	Puzzle1()
	
	ComputeData()
	
	RunGame()
	
End Constructor

Destructor GameType()
	
	LinearStates.Destroy()
	Roxels.Destroy()
	SoftBodys.Destroy()
	AngularSprings.Destroy()
	LinearSprings.Destroy()
	boxes.Destroy()
	wheels.Destroy()
	constraints.Destroy()
	distanceconstraints.Destroy()
	angularconstraints.Destroy()
	slideconstraints.Destroy()
	gearconstraints.Destroy()
	winchconstraints.Destroy()
	
End Destructor


''	Main loop
Sub GameType.RunGame()
	
	Do
		
		''
		CollisionDetection()
		
		''
		If( warmstart ) Then 
			
			ApplyWarmStart() 
			
		Else 
		
			ClearWarmStart()
		
		EndIf
		
		''
		ComputeRestImpulse()
		
		''
		UpdateInput()
		
		''
		For i As Integer = 1 To iterations
			
			ApplyCorrectiveImpulse()
			
		Next
		
		'''
		'If ( Not SoftBodys.Empty ) Then
		'	
		'	For S As SoftBodyType Ptr = SoftBodys.P_front To SoftBodys.P_back
		'		
		'		S->DisperseImpulses()
		'		
		'	Next
		'	
		'EndIf
		
		ComputeNewState()
		
		ComputeData()
		
		GameCamera.Update()
		
		UpdateScreen()
		
		ClearImpulses()
		
		'Sleep( 1, 1 )
		
	Loop

End Sub


'' Core physics functions
Sub GameType.CollisionDetection()
	
	''	Roxel - Roxel
	If ( Not Roxels.Empty ) Then 
		
		For R1 As RoxelType Ptr = Roxels.p_front To Roxels.p_back - 1
			
			For R2 As RoxelType Ptr = R1 + 1 To Roxels.p_back
				
				CollisionResponse( R1, R2 )
				
			Next
			
		Next
	
	EndIf
	
	'' Roxel - Wheel
	If ( Not Roxels.Empty ) And ( Not Wheels.Empty ) Then 
		
		For R As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			For W As WheelType Ptr = Wheels.p_front To Wheels.p_back
				
				
				
			Next
			
		Next
	
	EndIf
	
	'' Wheel - Wheel
	If ( Not Wheels.Empty ) Then 
		
		For W1 As WheelType Ptr = Wheels.p_front To Wheels.p_back - 1
			
			For W2 As WheelType Ptr = W1 + 1 To Wheels.p_back
				
				''
				Dim As Vec2 Distance = W2->AngularState.Position - W1->AngularState.Position
				
			Next
			
		Next
		
	EndIf
	
End Sub

Sub GameType.ComputeData()
	
	''	Linear springs
	If ( Not LinearSprings.Empty ) Then 
		
		For S As LinearSpringType Ptr = LinearSprings.P_front To LinearSprings.P_back
			
			S->ComputeData()
			
		Next
		
	EndIf
	
	''	Angular springs
	If ( Not AngularSprings.Empty ) Then 
		
		For A As AngularSpringType Ptr = AngularSprings.P_front To AngularSprings.P_back
			
			A->ComputeData()
			
		Next
		
	EndIf
	
	''Softbodys
	If ( Not SoftBodys.Empty ) Then
		
		For S As SoftBodyType Ptr = SoftBodys.P_front To SoftBodys.P_back
			
			'' Linear springs
			If ( Not S->LinearSprings.Empty ) Then
				
				For L As LinearSpringType Ptr = S->LinearSprings.P_front To S->LinearSprings.P_back
					
					L->ComputeData()
					
				Next
				
			EndIf
			
			If ( Not S->AngularSprings.Empty ) Then 
				
				For A As AngularSpringType Ptr = S->AngularSprings.P_front To S->AngularSprings.P_back
					
					A->ComputeData()
					
				Next
				
			EndIf
			
			'' Global
			S->ComputeData()
			
		Next
		
	EndIf
	
	'' Revolute Constraints
	If ( Not Constraints.Empty ) Then 
		
		For J As RevoluteConstraintType Ptr = Constraints.P_front To Constraints.P_back
			
			J->ComputeData()
			
		Next
		
	EndIf
	
	'' Distance constraints
	If ( Not DistanceConstraints.Empty ) Then 
		
		For J As DistanceConstraintType Ptr = DistanceConstraints.P_front To DistanceConstraints.P_back
			
			J->ComputeData()
			
		Next
		
	EndIf
	
	'' Slide constraints
	If ( Not SlideConstraints.Empty ) Then 
		
		For J As SlideConstraintType Ptr = SlideConstraints.P_front To SlideConstraints.P_back
			
			J->ComputeData()
			
		Next
		
	EndIf
		
End Sub

Sub GameType.ComputeRestImpulse()
	
	''	Linear springs
	If ( Not LinearSprings.Empty ) Then 
		
		For S As LinearSpringType Ptr = LinearSprings.P_front To LinearSprings.P_back
			
			S->ComputeRestImpulse()
			
		Next
		
	EndIf
	
	''	Angular springs
	If ( Not AngularSprings.Empty ) Then 
		
		For A As AngularSpringType Ptr = AngularSprings.P_front To AngularSprings.P_back
			
			A->ComputeRestImpulse()
			
		Next
		
	EndIf
	
	''Softbodys
	If ( Not SoftBodys.Empty ) Then
		
		For S As SoftBodyType Ptr = SoftBodys.P_front To SoftBodys.P_back
			
			'' Linear springs
			If ( Not S->LinearSprings.Empty ) Then
				
				For L As LinearSpringType Ptr = S->LinearSprings.P_front To S->LinearSprings.P_back Step 1
					
					L->ComputeRestImpulse()
					
				Next
				
			EndIf
			
			'' Angular springs
			If ( Not S->AngularSprings.Empty ) Then 
				
				For A As AngularSpringType Ptr = S->AngularSprings.P_front To S->AngularSprings.P_back
					
					A->ComputeRestImpulse()
					
				Next
				
			EndIf
			
		Next
		
	EndIf
	
	'' Revolute Constraints
	If ( Not Constraints.Empty ) Then 
		
		For J As RevoluteConstraintType Ptr = Constraints.P_front To Constraints.P_back
			
			J->ComputeRestImpulse()
			
		Next
		
	EndIf
	
	'' Distance Constraints
	If ( Not DistanceConstraints.Empty ) Then 
		
		For J As DistanceConstraintType Ptr = DistanceConstraints.P_front To DistanceConstraints.P_back
			
			J->ComputeRestImpulse()
			
		Next
		
	EndIf
	
	'' Slide Constraints
	If ( Not SlideConstraints.Empty ) Then 
		
		For J As SlideConstraintType Ptr = SlideConstraints.P_front To SlideConstraints.P_back
			
			J->ComputeRestImpulse()
			
		Next
		
	EndIf
	
	'' Angular Constraints
	If ( Not AngularConstraints.Empty ) Then 
		
		For J As AngularConstraintType Ptr = AngularConstraints.P_front To AngularConstraints.P_back
			
			J->ComputeRestImpulse()
			
		Next
		
	EndIf
	
	'' Gear Constraints
	If ( Not GearConstraints.Empty ) Then 
		
		For G As GearConstraintType Ptr = GearConstraints.P_front To GearConstraints.P_back
			
			G->ComputeRestImpulse()
			
		Next
		
	EndIf
	
	'' Winch Constraints
	If ( Not WinchConstraints.Empty ) Then 
		
		For W As WinchConstraintType Ptr = WinchConstraints.P_front To WinchConstraints.P_back
			
			W->ComputeRestImpulse()
			
		Next
		
	EndIf
	
End Sub

Sub GameType.ApplyCorrectiveimpulse()
	
	'' Linear springs
	If ( Not LinearSprings.Empty ) Then 
		
		For S As LinearSpringType Ptr = LinearSprings.P_front To LinearSprings.P_back Step 1
			
			S->ApplyCorrectiveImpulse()
			
		Next
		
		For S As LinearSpringType Ptr = LinearSprings.P_back To LinearSprings.P_front Step -1
			
			S->ApplyCorrectiveImpulse()
			
		Next
	
	EndIf
	
	'' Angular springs
	If ( Not AngularSprings.Empty ) Then 
		
		For A As AngularSpringType Ptr = AngularSprings.P_front To AngularSprings.P_back Step 1
			
			A->ApplyCorrectiveImpulse()
			
		Next
		
		For A As AngularSpringType Ptr = AngularSprings.P_back To AngularSprings.P_front Step -1
			
			A->ApplyCorrectiveImpulse()
			
		Next
	
	EndIf
	
	'' soft bodys
	If ( Not SoftBodys.Empty ) Then
		
		For S As SoftBodyType Ptr = SoftBodys.P_front To SoftBodys.P_back
			
			'' Linear springs
			If ( Not S->LinearSprings.Empty ) Then
				
				For L As LinearSpringType Ptr = S->LinearSprings.P_front To S->LinearSprings.P_back Step 1
					
					L->ApplyCorrectiveImpulse()
					
				Next
				
				For L As LinearSpringType Ptr = S->LinearSprings.P_back  To S->LinearSprings.P_front Step -1
					
					L->ApplyCorrectiveImpulse()
					
				Next
				
			EndIf
			
			'' Angular springs
			If ( Not S->AngularSprings.Empty ) Then 
				
				For A As AngularSpringType Ptr = S->AngularSprings.P_front To S->AngularSprings.P_back Step 1
					
					A->ApplyCorrectiveImpulse()
					
				Next
				
				For A As AngularSpringType Ptr = S->AngularSprings.P_back To S->AngularSprings.P_front Step -1
					
					A->ApplyCorrectiveImpulse()
					
				Next
				
			EndIf
			
		Next
		
	EndIf
	
	'' Revolute constraints
	If ( Not Constraints.Empty ) Then 
		
		For J As RevoluteConstraintType Ptr = Constraints.P_front To Constraints.P_back Step 1
			
			J->ApplyCorrectiveImpulse()
			
		Next
		
		For J As RevoluteConstraintType Ptr = Constraints.P_back To Constraints.P_front Step -1
			
			J->ApplyCorrectiveImpulse()
			
		Next
	
	EndIf
	
	'' Distance constraints
	If ( Not DistanceConstraints.Empty ) Then 
		
		For J As DistanceConstraintType Ptr = DistanceConstraints.P_front To DistanceConstraints.P_back Step 1
			
			J->ApplyCorrectiveImpulse()
			
		Next
		
		For J As DistanceConstraintType Ptr = DistanceConstraints.P_back To DistanceConstraints.P_front Step -1
			
			J->ApplyCorrectiveImpulse()
			
		Next
		
	EndIf
	
	'' Slide Constraints
	If ( Not SlideConstraints.Empty ) Then 
		
		For J As SlideConstraintType Ptr = SlideConstraints.P_front To SlideConstraints.P_back Step 1
			
			J->ApplyCorrectiveImpulse()
			
		Next
		
		For J As SlideConstraintType Ptr = SlideConstraints.P_back To SlideConstraints.P_front Step -1
			
			J->ApplyCorrectiveImpulse()
			
		Next
		
	EndIf
	
	'' Angular Constraints
	If ( Not AngularConstraints.Empty ) Then 
		
		For J As AngularConstraintType Ptr = AngularConstraints.P_front To AngularConstraints.P_back Step 1
			
			J->ApplyCorrectiveImpulse()
			
		Next
		
		For J As AngularConstraintType Ptr = AngularConstraints.P_back To AngularConstraints.P_front Step -1
			
			J->ApplyCorrectiveImpulse()
			
		Next
		
	EndIf
	
	'' Gear Constraints
	If ( Not GearConstraints.Empty ) Then 
		
		For G As GearConstraintType Ptr = GearConstraints.P_front To GearConstraints.P_back Step 1
			
			G->ApplyCorrectiveImpulse()
			
		Next
		
		For G As GearConstraintType Ptr = GearConstraints.P_back To GearConstraints.P_front Step -1
			
			G->ApplyCorrectiveImpulse()
			
		Next
		
	EndIf
	
	'' Winch Constraints
	If ( Not WinchConstraints.Empty ) Then 
		
		For W As WinchConstraintType Ptr = WinchConstraints.P_front To WinchConstraints.P_back Step 1
			
			W->ApplyCorrectiveImpulse()
			
		Next
		
		For W As WinchConstraintType Ptr = WinchConstraints.P_back To WinchConstraints.P_front Step -1
			
			W->ApplyCorrectiveImpulse()
			
		Next
		
	EndIf
	
End Sub

Sub GameType.ApplyWarmStart()
	
	'' Warm starting. Use the sum of previously applied impulses
	'' projected onto new normal vector as initial iteration value.
	''	This is roughly equivalent of doubling the number of iterations.
	
	'' Linear springs
	If ( Not LinearSprings.Empty ) Then 
		
		For S As LinearSpringType Ptr = LinearSprings.P_front To LinearSprings.P_back
			
			S->ApplyWarmStart()
			
		Next
	
	EndIf
	
	''	Angular springs
	If ( Not AngularSprings.Empty ) Then 
		
		For A As AngularSpringType Ptr = AngularSprings.P_front To AngularSprings.P_back
			
			A->ApplyWarmStart()
			
		Next
		
	EndIf
	
	'' soft bodys
	If ( Not SoftBodys.Empty ) Then
		
		For S As SoftBodyType Ptr = SoftBodys.P_front To SoftBodys.P_back
			
			'' Linear springs
			If ( Not S->LinearSprings.Empty ) Then
				
				For L As LinearSpringType Ptr = S->LinearSprings.P_front To S->LinearSprings.P_back
					
					L->ApplyWarmStart()
					
				Next
				
			EndIf
			
			'' Angular springs
			If ( Not S->AngularSprings.Empty ) Then 
				
				For A As AngularSpringType Ptr = S->AngularSprings.P_front To S->AngularSprings.P_back
					
					A->ApplyWarmStart()
					
				Next
				
			EndIf
			
		Next
		
	EndIf
	
	'' Revolute Constraints
	If ( Not Constraints.Empty ) Then 
		
		For J As RevoluteConstraintType Ptr = Constraints.P_front To Constraints.P_back
			
			J->ApplyWarmStart()
			
		Next
		
	EndIf
	
	'' Distance constraints
	If ( Not DistanceConstraints.Empty ) Then 
		
		For J As DistanceConstraintType Ptr = DistanceConstraints.P_front To DistanceConstraints.P_back
			
			J->ApplyWarmStart()
			
		Next
		
	EndIf
	
	'' Slide Constraints
	If ( Not SlideConstraints.Empty ) Then 
		
		For J As SlideConstraintType Ptr = SlideConstraints.P_front To SlideConstraints.P_back
			
			J->ApplyWarmStart()
			
		Next
		
	EndIf
	
	'' Angular Constraints
	If ( Not AngularConstraints.Empty ) Then 
		
		For J As AngularConstraintType Ptr = AngularConstraints.P_front To AngularConstraints.P_back
			
			J->ApplyWarmStart()
			
		Next
		
	EndIf
	
	'' Gear Constraints
	If ( Not GearConstraints.Empty ) Then 
		
		For G As GearConstraintType Ptr = GearConstraints.P_front To GearConstraints.P_back
			
			G->ApplyWarmStart()
			
		Next
		
	EndIf
	
	'' Winch Constraints
	If ( Not WinchConstraints.Empty ) Then 
		
		For W As WinchConstraintType Ptr = WinchConstraints.P_front To WinchConstraints.P_back
			
			W->ApplyWarmStart()
			
		Next
		
	EndIf
	
End Sub

Sub GameType.ComputeNewState()
	
	''	Compute new state vectors
	
	'' LinearStates
	If ( Not LinearStates.Empty ) Then 
		
		For L As LinearStateType Ptr = LinearStates.p_front To LinearStates.p_back
			
			L->ComputeNewState()
			
		Next
	
	EndIf
	
	'' Roxels
	If ( Not Roxels.Empty ) Then 
		
		For R As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			R->ComputeNewState()
			
		Next
	
	EndIf
	
	'' Linear springs in soft bodys
	If ( Not SoftBodys.Empty ) Then
		
		For S As SoftBodyType Ptr = SoftBodys.P_front To SoftBodys.P_back
			
			''
			If ( Not S->LinearStates.Empty ) Then
				
				For L As LinearStateType Ptr = S->LinearStates.P_front To S->LinearStates.P_back
					
					L->ComputeNewState()
					
				Next
				
			EndIf
			
			'S->ComputeNewState() ?
			
		Next
		
	EndIf
	
	'' Boxes
	If ( Not Boxes.Empty ) Then 
		
		For B As BoxType Ptr = Boxes.p_front To Boxes.p_back
			
			B->AngularState.ComputeNewState()
			
		Next
		
	EndIf
	
	'' Wheels
	If ( Not Wheels.Empty ) Then 
		
		For W As WheelType Ptr = Wheels.p_front To Wheels.p_back
			
			W->AngularState.ComputeNewState()
			
		Next
		
	EndIf
	
End Sub

'' Graphics and interaction
Sub GameType.UpdateScreen()
	
	ScreenLock()
	
	Cls
	'Line(0,0)-(screen_wid, screen_hgt), RGB( 60, 64, 68 ), BF
	
		'' Mouse
	Dim As Integer mouse_x, mouse_y

	GetMouse mouse_x, mouse_y
	
	Dim As Integer m_screen_x =  (  mouse_x - SCREEN_WIDTH  * 0.5 ) * GameCamera.Zoom * 0.5 + GameCamera.position.x
	Dim As Integer m_screen_y =  ( -mouse_y + SCREEN_HEIGHT * 0.5 ) * GameCamera.Zoom * 0.5 + GameCamera.position.y
	
	'Dim As Integer m_screen_x = ( ( GameCamera.position.x + mouse_x ) - SCREEN_WIDTH  * 0.5 )' * GameCamera.Zoom
	'Dim As Integer m_screen_y = ( ( GameCamera.position.y - mouse_y ) + SCREEN_HEIGHT * 0.5 ) '* GameCamera.Zoom
	
	''
	Locate  4, 2: Print PuzzleText
	Locate  8, 2: Print Using "Iterations: ##"; iterations
	Locate 10, 2: Print "Warmstart: "; warmstart
	Locate 12, 2: Print mouse_x, mouse_y
	Locate 14, 2: Print GameJoystick.State()
	
	''  draw particles background ( black)
	If ( Not Roxels.Empty  ) Then 
		
		For P As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			If ( P->radius > 0.0 ) Then
				
				'' draw impulse ( purple )
				'Dim As vec2 impulse = P->linear.position + ( P->linear.impulse + P->linear.velocity ) * DT
				'Line (P->linear.position.x, P->linear.position.y)-(impulse.x, impulse.y), RGBA( 0, 255, 0 , 128 )
				
				Circle(P->position.x, P->position.y), P->radius + 10, RGB(0, 0, 0) ,,, 1, f
				
			End If
			
		Next
		
	EndIf
	
	'' Linear springs in soft bodys
	If ( Not SoftBodys.Empty ) Then
		
		For S As SoftBodyType Ptr = SoftBodys.P_front To SoftBodys.P_back
			
						''
			If ( Not S->LinearSprings.Empty ) Then
				
				For F As LinearSpringType Ptr = S->LinearSprings.P_front To S->LinearSprings.P_back
					
					'Dim As Vec2 psn_a = F->LinearLink.a->position
					'Dim As Vec2 psn_b = F->LinearLink.b->position
					'
					'Dim As Vec2 unit = F->LinearLink.unit_vector * 1.5
					
					'Line( psn_a.x + unit.y, psn_a.y - unit.x )-( psn_b.x + unit.y, psn_b.y - unit.x ), RGB( 96, 80, 64 )
					'Line( psn_a.x - unit.y, psn_a.y + unit.x )-( psn_b.x - unit.y, psn_b.y + unit.x ), RGB( 96, 80, 64 )
					'
					'Line( psn_a.x - unit.y, psn_a.y + unit.x )-( psn_a.x + unit.y, psn_a.y - unit.x ), RGB( 96, 80, 64 )
					'Line( psn_b.x + unit.y, psn_b.y - unit.x )-( psn_b.x - unit.y, psn_b.y + unit.x ), RGB( 96, 80, 64 )
					
					Line( F->LinearLink.a->position.x, F->LinearLink.a->position.y )-_
				       ( F->LinearLink.b->position.x, F->LinearLink.b->position.y ), RGB( 160, 160, 160 )
					
					Circle( F->LinearLink.position.x, F->LinearLink.position.y ), 2, RGB( 160, 160, 160 ),,, 1, f
					'Paint( F->LinearLink.position.x, F->LinearLink.position.y ),  RGB( 96, 80, 64 )
					
					
					'Dim As Vec2 pnt = ClosestPointOnLinearLink( @(F->LinearLink), position )
			
					'Circle(pnt.x, pnt.y), 4, RGB(255, 255, 0),,, 1, f
					
				Next
				
			EndIf
			
			''
			If ( Not S->LinearStates.Empty ) Then
				
				For L As LinearStateType Ptr = S->LinearStates.P_front To S->LinearStates.P_back
					
					Circle( L->position.x, L->position.y), 2, RGB( 160, 160, 160 ),,, 1, f
					
					'' impulse ( purple )
					'Line( L->position.x, L->position.y )-_
					'    ( L->position.x + L->impulse.x * 10, L->position.y + L->impulse.y * 10), RGB(255,0,255)
					
					
					
				Next
				
			EndIf
			
			Dim As Vec2 r1    = S->position + S->direction_Vector         * 16.0
			Dim As Vec2 r1cw  = S->position + S->direction_Vector.PerpCW  * 16.0
			Dim As Vec2 r1ccw = S->position + S->direction_Vector.PerpCCW * 16.0
			
			Line( S->position.x, S->position.y )-( r1.x, r1.y )      , RGB( 255, 255, 0 )
			Line( S->position.x, S->position.y )-( r1cw.x, r1cw.y )  , RGB( 0, 255, 0 )
			Line( S->position.x, S->position.y )-( r1ccw.x, r1ccw.y ), RGB( 255, 0, 0 )
			
			'' global
			Circle( S->position.x, S->position.y ), 2, RGB( 255, 255, 0 ),,, 1, f
			
			'' impulse ( purple )
			'Line( S->LinearState.position.x, S->LinearState.position.y )-_
			'	 ( S->LinearState.position.x + S->LinearState.impulse.x * 10, S->LinearState.position.y + S->LinearState.impulse.y * 10), RGB(255,0,255)
			
		Next
		
	EndIf
	
	''  draw springs ( grey )
	If ( Not LinearSprings.Empty ) Then 
		
		For S As LinearSpringType Ptr = LinearSprings.P_front To LinearSprings.P_back
			
			'Dim As Vec2 psn_a = S->LinearLink.a->position
			'Dim As Vec2 psn_b = S->LinearLink.b->position
			'
			'Dim As Vec2 unit = S->LinearLink.unit_vector * 2.0
			'
			'Line( psn_a.x + unit.y, psn_a.y - unit.x )-( psn_b.x + unit.y, psn_b.y - unit.x ), RGB(192, 192, 192)
			'Line( psn_a.x - unit.y, psn_a.y + unit.x )-( psn_b.x - unit.y, psn_b.y + unit.x ), RGB(192, 192, 192)
			'
			'Line( psn_a.x - unit.y, psn_a.y + unit.x )-( psn_a.x + unit.y, psn_a.y - unit.x ), RGB(192, 192, 192)
			'Line( psn_b.x + unit.y, psn_b.y - unit.x )-( psn_b.x - unit.y, psn_b.y + unit.x ), RGB(192, 192, 192)
			
			Line(S->LinearLink.a->position.x, S->LinearLink.a->position.y)-_
				 (S->LinearLink.b->position.x, S->LinearLink.b->position.y), RGB(192, 192, 192)
			
			Circle(S->LinearLink.position.x, S->LinearLink.position.y), 2, RGB( 160, 160, 160 ),,, 1, f
			
		Next
		
	EndIf
	
	
	''	draw Roxels foreground
	If ( Not Roxels.Empty ) Then 
		
		For P As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			If ( P->radius > 0.0 ) Then
				
				'Dim As UInteger Col = IIf( P->inv_mass = 0.0, RGB(160, 160, 160), RGB(255, 0, 0) )
				
				Circle(P->position.x, P->position.y), P->radius, P->Colour,,, 1, f
				
			Else
				
				'Dim As UInteger Col = IIf( P->inv_mass = 0.0, RGB(160, 160, 160), RGB(160, 160, 160) )
				
				Circle(P->position.x, P->position.y), 2, P->Colour,,, 1, f
				
			End If
			
		Next
		
	EndIf
	
	
	'' draw linearstates
	If ( Not LinearStates.Empty ) Then 
		
		For P As LinearStateType Ptr = LinearStates.p_front To LinearStates.p_back
			
			Circle(P->position.x, P->position.y), 2, RGB( 128, 128, 128 ),,, 1, f
			
		Next
		
	EndIf
	
	If ( Nearest <> 0 ) Then Circle(Nearest->position.x, Nearest->position.y), 32, RGB(255, 255, 255),,, 1
	If ( Picked <> 0 ) Then Circle(Picked->position.x, Picked->position.y), 32, RGB(255, 255, 0),,, 1
	
	'' Wheels
	If ( Not Wheels.Empty ) Then 
		
		For W As WheelType Ptr = Wheels.p_front To Wheels.p_back
			
			Dim As Vec2 psn = W->AngularState.position
			
			Dim As Vec2 r1    = psn + W->AngularState.direction_Vector         * 16.0
			Dim As Vec2 r1cw  = psn + W->AngularState.direction_Vector.PerpCW  * 16.0
			Dim As Vec2 r1ccw = psn + W->AngularState.direction_Vector.PerpCCW * 16.0
			
			Dim As vec2 ring1 = psn + W->AngularState.direction_Vector * W->radius * 0.5
			Dim As vec2 ring2 = psn - W->AngularState.direction_Vector * W->radius * 0.5
			Dim As vec2 ring3 = psn + W->AngularState.direction_Vector.PerpCW * W->radius * 0.5
			Dim As vec2 ring4 = psn - W->AngularState.direction_Vector.PerpCW * W->radius * 0.5
			
			'Circle(psn.x, psn.y), W->radius, RGB( 0, 0, 0 ),,, 1, f
			'Circle(psn.x, psn.y), W->radius - 3, RGB( 96, 96, 96 ),,, 1, f
			Circle(psn.x, psn.y), W->radius, RGB( 160, 160, 160 ),,, 1, f
			Circle(psn.x, psn.y), W->radius - 1, RGB( 96, 96, 96 ),,, 1, f
			
			Circle(ring1.x, ring1.y), W->radius * 0.3, RGB( 80, 80, 80 ),,, 1, f
			Circle(ring2.x, ring2.y), W->radius * 0.3, RGB( 80, 80, 80 ),,, 1, f
			Circle(ring3.x, ring3.y), W->radius * 0.3, RGB( 80, 80, 80 ),,, 1, f
			Circle(ring4.x, ring4.y), W->radius * 0.3, RGB( 80, 80, 80 ),,, 1, f
			
			Line( psn.x, psn.y )-( r1.x, r1.y )      , RGB( 255, 255, 0 )
			Line( psn.x, psn.y )-( r1cw.x, r1cw.y )  , RGB( 0, 255, 0 )
			Line( psn.x, psn.y )-( r1ccw.x, r1ccw.y ), RGB( 255, 0, 0 )
			
			Circle(psn.x, psn.y), 2, RGB( 128, 128, 128 ),,, 1, f
			
		Next
		
	EndIf
	
	'' Boxes
	If ( Not Boxes.Empty ) Then 
		
		For B As BoxType Ptr = Boxes.p_front To Boxes.p_back
			
			Dim As Vec2 psn = B->AngularState.position
			
			Dim As Vec2 r1    = psn + B->AngularState.direction_Vector         * 16.0
			Dim As Vec2 r1cw  = psn + B->AngularState.direction_Vector.PerpCW  * 16.0
			Dim As Vec2 r1ccw = psn + B->AngularState.direction_Vector.PerpCCW * 16.0
			
			Line( psn.x, psn.y )-( r1.x, r1.y )      , RGB( 255, 255, 0 )
			Line( psn.x, psn.y )-( r1cw.x, r1cw.y )  , RGB( 0, 255, 0 )
			Line( psn.x, psn.y )-( r1ccw.x, r1ccw.y ), RGB( 255, 0, 0 )
			
			Circle(psn.x, psn.y), 2, RGB( 128, 128, 128 ),,, 1, f
			
			Dim As Vec2 a1 = B->AngularState.position + B->AngularState.direction_vector * B->radius.x + B->AngularState.direction_vector.perpccw * B->radius.y
			Dim As Vec2 a2 = B->AngularState.position + B->AngularState.direction_vector * B->radius.x - B->AngularState.direction_vector.perpccw * B->radius.y
			Dim As Vec2 a3 = B->AngularState.position - B->AngularState.direction_vector * B->radius.x - B->AngularState.direction_vector.perpccw * B->radius.y
			Dim As Vec2 a4 = B->AngularState.position - B->AngularState.direction_vector * B->radius.x + B->AngularState.direction_vector.perpccw * B->radius.y
	
			Line( a1.x, a1.y )-( a2.x, a2.y ), RGB( 160, 160, 160 )
			Line( a2.x, a2.y )-( a3.x, a3.y ), RGB( 160, 160, 160 )
			Line( a3.x, a3.y )-( a4.x, a4.y ), RGB( 160, 160, 160 )
			Line( a4.x, a4.y )-( a1.x, a1.y ), RGB( 160, 160, 160 )
			
		Next
		
	EndIf
	
	'' Revolute Constraints
	If ( Not Constraints.Empty ) Then 
		
		For J As RevoluteConstraintType Ptr = Constraints.P_front To Constraints.P_back
			
			Dim As Vec2 p1 = J->body_a->position + J->r_a
			Dim As Vec2 p2 = J->body_b->position + J->r_b
			
			Line(p1.x, p1.y)-(p2.x, p2.y), RGB( 255, 128, 255 )
			
			Circle(p1.x, p1.y), 2, RGB( 255, 128, 255 ),,, 1, f
			Circle(p2.x, p2.y), 2, RGB( 255, 128, 255 ),,, 1, f
			
		Next
		
	EndIf
	
	'' Distance constraints
	If ( Not DistanceConstraints.Empty ) Then 
		
		For J As DistanceConstraintType Ptr = DistanceConstraints.P_front To DistanceConstraints.P_back
			
			Dim As Vec2 p1 = J->body_a->position + J->r_a
			Dim As Vec2 p2 = J->body_b->position + J->r_b
			
			Line(p1.x, p1.y)-(p2.x, p2.y), RGB( 255, 255, 0 )
			
			Circle(p1.x, p1.y), 2, RGB( 255, 255, 0 ),,, 1, f
			Circle(p2.x, p2.y), 2, RGB( 255, 255, 0 ),,, 1, f
			
		Next
		
	EndIf
	
	'' Slide constraints
	If ( Not SlideConstraints.Empty ) Then 
		
		For J As SlideConstraintType Ptr = SlideConstraints.P_front To SlideConstraints.P_back
			
			Dim As Vec2 p1 = J->body_a->position + J->r_a
			Dim As Vec2 p2 = J->body_b->position + J->r_b
			
			Line(p1.x, p1.y)-(p2.x, p2.y), RGB( 0, 255, 0 )
			
			Line(p1.x, p1.y)-(p1.x + J->n.x * 100, p1.y + J->n.y * 100 ), RGB( 0, 255, 0 )
			
			Circle(p1.x, p1.y), 2, RGB( 0, 255, 0 ),,, 1, f
			Circle(p2.x, p2.y), 2, RGB( 0, 255, 0 ),,, 1, f
			
		Next
		
	EndIf
	
	Circle(m_screen_x, m_screen_y), 5, RGB( 0, 255, 255 ),,, 1, f
	Circle(0.0, 0.0), 5, RGB( 0, 255, 255 ),,, 1, f
	
	ScreenUnLock()
	
	'ScreenCopy()
	
End Sub

Sub GameType.UpdateInput()
	
	Dim As Integer mouse_x, mouse_y
	Dim As Vec2 DistanceVector
	Dim As Vec2 VelocityVector
	Dim As Single  Distance
	Dim As Single  MinDIst
	
	''
	position_prev = position
	button_prev   = button
	wheel_prev    = wheel
	
	''
	GetMouse mouse_x, mouse_y, wheel, button
	
	Dim As Integer m_screen_x =  (  mouse_x - SCREEN_WIDTH  * 0.5 ) * GameCamera.Zoom * 0.5 + GameCamera.position.x
	Dim As Integer m_screen_y =  ( -mouse_y + SCREEN_HEIGHT * 0.5 ) * GameCamera.Zoom * 0.5 + GameCamera.position.y
	
	position = Vec2( Cast( Single, m_screen_x ) , Cast( Single, ( m_screen_y ) ) )
	
	
	If ( wheel > wheel_prev ) Then GameCamera.RestZoom_ /= 1.1
	If ( wheel < wheel_prev ) Then GameCamera.RestZoom_ *= 1.1
	
	If ( Button = 2 ) Then 
		
		Dim As Vec2 rest_prev = GameCamera.restposition()
		
		'GameCamera.restposition( rest_prev + ( position_prev - position ) * GameCamera.Zoom )
		GameCamera.restposition( rest_prev + ( position_prev - position ) )
		
	EndIf
	
	''
	GameJoystick.Update()
	
	If ( GameJoystick.State() = 0 ) Then
		
		If GameJoystick.Button(3) Then GameCamera.RestZoom_ /= 1.005
		If GameJoystick.Button(0) Then GameCamera.Restzoom_ *= 1.005
		
		If Abs( GameJoystick.Axis(1).x ) > 0.15 Then 
			
			'GameCamera.RestPosition_.x += GameJoystick.Axis(1).x * GameScreen.Width  * GameCamera.Zoom_ * 0.002
			GameCamera.RestPosition_.x += GameJoystick.Axis(1).x * GameCamera.Zoom_ * 1.0
			
		EndIf
		
		If Abs( GameJoystick.Axis(1).y ) > 0.15 Then 
			
			'GameCamera.RestPosition_.y -= GameJoystick.Axis(1).y * GameScreen.Height * GameCamera.Zoom_ * 0.002
			GameCamera.RestPosition_.y -= GameJoystick.Axis(1).y * GameCamera.Zoom_ * 1.0
			
		EndIf
		
	EndIf
	
	''
	MinDist  = pick_distance
	
	nearest = 0
	
	If ( picked = 0 ) Then
		
		If ( Not LinearStates.Empty ) Then
				
			For P As LinearStateType Ptr = LinearStates.p_front To LinearStates.p_back
				
				DistanceVector = P->Position - position
				Distance = DistanceVector.LengthSquared()
				
				If ( Distance < MinDist ) Then
					
					MinDist = Distance
					nearest = P
					
				EndIf
			
			Next
		
		EndIf
		
		'' check Roxels
		If ( Not Roxels.Empty ) Then
				
			For P As RoxelType Ptr = Roxels.p_front To Roxels.p_back
				
				DistanceVector = P->Position - position
				Distance = DistanceVector.LengthSquared()
				
				If ( Distance < MinDist ) Then
					
					MinDist = Distance
					nearest = P
					
				EndIf
			
			Next
			
		EndIf
		
		'' check soft bodys
		If ( Not Softbodys.Empty ) Then
				
			For S As SoftbodyType Ptr = Softbodys.p_front To Softbodys.p_back
				
				DistanceVector = S->Position - position
				Distance = DistanceVector.LengthSquared()
				
				If ( Distance < MinDist ) Then
					
					MinDist = Distance
					nearest = S
					
				EndIf
				
				'' LinearStates
				If ( Not S->LinearStates.Empty ) Then
					
					For L As LinearStateType Ptr = S->LinearStates.p_front To S->LinearStates.p_back
						
						DistanceVector = L->Position - position
						Distance = DistanceVector.LengthSquared()
						
						If ( Distance < MinDist ) Then
							
							MinDist = Distance
							nearest = L
							
						EndIf
						
					Next
					
				EndIf
				
				'' LinearSprings
				If ( Not S->LinearSprings.Empty ) Then
					
					For L As LinearSpringType Ptr = S->LinearSprings.p_front To S->LinearSprings.p_back
						
						DistanceVector = L->LinearLink.Position - position
						Distance = DistanceVector.LengthSquared()
						
						If ( Distance < MinDist ) Then
							
							MinDist = Distance
							nearest = @(L->LinearLink)
							
						EndIf
						
					Next
					
				EndIf
				
			Next
			
		EndIf
		
		'' Linearsprings
		If ( Not LinearSprings.Empty ) Then
				
			For L As LinearSpringType Ptr = LinearSprings.p_front To LinearSprings.p_back
				
				DistanceVector = L->LinearLink.Position - position
				Distance = DistanceVector.LengthSquared()
				
				If ( Distance < MinDist ) Then
					
					MinDist = Distance
					nearest = @(L->LinearLink)
					
				EndIf
			
			Next
		
		EndIf
		
	EndIf
		
	''
	If ( button = 1 ) Then
		
		If ( button_prev = 1 ) Then 
			
			If ( Not picked = 0 ) Then
			
				DistanceVector = picked->Position - position
				VelocityVector = picked->Velocity
				
				picked->addImpulse( -DistanceVector * INV_DT * 0.1 - VelocityVector * 0.5 )
			
			EndIf
			
		Else
			
			picked = nearest
			
		EndIf
	
	Else
		
		picked = 0
	
	EndIf
	
	''
	If ( ScreenEvent( @e ) ) Then
		
		Select Case e.type
		
		Case fb.EVENT_KEY_PRESS
			
			If ( e.scancode = fb.SC_1 ) Then picked = 0 : Puzzle1()
			If ( e.scancode = fb.SC_2 ) Then picked = 0 : Puzzle2()
			If ( e.scancode = fb.SC_3 ) Then picked = 0 : Puzzle3()
			If ( e.scancode = fb.SC_4 ) Then picked = 0 : Puzzle4()
			If ( e.scancode = fb.SC_5 ) Then picked = 0 : Puzzle5()
			If ( e.scancode = fb.SC_6 ) Then picked = 0 : Puzzle6()
			If ( e.scancode = fb.SC_7 ) Then picked = 0 : Puzzle7()
			If ( e.scancode = fb.SC_8 ) Then picked = 0 : Puzzle8()
			If ( e.scancode = fb.SC_9 ) Then picked = 0 : Puzzle9()
			If ( e.scancode = fb.SC_0 ) Then picked = 0 : Puzzle0()
			
			'' Iterations
			If ( MultiKey( fb.SC_I ) And ( e.scancode = fb.SC_PLUS  ) ) Then iterations += 1
			If ( MultiKey( fb.SC_I ) And ( e.scancode = fb.SC_MINUS ) ) Then iterations -= 1
			
			If ( e.scancode = fb.SC_SPACE ) Then 
				
				ClearWarmStart()
				warmstart Xor= 1
				
			EndIf

			
			If ( e.scancode = fb.SC_ESCAPE ) Then End
			
		Case fb.EVENT_KEY_RELEASE
		
			Case fb.EVENT_KEY_REPEAT
			
		Case fb.EVENT_MOUSE_MOVE
		
		Case fb.EVENT_MOUSE_BUTTON_PRESS
			
			If (e.button = fb.BUTTON_LEFT) Then
			
			End If
			
			If (e.button = fb.BUTTON_RIGHT) Then
			
			End If
			
		Case fb.EVENT_MOUSE_BUTTON_RELEASE
			
			If (e.button = fb.BUTTON_LEFT) Then
			
			End If
			
			If (e.button = fb.BUTTON_RIGHT) Then
			
			End If
			
		Case fb.EVENT_MOUSE_WHEEL
		
		Case fb.EVENT_WINDOW_CLOSE
			
			End
			
		End Select
		
	End If
	
			''
	If MultiKey( fb.SC_PERIOD ) Or MultiKey( fb.SC_E ) Then GameCamera.RestZoom_ /= 1.01
	If MultiKey( fb.SC_COMMA )  Or MultiKey( fb.SC_Q ) Then GameCamera.Restzoom_ *= 1.01
	
	If MultiKey( fb.SC_UP )    Or MultiKey( fb.SC_W ) Then GameCamera.RestPosition_.y += GameCamera.Zoom_ * 2.0
	If MultiKey( fb.SC_DOWN )  Or MultiKey( fb.SC_S ) Then GameCamera.RestPosition_.y -= GameCamera.Zoom_ * 2.0
	If MultiKey( fb.SC_LEFT )  Or MultiKey( fb.SC_A ) Then GameCamera.RestPosition_.x -= GameCamera.Zoom_ * 2.0
	If MultiKey( fb.SC_RIGHT ) Or MultiKey( fb.SC_D ) Then GameCamera.RestPosition_.x += GameCamera.Zoom_ * 2.0
	
	If iterations < 0 Then iterations = 0
	
End Sub

Sub GameType.ClearImpulses()
	
	'' LinearStates
	If ( Not LinearStates.Empty ) Then 
		
		For P As LinearStateType Ptr = LinearStates.p_front To LinearStates.p_back
			
			P->impulse = Vec2( 0.0, 0.0 )
			
		Next
	
	EndIf
	
	''
	If ( Not LinearSprings.Empty ) Then 
		
		For P As LinearSpringType Ptr = LinearSprings.p_front To LinearSprings.p_back
			
			P->LinearLink.impulse = Vec2( 0.0, 0.0 )
			
			P->rest_impulse = 0.0
			
		Next
	
	EndIf
	
	'' Roxels
	If ( Not Roxels.Empty ) Then 
		
		For P As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			P->impulse = Vec2( 0.0, 0.0 )
			
		Next
	
	EndIf
	
	'' Soft bodys
	If ( Not SoftBodys.empty ) Then
		
		For S As SoftBodyType Ptr = SoftBodys.p_front To SoftBodys.p_back
			
			''
			If ( Not S->LinearStates.Empty ) Then 
				
				For L As LinearStateType Ptr = S->LinearStates.p_front To S->LinearStates.p_back
					
					L->impulse = Vec2( 0.0, 0.0 )
					
				Next
			
			EndIf
			
			''
			If ( Not S->LinearSprings.Empty ) Then
				
				For F As LinearSpringType Ptr = S->LinearSprings.P_front To S->LinearSprings.P_back
					
					F->LinearLink.impulse = Vec2( 0.0, 0.0 )
					
					F->rest_impulse = 0.0
					
				Next
				
			EndIf
				
			S->impulse  = Vec2( 0.0, 0.0 )
			S->angular_impulse = 0.0
			
			'S->Linear_prev  = Vec2( 0.0, 0.0 )
			'S->Angular_prev = 0.0
				
		Next
		
	EndIf
	
	'' Boxes
	If ( Not Boxes.Empty ) Then 
		
		For B As BoxType Ptr = Boxes.p_front To Boxes.p_back
			
			B->AngularState.impulse = Vec2( 0.0, 0.0 )
			B->AngularState.angular_impulse = 0.0
			
		Next
		
	EndIf
	
	''	Wheels
	If ( Not Wheels.Empty ) Then 
		
		For W As WheelType Ptr = Wheels.p_front To Wheels.p_back
			
			W->AngularState.impulse = Vec2( 0.0, 0.0 )
			W->AngularState.angular_impulse = 0.0
			
		Next
		
	EndIf
	
End Sub

Sub GameType.ClearWarmstart()
	
	'' Linear springs
	If ( Not LinearSprings.Empty ) Then 
		
		For S As LinearSpringType Ptr = LinearSprings.P_front To LinearSprings.P_back
		
			S->accumulated_impulse = Vec2( 0.0, 0.0 )
			
		Next
	
	EndIf
	
	''	Angular springs
	If ( Not AngularSprings.Empty ) Then 
		
		For A As AngularSpringType Ptr = AngularSprings.P_front To AngularSprings.P_back
			
			A->accumulated_impulse = 0.0
			
		Next
		
	EndIf
	
	'' Soft bodys
	If ( Not SoftBodys.Empty ) Then
		
		For S As SoftBodyType Ptr = SoftBodys.P_front To SoftBodys.P_back
			
			'' Linear springs
			If ( Not S->LinearSprings.Empty ) Then
				
				For L As LinearSpringType Ptr = S->LinearSprings.P_front To S->LinearSprings.P_back
					
					L->accumulated_impulse = Vec2( 0.0, 0.0 )
					
				Next
				
			EndIf
			
			'' Angular springs
			If ( Not S->AngularSprings.Empty ) Then 
				
				For A As AngularSpringType Ptr = S->AngularSprings.P_front To S->AngularSprings.P_back
					
					A->accumulated_impulse = 0.0
					
				Next
				
			EndIf
			
		Next
		
	EndIf
	
	'' Revolute constraints
	If ( Not Constraints.Empty ) Then 
		
		For J As RevoluteConstraintType Ptr = Constraints.P_front To Constraints.P_back
			
			J->accumulated_impulse = Vec2( 0.0, 0.0 )
			
		Next
		
	EndIf
	
	'' Distance constraints
	If ( Not DistanceConstraints.Empty ) Then 
		
		For J As DistanceConstraintType Ptr = DistanceConstraints.P_front To DistanceConstraints.P_back
			
			J->accumulated_impulse = Vec2( 0.0, 0.0 )
			
		Next
		
	EndIf
	
	'' Slide constraints
	If ( Not SlideConstraints.Empty ) Then 
		
		For J As SlideConstraintType Ptr = SlideConstraints.P_front To SlideConstraints.P_back
			
			J->accumulated_impulse = Vec2( 0.0, 0.0 )
			
		Next
		
	EndIf
	
	'' Angular Constraints
	If ( Not AngularConstraints.Empty ) Then 
		
		For J As AngularConstraintType Ptr = AngularConstraints.P_front To AngularConstraints.P_back
			
			J->accumulated_impulse = 0.0
			
		Next
		
	EndIf
	
	'' Gear Constraints
	If ( Not GearConstraints.Empty ) Then 
		
		For G As GearConstraintType Ptr = GearConstraints.P_front To GearConstraints.P_back
			
			'G->accumulated_impulse = Vec2( 0.0, 0.0 )
			G->accumulated_impulse = 0.0
			
		Next
		
	EndIf
	
	'' Winch Constraints
	If ( Not WinchConstraints.Empty ) Then 
		
		For W As WinchConstraintType Ptr = WinchConstraints.P_front To WinchConstraints.P_back
			
			W->accumulated_impulse = 0.0
			
		Next
		
	EndIf
	
End Sub

Sub GameType.ClearAllArrays()
	
	LinearStates.Clear()
	Roxels.Clear()
	
	SoftBodys.Clear()
	
	LinearSprings.Clear()
	AngularSprings.Clear()
	
	Boxes.Clear()
	Wheels.Clear()
	Constraints.Clear()
	distanceconstraints.Clear()
	angularconstraints.Clear()
	slideconstraints.Clear()
	gearconstraints.Clear()
	winchconstraints.Clear()
	
End Sub

Function GameType.FindClosestLinearLink() As LinearLinkType Ptr
	
	Dim As LinearLinkType Ptr LP
	
	Return LP
	
End Function

Function GameType.FindClosestLinearState() As LinearStateType Ptr
	
	Dim As LinearStateType Ptr LP
	
	Return LP
	
End Function

Function GameType.FindClosestRoxel() As RoxelType Ptr
	
	Dim As RoxelType Ptr RP
	
	Return RP
	
End Function
