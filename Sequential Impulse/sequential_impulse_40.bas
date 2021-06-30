''*******************************************************************************
''
''  Sequential impulse with warmstart demos
''
''  Version 0.40 (directly derived from 0.14), july 2017, Michael "h4tt3n" Nissen
''
''  This version includes rigid bodies
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
Const As Single  dt             = 1.0 / 60.0       ''  timestep
Const As Single  inv_dt         = 1.0 / dt         ''  inverse timestep
Const As Single  gravity        = 10.0             ''  gravity
Const As Single  density        = 0.05             ''  ball density
Const As Single  pi             = 4.0 * Atn( 1.0 ) ''  pi
Const As Integer screen_wid     = 1000             ''  screen width
Const As Integer screen_hgt     = 800              ''  screen height
Const As Integer pick_distance  = 128^2            ''  mouse pick up distance
Const As Integer max_particles  = 2048             ''  particles
Const As Integer max_springs    = 2048             ''  springs
Const As Integer max_boxes      =  512             ''  boxes
Const As Integer max_joints     =  512             ''  joints


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

Type JointType
	
	Declare Constructor()
	
	As Vec2 accumulated_impulse
	As Vec2 unit
	
	As Vec2 anchor_a
	As Vec2 anchor_b
	
	As Single reduced_mass
	As Single reduced_normal_mass
	As Single reduced_tangent_mass
	As Single rest_impulse
	
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
	Declare Function CreateJoint() As JointType Ptr
	
	Declare Sub ClearParticles()
	Declare Sub ClearSprings()
	Declare Sub ClearBoxes()
	Declare Sub ClearJoints()
	
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
	As Integer numBoxes
	As Integer numJoints
	
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
	
	As BoxType Ptr BoxLo
	As BoxType Ptr BoxHi
	
	As JointType Ptr JointLo
	As JointType Ptr JointHi
	
	As ParticleType particle ( 1 To max_particles )
	As SpringType   spring   ( 1 To max_springs )
	As BoxType      box      ( 1 To max_boxes )
	As JointType    joint    ( 1 To max_joints )

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

Constructor JointType()

	accumulated_impulse = Vec2( 0.0, 0.0 )
	unit                = Vec2( 0.0, 0.0 )
	
	anchor_a = Vec2( 0.0, 0.0 )
	anchor_b = Vec2( 0.0, 0.0 )
	
	reduced_mass = 0.0
	rest_impulse = 0.0
	
	box_a = 0
	box_b = 0

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
		
		UpdateScreen()
		
		UpdateInput()
		
		'' gravity
		For P As ParticleType Ptr = ParticleLo To ParticleHi
		
			If ( P->inverse_mass > 0.0 ) Then
				
				P->velocity += Vec2( 0.0, dt * gravity )
				
			End If
			
		Next
		
		For B As BoxType Ptr = BoxLo To BoxHi
		
			If ( B->inverse_mass > 0.0 ) Then
				
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
			
		EndIf
		
		For i As Integer = 1 To iterations
		
			ApplyCorrectiveImpulse()
		
		Next
		
		ComputeNewState()
		
	Loop

End Sub


