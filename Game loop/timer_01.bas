''
''
''
#Include "fbgfx.bi"

Using fb

Type ioTimer
	
	Public:
	
	''
	Declare Constructor()
	
	Declare Constructor( ByVal _frame_rate As Double, _
	                     ByVal _min_sleep  As Double, _
	                     ByVal _max_sleep  As Double, _ 
	                     ByVal _c_sleep    As Double )
	
	''
	Declare Destructor()
	
	''
	Declare Sub PauseLoop()
	
	Private:
	
	As Double c_sleep         '' sleep correction coefficient [0.0 - 1.0]
	As Double max_sleep_s     '' max. sleep time ( seconds )
	As Double min_sleep_s     '' min. sleep time ( seconds )
	As Double rest_frame_rate '' desired frame rate ( loops / second )
	As Double rest_loop_s     '' desired loop time ( seconds / loop )
	
	As Double frame_rate      '' actual frame rate ( loops / second )
	As Double loop_error_s    '' loop error time ( seconds )
	As Double last_loop_s     '' last loop time ( seconds )
	As Double this_loop_s     '' current time ( seconds )
	As Double loop_time_s     '' time it takes to do one loop ( seconds )
	As Double sleep_s         '' sleep time ( seconds )
	
	As Integer sleep_ms       '' sleep time ( milliseconds )
	
End Type

Constructor ioTimer()
	
End Constructor

Constructor ioTimer( ByVal _frame_rate As Double, _
	                  ByVal _min_sleep  As Double, _
	                  ByVal _max_sleep  As Double, _ 
	                  ByVal _c_sleep    As Double )
	
	rest_frame_rate = _frame_rate
	min_sleep_s     = _min_sleep
	max_sleep_s     = _max_sleep
	c_sleep         = _c_sleep
	
	rest_loop_s     = 1.0 / rest_frame_rate
	
End Constructor                 

Destructor ioTimer()
	
End Destructor
	
Sub ioTimer.PauseLoop()
	
	'' loop time ( seconds )
	last_loop_s = this_loop_s
	this_loop_s = Timer()
	loop_time_s = this_loop_s - last_loop_s
	
	'' loops per second ( framerate )
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
	
	'' sleep
	Sleep( sleep_ms, 1 )
	
End Sub


''
Dim As Boolean game_is_running = TRUE  '' 
Dim As Boolean game_is_working = FALSE '' 

Dim As ioTimer t

ScreenRes( 800, 600, 32 )

While( game_is_running )
	
	'' input
	game_is_running = IIf( MultiKey( fb.SC_ESCAPE ), FALSE, TRUE  )
	game_is_working = IIf( MultiKey( fb.SC_SPACE ) , TRUE , FALSE )
	
	
	'' write data to screen
	ScreenLock
		
		Cls
		
		Locate  2, 2: Print " loop_time_s     " & loop_time_s
		Locate  4, 2: Print " rest_loop_s     " & rest_loop_s
		Locate  6, 2: Print " loop_error_s    " & loop_error_s
		Locate  8, 2: Print " sleep_s         " & sleep_s
		Locate 10, 2: Print " sleep_ms        " & sleep_ms
		Locate 12, 2: Print " frame_rate      " & frame_rate
		Locate 14, 2: Print " rest_frame_rate " & rest_frame_rate
		Locate 16, 2: Print " game_is_working " & game_is_working
		
	ScreenUnLock
	
	'' do some cpu-heavy work to test sleep time correction
	If( game_is_working ) Then
		
		For i As Integer = 1 To 100000
			
			Dim As Single temp = Log( Sqr(i) )
			
		Next
		
	EndIf 
	
Wend
