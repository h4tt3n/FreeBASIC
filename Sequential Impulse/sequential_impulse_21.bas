''*******************************************************************************
''
''  Stable damped springs using sequential impulses and warmstart
''
''  Version 0.21, May 2016, Michael "h4tt3n" Nissen
''
''  This version onwards include angular springs.
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
#Include Once "../Math/Vector2.bi"


''   Global constants
Const As Single  dt                 = 1.0 / 60.0       ''  timestep
Const As Single  inv_dt             = 1.0 / dt         ''  inverse timestep
Const As Single  gravity            = 10.0             ''  gravity
Const As Single  density            = 0.05             ''  ball density
Const As Single  pi                 = 4.0 * Atn( 1.0 ) ''  pi
Const As Integer screen_wid         = 1000             ''  screen width
Const As Integer screen_hgt         = 800              ''  screen height
Const As Integer pick_distance      = 128^2            ''  mouse pick up distance
Const As Integer max_particles      = 2048             ''  particles
Const As Integer max_springs        = 4096             ''  springs
Const As Integer max_angularsprings = 4096             ''  angular springs


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
	
	As Vec2 position
	As Vec2 velocity
	
	As Single  reduced_mass
	As Single  rest_distance
	As Single  rest_impulse
	As Single  inertia
	As Single  inverse_inertia
	As Single  angular_velocity
	
	As Vec2 accumulated_impulse
	As Vec2 unit
	
	As ParticleType Ptr particle_a
	As ParticleType Ptr particle_b
  
End Type

Type AngularSpringType
	
	Declare Constructor()
	
	As Single  reduced_inertia
	As Single  rest_impulse
	As Single  accumulated_impulse
	
	As Vec2 angle
	As Vec2 rest_angle
	
	As SpringType Ptr spring_a
	As SpringType Ptr spring_b
  
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
	
	Declare Sub CreateScreen( ByVal Wid As Integer, ByVal Hgt As Integer )
	
	Declare Function CreateParticle() As ParticleType Ptr
	Declare Function CreateSpring() As SpringType Ptr
	Declare Function CreateAngularSpring() As AngularSpringType Ptr
	
	Declare Sub ClearParticles()
	Declare Sub ClearSprings()
	Declare Sub ClearAngularSprings()
	
	Declare Sub UpdateInput()
	Declare Sub UpdateScreen()
	
	Declare Sub RunSimulation()

	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	Declare Sub ComputeRestimpulse()
	Declare Sub ComputeNewState()
	
	As fb.EVENT e
	
	As String DemoText
	
	As Integer iterations
	As Integer warmstart
	As Integer numParticles
	As Integer numSprings
	As Integer numAngularSprings
	
	As Single cStiffness
	As Single cDamping
	As Single cWarmstart
	
	As Single cAstiffness
	As Single cAdamping
	As Single cAwarmstart
	
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
	
	As AngularSpringType Ptr AngularSpringLo
	As AngularSpringType Ptr AngularSpringHi
	
	As ParticleType      particle      ( 1 To max_particles )
	As SpringType        spring        ( 1 To max_springs )
	As AngularSpringType angularspring ( 1 To max_angularsprings )

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
	impulse      = Vec2( 0.0, 0.0 )
	
End Constructor

Constructor SpringType()
	
	particle_a          = 0
	particle_b          = 0
	reduced_mass        = 0.0
	rest_distance       = 0.0
	rest_impulse        = 0.0
	accumulated_impulse = Vec2( 0.0, 0.0 )
	unit                = Vec2( 0.0, 0.0 )
	
End Constructor

Constructor AngularSpringType()
	
	spring_a            = 0
	spring_b            = 0
	reduced_inertia     = 0.0
	rest_impulse        = 0.0
	accumulated_impulse = 0.0
	angle               = Vec2( 0.0, 0.0 )
	rest_angle          = Vec2( 0.0, 0.0 )
	
End Constructor

Constructor SimulationType()
	
	ClearParticles()
	ClearSprings()
	ClearAngularSprings()
	
	CreateScreen( screen_wid, screen_hgt )
	
	Demo2()
	
	RunSimulation()
	
End Constructor


