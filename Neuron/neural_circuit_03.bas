''*******************************************************************************
''
''  Version 0.60, February 2019, Michael "h4tt3n" Nissen
''
''
''  Controls:
''  
''  Demos                      :  F1 - F6
''  Double / halve iterations  :  1 - 9
''  Inc. / dec. iterations     :  I + up / down
''  Inc. / dec. stiffness      :  S + up / down
''  Inc. / dec. damping        :  D + up / down
''  Inc. / dec. warmstart      :  W + up / down
''  Warmstart on / off         :  Space bar
''  Exit demo                  :  Escape key
''  
''******************************************************************************* 


''   Includes
#Include Once "fbgfx.bi"
#Include Once "../Math/Vec2.bi"


''   Global constants
Const As Single  dt                 = 1.0 / 60.0       ''  timestep
Const As Single  inv_dt             = 1.0 / dt         ''  inverse timestep
Const As Single  density            = 0.02             ''  ball density
Const As Single  pi                 = 4.0 * Atn( 1.0 ) ''  pi
Const As Integer screen_wid         = 1000             ''  screen width
Const As Integer screen_hgt         = 800              ''  screen height
Const As Integer pick_distance      = 128^2            ''  mouse pick up distance
Const As Integer max_Neurons        = 8192             ''  Neurons
Const As Integer max_Connections    = 4096             ''  Connections

''	Types
Type NeuronType
	
	Declare Constructor()
	
	As Vec2 position
	
	As Single voltage
	As Single dvdt
	As Single impulse
	
	As Single inverse_mass
	As Single radius
	
End Type

Type ConnectionType
	
	Declare Constructor()
	
	Declare Sub ComputeCorrectiveImpulse()
	
	As Single _accumulatedimpulse
	As Single _restimpulse
	
	As Single reduced_mass
	
	As NeuronType Ptr Neuron_a
	As NeuronType Ptr Neuron_b
  
End Type

Type SimulationType
	
	Declare Constructor()
	Declare Destructor()

	Declare Sub Demo1()
	Declare Sub Demo2()
	
	Declare Sub CreateScreen( ByVal Wid As Integer, ByVal Hgt As Integer )
	
	Declare Function CreateNeuron() As NeuronType Ptr
	Declare Function CreateConnection() As ConnectionType Ptr
	
	Declare Sub ClearNeurons()
	Declare Sub ClearConnections()
	Declare Sub ClearWarmstart()
	
	Declare Sub UpdateInput()
	Declare Sub UpdateScreen()
	
	Declare Sub RunSimulation()

	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	Declare Sub ComputeReusableData()
	Declare Sub ComputeNewState()
	
	As fb.EVENT e
	
	As String DemoText
	
	As Integer iterations
	As Integer warmstart
	As Integer numNeurons
	As Integer numConnections
	
	As Single cStiffness
	As Single cDamping
	As Single cWarmstart
	
	As Vec2 position
	As Vec2 position_prev
	As Vec2 velocity
	
	As Integer button
	As Integer button_prev
	
	As NeuronType Ptr picked
	As NeuronType Ptr nearest
	
	As NeuronType Ptr NeuronLo
	As NeuronType Ptr NeuronHi
	
	As ConnectionType Ptr ConnectionLo
	As ConnectionType Ptr ConnectionHi
	
	As NeuronType     Neuron     ( 1 To max_Neurons )
	As ConnectionType Connection ( 1 To max_Connections )

End Type


''	Create instance and run simulation
Scope

	Dim As SimulationType simulation

End Scope


''	Constructors
Constructor NeuronType()
	
	inverse_mass = 0.0
	radius       = 0.0
	position     = Vec2( 0.0, 0.0 )
	voltage    = 0.0
	dvdt    = 0.0
	impulse     = 0.0
	
End Constructor

Constructor ConnectionType()
	
	Neuron_a            = 0
	Neuron_b            = 0
	reduced_mass        = 0.0
	_restimpulse        = 0.0
	_accumulatedimpulse = 0.0
	
End Constructor

Constructor SimulationType()
	
	ClearNeurons()
	ClearConnections()
	
	CreateScreen( screen_wid, screen_hgt )
	
	Demo1()
	
	RunSimulation()
	
End Constructor

Destructor SimulationType()
	
	ClearConnections()
	ClearNeurons()
	
End Destructor


