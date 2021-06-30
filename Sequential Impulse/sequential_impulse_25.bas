''*******************************************************************************
''
''  Stable and rigid damped springs using sequential impulses and warmstart
''
''  Version 0.25, August 2017, Michael "h4tt3n" Nissen
''
''  This version onwards includes angular springs.
''
''  Bug: angular coeff. = zero produces jitter
''  Bug: angular warmstart produces jitter
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
Const As Single  gravity            = 10.0             ''  gravity
Const As Single  density            = 0.5             ''  ball density
Const As Single  pi                 = 4.0 * Atn( 1.0 ) ''  pi
Const As Integer screen_wid         = 1000             ''  screen width
Const As Integer screen_hgt         = 800              ''  screen height
Const As Integer pick_distance      = 128^2            ''  mouse pick up distance
Const As Integer max_particles      = 8192             ''  particles
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
	
	As Vec2 local_position_a
	As Vec2 local_position_b
	
	As Vec2 local_velocity_a
	As Vec2 local_velocity_b
	
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
	
	Declare Sub CreateScreen( ByVal Wid As Integer, ByVal Hgt As Integer )
	
	Declare Function CreateParticle() As ParticleType Ptr
	Declare Function CreateSpring() As SpringType Ptr
	Declare Function CreateAngularSpring() As AngularSpringType Ptr
	
	Declare Sub ClearParticles()
	Declare Sub ClearSprings()
	Declare Sub ClearAngularSprings()
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
		
		UpdateInput()
		
		'' gravity
		For P As ParticleType Ptr = ParticleLo To ParticleHi
		
			If ( P->inverse_mass > 0.0 ) Then
				
				P->velocity += Vec2( 0.0, dt * gravity )
				
			End If
			
		Next
		
		''
		ComputeReusableData()
		
		UpdateScreen()
		
		''
		If warmstart = 1 Then 
			
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
		
	Loop

End Sub


'' Demos
Sub SimulationType.Demo1()
	
	'' Wrecking ball
	
	iterations   = 10
	warmstart    = 0
	
	cStiffness   = 1.0   
	cDamping     = 1.0
	cWarmstart   = 0.5
	
	cAstiffness  = 0.2
	cAdamping    = 0.5
	cAwarmstart  = 0.5
	
	DemoText = ""
	
	''
	ClearParticles()
	ClearSprings()
	ClearAngularSprings()

End Sub

