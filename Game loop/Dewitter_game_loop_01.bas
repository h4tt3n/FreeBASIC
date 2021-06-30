''
'' DeWitter game loop tutorial
'' Code sample # 1
'' http://www.koonsolo.com/news/dewitters-gameloop/
''


 'Const int FRAMES_PER_SECOND = 25;
 'const int SKIP_TICKS = 1000 / FRAMES_PER_SECOND;

 'DWORD next_game_tick = GetTickCount();
 '// GetTickCount() returns the current number of milliseconds
 '// that have elapsed since the system was started

 'int sleep_time = 0;

 'bool game_is_running = true;

 'while( game_is_running ) {
 '    update_game();
 '    display_game();

 '    next_game_tick += SKIP_TICKS;
 '    sleep_time = next_game_tick - GetTickCount();
 '    if( sleep_time >= 0 ) {
 '        Sleep( sleep_time );
 '    }
 '    else {
 '        // Shit, we are running behind!
 '    }
 '}

Function GetTickCount() As Double
	
	Return Timer * 1000
	
End Function

Const As Integer FRAMES_PER_SECOND = 60
Const As Integer SKIP_TICS = 1000 / FRAMES_PER_SECOND

Dim As Double next_game_tick = GetTickCount()

Dim As Integer sleep_time = 0

Dim As boolean game_is_running = TRUE

While( game_is_running )
	
	'' update game here
	'' display game here
	
	next_game_tick += SKIP_TICS
	
	sleep_time = next_game_tick - GetTickCount()
	
	If ( sleep_time >= 0 ) Then
		
		Sleep sleep_time, 1
		
	Else
		
		'' Shit, we are running behind!
		
	EndIf
	
	Locate 2, 2: Print "next_game_tick: " & next_game_tick
	Locate 4, 2: Print "sleep_time: " & sleep_time
	Locate 6, 2: Print "SKIP_TICS: " & SKIP_TICS
	Locate 8, 2: Print "Timer: " & GetTickCount()
	
	If MultiKey(1) Then game_is_running = FALSE
	
Wend
