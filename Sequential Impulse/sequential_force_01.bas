''*******************************************************************************
''
''  Sequential force rope simulation with warm starting
''
''  Version 1, january 2016, Michael "h4tt3n" Nissen
''
''******************************************************************************* 

''   Includes
#Include Once "fbgfx.bi"
#Include Once "../Math/Vector2.bi"

''   Global constants
Const As Single  dt             = 1.0 / 60.0        ''  dt
Const As Single  inv_dt         = 1.0 / dt          ''  inverse dt
Const As Single  inv_dt2        = inv_dt * inv_dt   ''  inverse dt squared
Const As Single  gravity        = 10.0               ''  gravity
Const As Single  density        = 0.1              ''  ball density
Const As Single  pi             = 4.0 * Atn( 1.0 )  ''  pi
Const As Integer screen_wid     = 1000               ''  screen width
Const As Integer screen_hgt     = 800               ''  screen height
Const As Integer pick_distance  = 100               ''  screen height
Const As Integer max_particles  = 2048               ''  screen height
Const As Integer max_springs    = 4096               ''  screen height

''	Types
Type ParticleType
	
	Declare Constructor()
	
	As Vec2 position
	As Vec2 velocity
	As Vec2 force
	
	As Single  mass
	As Single  inverse_mass
	As Single  radius
  
End Type

Type SpringType
	
	Declare Constructor()
	
	As Single  reduced_mass
	As Single  rest_distance
	As Single  rest_force
	
	As Vec2 accumulated_force
	As Vec2 unit
	
	As ParticleType Ptr particle_a
	As ParticleType Ptr particle_b
  
End Type

Type SimulationType
	
	Declare Constructor()

	Declare Sub Demo1()
	Declare Sub Demo2()
	Declare Sub Demo3()
	Declare Sub Demo4()
	Declare Sub Demo5()
	Declare Sub Demo6()
	Declare Sub Demo7()
	Declare Sub Demo8()
	
	Declare Sub CreateScreen( ByVal Wid As Integer, ByVal Hgt As Integer )
	
	Declare Sub ClearParticles()
	Declare Sub ClearSprings()
	
	Declare Sub UpdateKeyboard()
	Declare Sub UpdateScreen()
	Declare Sub UpdateMouse()
	
	Declare Sub RunSimulation()

	Declare Sub ApplyCorrectiveForce()
	Declare Sub ApplyWarmStarting()
	Declare Sub ComputeRestForce()
	Declare Sub ComputeState()
	
	As String DemoText
	
	As Integer iterations
	As Integer warmstart
	As Integer numParticles
	As Integer numSprings
	
	As Single cStiffness
	As Single cDamping
	As Single cWarmstart
	
	As Single currentLength
	As Single idealLength
	
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
	
	As ParticleType particle ( 1 To max_particles )
	As SpringType   spring   ( 1 To max_springs )

End Type

''	Create instance and run simulation
Dim As SimulationType simulation

''	Constructors
Constructor ParticleType()

	position = Vec2( 0.0, 0.0 )
	velocity = Vec2( 0.0, 0.0 )
	force    = Vec2( 0.0, 0.0 )
	
	mass         = 0.0
	inverse_mass = 0.0
	radius       = 0.0
	
End Constructor

Constructor SpringType()

	reduced_mass  = 0.0
	rest_distance = 0.0
	rest_force    = 0.0
	
	accumulated_force = Vec2( 0.0, 0.0 )
	unit = Vec2( 0.0, 0.0 )
	
	particle_a = 0
	particle_b = 0
	
End Constructor

Constructor SimulationType()
	
	ClearParticles()
	ClearSprings()
	
	CreateScreen( screen_wid, screen_hgt )
	
	Demo1()
	
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
			
				P->velocity += Vec2( 0.0, dt * gravity )
			
			End If
		
		Next
		
		''	rest force 
		ComputeRestforce()		
		
		''	warm starting
		If MultiKey( fb.SC_SPACE ) Then 
			
			ApplyWarmStarting()
			
		Else
			
			For S As SpringType Ptr = SpringLo To SpringHi
			
				S->accumulated_force = Vec2( 0.0, 0.0 )
				
			Next
			
		EndIf
		
		''	sequential forces
		For i As Integer = 0 To iterations - 1
		
			ApplyCorrectiveforce()
		
		Next
		
		''	Compute new particle state
		ComputeState()
		
		''	Draw to screen
		UpdateScreen()
		
		'Sleep 1, 1
		
	Loop

