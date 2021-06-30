''
'' Glenn Fiedler game loop tutorial
'' Code sample # 1
'' http://gafferongames.com/game-physics/fix-your-timestep/
'' Fixed delta time

'double t = 0.0;
'double dt = 1.0 / 60.0;
'
'while ( !quit )
'{
'    integrate( state, t, dt );
'    render( state );
'    t += dt;
'}

Dim As Double t = 0.0
Dim As Double dt = 1.0 / 60.0

Dim As Boolean quit = FALSE

While( Not quit )
	
	''integrate( state, t, dt )
	''render( state )
	Print "t:" & t
	
	t += dt
	
	If MultiKey(1) Then quit = TRUE
		
Wend
