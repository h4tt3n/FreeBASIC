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

Sub GameType.Puzzle1()
	
	'' Wrecking ball
	
	iterations  = 5
	warmstart   = 1
	
	PuzzleText = "Demo 1: Walschaerts valve gear"
	
	ClearAllArrays()
	
	
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
	
	
	'' Create joints
	
	''
	CreateRevoluteJoint( drive_frame->AngularState.position, @(World->AngularState), @(drive_frame->AngularState) )
	
	''
	CreateRevoluteJoint( front_wheel->AngularState.position, @(drive_frame->AngularState), @(front_wheel->AngularState) )
	CreateRevoluteJoint( back_wheel->AngularState.position, @(drive_frame->AngularState), @(back_wheel->AngularState) )
	
	''
	CreateRevoluteJoint( expansion_link->AngularState.position, @(drive_frame->AngularState), @(expansion_link->AngularState) )
	
	'' Tie rod
	CreateRevoluteJoint( front_wheel_pin, @(tie_rod->AngularState), @(front_wheel->AngularState) )
	CreateRevoluteJoint( back_wheel_pin, @(tie_rod->AngularState), @(back_wheel->AngularState) )
	
	'' Connecting rod
	CreateRevoluteJoint( back_wheel_pin, @(connecting_rod->AngularState), @(back_wheel->AngularState) )
	CreateRevoluteJoint( crosshead_center_pin, @(connecting_rod->AngularState), @(piston_rod->AngularState) )
	
	'' Eccentric rod
	CreateRevoluteJoint( eccentric_pin, @(eccetric_rod->AngularState), @(back_wheel->AngularState) )
	CreateRevoluteJoint( expansion_link_lower_pin, @(eccetric_rod->AngularState), @(expansion_link->AngularState) )
	
	'' Combination Link
	CreateRevoluteJoint( valve_rod_pin, @(combination_link->AngularState), @(piston_valve->AngularState) )
	
	'' union link
	CreateRevoluteJoint( combination_link_lower_pin, @(combination_link->AngularState), @(union_link->AngularState) )
	CreateRevoluteJoint( crosshead_lower_pin, @(piston_rod->AngularState), @(union_link->AngularState) )
	
	'' Radius rod
	CreateRevoluteJoint( combination_link_upper_pin, @(combination_link->AngularState), @(radius_rod->AngularState) )
	
	'' Lifting Link
	CreateRevoluteJoint( radius_rod_back_pin, @(lifting_link->AngularState), @(radius_rod->AngularState) )
	CreateRevoluteJoint( lifting_arm_lower_pin, @(lifting_link->AngularState), @(lifting_arm->AngularState) )
	
	'' 
	CreateRevoluteJoint( lifting_arm_center_pin, @(drive_frame->AngularState), @(lifting_arm->AngularState) )
	CreateRevoluteJoint( lifting_arm_center_pin, @(lifting_arm->AngularState), @(reverse_arm->AngularState) )
	
	''
	CreateSlideJoint( Vec2( 1.0, 0.0 ), piston_rod->AngularState.position, @(drive_frame->AngularState), @(piston_rod->AngularState) )
	CreateSlideJoint( Vec2( 1.0, 0.0 ), piston_valve->AngularState.position, @(drive_frame->AngularState), @(piston_valve->AngularState) )
	
	CreateSlideJoint( Vec2( 0.0, 1.0 ), radius_rod_slide_pin, @(expansion_link->AngularState), @(radius_rod->AngularState) )
	
	''
	CreateAngularJoint( @(world->AngularState), @(drive_frame->AngularState) )
	CreateAngularJoint( @(drive_frame->AngularState), @(piston_rod->AngularState) )
	CreateAngularJoint( @(drive_frame->AngularState), @(piston_valve->AngularState) )
	CreateAngularJoint( @(lifting_arm->AngularState), @(reverse_arm->AngularState) )
	'CreateAngularJoint( @(lifting_arm->AngularState), @(drive_frame->AngularState) )
	
	'CreateDistanceJoint( Vec2( 220.0, 350.0 ), reverse_arm_lower_pin, @(drive_frame->AngularState), @(lifting_arm->AngularState) )
	
	
	front_wheel->AngularState.angular_impulse = 5.0
	'back_wheel->AngularState.angular_impulse  = 10.0
	
