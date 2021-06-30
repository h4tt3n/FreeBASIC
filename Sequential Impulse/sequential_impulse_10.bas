''*******************************************************************************
''
''  Sequential impulse rope simulation with warm starting
''
''  Version 10, january 2016, Michael "h4tt3n" Nissen
''
''******************************************************************************* 

''   Includes
#Include Once "fbgfx.bi"
#Include Once "../Math/Vector2.bi"

''   Global constants
Const As Single  c_stiffness    = 0.1             ''  spring stiffness coefficient    [0, 1]
Const As Single  c_damping      = 1.0               ''  spring damping coefficient      [0, 1]
Const As Single  c_warmstart    = 0.75               ''  warm starting coefficient       [0, 1]
Const As Single  timestep       = 1.0 / 60.0        ''  timestep
Const As Single  inv_timestep   = 1.0 / timestep    ''  inverse timestep
Const As Single  gravity        = 1.0               ''  gravity
Const As Single  density        = 0.1              ''  ball density
Const As Single  min_mass       = 1.0               ''  min. particle mass
Const As Single  max_mass       = 1.0              ''  max. particle mass
Const As Single  pi             = 4.0 * Atn( 1.0 )  ''  pi
Const As Integer num_iterations = 10                ''  number of impulse iterationsations per state update
Const As Integer num_particles  = 32                ''  number of particles
Const As Integer num_springs    = num_particles - 1 ''  number of springs
Const As Integer screen_wid     = 900               ''  screen width
Const As Integer screen_hgt     = 900               ''  screen height
Const As Integer pick_distance  = 100               ''  screen height

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
	
	Declare Sub Demo1()
	
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStarting()
	Declare Sub ComputeRestImpulse()
	Declare Sub ComputeState()
	
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
	n = Vec2( 0.0, 0.0 )
	
	particle_a = 0
	particle_b = 0
	
End Constructor

Constructor SimulationType()

	CreateSimulation()
	
	CreateScreen(screen_wid, screen_hgt)
	
	RunSimulation()
	
End Constructor

''	Subs / Functions
Sub SimulationType.RunSimulation()
	
	''  Main program loop
	Do
		
		UpdateMouse()
		UpdateKeyboard()
		
		''	gravity
		For P As ParticleType Ptr = ParticleLo To ParticleHi
			
			If ( P->inverse_mass > 0.0 ) Then
			
				P->impulse += Vec2( 0.0, gravity )
			
			End If
		
		Next
		
		''	rest impulse 
		ComputeRestImpulse()		
		
		''	warm starting
		If MultiKey( fb.SC_SPACE ) Then 
			
			ApplyWarmStarting()
			
		Else
			
			For S As SpringType Ptr = SpringLo To SpringHi
			
				S->accumulated_impulse = Vec2( 0.0, 0.0 )
				
			Next
			
		EndIf
		
		''	sequential impulses
		For i As Integer = 0 To iterations - 1
		
			ApplyCorrectiveImpulse()
		
		Next
		
		''	Compute new particle state
		ComputeState()
		
		''	Draw to screen
		UpdateScreen()
		
		'Sleep 1, 1
		
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
		
		P->mass         = 1.0
		P->inverse_mass = 1.0 / P->mass
		P->radius       = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
		P->position.x   = 0.5 * screen_wid + n * 20
		P->position.y   = 0.1 * screen_hgt
		
		n += 1
		
		If P = ParticleLo Then P->inverse_mass = 0.0
		
		If P = ParticleHi Then
			
			P->mass = 200.0
			P->inverse_mass = 1.0 / P->mass
			P->radius = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
			
		EndIf
		
	Next
	
	''  create springs
	For i As Integer = 1 To num_springs
		
		With spring(i)
				
			.particle_a    = @particle( i )
			.particle_b    = @particle( i+1 )
			.rest_distance = .particle_a->radius + .particle_b->radius
			.c_stiffnes    = c_stiffness
			.c_damping     = c_damping
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
		
		S->n = distance_vector.Unit()
		
		Dim As Single distance_error = S->n.dot( distance_vector ) - S->rest_distance
		Dim As Single velocity_error = S->n.dot( velocity_vector )
		
		S->rest_impulse = - S->c_stiffnes * distance_error * inv_timestep - S->c_damping * velocity_error
	
	Next
	
End Sub

