''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 7, february 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''******************************************************************************* 

Type GameType
	
	''
	Declare Constructor()
	Declare Destructor()
	
	
	''
	Declare Sub CreateScreen( ByVal Wid As Integer, _
	                          ByVal Hgt As Integer )
	
	Declare Function CreateLinearState( ByVal _mass  As Single, _
	                                    ByVal _array As LinearStateArray Ptr  ) As LinearStateType Ptr
	
	Declare Function CreateLinearState( ByVal _position As Vec2, _
	                                    ByVal _mass     As Single, _
	                                    ByVal _array    As LinearStateArray Ptr ) As LinearStateType Ptr
	
	Declare Function CreateRoxel( ByVal _position As Vec2, _
	                              ByVal _mass     As Single, _
	                              ByVal _radius   As Single ) As RoxelType Ptr
	
	Declare Function CreateGravity( ByVal _linear1 As LinearStateType Ptr, _
	                                ByVal _linear2 As LinearStateType Ptr ) As GravityType Ptr
	
	Declare Function CreateOrbit( ByVal Position       As Vec2, _
	                              ByVal Eccentricity   As Single, _
	                              ByVal SemiMajorAxis  As Single, _
	                              ByVal Periapsis      As Single, _
	                              ByVal MeanAnomaly    As Single, _
	                              ByVal OrbitDirection As Single, _
	                              ByVal linear1 As LinearStateType Ptr, _
	                              ByVal linear2 As LinearStateType Ptr ) As OrbitType Ptr
	
	
	Declare Function CreateAngularSpring( ByVal _stiffness As Single, _
	                                      ByVal _damping   As Single, _
	                                      ByVal _warmstart As Single, _
	                                      ByVal _linear1   As LinearLinkType Ptr, _
	                                      ByVal _linear2   As LinearLinkType Ptr, _
	                                      ByVal _array     As AngularSpringArray Ptr ) As AngularSpringType Ptr
	
	Declare Function CreateFixedSpring( ByVal _stiffness As Single, _
	                                    ByVal _damping   As Single, _
	                                    ByVal _warmstart As Single, _
	                                    ByVal _linear1   As LinearStateType Ptr, _
	                                    ByVal _linear2   As LinearStateType Ptr, _
	                                    ByVal _array     As FixedSPringArray Ptr ) As FixedSpringType Ptr
	
	Declare Function CreateLinearSpring( ByVal _stiffness As Single, _
	                                     ByVal _damping   As Single, _
	                                     ByVal _warmstart As Single, _
	                                     ByVal _linear1   As LinearStateType Ptr, _
	                                     ByVal _linear2   As LinearStateType Ptr, _
	                                     ByVal _array     As LinearSpringArray Ptr ) As LinearSpringType Ptr
	
	''
	Declare sub drawEllipse( ByVal Position as Vec2, _
	                         ByVal SemiAxes As Vec2, _
	                         ByVal Angle    As Vec2, _
	                         ByVal Colour   As UInteger )
	
	Declare Sub drawOrbit( ByVal G As OrbitType Ptr )
	
	Declare Sub ClearImpulses()
	Declare Sub ClearWarmstart()
	Declare Sub UpdateInput()
	Declare Sub UpdateScreen()
	Declare Sub RunGame()
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	Declare Sub ComputeData()
	Declare Sub ComputeRestImpulse()
	Declare Sub ComputeNewState()
	Declare Sub DistributeImpulses()
	Declare Sub ClearAllArrays()
	
	''
	Declare Function FindClosestLinearLink() As LinearLinkType Ptr
	Declare Function FindClosestLinearState() As LinearStateType Ptr
	Declare Function FindClosestRoxel() As RoxelType Ptr
	
	Declare Function ClosestPointOnLinearLink( ByVal lp As LinearLinkType Ptr, ByVal p As Vec2 ) As Vec2
	
	
	''
	Declare Sub Puzzle1()
	Declare Sub Puzzle2()
	Declare Sub Puzzle3()
	Declare Sub Puzzle4()
	Declare Sub Puzzle5()
	Declare Sub Puzzle6()
	Declare Sub Puzzle7()
	Declare Sub Puzzle8()
	Declare Sub Puzzle9()
	Declare Sub Puzzle0()
	
	''
	As fb.EVENT e
	
	As String PuzzleText
	
	As Integer iterations
	As Integer warmstart
	
	As Vec2 position
	As Vec2 position_prev
	As Vec2 velocity
	
	As Integer button
	As Integer button_prev
	
	As UInteger Flags
	
	As LinearStateType Ptr picked
	As LinearStateType Ptr nearest
	
	''
	As LinearStateArray   linearstates
	As RoxelArray         roxels
	As GravityArray       gravitys
	As OrbitArray         orbits
	As AngularSpringArray angularsprings
	As LinearSpringArray  linearsprings
	
