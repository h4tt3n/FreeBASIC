''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 4, september 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''*******************************************************************************

Sub GameType.Puzzle0()
	
	iterations = 5
	warmstart  = 1
	
	PuzzleText = "Demo 0: Winch Constraint"
	
	ClearAllArrays()
	
	GameCamera.RestZoom( 2.0 )
	GameCamera.RestPosition( Vec2( SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5 ) )
	
	Dim As WheelType Ptr W1 = CreateWheel( Vec2( 400.0, 600.0 ), 50.0 )
	
	Dim As BoxType Ptr B0 = CreateBox( Vec2( 0.0, 0.0 ), FLOAT_MAX, Vec2( 50.0, 50.0 ) )
	Dim As BoxType Ptr B1 = CreateBox( Vec2( 400.0, 200.0 ), Vec2( 50.0, 50.0 ) )
	
	CreateRevoluteConstraint( Vec2( 400.0, 600.0 ), @(W1->AngularState), @(B0->AngularState)  )
	
	Dim As DistanceConstraintType Ptr L1 = CreateDistanceConstraint( Vec2( 450.0, 600.0 ), Vec2( 400.0, 250.0 ), @(W1->AngularState), @(B1->AngularState) )
	
End Sub

Sub GameType.Puzzle1()
	
	iterations  = 5
	warmstart   = 1
	
	PuzzleText = "Demo 1: Walschaerts valve gear"
	
	ClearAllArrays()
	
	GameCamera.RestZoom( 2.0 )
	GameCamera.RestPosition( Vec2( SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5 ) )
	
	
	'' Define positions
	
	'' back wheel
	Dim As Vec2   back_wheel_pos   = Vec2( 300.0, 500.0 )
	Dim As Single back_wheel_angle = 0.0 * TWO_PI
	
	'' front wheel
	Dim As Vec2   front_wheel_pos   = Vec2( 520.0, 500.0 )
	Dim As Single front_wheel_angle = 0.0 * TWO_PI
	
	'' pistons
	Dim As Vec2   piston_rod_pos = Vec2( 700.0, 500.0 )
	Dim As Vec2   valve_rod_pos  = Vec2( 750.0, 420.0 )
	
	'' Define pin positions
	
	'' Wheel pins
	Dim As Vec2   back_wheel_pin  = back_wheel_pos  + Vec2(  0.0, 50.0 ).RotateCCW( back_wheel_angle )
	Dim As Vec2   front_wheel_pin = front_wheel_pos + Vec2(  0.0, 50.0 ).RotateCCW( front_wheel_angle )
	Dim As Vec2   eccentric_pin   = back_wheel_pos  + Vec2( 25.0,  0.0 ).RotateCCW( back_wheel_angle )
	
	'' 
	Dim As Vec2   valve_rod_pin = valve_rod_pos  + Vec2( -100.0, 0.0 )
	
	''
	Dim As Vec2   crosshead_center_pin = piston_rod_pos + Vec2( -100.0, 0.0 )
	Dim As Vec2   crosshead_lower_pin  = crosshead_center_pin + Vec2( 0.0, 50.0 )
	
	''
	Dim As Vec2   combination_link_upper_pin = valve_rod_pin + Vec2( 0.0, -40.0 )
	Dim As Vec2   combination_link_lower_pin = valve_rod_pin + Vec2( 0.0, 130.0 )
	
	''
	Dim As Single expansion_link_angle = -0.05 * TWO_PI
	Dim As Vec2   expansion_link_center_pin = combination_link_upper_pin + Vec2( -200, 0.0 )
	Dim As Vec2   expansion_link_lower_pin  = expansion_link_center_pin + Vec2( 0.0, 100.0 ).RotateCCW( expansion_link_angle )
	
	''
	Dim As Vec2   radius_rod_slide_pin  = expansion_link_center_pin
	Dim As Vec2   radius_rod_back_pin   = expansion_link_center_pin + vec2( -80, 0.0 )
	
	''
	'Dim As Single lifting_arm_angle      = 0.0 * TWO_PI
	Dim As Vec2   lifting_arm_center_pin = Vec2( 400, 300 )
	Dim As Vec2   lifting_arm_lower_pin  = lifting_arm_center_pin + Vec2( -60.0, 0.0 )'.RotateCCW( lifting_arm_angle )
	
	''
	'Dim As Single reverse_arm_angle     =  lifting_arm_angle - 0.25 * TWO_PI
	Dim As Vec2   reverse_arm_lower_pin = lifting_arm_center_pin + Vec2( 00.0, 60.0 )'.RotateCCW( reverse_arm_angle )
	
	
	'' Create rigid bodies
	
	'' World
	Dim As BoxType Ptr World = CreateBox( Vec2( 600.0, 700.0 ), FLOAT_MAX, Vec2( 600.0, 100.0 ) )
	
	'' Drive frame
	Dim As BoxType Ptr drive_frame  = CreateBox( Vec2( 600.0, 350.0 ), Vec2( 400.0, 20.0 ) )
	
	'' Wheels
	Dim As WheelType Ptr front_wheel = CreateWheel( front_wheel_pos, 100.0 )
	Dim As WheelType Ptr back_wheel  = CreateWheel( back_wheel_pos, 100.0 )
	
	'' Piston
	Dim As BoxType Ptr piston_rod    = CreateBox( piston_rod_pos, Vec2( 100.0, 8.0 ) )
	
	'' Valve
	Dim As BoxType Ptr piston_valve  = CreateBox( valve_rod_pos,  Vec2( 100.0, 4.0 ) )
	
	'' Tie Rod
	Dim As BoxType Ptr tie_rod       = CreateBox( 20.0, back_wheel_pin, front_wheel_pin )
	
	'' Connecting rod
	Dim As BoxType Ptr connecting_rod   = CreateBox( 15.0, crosshead_center_pin, back_wheel_pin )
	
	'' Expansion link
	Dim As BoxType Ptr expansion_link   = CreateBox( expansion_link_center_pin, Vec2( 10.0, 80.0 ), expansion_link_angle )
	
	'' Eccentric rod
	Dim As BoxType Ptr eccetric_rod   = CreateBox( 8.0, eccentric_pin, expansion_link_lower_pin )
	
	'' Combination Link
	Dim As BoxType Ptr combination_link = CreateBox( 8.0, combination_link_upper_pin, combination_link_lower_pin )
	
	'' Radius rod
	Dim As BoxType Ptr radius_rod       = CreateBox( 8.0, radius_rod_back_pin, combination_link_upper_pin )
	
	Dim As BoxType Ptr union_link       = CreateBox( 8.0, crosshead_lower_pin, combination_link_lower_pin )
	
	Dim As BoxType Ptr lifting_arm = CreateBox( 12.0, lifting_arm_center_pin, lifting_arm_lower_pin )
	
	Dim As BoxType Ptr reverse_arm = CreateBox( 24.0, lifting_arm_center_pin, reverse_arm_lower_pin )
	
	Dim As BoxType Ptr lifting_link     = CreateBox( 8.0, lifting_arm_lower_pin, radius_rod_back_pin )
	
	
	'' Create constraints
	
	''
	CreateRevoluteConstraint( drive_frame->AngularState.position + Vec2( -100.0, -200.0 ), @(World->AngularState), @(drive_frame->AngularState) )
	CreateAngularConstraint( @(World->AngularState), @(drive_frame->AngularState) )
	
	''
	CreateRevoluteConstraint( front_wheel->AngularState.position, @(drive_frame->AngularState), @(front_wheel->AngularState) )
	CreateRevoluteConstraint( back_wheel->AngularState.position, @(drive_frame->AngularState), @(back_wheel->AngularState) )
	
	''
	CreateRevoluteConstraint( expansion_link->AngularState.position, @(drive_frame->AngularState), @(expansion_link->AngularState) )
	
	'' Tie rod
	CreateRevoluteConstraint( front_wheel_pin, @(tie_rod->AngularState), @(front_wheel->AngularState) )
	CreateRevoluteConstraint( back_wheel_pin, @(tie_rod->AngularState), @(back_wheel->AngularState) )
	
	'' Connecting rod
	CreateRevoluteConstraint( back_wheel_pin, @(connecting_rod->AngularState), @(back_wheel->AngularState) )
	CreateRevoluteConstraint( crosshead_center_pin, @(connecting_rod->AngularState), @(piston_rod->AngularState) )
	
	'' Eccentric rod
	CreateRevoluteConstraint( eccentric_pin, @(eccetric_rod->AngularState), @(back_wheel->AngularState) )
	CreateRevoluteConstraint( expansion_link_lower_pin, @(eccetric_rod->AngularState), @(expansion_link->AngularState) )
	
	'' Combination Link
	CreateRevoluteConstraint( valve_rod_pin, @(combination_link->AngularState), @(piston_valve->AngularState) )
	
	'' union link
	CreateRevoluteConstraint( combination_link_lower_pin, @(combination_link->AngularState), @(union_link->AngularState) )
	CreateRevoluteConstraint( crosshead_lower_pin, @(piston_rod->AngularState), @(union_link->AngularState) )
	
	'' Radius rod
	CreateRevoluteConstraint( combination_link_upper_pin, @(combination_link->AngularState), @(radius_rod->AngularState) )
	
	'' Lifting Link
	CreateRevoluteConstraint( radius_rod_back_pin, @(lifting_link->AngularState), @(radius_rod->AngularState) )
	CreateRevoluteConstraint( lifting_arm_lower_pin, @(lifting_link->AngularState), @(lifting_arm->AngularState) )
	
	'' 
	CreateRevoluteConstraint( lifting_arm_center_pin, @(drive_frame->AngularState), @(lifting_arm->AngularState) )
	CreateRevoluteConstraint( lifting_arm_center_pin, @(drive_frame->AngularState), @(reverse_arm->AngularState) )
	'CreateRevoluteConstraint( lifting_arm_center_pin, @(lifting_arm->AngularState), @(reverse_arm->AngularState) )
	
	''
	CreateSlideConstraint( Vec2( 1.0, 0.0 ), piston_rod->AngularState.position, @(drive_frame->AngularState), @(piston_rod->AngularState) )
	CreateSlideConstraint( Vec2( 1.0, 0.0 ), piston_valve->AngularState.position, @(drive_frame->AngularState), @(piston_valve->AngularState) )
	
	CreateSlideConstraint( Vec2( 0.0, 1.0 ), radius_rod_slide_pin, @(expansion_link->AngularState), @(radius_rod->AngularState) )
	
	''
	'CreateAngularConstraint( @(world->AngularState), @(drive_frame->AngularState) )
	CreateAngularConstraint( @(drive_frame->AngularState), @(piston_rod->AngularState) )
	CreateAngularConstraint( @(drive_frame->AngularState), @(piston_valve->AngularState) )
	CreateAngularConstraint( @(lifting_arm->AngularState), @(reverse_arm->AngularState) )
	'CreateAngularConstraint( @(lifting_arm->AngularState), @(drive_frame->AngularState) )
	
	CreateDistanceConstraint( Vec2( 220.0, 350.0 ), reverse_arm_lower_pin, 220.0, @(drive_frame->AngularState), @(lifting_arm->AngularState) )
	
	
	front_wheel->AngularState.angular_impulse = 10.0
	'back_wheel->AngularState.angular_impulse  = 10.0
	
