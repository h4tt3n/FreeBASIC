''*******************************************************************************
''
''  Sequential force with warmstart demos
''
''  Version 0.2, january 2016, Michael "h4tt3n" Nissen
''
''  Controls:
''  
''  Demos                 :  F1 - F8
''  Number of iterations  :  1 - 9
''  Inc / dec iterations  :  I + up / down
''  Stiffness coefficient :  S + up / down
''  Damping coefficient   :  D + up / down
''  Warmstart coefficient :  W + up / down
''  Warmstart on / off    :  Space bar
''  Exit demo             :  Escape key
''  
''******************************************************************************* 


''   Includes
#Include Once "fbgfx.bi"
#Include Once "../Math/Vector2.bi"


''   Global constants
Const As Single  dt             = 1.0 / 60.0       ''  dt
Const As Single  inv_dt         = 1.0 / dt         ''  inverse dt
Const As Single  inv_dt2        = inv_dt * inv_dt  ''  inverse dt squared
Const As Single  gravity        = 20.0             ''  gravity
Const As Single  density        = 0.1              ''  ball density
Const As Single  pi             = 4.0 * Atn( 1.0 ) ''  pi
Const As Integer screen_wid     = 1000             ''  screen width
Const As Integer screen_hgt     = 800              ''  screen height
Const As Integer pick_distance  = 128^2            ''  
Const As Integer max_particles  = 2048             ''  
Const As Integer max_springs    = 4096             ''  


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
	
	Declare Function CreateParticle() As ParticleType Ptr
	Declare Function CreateSpring() As SpringType Ptr
	
	Declare Sub ClearParticles()
	Declare Sub ClearSprings()
	
	Declare Sub UpdateInput()
	Declare Sub UpdateScreen()
	
	Declare Sub RunSimulation()

	Declare Sub ApplyCorrectiveForce()
	Declare Sub ApplyWarmStart()
	Declare Sub ComputeRestForce()
	Declare Sub ComputeState()
	
	As fb.EVENT e
	
	As String DemoText
	
	As Integer iterations
	As Integer warmstart    = 0
	As Integer numParticles
	As Integer numSprings
	
	As Single cStiffness
	As Single cDamping
	As Single cWarmstart
	
	As Vec2 position
	As Vec2 position_prev
	As Vec2 velocity
	
	As Integer button
	As Integer button_prev
	
	As ParticleType Ptr picked
	As ParticleType Ptr nearest
	
	As ParticleType Ptr ParticleLo
	As ParticleType Ptr ParticleHi
	
	As SpringType Ptr SpringLo
	As SpringType Ptr SpringHi
	
	As ParticleType particle ( 1 To max_particles )
	As SpringType   spring   ( 1 To max_springs )

End Type


''	Create instance and run simulation
Scope

	Dim As SimulationType simulation

End Scope


''	Constructors
Constructor ParticleType()
	
	mass         = 0.0
	inverse_mass = 0.0
	radius       = 0.0
	position     = Vec2( 0.0, 0.0 )
	velocity     = Vec2( 0.0, 0.0 )
	force        = Vec2( 0.0, 0.0 )
	
End Constructor

Constructor SpringType()
	
	particle_a        = 0
	particle_b        = 0
	reduced_mass      = 0.0
	rest_distance     = 0.0
	rest_force        = 0.0
	accumulated_force = Vec2( 0.0, 0.0 )
	unit              = Vec2( 0.0, 0.0 )
	
End Constructor

Constructor SimulationType()
	
	ClearParticles()
	ClearSprings()
	
	CreateScreen( screen_wid, screen_hgt )
	
	Demo1()
	
	RunSimulation()
	
End Constructor


''	Main loop
Sub SimulationType.RunSimulation()
	
	Do
		
		UpdateInput()
		
		ComputeRestForce()		
		
		If warmstart = 1 Then 
			
			ApplyWarmStart()
			
		Else
			
			For S As SpringType Ptr = SpringLo To SpringHi
			
				S->accumulated_force = Vec2( 0.0, 0.0 )
				
			Next
			
		EndIf
		
		For i As Integer = 1 To iterations
		
			ApplyCorrectiveForce()
		
		Next
		
		ComputeState()
		
		UpdateScreen()
		
	Loop