End Type


Constructor GameType()
	
	''
	LinearStates.Reserve( MAX_LINEAR_STATES )
	Gravitys.Reserve( MAX_GRAVITYS )
	Orbits.Reserve( MAX_ORBITS )
	Roxels.Reserve( MAX_ROXELS )
	AngularSprings.Reserve( MAX_ANGULAR_SPRINGS )
	LinearSprings.Reserve( MAX_LINEAR_SPRINGS )
	
	ClearAllArrays()
	
	Puzzle1()
	
	CreateScreen( screen_wid, screen_hgt )
	
	'ComputeData()
	
	RunGame()
	
End Constructor

Destructor GameType()
	
	LinearStates.Destroy()
	Roxels.Destroy()
	Gravitys.Destroy()
	Orbits.Destroy()
	AngularSprings.Destroy()
	LinearSprings.Destroy()
	
End Destructor

''
Sub GameType.DistributeImpulses()
	
	
End Sub


''	Main loop
Sub GameType.RunGame()
	
	Do
		
		''
		If ( Not Gravitys.Empty ) Then
			
			For G As GravityType Ptr = Gravitys.P_front To Gravitys.P_back
				
				G->ApplyImpulse
				
			Next
			
		EndIf
		
		''
		If( warmstart ) Then 
			
			ApplyWarmStart() 
			
		Else 
		
			ClearWarmStart()
		
		EndIf
		
		''
		ComputeRestImpulse()
		
		UpdateInput()
		
		''
		For i As Integer = 1 To iterations
			
			ApplyCorrectiveImpulse()
			DistributeImpulses()
			
		Next
		
		ComputeNewState()
		
		ComputeData()
		
		UpdateScreen()
		
		ClearImpulses()
		
		Sleep( 4, 1 )
		
	Loop

End Sub


'' Core physics functions
Sub GameType.ComputeData()
	
	'' Gravity
	If ( Not Gravitys.Empty ) Then 
		
		For G As GravityType Ptr = Gravitys.P_front To Gravitys.P_back
			
			G->ComputeData()
			
		Next
		
	EndIf
	
	''
	If ( Not Orbits.Empty ) Then 
		
		For O As OrbitType Ptr = Orbits.P_front To Orbits.P_back
			
			O->ComputeData()
			
		Next
		
	EndIf
	
	''	Linear springs
	If ( Not LinearSprings.Empty ) Then 
		
		For S As LinearSpringType Ptr = LinearSprings.P_front To LinearSprings.P_back
			
			S->ComputeData()
			
		Next
		
	EndIf
	
	''	Angular springs
	If ( Not AngularSprings.Empty ) Then 
		
		For A As AngularSpringType Ptr = AngularSprings.P_front To AngularSprings.P_back
			
			A->ComputeData()
			
		Next
		
	EndIf
		
End Sub

Sub GameType.ComputeRestImpulse()
	
	''	Linear springs
	If ( Not LinearSprings.Empty ) Then 
		
		For S As LinearSpringType Ptr = LinearSprings.P_front To LinearSprings.P_back
			
			S->ComputeRestImpulse()
			
		Next
		
	EndIf
	
	''	Angular springs
	If ( Not AngularSprings.Empty ) Then 
		
		For A As AngularSpringType Ptr = AngularSprings.P_front To AngularSprings.P_back
			
			A->ComputeRestImpulse()
			
		Next
		
	EndIf
	
End Sub