End Sub

Sub GameType.Puzzle2()
	
	'' 
	iterations = 5
	warmstart  = 1
	
	PuzzleText = "Demo 2: "
	
	ClearAllArrays()
	
	GameCamera.RestZoom( 2.0 )
	GameCamera.RestPosition( Vec2( SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5 ) )
	
	Dim As WheelType Ptr B1 = CreateWheel( Vec2( 0.0, 1000.0 ), FLOAT_MAX )
	
	Dim As WheelType Ptr B2 = CreateWheel( Vec2( 400.0, 400.0 ), 50.0 )
	Dim As WheelType Ptr B3 = CreateWheel( Vec2( 500.0, 400.0 ), 50.0 )
	Dim As WheelType Ptr B4 = CreateWheel( Vec2( 600.0, 400.0 ), 50.0 )
	Dim As WheelType Ptr B5 = CreateWheel( Vec2( 700.0, 400.0 ), 50.0 )
	Dim As WheelType Ptr B6 = CreateWheel( Vec2( 800.0, 400.0 ), 50.0 )
	Dim As WheelType Ptr B7 = CreateWheel( Vec2( 900.0, 400.0 ), 50.0 )
	
	Dim As WheelType Ptr B8 = CreateWheel( Vec2( 650.0, 200.0 ), 50.0 )
	
	Dim As RevoluteConstraintType Ptr J1 = CreateRevoluteConstraint( Vec2( 350, 400 ), @(B1->AngularState), @(B2->AngularState) )
	Dim As RevoluteConstraintType Ptr J2 = CreateRevoluteConstraint( Vec2( 450, 400 ), @(B2->AngularState), @(B3->AngularState) )
	Dim As RevoluteConstraintType Ptr J3 = CreateRevoluteConstraint( Vec2( 550, 400 ), @(B3->AngularState), @(B4->AngularState) )
	Dim As RevoluteConstraintType Ptr J4 = CreateRevoluteConstraint( Vec2( 650, 400 ), @(B4->AngularState), @(B5->AngularState) )
	Dim As RevoluteConstraintType Ptr J5 = CreateRevoluteConstraint( Vec2( 750, 400 ), @(B5->AngularState), @(B6->AngularState) )
	Dim As RevoluteConstraintType Ptr J6 = CreateRevoluteConstraint( Vec2( 850, 400 ), @(B6->AngularState), @(B7->AngularState) )
	Dim As RevoluteConstraintType Ptr J7 = CreateRevoluteConstraint( Vec2( 950, 400 ), @(B7->AngularState), @(B1->AngularState) )
	
