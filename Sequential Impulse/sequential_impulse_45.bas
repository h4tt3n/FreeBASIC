''*******************************************************************************
''
''  Sequential impulse with warmstart demos
''
''  Version 0.45, july 2017, Michael "h4tt3n" Nissen
''
''  This version includes rigid bodies and hinges
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
#Include Once "../Math/Mat22.bi"


''   Global constants
Const As Single  dt             = 1.0 / 60.0       ''  timestep
Const As Single  inv_dt         = 1.0 / dt         ''  inverse timestep
Const As Single  gravity        = 10.0             ''  gravity
Const As Single  air_friction   = 1.0             ''  gravity
Const As Single  density        = 0.05             ''  ball density
Const As Single  pi             = 4.0 * Atn( 1.0 ) ''  pi
Const As Integer screen_wid     = 1000             ''  screen width
Const As Integer screen_hgt     = 800              ''  screen height
Const As Integer pick_distance  = 128^2            ''  mouse pick up distance
Const As Integer max_particles  = 2048             ''  particles
Const As Integer max_springs    = 2048             ''  springs
Const As Integer max_boxes      =  512             ''  boxes
Const As Integer max_hinges     =  512             ''  hinges


''	Types
Type ParticleType
	
	Declare Constructor()
	
	As Vec2 position
	As Vec2 velocity
	As Vec2 impulse
	
	As Single mass
	As Single inverse_mass
	As Single radius
  
End Type

Type SpringType
	
	Declare Constructor()
	
	As Vec2 accumulated_impulse
	As Vec2 unit
	
	As Single reduced_mass
	As Single rest_distance
	As Single rest_impulse
	
	As ParticleType Ptr particle_a
	As ParticleType Ptr particle_b
  
End Type

Type BoxType
	
	Declare Constructor()
	
	As vec2 radius
	
	As Vec2 position
	As Vec2 velocity
	As Vec2 impulse
	As Vec2 angle_vector
	
	As Single angle
	As Single angular_velocity
	As Single angular_impulse
	
	As Single mass
	As Single inverse_mass
	As Single inertia
	As Single inverse_inertia
	
End Type

Type HingeType
	
	Declare Constructor()
	
	As Vec2 accumulated_impulse
	As Vec2 anchor_a
	As Vec2 anchor_b
	As Vec2 r_a
	As Vec2 r_b
	
	As Single reduced_mass
	As Mat22 M
	As Vec2 rest_impulse
	
	As BoxType Ptr box_a
	As BoxType Ptr box_b
	
End Type

Type SimulationType
	
	Declare Constructor()

	Declare Sub Demo1()
	Declare Sub Demo2()
	Declare Sub Demo3()
	Declare Sub Demo4()
	Declare Sub Demo5()
	Declare Sub Demo6()
	
	Declare Sub CreateScreen( ByVal Wid As Integer, ByVal Hgt As Integer )
	
	Declare Function CreateParticle() As ParticleType Ptr
	Declare Function CreateSpring() As SpringType Ptr
	Declare Function CreateBox() As BoxType Ptr
	Declare Function CreateHinge() As HingeType Ptr
	
	Declare Sub ClearParticles()
	Declare Sub ClearSprings()
	Declare Sub ClearBoxes()
	Declare Sub ClearHinges()
	
	Declare Sub UpdateInput()
	Declare Sub UpdateScreen()
	
	Declare Sub RunSimulation()

	Declare Sub ApplyCorrectiveimpulse()
	Declare Sub ApplyWarmStart()
	Declare Sub ComputeRestimpulse()
	Declare Sub ComputeNewState()
	
	As fb.EVENT e
	
	As String DemoText
	
	As Integer iterations
	As Integer warmstart
	As Integer numParticles
	As Integer numSprings
	As Integer numBoxes
	As Integer numHinges
	
	As Single spring_stiffnes
	As Single spring_damping
	As Single spring_warmstart
	
	As Single hinge_stiffnes
	As Single hinge_damping
	As Single hinge_warmstart
	
	As Vec2 position
	As Vec2 position_prev
	As Vec2 velocity
	
	As Integer button
	As Integer button_prev
	
	''
	As ParticleType Ptr picked
	As ParticleType Ptr nearest
	
	As ParticleType Ptr ParticleLo
	As ParticleType Ptr ParticleHi
	
	As SpringType Ptr SpringLo
	As SpringType Ptr SpringHi
	
	As BoxType Ptr BoxLo
	As BoxType Ptr BoxHi
	
	As HingeType Ptr HingeLo
	As HingeType Ptr HingeHi
	
	''
	As ParticleType particle ( 1 To max_particles )
	As SpringType   spring   ( 1 To max_springs )
	As BoxType      box      ( 1 To max_boxes )
	As HingeType    hinge    ( 1 To max_hinges )

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

Constructor BoxType()

	radius = Vec2( 0.0, 0.0 )
	
	position     = Vec2( 0.0, 0.0 )
	velocity     = Vec2( 0.0, 0.0 )
	impulse      = Vec2( 0.0, 0.0 )
	angle_vector = Vec2( 0.0, 0.0 )
	
	angle            = 0.0
	angular_velocity = 0.0
	angular_impulse  = 0.0
	
	mass            = 0.0
	inverse_mass    = 0.0
	inertia         = 0.0
	inverse_inertia = 0.0

End Constructor