Sub GameType.ApplyCorrectiveimpulse()
	
	'' Linear springs
	If ( Not LinearSprings.Empty ) Then 
		
		For S As LinearSpringType Ptr = LinearSprings.P_front To LinearSprings.P_back Step 1
			
			S->ApplyCorrectiveImpulse()
			
		Next
		
		For S As LinearSpringType Ptr = LinearSprings.P_back To LinearSprings.P_front Step -1
			
			S->ApplyCorrectiveImpulse()
			
		Next
	
	EndIf
	
	'' Angular springs
	If ( Not AngularSprings.Empty ) Then 
		
		For A As AngularSpringType Ptr = AngularSprings.P_front To AngularSprings.P_back Step 1
			
			A->ApplyCorrectiveImpulse()
			
		Next
		
		For A As AngularSpringType Ptr = AngularSprings.P_back To AngularSprings.P_front Step -1
			
			A->ApplyCorrectiveImpulse()
			
		Next
	
	EndIf
	
End Sub

Sub GameType.ApplyWarmStart()
	
	'' Warm starting. Use the sum of previously applied impulses
	'' projected onto new normal vector as initial iteration value.
	''	This is roughly equivalent of doubling the number of iterations.
	
	'' Linear springs
	If ( Not LinearSprings.Empty ) Then 
		
		For S As LinearSpringType Ptr = LinearSprings.P_front To LinearSprings.P_back
			
			S->ApplyWarmStart()
			
		Next
	
	EndIf
	
	''	Angular springs
	If ( Not AngularSprings.Empty ) Then 
		
		For A As AngularSpringType Ptr = AngularSprings.P_front To AngularSprings.P_back
			
			A->ApplyWarmStart()
			
		Next
		
	EndIf
	
End Sub

Sub GameType.ComputeNewState()
	
	''	Compute new state vectors
	
	'' LinearStates
	If ( Not LinearStates.Empty ) Then 
		
		For L As LinearStateType Ptr = LinearStates.p_front To LinearStates.p_back
			
			L->ComputeNewState()
			
		Next
	
	EndIf
	
	'' Roxels
	If ( Not Roxels.Empty ) Then 
		
		For R As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			R->ComputeNewState()
			
		Next
	
	EndIf
	
End Sub

'' Graphics and interaction
Sub GameType.UpdateScreen()
		
	'Cls
	Line(0,0)-(screen_wid, screen_hgt), RGB( 60, 64, 68 ), BF
	
	''
	Locate  4, 2: Print PuzzleText
	Locate  8, 2: Print Using "(I)terations ###"; iterations
	
	''  draw particles background ( black)
	If ( Not Roxels.Empty  ) Then 
		
		For P As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			If ( P->radius > 0.0 ) Then
				
				'' draw impulse ( purple )
				'Dim As vec2 impulse = P->linear.position + ( P->linear.impulse + P->linear.velocity ) * DT
				'Line (P->linear.position.x, P->linear.position.y)-(impulse.x, impulse.y), RGBA( 0, 255, 0 , 128 )
				
				Circle(P->position.x, P->position.y), P->radius + 10, RGB(0, 0, 0) ,,, 1, f
				
			End If
			
		Next
		
	EndIf
	
	''  draw gravitys ( purple )
	If ( Not Gravitys.Empty ) Then 
		
		For G As GravityType Ptr = Gravitys.P_front To Gravitys.P_back
			
			'DrawOrbit( G )
			
			Line(G->LinearLink.a->position.x, G->LinearLink.a->position.y)-_
				 (G->LinearLink.b->position.x, G->LinearLink.b->position.y), RGB(255, 0, 255)
			
			
			'Dim As vec2 position = ( G->LinearLink.a->position * G->LinearLink.b->inv_mass + _
			'                         G->LinearLink.b->position * G->LinearLink.a->inv_mass ) * G->LinearLink.reduced_mass
			
			'Circle(position.x, position.y), 2, RGB(255, 0, 255),,, 1, f
			Circle(G->LinearLink.position.x, G->LinearLink.position.y), 2, RGB(255, 0, 255),,, 1, f
			
		Next
		
	EndIf
	
	''
	If ( Not Orbits.Empty ) Then 
		
		For O As OrbitType Ptr = Orbits.P_front To Orbits.P_back
			
			DrawOrbit( O )
			
			Circle(O->LinearLink.position.x, O->LinearLink.position.y), 2, RGB(0, 255, 0),,, 1, f
			
		Next
		
	EndIf
	
	
	''  draw springs ( grey )
	If ( Not LinearSprings.Empty ) Then 
		
		For S As LinearSpringType Ptr = LinearSprings.P_front To LinearSprings.P_back
			
			Line(S->LinearLink.a->position.x, S->LinearLink.a->position.y)-_
				 (S->LinearLink.b->position.x, S->LinearLink.b->position.y), RGB(192, 192, 192)
			
			Circle(S->LinearLink.position.x, S->LinearLink.position.y), 2, RGB( 160, 160, 160 ),,, 1, f
			
		Next
		
	EndIf
	
	
	''	draw Roxels foreground
	If ( Not Roxels.Empty ) Then 
		
		For P As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			If ( P->radius > 0.0 ) Then
				
				'Dim As UInteger Col = IIf( P->inv_mass = 0.0, RGB(160, 160, 160), RGB(255, 0, 0) )
				
				Circle(P->position.x, P->position.y), P->radius, P->Colour,,, 1, f
				
			Else
				
				'Dim As UInteger Col = IIf( P->inv_mass = 0.0, RGB(160, 160, 160), RGB(160, 160, 160) )
				
				Circle(P->position.x, P->position.y), 2, P->Colour,,, 1, f
				
			End If
			
		Next
		
	EndIf
	
	
	'' draw linearstates
	If ( Not LinearStates.Empty ) Then 
		
		For P As LinearStateType Ptr = LinearStates.p_front To LinearStates.p_back
			
			Circle(P->position.x, P->position.y), 2, RGB( 128, 128, 128 ),,, 1, f
			
		Next
		
	EndIf
	
	If ( Nearest <> 0 ) Then Circle(Nearest->position.x, Nearest->position.y), 32, RGB(255, 255, 255),,, 1
	If ( Picked <> 0 ) Then Circle(Picked->position.x, Picked->position.y), 32, RGB(255, 255, 0),,, 1
	
	ScreenCopy()
	
