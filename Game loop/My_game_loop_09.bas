''
''
''
#Include "fbgfx.bi"

Using fb

''
Const As Double c_sleep         = 0.5                   '' sleep correction coefficient [0.0 - 1.0]
Const As Double max_sleep_s     = 0.2                   '' max. sleep time ( seconds )
Const As Double min_sleep_s     = 0.0                 '' min. sleep time ( seconds )
Const As Double rest_frame_rate = 60.0                  '' desired frame rate ( loops / second )
Const As Double rest_loop_s     = 1.0 / rest_frame_rate '' desired loop time ( seconds / loop )

Dim As Double frame_rate   = 0.0 '' actual frame rate ( loops / second )
Dim As Double loop_error_s = 0.0 '' loop error time ( seconds )
Dim As Double last_loop_s  = 0.0 '' last loop time ( seconds )
Dim As Double this_loop_s  = 0.0 '' current time ( seconds )
Dim As Double loop_time_s  = 0.0 '' time it takes to do one loop ( seconds )
Dim As Double sleep_s      = 0.0 '' sleep time ( seconds )
Dim As Double run_time_s   = 0.0 '' 
Dim As Double start_time   = 0.0 '' 

Dim As Integer num_loops = 0 ''
Dim As Integer sleep_ms = 0 '' sleep time ( milliseconds )
Dim As Single  sleep_ms_sum = 0 '' 

Dim As Boolean game_is_running = TRUE  '' 
Dim As Boolean game_is_working = FALSE '' 

ScreenRes( 800, 600, 32, 2 )

ScreenSet( 1, 0 )

start_time = Timer()

While( game_is_running )
	
	'' input
	game_is_running = IIf( MultiKey( fb.SC_ESCAPE ), FALSE, TRUE  )
	game_is_working = IIf( MultiKey( fb.SC_SPACE ) , TRUE , FALSE )
	
	num_loops += 1
	run_time_s = Timer() - start_time
	
	'' loop time ( seconds )
	last_loop_s = this_loop_s
	this_loop_s = Timer()
	loop_time_s = this_loop_s - last_loop_s
	
	'' loops per second ( framerate )
	'' (we know there has been exactly one loop since last time -
	'' -thus the hard-coded 1)
	frame_rate = 1.0 / loop_time_s
	
	'' loop time error ( seconds )
	loop_error_s = loop_time_s - rest_loop_s
	
	'' adjust sleep time ( seconds )
	sleep_s -= loop_error_s * c_sleep
	
	'' clamp sleep time ( seconds )
	If( sleep_s > max_sleep_s ) Then sleep_s = max_sleep_s
	If( sleep_s < min_sleep_s ) Then sleep_s = min_sleep_s
	
	'' sleep time ( integer milliseconds )
	sleep_ms = Cast( Integer, sleep_s * 1000 )
	
	sleep_ms_sum += sleep_ms
	
	'' sleep
	Sleep( sleep_ms, 1 )
	
	'' write data to screen
	Cls
	
	Locate  2, 2: Print " loop_time_s     " & loop_time_s
	Locate  4, 2: Print " rest_loop_s     " & rest_loop_s
	Locate  6, 2: Print " loop_error_s    " & loop_error_s
	Locate  8, 2: Print " sleep_s         " & sleep_s
	Locate 10, 2: Print " sleep_ms        " & sleep_ms
	Locate 12, 2: Print " sleep_ms_avg    " & sleep_ms_sum / num_loops
	Locate 14, 2: Print " frame_rate      " & frame_rate
	Locate 16, 2: Print " frame_rate_avg  " & num_loops / run_time_s
	Locate 18, 2: Print " rest_frame_rate " & rest_frame_rate
	Locate 20, 2: Print " game_is_working " & game_is_working
	
	ScreenCopy()
	
	'' do some cpu-heavy work to test sleep time correction
	If( game_is_working ) Then
		
		For i As Integer = 1 To 100000
			
			Dim As Single temp = Log( Sqr( i ) )
			
		Next
		
	EndIf 
	
Wend
