''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 1, october 2018
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
	Declare Sub CreateScreen( ByVal Wid As Integer, _
	                          ByVal Hgt As Integer )
	
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
	
	Declare Function CreateAngularSpring( ByVal _stiffness As Single, _
	                                      ByVal _damping   As Single, _
	                                      ByVal _warmstart As Single, _
	                                      ByVal _linear1   As LinearLinkType Ptr, _
	                                      ByVal _linear2   As LinearLinkType Ptr, _
	                                      ByVal _array     As AngularSpringArray Ptr ) As AngularSpringType Ptr
	
	Declare Function CreateFixedSpring( ByVal _stiffness As Single, _
	                                    ByVal _damping   As Single, _
	                                    ByVal _warmstart As Single, _
	                                    ByVal _linear1   As LinearStateType Ptr, _
	                                    ByVal _linear2   As LinearStateType Ptr, _
	                                    ByVal _array     As FixedSPringArray Ptr ) As FixedSpringType Ptr
	
	Declare Function CreateLinearSpring( ByVal _linear1 As LinearStateType Ptr, _
	                                     ByVal _linear2 As LinearStateType Ptr, _
	                                     ByVal _array   As LinearSpringArray Ptr ) As LinearSpringType Ptr
	
	Declare Function CreateLinearSpring( ByVal _stiffness As Single, _
	                                     ByVal _damping   As Single, _
	                                     ByVal _warmstart As Single, _
	                                     ByVal _linear1   As LinearStateType Ptr, _
	                                     ByVal _linear2   As LinearStateType Ptr, _
	                                     ByVal _array     As LinearSpringArray Ptr ) As LinearSpringType Ptr
	
	Declare Function CreateRevoluteJoint( ByVal _Position As Vec2, _ 
	                                      ByVal _Angular1 As AngularStateType Ptr, _
	                                      ByVal _Angular2 As AngularStateType Ptr ) As RevoluteJointType Ptr
	
	Declare Function CreateRevoluteJoint( ByVal _Position  As Vec2, _ 
	                                      ByVal _stiffness As Single, _
	                                      ByVal _damping   As Single, _
	                                      ByVal _warmstart As Single, _
	                                      ByVal _Angular1  As AngularStateType Ptr, _
	                                      ByVal _Angular2  As AngularStateType Ptr ) As RevoluteJointType Ptr
	
	Declare Function CreateDistanceJoint( ByVal _Position1 As Vec2, _ 
	                                      ByVal _Position2 As Vec2, _ 
	                                      ByVal _Angular1  As AngularStateType Ptr, _
	                                      ByVal _Angular2  As AngularStateType Ptr ) As DistanceJointType Ptr
	
	Declare Function CreateSlideJoint( ByVal _Line     As Vec2, _ 
	                                   ByVal _Position As Vec2, _
	                                   ByVal _Angular1 As AngularStateType Ptr, _
	                                   ByVal _Angular2 As AngularStateType Ptr ) As SlideJointType Ptr
	
	Declare Function CreateSlideJoint( ByVal _Line      As Vec2, _ 
	                                   ByVal _Position1 As Vec2, _ 
	                                   ByVal _Position2 As Vec2, _ 
	                                   ByVal _Angular1  As AngularStateType Ptr, _
	                                   ByVal _Angular2  As AngularStateType Ptr ) As SlideJointType Ptr
	
	Declare Function CreateAngularJoint( ByVal _Angular1 As AngularStateType Ptr, _
	                                     ByVal _Angular2 As AngularStateType Ptr ) As AngularJointType Ptr
	
	Declare Function CreateRope( ByVal _linear1    As LinearStateType Ptr, _
	                             ByVal _linear2    As LinearStateType Ptr, _
	                             ByVal _unitlength As Single ) As SoftBodyType Ptr
	
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
	
	As String PuzzleText
	
	As Integer iterations
	As Integer warmstart
	
	As Vec2 position
	As Vec2 position_prev
	As Vec2 velocity
	
	As Integer button
	As Integer button_prev
	
	As UInteger Flags
	
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
	As RevoluteJointArray joints
	As DistanceJointArray distancejoints
	As AngularJointArray  angularjoints
	As SlideJointArray    slidejoints
	
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
	joints.Reserve( MAX_REVOLUTE_JOINTS )
	distancejoints.Reserve( MAX_DISTANCE_JOINTS )
	angularjoints.Reserve( MAX_ANGULAR_JOINTS )
	slidejoints.Reserve( MAX_SLIDE_JOINTS )
	
	
	ClearAllArrays()
	
	Puzzle1()
	
	CreateScreen( screen_wid, screen_hgt )
	
	'ComputeData()
	
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
	joints.Destroy()
	distancejoints.Destroy()
	angularjoints.Destroy()
	slidejoints.Destroy()
	
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
		
		''
		If ( Not SoftBodys.Empty ) Then
			
			For S As SoftBodyType Ptr = SoftBodys.P_front To SoftBodys.P_back
				
				S->DisperseImpulses()
				
			Next
			
		EndIf
		
		ComputeNewState()
		
		ComputeData()
		
		UpdateScreen()
		
		ClearImpulses()
		
		Sleep( 1, 1 )
		
	Loop