End Sub

Sub GameType.CreateScreen( ByVal Wid As Integer, ByVal Hgt As Integer )
   
	Dim As Integer top = hgt
	Dim As Integer lft = 0
	Dim As Integer btm = 0
	Dim As Integer rgt = wid
   
   ScreenRes( Wid, Hgt, 16, 2 )
   
   '' Cartesian ( 0,0 ) = bottom left
   'Window ( lft, top )-( rgt, btm )
   'Window ( 0, Hgt )-( wid, 0 )
   
   '' Default ( 0,0 ) = top left
	Window Screen ( 0, 0 )-( wid, hgt )
	'Window Screen ( lft, btm )-( rgt, top )
	
	View( 0, 0 )-( wid, hgt )
   
   WindowTitle "Graveyard Orbit - a 2D space physics puzzle game. Prototype # 6, september 2018"
   
   Color RGB( 255, 160, 160 ), RGB( 60, 64, 68 )
   
   ScreenSet( 0, 1 )
   
End Sub

Sub GameType.UpdateInput()
	
	Dim As Integer mouse_x, mouse_y
	Dim As Vec2 DistanceVector
	Dim As Vec2 VelocityVector
	Dim As Single  Distance
	Dim As Single  MinDIst
	
	''
	position_prev = position
	button_prev   = button
	
	''
	GetMouse mouse_x, mouse_y,, button
	
	position = Vec2( Cast( Single, mouse_x) , Cast( Single, mouse_y ) )
	
	''
	MinDist  = pick_distance
	
	nearest = 0
	
	If ( picked = 0 ) Then
		
		If ( Not LinearStates.Empty ) Then
				
			For P As LinearStateType Ptr = LinearStates.p_front To LinearStates.p_back
				
				DistanceVector = P->Position - position
				Distance = DistanceVector.LengthSquared()
				
				If ( Distance < MinDist ) Then
					
					MinDist = Distance
					nearest = P
					
				EndIf
			
			Next
		
		EndIf
		
		'' check Roxels
		If ( Not Roxels.Empty ) Then
				
			For P As RoxelType Ptr = Roxels.p_front To Roxels.p_back
				
				DistanceVector = P->Position - position
				Distance = DistanceVector.LengthSquared()
				
				If ( Distance < MinDist ) Then
					
					MinDist = Distance
					nearest = P
					
				EndIf
			
			Next
			
		EndIf
		
		'' Linearsprings
		If ( Not LinearSprings.Empty ) Then
				
			For L As LinearSpringType Ptr = LinearSprings.p_front To LinearSprings.p_back
				
				DistanceVector = L->LinearLink.Position - position
				Distance = DistanceVector.LengthSquared()
				
				If ( Distance < MinDist ) Then
					
					MinDist = Distance
					nearest = @(L->LinearLink)
					
				EndIf
			
			Next
		
		EndIf
		
		'' Orbits
		If ( Not Orbits.Empty ) Then
				
			For G As OrbitType Ptr = Orbits.p_front To Orbits.p_back
				
				DistanceVector = G->LinearLink.Position - position
				Distance = DistanceVector.LengthSquared()
				
				If ( Distance < MinDist ) Then
					
					MinDist = Distance
					nearest = @(G->LinearLink)
					
				EndIf
			
			Next
		
		EndIf
		
		'' Gravitys
		If ( Not Gravitys.Empty ) Then
				
			For G As GravityType Ptr = Gravitys.p_front To Gravitys.p_back
				
				DistanceVector = G->LinearLink.Position - position
				Distance = DistanceVector.LengthSquared()
				
				If ( Distance < MinDist ) Then
					
					MinDist = Distance
					nearest = @(G->LinearLink)
					
				EndIf
			
			Next
		
		EndIf
	
	EndIf
		
	''
	If ( button = 1 ) Then
		
		If ( button_prev = 1 ) Then 
			
			If ( Not picked = 0 ) Then
			
				DistanceVector = picked->Position - position
				VelocityVector = picked->Velocity
				
				picked->addImpulse( -DistanceVector * INV_DT * 0.1 - VelocityVector * 0.5 )
			
			EndIf
			
		Else
			
			picked = nearest
			
		EndIf
	
	Else
		
		picked = 0
	
	EndIf
	
	''
	If ( ScreenEvent( @e ) ) Then
		
		Select Case e.type
		
		Case fb.EVENT_KEY_PRESS
			
			If ( e.scancode = fb.SC_1 ) Then picked = 0 : Puzzle1()
			If ( e.scancode = fb.SC_2 ) Then picked = 0 : Puzzle2()
			If ( e.scancode = fb.SC_3 ) Then picked = 0 : Puzzle3()
			If ( e.scancode = fb.SC_4 ) Then picked = 0 : Puzzle4()
			If ( e.scancode = fb.SC_5 ) Then picked = 0 : Puzzle5()
			If ( e.scancode = fb.SC_6 ) Then picked = 0 : Puzzle6()
			If ( e.scancode = fb.SC_7 ) Then picked = 0 : Puzzle7()
			If ( e.scancode = fb.SC_8 ) Then picked = 0 : Puzzle8()
			If ( e.scancode = fb.SC_9 ) Then picked = 0 : Puzzle9()
			If ( e.scancode = fb.SC_0 ) Then picked = 0 : Puzzle0()
			
			'' Iterations
			If ( MultiKey( fb.SC_I ) And ( e.scancode = fb.SC_UP   ) ) Then iterations += 1
			If ( MultiKey( fb.SC_I ) And ( e.scancode = fb.SC_DOWN ) ) Then iterations -= 1
			
			If ( e.scancode = fb.SC_SPACE ) Then warmstart Xor= 1
			
			If ( e.scancode = fb.SC_ESCAPE ) Then End
			
		Case fb.EVENT_KEY_RELEASE
		
			Case fb.EVENT_KEY_REPEAT
			
		Case fb.EVENT_MOUSE_MOVE
		
		Case fb.EVENT_MOUSE_BUTTON_PRESS
			
			If (e.button = fb.BUTTON_LEFT) Then
			
			End If
			
			If (e.button = fb.BUTTON_RIGHT) Then
			
			End If
			
		Case fb.EVENT_MOUSE_BUTTON_RELEASE
			
			If (e.button = fb.BUTTON_LEFT) Then
			
			End If
			
			If (e.button = fb.BUTTON_RIGHT) Then
			
			End If
			
		Case fb.EVENT_MOUSE_WHEEL
		
		Case fb.EVENT_WINDOW_CLOSE
			
			End
			
		End Select
		
	End If
	
	If iterations < 1 Then iterations = 1
	