Constructor HingeType()

	accumulated_impulse = Vec2( 0.0, 0.0 )
	
	anchor_a = Vec2( 0.0, 0.0 )
	anchor_b = Vec2( 0.0, 0.0 )
	
	r_a = Vec2( 0.0, 0.0 )
	r_b = Vec2( 0.0, 0.0 )
	
	reduced_mass = 0.0
	rest_impulse = Vec2( 0.0, 0.0 )
	
	box_a = 0
	box_b = 0
	
End Constructor

Constructor SimulationType()
	
	ClearParticles()
	ClearSprings()
	ClearBoxes()
	ClearHinges()
	
	CreateScreen( screen_wid, screen_hgt )
	
	Demo1()
	
	RunSimulation()
	
End Constructor


''	Main loop
Sub SimulationType.RunSimulation()
	
	Do
		
		'Sleep( 1, 1 )
		
		UpdateScreen()
		
		UpdateInput()
		
		'' gravity
		For P As ParticleType Ptr = ParticleLo To ParticleHi
		
			If ( P->inverse_mass > 0.0 ) Then
				
				P->velocity *= air_friction
				
				P->velocity += Vec2( 0.0, dt * gravity )
				
			End If
			
		Next
		
		For B As BoxType Ptr = BoxLo To BoxHi
		
			If ( B->inverse_mass > 0.0 ) Then
				
				B->angular_velocity *= air_friction
				
				B->velocity *= air_friction
				
				B->velocity += Vec2( 0.0, dt * gravity )
				
			End If
			
		Next
		
		ComputeRestimpulse()		
		
		If warmstart = 1 Then 
			
			ApplyWarmStart()
			
		Else
			
			For S As SpringType Ptr = SpringLo To SpringHi
				
				S->accumulated_impulse = Vec2( 0.0, 0.0 )
				
			Next
			
			For J As HingeType Ptr = HingeLo To HingeHi
				
				J->accumulated_impulse = Vec2( 0.0, 0.0 )
				
			Next
			
		EndIf
		
		For i As Integer = 1 To iterations
		
			ApplyCorrectiveimpulse()
		
		Next
		
		ComputeNewState()
		
	Loop
	
End Sub


'' Demos
Sub SimulationType.Demo1()
	
		'' Wrecking ball
	
	iterations   = 10
	warmstart    = 0
	spring_stiffnes  = 0.2   
	spring_damping   = 1.0
	spring_warmstart = 0.0
	
	Dim As Integer num_Particles = 15
	Dim As Integer num_Springs   = 14
	Dim As Integer SpringLength  = 50
	
	Dim As Integer num_boxes  = 15
	Dim As Integer num_hinges = 14
	Dim As Integer hinge_pos  = 5
	Dim As vec2    box_radius = vec2( 30, 5 )
	
	DemoText = "Demo 1: Wrecking ball. The ball weighs 1000 times more than the smaller masses, but there is no visible deformation."
	
	''
	ClearParticles()
	ClearSprings()
	ClearBoxes()
	ClearHinges()
	
	'' Boxes
	Dim As BoxType Ptr B1 = CreateBox()
	
	B1->radius = Vec2( 15, 30 )
	
	B1->mass = B1->radius.x * B1->radius.y * density
	B1->inverse_mass = 0.0
	
	B1->inertia = B1->mass / 12.0 * ( ( 2.0 * B1->radius.x ) ^ 2 + ( 2.0 * B1->radius.y ) ^ 2 )
	B1->inverse_inertia = 0.0
	
	B1->position.x   = -300
	B1->position.y   = -100
	
	B1->angle = 0.0
	B1->angle_vector = Vec2( Cos( B1->angle ), Sin( B1->angle ) )
	
	''
	For i As Integer = 2 To num_boxes
		
		Dim As BoxType Ptr B = CreateBox()
		
		B->radius = box_radius
	
		B->mass = ( 2.0 * B->radius.x ) * ( 2.0 * B->radius.y ) * density
		B->inverse_mass = 1.0 / B->mass
		
		If ( i = num_boxes ) Then
			
			B->radius = Vec2( 100, 50 )
			B->mass = ( 2.0 * B->radius.x ) * ( 2.0 * B->radius.y ) * density
			B->inverse_mass = 1.0 / B->mass
			
			'B->mass *= 1000
			'B->inverse_mass = 1.0 / B->mass
			
		EndIf
		
		B->inertia = B->mass / 12.0 * ( ( 2.0 * B->radius.x ) ^ 2 + ( 2.0 * B->radius.y ) ^ 2 )
		B->inverse_inertia = 1.0 / B->inertia
		
		B->position.x   = 300 + (i-1) * ( box_radius.x - hinge_pos ) * 2
		B->position.y   = 100
		
		B->angle = 0.0
		B->angle_vector = Vec2( Cos( B->angle ), Sin( B->angle ) )
		
		'B->angular_velocity = (Rnd-rnd)*1000
		
	Next
	
	'' Hinges
	For i As Integer = 1 To num_hinges
		
		Dim As HingeType Ptr J1 = CreateHinge()
		
		J1->box_a = @box(i)
		J1->box_b = @box(i+1)
		
		J1->anchor_a = Vec2( 300 + ( box_radius.x - hinge_pos ) + (i-1) * ( box_radius.x - hinge_pos ) * 2, 100 ) - J1->box_a->position
		J1->anchor_b = Vec2( 300 + ( box_radius.x - hinge_pos ) + (i-1) * ( box_radius.x - hinge_pos ) * 2, 100 ) - J1->box_b->position
		
	Next
	
	'' randomize positions for stability test
	'For i As Integer = 2 To num_boxes
	'	
	'	box(i).position = Vec2().RandomizeCircle( 512 )
	'	
	'	box(i).angle = ( Rnd() - Rnd() ) * 2.0 * pi
	'	box(i).angle_vector = Vec2( Cos( box(i).angle ), Sin( box(i).angle ) )
	'	
	'Next
	
	'' create particles
	Dim As particletype Ptr P = CreateParticle()
		
	P->mass         = 10.0
	P->inverse_mass = 0
	P->radius       = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
	P->position.x   = 0.5 * screen_wid
	P->position.y   = 0.25 * screen_hgt
	
	For i As integer = 2 To num_Particles
		
		Dim As particletype Ptr P = CreateParticle()
		
		P->mass         = 10.0
		P->inverse_mass = 1.0 / P->mass
		P->radius       = 0.0
		
		If i = num_Particles Then
			
			P->mass = 1000.0
			P->inverse_mass = 1.0 / P->mass
			P->radius = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
			
		EndIf
		
		P->position.x   = 0.5 * screen_wid + ( i - 1 ) * SpringLength
		P->position.y   = 0.25 * screen_hgt
		
	Next
	
	''  create springs
	For i As Integer = 1 To num_Springs
		
		Dim As SpringType Ptr S = CreateSpring()
				
		S->particle_a    = @particle( i )
		S->particle_b    = @particle( i + 1 )
		S->rest_distance = (S->particle_b->position - S->particle_a->position).length()
		
		Dim As Single inverseMass = S->particle_a->inverse_mass + S->particle_b->inverse_mass
		
		S->reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
		
	Next
	
