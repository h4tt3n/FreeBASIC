''
''
''


ScreenRes( 800, 600, 32 )

Dim As Double frame_rate_timer
Dim As Double sleep_time
Dim As Double timestep   = 1 / 60
Dim As Double t0

Dim As Integer frame_rate_counter
Dim As Integer frame_rate

Dim As Boolean game_is_running = TRUE

frame_rate_Timer = TImer



While( game_is_running )
	
	t0 = Timer
	
	''	get framerate
	If ( Timer < frame_rate_Timer ) Then
		
		frame_rate_Counter += 1
		
	Else
		
		frame_rate = frame_rate_Counter
		frame_rate_Counter = 1
		frame_rate_Timer += 1.0
		
	End If
	
	Sleep_Time = ( ( Timestep - ( Timer - t0 ) ) * 1000 - 2 )
	
	If Sleep_Time <    0 Then Sleep_Time =    0
	If Sleep_Time > 1000 Then Sleep_Time = 1000
	
	Sleep Sleep_Time, 1
	
	'Do: Loop While ( Timer - t0 ) < Timestep
	
	ScreenLock
		
		Cls
		
		Locate 2, 2: Print " frame_rate: " & frame_rate
		Locate 4, 2: Print " Sleep_Time: " & Sleep_Time
		
	ScreenUnLock
	
	game_is_running = IIf( MultiKey(1) , FALSE , TRUE )
	
Wend