End Sub

Sub GameType.Puzzle3()
	
	''
	
	iterations = 5
	warmstart  = 1
	
	Dim As Integer GirderLength = 8
	Dim As Integer GirderWidth  = 2
	Dim As Integer UnitLength   = 48
	Dim As Integer UnitWidth    = 32
	
	PuzzleText = "Demo 3: "
	
	ClearAllArrays()
	
	GameCamera.RestZoom( 2.0 )
	GameCamera.RestPosition( Vec2( SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5 ) )
	
	Dim As RoxelType Ptr PP3 = CreateRoxel( Vec2( 400, 200 ), FLOAT_MAX, 4.0 )
	
	
	Dim As SoftBodyType Ptr G3 = CreateSoftGirder( Vec2( 200.0, 200.0 ), _
	                                            Vec2( Cos( 0.0 * TWO_PI ), Sin( 0.0 * TWO_PI )), _
	                                            Vec2( GirderLength, GirderWidth ), _
	                                            Vec2( UnitLength, UnitWidth ), _
	                                            Z_TRUSS )
	
	Dim As SoftBodyType Ptr G5 = CreateSoftGirder( Vec2( 600.0, 200.0 ), _
	                                            Vec2( Cos( 0.0 * TWO_PI ), Sin( 0.0 * TWO_PI )), _
	                                            Vec2( GirderLength, GirderWidth ), _
	                                            Vec2( UnitLength, UnitWidth ), _
	                                            W_TRUSS )
	
	G3->Addimpulse( Vec2( 0.0, -20.0 ) )
	G5->Addimpulse( Vec2( 0.0,  20.0 ) )
	
	CreateLinearSpring( 0.2, 1.0, 0.5, @(G3->LinearSprings.p_back->LinearLink), @(G5->LinearSprings.p_back->LinearLink), @LinearSprings )
	CreateLinearSpring( 0.2, 1.0, 0.5, PP3, @(G5->LinearSprings.p_front->LinearLink), @LinearSprings )
	
