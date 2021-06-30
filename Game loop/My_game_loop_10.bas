''
''
''
#Include "fbgfx.bi"

Using fb

''
Const As Double c_sleep         = 0.2                   '' sleep correction coefficient [0.0 - 1.0]
Const As Double max_sleep_s     = 1.0                   '' max. sleep time ( seconds )
Const As Double min_sleep_s     = 0.001                 '' min. sleep time ( seconds )
Const As Double rest_velocity   = 60.0                  '' desired frame rate ( loops / second )
Const As Double rest_delta_time     = 1.0 / rest_velocity '' desired loop time ( seconds / loop )

Dim As Double acceleration  = 0.0 '' delta frame rate ( loops / second^2 )
Dim As Double velocity      = 0.0 '' actual frame rate ( loops / second )
Dim As Double last_velocity = 0.0 '' actual frame rate ( loops / second )
Dim As Double delta_time_error  = 0.0 '' loop error time ( seconds )
Dim As Double last_loop_s   = 0.0 '' last loop time ( seconds )
Dim As Double this_loop_s   = 0.0 '' current time ( seconds )
Dim As Double delta_time    = 0.0 '' time it takes to do one loop ( seconds )
Dim As Double sleep_s       = 0.0 '' sleep time ( seconds )

Dim As Integer sleep_ms = 0 '' sleep time ( milliseconds )

Dim As Boolean game_is_running = TRUE  '' 
Dim As Boolean game_is_working = FALSE '' 

ScreenRes( 800, 600, 32 )

While( game_is_running )
	
	'' input
	game_is_running = IIf( MultiKey( fb.SC_ESCAPE ), FALSE, TRUE  )
	game_is_working = IIf( MultiKey( fb.SC_SPACE ) , TRUE , FALSE )
	
	'' loop time ( seconds )
	last_loop_s = this_loop_s
	this_loop_s = Timer()
	delta_time = this_loop_s - last_loop_s
	
	'' loops per second ( framerate )
	last_velocity = velocity
	velocity = 1.0 / delta_time
	
	acceleration = ( velocity - last_velocity ) / delta_time
	
	'' loop time error ( seconds )
	delta_time_error = delta_time - rest_delta_time
	
	'' adjust sleep time ( seconds )
	sleep_s -= delta_time_error * c_sleep
	
	'' clamp sleep time ( seconds )
	If( sleep_s > max_sleep_s ) Then sleep_s = max_sleep_s
	If( sleep_s < min_sleep_s ) Then sleep_s = min_sleep_s
	
	'' sleep time ( integer milliseconds )
	sleep_ms = Cast( Integer, sleep_s * 1000 )
	
	'' sleep
	Sleep( sleep_ms, 1 )
	
	'' write data to screen
	ScreenLock
		
		Cls
		
		Locate  2, 2: Print " delta_time      " & delta_time
		Locate  4, 2: Print " rest_delta_time     " & rest_delta_time
		Locate  6, 2: Print " delta_time_error    " & delta_time_error
		Locate  8, 2: Print " sleep_s         " & sleep_s
		Locate 10, 2: Print " sleep_ms        " & sleep_ms
		Locate 12, 2: Print " velocity        " & velocity
		Locate 14, 2: Print " acceleration    " & acceleration
		Locate 16, 2: Print " rest_velocity   " & rest_velocity
		Locate 18, 2: Print " game_is_working " & game_is_working
		
	ScreenUnLock
	
	'' do some cpu-heavy work to test sleep time correction
	If( game_is_working ) Then
		
		For i As Integer = 1 To 50000
			
			Dim As Single temp = Log( Sqr(i) )
			
		Next
		
	EndIf 
	
Wend