'' Demos
Sub SimulationType.Demo1()
	
	'' Wrecking ball
	
	iterations   = 1
	warmstart    = 0
	cStiffness   = 0.001   
	cDamping     = 0.05
	cWarmstart   = 0.0
	
	Dim As Integer num_Particles = 13
	Dim As Integer num_Springs   = 12
	Dim As Integer SpringLength  = 30 
	
	DemoText = "Demo 1: Wrecking ball. The ball weighs 1000 times more than the smaller masses, but there is no visible deformation."
	
	''
	ClearParticles()
	ClearSprings()
	ClearBoxes()
	ClearJoints()
	
	''
	Dim As BoxType Ptr B0 = CreateBox()
	
	B0->radius = Vec2( 50, 10 )
	
	B0->mass = ( 2.0 * B0->radius.x ) * ( 2.0 * B0->radius.y ) * density
	B0->inverse_mass = 0.0'1.0 / B1->mass
	
	B0->inertia = B0->mass / 12.0 * ( 2.0 * B0->radius.x ^ 2 + 2.0 * B0->radius.y ^ 2 )
	B0->inverse_inertia = 0.0'1.0 / B1->inertia
	
	B0->position.x   = 300
	B0->position.y   = 100
	
	B0->angle = 0.0
	B0->angle_vector = Vec2( Cos( B0->angle ), Sin( B0->angle ) )
	
	B0->angular_velocity = 0.0
	
	''
	Dim As BoxType Ptr B1 = CreateBox()
	
	B1->radius = Vec2( 50, 10 )
	
	B1->mass = ( 2.0 * B1->radius.x ) * ( 2.0 * B1->radius.y ) * density
	B1->inverse_mass = 1.0 / B1->mass
	
	B1->inertia = B1->mass / 12.0 * ( 2.0 * B1->radius.x ^ 2 + 2.0 * B1->radius.y ^ 2 )
	B1->inverse_inertia = 1.0 / B1->inertia
	
	B1->position.x   = 300
	B1->position.y   = 100
	
	B1->angle = 0.0
	B1->angle_vector = Vec2( Cos( B1->angle ), Sin( B1->angle ) )
	
	B1->angular_velocity = 0.0
	
	''
	Dim As BoxType Ptr B2 = CreateBox()
	
	B2->radius = Vec2( 50, 10 )
	
	B2->mass = ( 2.0 * B2->radius.x ) * ( 2.0 * B2->radius.y ) * density
	B2->inverse_mass = 1.0 / B2->mass
	
	B2->inertia = B2->mass / 12.0 * ( 2.0 * B2->radius.x ^ 2 + 2.0 * B2->radius.y ^ 2 )
	B2->inverse_inertia = 1.0 / B2->inertia
	
	B2->position.x   = 400
	B2->position.y   = 100
	
	B2->angle = 0.0
	B2->angle_vector = Vec2( Cos( B2->angle ), Sin( B2->angle ) )
	
	B2->angular_velocity = 0.0
	
	''
	Dim As BoxType Ptr B3 = CreateBox()
	
	B3->radius = Vec2( 50, 10 )
	
	B3->mass = ( 2.0 * B3->radius.x ) * ( 2.0 * B3->radius.y ) * density
	B3->inverse_mass = 1.0 / B3->mass
	
	B3->inertia = B3->mass / 12.0 * ( 2.0 * B3->radius.x ^ 2 + 2.0 * B3->radius.y ^ 2 )
	B3->inverse_inertia = 1.0 / B3->inertia
	
	B3->position.x   = 500
	B3->position.y   = 100
	
	B3->angle = 0.0
	B3->angle_vector = Vec2( Cos( B3->angle ), Sin( B3->angle ) )
	
	B3->angular_velocity = 0.0
	
	''
	Dim As BoxType Ptr B4 = CreateBox()
	
	B4->radius = Vec2( 50, 10 )
	
	B4->mass = ( 2.0 * B4->radius.x ) * ( 2.0 * B4->radius.y ) * density
	B4->inverse_mass = 1.0 / B4->mass
	
	B4->inertia = B4->mass / 12.0 * ( 2.0 * B4->radius.x ^ 2 + 2.0 * B4->radius.y ^ 2 )
	B4->inverse_inertia = 1.0 / B4->inertia
	
	B4->position.x   = 600
	B4->position.y   = 100
	
	B4->angle = 0.0
	B4->angle_vector = Vec2( Cos( B4->angle ), Sin( B4->angle ) )
	
	B4->angular_velocity = 0.0
	
	''
	Dim As JointType Ptr J0 = CreateJoint()
	
	J0->box_a = B0
	J0->box_b = B1
	
	J0->anchor_a = Vec2( 250, 100 ) - J0->box_a->position
	J0->anchor_b = Vec2( 250, 100 ) - J0->box_b->position
	
	Dim As JointType Ptr J1 = CreateJoint()
	
	J1->box_a = B1
	J1->box_b = B2
	
	J1->anchor_a = Vec2( 350, 100 ) - J1->box_a->position
	J1->anchor_b = Vec2( 350, 100 ) - J1->box_b->position
	
	Dim As JointType Ptr J2 = CreateJoint()
	
	J2->box_a = B2
	J2->box_b = B3
	
	J2->anchor_a = Vec2( 450, 100 ) - J2->box_a->position
	J2->anchor_b = Vec2( 450, 100 ) - J2->box_b->position
	
	Dim As JointType Ptr J3 = CreateJoint()
	
	J3->box_a = B3
	J3->box_b = B4
	
	J3->anchor_a = Vec2( 550, 100 ) - J3->box_a->position
	J3->anchor_b = Vec2( 550, 100 ) - J3->box_b->position
	
	
	'' create particles
	Dim As particletype Ptr P = CreateParticle()
		
	P->mass         = 1.0
	P->inverse_mass = 0
	P->radius       = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
	P->position.x   = 0.5 * screen_wid
	P->position.y   = 0.25 * screen_hgt
	
	For i As integer = 2 To num_Particles
		
		Dim As particletype Ptr P = CreateParticle()
		
		P->mass         = 1.0
		P->inverse_mass = 1.0 / P->mass
		P->radius       = 0.0
		
		If i = num_Particles Then
			
			P->mass = 200.0
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
		'S->reduced_mass = IIf( inverseMass = 0.0 , 0.0 , ( S->particle_a->mass * S->particle_b->mass ) / ( S->particle_a->mass + S->particle_b->mass ) )
		
	Next