End Sub

Sub SimulationType.Demo2()
	
	'' Steam locomotive
	
	iterations       = 10
	warmstart        = 1
	spring_stiffnes  = 1.0
	spring_damping   = 1.0
	spring_warmstart = 1.0
	
	DemoText = "Demo 2: Steam locomotive."
	
	''
	ClearParticles()
	ClearSprings()
	ClearBoxes()
	ClearHinges()
	
	'' Boiler
	Dim As BoxType Ptr B = CreateBox()
	
	B->radius = Vec2( 300, 60 )
	B->position = Vec2( 400, 300 )
	
	B->mass = ( 2.0 * B->radius.x ) * ( 2.0 * B->radius.y ) * density
	B->inverse_mass = 0'1.0 / B->mass
	
	B->inertia = B->mass / 12.0 * ( ( 2.0 * B->radius.x ) ^ 2 + ( 2.0 * B->radius.y ) ^ 2 )
	B->inverse_inertia = 0'1.0 / B->inertia 
	
	B->angle = 0.0
	B->angle_vector = Vec2( Cos( B->angle ), Sin( B->angle ) )
	
	'' big wheel 1
	B = CreateBox()
	
	B->radius = Vec2( 40, 40 )
	B->position = Vec2( 300, 400 )
	
	B->mass = ( 2.0 * B->radius.x ) * ( 2.0 * B->radius.y ) * density
	B->inverse_mass = 1.0 / B->mass
	
	B->inertia = B->mass / 12.0 * ( ( 2.0 * B->radius.x ) ^ 2 + ( 2.0 * B->radius.y ) ^ 2 )
	B->inverse_inertia = 1.0 / B->inertia 
	
	B->angle = 0.0
	B->angle_vector = Vec2( Cos( B->angle ), Sin( B->angle ) )
	
	'B->angular_velocity = -10.0
	
	'' big wheel 2
	B = CreateBox()
	
	B->radius = Vec2( 40, 40 )
	B->position = Vec2( 400, 400 )
	
	B->mass = ( 2.0 * B->radius.x ) * ( 2.0 * B->radius.y ) * density
	B->inverse_mass = 1.0 / B->mass
	
	B->inertia = B->mass / 12.0 * ( ( 2.0 * B->radius.x ) ^ 2 + ( 2.0 * B->radius.y ) ^ 2 )
	B->inverse_inertia = 1.0 / B->inertia 
	
	B->angle = 0.0
	B->angle_vector = Vec2( Cos( B->angle ), Sin( B->angle ) )
	
	'' big wheel 3
	B = CreateBox()
	
	B->radius = Vec2( 40, 40 )
	B->position = Vec2( 500, 400 )
	
	B->mass = B->radius.x * B->radius.y * density
	B->inverse_mass = 1.0 / B->mass
	
	B->inertia = B->mass / 12.0 * ( ( 2.0 * B->radius.x ) ^ 2 + ( 2.0 * B->radius.y ) ^ 2 )
	B->inverse_inertia = 1.0 / B->inertia 
	
	B->angle = 0.0
	B->angle_vector = Vec2( Cos( B->angle ), Sin( B->angle ) )
	
	'' coupling rod 1
	B = CreateBox()
	
	B->radius = Vec2( 110, 5 )
	B->position = Vec2( 420, 380 )
	
	B->mass = ( 2.0 * B->radius.x ) * ( 2.0 * B->radius.y ) * density
	B->inverse_mass = 1.0 / B->mass
	
	B->inertia = B->mass / 12.0 * ( ( 2.0 * B->radius.x ) ^ 2 + ( 2.0 * B->radius.y ) ^ 2 )
	B->inverse_inertia = 1.0 / B->inertia 
	
	B->angle = 0.0
	B->angle_vector = Vec2( Cos( B->angle ), Sin( B->angle ) )
	
	'B->velocity = Vec2( -1000.0, 0.0 )
	
	'' Immovable ground (outside screen)
	B = CreateBox()
	
	B->radius = Vec2( 15, 15 )
	
	B->mass = ( 2.0 * B->radius.x ) * ( 2.0 * B->radius.y ) * density
	B->inverse_mass = 0.0
	
	B->inertia = B->mass / 12.0 * ( ( 2.0 * B->radius.x ) ^ 2 + ( 2.0 * B->radius.y ) ^ 2 )
	B->inverse_inertia = 0.0
	
	B->position.x   = -300
	B->position.y   = -100
	
	B->angle = 0.0
	B->angle_vector = Vec2( Cos( B->angle ), Sin( B->angle ) )
	
	
	
	'' wheel 1 crank
	Dim As HingeType Ptr J = CreateHinge()
	
	J->box_a = @box(1)
	J->box_b = @box(2)
	
	J->anchor_a = Vec2( 300, 400 ) - J->box_a->position
	J->anchor_b = Vec2( 300, 400 ) - J->box_b->position
	
	'' wheel 2 crank
	J = CreateHinge()
	
	J->box_a = @box(1)
	J->box_b = @box(3)
	
	J->anchor_a = Vec2( 400, 400 ) - J->box_a->position
	J->anchor_b = Vec2( 400, 400 ) - J->box_b->position
	
	'' wheel 3 crank
	J = CreateHinge()
	
	J->box_a = @box(1)
	J->box_b = @box(4)
	
	J->anchor_a = Vec2( 500, 400 ) - J->box_a->position
	J->anchor_b = Vec2( 500, 400 ) - J->box_b->position
	
	'' coupling rod 1 - wheel 1 crank
	J = CreateHinge()
	
	J->box_a = @box(2)
	J->box_b = @box(5)
	
	J->anchor_a = Vec2( 320, 380 ) - J->box_a->position
	J->anchor_b = Vec2( 320, 380 ) - J->box_b->position
	
	'' coupling rod 1 - wheel 2 crank
	J = CreateHinge()
	
	J->box_a = @box(3)
	J->box_b = @box(5)
	
	J->anchor_a = Vec2( 420, 380 ) - J->box_a->position
	J->anchor_b = Vec2( 420, 380 ) - J->box_b->position
	
	'' coupling rod 1 - wheel 3 crank
	J = CreateHinge()
	
	J->box_a = @box(4)
	J->box_b = @box(5)
	
	J->anchor_a = Vec2( 520, 380 ) - J->box_a->position
	J->anchor_b = Vec2( 520, 380 ) - J->box_b->position
	
	'' hinge for holding train
	J = CreateHinge()
	
	J->box_a = @box(1)
	J->box_b = @box(6)
	
	J->anchor_a = Vec2( 400, 100 ) - J->box_a->position
	J->anchor_b = Vec2( 400, 100 ) - J->box_b->position
	
