''
'' Glenn Fiedler game loop tutorial
'' Code sample # 1
'' http://gafferongames.com/game-physics/fix-your-timestep/
'' Free the physics

'double t = 0.0;
'const double dt = 0.01;
'
'double currentTime = hires_time_in_seconds();
'double accumulator = 0.0;
'
'while ( !quit )
'{
'    double newTime = hires_time_in_seconds();
'    double frameTime = newTime - currentTime;
'    currentTime = newTime;
'
'    accumulator += frameTime;
'
'    while ( accumulator >= dt )
'    {
'        integrate( state, t, dt );
'        accumulator -= dt;
'        t += dt;
'    }
'
'    render( state );
'}


Dim As Double t = 0.0
Dim As Double dt = 0.01

Dim As Double currentTime = Timer()
Dim As Double accumulator = 0.0

Dim As Boolean quit = FALSE

While( Not quit )
	
	Dim As Double newTime = Timer()
	Dim As Double frameTime = newTime - currentTime
	
	currentTime = newTime
	
	accumulator += frameTime
	
	While( accumulator >= dt )
		
		''integrate( state, t, dt )
		accumulator -= dt
		t += dt
		
	Wend
	
	''render( state )
	
	Locate 2, 2: Print" currentTime: " & currentTime
	Locate 4, 2: Print" newTime: " & newTime
	Locate 6, 2: Print" frameTime: " & frameTime
	Locate 8, 2: Print" accumulator: " & accumulator
	
	If MultiKey(1) Then quit = TRUE
		
Wend