Sub SimulationType.Demo2()
	
	'' Wrecking ball
	
	iterations   = 4
	warmstart    = 1
	
	cStiffness   = 0.5  
	cDamping     = 1.0  
	cWarmstart   = 0.5
	
	cAstiffness  = 0.5
	cAdamping    = 1.0 
	cAwarmstart  = 0.5
	
	Dim As Integer num_Particles       = 202
	Dim As Integer num_Springs         = 201
	Dim As Integer num_angular_Springs = 200
	Dim As Integer SpringLength        = 100.0
	Dim As Single  Angle               = 3/4 * 2 * Pi
	Dim As Single  delta_Angle         = 0.05 * 2 * Pi
	
	DemoText = ""
	
	''
	ClearParticles()
	ClearSprings()
	ClearAngularSprings()
	
	Randomize
	
	'' create particles
	'Dim As particletype Ptr P = CreateParticle()
	'
	'P->mass         = 1.0
	'P->inverse_mass = 0.0
	'P->radius       = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
	'P->position.x   = 0.5 * screen_wid
	'P->position.y   = 0.5 * screen_hgt
	'
	For i As integer = 1 To num_Particles
		
		Dim As particletype Ptr P = CreateParticle()
		
		P->mass = 10.0 + ( Rnd() - Rnd() ) * 5.0
		
		If i = num_Particles Then
			
			'P->mass = 10000.0
			
		EndIf
		
		P->inverse_mass = 1.0 / P->mass
		
		
		If i = 1 Then
			
			P->inverse_mass = 0.0
			
		EndIf
		
		P->radius  = ( ( P->mass / density ) / (4/3) * pi ) ^ (1/3) 
		
		P->position = 0.5 * Vec2( screen_wid, screen_hgt * 0.5 ) + Vec2().RandomizeCircle( 5.0 ) + Vec2( Cos(Angle), Sin(Angle) ) * SpringLength
		
		
		''delta_angle -= 0.001
		Angle += delta_angle
		''SpringLength += 4
		
		'If i = 1 Or i = 2 Or i = 3 Then
		'	
		'	P->inverse_mass = 0.0
		'	
		'EndIf
		
	Next
	
	'' create springs
	For i As Integer = 1 To num_Springs
		
		Dim As SpringType Ptr S = CreateSpring()
				
		S->particle_a    = @particle( i )
		S->particle_b    = @particle( i + 1 )
		S->rest_distance = ( S->particle_b->position - S->particle_a->position ).length()
		S->unit          = ( S->particle_b->position - S->particle_a->position ).unit()
		
		Dim As Single inverseMass = S->particle_a->inverse_mass + S->particle_b->inverse_mass
		
		S->reduced_mass = IIf( inverseMass > 0.0 , 1.0 / inverseMass , 0.0 )
		
	Next
	
	'' create angular springs
	For i As Integer = 1 To num_angular_Springs
		
		Dim As AngularSpringType Ptr A = CreateAngularSpring()
		
		A->spring_a = @spring( i )
		A->spring_b = @spring( i + 1 )
		
		A->rest_angle = Vec2( A->spring_a->unit.dot( A->spring_b->unit ), _
		                      A->spring_a->unit.perpdot( A->spring_b->unit ) )
		
	Next

	
End Sub



'' Core physics functions
Sub SimulationType.ComputeReusableData()
	
	''	Linear springs
	For S As SpringType Ptr = SpringLo To SpringHi
		
		'' desired "rest impulse" needed to satisfy the constraint
		Dim As Vec2 distance = S->particle_b->position - S->particle_a->position
		Dim As Vec2 velocity = S->particle_b->velocity - S->particle_a->velocity
		
		S->unit = distance.Unit()
		
		Dim As Single distance_error = S->unit.dot( distance ) - S->rest_distance
		Dim As Single velocity_error = S->unit.dot( velocity )
		
		S->rest_impulse = - cstiffness * distance_error * inv_dt - cdamping * velocity_error
		
		'' spring state vectors
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
		
		'' particle local state vectors relative to spring state vector
		S->local_position_a = S->Particle_a->Position - S->Position
		S->local_position_b = S->Particle_b->Position - S->Position
		
		S->local_velocity_a = S->Particle_a->Velocity - S->Velocity
		S->local_velocity_b = S->Particle_b->Velocity - S->Velocity
		
		'' moment of inertia and inverse
		S->inertia = S->local_position_a.lengthsquared() * S->particle_a->mass + _
		             S->local_position_b.lengthsquared() * S->particle_b->mass
		
		S->inverse_inertia = IIf( S->inertia > 0.0 , 1.0 / S->inertia, 0.0 )
		
		'' angular velocity
		S->angular_velocity = ( S->local_position_a.PerpDot( S->local_velocity_a * S->particle_a->mass ) + _
	                           S->local_position_b.PerpDot( S->local_velocity_b * S->particle_b->Mass ) ) * _
	                           S->inverse_inertia
		
	Next
	
	'' Angular springs
	For A As AngularSpringType Ptr = AngularSpringLo To AngularSpringHi
		
		'' angle between springs, Vec2( cos angle, sin angle )
		A->angle = Vec2( A->spring_a->unit.dot( A->spring_b->unit ), _
		                 A->spring_a->unit.perpdot( A->spring_b->unit ) )
		
		'' errors
		'Dim As Single angle_error = ATan2 ( A->rest_angle.perpdot( A->angle ), A->rest_angle.dot( A->angle ) )
		'Dim As Single angle_error = A->rest_angle.perpdot( A->angle )
		Dim As Single angle_error = A->rest_angle.perpdot( A->angle )
		
		Dim As Single velocity_error = A->spring_b->angular_velocity - A->spring_a->angular_velocity
		
		'' reduced moment of inertia
		Dim As Single inverse_inertia = A->spring_a->inverse_inertia + A->spring_b->inverse_inertia
		
		A->reduced_inertia = IIf( inverse_inertia > 0.0 , 1.0 / inverse_inertia , 0.0 )
		
		'' desired "rest impulse" needed to satisfy the constraint
		A->rest_impulse = -castiffness * angle_error * inv_dt - cadamping * velocity_error 
		
	Next
	