End Sub

Sub SimulationType.Demo3()
	
	'' Horizontal steel girder
	
	iterations   = 10
	warmstart    = 1
	spring_stiffnes   = 1.0
	spring_damping     = 1.0
	spring_warmstart   = 0.5
	
	Dim As Integer GirderWidth  = 2
	Dim As Integer GirderLength = 15
	Dim As Integer SpringWidth  = 30
	Dim As Integer SpringLength = 60
	
	DemoText = "Demo 3: Horizontal steel girder. Connecting springs at right angles increases stability. (And NO dirty thoughts!)"
	
	''
	ClearParticles()
	ClearSprings()
	ClearBoxes()
	ClearHinges()
	
	''	particles
	for i as integer = 1 to GirderLength
		for j as integer = 1 to GirderWidth
		
			Dim As particletype Ptr P = CreateParticle()
			
			P->mass         = 1.0
			P->inverse_mass = 1.0 / P->mass
			P->radius       = 0.0
			'P->velocity     = Vec2().randomizesquare( 10.0 )
			P->position.x   = 0.1 * screen_wid + (i-1) * SpringLength 
			P->position.y   = 0.4 * screen_hgt + (j-1) * SpringWidth
		  	
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
	spring_stiffnes   = 1.0
	spring_damping     = 1.0
	spring_warmstart   = 0.5
	
	Dim As Integer GirderWidth  = 2
	Dim As Integer GirderLength = 32
	Dim As Integer SpringLength = 20
	
	DemoText = "Demo 4: Vertical steel girder fighting gravity."
	
	''
	ClearParticles()
	ClearSprings()
	ClearBoxes()
	ClearHinges()
	
	''	particles
	for i as integer = 1 to GirderLength
		for j as integer = 1 to GirderWidth
		
			Dim As particletype Ptr P = CreateParticle()
			
			P->mass         = 1.0
			P->inverse_mass = 1.0 / P->mass
			P->radius       = 0.0
			P->position.x   = 0.5 * screen_wid + (j-1) * SpringLength' + (j - 1.5 ) * ( GirderLength - 8 - i )
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
	spring_stiffnes   = 0.25 
	spring_damping     = 1.0
	spring_warmstart   = 0.5
	
	Dim As Integer num_Particles = 96
	Dim As Integer num_Springs   = 95
	Dim As Integer state         = 1000
	
	DemoText = "Demo 5: Rigid chain stabilization. The masses get random state vectors in the range +/- " & state & " but stabilizes very fast."
	
	''
	ClearParticles()
	ClearSprings()
	ClearBoxes()
	ClearHinges()
	
	Randomize Timer
	
	Dim As particletype Ptr P = CreateParticle()
	
	P->mass         = 1.0
	P->inverse_mass = 0.0
	P->radius       = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
	P->position.x   = 0.5 * screen_wid
	P->position.y   = 0.1 * screen_hgt
	
	'' create particles
	For i As Integer = 2 To num_Particles
		
		P = CreateParticle()
		
		P->mass         = 1.0' + ( Rnd() * 99.0 ^ (1/3)  ) ^ 3
		P->inverse_mass = 1.0 / P->mass
		P->radius       = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
		
		P->position.x   = 0.5 * screen_wid + ( Rnd() - Rnd() ) * state 
		P->position.y   = 0.5 * screen_hgt + ( Rnd() - Rnd() ) * state
		
		P->velocity.x   = ( Rnd() - Rnd() ) * state 
		P->velocity.y   = ( Rnd() - Rnd() ) * state
		
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
	warmstart    = 0
	spring_stiffnes   = 0.2
	spring_damping     = 1.0
	spring_warmstart   = 1.0
	
	Dim As Integer num_Particles = 24
	Dim As Integer num_Springs   = 23
	
	Dim As Integer num_boxes  = 24
	Dim As Integer num_hinges = 23
	Dim As vec2    box_radius = vec2( 20, 5 )
	
	DemoText = "Demo 6: Suspension bridge."
	
	''
	ClearParticles()
	ClearSprings()
	ClearBoxes()
	ClearHinges()
	
	Randomize Timer
	
	For i As Integer = 1 To num_boxes
		
		Dim As BoxType Ptr B = CreateBox()
		
		B->radius = box_radius
	
		B->mass = ( 2.0 * B->radius.x ) * ( 2.0 * B->radius.y ) * density
		B->inverse_mass = 1.0 / B->mass
		
		B->inertia = B->mass / 12.0 * ( ( 2.0 * B->radius.x ) ^ 2 + ( 2.0 * B->radius.y ) ^ 2 )
		B->inverse_inertia = 1.0 / B->inertia
		
		If ( i = num_boxes Or i = 1) Then
			
			B->mass = ( 2.0 * B->radius.x ) * ( 2.0 * B->radius.y ) * density
			B->inverse_mass = 0.0'1.0 / B->mass
			
			B->inertia = B->mass / 12.0 * ( ( 2.0 * B->radius.x ) ^ 2 + ( 2.0 * B->radius.y ) ^ 2 )
			B->inverse_inertia = 0.0'1.0 / B->inertia
			
		EndIf
		
		B->position.x   = 50 + (i-1) * box_radius.x * 2
		B->position.y   = 0.3 * screen_hgt
		
		B->angle = 0.0
		B->angle_vector = Vec2( Cos( B->angle ), Sin( B->angle ) )
		
		'B->angular_velocity = (Rnd-rnd)*1000
		
	Next
	
	''
	For i As Integer = 1 To num_hinges
		
		Dim As HingeType Ptr J1 = CreateHinge()
		
		J1->box_a = @box(i)
		J1->box_b = @box(i+1)
		
		J1->anchor_a = Vec2( 50 + box_radius.x + (i-1) * box_radius.x * 2, 0.3 * screen_hgt ) - J1->box_a->position
		J1->anchor_b = Vec2( 50 + box_radius.x + (i-1) * box_radius.x * 2, 0.3 * screen_hgt ) - J1->box_b->position
	
	Next
	
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
		S->rest_distance = length( S->particle_b->position - S->particle_a->position )
		
		Dim As Single inverseMass = S->particle_a->inverse_mass + S->particle_b->inverse_mass
		S->reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
	
	Next
	
