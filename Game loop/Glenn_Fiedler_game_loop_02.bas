''
'' Glenn Fiedler game loop tutorial
'' Code sample # 2
'' http://gafferongames.com/game-physics/fix-your-timestep/
'' Variable delta time

'double t = 0.0;
'
'double currentTime = hires_time_in_seconds();
'
'while ( !quit )
'{
'    double newTime = hires_time_in_seconds();
'    double frameTime = newTime - currentTime;
'    currentTime = newTime;
'
'    integrate( state, t, frameTime );
'    t += frameTime;
'
'    render( state );
'}

Dim As Double t = 0.0

Dim As Double currentTime = Timer()

Dim As Boolean quit = FALSE

While( Not quit )
	
	Dim As Double newTime = Timer()
	Dim As Double frameTime = newTime - currentTime
	
	currentTime = newTime
	
	''integrate( state, t, frameTime )
	
	t += frameTime
	
	''render( state )
	
	Locate 2, 2: Print" currentTime: " & currentTime
	Locate 4, 2: Print" newTime: " & newTime
	Locate 6, 2: Print" frameTime: " & frameTime
	
	If MultiKey(1) Then quit = TRUE
		
Wend