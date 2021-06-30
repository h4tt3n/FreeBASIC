''
''
''
#Include "fbgfx.bi"

Using fb

''
Const As Double c_sleep_ms   = 0.25               ''
Const As Double max_sleep_ms = 0.128              ''
Const As Double min_sleep_ms = 0.001              ''
Const As Double rest_loops_s = 60.0               ''
Const As Double rest_loop_ms = 1.0 / rest_loops_s ''

Dim As Double frame_rate_timer
Dim As Integer num_frames
Dim As Integer frame_rate

Dim As Double loops_s       = 0.0
Dim As Double loop_error_ms = 0.0
Dim As Double last_loop_ms  = 0.0
Dim As Double this_loop_ms  = 0.0
Dim As Double loop_time_ms  = 0.0
Dim As Double sleep_time_ms = 0.0

Dim As Integer sleep_time_s = 0

Dim As Boolean game_is_running = TRUE
Dim As Boolean game_is_working = FALSE

ScreenRes( 800, 600, 32 )

last_loop_ms = Timer()
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
	
	last_loop_ms = this_loop_ms
	
	this_loop_ms = Timer()
	
	loop_time_ms = this_loop_ms - last_loop_ms
	
	loop_error_ms = loop_time_ms - rest_loop_ms
	
	loops_s = 1.0 / loop_time_ms
	
	sleep_time_ms -= loop_error_ms  * c_sleep_ms
	
	''
	If sleep_time_ms > max_sleep_ms Then sleep_time_ms = max_sleep_ms
	If sleep_time_ms < min_sleep_ms Then sleep_time_ms = min_sleep_ms
	
	''
	sleep_time_s = Cast( Integer, sleep_time_ms * 1000 )
	
	''
	Sleep sleep_time_s, 1
	
	ScreenLock
		
		Cls
	
		Locate  2, 2: Print " Loop_time       " & loop_time_ms
		Locate  4, 2: Print " rest_loop_ms  " & rest_loop_ms
		Locate  6, 2: Print " loop_error_ms " & loop_error_ms
		Locate  8, 2: Print " sleep_time_ms   " & sleep_time_ms
		Locate 10, 2: Print " loops_s         " & loops_s
		Locate 12, 2: Print " rest_loops_s    " & rest_loops_s
		Locate 14, 2: Print " frame_rate      " & frame_rate
		Locate 16, 2: Print " game_is_working " & game_is_working
	
	ScreenUnLock
	
Wend