End Sub

Sub GameType.ClearImpulses()
	
	'' LinearStates
	If ( Not LinearStates.Empty ) Then 
		
		For P As LinearStateType Ptr = LinearStates.p_front To LinearStates.p_back
			
			P->impulse = Vec2( 0.0, 0.0 )
			
		Next
	
	EndIf
	
	''
	If ( Not LinearSprings.Empty ) Then 
		
		For P As LinearSpringType Ptr = LinearSprings.p_front To LinearSprings.p_back
			
			P->LinearLink.impulse = Vec2( 0.0, 0.0 )
			'P->accumulated_impulse = Vec2( 0.0, 0.0 )
			
		Next
	
	EndIf
	
	'' Roxels
	If ( Not Roxels.Empty ) Then 
		
		For P As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			P->impulse = Vec2( 0.0, 0.0 )
			
		Next
	
	EndIf
	
End Sub

Sub GameType.ClearWarmstart()
	
	''
	If ( Not LinearSprings.Empty ) Then 
		
		For S As LinearSpringType Ptr = LinearSprings.P_front To LinearSprings.P_back
		
			S->accumulated_impulse = Vec2( 0.0, 0.0 )
			
		Next
	
	EndIf
	
	''	Angular springs
	If ( Not AngularSprings.Empty ) Then 
		
		For A As AngularSpringType Ptr = AngularSprings.P_front To AngularSprings.P_back
			
			A->accumulated_impulse = 0.0
			
		Next
		
	EndIf
	