End Sub


'' Demos
Sub SimulationType.Demo1()
	
	'' Wrecking ball
	
	iterations   = 10
	warmstart    = 1
	cStiffness   = 0.25    
	cDamping     = 1.0
	cWarmstart   = 0.75
	Dim As Integer num_Particles = 10
	Dim As Integer num_Springs   = 9
	
	DemoText = "Demo 1: Wrecking ball. The ball weighs 1000 times more than the smaller masses, but there is almost no deformation."
	
	Dim As Integer SpringLength = 40 
	
	''
	ClearParticles()
	ClearSprings()
	
	'' create particles
	For i As integer = 1 To num_Particles
		
		Dim As particletype Ptr P = CreateParticle()
		
		P->mass         = 1.0
		P->inverse_mass = 1.0 / P->mass
		P->radius       = 0.0
		P->position.x   = 0.5 * screen_wid + i * SpringLength
		P->position.y   = 0.2 * screen_hgt
		
		If i = 1 Then P->inverse_mass = 0.0
		
		If i = num_Particles Then
			
			P->mass = 1000.0
			P->inverse_mass = 1.0 / P->mass
			P->radius = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
			
		EndIf
		
	Next
	
	''  create springs
	For i As Integer = 1 To num_Springs
		
		Dim As SpringType Ptr S = CreateSpring()
				
		S->particle_a    = @particle( i )
		S->particle_b    = @particle( i + 1 )
		S->rest_distance = (S->particle_b->position - S->particle_a->position).length()
		S->reduced_mass  = 1.0 / ( S->particle_a->inverse_mass + S->particle_b->inverse_mass )
		
	Next

End Sub

Sub SimulationType.Demo2()
	
	'' Rigid chain
	
	iterations   = 10
	warmstart    = 1
	cStiffness   = 0.25
	cDamping     = 1.0
	cWarmstart   = 0.75
	Dim As Integer num_Particles = 24
	Dim As Integer num_Springs   = 23
	
	DemoText = "Demo 2: Rigid chain. Each ball weight twice as much as the one above it. "
	
	''
	ClearParticles()
	ClearSprings()
	
	Dim As Integer px = 0.5 * screen_wid
	
	'' create particles
	For i As Integer = 1 To num_Particles
		
		Dim As particletype Ptr P = CreateParticle()
		
		P->mass         = 1.0 + i * i
		P->inverse_mass = 1.0 / P->mass
		P->radius       = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
		P->position.x   = px
		P->position.y   = 0.2 * screen_hgt
		
		px += P->radius
		
		If i = 1 Then P->inverse_mass = 0.0
		
	Next
	
	''  create springs
	For i As Integer = 1 To num_springs
		
		Dim As SpringType Ptr S = CreateSpring()
		
		S->particle_a    = @particle( i )
		S->particle_b    = @particle( i + 1 )
		S->rest_distance = S->particle_b->radius + S->particle_a->radius
		S->reduced_mass  = 1.0 / ( S->particle_a->inverse_mass + S->particle_b->inverse_mass )
	
	Next
	
End Sub