End Sub

Sub SimulationType.Demo1()
	
	'' Wrecking ball
	
	iterations   = 16
	warmstart    = 0
	cStiffness   = 0.2    
	cDamping     = 1.0
	cWarmstart   = 0.8
	numParticles = 12
	numSprings   = 11
	
	IdealLength = 0
	
	DemoText = "Demo 1: Wrecking ball (the ball weighs ONE THOUSAND times more than the smaller masses)"
	
	Dim As Integer SpringLength = 32
	
	''
	ClearParticles()
	ClearSprings()
	
	ParticleLo = @Particle( 1 )
	ParticleHi = @Particle( numParticles )
	
	SpringLo = @spring( 1 )
	SpringHi = @spring( numSprings )
	
	Dim As Integer n = 0
	
	'' create particles
	For P As ParticleType Ptr = ParticleLo To ParticleHi
		
		P->mass         = 1.0
		P->inverse_mass = 1.0 / P->mass
		P->radius       = 4.0
		P->position.x   = 0.5 * screen_wid + n * SpringLength
		P->position.y   = 0.2 * screen_hgt
		
		n += 1
		
		If P = ParticleLo Then P->inverse_mass = 0.0
		
		If P = ParticleHi Then
			
			P->mass = 1000.0
			P->inverse_mass = 1.0 / P->mass
			P->radius = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
			
		EndIf
		
	Next
	
	''  create springs
	For i As Integer = 1 To numsprings
		
		With spring(i)
				
			.particle_a    = @particle( i )
			.particle_b    = @particle( i+1 )
			.rest_distance = (.particle_b->position - .particle_a->position).length()
			.reduced_mass  = 1.0 / ( .particle_a->inverse_mass + .particle_b->inverse_mass )
			
			IdealLength += .rest_distance
			
		End With
	
	Next

End Sub

Sub SimulationType.Demo2()
	
	'' Rigid chain
	
	iterations = 8
	cStiffness = 0.2
	cDamping   = 1.0
	cWarmstart = 0.8
	numParticles = 64
	numSprings   = 63
	
	IdealLength = 0
	
	DemoText = "Demo 2: Rigid chain."
	
	''
	ClearParticles()
	ClearSprings()
	
	ParticleLo = @Particle( 1 )
	ParticleHi = @Particle( numParticles )
	
	SpringLo = @spring( 1 )
	SpringHi = @spring( numSprings )
	
	Dim As Integer n = 0
	
	'' create particles
	For P As ParticleType Ptr = ParticleLo To ParticleHi
		
		P->mass         = 1.0
		P->inverse_mass = 1.0 / P->mass
		P->radius       = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
		P->position.x   = 0.5 * screen_wid + n * 10
		P->position.y   = 0.1 * screen_hgt
		
		n += 1
		
		If P = ParticleLo Then P->inverse_mass = 0.0
		
	Next
	
	''  create springs
	For i As Integer = 1 To numsprings
		
		With spring(i)
				
			.particle_a    = @particle( i )
			.particle_b    = @particle( i+1 )
			.rest_distance = (.particle_b->position - .particle_a->position).length()
			.reduced_mass  = 1.0 / ( .particle_a->inverse_mass + .particle_b->inverse_mass )
			
			IdealLength += .rest_distance
			
		End With
	
	Next
	
End Sub