End Sub

Sub SimulationType.ApplyCorrectiveimpulse()
	
	'' Angular springs
	For A As AngularSpringType Ptr = AngularSpringLo To AngularSpringHi Step 1
		
		'' 
		Dim As SpringType Ptr S_a = A->spring_a
		Dim As SpringType Ptr S_b = A->spring_b
		
		'' current linear impulse
		Dim As Single LocalImpulse_aa = S_a->Local_Position_a.PerpDot( S_a->particle_a->Impulse )
		Dim As Single LocalImpulse_ab = S_a->Local_Position_b.PerpDot( S_a->particle_b->Impulse )
		
		Dim As Single LocalImpulse_ba = S_b->Local_position_a.PerpDot( S_b->particle_a->Impulse )
		Dim As Single LocalImpulse_bb = S_b->Local_position_b.PerpDot( S_b->particle_b->Impulse )
		
		'' current angular impulse
		Dim As Single AngularImpulse_a = LocalImpulse_aa * S_a->particle_a->Mass * S_a->inverse_Inertia + _
		                                 LocalImpulse_ab * S_a->particle_b->Mass * S_a->inverse_Inertia
		
		Dim As Single AngularImpulse_b = LocalImpulse_ba * S_b->particle_a->Mass * S_b->inverse_Inertia + _
		                                 LocalImpulse_bb * S_b->particle_b->Mass * S_b->inverse_Inertia
		
		'' corrective angular impulse
		Dim As Single delta_impulse = AngularImpulse_b - AngularImpulse_a
			
		Dim As Single impulse_error = delta_impulse - A->Rest_Impulse
		
		Dim As Single corrective_impulse = -impulse_error * A->Reduced_Inertia
		
		Dim As Single new_Angular_Impulse_a = corrective_impulse * S_a->Inverse_Inertia 
		Dim As Single new_Angular_Impulse_b = corrective_impulse * S_b->Inverse_Inertia
		
		'' apply corrective linear impulse
		S_a->particle_a->Impulse -= S_a->Local_Position_a.PerpDot( new_Angular_Impulse_a )
		S_a->particle_b->Impulse -= S_a->Local_Position_b.PerpDot( new_Angular_Impulse_a )
		
		S_b->particle_a->Impulse += S_b->Local_Position_a.PerpDot( new_Angular_Impulse_b )
		S_b->particle_b->Impulse += S_b->Local_Position_b.PerpDot( new_Angular_Impulse_b )
			
		'' save for warmstart
		A->Accumulated_Impulse += corrective_impulse
		
	Next
	
	For A As AngularSpringType Ptr = AngularSpringHi To AngularSpringLo Step -1
		
		'' 
		Dim As SpringType Ptr S_a = A->spring_a
		Dim As SpringType Ptr S_b = A->spring_b
		
		'' current linear impulse
		Dim As Single LocalImpulse_aa = S_a->Local_Position_a.PerpDot( S_a->particle_a->Impulse )
		Dim As Single LocalImpulse_ab = S_a->Local_Position_b.PerpDot( S_a->particle_b->Impulse )
		
		Dim As Single LocalImpulse_ba = S_b->Local_position_a.PerpDot( S_b->particle_a->Impulse )
		Dim As Single LocalImpulse_bb = S_b->Local_position_b.PerpDot( S_b->particle_b->Impulse )
		
		'' current angular impulse
		Dim As Single AngularImpulse_a = LocalImpulse_aa * S_a->particle_a->Mass * S_a->inverse_Inertia + _
		                                 LocalImpulse_ab * S_a->particle_b->Mass * S_a->inverse_Inertia
		
		Dim As Single AngularImpulse_b = LocalImpulse_ba * S_b->particle_a->Mass * S_b->inverse_Inertia + _
		                                 LocalImpulse_bb * S_b->particle_b->Mass * S_b->inverse_Inertia
		
		'' corrective angular impulse
		Dim As Single delta_impulse = AngularImpulse_b - AngularImpulse_a
			
		Dim As Single impulse_error = delta_impulse - A->Rest_Impulse
		
		Dim As Single corrective_impulse = -impulse_error * A->Reduced_Inertia
		
		Dim As Single new_Angular_Impulse_a = corrective_impulse * S_a->Inverse_Inertia 
		Dim As Single new_Angular_Impulse_b = corrective_impulse * S_b->Inverse_Inertia
		
		'' apply corrective linear impulse
		S_a->particle_a->Impulse -= S_a->Local_Position_a.PerpDot( new_Angular_Impulse_a )
		S_a->particle_b->Impulse -= S_a->Local_Position_b.PerpDot( new_Angular_Impulse_a )
		
		S_b->particle_a->Impulse += S_b->Local_Position_a.PerpDot( new_Angular_Impulse_b )
		S_b->particle_b->Impulse += S_b->Local_Position_b.PerpDot( new_Angular_Impulse_b )
		
		'' save for warmstart
		A->Accumulated_Impulse += corrective_impulse
		
	Next
	
	'' Linear springs
	For S As SpringType Ptr = SpringLo To SpringHi Step 1
		
		''	delta impulse
		Dim As Vec2 delta_impulse = S->particle_b->impulse - S->particle_a->impulse
		
		'' impulse error
		Dim As Single impulse_error = S->unit.dot( delta_impulse ) - S->rest_impulse
		
		'' corrective impulse
	   Dim As Vec2 corrective_impulse = -impulse_error * S->reduced_mass * S->unit
		
		S->particle_a->impulse -= corrective_impulse * S->particle_a->inverse_mass
		S->particle_b->impulse += corrective_impulse * S->particle_b->inverse_mass
		
		'' save for warmstart
		S->accumulated_impulse += corrective_impulse
		
	Next
	
	For S As SpringType Ptr = SpringHi To SpringLo Step -1
		
		''	delta impulse
		Dim As Vec2 delta_impulse = S->particle_b->impulse - S->particle_a->impulse
		
		'' impulse error
		Dim As Single impulse_error = S->unit.dot( delta_impulse ) - S->rest_impulse
		
		'' corrective impulse
	   Dim As Vec2 corrective_impulse = -impulse_error * S->reduced_mass * S->unit
		
		S->particle_a->impulse -= corrective_impulse * S->particle_a->inverse_mass
		S->particle_b->impulse += corrective_impulse * S->particle_b->inverse_mass
		
		'' save for warmstart
		S->accumulated_impulse += corrective_impulse
		
	Next
	