Sub SimulationType.Demo3()
	
	'' Quad-mesh
	
	Dim As Integer MeshWidth    = 32
	Dim As Integer MeshLength   = 24
	Dim As Integer SpringLength = 32
	Dim As Integer Border       = 128
	
	iterations   = 10
	warmstart    = 0
	cStiffness   = 0.02
	cDamping     = 1.0
	cWarmstart   = 0.1
	
	DemoText = "Demo 3: Quad-mesh."
	
	''
	ClearParticles()
	ClearSprings()
	
	Dim As Integer p = 0
	Dim As Integer s = 0
	
	''	particles
	for i as integer = 1 to MeshLength
		for j as integer = 1 to MeshWidth
			
			Dim As particletype Ptr P = CreateParticle()
			
			P->mass         = 1.0
			P->inverse_mass = 1.0 / P->mass
			P->radius       = 0.0 
			P->position.x   = border + ( (j-1) / (MeshWidth-1)) * (screen_wid-2*border)
			P->position.y   = border + ( (i-1) / (MeshLength-1)) * (screen_hgt-2*border)
		  	
		  	If ( i = 1 ) Then P->inverse_mass = 0.0
			
		next
	Next
	
	''  vertical springs
	for i as integer = 1 to MeshWidth
		For j as integer = 1 to MeshLength-1
			
			Dim As SpringType Ptr S = CreateSpring()
			
			S->particle_a = @particle(i+(j-1)*MeshWidth)
			S->particle_b = @particle(i+MeshWidth+(j-1)*MeshWidth)
			S->rest_distance = ( S->particle_b->position - S->particle_a->position ).length()
			S->reduced_mass  = 1.0 / ( S->particle_a->inverse_mass + S->particle_b->inverse_mass )
			
		Next
	Next
	
	''  horizontal springs
	for i as integer = 2 to MeshLength
		For j as integer = 1 to MeshWidth-1
			
			Dim As SpringType Ptr S = CreateSpring()
			
			S->particle_a = @particle((i-1)*MeshWidth+j)
			S->particle_b = @particle((i-1)*MeshWidth+j+1)
			S->rest_distance = ( S->particle_b->position - S->particle_a->position ).length()
			S->reduced_mass  = 1.0 / ( S->particle_a->inverse_mass + S->particle_b->inverse_mass )
			
		Next
	next
	
	
End Sub

Sub SimulationType.Demo4()
	
	'' Steel girder
	
	Dim As Integer GirderWidth  = 2
	Dim As Integer GirderLength = 22
	Dim As Integer SpringLength = 40
	
	iterations   = 10
	warmstart    = 1
	cStiffness   = 1.0
	cDamping     = 1.0
	cWarmstart   = 0.6
	
	DemoText = "Demo 4: Horizontal steel girder fighting gravity (NO dirty thoughts!)"
	
	''
	ClearParticles()
	ClearSprings()
	
	''	particles
	for i as integer = 1 to GirderLength
		for j as integer = 1 to GirderWidth
		
			Dim As particletype Ptr P = CreateParticle()
			
			P->mass         = 1.0
			P->inverse_mass = 1.0 / P->mass
			P->radius       = 0.0
			P->position.x   = 100 + (i-1) * SpringLength 
			P->position.y   = 300 + (j-1) * SpringLength
		  	
		  	If ( i = 1 ) Then P->inverse_mass = 0.0
		  	
		Next
	Next
	
	''  vertical springs
	for i as integer = 1 to GirderWidth
		For j as integer = 1 to GirderLength-1 
		'For j as integer = i to GirderLength-1  Step 2
			
			Dim As SpringType Ptr S = CreateSpring()
			
			S->particle_a = @particle(i+(j-1)*GirderWidth)
			S->particle_b = @particle(i+GirderWidth+(j-1)*GirderWidth)
			
		Next
	Next
	
	''  horizontal springs
	for i as integer = 1 to GirderLength
		For j as integer = 1 to GirderWidth-1
			
			Dim As SpringType Ptr S = CreateSpring()
			
			S->particle_a = @particle((i-1)*GirderWidth+j)
			S->particle_b = @particle((i-1)*GirderWidth+j+1)
			
		Next
	Next
	
	''  diagonal springs
	for i as integer = 1 to GirderWidth - 1
		For j as integer = 1 to GirderLength-1 
			
			Dim As SpringType Ptr S = CreateSpring()
			
			S->particle_a = @particle(i+(j-1)*GirderWidth)
			S->particle_b = @particle(j*GirderWidth+i+1)
			
			S = CreateSpring()
			
			S->particle_a = @particle( j*GirderWidth + i )
			S->particle_b = @particle( (j-1)*GirderWidth + i+1)
			
		Next
	Next
	
	''
	For S As SpringType Ptr = SpringLo To SpringHi
		
		S->rest_distance = ( S->particle_b->position - S->particle_a->position ).Length()
		
		Dim As Single inverseMass = S->particle_a->inverse_mass + S->particle_b->inverse_mass
		
		S->reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
		
	Next
	