End Sub

Sub GameType.Puzzle2()
	
	'' 
	iterations = 5
	warmstart  = 0
	
	PuzzleText = "Demo 2: "
	
	ClearAllArrays()
	
	Dim As WheelType Ptr B1 = CreateWheel( Vec2( 0.0, 1000.0 ), FLOAT_MAX, 1.0 )
	
	Dim As WheelType Ptr B2 = CreateWheel( Vec2( 400.0, 400.0 ), 50.0 )
	Dim As WheelType Ptr B3 = CreateWheel( Vec2( 500.0, 400.0 ), 50.0 )
	Dim As WheelType Ptr B4 = CreateWheel( Vec2( 600.0, 400.0 ), 50.0 )
	Dim As WheelType Ptr B5 = CreateWheel( Vec2( 700.0, 400.0 ), 50.0 )
	Dim As WheelType Ptr B6 = CreateWheel( Vec2( 800.0, 400.0 ), 50.0 )
	Dim As WheelType Ptr B7 = CreateWheel( Vec2( 900.0, 400.0 ), 50.0 )
	
	Dim As WheelType Ptr B8 = CreateWheel( Vec2( 650.0, 200.0 ), 50.0 )
	
	 'B1->AngularState.inv_mass    = 0.0
	 'B1->AngularState.inv_inertia = 0.0
	
	'B7->AngularState.angular_velocity = 10.0
	'B2->AngularState.angular_velocity = -0.5
	
	Dim As RevoluteJointType Ptr J1 = CreateRevoluteJoint( Vec2( 350, 400 ), @(B1->AngularState), @(B2->AngularState) )
	Dim As RevoluteJointType Ptr J2 = CreateRevoluteJoint( Vec2( 450, 400 ), @(B2->AngularState), @(B3->AngularState) )
	Dim As RevoluteJointType Ptr J3 = CreateRevoluteJoint( Vec2( 550, 400 ), @(B3->AngularState), @(B4->AngularState) )
	Dim As RevoluteJointType Ptr J4 = CreateRevoluteJoint( Vec2( 650, 400 ), @(B4->AngularState), @(B5->AngularState) )
	Dim As RevoluteJointType Ptr J5 = CreateRevoluteJoint( Vec2( 750, 400 ), @(B5->AngularState), @(B6->AngularState) )
	Dim As RevoluteJointType Ptr J6 = CreateRevoluteJoint( Vec2( 850, 400 ), @(B6->AngularState), @(B7->AngularState) )
	Dim As RevoluteJointType Ptr J7 = CreateRevoluteJoint( Vec2( 950, 400 ), @(B7->AngularState), @(B1->AngularState) )
	
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
	
	Dim As RoxelType Ptr PP3 = CreateRoxel( Vec2( 400, 200 ), FLOAT_MAX, 4.0 )
	
	
	Dim As SoftBodyType Ptr G3 = CreateSoftGirder( Vec2( 200.0, 200.0 ), _
	                                            Vec2( Cos( 0.0 * TWO_PI ), Sin( 0.0 * TWO_PI )), _
	                                            Vec2( GirderLength, GirderWidth ), _
	                                            Vec2( UnitLength, UnitWidth ), _
	                                            X_TRUSS )
	
	Dim As SoftBodyType Ptr G5 = CreateSoftGirder( Vec2( 600.0, 200.0 ), _
	                                            Vec2( Cos( 0.0 * TWO_PI ), Sin( 0.0 * TWO_PI )), _
	                                            Vec2( GirderLength, GirderWidth ), _
	                                            Vec2( UnitLength, UnitWidth ), _
	                                            X_TRUSS )
	
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
	warmstart    = 0
	
	PuzzleText = "Demo 5: "
	
	ClearAllArrays()
	
	Dim As Integer GirderWidth  = 2
	Dim As Integer GirderLength = 16
	Dim As Integer SpringLength = 24
	
	
	Dim As SoftBodyType Ptr G2 = CreateSoftGirder( Vec2( 800.0, 400.0 ), _
	                                               Vec2( Cos( 0.25 * TWO_PI ), Sin( 0.25 * TWO_PI )), _
	                                               Vec2( GirderLength, GirderWidth ), _
	                                               Vec2( SpringLength, SpringLength ), _
	                                               X_TRUSS )
	