End Sub



'' Core physics functions
Sub SimulationType.ComputeRestimpulse()
	
	'' Compute the impulse needed to satisfy the constraint in one loop
	
	'' Springs
	If ( numsprings ) Then
		
		For S As SpringType Ptr = SpringLo To SpringHi
			
			Dim As Vec2 distance = S->particle_b->position - S->particle_a->position
			Dim As Vec2 velocity = S->particle_b->velocity - S->particle_a->velocity
			
			S->unit = distance.Unit()
			
			Dim As Single distance_error = S->unit.dot( distance ) - S->rest_distance
			Dim As Single velocity_error = S->unit.dot( velocity )
			
			S->rest_impulse = -( spring_stiffnes * distance_error * inv_dt + spring_damping * velocity_error )
			
		Next
		
	EndIf
	
	'' Hinges
	If ( numhinges ) Then
		
		For J As HingeType Ptr = HingeLo To HingeHi
			
			''
			J->r_a = J->box_a->angle_vector.Rotateccw( J->anchor_a )
			J->r_b = J->box_b->angle_vector.Rotateccw( J->anchor_b )
			
			Dim As Vec2 position_a = J->box_a->position + J->r_a
			Dim As Vec2 position_b = J->box_b->position + J->r_b
			
			Dim As Vec2 velocity_a = J->box_a->velocity + J->r_a.Perpdot( J->box_a->angular_velocity )
			Dim As Vec2 velocity_b = J->box_b->velocity + J->r_b.Perpdot( J->box_b->angular_velocity )
			
			Dim As Vec2 distance_error = position_b - position_a
			Dim As Vec2 velocity_error = velocity_b - velocity_a
			
			J->rest_impulse = -( spring_stiffnes * distance_error * inv_dt + spring_damping * velocity_error )
			
			'' deltaV = deltaV0 + K * impulse
			'' invM = [(1/m1 + 1/m2) * eye(2) - skew(r1) * invI1 * skew(r1) - skew(r2) * invI2 * skew(r2)]
			''      = [1/m1+1/m2     0    ] + invI1 * [r1.y*r1.y -r1.x*r1.y] + invI2 * [r2.y*r2.y -r2.x*r2.y]
			''        [    0     1/m1+1/m2]           [-r1.x*r1.y r1.x*r1.x]           [-r2.x*r2.y r2.x*r2.x]
			Dim As Mat22 K1 = Mat22( _
			J->box_a->inverse_mass + J->box_b->inverse_mass, 0.0, _
			0.0									 	              , J->box_a->inverse_mass + J->box_b->inverse_mass )
			
			Dim As Mat22 K2 = Mat22( _
			J->box_a->inverse_inertia, 0.0, _
			0.0,	                     J->box_a->inverse_inertia )
			
			Dim As Mat22 K3 = Mat22( _
			J->box_b->inverse_inertia, 0.0, _
			0.0,	                     J->box_b->inverse_inertia )
			
			'' 
			Dim As Mat22 K4 = Mat22( _
			 J->r_a.y * J->r_a.y, -J->r_a.x * J->r_a.y, _
			-J->r_a.x * J->r_a.y,  J->r_a.x * J->r_a.x )
			
			Dim As Mat22 K5 = Mat22( _
			 J->r_b.y * J->r_b.y, -J->r_b.x * J->r_b.y, _
			-J->r_b.x * J->r_b.y,  J->r_b.x * J->r_b.x )
						
			'Dim As Mat22 K2 = Mat22( _
			' J->box_a->inverse_inertia * J->r_a.y * J->r_a.y, -J->box_a->inverse_inertia * J->r_a.x * J->r_a.y, _
			'-J->box_a->inverse_inertia * J->r_a.x * J->r_a.y,	J->box_a->inverse_inertia * J->r_a.x * J->r_a.x )
			'
			'Dim As Mat22 K3 = Mat22( _
			' J->box_b->inverse_inertia * J->r_b.y * J->r_b.y, -J->box_b->inverse_inertia * J->r_b.x * J->r_b.y, _
			'-J->box_b->inverse_inertia * J->r_b.x * J->r_b.y,  J->box_b->inverse_inertia * J->r_b.x * J->r_b.x )
		
			'Dim As Mat22 K = K1 + K2 + K3
			Dim As Mat22 K = K1 + K2 * K4 + K3 * K5
		
			J->M = K.Inverse()
			
		Next
	
	EndIf
	
