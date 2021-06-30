''*******************************************************************************
''
''  Sequential impulse spring with warm starting
''
''  Version 1, september 2015
''  Michael "h4tt3n" Nissen, micha3l_niss3n@yahoo.dk
''
''	Impulses are applied in opposite orders each loop
''
''******************************************************************************* 

''   Includes
#Include Once "fbgfx.bi"
#Include Once "../Math/Vector2.bi"

''   Global constants
Const As Single  c_stiffness    = 0.2               ''  spring stiffness coefficient    [0, 1]
Const As Single  c_damping      = 1.0               ''  spring damping coefficient      [0, 1]
Const As Single  c_corrective   = 1.0               ''  corrective impulse coefficient  [0, 1]
Const As Single  c_warmstart    = 1.0               ''  warm starting coefficient       [0, 1]
Const As Single  timestep       = 1.0 / 60.0        ''  timestep
Const As Single  inv_timestep   = 1.0 / timestep    ''  inverse timestep
Const As Single  gravity        = 10.0              ''  gravity
Const As Single  density        = 0.01              ''  ball density
Const As Single  min_mass       = 1.0              ''  min. particle mass
Const As Single  max_mass       = 1.0              ''  max. particle mass
Const As Single  pi             = 4.0 * Atn( 1.0 )  ''  pi
Const As Integer num_iterations = 1                 ''  number of impulse iterationsations per state update
Const As Integer num_particles  = 30                ''  number of particles
Const As Integer num_springs    = num_particles - 1 ''  number of springs
Const As Integer screen_wid     = 800               ''  screen width
Const As Integer screen_hgt     = 600               ''  screen height

''	Types
Type ParticleType
	
	Declare Constructor()
	
	As Vec2 position
	As Vec2 velocity
	As Vec2 impulse
	
	As Single  mass
	As Single  inverse_mass
	As Single  radius
  
End Type

Type SpringType
	
	Declare Constructor()
	Declare Constructor( ByVal A As ParticleType Ptr, ByVal B As ParticleType Ptr )
	
	As Single  rest_distance
	As Single  c_stiffnes
	As Single  c_damping
	As Single  c_corrective
	As Single  c_warmstart
	As Single  reduced_mass
	As Single  rest_impulse
	
	As Vec2 accumulated_impulse
	As Vec2 n
	
	As ParticleType Ptr particle_a
	As ParticleType Ptr particle_b
  
End Type

Type SimulationType
	
	Declare Constructor()

	Declare Sub CreateSimulation()
	Declare Sub CreateScreen( ByVal Wid As Integer, ByVal Hgt As Integer )
	
	Declare Sub UpdateKeyboard()
	Declare Sub UpdateScreen()
	Declare Sub UpdateMouse()
	
	Declare Sub RunSimulation()
	
	Declare Sub ComputeCorrectiveImpulse()
	Declare Sub ComputeWarmStarting()
	Declare Sub ComputeRestImpulse()
	Declare Sub compute_velocity()
	Declare Sub compute_position()
	
	Declare Sub Demo1()
	Declare Sub Demo2()
	Declare Sub Demo3()
	
	Declare Function CreateParticle() As ParticleType Ptr
	Declare Function CreateSpring() As SpringType Ptr
	
	As Integer iterations
	As Integer direction
	As Integer warmstarting
	As Integer numParticles
	As Integer numSprings
	
	As Vec2 position
	As Vec2 position_prev
	As Vec2 velocity
	
	As Integer button
	As Integer button_prev
	As Integer wheel
	As Integer wheel_prev
	
	As ParticleType Ptr picked
	
	As ParticleType Ptr ParticleLo
	As ParticleType Ptr ParticleHi
	
	As SpringType Ptr SpringLo
	As SpringType Ptr SpringHi
	
	As ParticleType particle ( 1 To num_particles )
	As SpringType   spring   ( 1 To num_springs )

End Type

''	Create instance and run simulation
Dim As SimulationType simulation