End Sub


'' Core physics functions
Sub GameType.CollisionDetection()
	
	''	Roxel - Roxel
	If ( Not Roxels.Empty ) Then 
		
		For R1 As RoxelType Ptr = Roxels.p_front To Roxels.p_back - 1
			
			For R2 As RoxelType Ptr = R1 + 1 To Roxels.p_back
				
				
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
				
				For L As LinearSpringType Ptr = S->LinearSprings.P_front To S->LinearSprings.P_back Step 1
					
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
	
	'' Revolute Joints
	If ( Not Joints.Empty ) Then 
		
		For J As RevoluteJointType Ptr = Joints.P_front To Joints.P_back
			
			J->ComputeRestImpulse()
			
		Next
		
	EndIf
	
	'' Distance Joints
	If ( Not DistanceJoints.Empty ) Then 
		
		For J As DistanceJointType Ptr = DistanceJoints.P_front To DistanceJoints.P_back
			
			J->ComputeRestImpulse()
			
		Next
		
	EndIf
	
	'' Slide Joints
	If ( Not SlideJoints.Empty ) Then 
		
		For J As SlideJointType Ptr = SlideJoints.P_front To SlideJoints.P_back
			
			J->ComputeRestImpulse()
			
		Next
		
	EndIf
	
	'' Angular Joints
	If ( Not AngularJoints.Empty ) Then 
		
		For J As AngularJointType Ptr = AngularJoints.P_front To AngularJoints.P_back
			
			J->ComputeRestImpulse()
			
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
	
	'' Revolute joints
	If ( Not Joints.Empty ) Then 
		
		For J As RevoluteJointType Ptr = Joints.P_front To Joints.P_back Step 1
			
			J->ApplyCorrectiveImpulse()
			
		Next
		
		For J As RevoluteJointType Ptr = Joints.P_back To Joints.P_front Step -1
			
			J->ApplyCorrectiveImpulse()
			
		Next
	
	EndIf
	
	'' Distance joints
	If ( Not DistanceJoints.Empty ) Then 
		
		For J As DistanceJointType Ptr = DistanceJoints.P_front To DistanceJoints.P_back Step 1
			
			J->ApplyCorrectiveImpulse()
			
		Next
		
		For J As DistanceJointType Ptr = DistanceJoints.P_back To DistanceJoints.P_front Step -1
			
			J->ApplyCorrectiveImpulse()
			
		Next
		
	EndIf
	
	'' Slide Joints
	If ( Not SlideJoints.Empty ) Then 
		
		For J As SlideJointType Ptr = SlideJoints.P_front To SlideJoints.P_back Step 1
			
			J->ApplyCorrectiveImpulse()
			
		Next
		
		For J As SlideJointType Ptr = SlideJoints.P_back To SlideJoints.P_front Step -1
			
			J->ApplyCorrectiveImpulse()
			
		Next
		
	EndIf
	
	'' Angular Joints
	If ( Not AngularJoints.Empty ) Then 
		
		For J As AngularJointType Ptr = AngularJoints.P_front To AngularJoints.P_back Step 1
			
			J->ApplyCorrectiveImpulse()
			
		Next
		
		For J As AngularJointType Ptr = AngularJoints.P_back To AngularJoints.P_front Step -1
			
			J->ApplyCorrectiveImpulse()
			
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
	
	'' Revolute Joints
	If ( Not Joints.Empty ) Then 
		
		For J As RevoluteJointType Ptr = Joints.P_front To Joints.P_back
			
			J->ApplyWarmStart()
			
		Next
		
	EndIf
	
	'' Distance joints
	If ( Not DistanceJoints.Empty ) Then 
		
		For J As DistanceJointType Ptr = DistanceJoints.P_front To DistanceJoints.P_back
			
			J->ApplyWarmStart()
			
		Next
		
	EndIf
	
	'' Slide Joints
	If ( Not SlideJoints.Empty ) Then 
		
		For J As SlideJointType Ptr = SlideJoints.P_front To SlideJoints.P_back
			
			J->ApplyWarmStart()
			
		Next
		
	EndIf
	
	'' Angular Joints
	If ( Not AngularJoints.Empty ) Then 
		
		For J As AngularJointType Ptr = AngularJoints.P_front To AngularJoints.P_back
			
			J->ApplyWarmStart()
			
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
		
	Cls
	'Line(0,0)-(screen_wid, screen_hgt), RGB( 60, 64, 68 ), BF
	
	''
	Locate  4, 2: Print PuzzleText
	Locate  8, 2: Print Using "(I)terations ###"; iterations
	
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
					
					Dim As Vec2 psn_a = F->LinearLink.a->position
					Dim As Vec2 psn_b = F->LinearLink.b->position
					
					Dim As Vec2 unit = F->LinearLink.unit_vector * 1.5
					
					Line( psn_a.x + unit.y, psn_a.y - unit.x )-( psn_b.x + unit.y, psn_b.y - unit.x ), RGB( 96, 80, 64 )
					Line( psn_a.x - unit.y, psn_a.y + unit.x )-( psn_b.x - unit.y, psn_b.y + unit.x ), RGB( 96, 80, 64 )
					
					Line( psn_a.x - unit.y, psn_a.y + unit.x )-( psn_a.x + unit.y, psn_a.y - unit.x ), RGB( 96, 80, 64 )
					Line( psn_b.x + unit.y, psn_b.y - unit.x )-( psn_b.x - unit.y, psn_b.y + unit.x ), RGB( 96, 80, 64 )
					
					'Line( F->LinearLink.a->position.x, F->LinearLink.a->position.y )-_
				   '    ( F->LinearLink.b->position.x, F->LinearLink.b->position.y ), RGB( 160, 160, 160 )
					
					'Circle( F->LinearLink.position.x, F->LinearLink.position.y ), 2, RGB( 160, 160, 160 ),,, 1, f
					Paint( F->LinearLink.position.x, F->LinearLink.position.y ),  RGB( 96, 80, 64 )
					
					
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
			
			Dim As Vec2 psn_a = S->LinearLink.a->position
			Dim As Vec2 psn_b = S->LinearLink.b->position
			
			Dim As Vec2 unit = S->LinearLink.unit_vector * 2.0
			
			Line( psn_a.x + unit.y, psn_a.y - unit.x )-( psn_b.x + unit.y, psn_b.y - unit.x ), RGB(192, 192, 192)
			Line( psn_a.x - unit.y, psn_a.y + unit.x )-( psn_b.x - unit.y, psn_b.y + unit.x ), RGB(192, 192, 192)
			
			Line( psn_a.x - unit.y, psn_a.y + unit.x )-( psn_a.x + unit.y, psn_a.y - unit.x ), RGB(192, 192, 192)
			Line( psn_b.x + unit.y, psn_b.y - unit.x )-( psn_b.x - unit.y, psn_b.y + unit.x ), RGB(192, 192, 192)
			
			'Line(S->LinearLink.a->position.x, S->LinearLink.a->position.y)-_
			'	 (S->LinearLink.b->position.x, S->LinearLink.b->position.y), RGB(192, 192, 192)
			
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
			
			Circle(psn.x, psn.y), W->radius, RGB( 0, 0, 0 ),,, 1, f
			Circle(psn.x, psn.y), W->radius - 3, RGB( 64, 64, 64 ),,, 1, f
			
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
	
	'' Revolute Joints
	If ( Not Joints.Empty ) Then 
		
		For J As RevoluteJointType Ptr = Joints.P_front To Joints.P_back
			
			Dim As Vec2 p1 = J->body_a->position + J->r_a
			Dim As Vec2 p2 = J->body_b->position + J->r_b
			
			Line(p1.x, p1.y)-(p2.x, p2.y), RGB( 255, 128, 255 )
			
			Circle(p1.x, p1.y), 2, RGB( 255, 128, 255 ),,, 1, f
			Circle(p2.x, p2.y), 2, RGB( 255, 128, 255 ),,, 1, f
			
		Next
		
	EndIf
	
	'' Distance joints
	If ( Not DistanceJoints.Empty ) Then 
		
		For J As DistanceJointType Ptr = DistanceJoints.P_front To DistanceJoints.P_back
			
			Dim As Vec2 p1 = J->body_a->position + J->r_a
			Dim As Vec2 p2 = J->body_b->position + J->r_b
			
			Line(p1.x, p1.y)-(p2.x, p2.y), RGB( 255, 255, 0 )
			
			Circle(p1.x, p1.y), 2, RGB( 255, 255, 0 ),,, 1, f
			Circle(p2.x, p2.y), 2, RGB( 255, 255, 0 ),,, 1, f
			
		Next
		
	EndIf
	
	'' Slide joints
	If ( Not SlideJoints.Empty ) Then 
		
		For J As SlideJointType Ptr = SlideJoints.P_front To SlideJoints.P_back
			
			Dim As Vec2 p1 = J->body_a->position + J->r_a
			Dim As Vec2 p2 = J->body_b->position + J->r_b
			
			Line(p1.x, p1.y)-(p2.x, p2.y), RGB( 0, 255, 0 )
			
			Line(p1.x, p1.y)-(p1.x + J->n.x * 100, p1.y + J->n.y * 100 ), RGB( 0, 255, 0 )
			
			Circle(p1.x, p1.y), 2, RGB( 0, 255, 0 ),,, 1, f
			Circle(p2.x, p2.y), 2, RGB( 0, 255, 0 ),,, 1, f
			
		Next
		
	EndIf
	
	ScreenCopy()
	