End Sub

Sub SimulationType.Demo5()
	
	'' Suspension bridge
	
	iterations   = 4
	warmstart    = 1
	cStiffness   = 0.4
	cDamping     = 1.0
	cWarmstart   = 0.75
	Dim As Integer num_Particles = 48
	Dim As Integer num_Springs   = 47
	
	DemoText = "Demo 5: Suspension bridge."
	
	''
	ClearParticles()
	ClearSprings()
	
	'' create particles
	For i As Integer = 1 To num_particles
		
		Dim As particletype Ptr P = CreateParticle()
		
		P->mass         = 1.0
		P->inverse_mass = 1.0 / P->mass
		P->radius       = 0.0
		P->position.x   = 0.15 * screen_wid + i * 16
		P->position.y   = 0.5 * screen_hgt
		
		If i = 1 Then P->inverse_mass = 0.0
		If i = num_particles Then P->inverse_mass = 0.0
		
	Next
	
	''  create springs
	For i As Integer = 1 To num_springs
		
		Dim As SpringType Ptr S = CreateSpring()
		
		S->particle_a    = @particle( i )
		S->particle_b    = @particle( i + 1 )
		S->rest_distance = ( S->particle_b->position - S->particle_a->position ).length()
		S->reduced_mass  = 1.0 / ( S->particle_a->inverse_mass + S->particle_b->inverse_mass )
		
	Next
	
End Sub

Sub SimulationType.Demo6()
	
	'' 
	DemoText = "Demo 6: "
	
	
End Sub

Sub SimulationType.Demo7()
	
	'' Tower
	Dim As Integer GirderWidth  = 2
	Dim As Integer GirderLength = 36
	Dim As Integer SpringLength = 20
	
	iterations   = 10
	warmstart    = 1
	cStiffness   = 0.5
	cDamping     = 1.0
	cWarmstart   = 0.75
	
	DemoText = "Demo 7: Steel girder tower"
	
	''
	ClearParticles()
	ClearSprings()
	
	''	particles
	for i as integer = 1 to GirderLength
		for j as integer = 1 to GirderWidth
		
			Dim As particletype Ptr P = CreateParticle()
			
			P->mass         = 1.0
			P->inverse_mass = 1.0 / P->mass
			P->radius       = 0.0
			P->position.x   = 450 + (j-1) * SpringLength + (j - 1.5 ) * (GirderLength - i )
			P->position.y   =  screen_hgt - 32 - (i-1) * SpringLength '( j -1 ) * SpringLength * 0.5
		  	
		  	If ( i = 1 ) Then P->inverse_mass = 0.0
		  	
		Next
	Next
	
	''  horizontal springs
	for i as integer = 1 to GirderLength
		For j as integer = 1 to GirderWidth-1
			
			Dim As SpringType Ptr S = CreateSpring()
			
			S->particle_a = @particle((i-1)*GirderWidth+j)
			S->particle_b = @particle((i-1)*GirderWidth+j+1)
			
		Next
	Next
	
	''  vertical springs
	for i as integer = 1 to GirderWidth
		For j as integer = 1 to GirderLength-1
			
			Dim As SpringType Ptr S = CreateSpring()
			
			S->particle_a = @particle(i+(j-1)*GirderWidth)
			S->particle_b = @particle(i+GirderWidth+(j-1)*GirderWidth)
			
		Next
	Next
	
	''  diagonal springs
	for i as integer = 1 to GirderWidth - 1
	  For j as integer = 1 to GirderLength-1 'Step 2
	  	
			Dim As SpringType Ptr S = CreateSpring()
			
			S->particle_a = @particle(i+(j-1)*GirderWidth)
			S->particle_b = @particle(j*GirderWidth+i+1)
			
	  Next
	Next
	
	''  diagonal springs
	For i as integer = 1 to GirderWidth - 1
	  For j as integer = 1 to GirderLength-1 'Step 2
	  	
	  		Dim As SpringType Ptr S = CreateSpring()
	  	
			S->particle_a = @particle( j*GirderWidth + i )
			S->particle_b = @particle( (j-1)*GirderWidth + i+1)
			
	  Next
	Next
	
	''
	For S As SpringType Ptr = SpringLo To SpringHi
		
		S->rest_distance = ( S->particle_b->position - S->particle_a->position ).Length()
		
		Dim As Single inverseMass = S->particle_a->inverse_mass + S->particle_b->inverse_mass
		
		S->reduced_mass  = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
		
	Next
	