''	Constructors
Constructor ParticleType()

	position = Vec2( 0.0, 0.0 )
	velocity = Vec2( 0.0, 0.0 )
	impulse  = Vec2( 0.0, 0.0 )
	
	mass         = 0.0
	inverse_mass = 0.0
	radius       = 0.0
	
End Constructor

Constructor SpringType()

	rest_distance = 0.0
	c_stiffnes    = 0.0
	c_damping     = 0.0
	c_corrective  = 0.0
	c_warmstart   = 0.0
	reduced_mass  = 0.0
	rest_impulse  = 0.0
	
	accumulated_impulse = Vec2( 0.0, 0.0 )
	n                   = Vec2( 0.0, 0.0 )
	
	particle_a = 0
	particle_b = 0
	
End Constructor

Constructor SpringType( ByVal A As ParticleType Ptr, ByVal B As ParticleType Ptr )

	particle_a = A
	particle_b = B

	rest_distance = A->radius + A->radius
	
	c_stiffnes    = c_stiffness
	c_damping     = c_damping
	c_corrective  = c_corrective
	c_warmstart   = c_warmstart
	
	reduced_mass  = 1.0 / ( A->inverse_mass + B->inverse_mass )
	
	rest_impulse  = 0.0
	
	accumulated_impulse = Vec2( 0.0, 0.0 )
	n                   = Vec2( 0.0, 0.0 )
	
End Constructor

Constructor SimulationType()

	CreateSimulation()
	
	CreateScreen(screen_wid, screen_hgt)
	
	RunSimulation()
	
	End 
	
End Constructor

''	Demos

''	Demo 1
Sub SimulationType.Demo1()
	
End Sub

''	Demo 2
Sub SimulationType.Demo2()
	
End Sub

''	Demo 3
Sub SimulationType.Demo3()
	
End Sub

''	Subs / Functions
Sub SimulationType.RunSimulation()
	
	''  main program loop
	Do
		
		Direction = IIf( Direction = 1 , -1, 1 )
		
		UpdateMouse()
		UpdateKeyboard()
		
		For P As ParticleType Ptr = ParticleLo To ParticleHi
			
			If ( P->inverse_mass > 0.0 ) Then
			
				P->impulse += Vec2( 0.0, gravity )
			
			End If
		
		Next
		
		ComputeRestImpulse()		
		
		If MultiKey( fb.SC_SPACE ) Then 
			
			ComputeWarmStarting()
			
		Else
			
			For S As SpringType Ptr = SpringLo To SpringHi
			
				S->accumulated_impulse = Vec2( 0.0, 0.0 )
				
			Next
			
		EndIf
		
		For i As Integer = 0 To iterations - 1
		
			ComputeCorrectiveImpulse()
		
		Next
		
		compute_velocity()
		
		compute_position()
		
		UpdateScreen()
		
		Sleep 1, 1
		
	Loop

End Sub

Sub SimulationType.CreateSimulation()
	
	Randomize Timer
	
	ParticleLo = @Particle( 1 )
	ParticleHi = @Particle( num_particles )
	
	SpringLo = @spring( 1 )
	SpringHi = @spring( num_springs )
	
	warmstarting = -1
	picked = @Particle( 1 )
	iterations = num_iterations
	
	Dim As Integer n = 0
	
	'' create particles
	For P As ParticleType Ptr = ParticleLo To ParticleHi
		
		P->mass         = Abs( min_mass + ( Rnd() * ( max_mass ^ 4.0 ) ) ^ (1.0 / 4.0 ) )
		P->inverse_mass = 1.0 / P->mass
		P->radius       = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
		P->position.x   = 0.5 * screen_wid + ( Rnd() - Rnd() ) * 0.5 * screen_wid
		P->position.y   = 0.5 * screen_hgt + ( Rnd() - Rnd() ) * 0.5 * screen_hgt
		'P->position.x   = 0.5 * screen_wid '+ ( Rnd() - Rnd() ) * 1.0
		'P->position.y   = 0 + n * P->radius * 2
		
		n += 1
		
		If P = ParticleLo Then P->inverse_mass = 0': P->radius = 10.0
		If P = ParticleHi Then P->inverse_mass = 0
		
	Next
	
	''  create springs
	For i As Integer = 1 To num_springs
		
		With spring(i)
				
			.particle_a    = @particle( i )
			.particle_b    = @particle( i+1 )
			.rest_distance = .particle_a->radius + .particle_b->radius
			.c_stiffnes    = c_stiffness
			.c_damping     = c_damping
			.c_corrective  = c_corrective
			.c_warmstart   = c_warmstart
			.reduced_mass  = 1.0 / ( .particle_a->inverse_mass + .particle_b->inverse_mass )
			
		End With
	
	Next

