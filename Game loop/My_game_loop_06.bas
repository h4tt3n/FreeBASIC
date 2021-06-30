''
''
''
#Include "fbgfx.bi"

Using fb

Const As Double sleep_time_coefficient = 0.25
Const As Double max_sleep_time = 128
Const As Double min_sleep_time = 1
Const As Double rest_loops_per_second = 60.0

Dim As Double frame_rate_timer
Dim As Integer num_frames
Dim As Integer frame_rate

Dim As Double loops_per_second = 0.0

Dim As Double rest_loop_time = 1.0 / rest_loops_per_second
Dim As Double loop_time_error = 0.0
Dim As Double last_loop_time = 0.0
Dim As Double this_loop_time = 0.0
Dim As Double loop_time = 0.0
Dim As Double sleep_time = 16.0

Dim As Boolean game_is_running = TRUE
Dim As Boolean game_is_working = FALSE

ScreenRes( 800, 600, 32 )

last_loop_time = Timer()
frame_rate_Timer = Timer()

While( game_is_running )
	
	game_is_running = IIf( MultiKey( fb.SC_ESCAPE ) , FALSE , TRUE )
	game_is_working = IIf( MultiKey( fb.SC_SPACE ) , TRUE , FALSE )
	
	If( game_is_working ) THen
		
		For i As Integer = 1 To 100000
			
			Dim As Single temp = Log( Sqr(i) )
			
		Next
		
	EndIf 
	
	''	get framerate
	If ( Timer() < frame_rate_Timer ) Then
		
		num_frames += 1
		
	Else
		
		frame_rate        = num_frames
		num_frames        = 1
		frame_rate_Timer += 1.0
		
	End If
	
	last_loop_time = this_loop_time
	
	this_loop_time = Timer()
	
	loop_time = this_loop_time - last_loop_time
	
	loop_time_error = loop_time - rest_loop_time
	
	loops_per_second = 1.0 / loop_time
	
	sleep_time -= loop_time_error * 1000 * sleep_time_coefficient
	
	''
	If Sleep_time > max_sleep_time Then Sleep_time = max_sleep_time
	If Sleep_time < min_sleep_time Then Sleep_time = min_sleep_time
	
	Sleep Sleep_time, 1
	
	ScreenLock
		
		Cls
	
		Locate  2, 2: Print " Loop_time             " & loop_time
		Locate  4, 2: Print " rest_loop_time        " & rest_loop_time
		Locate  6, 2: Print " loop_time_error       " & loop_time_error
		Locate  8, 2: Print " sleep_time            " & sleep_time
		Locate 10, 2: Print " loops_per_second      " & loops_per_second
		Locate 12, 2: Print " rest_loops_per_second " & rest_loops_per_second
		Locate 14, 2: Print " frame_rate            " & frame_rate
		Locate 16, 2: Print " game_is_working       " & game_is_working
	
	ScreenUnLock
	
Wend