End Sub

Sub GameType.Puzzle4()
	
	''
	
	iterations  = 5
	warmstart   = 1
	
	PuzzleText = "Demo 4: "
	
	ClearAllArrays()
	
	GameCamera.RestZoom( 2.0 )
	GameCamera.RestPosition( Vec2( SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5 ) )
	
	Dim As RoxelType Ptr PP3 = CreateRoxel( Vec2( 0, 0 ), 5.0, 10.0 )
	Dim As RoxelType Ptr PP4 = CreateRoxel( Vec2( 0, 0 ), 10.0, 15.0 )
	
	Dim As SoftBodyType Ptr G2 = CreateSoftGirder( Vec2( 200.0, 400.0 ), _
	                                            Vec2( Cos( 0.0 * TWO_PI ), Sin( 0.0 * TWO_PI )), _
	                                            Vec2( 16, 2 ), _
	                                            Vec2( 48, 32 ), _
	                                            V_TRUSS )
	
End Sub

Sub GameType.Puzzle5()
	
	'' 
	
	iterations   = 5
	warmstart    = 1
	
	PuzzleText   = "Demo 5: Gears"
	
	ClearAllArrays()
	
	GameCamera.RestZoom( 2.0 )
	GameCamera.RestPosition( Vec2( SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5 ) )
	
	Dim As Single buffer = 0.0
	
	'' 
	Dim As BoxType Ptr B1 = CreateBox( Vec2( 0.0, 0.0 ), FLOAT_MAX, Vec2( 100.0, 40.0 ) )
	'Dim As BoxType Ptr B2 = CreateBox( Vec2( 100.0, 600.0 ), Vec2( 200.0, 60.0 ) )
	
	'' wheels
	Dim As WheelType Ptr W1 = CreateWheel( Vec2( 200.0, 500.0 ), 50.0 )
	Dim As WheelType Ptr W2 = CreateWheel( Vec2( 300.0, 500.0 ), 50.0 )
	Dim As WheelType Ptr W3 = CreateWheel( Vec2( 400.0, 500.0 ), 50.0 )
	Dim As WheelType Ptr W4 = CreateWheel( Vec2( 500.0, 500.0 ), 50.0 )
	Dim As WheelType Ptr W5 = CreateWheel( Vec2( 600.0, 500.0 ), 50.0 )
	Dim As WheelType Ptr W6 = CreateWheel( Vec2( 700.0, 500.0 ), 50.0 )

	''
	CreateRevoluteConstraint( Vec2( 200, 500 ), @(B1->AngularState), @(W1->AngularState) )
	CreateRevoluteConstraint( Vec2( 300, 500 ), @(B1->AngularState), @(W2->AngularState) )
	CreateRevoluteConstraint( Vec2( 400, 500 ), @(B1->AngularState), @(W3->AngularState) )
	CreateRevoluteConstraint( Vec2( 500, 500 ), @(B1->AngularState), @(W4->AngularState) )
	CreateRevoluteConstraint( Vec2( 600, 500 ), @(B1->AngularState), @(W5->AngularState) )
	CreateRevoluteConstraint( Vec2( 700, 500 ), @(B1->AngularState), @(W6->AngularState) )

	
	'J10 = CreateRevoluteConstraint( Vec2( 200, 600 ), @(B2->AngularState), @(W1->AngularState) )
	
	''
	'CreateAngularConstraint( @(W1->AngularState), @(W2->AngularState) )
	'CreateAngularConstraint( @(W3->AngularState), @(W4->AngularState) )
	'CreateAngularConstraint( @(W5->AngularState), @(W6->AngularState) )
	
	''
	'CreateGearConstraint( @(W1->AngularState), @(W2->AngularState), -1/10 )
	'CreateGearConstraint( @(W2->AngularState), @(W3->AngularState),  -10 )
	'CreateGearConstraint( @(W3->AngularState), @(W4->AngularState), -1/10 )
	
	'CreateGearConstraint( @(W1->AngularState), @(W2->AngularState), -1.0 )
	'CreateGearConstraint( @(W2->AngularState), @(W3->AngularState), -1.0 )
	'CreateGearConstraint( @(W3->AngularState), @(W4->AngularState), -1.0 )
	'CreateGearConstraint( @(W4->AngularState), @(W5->AngularState), -1.0 )
	'CreateGearConstraint( @(W5->AngularState), @(W6->AngularState), -1.0 )
	'CreateGearConstraint( @(W6->AngularState), @(W1->AngularState), -1.0 )
	
	CreateGearConstraint( @(W1->AngularState), @(W2->AngularState), W1->radius, -W2->radius )
	CreateGearConstraint( @(W2->AngularState), @(W3->AngularState), W2->radius, -W3->radius )
	CreateGearConstraint( @(W3->AngularState), @(W4->AngularState), W3->radius, -W4->radius )
	CreateGearConstraint( @(W4->AngularState), @(W5->AngularState), W4->radius, -W5->radius )
	CreateGearConstraint( @(W5->AngularState), @(W6->AngularState), W5->radius, -W6->radius )
	
	''
	'W1->AngularState.angular_impulse = 1.0
	W6->AngularState.angular_impulse = 1.0
	'W5->AngularState.angular_impulse = 1.0
	