Sub SimulationType.ApplyCorrectiveImpulse()
	
	'' Apply a corrective impulse with respect to the impulse already added.
	'' Accumulate applied impulses for warmstarting the next loop.
	
	For S As SpringType Ptr = SpringLo To SpringHi Step 1
	
		Dim As Vec2 impulse_vector = S->particle_b->impulse - S->particle_a->impulse
		
		Dim As Single impulse_error = S->n.dot( impulse_vector ) - S->rest_impulse
		
		Dim As Vec2 corrective_impulse = - impulse_error * S->reduced_mass * S->n
		
		S->particle_a->impulse -= corrective_impulse * S->particle_a->inverse_mass
		S->particle_b->impulse += corrective_impulse * S->particle_b->inverse_mass
		
		S->accumulated_impulse += corrective_impulse
		
	Next
	
End Sub

Sub SimulationType.ApplyWarmStarting()
	
	'' Warm starting. Recycle the sum of previously applied impulses
	'' projected onto new normal vector as initial guess (better than zero).
	'' Also, we recycle warmstart impulse projected onto new normal vector.
	''
	'' This improved warmstart method is equivalent to applying *twice* the
	'' number of iterations. So, 4 iterations + warmstart equals 8 iterations.
	
	For S As SpringType Ptr = SpringLo To SpringHi Step 1
		
		Dim As Single projected_impulse = S->n.dot( S->accumulated_impulse )
		
		Dim As Vec2 warmstart_impulse = c_warmstart * projected_impulse * S->n
		
		If ( projected_impulse < 0.0 ) Then
			
			S->particle_a->impulse -= warmstart_impulse * S->particle_a->inverse_mass
			S->particle_b->impulse += warmstart_impulse * S->particle_b->inverse_mass
			
		End If
		
		S->accumulated_impulse = warmstart_impulse '' <-- Don't know why this works...
		'S->accumulated_impulse = Vec2( 0.0, 0.0 )
		
	Next
	
End Sub

Sub SimulationType.ComputeState()
	
	For P As ParticleType Ptr = ParticleLo  To ParticleHi
		
		If ( P <> picked ) Then
		
			P->velocity += P->impulse
			P->position += P->velocity * timestep  
		
		End If
		
		P->impulse = Vec2( 0.0, 0.0 )
		
	Next

End Sub

Sub SimulationType.UpdateScreen()
	
	ScreenLock
		
		Cls
		
		''
		Locate 4, 2: Print "Press 0-9 for number of Iterations, Space bar for Warm Starting, Left Mouse for pick up."
		Locate 8, 2: Print Using "Iterations: ##"; iterations
		Locate 10, 2: If MultiKey( fb.SC_SPACE ) Then Print "Warm Starting: ON" Else Print "Warm Starting: OFF"

		
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
	Dim As Single  MinDIst
	
	''
	position_prev = position
	button_prev   = button
	
	''
	GetMouse mouse_x, mouse_y,, button
	
	position = Vec2( Cast( Single, mouse_x) , Cast( Single, mouse_y ) )
	
	''
	If ( button = 1 And button_prev = 0 ) Then
		
		MinDist  = pick_distance
		
		For P As ParticleType Ptr = ParticleLo To ParticleHi
			
			DistanceVector = P->Position - Vec2( Cast( Single, mouse_x) , Cast( Single, mouse_y ) )
			Distance = DistanceVector.Length()
			
			If ( Distance < MinDist ) Then
				
				MinDist = Distance
				picked = P
				
			EndIf
			
		Next
	
	End If
	
	''
	If ( button = 0 And button_prev = 1 ) Then
		
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
	
	If MultiKey( fb.SC_K ) Then
		
		If MultiKey( fb.SC_PLUS ) Then
			
			
			
		EndIf
		
		If MultiKey( fb.SC_MINUS ) Then
			
			
			
		EndIf
		
	EndIf
	
	If MultiKey( fb.SC_1 ) Then iterations = 1
	If MultiKey( fb.SC_2 ) Then iterations = 2
	If MultiKey( fb.SC_3 ) Then iterations = 4
	If MultiKey( fb.SC_4 ) Then iterations = 6
	If MultiKey( fb.SC_5 ) Then iterations = 8
	If MultiKey( fb.SC_6 ) Then iterations = 10
	If MultiKey( fb.SC_7 ) Then iterations = 12
	If MultiKey( fb.SC_8 ) Then iterations = 16
	If MultiKey( fb.SC_9 ) Then iterations = 24
	If MultiKey( fb.SC_0 ) Then iterations = 32
	
	If MultiKey( fb.SC_ESCAPE ) Then End
	
End Sub

Function SimulationType.CreateParticle() As ParticleType Ptr
	
	numParticles += 1
	
	Return @particle(numParticles - 1)
	
End Function

Function SimulationType.CreateSpring() As SpringType Ptr
	
	numSprings += 1
	
	Return @spring(numSprings - 1) 
	
End Function