End Sub

Sub SimulationType.Demo2()
	
	'' Rigid chain
	
	iterations   = 8
	warmstart    = 1
	cStiffness   = 0.5
	cDamping     = 1.0
	cWarmstart   = 1.0
	
	Dim As Integer num_Particles = 11
	Dim As Integer num_Springs   = 10
	
	DemoText = "Demo 2: Rigid chain. The top spring lifts a total mass 1024 times heavier than it is tuned for."
	
	''
	ClearParticles()
	ClearSprings()
	ClearBoxes()
	ClearJoints()
	
	Dim As particletype Ptr P = CreateParticle()
	
	P->mass         = 1.0
	P->inverse_mass = 0.0
	P->radius       = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
	P->position.x   = 0.5 * screen_wid
	P->position.y   = 0.25 * screen_hgt
	
	'' create particles
	For i As Integer = 2 To num_Particles
		
		P = CreateParticle()
		
		P->mass         = (P-1)->mass * 2.0
		P->inverse_mass = 1.0 / P->mass
		P->radius       = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
		P->position.x   = (P-1)->position.x + (P-1)->radius + P->radius
		P->position.y   = 0.25 * screen_hgt
		
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

Sub SimulationType.Demo3()
	
	'' Horizontal steel girder
	
	iterations   = 10
	warmstart    = 1
	cStiffness   = 1.0
	cDamping     = 1.0
	cWarmstart   = 0.5
	
	Dim As Integer GirderWidth  = 2
	Dim As Integer GirderLength = 22
	Dim As Integer SpringLength = 40
	
	DemoText = "Demo 3: Horizontal steel girder. Connecting springs at right angles increases stability. (And NO dirty thoughts!)"
	
	''
	ClearParticles()
	ClearSprings()
	ClearBoxes()
	ClearJoints()
	
	''	particles
	for i as integer = 1 to GirderLength
		for j as integer = 1 to GirderWidth
		
			Dim As particletype Ptr P = CreateParticle()
			
			P->mass         = 1.0
			P->inverse_mass = 1.0 / P->mass
			P->radius       = 0.0
			P->velocity     = Vec2().randomizesquare( 10.0 )
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
	cWarmstart   = 0.5
	
	Dim As Integer GirderWidth  = 2
	Dim As Integer GirderLength = 32
	Dim As Integer SpringLength = 20
	
	DemoText = "Demo 4: Vertical steel girder fighting gravity."
	
	''
	ClearParticles()
	ClearSprings()
	ClearBoxes()
	ClearJoints()
	
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
	cStiffness   = 0.25 
	cDamping     = 1.0
	cWarmstart   = 0.5
	
	Dim As Integer num_Particles = 96
	Dim As Integer num_Springs   = 95
	Dim As Integer state         = 1000
	
	DemoText = "Demo 5: Rigid chain stabilization. The masses get random state vectors in the range +/- " & state & " but stabilizes very fast."
	
	''
	ClearParticles()
	ClearSprings()
	ClearBoxes()
	ClearJoints()
	
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
	warmstart    = 1
	cStiffness   = 1.0
	cDamping     = 1.0
	cWarmstart   = 0.5
	
	Dim As Integer num_Particles = 48
	Dim As Integer num_Springs   = 47
	
	DemoText = "Demo 6: Suspension bridge."
	
	''
	ClearParticles()
	ClearSprings()
	ClearBoxes()
	ClearJoints()
	
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