End Sub

Sub SimulationType.Demo8()
	
	'' Spider web
	
	iterations   = 4
	warmstart    = 1
	cStiffness   = 0.1
	cDamping     = 1.0
	cWarmstart   = 0.5
	
	Dim As Integer num_edges = 30
	Dim As Integer num_rounds = 20
	Dim As Single delta_step = 16 / num_edges 
	Dim As Integer num_Particles = num_edges * num_rounds 
	Dim As Integer num_Springs   = num_Particles - num_edges + num_edges * ( num_rounds - 1 )
	
	DemoText = "Demo 8: Spider web"
	
	''
	ClearParticles()
	ClearSprings()
	
	Dim As Single Distance = 16
	
	Randomize Timer
	
	''	particles
	for i as integer = 1 to num_Particles
	
		Dim As particletype Ptr P = CreateParticle()
		
		Dim As Single Angle = i * ( ( 2.0 * pi ) / num_edges )
		
		P->mass         = 1.0
		P->inverse_mass = 1.0 / P->mass
		P->radius       = 0.0
		P->position.x   = screen_wid * 0.5 + Cos( angle ) * Distance
		P->position.y   = screen_hgt * 0.5 + Sin( angle ) * Distance
	  	
	  	If ( ( i > num_Particles - num_edges )  ) Then P->inverse_mass = 0.0
	  	
	  	If (i >= num_Particles - num_edges ) Then 
	  	
	  		Distance = screen_hgt * 0.5 + ( Rnd() - Rnd() ) * 16.0
	  	
	  	Else
	  	
	  		Distance += delta_step + ( Rnd() - Rnd() ) * delta_step * 3.0
	  	
	  	End If
	  	
	Next
	
	''  create spiraling springs
	For i As Integer = 1 To num_Particles - num_edges - 1
		
		'If ( Rnd() > 0.02 ) THen
		
		Dim As SpringType Ptr S = CreateSpring()
		
		S->particle_a    = @particle( i )
		S->particle_b    = @particle( i + 1 )
		
		S->rest_distance = ( S->particle_b->position - S->particle_a->position ).length()' * 0.5
		
		Dim As Single inverseMass = S->particle_a->inverse_mass + S->particle_b->inverse_mass
		
		S->reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
		
		'End If
			
	Next
	
		''  create radiating springs
	For i As Integer = 1 To num_particles - num_edges 
			
			Dim As SpringType Ptr S = CreateSpring()
			
			S->particle_a    = @particle( i )
			S->particle_b    = @particle( i + num_edges )
			
			S->rest_distance = ( S->particle_b->position - S->particle_a->position ).length()
			
			Dim As Single inverseMass = S->particle_a->inverse_mass + S->particle_b->inverse_mass
			
			S->reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
			
		'Next
	Next
	
End Sub


