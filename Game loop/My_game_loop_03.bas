''
''
''

Dim As Double reference_time = Timer()
Dim As Double seconds_passed = 0.0
Dim As Double loops_per_second = 0.0
Dim As Double rest_loops_per_second = 10.0
Dim As Double rest_loop_time = 1.0 / rest_loops_per_second
Dim As Double loop_error = 0.0
Dim As Double loop_time_error = 0.0
Dim As Double last_loop_time = 0.0
Dim As Double this_loop_time = 0.0
Dim As Double loop_time = 0.0
Dim As Double sleep_time = 0.0
Dim As Double t = 0.0

Dim As Integer loops = 0

Dim As Boolean game_is_running = TRUE

ScreenRes( 800, 600, 32 )

last_loop_time = Timer()

While( game_is_running )
	
	loops += 1
	
	last_loop_time = this_loop_time
	
	this_loop_time = Timer() '- reference_time
	
	loop_time = this_loop_time - last_loop_time '' s
	
	loop_time_error = rest_loop_time - loop_time '' s
	
	't += loop_time
	'
	'seconds_passed = Timer() - reference_time
	'
	'loops_per_second = loops / seconds_passed
	'
	loops_per_second = 1.0 / loop_time '' l/s
	'
	loop_error = loops_per_second - rest_loops_per_second '' l/s
	
	sleep_time += loop_time_error * loops_per_second '* 10
	
	If Sleep_time >  100 Then Sleep_time = 100
	If Sleep_time <    1 Then Sleep_time =   1
	
	Sleep Sleep_time, 1
	
	ScreenLock
		
		Cls
	
		Locate  2, 2: Print " Loop_time " & loop_time
		Locate  4, 2: Print " loop_time_error " & loop_time_error
		Locate  6, 2: Print " sleep_time " & sleep_time
		Locate  8, 2: Print " loops_per_second " & loops_per_second
	
	ScreenUnLock
	
	game_is_running = IIf( MultiKey(1) , FALSE , TRUE )
	
Wend