'' Core physics functions
Sub SimulationType.ComputeRestimpulse()
	
	'' Compute the impulse needed to satisfy the constraint in one loop
	
	''
	For S As SpringType Ptr = SpringLo To SpringHi
		
		Dim As Vec2 distance = S->particle_b->position - S->particle_a->position
		Dim As Vec2 velocity = S->particle_b->velocity - S->particle_a->velocity
		
		S->unit = distance.Unit()
		
		Dim As Single distance_error = S->unit.dot( distance ) - S->rest_distance
		Dim As Single velocity_error = S->unit.dot( velocity )
		
		S->rest_impulse = -cstiffness * distance_error * inv_dt - cdamping * velocity_error
		
	Next
	
	''
	For J As JointType Ptr = JointLo To JointHi
		
		Dim As Vec2 r_a = J->box_a->angle_vector.Rotateccw( J->anchor_a )
		Dim As Vec2 r_b = J->box_b->angle_vector.Rotateccw( J->anchor_b )
		
		Dim As Vec2 position_a = J->box_a->position + r_a
		Dim As Vec2 position_b = J->box_b->position + r_b
		
		Dim As Vec2 velocity_a = J->box_a->velocity + J->box_a->angular_velocity * r_a.perpccw
		Dim As Vec2 velocity_b = J->box_b->velocity + J->box_b->angular_velocity * r_b.perpccw
		
		Dim As Vec2 distance = position_b - position_a
		Dim As Vec2 velocity = velocity_b - velocity_a
		
		J->unit = distance.Unit()
		
		Dim As Single distance_error = J->unit.dot( distance )
		Dim As Single velocity_error = J->unit.dot( velocity )
		
		J->rest_impulse = -( cstiffness * distance_error * inv_dt + cdamping * velocity_error )
		
		Dim As Single rna = r_a.dot( J->Unit )
		Dim As Single rnb = r_b.dot( J->Unit )
		
		Dim As Single rta = r_a.perpdot( J->Unit )
		Dim As Single rtb = r_b.perpdot( J->Unit )
		
		Dim As Single Kn = J->box_a->inverse_mass + J->box_b->inverse_mass + _
		                   J->box_a->inverse_inertia * ( r_a.dot( r_a ) - rna * rna ) + _
		                   J->box_b->inverse_inertia * ( r_b.dot( r_b ) - rnb * rnb )
		                   
		Dim As Single Kt = J->box_a->inverse_mass + J->box_b->inverse_mass + _
		                   J->box_a->inverse_inertia * ( r_a.dot( r_a ) - rta * rta ) + _
		                   J->box_b->inverse_inertia * ( r_b.dot( r_b ) - rtb * rtb )
		
		
		J->reduced_normal_mass  = 1.0 / Kn
		
		J->reduced_tangent_mass  = 1.0 / Kt
		
		'J->reduced_mass = 1.0 / ( Kn + Kt )
		
	Next
	