Sub SimulationType.Demo3()
	
	'' Quad-mesh
	
	Dim As Integer MeshWidth    = 32
	Dim As Integer MeshLength   = 24
	Dim As Integer SpringLength = 32
	Dim As Integer Border       = 128
	
	iterations = 2
	cStiffness = 0.1
	cDamping   = 1.0
	cWarmstart = 0.5
	numParticles = MeshWidth * MeshLength
	numSprings   = ( MeshLength - 1 ) * MeshWidth + ( MeshWidth - 1 ) * ( MeshLength - 1 )
	
	DemoText = "Demo 3: Quad-mesh."
	
	''
	ClearParticles()
	ClearSprings()
	
	ParticleLo = @Particle( 1 )
	ParticleHi = @Particle( numParticles )
	
	SpringLo = @spring( 1 )
	SpringHi = @spring( numSprings )
	
	Dim As Integer p = 0
	Dim As Integer s = 0
	
	''	particles
	for i as integer = 1 to MeshLength
		for j as integer = 1 to MeshWidth
			
			p += 1
			
			with Particle(p)
				
				.mass         = 1.0
				.inverse_mass = 1.0 / .mass
				.radius       = ( ( .mass / density ) / (4/3) * pi ) ^ (1/3) 
				.position.x   = border + ((j-1)/(MeshWidth-1)) * (screen_wid-2*border)
				.position.y   = border + ((i-1)/(MeshLength-1)) * (screen_hgt-2*border)
			  	
			  	If ( i = 1 ) Then .inverse_mass = 0.0
			  	
			end With
			
		next
	Next
	
	''  vertical springs
	for i as integer = 1 to MeshWidth
	  For j as integer = 1 to MeshLength-1
	      s += 1
	      With Spring(s)
	        .particle_a = @particle(i+(j-1)*MeshWidth)
	        .particle_b = @particle(i+MeshWidth+(j-1)*MeshWidth)
	        .rest_distance = (.particle_b->position - .particle_a->position).length()
	        .reduced_mass  = 1.0 / ( .particle_a->inverse_mass + .particle_b->inverse_mass )
	      End with
	  Next
	Next
	
	''  horizontal springs
	for i as integer = 2 to MeshLength
	  For j as integer = 1 to MeshWidth-1
	      s += 1
	      With Spring(s)
	        .particle_a = @particle((i-1)*MeshWidth+j)
	        .particle_b = @particle((i-1)*MeshWidth+j+1)
	        .rest_distance = (.particle_b->position - .particle_a->position).length()
	        
	        Dim As Single inv_red_mass = ( .particle_a->inverse_mass + .particle_b->inverse_mass )
	        
	        .reduced_mass  = IIf( inv_Red_mass = 0.0 , 0.0 , 1.0 / inv_Red_mass )
	        
	        '.reduced_mass  = 1.0 / ( .particle_a->inverse_mass + .particle_b->inverse_mass )
	      End with
	  Next
	next
	
	
End Sub

Sub SimulationType.Demo4()
	
	'' Steel girder
	
	Dim As Integer GirderWidth  = 2
	Dim As Integer GirderLength = 16
	Dim As Integer SpringLength = 48
	
	iterations = 2
	cStiffness = 0.4
	cDamping   = 1.0
	cWarmstart = 0.8
	numParticles = GirderWidth * GirderLength
	numSprings   = ( GirderLength - 1 ) * GirderWidth + _
	               ( ( GirderWidth - 1 ) * ( GirderLength - 1 ) ) * 3
	
	DemoText = "Demo 4: Steel girder (NO laughing!)"
	
	''
	ClearParticles()
	ClearSprings()
	
	ParticleLo = @Particle( 1 )
	ParticleHi = @Particle( numParticles )
	
	SpringLo = @spring( 1 )
	SpringHi = @spring( numSprings )
	
	Dim As Integer p = 0
	Dim As Integer s = 0
	
	''	particles
	for i as integer = 1 to GirderLength
		for j as integer = 1 to GirderWidth
			p += 1
			with Particle(p)
				.mass         = 1.0
				.inverse_mass = 1.0 / .mass
				.radius       = ( ( .mass / density ) / (4/3) * pi ) ^ (1/3) 
				.position.x   = 150 + (i-1) * SpringLength
				.position.y   = 300 + (j-1) * SpringLength
			  	
			  	If ( i = 1 ) Then .inverse_mass = 0.0
			  	
			end With
	  	Next
	Next
	
	for i as integer = 1 to GirderWidth
	  For j as integer = 1 to GirderLength-1
	      s += 1
	      With Spring(s)
	        .particle_a = @particle(i+(j-1)*GirderWidth)
	        .particle_b = @particle(i+GirderWidth+(j-1)*GirderWidth)
	        .rest_distance = (.particle_b->position - .particle_a->position).length()
	        .reduced_mass  = 1.0 / ( .particle_a->inverse_mass + .particle_b->inverse_mass )
	      End with
	  Next
	Next
	
	''  horizontal springs
	for i as integer = 2 to GirderLength
	  For j as integer = 1 to GirderWidth-1
	      s += 1
	      With Spring(s)
	        .particle_a = @particle((i-1)*GirderWidth+j)
	        .particle_b = @particle((i-1)*GirderWidth+j+1)
	        .rest_distance = (.particle_b->position - .particle_a->position).length()
	        
	        'Dim As Single inv_red_mass = ( .particle_a->inverse_mass + .particle_b->inverse_mass )
	        
	        '.reduced_mass  = IIf( inv_Red_mass = 0.0 , 0.0 , 1.0 / inv_Red_mass )
	        
	        .reduced_mass  = 1.0 / ( .particle_a->inverse_mass + .particle_b->inverse_mass )
	      End with
	  Next
	Next
	
	''  diagonal springs
	for i as integer = 1 to GirderWidth - 1
	  For j as integer = 1 to GirderLength-1
	      s += 1
	      With Spring(s)
	        .particle_a = @particle(i+(j-1)*GirderWidth)
	        .particle_b = @particle((j)*GirderWidth+i+1)
	        .rest_distance = (.particle_b->position - .particle_a->position).length()
	        .reduced_mass  = 1.0 / ( .particle_a->inverse_mass + .particle_b->inverse_mass )
	      End with
	  Next
	Next
	
	For i as integer = 1 to GirderWidth - 1
	  For j as integer = 1 to GirderLength-1
	      s += 1
	      With Spring(s)
		      .particle_a = @particle( (j)*GirderWidth + i )
		      .particle_b = @particle( (j-1)*GirderWidth + i+1)
	         .rest_distance = (.particle_b->position - .particle_a->position).length()
	         .reduced_mass  = 1.0 / ( .particle_a->inverse_mass + .particle_b->inverse_mass )
	      End with
	  Next
	Next
	