'' Core physics functions
Sub SimulationType.ComputeRestforce()
	
	'' Compute the exact force needed to satisfy the constraint in one loop
	
	For S As SpringType Ptr = SpringLo To SpringHi
	
		Dim As Vec2 distance_vector = S->particle_b->position - S->particle_a->position
		Dim As Vec2 velocity_vector = S->particle_b->velocity - S->particle_a->velocity
		
		S->unit = distance_vector.Unit()
		
		Dim As Single distance_error = S->unit.dot( distance_vector ) - S->rest_distance
		Dim As Single velocity_error = S->unit.dot( velocity_vector )
		
		S->rest_force = - cstiffness * distance_error * inv_dt2 - cdamping * velocity_error * inv_dt
		'S->rest_force = -( cstiffnes * distance_error * inv_dt2 + cdamping * velocity_error * inv_dt ) * S->reduced_mass
			
	Next
	
End Sub

Sub SimulationType.ApplyCorrectiveforce()
	
	'' Apply the difference between rest force and current force.
	'' Accumulate applied forces for warmstarting next loop.
	
	For S As SpringType Ptr = SpringLo To SpringHi
	
		Dim As Vec2 force_vector = S->particle_b->force - S->particle_a->force
		
		Dim As Single force_error = S->unit.dot( force_vector ) - S->rest_force
		
	   Dim As Vec2 corrective_force = - force_error * S->reduced_mass * S->unit
		'Dim As Vec2 corrective_force = - force_error * S->unit
		
		S->particle_a->force -= corrective_force * S->particle_a->inverse_mass
		S->particle_b->force += corrective_force * S->particle_b->inverse_mass
		
		S->accumulated_force += corrective_force
		
	Next
	
End Sub

Sub SimulationType.ApplyWarmStart()
	
	'' Warm starting. Use the sum of previously applied forces
	'' projected onto new normal vector as initial iteration value.
	''	This is roughly equivalent of doubling the number of iterations.
	
	For S As SpringType Ptr = SpringLo To SpringHi
		
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
	
	For P As ParticleType Ptr = ParticleLo To ParticleHi
		
		If ( P->inverse_mass > 0.0 ) Then
			
			P->velocity += Vec2( 0.0, dt * gravity )
		
			'P->velocity += P->force * P->inverse_mass * dt
			P->velocity += P->force * dt
			P->position += P->velocity * dt 
		
		End If
		
		P->force = Vec2( 0.0, 0.0 )
		
	Next

End Sub

'' Graphics and interaction
Sub SimulationType.UpdateScreen()
	
	ScreenLock
		
		Cls
		
		''
		Locate  2, 2: Print "Press F1 - F8 for demos, 1 - 9 for number of iterations, space bar for warmstart, left mouse for pickup."
		Locate  6, 2: Print DemoText
		Locate 10, 2: Print Using "(I)terations ###"; iterations
		Locate 12, 2: Print Using "(S)tiffness  #.##"; cStiffness
		Locate 14, 2: Print Using "(D)amping    #.##"; cDamping
		Locate 16, 2: Print Using "(W)armstart  #.##"; cWarmstart
		Locate 16, 20: If ( warmstart = 1 ) Then Print "(On)" Else Print "(Off)"
		
		''  draw particles background
		For P As ParticleType Ptr = ParticleLo To ParticleHi
			
			If ( P->radius > 0.0 ) Then
				
				Circle(P->position.x, P->position.y), P->radius + 5, RGB(0, 0, 0) ,,, 1, f
				
			End If
			
		Next
		
		''  draw springs 
		For S As SpringType Ptr = SpringLo To SpringHi
			
			Line(S->particle_a->position.x, S->particle_a->position.y)-_
				 (S->particle_b->position.x, S->particle_b->position.y), RGB(0, 255, 0)
			
		Next
		
		''	draw particles foreground
		For P As ParticleType Ptr = ParticleLo To ParticleHi
			
			If ( P->radius > 0.0 ) Then
				
				Dim As UInteger Col = IIf( P->inverse_mass = 0.0, RGB(160, 160, 160), RGB(255, 0, 0) )
				
				Circle(P->position.x, P->position.y), P->radius, Col,,, 1, f
			
			Else
				
				Dim As UInteger Col = IIf( P->inverse_mass = 0.0, RGB(160, 160, 160), RGB(128, 255, 0) )
				
				Circle(P->position.x, P->position.y), 2, Col,,, 1, f
				
			End If
			
		Next
		
		If ( Nearest <> 0 ) Then Circle(Nearest->position.x, Nearest->position.y), Nearest->radius + 8, RGB(255, 255, 255),,, 1
		If ( Picked <> 0 ) Then Circle(Picked->position.x, Picked->position.y), Picked->radius + 8, RGB(255, 255, 0),,, 1
		
	ScreenUnLock
	