End Sub

Sub SimulationType.ApplyCorrectiveimpulse()
	
	'' Apply the difference between rest impulse and current impulse.
	'' Accumulate applied impulses for warmstarting the next loop.
	
	'' Springs
	If ( numsprings ) Then
			
		For S As SpringType Ptr = SpringLo To SpringHi
		
			Dim As Vec2 current_impulse = S->particle_b->impulse - S->particle_a->impulse
			
			Dim As Single impulse_error = S->unit.dot( current_impulse ) - S->rest_impulse
			
		   Dim As Vec2 corrective_impulse = -impulse_error * S->reduced_mass * S->unit
			
			S->particle_a->impulse -= corrective_impulse * S->particle_a->inverse_mass
			S->particle_b->impulse += corrective_impulse * S->particle_b->inverse_mass
			
			S->accumulated_impulse += corrective_impulse
			
		Next
		
	EndIf
	
	'' Hinges
	If ( numhinges ) Then
		
		For J As HingeType Ptr = HingeLo To HingeHi
			
			Dim As Vec2 impulse_a = J->box_a->impulse + J->r_a.PerpDot( J->box_a->angular_impulse )
			Dim As Vec2 impulse_b = J->box_b->impulse + J->r_b.PerpDot( J->box_b->angular_impulse )
			
			Dim As Vec2 current_impulse = impulse_b - impulse_a
			
			Dim As Vec2 impulse_error = current_impulse - J->rest_impulse
			
			Dim As Vec2 corrective_impulse = -impulse_error * J->M
			
			J->box_a->impulse -= corrective_impulse * J->box_a->inverse_mass
			J->box_b->impulse += corrective_impulse * J->box_b->inverse_mass
			
			J->box_a->angular_impulse -= J->r_a.PerpDot( corrective_impulse ) * J->box_a->inverse_inertia
			J->box_b->angular_impulse += J->r_b.PerpDot( corrective_impulse ) * J->box_b->inverse_inertia
			
			J->accumulated_impulse += corrective_impulse
			
		Next
		
	EndIf
	
End Sub

Sub SimulationType.ApplyWarmStart()
	
	'' Warm starting. Use the sum of previously applied impulses
	'' projected onto new normal vector as initial iteration value.
	''	This is roughly equivalent of doubling the number of iterations.
	
	'' Springs
	If ( numsprings ) Then
		
		For S As SpringType Ptr = SpringLo To SpringHi
			
			Dim As Single projected_impulse = S->unit.dot( S->accumulated_impulse )
			
			If ( projected_impulse < 0.0 ) Then
				
				Dim As Vec2 warmstart_impulse = spring_warmstart * projected_impulse * S->unit
				
				S->particle_a->impulse -= warmstart_impulse * S->particle_a->inverse_mass 
				S->particle_b->impulse += warmstart_impulse * S->particle_b->inverse_mass
			
			End If
			
			S->accumulated_impulse = Vec2( 0.0, 0.0 )
			
		Next
	
	EndIf
	
	'' Hinges
	If ( numhinges ) Then
		
		For J As HingeType Ptr = HingeLo To HingeHi
			
			Dim As Vec2 projected_impulse = J->accumulated_impulse
			
			'Dim As Vec2 position_a = J->box_a->position + J->r_a
			'Dim As Vec2 position_b = J->box_b->position + J->r_b
			
			'Dim As Vec2 dist = position_b - position_a
			
			'If ( Sgn(projected_impulse.x ) = Sgn( dist.x ) And Sgn( projected_impulse.y ) = Sgn( dist.y )) Then
				
				Dim As Vec2 warmstart_impulse = spring_warmstart * projected_impulse
				
				J->box_a->impulse -= warmstart_impulse * J->box_a->inverse_mass
				J->box_b->impulse += warmstart_impulse * J->box_b->inverse_mass
				
				J->box_a->angular_impulse -= J->r_a.PerpDot( warmstart_impulse ) * J->box_a->inverse_inertia
				J->box_b->angular_impulse += J->r_b.PerpDot( warmstart_impulse ) * J->box_b->inverse_inertia
				
			'EndIf
			
			J->accumulated_impulse = Vec2( 0.0, 0.0 )
			
		Next
	
	EndIf
	