End Sub

Sub SimulationType.Demo5()
	
	'' Suspension bridge
	
	iterations = 4
	cStiffness = 0.4
	cDamping   = 1.0
	cWarmstart = 0.8
	numParticles = 48
	numSprings   = 47
	
	IdealLength = 0
	
	DemoText = "Demo 5: Suspension bridge."
	
	''
	ClearParticles()
	ClearSprings()
	
	ParticleLo = @Particle( 1 )
	ParticleHi = @Particle( numParticles )
	
	SpringLo = @spring( 1 )
	SpringHi = @spring( numSprings )
	
	Dim As Integer n = 0
	
	'' create particles
	For P As ParticleType Ptr = ParticleLo To ParticleHi
		
		P->mass         = 1.0
		P->inverse_mass = 1.0 / P->mass
		P->radius       = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
		P->position.x   = 0.15 * screen_wid + n * 16
		P->position.y   = 0.5 * screen_hgt
		
		n += 1
		
		If P = ParticleLo Then P->inverse_mass = 0.0
		If P = ParticleHi Then P->inverse_mass = 0.0
		
	Next
	
	''  create springs
	For i As Integer = 1 To numsprings
		
		With spring(i)
				
			.particle_a    = @particle( i )
			.particle_b    = @particle( i+1 )
			.rest_distance = (.particle_b->position - .particle_a->position).length()
			.reduced_mass  = 1.0 / ( .particle_a->inverse_mass + .particle_b->inverse_mass )
			
			IdealLength += .rest_distance
			
		End With
	
	Next
	
End Sub

Sub SimulationType.Demo6()
	
	'' Tri-mesh
	
End Sub

Sub SimulationType.Demo7()
	
	'' Tower
	
End Sub

Sub SimulationType.Demo8()
	
	'' Spider web
	
	iterations = 4
	cStiffness = 0.4
	cDamping   = 1.0
	cWarmstart = 0.8
	numParticles = 128
	'numSprings   = 47
	
	IdealLength = 0
	
	DemoText = "Demo 8: Spider web."
	
	''
	'ClearParticles()
	'ClearSprings()
	
	'ParticleLo = @Particle( 1 )
	'ParticleHi = @Particle( numParticles )
	
	'SpringLo = @spring( 1 )
	'SpringHi = @spring( numSprings )
	
	
	
End Sub