End Sub

Sub GameType.Puzzle6()
	
	'' 
	
	iterations   = 5
	warmstart    = 0
	
	PuzzleText   = "Demo 6: "
	
	ClearAllArrays()
	
	''
	'Dim As BoxType Ptr B1 = CreateBox( Vec2( 500.0, 1000.0 ), FLOAT_MAX, Vec2( 1.0, 1.0 ) )
	
	'' boiler
	Dim As BoxType Ptr B2 = CreateBox( Vec2( 500.0, 400.0 ), FLOAT_MAX, Vec2( 100.0, 40.0 ) )
	
	'' wheels
	Dim As WheelType Ptr W1 = CreateWheel( Vec2( 400.0, 500.0 ), 70.0 )
	Dim As WheelType Ptr W2 = CreateWheel( Vec2( 600.0, 500.0 ), 70.0 )
	'Dim As WheelType Ptr W3 = CreateWheel( Vec2( 300.0, 550.0 ), 30.0 )
	'Dim As WheelType Ptr W4 = CreateWheel( Vec2( 200.0, 550.0 ), 30.0 )
	
	'' rods
	'Dim As BoxType Ptr B3 = CreateBox( Vec2( 500.0, 450.0 ), Vec2( 100.0, 2.5 ) )
	'Dim As BoxType Ptr B4 = CreateBox( Vec2( 450.0, 500.0 ), Vec2( 100.0, 2.5 ) )
	
	'Dim As RevoluteJointType Ptr J0 = CreateRevoluteJoint( Vec2( 400, 200 ), @(B1->AngularState), @(B2->AngularState) )
	'Dim As RevoluteJointType Ptr J1 = CreateRevoluteJoint( Vec2( 500, 200 ), @(B1->AngularState), @(B2->AngularState) )
	
	''
	Dim As RevoluteJointType Ptr J2 = CreateRevoluteJoint( Vec2( 400, 500 ), @(B2->AngularState), @(W1->AngularState) )
	Dim As RevoluteJointType Ptr J3 = CreateRevoluteJoint( Vec2( 600, 500 ), @(B2->AngularState), @(W2->AngularState) )
	
	'Dim As RevoluteJointType Ptr J4 = CreateRevoluteJoint( Vec2( 300, 550 ), @(B2->AngularState), @(W3->AngularState) )
	'Dim As RevoluteJointType Ptr J5 = CreateRevoluteJoint( Vec2( 200, 550 ), @(B2->AngularState), @(W4->AngularState) )
	'
	'Dim As RevoluteJointType Ptr J6 = CreateRevoluteJoint( Vec2( 400, 450 ), @(B3->AngularState), @(W1->AngularState) )
	'Dim As RevoluteJointType Ptr J7 = CreateRevoluteJoint( Vec2( 600, 450 ), @(B3->AngularState), @(W2->AngularState) )
	'
	'Dim As RevoluteJointType Ptr J8 = CreateRevoluteJoint( Vec2( 350, 500 ), @(B4->AngularState), @(W1->AngularState) )
	'Dim As RevoluteJointType Ptr J9 = CreateRevoluteJoint( Vec2( 550, 500 ), @(B4->AngularState), @(W2->AngularState) )
	
	CreateAngularJoint( @(W1->AngularState), @(W2->AngularState) )
	
	''
	W1->AngularState.angular_impulse = -2.0
	'W2->AngularState.angular_impulse = -1.0
	
End Sub