End Sub

Sub SimulationType.ComputeRestImpulse()
	
	'' Compute the exact impulse needed to satisfy the constraint in one loop
	For S As SpringType Ptr = SpringLo To SpringHi
	
		Dim As Vec2 distance_vector = S->particle_b->position - S->particle_a->position
		Dim As Vec2 velocity_vector = S->particle_b->velocity - S->particle_a->velocity
		
		S->n = distance_vector.unit()
		
		Dim As Single distance_error = S->n.dot( distance_vector ) - S->rest_distance
		Dim As Single velocity_error = S->n.dot( velocity_vector )
		
		S->rest_impulse = - S->c_stiffnes * distance_error * inv_timestep - S->c_damping * velocity_error
	
	Next
	
End Sub

Sub SimulationType.ComputeCorrectiveImpulse()
	
	Dim As SpringType Ptr Lo = IIf( direction =  1 , SpringLo , SpringHi )
	Dim As SpringType Ptr Hi = IIf( direction = -1 , SpringLo , SpringHi )
	
	''
	For S As SpringType Ptr = Lo To Hi Step Direction
	
		Dim As Vec2 impulse_vector = S->particle_b->impulse - S->particle_a->impulse
		
		Dim As Single impulse_error = S->n.dot( impulse_vector ) - S->rest_impulse
		
		Dim As Vec2 corrective_impulse = - c_corrective * impulse_error * S->reduced_mass * S->n
		
		S->accumulated_impulse += corrective_impulse
		
		S->particle_a->impulse -= corrective_impulse * S->particle_a->inverse_mass
		S->particle_b->impulse += corrective_impulse * S->particle_b->inverse_mass
	
	Next
	
End Sub

Sub SimulationType.ComputeWarmStarting()
	
	'' Warm starting. Use previously applied impulse vector 
	'' projected onto new normal vector as initial guess rather than zero
	
	Dim As SpringType Ptr Lo = IIf( direction =  1 , SpringLo , SpringHi )
	Dim As SpringType Ptr Hi = IIf( direction = -1 , SpringLo , SpringHi )
	
	For S As SpringType Ptr = Lo To Hi Step Direction
		
		Dim As Single projected_impulse = S->n.dot( S->accumulated_impulse )
		
		If ( projected_impulse < 0.0 ) Then
			
			S->particle_a->impulse -= c_warmstart * projected_impulse * S->particle_a->inverse_mass * S->n
			S->particle_b->impulse += c_warmstart * projected_impulse * S->particle_b->inverse_mass * S->n
			
		End If
		
		S->accumulated_impulse = Vec2( 0.0, 0.0 )
		
	Next
	
End Sub

Sub SimulationType.compute_velocity()
	
	For P As ParticleType Ptr = ParticleLo  To ParticleHi
		
		If ( P <> picked ) Then
		
			P->velocity += P->impulse 
		
		End If
	
		P->impulse = Vec2( 0.0, 0.0 )
	
	Next

End Sub

Sub SimulationType.compute_position()
	
	For P As ParticleType Ptr = ParticleLo To ParticleHi 
		
		If ( P <> picked ) Then
		
			P->position += P->velocity * timestep   
		
		End If
		
	Next
	
End Sub