End Sub

Sub GameType.CreateScreen( ByVal Wid As Integer, ByVal Hgt As Integer )
   
	Dim As Integer top = hgt
	Dim As Integer lft = 0
	Dim As Integer btm = 0
	Dim As Integer rgt = wid
   
   ScreenRes( Wid, Hgt, 16, 2 )
   
   '' Cartesian ( 0,0 ) = bottom left
   'Window ( lft, top )-( rgt, btm )
   'Window ( 0, Hgt )-( wid, 0 )
   
   '' Default ( 0,0 ) = top left
	Window Screen ( 0, 0 )-( wid, hgt )
	'Window Screen ( lft, btm )-( rgt, top )
	
	View( 0, 0 )-( wid, hgt )
   
   WindowTitle "Steam and railway physics engine. Prototype # 1, october 2018"
   
   Color RGB( 255, 160, 160 ), RGB( 48, 56, 56 )
   
   ScreenSet( 0, 1 )
   
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
	
	''
	GetMouse mouse_x, mouse_y,, button
	
	position = Vec2( Cast( Single, mouse_x) , Cast( Single, mouse_y ) )
	
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
			If ( MultiKey( fb.SC_I ) And ( e.scancode = fb.SC_UP   ) ) Then iterations += 1
			If ( MultiKey( fb.SC_I ) And ( e.scancode = fb.SC_DOWN ) ) Then iterations -= 1
			
			If ( e.scancode = fb.SC_SPACE ) Then warmstart Xor= 1
			
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
	
	If iterations < 1 Then iterations = 1
	
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
	
	If ( Not Wheels.Empty ) Then 
		
		For W As WheelType Ptr = Wheels.p_front To Wheels.p_back
			
			W->AngularState.impulse = Vec2( 0.0, 0.0 )
			W->AngularState.angular_impulse = 0.0
			
		Next
		
	EndIf
	
End Sub

Sub GameType.ClearWarmstart()
	
	''
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
	
	'' Joints
	If ( Not Joints.Empty ) Then 
		
		For J As RevoluteJointType Ptr = Joints.P_front To Joints.P_back
			
			J->accumulated_impulse = Vec2( 0.0, 0.0 )
			
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
	Joints.Clear()
	distancejoints.Clear()
	angularjoints.Clear()
	slidejoints.Clear()
	
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