End Sub

Sub SimulationType.ApplyWarmStart()
	
	'' Warm starting. Use the sum of previously applied impulses
	'' projected onto new normal vector as initial iteration value.
	''	This is roughly equivalent of doubling the number of iterations.
	
	'' Angular springs
	For A As AngularSpringType Ptr = AngularSpringLo To AngularSpringHi
		
		Dim As SpringType Ptr S_a = A->spring_a
		Dim As SpringType Ptr S_b = A->spring_b
		
		Dim As Single warmstart_impulse = cawarmstart * A->Accumulated_Impulse
		
		Dim As Single new_Angular_Impulse_a = warmstart_impulse * A->spring_a->Inverse_Inertia 
		Dim As Single new_Angular_Impulse_b = warmstart_impulse * A->spring_b->Inverse_Inertia
		
		'' apply linear
		A->spring_a->particle_a->Impulse -= S_a->Local_Position_a.PerpDot( new_Angular_Impulse_a )
		A->spring_a->particle_b->Impulse -= S_a->Local_Position_b.PerpDot( new_Angular_Impulse_a )
		
		A->spring_b->particle_a->Impulse += S_b->Local_Position_a.PerpDot( new_Angular_Impulse_b )
		A->spring_b->particle_b->Impulse += S_b->Local_Position_b.PerpDot( new_Angular_Impulse_b )
		
		''
		A->Accumulated_Impulse = 0.0
		
	Next
	
	'' Linear springs
	For S As SpringType Ptr = SpringLo To SpringHi
		
		Dim As Single projected_impulse = S->unit.dot( S->accumulated_impulse )
		
		If ( projected_impulse < 0.0 ) Then
			
			Dim As Vec2 warmstart_impulse = cwarmstart * projected_impulse * S->unit
			
			S->particle_a->impulse -= warmstart_impulse * S->particle_a->inverse_mass 
			S->particle_b->impulse += warmstart_impulse * S->particle_b->inverse_mass
			
		End If
		
		S->accumulated_impulse = Vec2( 0.0, 0.0 )
		
	Next
	