End Sub

Sub SimulationType.ApplyCorrectiveimpulse()
	
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
	
	''
	For J As JointType Ptr = JointLo To JointHi
		
		Dim As Vec2 r_a = J->box_a->angle_vector.Rotateccw( J->anchor_a )
		Dim As Vec2 r_b = J->box_b->angle_vector.Rotateccw( J->anchor_b )
		
		Dim As Vec2 impulse_a = J->box_a->impulse + J->box_a->angular_impulse * r_a.perpccw
		Dim As Vec2 impulse_b = J->box_b->impulse + J->box_b->angular_impulse * r_b.perpccw
		
		Dim As Vec2 current_impulse = impulse_b - impulse_a
		
		Dim As Single impulse_error = J->unit.dot( current_impulse ) - J->rest_impulse
		
		'Dim As Vec2 corrective_impulse = -impulse_error * J->reduced_mass * J->Unit
		Dim As Vec2 corrective_normal_impulse = -impulse_error * J->reduced_normal_mass * J->Unit
		Dim As Vec2 corrective_tangent_impulse = -impulse_error * J->reduced_tangent_mass * J->Unit
		'Dim As Vec2 corrective_impulse = -impulse_error * 1.0 * J->Unit
		
		J->box_a->impulse -= corrective_normal_impulse * J->box_a->inverse_mass
		J->box_b->impulse += corrective_normal_impulse * J->box_b->inverse_mass
		
		J->box_a->angular_impulse -= corrective_tangent_impulse.perpdot( -r_a ) * J->box_a->inverse_inertia '* 0.5
		J->box_b->angular_impulse += corrective_tangent_impulse.perpdot( -r_b ) * J->box_b->inverse_inertia '* 0.5
		
		'J->accumulated_impulse += corrective_impulse
		
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
	
	''
	For J As JointType Ptr = JointLo To JointHi
		
		J->accumulated_impulse = Vec2( 0.0, 0.0 )
		
	Next
	
End Sub

Sub SimulationType.ComputeNewState()
	
	''
	For P As ParticleType Ptr = ParticleLo To ParticleHi
		
		If ( P->inverse_mass > 0.0 ) Then
			
			P->velocity += P->impulse
			P->position += P->velocity * dt 
			
		End If
		
		P->impulse = Vec2( 0.0, 0.0 )
		
	Next
	
	''
	For B As BoxType Ptr = BoxLo To BoxHi
		
		If ( B->inverse_mass > 0.0 ) Then
			
			B->velocity += B->impulse
			B->position += B->velocity * dt 
			
		End If
		
		If ( B->inverse_inertia > 0.0 ) Then
			
			B->angular_velocity += B->angular_impulse
			B->angle            += B->angular_velocity * dt
			
			B->angle_vector = Vec2( Cos( B->angle ), Sin( B->angle ) )
			
		EndIf
		
		B->impulse = Vec2( 0.0, 0.0 )
		B->angular_impulse = 0.0
		
	Next

End Sub