''	Main loop
Sub SimulationType.RunSimulation()
	
	Do
		
		UpdateInput()
		
		''
		ComputeReusableData()
		
		''
		If ( warmstart = 1 ) Then 
			
			ApplyWarmStart()
			
		Else
			
			ClearWarmstart()
			
		EndIf
		
		''
		For i As Integer = 1 To iterations
			
			ApplyCorrectiveImpulse()
		
		Next
		
		''
		ComputeNewState()
		
		UpdateScreen()
		
		Sleep( 10, 1 )
		
	Loop

End Sub


'' Demos
Sub SimulationType.Demo1()
	
	DemoText = "Mechanical wind-up clock Connection"
	
	iterations   = 4
	warmstart    = 0
	
	cStiffness   = 1.0  
	cDamping     = 0.001 
	cWarmstart   = 0.0
	
	Dim As Integer num_Neurons       = 128
	Dim As Integer num_Connections   = 127
	Dim As Integer ConnectionLength  = 100
	Dim As Single  Angle             = 3/4 * 2 * Pi
	Dim As Single  delta_Angle       = 0.05 * 2 * Pi
	
	''
	ClearNeurons()
	ClearConnections()
	
	Randomize
	
	''
	For i As integer = 1 To num_Neurons
		
		Dim As Neurontype Ptr P = CreateNeuron()
		
		Dim As Single mass = 1.0 ''1.0 + Rnd() * 100''1.0 + i
		
		P->inverse_mass = 1.0 / mass
		
		If i = num_Neurons Or i = 1 Then
			
			P->inverse_mass = 0.0
			
		EndIf
		 
		P->radius  = ( ( mass / density ) / (4/3) * pi ) ^ (1/3) 
		
		P->position = 0.5 * Vec2( screen_wid, screen_hgt ) + Vec2( Cos(Angle), Sin(Angle) ) * ConnectionLength
		
		P->voltage = 0.0''num_Neurons - i
		
		P->dvdt = 0.0
		
		If i = 3 Then
			
			P->voltage = -32
			'P->dvdt = 10.0
			''P->impulse = 10.0
			
		EndIf
		
		If i = 2 Then
			
			P->voltage = 32
			'P->dvdt = 10.0
			''P->impulse = 10.0
			
		EndIf
		
		'delta_angle -= 0.001
		Angle += delta_angle
		ConnectionLength += 1.5
		
	Next
	
	'' create Connections
	For i As Integer = 1 To num_Connections
		
		Dim As ConnectionType Ptr S = CreateConnection()
				
		S->Neuron_a = @Neuron( i )
		S->Neuron_b = @Neuron( i + 1 )
		
		Dim As Single inverseMass = S->Neuron_a->inverse_mass + S->Neuron_b->inverse_mass
		
		If ( inverseMass > 0.0 ) Then
			
			S->reduced_mass = 1.0 / inverseMass
			
		ElseIf ( S->Neuron_a->inverse_mass = 0.0 ) Then
			
			S->reduced_mass = S->Neuron_b->inverse_mass
			
		ElseIf ( S->Neuron_b->inverse_mass = 0.0 ) Then
			
			S->reduced_mass = S->Neuron_a->inverse_mass
		
		Else
			
			S->reduced_mass = 0.0
		
		EndIf
		
	Next
	
End Sub