End Sub

Sub GameType.Puzzle6()
	
	'' 
	
	iterations   = 5
	warmstart    = 1
	
	PuzzleText   = "Demo 6: Gears"
	
	ClearAllArrays()
	
	GameCamera.RestZoom( 2.0 )
	GameCamera.RestPosition( Vec2( SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5 ) )
	
	'' 
	Dim As BoxType Ptr B1 = CreateBox( Vec2( 0.0, 0.0 ), FLOAT_MAX, Vec2( 1000.0, 100.0 ) )
	Dim As BoxType Ptr B2 = CreateBox( Vec2( 300.1, 200.0 ), 3e5, Vec2( 200.0, 100.0 ) )
	
	'' wheels
	'Dim As BoxType Ptr W4 = CreateBox( Vec2( 675.0, 500.0 ), Vec2( 150.0, 150.0 ) )
	Dim As WheelType Ptr W4 = CreateWheel( Vec2( 675.0, 500.0 ), 150.0 )
	Dim As WheelType Ptr W3 = CreateWheel( Vec2( 550.0, 500.0 ), 50.0 )
	Dim As WheelType Ptr W2 = CreateWheel( Vec2( 425.0, 500.0 ), 50.0 )
	Dim As WheelType Ptr W1 = CreateWheel( Vec2( 300.0, 500.0 ), 100.0 )
	
	'Dim As WheelType Ptr W4 = CreateWheel( Vec2( 675.0, 500.0 ), 100.0, Rnd() * TWO_PI )
	'Dim As WheelType Ptr W3 = CreateWheel( Vec2( 550.0, 500.0 ), 100.0, Rnd() * TWO_PI )
	'Dim As WheelType Ptr W2 = CreateWheel( Vec2( 425.0, 500.0 ), 100.0, Rnd() * TWO_PI )
	'Dim As WheelType Ptr W1 = CreateWheel( Vec2( 300.0, 500.0 ), 100.0, Rnd() * TWO_PI )
	
	''
	CreateRevoluteConstraint( Vec2( 300, 500 ), @(B1->AngularState), @(W1->AngularState) )
	CreateRevoluteConstraint( Vec2( 425, 500 ), @(B1->AngularState), @(W2->AngularState) )
	CreateRevoluteConstraint( Vec2( 550, 500 ), @(B1->AngularState), @(W3->AngularState) )
	CreateRevoluteConstraint( Vec2( 675, 500 ), @(B1->AngularState), @(W4->AngularState) )
	
	''
	'CreateGearConstraint( @(W1->AngularState), @(W2->AngularState), 4.0, -1.0 )
	'CreateGearConstraint( @(W2->AngularState), @(W3->AngularState), 4.0, -1.0 )
	'CreateGearConstraint( @(W3->AngularState), @(W4->AngularState), 4.0, -1.0 )
	
	CreateGearConstraint( @(W1->AngularState), @(W2->AngularState), -4.0 )
	CreateGearConstraint( @(W2->AngularState), @(W3->AngularState), -4.0 )
	CreateGearConstraint( @(W3->AngularState), @(W4->AngularState), -4.0 )
	'CreateGearConstraint( @(W4->AngularState), @(W1->AngularState), -(1.0/64.0) )
	
	CreateDistanceConstraint( Vec2( 300.1, 300.0 ), Vec2( 300.1, 550.0 ), @(B2->AngularState), @(W1->AngularState) )
	
	''
	'W4->AngularState.angular_impulse = 0.01
	B2->AngularState.addImpulse( Vec2( 2.0, 0.0 ) )
	
	'G1->SetGearRatio( -0.1 )
	'G2->SetGearRatio( -1.0 )
	'G3->SetGearRatio( 10.0 )
	