End Sub

Sub SimulationType.ComputeNewState()
	
	'' Particles
	If ( numparticles ) Then
		
		For P As ParticleType Ptr = ParticleLo To ParticleHi
			
			If ( P->inverse_mass > 0.0 ) Then
				
				P->velocity += P->impulse
				P->position += P->velocity * dt 
				
			End If
			
			P->impulse = Vec2( 0.0, 0.0 )
			
		Next
	
	EndIf
	
	'' Boxes
	If ( numboxes ) Then
		
		For B As BoxType Ptr = BoxLo To BoxHi
			
			''
			If ( B->inverse_mass > 0.0 ) Then
				
				B->velocity += B->impulse
				B->position += B->velocity * dt 
				
			End If
			
			B->impulse = Vec2( 0.0, 0.0 )
			
			''
			If ( B->inverse_inertia > 0.0 ) Then
				
				B->angular_velocity += B->angular_impulse
				B->angle            += B->angular_velocity * dt
				
				B->angle_vector = Vec2( Cos( B->angle ), Sin( B->angle ) )
				
			EndIf
			
			B->angular_impulse = 0.0
			
		Next
	
	EndIf
	
End Sub

'' Graphics and interaction
Sub SimulationType.UpdateScreen()
	
	''
	Cls
	
	''
	Locate  4, 2: Print DemoText
	Locate  8, 2: Print Using "(I)terations ###"; iterations
	Locate 10, 2: Print Using "(S)tiffness  #.##"; spring_stiffnes
	Locate 12, 2: Print Using "(D)amping    #.##"; spring_damping
	
	If ( warmstart = 0 ) Then 
		
		Locate 14, 2: Print "(W)armstart  OFF"
		
	Else
		
		Locate 14, 2: Print Using "(W)armstart  #.##"; spring_warmstart
		
	EndIf
	
	''  draw particles background
	If ( numparticles ) Then
		
		For P As ParticleType Ptr = ParticleLo To ParticleHi
			
			If ( P->radius > 0.0 ) Then
				
				Circle(P->position.x, P->position.y), P->radius + 5.0, RGB(0, 0, 0) ,,, 1, f
				
			End If
			
		Next
	
	EndIf
	
	''  draw springs 
	If ( numsprings ) Then
		
		For S As SpringType Ptr = SpringLo To SpringHi
			
			Line(S->particle_a->position.x, S->particle_a->position.y)-_
				 (S->particle_b->position.x, S->particle_b->position.y), RGB(0, 255, 0)
			
		Next
	
	EndIf
	
	''	draw particles foreground
	If ( numparticles ) Then
		
		For P As ParticleType Ptr = ParticleLo To ParticleHi
			
			If ( P->radius > 0.0 ) Then
				
				Dim As UInteger Col = IIf( P->inverse_mass = 0.0, RGB(160, 160, 160), RGB(255, 0, 0) )
				
				Circle(P->position.x, P->position.y), P->radius, Col,,, 1, f
				
			Else
				
				Dim As UInteger Col = IIf( P->inverse_mass = 0.0, RGB(160, 160, 160), RGB(128, 255, 0) )
				
				Circle(P->position.x, P->position.y), 2.0, Col,,, 1, f
				
			End If
			
		Next
	
	EndIf
	
	'' Draw boxes
	If ( numboxes) Then
		
		For B As BoxType Ptr = BoxLo To BoxHi
			
			'Circle( B->position.x, B->position.y ), 2.0, RGB( 192, 192, 192 ),,, 1, f
			
			Dim As Vec2 a1 = B->position + B->angle_vector * B->radius.x + B->angle_vector.perpccw * B->radius.y
			Dim As Vec2 a2 = B->position + B->angle_vector * B->radius.x - B->angle_vector.perpccw * B->radius.y
			Dim As Vec2 a3 = B->position - B->angle_vector * B->radius.x - B->angle_vector.perpccw * B->radius.y
			Dim As Vec2 a4 = B->position - B->angle_vector * B->radius.x + B->angle_vector.perpccw * B->radius.y
	
			Line( a1.x, a1.y )-( a2.x, a2.y ), RGB( 160, 160, 160 )
			Line( a2.x, a2.y )-( a3.x, a3.y ), RGB( 160, 160, 160 )
			Line( a3.x, a3.y )-( a4.x, a4.y ), RGB( 160, 160, 160 )
			Line( a4.x, a4.y )-( a1.x, a1.y ), RGB( 160, 160, 160 )
			
		Next
	
	EndIf
	
	'' Draw hinges
	If ( numhinges ) Then
		
		For J As HingeType Ptr = HingeLo To HingeHi
			
			Dim As vec2 pos_a = J->box_a->position + J->r_a
			Dim As vec2 pos_b = J->box_b->position + J->r_b
			
			Circle( pos_a.x, pos_a.y ), 2.0, RGB( 255, 0, 255 ),,, 1, f
			Circle( pos_b.x, pos_b.y ), 2.0, RGB( 255, 0, 255 ),,, 1, f

			Line( pos_a.x, pos_a.y )-( pos_b.x, pos_b.y ), RGB( 255, 0, 255 )
			
		Next
	
	EndIf
	
	If ( Nearest <> 0 ) Then Circle(Nearest->position.x, Nearest->position.y), Nearest->radius + 8, RGB(255, 255, 255),,, 1
	If ( Picked <> 0 ) Then Circle(Picked->position.x, Picked->position.y), Picked->radius + 8, RGB(255, 255, 0),,, 1
	
	''
	ScreenCopy()
	