Sub SimulationType.Demo2()
	
	DemoText = "Mechanical wind-up clock Connection"
	
	iterations   = 10
	warmstart    = 0
	
	cStiffness   = 0.5  
	cDamping     = 0.0  
	cWarmstart   = 0.25
	
	Dim As Integer num_Neurons       = 64
	Dim As Integer num_Connections   = 63
	Dim As Integer ConnectionLength  = 100
	Dim As Single  Angle             = 3/4 * 2 * Pi
	Dim As Single  delta_Angle       = 0.05 * 2 * Pi
	
	''
	ClearNeurons()
	ClearConnections()
	
	Randomize
	
	''
	For i As integer = 1 To num_Neurons
		
		Dim As Neurontype Ptr P = CreateNeuron()
		
		Dim As Single mass = 1.0 ''1.0 + Rnd() * 100''1.0 + i
		
		P->inverse_mass = 1.0 / mass
		
		If i = num_Neurons Then
			
			P->inverse_mass = 0.0
			
		EndIf
		 
		P->radius  = ( ( mass / density ) / (4/3) * pi ) ^ (1/3) 
		
		P->position = 0.5 * Vec2( screen_wid, screen_hgt ) + Vec2( Cos(Angle), Sin(Angle) ) * ConnectionLength
		
		P->voltage = num_Neurons - i
		
		P->dvdt = 0.0
		
		If i = 1 Then
			
			''P->voltage = 255
			
			'P->dvdt = 10.0
			
			''
			P->impulse = 10.0
			
		EndIf
		
		'delta_angle -= 0.001
		Angle += delta_angle
		ConnectionLength += 3
		
	Next
	
	'' create Connections
	For i As Integer = 1 To num_Connections
		
		Dim As ConnectionType Ptr S = CreateConnection()
				
		S->Neuron_a = @Neuron( i )
		S->Neuron_b = @Neuron( i + 1 )
		
		Dim As Single inverseMass = S->Neuron_a->inverse_mass + S->Neuron_b->inverse_mass
		
		If ( inverseMass > 0.0 ) Then
			
			S->reduced_mass = 1.0 / inverseMass
			
		ElseIf ( S->Neuron_a->inverse_mass = 0.0 ) Then
			
			S->reduced_mass = S->Neuron_b->inverse_mass
			
		ElseIf ( S->Neuron_b->inverse_mass = 0.0 ) Then
			
			S->reduced_mass = S->Neuron_a->inverse_mass
		
		Else
			
			S->reduced_mass = 0.0
		
		EndIf
		
	Next
	
End Sub


''
Sub ConnectionType.ComputeCorrectiveImpulse()
	
	''
	Dim As Single deltaimpulse = Neuron_b->impulse - Neuron_a->impulse
	
	Dim As Single impulse_error = deltaimpulse - _restimpulse
	
	Dim As Single correctiveimpulse = -impulse_error * reduced_mass
	
	'' apply impulse scaled by mass
	Neuron_a->impulse -= correctiveimpulse * Neuron_a->inverse_mass
	Neuron_b->impulse += correctiveimpulse * Neuron_b->inverse_mass
	
	'' save for warmstart
	_accumulatedimpulse += correctiveimpulse
	
End Sub


'' Core physics functions
Sub SimulationType.ComputeReusableData()
	
	''	Linear Connections
	For S As ConnectionType Ptr = ConnectionLo To ConnectionHi
		
		'' 
		Dim As Single distance = S->Neuron_b->voltage - S->Neuron_a->voltage
		Dim As Single velocity = S->Neuron_b->dvdt - S->Neuron_a->dvdt
		
		'' errors
		Dim As Single distance_error = distance
		Dim As Single velocity_error = velocity
		
		'' impulse needed to satisfy the constraint
		S->_restimpulse = -( cstiffness * distance_error * inv_dt + cdamping * velocity_error )
		
	Next
	
End Sub

Sub SimulationType.ApplyCorrectiveimpulse()
	
	For S As ConnectionType Ptr = ConnectionLo To ConnectionHi Step 1
		
		S->ComputeCorrectiveImpulse()
		
	Next
	
	For S As ConnectionType Ptr = ConnectionHi To ConnectionLo Step -1
		
		S->ComputeCorrectiveImpulse()
		
	Next
	
End Sub

Sub SimulationType.ApplyWarmStart()
	
	'' Warm starting. Re-use the sum of previously applied impulses as start value.
	''	This is roughly the equivalent of *doubling* the number of iterations.
	
	'' Linear Connections
	For S As ConnectionType Ptr = ConnectionLo To ConnectionHi
		
		Dim As Single projectedimpulse = S->_accumulatedimpulse
			
		Dim As Single warmstartimpulse = cwarmstart * projectedimpulse
		
		S->Neuron_a->impulse -= warmstartimpulse * S->Neuron_a->inverse_mass 
		S->Neuron_b->impulse += warmstartimpulse * S->Neuron_b->inverse_mass
		
		S->_accumulatedimpulse = 0.0
		
	Next
	
End Sub

Sub SimulationType.ComputeNewState()
	
	''	Compute new state vectors
	
	For P As NeuronType Ptr = NeuronLo To NeuronHi
		
		If ( P->inverse_mass > 0.0 ) Then
			
			P->dvdt    += P->impulse
			P->voltage += P->dvdt * dt 
			
		End If
		
		P->impulse = 0.0
		
	Next

End Sub

