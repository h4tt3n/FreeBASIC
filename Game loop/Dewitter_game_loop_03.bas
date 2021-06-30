''
'' DeWitter game loop tutorial
'' Code sample # 3
'' http://www.koonsolo.com/news/dewitters-gameloop/
''


 'const int TICKS_PER_SECOND = 50;
 'const int SKIP_TICKS = 1000 / TICKS_PER_SECOND;
 'const int MAX_FRAMESKIP = 10;

 'DWORD next_game_tick = GetTickCount();
 'int loops;

 'bool game_is_running = true;
 'while( game_is_running ) {

 '    loops = 0;
 '    while( GetTickCount() > next_game_tick && loops < MAX_FRAMESKIP) {
 '        update_game();

 '        next_game_tick += SKIP_TICKS;
 '        loops++;
 '    }

 '    display_game();
 '}

Function GetTickCount() As Double
	
	Return Timer * 1000
	
End Function

Const As Integer TICKS_PER_SECOND = 50
Const As Integer SKIP_TICKS = 1000 / TICKS_PER_SECOND
Const As Integer MAX_FRAMESKIP = 10

Dim As Double next_game_tick = GetTickCount()

Dim As Integer loops = 0

Dim As boolean game_is_running = TRUE

While( game_is_running )
	
	loops = 0
	
	While( ( GetTickCount() > next_game_tick ) And ( loops < MAX_FRAMESKIP ) )
		
		'' update game here
		'Sleep 1, 1
		
		next_game_tick += SKIP_TICKS
		
		loops += 1
		
	Wend
	
	'' display game here
	
	Locate 2, 2: Print "next_game_tick: " & next_game_tick
	Locate 4, 2: Print "loops: " & loops
	Locate 6, 2: Print "MAX_FRAMESKIP: " & MAX_FRAMESKIP
	Locate 8, 2: Print "Timer: " & GetTickCount()
	
	If MultiKey(1) Then game_is_running = FALSE
	
Wend