End Sub

Sub GameType.ClearAllArrays()
	
	LinearStates.Clear()
	Roxels.Clear()
	Gravitys.Clear()
	Orbits.Clear()
	LinearSprings.Clear()
	AngularSprings.Clear()
	
End Sub

''
sub GameType.drawEllipse ( ByVal Position as Vec2, _
	                        ByVal SemiAxes As Vec2, _
	                        ByVal Angle    As Vec2, _
	                        ByVal Colour   As UInteger )
	
	''	these constants define the graphical quality of the circle
	const as Single  verticelength = 16
	const as Integer minvertices   = 16
	const as Integer maxvertices   = 256
	
	''	approx. ellipse circumference ( Hudson's method )
	dim as Single h = ( ( SemiAxes.x - SemiAxes.y ) * ( SemiAxes.x - SemiAxes.y ) ) / _
	                  ( ( SemiAxes.x + SemiAxes.y ) * ( SemiAxes.x + SemiAxes.y ) )
	
	dim as single circumference = 0.25 * PI * ( SemiAxes.x + SemiAxes.y ) * _
	                             ( 3.0 * ( 1.0 + h / 4.0 ) + 1.0 / ( 1.0 - h / 4.0 ) )
	
	''	number of vertices
	dim as integer numvertices =  Abs( circumference / verticelength )
	
	'numvertices -= numvertices mod 4
	
	If ( numvertices < minvertices ) Then numvertices = minvertices
	if ( numvertices > maxvertices ) Then numvertices = maxvertices

	Dim As Vec2 Theta = Vec2( cos( TWO_PI / numvertices ), _
	                          Sin( TWO_PI / numvertices ) )
	
	Dim As Vec2 Coords( NumVertices )
	Dim As Vec2 EllipseCoords( NumVertices )
	
	Coords(0) = Theta.RotateCCW( Vec2( 1.0, 0.0 ) )
	
	EllipseCoords(0) = Position + ( Coords(0) * SemiAxes ).RotateCCW( Angle )
	
	for i as integer = 1 to numvertices-1
		
		Coords(i) = Theta.RotateCCW( Coords(i-1) )
		
		EllipseCoords(i) = Position + ( Coords(i) * SemiAxes ).RotateCCW( Angle )
		
	Next
	
	'For i as integer = 0 to numvertices-1
	'	
	'	EllipseCoords(i) = Position + ( Coords(i) * SemiAxes ).Rotate( Angle )
	'	
	'Next
	
	''	draw ellipse
	for i as integer = 0 to numvertices-1
		
		Dim as integer j = (i + 1) mod numvertices
		
		Line( EllipseCoords(i).x, EllipseCoords(i).y )-( EllipseCoords(j).x, EllipseCoords(j).y ), Colour
		'PSet( EllipseCoords(i).x, EllipseCoords(i).y ), Colour
		
	Next
	
end Sub


Sub GameType.drawOrbit( ByVal O As OrbitType Ptr )
	
	''' State vectors
	'Dim As vec2 distanceVector = O->LinearLink.b->position - O->LinearLink.a->position
	'Dim As vec2 velocityVector = O->LinearLink.b->velocity - O->LinearLink.a->velocity
	'
	'Dim As Single length = O->LinearLink.unit_vector.dot( distanceVector )
	'
	''' Eccentricity
	'Dim As Vec2 EccentricityVector = ( velocityVector.Dot( velocityVector ) * distanceVector - _
   '                                   distanceVector.dot( velocityVector ) * velocityVector ) / _
   '                                   ( C_GRAVITY * O->LinearLink.mass ) - O->LinearLink.unit_vector
	'
	'Dim As Single eccentricity = eccentricityVector.Length()
	'
	''' Periapsis
	'Dim As Vec2 PeriApsisVector = IIf( eccentricity > 0.0 , Vec2( eccentricityVector / eccentricity ) , Vec2( 0.0, 0.0 ) )

	''' Semi axes
	'Dim As Single SemiMajorAxis = 1.0 / ( 2.0 / Length - velocityVector.Dot( velocityVector ) / ( C_GRAVITY * O->LinearLink.mass ) )
	'Dim As Single semiMinorAxis = semiMajorAxis * Sqr( 1.0 - eccentricity * eccentricity )
	'
	'''	Scale axes by mass (only used for drawing)
	Dim As Vec2 SemiAxesA = Vec2( O->semiMajorAxis, O->semiMinorAxis ) * O->LinearLink.b->inv_mass * O->LinearLink.reduced_mass
	Dim As Vec2 SemiAxesB = Vec2( O->semiMajorAxis, O->semiMinorAxis ) * O->LinearLink.a->inv_mass * O->LinearLink.reduced_mass
	
	'' Distance between focal points
	Dim As Single FocalDistA = O->Eccentricity * SemiAxesA.x
	Dim As Single FocalDistB = O->Eccentricity * SemiAxesB.x
	
	''	Compute orbit centers (only used for drawing)
	Dim As Vec2 OrbitCenterA = O->LinearLink.Position - O->PeriApsisVector * FocalDistA
	Dim As Vec2 OrbitCenterB = O->LinearLink.Position + O->PeriApsisVector * FocalDistB
	
	'' Empty focal points
	Dim As Vec2 EmptyFocusA = O->LinearLink.Position - O->PeriApsisVector * FocalDistA * 2.0
	Dim As Vec2 EmptyFocusB = O->LinearLink.Position + O->PeriApsisVector * FocalDistB * 2.0
	
	''	Draw focal points
	Circle( EmptyFocusA.x, EmptyFocusA.y ), 0.05 * SemiAxesA.x,    RGB( 32, 128, 16 ),,,1
	Circle( EmptyFocusB.x, EmptyFocusB.y ), 0.05 * SemiAxesB.x,    RGB( 32, 128, 16 ),,,1
	Circle( O->LinearLink.Position.x, O->LinearLink.Position.y )    , 0.05 * O->semiMajorAxis, RGB( 32, 128, 16 ),,,1
	
	''	Draw orbits
	drawEllipse( OrbitCenterA, SemiAxesA, O->PeriApsisVector, RGB( 64, 255, 32 ) )
	drawEllipse( OrbitCenterB, SemiAxesB, O->PeriApsisVector, RGB( 64, 255, 32 ) )
	
End Sub

Function GameType.FindClosestLinearLink() As LinearLinkType Ptr
	
	Dim As LinearLinkType Ptr LP
	
	Return LP
	
End Function

Function GameType.FindClosestLinearState() As LinearStateType Ptr
	
	Dim As LinearStateType Ptr LP
	
	Return LP
	
End Function

Function GameType.FindClosestRoxel() As RoxelType Ptr
	
	Dim As RoxelType Ptr RP
	
	Return RP
	
End Function

Function GameType.ClosestPointOnLinearLink( ByVal LP As LinearLinkType Ptr, ByVal P As Vec2 ) As Vec2
	
	Dim As Vec2 ab = LP->b->position - LP->a->position
	
	Dim As Vec2 ap = p - LP->a->position
	
	Dim As Single t = ap.dot( ab ) / ab.dot( ab )
	
	If t < 0.0 Then t = 0.0
   If t > 1.0 Then t = 1.0
   
   Return LP->a->position + ab * t
	
End Function