'' Graphics and interaction
Sub SimulationType.UpdateScreen()
		
	Cls
	
	''
	Locate  4, 2: Print DemoText
	Locate  8, 2: Print Using "(I) Iterations ###"; iterations
	Locate 12, 2: Print Using "(S) Linear stiffness  #.##"; cStiffness
	Locate 14, 2: Print Using "(D) Linear damping    #.##"; cDamping
	
	If ( warmstart = 0 ) Then 
		
		Locate 16, 2: Print "(W) Linear warmstart  OFF"
		
	Else
		
		Locate 16, 2: Print Using "(W) Linear warmstart  #.##"; cWarmstart
		
	EndIf
	
	''  draw Neurons background
	For P As NeuronType Ptr = NeuronLo To NeuronHi
		
		If ( P->radius > 0.0 ) Then
			
			Circle(P->position.x, P->position.y), P->radius + 2, RGB(0, 0, 0) ,,, 1, f
			
		End If
		
	Next
	
	''  draw Connections 
	For S As ConnectionType Ptr = ConnectionLo To ConnectionHi
		
		Dim As UByte col = ( S->Neuron_a->Voltage + S->Neuron_b->Voltage ) * 0.1
		
		Line(S->Neuron_a->position.x, S->Neuron_a->position.y)-_
			 (S->Neuron_b->position.x, S->Neuron_b->position.y), RGB(col, col, col)
		
		
	Next
	
	''	draw Neurons foreground
	For P As NeuronType Ptr = NeuronLo To NeuronHi
		
		If ( P->radius > 0.0 ) Then
			
			Dim As UInteger Col = IIf( P->inverse_mass = 0.0, RGB(160, 160, 160), RGB( P->voltage, 0, 0) )
			
			Circle(P->position.x, P->position.y), P->radius, Col,,, 1, f
			
		Else
			
			Dim As UInteger Col = IIf( P->inverse_mass = 0.0, RGB(160, 160, 160), RGB(P->voltage, 0, 0) )
			
			Circle(P->position.x, P->position.y), 2.2, Col,,, 1, f
			
		End If
		
		Draw String(P->position.x - 20 , P->position.y - 20 ), Str(P->voltage)
		
	Next
	
	If ( Nearest <> 0 ) Then Circle(Nearest->position.x, Nearest->position.y), Nearest->radius + 8, RGB(255, 255, 255),,, 1
	If ( Picked <> 0 ) Then Circle(Picked->position.x, Picked->position.y), Picked->radius + 8, RGB(255, 255, 0),,, 1
		
	ScreenCopy()
	
End Sub

Sub SimulationType.CreateScreen( ByVal Wid As Integer, ByVal Hgt As Integer )
   
   ScreenRes Wid, Hgt, 24, 2, fb.GFX_ALPHA_PRIMITIVES
   
   ScreenSet( 0, 1 )
   
   WindowTitle "Mike's iterative Connection demo. See source for controls."
   
   Color RGB( 255, 160, 160 ), RGB( 64, 64, 64 )
   
End Sub