''	Main loop
Sub SimulationType.RunSimulation()
	
	Do
		
		UpdateScreen()
		
		'Sleep 0, 1
		
		UpdateInput()
		
		'' gravity
		For P As ParticleType Ptr = ParticleLo To ParticleHi
		
			If ( P->inverse_mass > 0.0 ) Then
				
				P->velocity += Vec2( 0.0, dt * gravity )
				
			End If
			
		Next
		
		''
		ComputeRestimpulse()		
		
		''
		If warmstart = 1 Then 
			
			ApplyWarmStart()
			
		Else
			
			For S As SpringType Ptr = SpringLo To SpringHi
			
				S->accumulated_impulse = Vec2( 0.0, 0.0 )
				
			Next
			
		EndIf
		
		''
		For i As Integer = 1 To iterations
		
			ApplyCorrectiveImpulse()
		
		Next
		
		''
		ComputeNewState()
		
	Loop

End Sub


'' Demos
Sub SimulationType.Demo1()
	
	'' Wrecking ball
	
	iterations   = 1
	warmstart    = 0
	cStiffness   = 1.0    
	cDamping     = 1.0
	cWarmstart   = 0.0
	
	Dim As Integer num_Particles       = 2
	Dim As Integer num_Springs         = 1
	Dim As Integer num_angular_Springs = 1
	Dim As Integer SpringLength        = 450 
	
	DemoText = "Demo 1: Wrecking ball. The ball weighs 10000 kg, but there is no spring deformation, and no loss of energy or momentum."
	
	''
	ClearParticles()
	ClearSprings()
	ClearAngularSprings()
	
	'' create particles
	Dim As particletype Ptr P = CreateParticle()
		
	P->mass         = 1.0
	P->inverse_mass = 0
	P->radius       = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
	P->position.x   = 0.5 * screen_wid
	P->position.y   = 0.2 * screen_hgt
	
	For i As integer = 2 To num_Particles
		
		Dim As particletype Ptr P = CreateParticle()
		
		P->mass         = 1.0
		P->inverse_mass = 1.0 / P->mass
		P->radius       = 0.0
		
		If i = num_Particles Then
			
			P->mass = 10000.0
			P->inverse_mass = 1.0 / P->mass
			P->radius = 24'( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
			
		EndIf
		
		P->position.x   = 0.5 * screen_wid + ( i - 1 ) * SpringLength
		P->position.y   = 0.2 * screen_hgt + 100 * i
		
	Next
	
	''  create springs
	For i As Integer = 1 To num_Springs
		
		Dim As SpringType Ptr S = CreateSpring()
				
		S->particle_a    = @particle( i )
		S->particle_b    = @particle( i + 1 )
		S->rest_distance = ( S->particle_b->position - S->particle_a->position ).length()
		S->unit          = ( S->particle_b->position - S->particle_a->position ).unit()
		
		Dim As Single inverseMass = S->particle_a->inverse_mass + S->particle_b->inverse_mass
		
		S->reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
		
	Next
	
	For i As Integer = 1 To num_angular_Springs
		
		Dim As AngularSpringType Ptr A = CreateAngularSpring()
		
		A->spring_a = @spring( i )
		A->spring_b = @spring( i + 1 )
		
		A->rest_angle = Vec2( A->spring_b->unit.dot( A->spring_a->unit ), _
		                      A->spring_b->unit.perpdot( A->spring_a->unit ) )
		
	Next

End Sub