Sub SimulationType.UpdateScreen()
	
	ScreenLock
		
		Cls
		
		''
		Locate 4, 2: Print "Keys: F1-F9 Demos, 0-9 Iterations"
		Locate 6, 2: Print Using "Iterations: ##"; iterations
		Locate 8, 2: If MultiKey( fb.SC_SPACE ) Then Print "Warm start: ON" Else Print "Warm start: OFF"

		
		''  draw particles background
		For P As ParticleType Ptr = ParticleLo To ParticleHi
			
			Circle(P->position.x, P->position.y), P->radius + 5, RGB(0, 0, 0),,, 1, f
			
		Next
		
		''  draw springs 
		For S As SpringType Ptr = SpringLo To SpringHi
			
			Line(S->particle_a->position.x, S->particle_a->position.y)-_
				 (S->particle_b->position.x, S->particle_b->position.y), RGB(0, 255, 64)
			
		Next
		
		''	draw particles foreground
		For P As ParticleType Ptr = ParticleLo To ParticleHi
			
			Circle(P->position.x, P->position.y), P->radius, RGB(255, 0, 0),,, 1, f
			
		Next
		
	ScreenUnLock
	
End Sub

Sub SimulationType.CreateScreen( ByVal Wid As Integer, ByVal Hgt As Integer )
   
   ScreenRes Wid, Hgt, 24,, fb.GFX_ALPHA_PRIMITIVES
   
   WindowTitle "Mike's Sequential Impulse Spring Demo"
   
   Color RGB( 255, 160, 160 ), RGB( 64, 64, 64 )
   
End Sub

Sub SimulationType.UpdateMouse()
	
	Dim As Integer mouse_x, mouse_y
	Dim As Vec2 DistanceVector
	Dim As Single  Distance
	Dim As Single  MinDist
	
	''
	position_prev = position
	button_prev   = button
	wheel_prev    = wheel
	
	''
	GetMouse mouse_x, mouse_y, wheel, button
	
	position = Vec2( Cast( Single, mouse_x) , Cast( Single, mouse_y ) )
	
	''
	If ( button = 1 And button_prev = 0 ) Then
		
		For P As ParticleType Ptr = ParticleLo To ParticleHi
			
			DistanceVector = P->Position - Vec2( Cast( Single, mouse_x) , Cast( Single, mouse_y ) )
			Distance = DistanceVector.Length()
			MinDist  = screen_wid
			
			If (Distance < P->radius) Then
				
				MinDist = Distance
				picked = P
				
				Exit For
				
			EndIf
			
		Next
	
	End If
	
	''
	If ( button = 0 ) Then
		
		picked = 0
		
	End If
	
	''
	If ( button = 1 And button_prev = 1 And picked <> 0 ) Then
	
		picked->position.x += ( position.x - position_prev.x )
		picked->position.y += ( position.y - position_prev.y )
		
		picked->velocity.x = ( position.x - position_prev.x ) * inv_timestep
		picked->velocity.y = ( position.y - position_prev.y ) * inv_timestep
		
	End If
	
End Sub

Sub SimulationType.UpdateKeyboard()
	
		If MultiKey( fb.SC_1 ) Then iterations = 1
		If MultiKey( fb.SC_2 ) Then iterations = 2
		If MultiKey( fb.SC_3 ) Then iterations = 3
		If MultiKey( fb.SC_4 ) Then iterations = 4
		If MultiKey( fb.SC_5 ) Then iterations = 5
		If MultiKey( fb.SC_6 ) Then iterations = 6
		If MultiKey( fb.SC_7 ) Then iterations = 7
		If MultiKey( fb.SC_8 ) Then iterations = 8
		If MultiKey( fb.SC_9 ) Then iterations = 9
		If MultiKey( fb.SC_0 ) Then iterations = 10
		
		If MultiKey( fb.SC_F1 ) Then Demo1()
		
		If MultiKey(1) Then End
		
End Sub

Function SimulationType.CreateParticle() As ParticleType Ptr
	
	numParticles += 1
	
	Return @particle(numParticles - 1)
	
End Function

Function SimulationType.CreateSpring() As SpringType Ptr
	
	numSprings += 1
	
	Return @spring(numSprings - 1) 
	
End Function