Sub GameType.Puzzle7()
	
	'' 
	
	iterations = 5
	warmstart  = 1
	
	PuzzleText = "Demo 7: "
	
	ClearAllArrays()
	
	Dim As RoxelType Ptr PP1 = CreateRoxel( Vec2( 200, 200 ), 10.0, 10.0 )
	Dim As RoxelType Ptr PP2 = CreateRoxel( Vec2( 800, 600 ), 10.0, 10.0 )
	
	'PP1->AddImpulse( Vec2( -100.0, 0.0 ) )
	
	CreateRope( PP1, PP2, 64 )
	
End Sub

Sub GameType.Puzzle8()
	
	'' 
	
	iterations = 5
	warmstart  = 0
	
	PuzzleText = "Demo 8:"
	
	ClearAllArrays()
	
	'' create particles
	Dim As RoxelType Ptr RP1 = CreateRoxel( Vec2( 0.25 * screen_wid, 0.25 * screen_hgt ), 1.0 + Rnd() * 32.0, 0.0 )
	Dim As RoxelType Ptr RP2 = CreateRoxel( Vec2( 0.75 * screen_wid, 0.25 * screen_hgt ), 1.0 + Rnd() * 32.0, 0.0 )
	Dim As RoxelType Ptr RP3 = CreateRoxel( Vec2( 0.25 * screen_wid, 0.75 * screen_hgt ), 1.0 + Rnd() * 32.0, 0.0 )
	Dim As RoxelType Ptr RP4 = CreateRoxel( Vec2( 0.75 * screen_wid, 0.75 * screen_hgt ), 1.0 + Rnd() * 32.0, 0.0 )
	
	RP1->colour = RGB( 255, 64, 64 )
	RP2->colour = RGB( 64, 255, 64 )
	RP3->colour = RGB( 64, 64, 255 )
	RP4->colour = RGB( 255, 255, 64 )
	
	'' create springs
	Dim As LinearSpringType Ptr LL1 = CreateLinearSpring( 0.0, 0.0, 0.0, RP1, RP2, @LinearSprings )
	Dim As LinearSpringType Ptr LL2 = CreateLinearSpring( 0.0, 0.0, 0.0, RP2, RP3, @LinearSprings )
	Dim As LinearSpringType Ptr LL3 = CreateLinearSpring( 0.0, 0.0, 0.0, RP3, RP4, @LinearSprings )
	'Dim As LinearSpringType Ptr LL3 = CreateLinearSpring( 0.01, 0.01, 0.01, @(LL1->LinearLink), @(LL2->LinearLink), @LinearSprings )
	'Dim As LinearSpringType Ptr LL4 = CreateLinearSpring( 0.0, cDamping, cWarmstart, RP1, @(LL3->LinearLink), @LinearSprings )
	
	'Dim As AngularSpringType Ptr AS1 = CreateAngularSpring( 0.0, 0.0, 0.0, @(LL1->LinearLink), @(LL2->LinearLink), @AngularSprings )
	'Dim As AngularSpringType Ptr AS2 = CreateAngularSpring( 0.0, 0.0, 0.0, @(LL2->LinearLink), @(LL3->LinearLink), @AngularSprings )
	
	
	'RP1->Impulse += Vec2(  100.0, 0.0 )
	'RP3->Impulse += Vec2( -100.0, 0.0 )
	'
	'RP2->AddImpulse( Vec2( -200.0, 0.0 ) )
	'RP4->AddImpulse( Vec2(  200.0, 0.0 ) )
	
	'LL1->LinearLink.AddImpulse( Vec2( 0.0,  100.0 ) )
	'LL2->LinearLink.AddImpulse( Vec2( 0.0, -100.0 ) )
	'LL3->LinearLink.AddImpulse( Vec2( 0.0, -10.0 ) )
	
End Sub

Sub GameType.Puzzle9()
	
	iterations = 5
	warmstart  = 1
	
	PuzzleText = "Demo 9:"
	
	ClearAllArrays()
	
End Sub

Sub GameType.Puzzle0()
	
	iterations = 5
	warmstart  = 1
	
	PuzzleText = "Demo 0:"
	
	ClearAllArrays()
	
End Sub