Sub SimulationType.Demo2()
	
	'' Wrecking ball
	
	iterations   = 1
	warmstart    = 0
	cStiffness   = 0.1    
	cDamping     = 0.5
	cWarmstart   = 0.0
	
	Dim As Integer num_Particles       = 8
	Dim As Integer num_Springs         = 7
	Dim As Integer num_angular_Springs = 6
	Dim As Integer SpringLength        = 50 
	
	DemoText = "Demo 2: Wrecking ball. The ball weighs 2000 times more than the smaller masses, but there is no visible deformation."
	
	''
	ClearParticles()
	ClearSprings()
	ClearAngularSprings()
	
	'' create particles
	Dim As particletype Ptr P = CreateParticle()
		
	P->mass         = 1.0
	P->inverse_mass = 0.0'1.0 / P->mass
	P->radius       = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
	P->position.x   = 0.5 * screen_wid
	P->position.y   = 0.2 * screen_hgt
	
	For i As integer = 2 To num_Particles
		
		Dim As particletype Ptr P = CreateParticle()
		
		P->mass         = 1.0 + Rnd() * 10
		P->inverse_mass = 1.0 / P->mass
		P->radius       = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
		
		'If i = num_Particles Then
		'	
		'	P->mass = 2000.0
		'	P->inverse_mass = 1.0 / P->mass
		'	P->radius = 24'( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
		'	
		'EndIf
		
		P->position.x   = 0.5 * screen_wid + ( i - 1 ) * SpringLength
		P->position.y   = 0.2 * screen_hgt + 20 * ( i - 1 )
		
		'P->velocity += Vec2().randomizecircle( 1.0 )
		
	Next
	
	''  create springs
	For i As Integer = 1 To num_Springs
		
		Dim As SpringType Ptr S = CreateSpring()
				
		S->particle_a    = @particle( i )
		S->particle_b    = @particle( i + 1 )
		S->rest_distance = 40 + Rnd() * 60'( S->particle_b->position - S->particle_a->position ).length()
		S->unit          = ( S->particle_b->position - S->particle_a->position ).unit()
		
		Dim As Single inverseMass = S->particle_a->inverse_mass + S->particle_b->inverse_mass
		
		S->reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
		
	Next
	
	For i As Integer = 1 To num_angular_Springs
		
		Dim As AngularSpringType Ptr A = CreateAngularSpring()
		
		A->spring_a = @spring( i )
		A->spring_b = @spring( i + 1 )
		
		A->rest_angle = Vec2( A->spring_b->unit.dot( A->spring_a->unit ), _
		                      A->spring_b->unit.perpdot( A->spring_a->unit ) )
		
	Next

	
End Sub

Sub SimulationType.Demo3()
	
	'' Horizontal steel girder
	
	iterations   = 10
	warmstart    = 1
	cStiffness   = 1.0    
	cDamping     = 1.0
	cWarmstart   = 1.0
	
	Dim As Integer GirderWidth  = 2
	Dim As Integer GirderLength = 22
	Dim As Integer SpringLength = 40
	
	DemoText = "Demo 3: Horizontal steel girder. Connecting springs at right angles increases stability. (And NO dirty thoughts!)"
	
	''
	ClearParticles()
	ClearSprings()
	ClearAngularSprings()
	
	''	particles
	for i as integer = 1 to GirderLength
		for j as integer = 1 to GirderWidth
		
			Dim As particletype Ptr P = CreateParticle()
			
			P->mass         = 1.0
			P->inverse_mass = 1.0 / P->mass
			P->radius       = 0.0
			P->position.x   = 0.1 * screen_wid + (i-1) * SpringLength 
			P->position.y   = 0.4 * screen_hgt + (j-1) * SpringLength
		  	
		  	If ( i = 1 ) Then 
		  		
		  		P->inverse_mass = 0.0
		  		P->radius       =( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
		  		
		  	EndIf
		  	
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

Sub SimulationType.Demo4()
	
	'' Vertical steel girder
	
	iterations   = 10
	warmstart    = 1
	cStiffness   = 1.0    
	cDamping     = 1.0
	cWarmstart   = 1.0
	
	Dim As Integer GirderWidth  = 2
	Dim As Integer GirderLength = 32
	Dim As Integer SpringLength = 20
	
	DemoText = "Demo 4: Vertical steel mast fighting gravity. Turn warmstart off and set iterations to 1 to see 'regular' springs."
	
	''
	ClearParticles()
	ClearSprings()
	ClearAngularSprings()
	
	''	particles
	for i as integer = 1 to GirderLength
		for j as integer = 1 to GirderWidth
		
			Dim As particletype Ptr P = CreateParticle()
			
			P->mass         = 1.0
			P->inverse_mass = 1.0 / P->mass
			P->radius       = 0.0
			P->position.x   = 0.5 * screen_wid + (j-1) * SpringLength + (j - 1.5 ) * ( GirderLength - 8 - i )
			P->position.y   = 0.9 * screen_hgt - (i-1) * SpringLength '( j -1 ) * SpringLength * 0.5
		  	
		  	If ( i = 1 ) Then 
		  		
		  		P->inverse_mass = 0.0
		  		P->radius       =( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
		  		
		  	EndIf
		  	
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
		
		Dim As Single im = S->particle_a->inverse_mass + S->particle_b->inverse_mass
		
		S->reduced_mass  = IIf( im > 0.0 , 1.0 / im , 0.0 )
		
	Next
	
End Sub

Sub SimulationType.Demo5()
	
	'' Rigid chain stabilization
	
	iterations   = 10
	warmstart    = 1
	cStiffness   = 0.5    
	cDamping     = 1.0
	cWarmstart   = 0.5
	
	Dim As Integer num_Particles = 96
	Dim As Integer num_Springs   = 95
	
	DemoText = "Demo 5: Stability test. The particles are assigned a random position and velocity, but the rope stabilizes very fast."
	
	''
	ClearParticles()
	ClearSprings()
	ClearAngularSprings()
	
	Randomize Timer
	
	Dim As particletype Ptr P = CreateParticle()
	
	P->mass         = 1.0 
	P->inverse_mass = 0.0
	P->radius       = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
	P->position.x   = 0.5 * screen_wid
	P->position.y   = 0.2 * screen_hgt
	
	'' create particles
	For i As Integer = 2 To num_Particles
		
		P = CreateParticle()
		
		P->mass         = 1.0 '+ ( Rnd() * 100.0 ^ (1/3)  ) ^ 3
		P->inverse_mass = 1.0 / P->mass
		P->radius       = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
		
		P->position.x   = Rnd() * screen_wid
		P->position.y   = Rnd() * screen_hgt
		
		'P->position.x   = 0.5 * screen_wid + ( Rnd() - Rnd() ) * state 
		'P->position.y   = 0.5 * screen_hgt + ( Rnd() - Rnd() ) * state
		
		P->velocity.x   = ( Rnd() - Rnd() ) * 1000 
		P->velocity.y   = ( Rnd() - Rnd() ) * 1000
		
	Next
	
	''  create springs
	For i As Integer = 1 To num_springs
		
		Dim As SpringType Ptr S = CreateSpring()
		
		S->particle_a    = @particle( i )
		S->particle_b    = @particle( i + 1 )
		S->rest_distance = S->particle_b->radius + S->particle_a->radius
		
		Dim As Single inverseMass = S->particle_a->inverse_mass + S->particle_b->inverse_mass
		S->reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
	
	Next
	
End Sub

Sub SimulationType.Demo6()
	
	'' Suspension bridge
	
	iterations   = 10
	warmstart    = 1
	cStiffness   = 1.0    
	cDamping     = 1.0
	cWarmstart   = 1.0
	
	Dim As Integer num_Particles = 48
	Dim As Integer num_Springs   = 47
	
	DemoText = "Demo 6: Suspension bridge."
	
	''
	ClearParticles()
	ClearSprings()
	ClearAngularSprings()
	
	Randomize Timer
	
	Dim As particletype Ptr P = CreateParticle()
	
	P->mass         = 1.0
	P->inverse_mass = 0.0
	P->radius       = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
	P->position.x   = 50
	P->position.y   = 0.3 * screen_hgt
	
	'' create particles
	For i As Integer = 2 To num_Particles - 1
		
		P = CreateParticle()
		
		P->mass         = 1.0' + ( Rnd() * 99.0 ^ (1/3)  ) ^ 3
		P->inverse_mass = 1.0 / P->mass
		P->radius       = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
		
		P->position.x   = i * ( ( screen_Wid - 100 ) / ( num_particles - 1 ) ) + 30
		P->position.y   = 0.3 * screen_hgt
		
	Next
	
	P = CreateParticle()
	
	P->mass         = 1.0
	P->inverse_mass = 0.0
	P->radius       = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
	P->position.x   = screen_wid - 50
	P->position.y   = 0.3 * screen_hgt
	
	''  create springs
	For i As Integer = 1 To num_springs
		
		Dim As SpringType Ptr S = CreateSpring()
		
		S->particle_a    = @particle( i )
		S->particle_b    = @particle( i + 1 )
		S->rest_distance = length(S->particle_b->position - S->particle_a->position)
		
		Dim As Single inverseMass = S->particle_a->inverse_mass + S->particle_b->inverse_mass
		S->reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
	
	Next
	
End Sub

Sub SimulationType.Demo7()
	
	'' Horizontal steel girder
	
	iterations   = 10
	warmstart    = 1
	cStiffness   = 1.0    
	cDamping     = 1.0
	cWarmstart   = 1.0
	
	Dim As Integer GirderWidth  = 2
	Dim As Integer GirderLength = 18
	Dim As Integer SpringLength = 50
	
	DemoText = "Demo 3: Truss bridge."
	
	''
	ClearParticles()
	ClearSprings()
	ClearAngularSprings()
	
	''	particles
	for i as integer = 1 to GirderLength
		for j as integer = 1 to GirderWidth
		
			Dim As particletype Ptr P = CreateParticle()
			
			P->mass         = 1.0
			P->inverse_mass = 1.0 / P->mass
			P->radius       = 0.0
			P->position.x   = 0.1 * screen_wid + (i-1) * SpringLength 
			P->position.y   = 0.4 * screen_hgt + (j-1) * SpringLength
		  	
		  	If ( (i = GirderLength) And (j = GirderWidth) ) Then 
		  		
		  		P->inverse_mass = 0.0
		  		P->radius       =( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
		  		
		  	EndIf
		  	
		  	If ( (i = 1) And (j = GirderWidth) ) Then 
		  		
		  		P->inverse_mass = 0.0
		  		P->radius       =( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
		  		
		  	EndIf
		  	
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
	
	''  bottom-right to top-left diagonal springs
	for i as integer = 1 to GirderWidth - 1
		For j as integer = 2 to GirderLength-1 
			
			Dim As SpringType Ptr S = CreateSpring()
			
			S->particle_a = @particle(i+(j-1)*GirderWidth)
			S->particle_b = @particle(j*GirderWidth+i+1)
			
		Next
	Next
	
	''  bottom-left to top-right diagonal springs
	for i as integer = 1 to GirderWidth - 1
		For j as integer = 1 to GirderLength-2 
			
			Dim As SpringType Ptr S = CreateSpring()
			
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



'' Core physics functions
Sub SimulationType.ComputeRestimpulse()
	
	'' pre-compute linear spring state vectors
	'' pre-compute linear spring moment of inertia
	'' pre-compute linear spring angular velocity
	
	'' pre-compute angular spring rest impulse
	
	
	'' Compute the impulse needed to satisfy the constraint in one loop
	
	''	Linear springs
	For S As SpringType Ptr = SpringLo To SpringHi
		
		Dim As Vec2 distance = S->particle_b->position - S->particle_a->position
		Dim As Vec2 velocity = S->particle_b->velocity - S->particle_a->velocity
		
		S->unit = distance.Unit()
		
		Dim As Single distance_error = S->unit.dot( distance ) - S->rest_distance
		Dim As Single velocity_error = S->unit.dot( velocity )
		
		S->rest_impulse = -cstiffness * distance_error * inv_dt - cdamping * velocity_error
		
		'' for angular springs
		
		''
		If ( S->particle_a->inverse_mass = 0.0 ) Then
			
			S->position = S->particle_a->position
			S->velocity = Vec2( 0.0, 0.0 )
			
		ElseIf ( S->particle_b->inverse_mass = 0.0 ) Then
			
			S->position = S->particle_b->position
			S->velocity = Vec2( 0.0, 0.0 )
			
		Else
			
			S->position = ( S->particle_a->position * S->particle_a->mass + _
		                   S->particle_b->position * S->particle_b->mass ) / _
		                  ( S->particle_a->mass + S->particle_b->mass )
			
			S->velocity = ( S->particle_a->velocity * S->particle_a->mass + _
		                   S->particle_b->velocity * S->particle_b->mass ) / _
		                   ( S->particle_a->mass + S->particle_b->mass )
			
		End If
		
		''
		S->inertia = ( S->particle_a->position - S->position ).lengthsquared() * S->particle_a->mass + _
		             ( S->particle_b->position - S->position ).lengthsquared() * S->particle_b->mass
		
		
		S->inverse_inertia = IIf( S->inertia > 0.0 , 1.0 / S->inertia, 0.0 )
		
		''
		Dim As Vec2 localPositionA = S->Particle_a->Position - S->Position
		Dim As Vec2 localPositionB = S->Particle_b->Position - S->Position
		
		Dim As Vec2 localVelocityA = S->Particle_a->Velocity - S->Velocity
		Dim As Vec2 localVelocityB = S->Particle_b->Velocity - S->Velocity
	
		S->angular_velocity =  ( localPositionA.PerpDot( localVelocityA * S->particle_a->mass ) + _
	                            localPositionB.PerpDot( localVelocityB * S->particle_b->Mass ) ) * _
	                            S->inverse_inertia
		
		
	Next
	
	'' Angular springs
	For A As AngularSpringType Ptr = AngularSpringLo To AngularSpringHi
		
		''
		A->angle = Vec2( A->spring_b->unit.dot( A->spring_a->unit ), _
		                 A->spring_b->unit.perpdot( A->spring_a->unit ) )
		
		''
		'Dim As Single angle_error    = ATan2 ( A->angle.perpdot( A->rest_angle ), A->angle.dot( A->rest_angle ) )
		Dim As Single angle_error    = A->angle.perpdot( A->rest_angle )
		
		Dim As Single velocity_error = A->spring_b->angular_velocity - A->spring_a->angular_velocity
		
		''
		Dim As Single inverse_inertia = A->spring_a->inverse_inertia + A->spring_b->inverse_inertia
		
		'A->reduced_inertia = 2.0'IIf( inverse_inertia > 0.0 , 1.0 / inverse_inertia , 0.0 )
		A->reduced_inertia = IIf( inverse_inertia > 0.0 , 1.0 / inverse_inertia , 0.0 )
		
		''
		A->rest_impulse = 0.0' -angle_error * inv_dt * 0.000001 - velocity_error * 0.000001
		
	Next
	
End Sub

Sub SimulationType.ApplyCorrectiveimpulse()
	
	''	compute linear spring angular impulse from endpoint mass linear impulses
	'' compute angular impulse error and corrective angular impulse
	'' compute linear impulses from corrective angular impulse
	
	'' Apply the difference between rest impulse and current impulse.
	'' Accumulate applied impulses for warmstarting the next loop.
	
	''
	For S As SpringType Ptr = SpringLo To SpringHi
	
		Dim As Vec2 current_impulse = S->particle_b->impulse - S->particle_a->impulse
		
		Dim As Single impulse_error = S->unit.dot( current_impulse ) - S->rest_impulse
		
	   Dim As Vec2 corrective_impulse = -impulse_error * S->reduced_mass * S->unit
		
		S->particle_a->impulse -= corrective_impulse * S->particle_a->inverse_mass
		S->particle_b->impulse += corrective_impulse * S->particle_b->inverse_mass
		
		S->accumulated_impulse += corrective_impulse
		
	Next
	
	'' Angular springs
	For A As AngularSpringType Ptr = AngularSpringLo To AngularSpringHi
		
			'Dim As Vec2 LocalPositionA = Position_ - ParticleA_->Position
			'Dim As Vec2 LocalPositionB = Position_ - ParticleB_->Position
			'
			'Dim As Single LocalImpulseA = LocalPositionA.PerpDot( ParticleA_->Impulse )
			'Dim As Single LocalImpulseB = LocalPositionB.PerpDot( ParticleB_->Impulse )
			'
			'AngularImpulse_ += LocalImpulseA * ParticleA_->Mass * inverseInertia_
			'AngularImpulse_ += LocalImpulseB * ParticleB_->Mass * inverseInertia_
		
		
		''
		Dim As Single angular_impulse_aa = A->spring_a->unit.perpdot( A->spring_a->particle_a->impulse )
		Dim As Single angular_impulse_ab = A->spring_a->unit.perpdot( A->spring_a->particle_b->impulse )
		
		Dim As Single angular_impulse_ba = A->spring_b->unit.perpdot( A->spring_b->particle_a->impulse )
		Dim As Single angular_impulse_bb = A->spring_b->unit.perpdot( A->spring_b->particle_b->impulse )
		
		''
		Dim As Single current_angular_impulse = ( angular_impulse_ab + angular_impulse_aa ) - ( angular_impulse_bb + angular_impulse_ba )
		
		''
		Dim As Single angular_impulse_error = current_angular_impulse - A->rest_impulse
		
		''
		Dim As Single corrective_angular_impulse = angular_impulse_error * A->reduced_inertia
		
		''
		Dim As Single impulse_a =  corrective_angular_impulse * A->spring_a->inverse_inertia
		Dim As Single impulse_b =  corrective_angular_impulse * A->spring_b->inverse_inertia
		
		A->spring_a->particle_a->impulse += A->spring_a->unit.perp() * impulse_a
		A->spring_a->particle_b->impulse -= A->spring_a->unit.perp() * impulse_a
		
		A->spring_b->particle_a->impulse -= A->spring_b->unit.perp() * impulse_b
		A->spring_b->particle_b->impulse += A->spring_b->unit.perp() * impulse_b
		
		A->accumulated_impulse += corrective_angular_impulse
		
			'Dim As Vec2 LocalPositionA = Position_ - ParticleA_->Position
			'Dim As Vec2 LocalPositionB = Position_ - ParticleB_->Position
			'
			'Dim As Vec2 LocalImpulseA = LocalPositionA.PerpDot( AngularImpulse_ )
			'Dim As Vec2 LocalImpulseB = LocalPositionB.PerpDot( AngularImpulse_ )
			'
			'ParticleA_->addImpulse( LocalImpulseA )
			'ParticleB_->addImpulse( LocalImpulseB )
		
	Next
	
End Sub

Sub SimulationType.ApplyWarmStart()
	
	'' Warm starting. Use the sum of previously applied impulses
	'' projected onto new normal vector as initial iteration value.
	''	This is roughly equivalent of doubling the number of iterations.
	
	''
	For S As SpringType Ptr = SpringLo To SpringHi
		
		Dim As Single projected_impulse = S->unit.dot( S->accumulated_impulse )
		
		If ( projected_impulse < 0.0 ) Then
			
			Dim As Vec2 warmstart_impulse = cwarmstart * projected_impulse * S->unit
			
			S->particle_a->impulse -= warmstart_impulse * S->particle_a->inverse_mass 
			S->particle_b->impulse += warmstart_impulse * S->particle_b->inverse_mass
			
		End If
		
		S->accumulated_impulse = Vec2( 0.0, 0.0 )
		
	Next
	
	'' Angular springs
	For A As AngularSpringType Ptr = AngularSpringLo To AngularSpringHi
		
		A->accumulated_impulse = 0.0
		
	Next
	
End Sub

Sub SimulationType.ComputeNewState()
	
	''	Compute new state vectors
	
	For P As ParticleType Ptr = ParticleLo To ParticleHi
		
		If ( P->inverse_mass > 0.0 ) Then
			
			P->velocity += P->impulse
			P->position += P->velocity * dt 
			
		End If
		
		P->impulse = Vec2( 0.0, 0.0 )
		
	Next

End Sub

'' Graphics and interaction
Sub SimulationType.UpdateScreen()
	
	ScreenLock
		
		Cls
		
		''
		Locate  4, 2: Print DemoText
		Locate  8, 2: Print Using "(I)terations ###"; iterations
		Locate 10, 2: Print Using "(S)tiffness  #.##"; cStiffness
		Locate 12, 2: Print Using "(D)amping    #.##"; cDamping
		
		If ( warmstart = 0 ) Then 
			
			Locate 14, 2: Print "(W)armstart  OFF"
			
		Else
			
			Locate 14, 2: Print Using "(W)armstart  #.##"; cWarmstart
			
		EndIf
		
		'Locate 16, 2: Print SpringLo->inertia
		Locate 16, 2: Print SpringLo->angular_velocity
		'Locate 16, 2: Print SpringLo->inverse_inertia
		'Locate 16, 2: Print AngularSpringLo->angle.x
		Locate 17, 2: Print ( AngularSpringLo->spring_a->inertia * AngularSpringLo->spring_b->inertia ) / _
		                      ( AngularSpringLo->spring_a->inertia + AngularSpringLo->spring_b->inertia )
		
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
			
			Circle(S->position.x, S->position.y), 2.2, RGB( 160, 160, 160 ),,, 1, f
			
		Next
		
		''	draw particles foreground
		For P As ParticleType Ptr = ParticleLo To ParticleHi
			
			If ( P->radius > 0.0 ) Then
				
				Dim As UInteger Col = IIf( P->inverse_mass = 0.0, RGB(160, 160, 160), RGB(255, 0, 0) )
				
				Circle(P->position.x, P->position.y), P->radius, Col,,, 1, f
				
			Else
				
				Dim As UInteger Col = IIf( P->inverse_mass = 0.0, RGB(160, 160, 160), RGB(128, 255, 0) )
				
				Circle(P->position.x, P->position.y), 2.2, Col,,, 1, f
				
			End If
			
		Next
		
		If ( Nearest <> 0 ) Then Circle(Nearest->position.x, Nearest->position.y), Nearest->radius + 8, RGB(255, 255, 255),,, 1
		If ( Picked <> 0 ) Then Circle(Picked->position.x, Picked->position.y), Picked->radius + 8, RGB(255, 255, 0),,, 1
		
	ScreenUnLock
	
End Sub

Sub SimulationType.CreateScreen( ByVal Wid As Integer, ByVal Hgt As Integer )
   
   ScreenRes Wid, Hgt, 32,, fb.GFX_ALPHA_PRIMITIVES
   
   WindowTitle "Mike's iterative spring demo. See source for controls."
   
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
	
	If iterations < 1 Then iterations = 1
	
	If cStiffness < 0.0 Then cStiffness = 0.0
	If cStiffness > 1.0 Then cStiffness = 1.0
	
	If cDamping < 0.0 Then cDamping = 0.0
	If cDamping > 1.0 Then cDamping = 1.0
	
	If cWarmstart < 0.0 Then cWarmstart = 0.0
	If cWarmstart > 1.0 Then cWarmstart = 1.0
	
End Sub


'' Memory management
Sub SimulationType.ClearParticles()
	
	numParticles = 0
	
	ParticleLo = @Particle( 1 )
	ParticleHi = @Particle( 1 )
	
	For i As Integer = 1 To max_particles
		
		With particle(i)
			
			.mass         = 0.0
			.inverse_mass = 0.0
			.radius       = 0.0
			.position     = Vec2( 0.0, 0.0 )
			.velocity     = Vec2( 0.0, 0.0 )
			.impulse      = Vec2( 0.0, 0.0 )
			
		End With
	
	Next
	
End Sub

Sub SimulationType.ClearSprings()
	
	numSprings = 0
	
	SpringLo = @spring( 1 )
	SpringHi = @spring( 1 )
	
	For i As Integer = 1 To max_springs
		
		With spring(i)
			
			.particle_a          = 0
			.particle_b          = 0
			.rest_distance       = 0.0
			.reduced_mass        = 0.0
			.rest_distance       = 0.0
			.rest_impulse        = 0.0
			.accumulated_impulse = Vec2( 0.0, 0.0 )
			.unit                = Vec2( 0.0, 0.0 )
			
		End With
	
	Next
	
End Sub

Sub SimulationType.ClearAngularSprings()
	
	numAngularSprings = 0
	
	AngularSpringLo = @Angularspring( 1 )
	AngularSpringHi = @Angularspring( 1 )
	
	For i As Integer = 1 To max_Angularsprings
		
		With Angularspring(i)
			
			.spring_a            = 0
			.spring_b            = 0
			.angle               = Vec2( 0.0, 0.0 )
			.rest_angle          = Vec2( 0.0, 0.0 )
			.reduced_inertia     = 0.0
			.rest_impulse        = 0.0
			.accumulated_impulse = 0.0
			
		End With
	
	Next
	
End Sub

Function SimulationType.CreateParticle() As ParticleType Ptr
	
	If ( numParticles < max_Particles - 1 ) Then
		
		numParticles += 1
		
		ParticleHi = @Particle( numParticles )
		
		Return ParticleHi
		
	End If
	
End Function

Function SimulationType.CreateSpring() As SpringType Ptr
	
	If ( numSprings < max_Springs - 1 ) Then
		
		numSprings += 1
		
		SpringHi = @spring( numSprings )
		
		Return SpringHi 
		
	End If
	
End Function

Function SimulationType.CreateAngularSpring() As AngularSpringType Ptr
	
	If ( numAngularSprings < max_AngularSprings - 1 ) Then
		
		numAngularSprings += 1
		
		AngularSpringHi = @Angularspring( numAngularSprings )
		
		Return AngularSpringHi 
		
	End If
	
End Function