'' Graphics and interaction
Sub SimulationType.UpdateScreen()
	
	''
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
	
	''  draw particles background
	For P As ParticleType Ptr = ParticleLo To ParticleHi
		
		If ( P->radius > 0.0 ) Then
			
			Circle(P->position.x, P->position.y), P->radius + 5.0, RGB(0, 0, 0) ,,, 1, f
			
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
			
			Circle(P->position.x, P->position.y), 2.0, Col,,, 1, f
			
		End If
		
	Next
	
	'' Draw boxes
	For B As BoxType Ptr = BoxLo To BoxHi
		
		Circle( B->position.x, B->position.y ), 2.0, RGB( 255, 255, 0 ),,, 1, f
		
		Dim As Vec2 a1 = B->position + B->angle_vector * B->radius.x + B->angle_vector.perpccw * B->radius.y
		Dim As Vec2 a2 = B->position + B->angle_vector * B->radius.x - B->angle_vector.perpccw * B->radius.y
		Dim As Vec2 a3 = B->position - B->angle_vector * B->radius.x - B->angle_vector.perpccw * B->radius.y
		Dim As Vec2 a4 = B->position - B->angle_vector * B->radius.x + B->angle_vector.perpccw * B->radius.y

		Line( a1.x, a1.y )-( a2.x, a2.y ), RGB( 128, 128, 128 )
		Line( a2.x, a2.y )-( a3.x, a3.y ), RGB( 128, 128, 128 )
		Line( a3.x, a3.y )-( a4.x, a4.y ), RGB( 128, 128, 128 )
		Line( a4.x, a4.y )-( a1.x, a1.y ), RGB( 128, 128, 128 )

		'Circle( B->position.x - B->angle_vector.x * B->radius.x, B->position.y - B->angle_vector.y * B->radius.x ), 2.0, RGB( 128, 128, 128 ),,, 1, f

		
	Next
	
	''' draw joints
	'For J As JointType Ptr = JointLo To JointHi
	'	
	'	Dim As Vec2 r_a = J->box_a->angle_vector.Rotateccw( J->anchor_a )
	'	Dim As Vec2 r_b = J->box_b->angle_vector.Rotateccw( J->anchor_b )
	'	
	'	Dim As Vec2 position_a = J->box_a->position + r_a
	'	Dim As Vec2 position_b = J->box_b->position + r_b
	'	
	'	Dim As Vec2 velocity_a = J->box_a->velocity + J->box_a->angular_velocity * r_a.perpccw
	'	Dim As Vec2 velocity_b = J->box_b->velocity + J->box_b->angular_velocity * r_b.perpccw
	'	
	'	Dim As Vec2 distance = position_b - position_a
	'	Dim As Vec2 velocity = velocity_b - velocity_a
	'	
	'	J->unit = distance.Unit()
	'	
	'	Circle(J->box_a->position.x + r_a.x, J->box_a->position.y + r_a.y), 2, RGB( 255, 255, 0),,,1,f
	'	Circle(J->box_b->position.x + r_b.x, J->box_b->position.y + r_b.y), 2, RGB( 255, 255, 0),,,1,f
	'	
	'	Line( position_a.x, position_a.y )-( position_a.x + velocity_a.x, position_a.y + velocity_a.y ), RGB(255, 255,0)
	'	Line( position_b.x, position_b.y )-( position_b.x + velocity_b.x, position_b.y + velocity_b.y ), RGB(255, 255,0)
	'	
	'Next
	
	If ( Nearest <> 0 ) Then Circle(Nearest->position.x, Nearest->position.y), Nearest->radius + 8, RGB(255, 255, 255),,, 1
	If ( Picked <> 0 ) Then Circle(Picked->position.x, Picked->position.y), Picked->radius + 8, RGB(255, 255, 0),,, 1
	
	''
	ScreenCopy()
	
End Sub

Sub SimulationType.CreateScreen( ByVal Wid As Integer, ByVal Hgt As Integer )
   
   ScreenRes Wid, Hgt, 32, 2, fb.GFX_ALPHA_PRIMITIVES
   
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

Sub SimulationType.ClearJoints()
	
	numJoints = 0
	
	JointLo = @joint( 1 )
	JointHi = @joint( 1 )
	
	For i As Integer = 1 To max_joints
		
		With joint(i)
			
			.accumulated_impulse = Vec2( 0.0, 0.0 )
			.unit                = Vec2( 0.0, 0.0 )
			
			.anchor_a = Vec2( 0.0, 0.0 )
			.anchor_b = Vec2( 0.0, 0.0 )
			
			.reduced_mass = 0.0
			.rest_impulse = 0.0
			
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

Function SimulationType.CreateJoint() As JointType Ptr
	
	If ( numJoints < max_joints - 1 ) Then
		
		numJoints += 1
		
		JointHi = @joint( numJoints )
		
		Return JointHi 
		
	End If
	
End Function
	