End Sub

Sub GameType.Puzzle7()
	
	iterations = 5
	warmstart  = 1
	
	PuzzleText = "Demo 7: "
	
	ClearAllArrays()
	
	GameCamera.RestZoom( 2.0 )
	GameCamera.RestPosition( Vec2( SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5 ) )
	
End Sub

Sub GameType.Puzzle8()
	
	iterations = 5
	warmstart  = 1
	
	PuzzleText = "Demo 8:"
	
	ClearAllArrays()
	
	GameCamera.RestZoom( 2.0 )
	GameCamera.RestPosition( Vec2( SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5 ) )
	
End Sub

Sub GameType.Puzzle9()
	
	iterations = 5
	warmstart  = 1
	
	PuzzleText = "Demo 9:"
	
	ClearAllArrays()
	
	GameCamera.RestZoom( 2.0 )
	GameCamera.RestPosition( Vec2( SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5 ) )
	
	Dim As BoxType Ptr B0 = CreateBox( Vec2( 0.0, 0.0 ), FLOAT_MAX, Vec2( 1000.0, 100.0 ) )
	Dim As BoxType Ptr B1 = CreateBox( Vec2( 0.0, 500.0 ), 5e5, Vec2( 50.0, 50.0 ) )
	Dim As BoxType Ptr B2 = CreateBox( Vec2( 0.0, 100.0 ), 1e2, Vec2( 200.0, 100.0 ) )
	Dim As BoxType Ptr B3 = CreateBox( Vec2( 0.0, 100.0 ), 1e2, Vec2( 200.0, 100.0 ) )
	
	CreateRevoluteConstraint( Vec2( 0.0, 500.0 ), @(B0->AngularState), @(B1->AngularState) )
	CreateDistanceConstraint( Vec2( 0.0, 500.0 ), Vec2( 0.0, 100.0 ), @(B1->AngularState), @(B2->AngularState) )
	'CreateLinearSpring( @(B1->AngularState), @(B3->AngularState), @LinearSprings )
	CreateRope( 25.0, 1.0, @(B1->AngularState), @(B3->AngularState) )
	
End Sub
