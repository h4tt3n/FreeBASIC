''
'' Game loop test code # 1
''
'' Requirements:
'' -Must run physics at fixed timestep and framerate
'' -Must run graphics update at variable framerate
'' -Must free all surplus cpu time to system

Dim Shared As Double SleepTime = 0.0
Dim Shared As Double MinSleepTime = 1.0
Dim Shared As Double MaxSleepTime = 16.0
Dim Shared As Double NextLoopUpdate = 0.0
Dim Shared As Double GameLoopTimestep = 1 / 60

Dim Shared As Double FpsTimer = 0.0
Dim Shared As Integer FpsCounter = 0
Dim Shared As Integer Fps = 0


Function GetRunTime( ByVal _since      As Double = 0.0, _
	                  ByVal _resolution As Double = 1000.0 ) As Double
	
	Return ( Timer - _since ) * _resolution
	
End Function

sub PauseGame()
	
	SleepTime = NextLoopUpdate - GetRunTime()
	
	If SleepTime < MinSleepTime then SleepTime = MinSleepTime
	If SleepTime > MaxSleepTime then SleepTime = MaxSleepTime
	
	Sleep SleepTime
	
	NextLoopUpdate = GetRunTime() + GameLoopTimestep
	
end Sub

Dim As Double reference = Timer

Dim As Boolean game_is_running = TRUE

FpsTimer = GetRunTime( , 1.0)

''
While( game_is_running )
	
	'PauseGame()
	
	if GetRunTime( , 1.0) < FpsTimer then 
		
		FpsCounter += 1 
	
	else 
		
		Fps        = FpsCounter
		FpsCounter = 1
		FpsTimer  += 1
	
	end If
	
	Sleep 15, 1
	
	'Locate 2, 2: Print " run time in millisecs: " & GetRunTime( reference, 1000.0 )
	'Locate 4, 2: Print " run time in seconds: " & GetRunTime( reference, 1.0 )
	'Locate 6, 2: Print " Sleep Time in millisecs: " & SleepTime
	Locate 8, 2: Print " Fps: " & Fps
	
	game_is_running = IIf( MultiKey(1) , FALSE , TRUE )
	
Wend





	
