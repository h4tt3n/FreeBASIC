''
'' Glenn Fiedler game loop tutorial
'' Code sample # 1
'' http://gafferongames.com/game-physics/fix-your-timestep/
'' The final touch

'double t = 0.0;
'double dt = 0.01;
'
'double currentTime = hires_time_in_seconds();
'double accumulator = 0.0;
'
'State previous;
'State current;
'
'while ( !quit )
'{
'    double newTime = time();
'    double frameTime = newTime - currentTime;
'    if ( frameTime > 0.25 )
'        frameTime = 0.25;
'    currentTime = newTime;
'
'    accumulator += frameTime;
'
'    while ( accumulator >= dt )
'    {
'        previousState = currentState;
'        integrate( currentState, t, dt );
'        t += dt;
'        accumulator -= dt;
'    }
'
'    const double alpha = accumulator / dt;
'
'    State state = currentState * alpha + 
'        previousState * ( 1.0 - alpha );
'
'    render( state );
'}

Dim As Double t = 0.0
Dim As Double dt = 1.0 / 60.0'0.01

Dim As Double currentTime = Timer()
Dim As Double accumulator = 0.0

Dim As Boolean quit = FALSE

While( Not quit )
	
	Dim As Double newTime = Timer()
	Dim As Double frameTime = newTime - currentTime
	
	If ( frameTime > 0.25 ) Then frameTime = 0.25
	
	currentTime = newTime
	
	accumulator += frameTime
	
	While( accumulator >= dt )
		
		''previousState = currentState
		''integrate( currentState, t, dt )
		t += dt
		accumulator -= dt
		
	Wend
	
	Dim As Double alpha_ = accumulator / dt
	
'	State state = currentState * alpha + 
'        previousState * ( 1.0 - alpha )
	
	''render( state )
	
	Locate 2, 2: Print" currentTime: " & currentTime
	Locate 4, 2: Print" newTime: " & newTime
	Locate 6, 2: Print" frameTime: " & frameTime
	Locate 8, 2: Print" accumulator: " & accumulator
	
	If MultiKey(1) Then quit = TRUE
		
Wend