Sub SimulationType.ComputeRestforce()
	
	'' Compute the exact force needed to satisfy the constraint in one loop
	
	CurrentLength = 0
	
	For S As SpringType Ptr = SpringLo To SpringHi
	
		Dim As Vec2 distance_vector = S->particle_b->position - S->particle_a->position
		Dim As Vec2 velocity_vector = S->particle_b->velocity - S->particle_a->velocity
		
		S->unit = distance_vector.Unit()
		
		Dim As Single distance_error = S->unit.dot( distance_vector ) - S->rest_distance
		Dim As Single velocity_error = S->unit.dot( velocity_vector )
		
		S->rest_force = - cstiffness * distance_error * inv_dt2 - cdamping * velocity_error * inv_dt
		'S->rest_force = -( cstiffnes * distance_error * inv_dt2 + cdamping * velocity_error * inv_dt ) * S->reduced_mass
		
		CurrentLength += distance_vector.Length()
		
	Next
	
End Sub

Sub SimulationType.ApplyCorrectiveforce()
	
	'' Apply a corrective force with respect to the force already added.
	'' Accumulate applied forces for warmstarting next loop.
	
	For S As SpringType Ptr = SpringLo To SpringHi Step 1
	
		Dim As Vec2 force_vector = S->particle_b->force - S->particle_a->force
		
		Dim As Single force_error = S->unit.dot( force_vector ) - S->rest_force
		
	   Dim As Vec2 corrective_force = - force_error * S->reduced_mass * S->unit
		'Dim As Vec2 corrective_force = - force_error * S->unit
		
		S->particle_a->force -= corrective_force * S->particle_a->inverse_mass
		S->particle_b->force += corrective_force * S->particle_b->inverse_mass
		
		S->accumulated_force += corrective_force
		
	Next
	
End Sub

Sub SimulationType.ApplyWarmStarting()
	
	'' Warm starting. Recycle the sum of previously applied forces
	'' projected onto new normal vector as initial guess (better than zero).
	
	For S As SpringType Ptr = SpringLo To SpringHi Step 1
		
		Dim As Single projected_force = S->unit.dot( S->accumulated_force )
		
		Dim As Vec2 warmstart_force = cwarmstart * projected_force * S->unit
		
		If ( projected_force < 0.0 ) Then
			
			S->particle_a->force -= warmstart_force * S->particle_a->inverse_mass
			S->particle_b->force += warmstart_force * S->particle_b->inverse_mass
			
		End If
		
		S->accumulated_force = warmstart_force
		
	Next
	
End Sub

Sub SimulationType.ComputeState()
	
	For P As ParticleType Ptr = ParticleLo  To ParticleHi
		
		'P->velocity += P->force * P->inverse_mass * dt
		P->velocity += P->force * dt
		P->position += P->velocity * dt  
		
		P->force = Vec2( 0.0, 0.0 )
		
	Next

End Sub

Sub SimulationType.UpdateScreen()
	
	ScreenLock
		
		Cls
		
		''
		Locate  2, 2: Print "Press F1 - F8 for demos, 0 - 9 for number of iterations, space bar for warmstart, left mouse for pickup."
		Locate  6, 2: Print DemoText
		Locate 10, 2: Print Using "Iterations: ###"; iterations
		Locate 12, 2: If MultiKey( fb.SC_SPACE ) Then Print "Warmstart:   On" Else Print "Warmstart:  Off"
		Locate 16, 2: Print Using "(S)tiffness:  #.##"; cStiffness
		Locate 18, 2: Print Using "(D)amping:    #.##"; cDamping
		Locate 20, 2: Print Using "(W)armstart:  #.##"; cWarmstart
		'Locate 20, 2: Print Using "Error % : ###.##"; ( currentLength / IdealLength ) * 100 - 100
		
		''  draw particles background
		For P As ParticleType Ptr = ParticleLo To ParticleHi
			
			'Dim As UInteger Col = IIf( P = Picked , RGB(255, 255, 0), RGB(0, 0, 0) )
			
			Circle(P->position.x, P->position.y), P->radius + 5, RGB(0, 0, 0) ,,, 1, f
			
			If ( P = Picked ) Then Circle(P->position.x, P->position.y), P->radius + 5, RGB(255, 255, 0),,, 1
			
		Next
		
		''  draw springs 
		For S As SpringType Ptr = SpringLo To SpringHi
			
			Line(S->particle_a->position.x, S->particle_a->position.y)-_
				 (S->particle_b->position.x, S->particle_b->position.y), RGB(0, 255, 64)
			
		Next
		
		''	draw particles foreground
		For P As ParticleType Ptr = ParticleLo To ParticleHi
			
			Dim As UInteger Col = IIf( P->inverse_mass = 0.0, RGB(128, 128, 128), RGB(255, 0, 0) )
			
			Circle(P->position.x, P->position.y), P->radius, Col,,, 1, f
			
		Next
		
	ScreenUnLock
	
