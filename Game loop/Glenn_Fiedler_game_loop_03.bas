''
'' Glenn Fiedler game loop tutorial
'' Code sample # 3
'' http://gafferongames.com/game-physics/fix-your-timestep/
'' Semi-fixed time step

'double t = 0.0;
'double dt = 1 / 60.0;
'
'double currentTime = hires_time_in_seconds();
'
'while ( !quit )
'{
'    double newTime = hires_time_in_seconds();
'    double frameTime = newTime - currentTime;
'    currentTime = newTime;
'          
'    while ( frameTime > 0.0 )
'    {
'        float deltaTime = min( frameTime, dt );
'        integrate( state, t, deltaTime );
'        frameTime -= deltaTime;
'        t += deltaTime;
'    }
'
'    render( state );
'}

Dim As Double t = 0.0
Dim As Double dt = 1.0 / 60.0
Dim As Double deltaTime = 0.0

Dim As Double currentTime = Timer()

Dim As Boolean quit = FALSE

While( Not quit )
	
	Dim As Double newTime = Timer()
	Dim As Double frameTime = newTime - currentTime
	
	currentTime = newTime
	
	While( frameTime > 0.0 )
		
		deltaTime = IIf( frameTime < dt , frameTime, dt )
		''integrate( state, t, deltaTime )
		frameTime -= deltaTime
		t += deltaTime
		
	Wend
	
	''render( state )
	
	Locate 2, 2: Print" currentTime: " & currentTime
	Locate 4, 2: Print" newTime: " & newTime
	Locate 6, 2: Print" frameTime: " & frameTime
	Locate 8, 2: Print" deltaTime: " & deltaTime
	
	If MultiKey(1) Then quit = TRUE
		
Wend