End Sub

Sub SimulationType.ComputeNewState()
	
	''	Compute new state vectors
	
	For P As ParticleType Ptr = ParticleLo To ParticleHi
		
		'If ( P->inverse_mass > 0.0 And P <> picked ) Then
		If ( P->inverse_mass > 0.0 ) Then
			
			P->velocity += P->impulse
			P->position += P->velocity * dt 
			
		End If
		
		P->impulse = Vec2( 0.0, 0.0 )
		
	Next

End Sub

'' Graphics and interaction
Sub SimulationType.UpdateScreen()
		
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
			
			Dim As vec2 impulse = P->position + ( P->impulse + P->velocity ) * dt
			
			Line (P->position.x, P->position.y)-(impulse.x, impulse.y), RGBA( 0, 255, 0 , 128 )
			
			Circle(impulse.x, impulse.y), P->radius + 5, RGBA(0, 255, 0, 128) ,,, 1, f
			
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
		VelocityVector = picked->Velocity
		
		picked->impulse = -DistanceVector * inv_dt * 0.5 - VelocityVector
		
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
			
			''' 
			'If ( MultiKey( fb.SC_S ) And ( e.scancode = fb.SC_UP   ) ) Then caStiffness += 0.002
			'If ( MultiKey( fb.SC_S ) And ( e.scancode = fb.SC_DOWN ) ) Then caStiffness -= 0.002
			'
			''' 
			'If ( MultiKey( fb.SC_D ) And ( e.scancode = fb.SC_UP   ) ) Then caDamping += 0.002
			'If ( MultiKey( fb.SC_D ) And ( e.scancode = fb.SC_DOWN ) ) Then caDamping -= 0.002
			'
			''' 
			'If ( MultiKey( fb.SC_W ) And ( e.scancode = fb.SC_UP   ) ) Then caWarmstart += 0.002
			'If ( MultiKey( fb.SC_W ) And ( e.scancode = fb.SC_DOWN ) ) Then caWarmstart -= 0.002
			
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
	
	If caStiffness < 0.0 Then caStiffness = 0.0
	If caStiffness > 1.0 Then caStiffness = 1.0
	
	If caDamping < 0.0 Then caDamping = 0.0
	If caDamping > 1.0 Then caDamping = 1.0
	
	If caWarmstart < 0.0 Then caWarmstart = 0.0
	If caWarmstart > 1.0 Then caWarmstart = 1.0
	
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

Sub SimulationType.ClearWarmstart()
	
	For S As SpringType Ptr = SpringLo To SpringHi
	
		S->accumulated_impulse = Vec2( 0.0, 0.0 )
		
	Next
	
	For S As AngularSpringType Ptr = AngularSpringLo To AngularSpringHi
	
		S->accumulated_impulse = 0.0
		
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