End Sub

Sub SimulationType.CreateScreen( ByVal Wid As Integer, ByVal Hgt As Integer )
   
   ScreenRes Wid, Hgt, 24,, fb.GFX_ALPHA_PRIMITIVES
   
   WindowTitle "Mike's Sequential force Spring Demo"
   
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
	'If ( button = 1 And button_prev = 0 ) Then
		
		MinDist  = pick_distance
		
		picked = 0
		
		For P As ParticleType Ptr = ParticleLo To ParticleHi
			
			DistanceVector = P->Position - Vec2( Cast( Single, mouse_x) , Cast( Single, mouse_y ) )
			Distance = DistanceVector.Length()
			
			If ( Distance < MinDist ) Then
				
				MinDist = Distance
				picked = P
				
			EndIf
			
		Next
	
	'End If
	
	''
	If ( button = 1 And button_prev = 1 And picked <> 0 ) Then
	
		picked->position.x += ( position.x - position_prev.x )
		picked->position.y += ( position.y - position_prev.y )
		
		picked->velocity.x = ( position.x - position_prev.x ) * dt
		picked->velocity.y = ( position.y - position_prev.y ) * dt
		
	End If
	
End Sub

Sub SimulationType.UpdateKeyboard()
	
	If MultiKey( fb.SC_F1 ) Then Demo1()
	If MultiKey( fb.SC_F2 ) Then Demo2()
	If MultiKey( fb.SC_F3 ) Then Demo3()
	If MultiKey( fb.SC_F4 ) Then Demo4()
	If MultiKey( fb.SC_F5 ) Then Demo5()
	If MultiKey( fb.SC_F6 ) Then Demo6()
	If MultiKey( fb.SC_F7 ) Then Demo7()
	If MultiKey( fb.SC_F8 ) Then Demo8()
	
	If MultiKey( fb.SC_S ) Then
		If MultiKey( fb.SC_UP )   Then cStiffness += 0.0002
		If MultiKey( fb.SC_DOWN ) Then cStiffness -= 0.0002
	EndIf
	
	If MultiKey( fb.SC_D ) Then
		If MultiKey( fb.SC_UP )   Then cDamping += 0.0002
		If MultiKey( fb.SC_DOWN ) Then cDamping -= 0.0002
	EndIf
	
	If MultiKey( fb.SC_W ) Then
		If MultiKey( fb.SC_UP )   Then cWarmstart += 0.0002
		If MultiKey( fb.SC_DOWN ) Then cWarmstart -= 0.0002
	EndIf
	
	If MultiKey( fb.SC_1 ) Then iterations = 1
	If MultiKey( fb.SC_2 ) Then iterations = 2
	If MultiKey( fb.SC_3 ) Then iterations = 4
	If MultiKey( fb.SC_4 ) Then iterations = 8
	If MultiKey( fb.SC_5 ) Then iterations = 16
	If MultiKey( fb.SC_6 ) Then iterations = 32
	If MultiKey( fb.SC_7 ) Then iterations = 64
	If MultiKey( fb.SC_8 ) Then iterations = 128
	If MultiKey( fb.SC_9 ) Then iterations = 256
	If MultiKey( fb.SC_0 ) Then iterations = 10
	
	If MultiKey( fb.SC_ESCAPE ) Then End
	
End Sub

Sub SimulationType.ClearParticles()
	
	For i As Integer = 1 To max_particles
		
		With particle(i)
			.mass         = 0.0
			.inverse_mass = 0.0
			.radius       = 0.0
			.position     = Vec2( 0.0, 0.0 )
			.velocity     = Vec2( 0.0, 0.0 )
			.force        = Vec2( 0.0, 0.0 )
		End With
	
	Next
	
End Sub

Sub SimulationType.ClearSprings()
	
	For i As Integer = 1 To max_springs
		
		With spring(i)
			.particle_a        = 0
			.particle_b        = 0
			.rest_distance     = 0.0
			.reduced_mass      = 0.0
			.rest_distance     = 0.0
			.rest_force        = 0.0
			.accumulated_force = Vec2( 0.0, 0.0 )
			.unit              = Vec2( 0.0, 0.0 )
		End With
	
	Next
	
End Sub