End Sub

Sub SimulationType.CreateScreen( ByVal Wid As Integer, ByVal Hgt As Integer )
   
   ScreenRes Wid, Hgt, 24,, fb.GFX_ALPHA_PRIMITIVES
   
   WindowTitle "Mike's sequential force demo."
   
   Color RGB( 255, 160, 160 ), RGB( 64, 64, 64 )
   
End Sub


Sub SimulationType.UpdateInput()
	
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
	MinDist  = pick_distance
	
	nearest = 0
	
	If ( picked = 0 ) Then
	
		For P As ParticleType Ptr = ParticleLo To ParticleHi
			
			DistanceVector = P->Position - Vec2( Cast( Single, mouse_x) , Cast( Single, mouse_y ) )
			Distance = DistanceVector.LengthSquared()
			
			If ( Distance < MinDist ) Then
				
				MinDist = Distance
				nearest = P
				
			EndIf
			
		Next
	
	End If
	
	If ( button = 1 And button_prev = 0 ) Then picked = nearest
	
	If ( button = 0 ) Then picked = 0

	
	''
	If ( picked <> 0 ) Then
	
		picked->position.x += ( position.x - position_prev.x )
		picked->position.y += ( position.y - position_prev.y )
		
		picked->velocity.x = ( position.x - position_prev.x ) * dt
		picked->velocity.y = ( position.y - position_prev.y ) * dt
		
	End If
	
	If ( ScreenEvent( @e ) ) Then
		
		Select Case e.type
		
		Case fb.EVENT_KEY_PRESS
			
			If ( e.scancode = fb.SC_F1 ) Then Demo1()
			If ( e.scancode = fb.SC_F2 ) Then Demo2()
			If ( e.scancode = fb.SC_F3 ) Then Demo3()
			If ( e.scancode = fb.SC_F4 ) Then Demo4()
			If ( e.scancode = fb.SC_F5 ) Then Demo5()
			If ( e.scancode = fb.SC_F6 ) Then Demo6()
			If ( e.scancode = fb.SC_F7 ) Then Demo7()
			If ( e.scancode = fb.SC_F8 ) Then Demo8()
			
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
	If MultiKey( fb.SC_3 ) Then iterations = 4
	If MultiKey( fb.SC_4 ) Then iterations = 8
	If MultiKey( fb.SC_5 ) Then iterations = 16
	If MultiKey( fb.SC_6 ) Then iterations = 32
	If MultiKey( fb.SC_7 ) Then iterations = 64
	If MultiKey( fb.SC_8 ) Then iterations = 128
	If MultiKey( fb.SC_9 ) Then iterations = 256
	
End Sub

Sub SimulationType.ClearParticles()
	
	numParticles = 0
	
	ParticleLo = @Particle( 0 )
	ParticleHi = @Particle( 0 )
	
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
	
	numSprings = 0
	
	SpringLo = @spring( 0 )
	SpringHi = @spring( 0 )
	
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

Function SimulationType.CreateParticle() As ParticleType Ptr
	
	If ( numParticles < max_Particles - 1 ) Then
		
		numParticles += 1
		
		ParticleLo = @Particle( 1 )
		ParticleHi = @Particle( numParticles )
		
		Return ParticleHi
		
	End If
	
End Function

Function SimulationType.CreateSpring() As SpringType Ptr
	
	If ( numSprings < max_Springs - 1 ) Then
		
		numSprings += 1
		
		SpringLo = @spring( 1 )
		SpringHi = @spring( numSprings )
		
		Return SpringHi 
		
	End If
	
End Function