End Sub

Sub SimulationType.CreateScreen( ByVal Wid As Integer, ByVal Hgt As Integer )
   
   ScreenRes Wid, Hgt, 16, 2', fb.GFX_ALPHA_PRIMITIVES
   
   ScreenSet( 0, 1 )
   
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
		
		picked->velocity.x = 0'( position.x - position_prev.x ) * dt
		picked->velocity.y = 0'( position.y - position_prev.y ) * dt
		
		picked->impulse.x = 0
		picked->impulse.y = 0
		
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
			
			'' Iterations
			If ( MultiKey( fb.SC_I ) And ( e.scancode = fb.SC_UP   ) ) Then iterations += 1
			If ( MultiKey( fb.SC_I ) And ( e.scancode = fb.SC_DOWN ) ) Then iterations -= 1
			
			If ( e.scancode = fb.SC_SPACE ) Then warmstart Xor= 1
			
			If ( e.scancode = fb.SC_ESCAPE ) Then End
			
		Case fb.EVENT_KEY_RELEASE
		
		Case fb.EVENT_KEY_REPEAT
			
			'' 
			If ( MultiKey( fb.SC_S ) And ( e.scancode = fb.SC_UP   ) ) Then spring_stiffnes += 0.002
			If ( MultiKey( fb.SC_S ) And ( e.scancode = fb.SC_DOWN ) ) Then spring_stiffnes -= 0.002
			
			'' 
			If ( MultiKey( fb.SC_D ) And ( e.scancode = fb.SC_UP   ) ) Then spring_damping += 0.002
			If ( MultiKey( fb.SC_D ) And ( e.scancode = fb.SC_DOWN ) ) Then spring_damping -= 0.002
			
			'' 
			If ( MultiKey( fb.SC_W ) And ( e.scancode = fb.SC_UP   ) ) Then spring_warmstart += 0.002
			If ( MultiKey( fb.SC_W ) And ( e.scancode = fb.SC_DOWN ) ) Then spring_warmstart -= 0.002
			
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
	
	If spring_stiffnes < 0.0 Then spring_stiffnes = 0.0
	If spring_stiffnes > 1.0 Then spring_stiffnes = 1.0
	
	If spring_damping < 0.0 Then spring_damping = 0.0
	If spring_damping > 1.0 Then spring_damping = 1.0
	
	If spring_warmstart < 0.0 Then spring_warmstart = 0.0
	If spring_warmstart > 1.0 Then spring_warmstart = 1.0
	
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

Sub SimulationType.ClearBoxes()
	
	numBoxes = 0
	
	BoxLo = @box( 1 )
	BoxHi = @box( 1 )
	
	For i As Integer = 1 To max_boxes
		
		With box(i)
			
			.radius = Vec2( 0.0, 0.0 )
	
			.position     = Vec2( 0.0, 0.0 )
			.velocity     = Vec2( 0.0, 0.0 )
			.impulse      = Vec2( 0.0, 0.0 )
			.angle_vector = Vec2( 0.0, 0.0 )
			
			.angle            = 0.0
			.angular_velocity = 0.0
			.angular_impulse  = 0.0
			
			.mass            = 0.0
			.inverse_mass    = 0.0
			.inertia         = 0.0
			.inverse_inertia = 0.0
			
		End With
	
	Next
	
End Sub

Sub SimulationType.ClearHinges()
	
	numHinges = 0
	
	HingeLo = @hinge( 1 )
	HingeHi = @hinge( 1 )
	
	For i As Integer = 1 To max_hinges
		
		With hinge(i)
			
			.accumulated_impulse = Vec2( 0.0, 0.0 )
			'.unit                = Vec2( 0.0, 0.0 )
			
			.anchor_a = Vec2( 0.0, 0.0 )
			.anchor_b = Vec2( 0.0, 0.0 )
			
			.r_a = Vec2( 0.0, 0.0 )
			.r_b = Vec2( 0.0, 0.0 )
			
			.reduced_mass = 0.0
			.rest_impulse = Vec2( 0.0, 0.0 )
			
			.box_a = 0
			.box_b = 0
			
		End With
	
	Next
	
End Sub

''
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

Function SimulationType.CreateBox() As BoxType Ptr
	
	If ( numBoxes < max_boxes - 1 ) Then
		
		numBoxes += 1
		
		BoxHi = @box( numBoxes )
		
		Return BoxHi 
		
	End If
	
End Function

Function SimulationType.CreateHinge() As HingeType Ptr
	
	If ( numHinges < max_hinges - 1 ) Then
		
		numHinges += 1
		
		HingeHi = @hinge( numHinges )
		
		Return HingeHi 
		
	End If
	
End Function
	