Sub SimulationType.UpdateInput()
	
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
	
		For P As NeuronType Ptr = NeuronLo To NeuronHi
			
			DistanceVector = P->Position - Vec2( Cast( Single, mouse_x) , Cast( Single, mouse_y ) )
			Distance = DistanceVector.LengthSquared()
			
			If ( Distance < MinDist ) Then
				
				MinDist = Distance
				nearest = P
				
			EndIf
		
		Next
	
	End If
	
	If ( button = 1 And button_prev = 0 ) Then picked = nearest
	
	If ( button = 0 And picked <> 0 ) Then
		
		'picked->velocity.x = ( position.x - position_prev.x ) * inv_dt
		'picked->velocity.y = ( position.y - position_prev.y ) * inv_dt
		
	EndIf
	
	If ( button = 0 ) Then picked = 0
	
	
	''
	If ( picked <> 0 ) Then
	
		'picked->velocity = Vec2( 0.0, 0.0 )
	
		'picked->position.x += ( position.x - position_prev.x )
		'picked->position.y += ( position.y - position_prev.y )
		
		DistanceVector = picked->Position - Vec2( Cast( Single, mouse_x) , Cast( Single, mouse_y ) )
		
	End If
	
	If ( ScreenEvent( @e ) ) Then
		
		Select Case e.type
		
		Case fb.EVENT_KEY_PRESS
			
			If ( e.scancode = fb.SC_F1 ) Then Demo1()
			If ( e.scancode = fb.SC_F2 ) Then Demo2()
			
			'' Iterations
			If ( MultiKey( fb.SC_I ) And ( e.scancode = fb.SC_UP   ) ) Then iterations += 1
			If ( MultiKey( fb.SC_I ) And ( e.scancode = fb.SC_DOWN ) ) Then iterations -= 1
			
			If ( e.scancode = fb.SC_SPACE ) Then warmstart Xor= 1
			
			If ( e.scancode = fb.SC_ESCAPE ) Then End
			
		Case fb.EVENT_KEY_RELEASE
		
		Case fb.EVENT_KEY_REPEAT
			
			'' 
			If ( MultiKey( fb.SC_S ) And ( e.scancode = fb.SC_UP   ) ) Then cStiffness += 0.002
			If ( MultiKey( fb.SC_S ) And ( e.scancode = fb.SC_DOWN ) ) Then cStiffness -= 0.002
			
			'' 
			If ( MultiKey( fb.SC_D ) And ( e.scancode = fb.SC_UP   ) ) Then cDamping += 0.002
			If ( MultiKey( fb.SC_D ) And ( e.scancode = fb.SC_DOWN ) ) Then cDamping -= 0.002
			
			'' 
			If ( MultiKey( fb.SC_W ) And ( e.scancode = fb.SC_UP   ) ) Then cWarmstart += 0.002
			If ( MultiKey( fb.SC_W ) And ( e.scancode = fb.SC_DOWN ) ) Then cWarmstart -= 0.002
			
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
	
	If MultiKey( fb.SC_1 ) Then iterations = 1
	If MultiKey( fb.SC_2 ) Then iterations = 2
	If MultiKey( fb.SC_3 ) Then iterations = 3
	If MultiKey( fb.SC_4 ) Then iterations = 4
	If MultiKey( fb.SC_5 ) Then iterations = 5
	If MultiKey( fb.SC_6 ) Then iterations = 6
	If MultiKey( fb.SC_7 ) Then iterations = 7
	If MultiKey( fb.SC_8 ) Then iterations = 8
	If MultiKey( fb.SC_9 ) Then iterations = 9
	
	If iterations < 1 Then iterations = 1
	
	If cStiffness < 0.0 Then cStiffness = 0.0
	If cStiffness > 1.0 Then cStiffness = 1.0
	
	If cDamping < 0.0 Then cDamping = 0.0
	If cDamping > 1.0 Then cDamping = 1.0
	
	If cWarmstart < 0.0 Then cWarmstart = 0.0
	If cWarmstart > 1.0 Then cWarmstart = 1.0
	
End Sub


'' Memory management
Sub SimulationType.ClearNeurons()
	
	numNeurons = 0
	
	NeuronLo = @Neuron( 1 )
	NeuronHi = @Neuron( 1 )
	
	For i As Integer = 1 To max_Neurons
		
		With Neuron(i)
			
			.inverse_mass = 0.0
			.radius       = 0.0
			.position     = Vec2( 0.0, 0.0 )
			.voltage    = 0.0
			.dvdt    = 0.0
			.impulse     = 0.0
			
		End With
	
	Next
	
End Sub

Sub SimulationType.ClearConnections()
	
	numConnections = 0
	
	ConnectionLo = @Connection( 1 )
	ConnectionHi = @Connection( 1 )
	
	For i As Integer = 1 To max_Connections
		
		With Connection(i)
			
			.Neuron_a             = 0
			.Neuron_b             = 0
			.reduced_mass         = 0.0
			._restimpulse        = 0.0
			._accumulatedimpulse = 0.0
			
		End With
	
	Next
	
End Sub

Sub SimulationType.ClearWarmstart()
	
	For S As ConnectionType Ptr = ConnectionLo To ConnectionHi
	
		S->_accumulatedimpulse = 0.0
		
	Next
	
End Sub

Function SimulationType.CreateNeuron() As NeuronType Ptr
	
	If ( numNeurons < max_Neurons - 1 ) Then
		
		numNeurons += 1
		
		NeuronHi = @Neuron( numNeurons )
		
		Return NeuronHi
		
	End If
	
End Function

Function SimulationType.CreateConnection() As ConnectionType Ptr
	
	If ( numConnections < max_Connections - 1 ) Then
		
		numConnections += 1
		
		ConnectionHi = @Connection( numConnections )
		
		Return ConnectionHi 
		
	End If
	
End Function
