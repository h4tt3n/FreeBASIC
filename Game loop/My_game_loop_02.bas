''
'' Game loop test code # 2
''
'' Requirements:
'' -Must run physics at fixed timestep and framerate
'' -Must run graphics update at variable framerate
'' -Must free all surplus cpu time to system

Dim As Double rest_loop_time  = 1.0 / 60.0
Dim As Double loop_time       = 0.0
Dim As Double loop_time_error = 0.0
Dim As Double last_loop       = 0.0
Dim As Double this_loop       = 0.0
Dim As Double sleep_time      = 1.0
Dim As Double rest_sleep_time  = 0.0
Dim As Double sleep_time_error = 0.0

Dim As Double FpsTimer = 0.0
Dim As Integer FpsCounter = 0
Dim As Integer Fps = 0


Dim As Double t = 0.0

Dim As Double reference = Timer()

Dim As Boolean game_is_running = TRUE

FpsTimer = Timer()

ScreenRes( 800, 600, 32 )

''
While( game_is_running )
	
	
	'For i As Integer = 1 To 10000
	'	
	'	Dim As Single temp = Log( Sqr(i) )
	'	
	'Next
	
	last_loop = this_loop
	
	this_loop = Timer()
	
	loop_time = this_loop - last_loop
	
	loop_time_error = loop_time - rest_loop_time
	
	rest_sleep_time = loop_time_error * 1000
	
	sleep_time_Error = sleep_time - rest_sleep_time 
	
	sleep_time -= sleep_time_Error * 0.1
	'sleep_time = loop_time_error * 1000
	
	'Sleep_time -= 2
	
	If Sleep_time >  100 Then Sleep_time = 100
	If Sleep_time <     1 Then Sleep_time =    1
	
	'Sleep 16, 1
	Sleep Sleep_time, 1
	
	if Timer() < FpsTimer then 
		FpsCounter += 1 
	else 
		Fps        = FpsCounter
		FpsCounter = 1
		FpsTimer   += 1.0
	end If
	
	t += rest_loop_time
	
	ScreenLock
		
		Cls
		
		'Locate 2, 2: Print " loop_time: " & 1 / loop_time
		'Locate 4, 2: Print " loop_time_error: " & loop_time_error
		Locate 6, 2: Print " sleep_time : " & Sleep_time 
		Locate 8, 2: Print " fps : " & fps 
		'Locate 10, 2: Print " time : " & t
		'Locate 12, 2: Print " timer : " & Timer() - reference
	
	ScreenUnLock
	
	game_is_running = IIf( MultiKey(1) , FALSE , TRUE )
	
Wend





	
