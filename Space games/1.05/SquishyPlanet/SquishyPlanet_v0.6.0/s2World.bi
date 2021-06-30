''******************************************************************************
''    
''   Squishy2D World Class
''   Written in FreeBASIC 1.05
''   version 0.2.0, June 2016, Michael "h4tt3n" Nissen
''
''****************************************************************************** 


''
#Ifndef __S2_WORLD_BI__
#Define __S2_WORLD_BI__


''
Type World
	
	Public:
	
	'' Constructors
	Declare Constructor()
	Declare Constructor( ByRef w As World )
	
	'' Destructor
	Declare Destructor()
	
	'' Operators
	Declare Operator Let( ByRef w As World )
	
	'' Apply
	Declare Sub ApplyImpulses()
	Declare Sub ApplyWarmStart()
	
	'' Compute
	Declare Sub ComputeBroadPhase()
	Declare Sub ComputeData()
	Declare Sub ComputeNarrowPhase()
	Declare Sub ComputeNewState()
	
	Declare Sub WhatAmIOrbiting( ByVal particle As Particle Ptr, ByVal array As NewtonGravityArray Ptr )
	
	
	'' Create
	Declare Function CreateAngularSpring( ByVal stiffnes  As Single, _
	                                      ByVal damping   As Single, _
	                                      ByVal warmstart As Single, _
	                                      ByRef rotate_a  As Rotate Ptr, _
	                                      ByRef rotate_b  As Rotate Ptr ) As AngularSpring Ptr
	
	Declare Function CreateAngularSpring( ByVal stiffnes        As Single, _
	                                      ByVal damping         As Single, _
	                                      ByVal warmstart       As Single, _
	                                      ByVal restanglevector As Vec2, _
	                                      ByRef rotate_a        As Rotate Ptr, _
	                                      ByRef rotate_b        As Rotate Ptr ) As AngularSpring Ptr
	
	Declare Function CreateAngularSpring( ByVal stiffnes  As Single, _
	                                      ByVal damping   As Single, _
	                                      ByVal warmstart As Single, _
	                                      ByVal restangle As Single, _
	                                      ByRef rotate_a  As Rotate Ptr, _
	                                      ByRef rotate_b  As Rotate Ptr ) As AngularSpring Ptr
	
	Declare Function CreateBody( ByVal _position    As Vec2, _
	                             ByVal _num_objects As Integer )As Body Ptr
	
	Declare Function CreateFixedSpring( ByVal stiffnes   As Single, _
	                                    ByVal damping    As Single, _
	                                    ByVal warmstart  As Single, _
	                                    ByRef particle_a As Particle Ptr, _
	                                    ByRef particle_b As Particle Ptr ) As FixedSpring Ptr
	
	Declare Function CreateFixedSpring( ByVal stiffnes   As Single, _
	                                    ByVal damping    As Single, _
	                                    ByVal warmstart  As Single, _
	                                    ByVal restlength As Vec2, _
	                                    ByRef particle_a As Particle Ptr, _
	                                    ByRef particle_b As Particle Ptr ) As FixedSpring Ptr
	
	Declare Function CreateKeplerOrbit( ByVal particle_a As Particle Ptr, _
	                                    ByVal particle_b As Particle Ptr ) As KeplerOrbit Ptr
	
	Declare Function CreateLinearSpring( ByVal stiffness  As Single, _
	                                     ByVal damping    As Single, _
	                                     ByVal warmstart  As Single, _
	                                     ByVal particle_a As Particle Ptr, _
	                                     ByVal particle_b As Particle Ptr ) As LinearSpring Ptr
	
	Declare Function CreateLinearSpring( ByVal stiffness  As Single, _
	                                     ByVal damping    As Single, _
	                                     ByVal warmstart  As Single, _
	                                     ByVal restlength As Single, _
	                                     ByVal particle_a As Particle Ptr, _
	                                     ByVal particle_b As Particle Ptr ) As LinearSpring Ptr
	
	Declare Function CreateNewtonGravity( ByVal particle_a As Particle Ptr, _
	                                      ByVal particle_b As Particle Ptr ) As NewtonGravity Ptr
	
	Declare Function CreateParticle( ByVal mass     As Single, _
	                                 ByVal position As Vec2 ) As Particle Ptr
		
	Declare Function CreateParticle( ByVal mass     As Single, _
	                                 ByVal radius   As Single, _
	                                 ByVal position As Vec2 ) As Particle Ptr
	
	Declare Function CreatePressureBody( ByVal n        As Integer, _
	                                     ByVal position As Vec2 ) As PressureBody Ptr
	
	Declare Function CreateRotate( ByVal mass     As Single, _
	                               ByVal radius   As Single, _
	                               ByVal position As Vec2 ) As Rotate Ptr
	
	Declare Function CreateRotate( ByVal mass     As Single, _
	                               ByVal radius   As Single, _
	                               ByVal angle    As Single, _
	                               ByVal position As Vec2 ) As Rotate Ptr
	
	Declare Function CreateRotate( ByVal mass        As Single, _
	                               ByVal radius      As Single, _
	                               ByVal anglevector As Vec2, _
	                               ByVal position    As Vec2 ) As Rotate Ptr
	
	Declare Function CreateSpringBody( ByVal particles As Integer, _
	                                   ByVal position  As Vec2 ) As SpringBody Ptr
	
	Declare Function CreateSpringBody( ByVal particles As Integer, _
	                                   ByVal radius    As Single, _
	                                   ByVal position  As Vec2 ) As SpringBody Ptr
	
	
	'' Merge / Split
	Declare Function MergeParticles( ByVal particle_a As Particle Ptr, _
	                                 ByVal particle_b As Particle Ptr ) As Particle
	
	Declare Function SplitParticle( ByVal P As Particle Ptr, _
	                                ByVal C As Single ) As Particle
	
	'Protected:
	
	'' Flags
	As UInteger Flags                    ''
	
	'' Variables
	As Double CurrentTime               ''
	As Double StartupTime               ''             
	
	As Grid Grid_
	
	'' Object arrays ( All physical objects are stored here )
	As AngularSpringArray  AngularSprings_
	As BodyArray           Bodys_
	As FixedSpringArray    FixedSprings_
	As KeplerOrbitArray    KeplerOrbits_
	As LineSegmentArray    LineSegments_
	As LinearSpringArray   LinearSprings_
	As NewtonGravityArray  NewtonGravitys_
	As ParticleArray       Particles_
	As PressureBodyArray   PressureBodys_
	As RotateArray         Rotates_
	As SpringBodyArray     SpringBodys_
	
End Type


'' Constructors
Constructor World()
	
	''
	AngularSprings_.Reserve ( MAX_ANGULAR_SPRINGS )
	Bodys_.Reserve          ( MAX_BODYS )
	FixedSprings_.Reserve   ( MAX_FIXED_SPRINGS )
	KeplerOrbits_.Reserve   ( MAX_KEPLER_ORBITS )
	LinearSprings_.Reserve  ( MAX_LINEAR_SPRINGS )
	LineSegments_.Reserve   ( MAX_LINE_SEGMENTS )
	NewtonGravitys_.Reserve ( MAX_NEWTON_GRAVITYS )
	Particles_.Reserve      ( MAX_PARTICLES )
	Pressurebodys_.Reserve  ( MAX_PRESSURE_BODYS )
	Rotates_.Reserve        ( MAX_ROTATES )
	Springbodys_.Reserve    ( MAX_SPRING_BODYS )
	
End Constructor

Constructor World( ByRef w As World )
	
	This = w
	
End Constructor


'' Destructor
Destructor World()
	
	''
	AngularSprings_.Clear()
	Bodys_.Clear()
	FixedSprings_.Clear()
	KeplerOrbits_.Clear()
	LinearSprings_.Clear()
	LineSegments_.Clear()
	NewtonGravitys_.Clear()
	Particles_.Clear()
	PressureBodys_.Clear()
	Rotates_.Clear()
	SpringBodys_.Clear()
	
End Destructor


'' Operators
Operator World.Let( ByRef w As World )
	
	If ( @This <> @w ) Then
		
		''
		AngularSprings_  = w.AngularSprings_
		Bodys_           = w.Bodys_
		FixedSprings_    = w.FixedSprings_
		KeplerOrbits_    = w.KeplerOrbits_
		LinearSprings_   = w.LinearSprings_
		LineSegments_    = w.LineSegments_
		NewtonGravitys_  = w.NewtonGravitys_
		Particles_       = w.Particles_
		PressureBodys_   = w.PressureBodys_
		Rotates_         = w.Rotates_
		SpringBodys_     = w.SpringBodys_
		
	EndIf
	
End Operator


'' Apply
Sub World.ApplyImpulses()
	
	''
	If ( NewtonGravitys_.size > 0 ) Then
			
		For I As NewtonGravity Ptr = NewtonGravitys_.p_front To NewtonGravitys_.p_back
			
			I->applyImpulse()
			
		Next
		
	EndIf
	
	For I As Integer = 1 To NUM_ITERATIONS
		
		''
		If ( AngularSprings_.size > 0 ) Then 
			
			For II As AngularSpring Ptr = AngularSprings_.p_front To AngularSprings_.p_back
				
				II->applyCorrectiveImpulse()
				
			Next
			
		End If
		
		''
		If ( FixedSprings_.size > 0 ) Then 
			
			For II As FixedSpring Ptr = FixedSprings_.p_front To FixedSprings_.p_back
				
				II->applyCorrectiveImpulse()
				
			Next
			
		End If
		
		''
		If ( LinearSprings_.size > 0 ) Then 
			
			For II As LinearSpring Ptr = LinearSprings_.p_front To LinearSprings_.p_back
				
				II->applyCorrectiveImpulse()
				
			Next
			
		End If
		
	Next
	
End Sub

Sub World.ApplyWarmStart()
	
	''
	If ( AngularSprings_.size > 0 ) Then 
		
		For AP as AngularSpring Ptr = AngularSprings_.p_front To AngularSprings_.p_back
			
			AP->ApplyWarmStart()
			
		Next
		
	End If
	
	''
	If ( FixedSprings_.size > 0 ) Then 
		
		For FP As FixedSpring Ptr = FixedSprings_.p_front To FixedSprings_.p_back
			
			FP->ApplyWarmStart()
			 
		Next
		
	End If
	
	''
	If ( LinearSprings_.size > 0 ) Then 
		
		For LP As LinearSpring Ptr = LinearSprings_.p_front To LinearSprings_.p_back
			
			LP->ApplyWarmStart()
			 
		Next
	
	End If
	
End Sub


'' Compute
Sub World.WhatAmIOrbiting( ByVal P As Particle Ptr, Byval array As NewtonGravityArray Ptr )
	
	'' Compute what object - or body of objects - I am orbiting
	
	'' Find the orbit around the lightest object with specific energy < 0
	
	Dim As Single energy = 0.0
	Dim As Single mass = 1e999
	Dim As Single dist = 1e999
	Dim As Single force = 0.0
	
	Dim As Particle Ptr orbiting = 0
	

	For N As NewtonGravity Ptr = array->p_front To array->p_back
		
		If ( P <> N ) Then
		
		'If N->GetFlag( IS_VISIBLE ) Then
			
						''
			'Dim As Single mju = G * ( N->Mass + P->Mass )
			'Dim As Single lng = ( N->Position - P->Position ).Length
			'Dim As Single vel2 = ( N->Velocity - P->Velocity ).LengthSquared
			'Dim As Single e = ( vel2 / 2.0 ) - ( mju / lng )
			'
			''If ( e < energy ) And ( N->Mass < mass ) Then
			''If ( specific_orbital_energy < 0.0 ) And ( P->Mass < mass ) Then
			''If ( e < specific_orbital_energy ) And ( f > force ) Then
			'If ( e < energy ) And ( lng < dist ) Then
			'		
			'	mass = N->Mass
			'	dist = lng
			'	'energy = e
			'	'force = f
			'	orbiting = N
			'		
			'EndIf
			
			''
			If ( P = N->ParticleB ) Then
				
				Dim As Single mju = G * ( N->ParticleA->Mass + P->Mass )
				Dim As Single vel2 = ( N->ParticleA->Velocity - P->Velocity ).LengthSquared
				Dim As Single e = vel2 / 2.0 - mju / N->Length
				
				'Dim As Single f = ( G * N->ParticleB->Mass * P->Mass ) / ( N->Length * N->Length )
				
				'If ( e < energy ) And (  N->ParticleA->Mass < mass ) Then
				'If ( specific_orbital_energy < 0.0 ) And ( P->Mass < mass ) Then
				'If ( e < specific_orbital_energy ) And ( f > force ) Then
				If ( e < energy ) And ( N->Length < dist ) Then
					
					mass =  N->ParticleA->Mass
					dist = N->Length
					'energy = e
					'force = f
					orbiting = N->ParticleA
					
				EndIf
				
			EndIf
			
			''
			If ( P = N->ParticleA ) Then
				
				Dim As Single mju = G * ( N->ParticleB->Mass + P->Mass )
				Dim As Single vel2 = ( P->Velocity - N->ParticleB->Velocity ).LengthSquared
				Dim As Single e = vel2 / 2.0 - mju / N->Length
				
				'Dim As Single f = ( G * N->ParticleA->Mass * P->Mass ) / ( N->Length * N->Length )
				
				'If ( e < energy ) And ( N->ParticleB->Mass < mass ) Then
				'If ( specific_orbital_energy < 0.0 ) And ( P->Mass < mass ) Then
				'If ( e < specific_orbital_energy ) And ( f > force ) Then
				If ( e < energy ) And ( N->Length < dist ) Then
					
					mass = N->ParticleB->Mass
					dist = N->Length
					'energy = e
					'force = f
					orbiting = N->ParticleB
					
				EndIf
				
			EndIf
			
		'End If
		
		End If
		
	Next
	
	If orbiting <> 0 Then
		
		Dim As KeplerOrbit K = KeplerOrbit( P, Orbiting )
		
		K.ComputeKeplerFromState()
		
		k.DrawOrbit()
	
	End If
	
End Sub

Sub World.ComputeBroadPhase()
	
	'' This function determines in which cell in the broad-phase collision detection
	'' grid each particle is placed. Computation is very fast and CPU cheap.
	
	If ( Particles_.size > 0 ) Then 
		
		For I As Particle Ptr = Particles_.p_front To Particles_.p_back
			
			Dim As Integer cell_x = Cast( Integer, I->position.x * Grid_.InvCellDiameter )
			
			If ( cell_x < 0 ) Or ( cell_x > Grid_.NumCellsX ) Then Continue For
			
			Dim As Integer cell_y = Cast( Integer, I->position.y * Grid_.InvCellDiameter )
			
			If ( cell_y < 0 ) Or ( cell_y > Grid_.NumCellsY ) Then Continue For
			
			'Dim As Cell Ptr CP = @Grid_
			
			'If CP->numParticles_ >= BroadPhaseGrid.numParticlesPerCell_ Then Continue For
			
			'CP->numParticles_ += 1
			
			'CP->Particles( PC->numParticles_ ) = I
			
		Next
		
	End If
	
End Sub

Sub World.computeData()
	
	''	In this function all the necessary data is computed, such as
	'' spring lengths, unit vectors, soft body state vectors and so on.
	'' Particle states aren't changed. No impulses are applied.
	
	If ( Bodys_.size > 0 ) Then 
		
		For I as Body Ptr = Bodys_.p_front To Bodys_.p_back
			
			I->ComputeStateVectors()
			I->ComputeInertia()
			I->ComputeAngularVelocity()
			'I->ComputeAngle()
			'I->ComputeAngleVector()
			
		Next
		
	End If
	
	If ( SpringBodys_.size > 0 ) Then 
		
		For I as SpringBody Ptr = SpringBodys_.p_front To SpringBodys_.p_back
			
			I->ComputeStateVectors()
			I->ComputeInertia()
			I->ComputeAngularVelocity()
			'I->ComputeAngle()
			'I->ComputeAngleVector()
			
		Next
		
	End If
	
	If ( PressureBodys_.size > 0 ) Then 
		
		For I as PressureBody Ptr = PressureBodys_.p_front To PressureBodys_.p_back
			
			I->ComputeStateVectors()
			I->ComputeInertia()
			I->ComputeAngularVelocity()
			'I->ComputeAngle()
			'I->ComputeAngleVector()
			I->ComputeArea()
			I->ComputeRestImpulse()
			
		Next
		
	End If
	
	If ( LinearSprings_.size > 0 ) Then 
		
		For I as LinearSpring Ptr = LinearSprings_.p_front To LinearSprings_.p_back
			
			I->ComputeStateVectors()
			I->ComputeLengths()
			I->ComputeInertia()
			I->ComputeAngularVelocity()
			'I->ComputeAngle()
			I->ComputeRestImpulse()
			
		Next
		
	End If
	
	If ( FixedSprings_.size > 0 ) Then 
	
		For I as FixedSpring Ptr = FixedSprings_.p_front To FixedSprings_.p_back
			
			I->ComputeStateVectors()
			I->ComputeLengthVector()
			I->ComputeRestImpulse()
			
		Next
	
	End If
	
	If ( NewtonGravitys_.size > 0 ) Then 
		
		For I as NewtonGravity Ptr = NewtonGravitys_.p_front To NewtonGravitys_.p_back
			
			If I->GetFlag( IS_ACTIVE ) Then
				
				I->ComputeStateVectors()
				I->ComputeLengths()
				
			End If
				
		Next
		
	End If
	
	If ( KeplerOrbits_.size > 0 ) Then 
		
		For I as KeplerOrbit Ptr = KeplerOrbits_.p_front To KeplerOrbits_.p_back
			
			I->ComputeKeplerFromState()
			'I->ComputePeriapsisVector()
			
		Next
		
	End If
	
	If ( AngularSprings_.size > 0 ) Then 
		
		For I as AngularSpring Ptr = AngularSprings_.p_front To AngularSprings_.p_back
			
			I->ComputeAngle()
			I->ComputeAngleVector()
			I->ComputeReducedInertia()
			I->ComputeRestImpulse()
			
		Next
	
	End If
	
End Sub

Sub World.ComputeNarrowPhase()
	
End Sub

Sub World.ComputeNewState()
	
	''
	If ( Particles_.size > 0 ) Then 
		
		For I As Particle Ptr = Particles_.p_front To Particles_.p_back
			
			If I->GetFlag( IS_ACTIVE Or IS_DYNAMIC ) Then
				
				I->AddVelocity( I->Impulse )
				I->AddPosition( I->Velocity * DT )
				
				I->Impulse( Vec2( 0.0, 0.0 ) )
				
			End If
			
		Next
		
	End If
	
	''
	If ( Rotates_.size > 0 ) Then 
		
		For I As Rotate Ptr = Rotates_.p_front To Rotates_.p_back
			
			If I->GetFlag( IS_ACTIVE Or IS_DYNAMIC ) Then
				
				''
				I->AddVelocity( I->Impulse )
				I->AddPosition( I->Velocity * DT )
				
				I->Impulse( Vec2( 0.0, 0.0 ) )
				
				''
				I->AddAngularVelocity( I->AngularImpulse )
				I->AddAngle( I->AngularVelocity * DT )
				
				I->ComputeAngleVector()
				
				I->AngularImpulse( 0.0 )
				
			End If
			
		Next
		
	End If
	
	If ( Bodys_.size > 0 ) Then 
		
		For I As Body Ptr = Bodys_.p_front To Bodys_.p_back
			
			If I->GetFlag( IS_ACTIVE Or IS_DYNAMIC ) Then
				
				If ( I->Particles_.size > 0 ) Then 
					
					For II As Particle Ptr Ptr = I->Particles_.p_front To I->Particles_.p_back
						
						Dim As Particle Ptr P = *II
						
						If Not P->GetFlag( IS_DYNAMIC ) Then
							
							
							
						End If
						
					Next
					
				End If
				
			End If
			
		Next
		
	End If
	
End Sub


'' Create
Function World.CreateAngularSpring( ByVal stiffnes  As Single, _
	                                 ByVal damping   As Single, _
	                                 ByVal warmstart As Single, _
	                                 ByRef rotate_a  As Rotate Ptr, _
	                                 ByRef rotate_b  As Rotate Ptr ) As AngularSpring Ptr
	
	Dim As AngularSpring A = AngularSpring( stiffnes, damping, warmstart, rotate_a, rotate_b )
	
	Dim As AngularSpring Ptr AP = AngularSprings_.push_back( A )
	
	Return AP
	
End Function

Function World.CreateAngularSpring( ByVal stiffnes        As Single, _
	                                 ByVal damping         As Single, _
	                                 ByVal warmstart       As Single, _
	                                 ByVal restanglevector As Vec2, _
	                                 ByRef rotate_a        As Rotate Ptr, _
	                                 ByRef rotate_b        As Rotate Ptr ) As AngularSpring Ptr
	
	Dim As AngularSpring A = AngularSpring( stiffnes, damping, warmstart, restanglevector, rotate_a, rotate_b )
	
	Dim As AngularSpring Ptr AP = AngularSprings_.push_back( A )
	
	Return AP
	
End Function

Function World.CreateAngularSpring( ByVal stiffnes  As Single, _
	                                 ByVal damping   As Single, _
	                                 ByVal warmstart As Single, _
	                                 ByVal restangle As Single, _
	                                 ByRef rotate_a  As Rotate Ptr, _
	                                 ByRef rotate_b  As Rotate Ptr ) As AngularSpring Ptr
	
	Dim As AngularSpring A = AngularSpring( stiffnes, damping, warmstart, restangle, rotate_a, rotate_b )
	
	Dim As AngularSpring Ptr AP = AngularSprings_.push_back( A )
	
	Return AP
	
End Function

Function World.CreateFixedSpring( ByVal stiffnes   As Single, _
                                  ByVal damping    As Single, _
                                  ByVal warmstart  As Single, _
                                  ByRef particle_a As Particle Ptr, _
                                  ByRef particle_b As Particle Ptr ) As FixedSpring Ptr
	
	Dim As FixedSpring F = FixedSpring( stiffnes, damping, warmstart, particle_a, particle_b )
	
	Dim As FixedSpring Ptr FP = FixedSprings_.push_back( F )
	
	Return FP
	
End Function

Function World.CreateFixedSpring( ByVal stiffnes   As Single, _
                                  ByVal damping    As Single, _
                                  ByVal warmstart  As Single, _
                                  ByVal restlength As Vec2, _
                                  ByRef particle_a As Particle Ptr, _
                                  ByRef particle_b As Particle Ptr ) As FixedSpring Ptr
	
	Dim As FixedSpring F = FixedSpring( stiffnes, damping, warmstart, restlength, particle_a, particle_b )
	
	Dim As FixedSpring Ptr FP = FixedSprings_.push_back( F )
	
	Return FP
	
End Function

Function World.CreateParticle( ByVal mass     As Single, _
	                            ByVal position As Vec2 ) As Particle Ptr
   
   Dim As Particle P = Particle( mass, position )
   
   Dim As Particle Ptr PP = Particles_.push_back( P )
   
   Return PP
   
End Function

Function World.CreateParticle( ByVal mass     As Single, _
	                            ByVal radius   As Single, _
	                            ByVal position As Vec2 ) As Particle Ptr
	
	Dim As Particle P = Particle( mass, radius, position )
   
   Dim As Particle Ptr PP = Particles_.push_back( P )
   
   Return PP
	
End Function

Function World.CreateKeplerOrbit( ByVal particle_a As Particle Ptr, _
	                               ByVal particle_b As Particle Ptr ) As KeplerOrbit Ptr
	
	Dim As KeplerOrbit K = KeplerOrbit( particle_a, particle_b )
	
	Dim As KeplerOrbit Ptr KP = KeplerOrbits_.push_back( K )
	
	Return KP
	
End Function

Function World.CreateLinearSpring( ByVal stiffness  As Single, _
	                                ByVal damping    As Single, _
	                                ByVal warmstart  As Single, _
	                                ByVal particle_a As Particle Ptr, _
	                                ByVal particle_b As Particle Ptr ) As LinearSpring Ptr
	
	Dim As LinearSpring L = LinearSpring( stiffness, damping, warmstart,particle_a, particle_b )
	
	Dim As LinearSpring Ptr LP = LinearSprings_.push_back( L )
	
	Return LP
	
End Function

Function World.CreateLinearSpring( ByVal stiffness  As Single, _
	                                ByVal damping    As Single, _
	                                ByVal warmstart  As Single, _
	                                ByVal restlength As Single, _
	                                ByVal particle_a As Particle Ptr, _
	                                ByVal particle_b As Particle Ptr ) As LinearSpring Ptr
	
	Dim As LinearSpring L = LinearSpring( stiffness, damping, warmstart, restlength, particle_a, particle_b )
	
	Dim As LinearSpring Ptr LP = LinearSprings_.push_back( L )
	
	Return LP
	
End Function

Function World.CreateNewtonGravity( ByVal particle_a As Particle Ptr, _
	                                 ByVal particle_b As Particle Ptr ) As NewtonGravity Ptr
	
	Dim As NewtonGravity N = NewtonGravity( particle_a, particle_b )
	
	Dim As NewtonGravity Ptr NP = NewtonGravitys_.push_back( N )
	
	Return NP
	
End Function

Function World.CreateBody( ByVal _position    As Vec2, _
	                        ByVal _num_objects As Integer ) As Body Ptr
	
	Dim As Body B = Body()
	
	Dim As Body Ptr BP = Bodys_.push_back( B )
	
	BP->Particles_.Reserve( _num_objects )
	
	Return BP
	
End Function

Function World.CreateSpringBody( ByVal particles As Integer, _
	                              ByVal position  As Vec2 ) As SpringBody Ptr
	
	Dim As Single radius      = 96.0
	Dim As Single angle       = 0.0
	Dim As Single delta_angle = TWO_PI / particles
	
	Dim As SpringBody S = SpringBody()
	
	Dim As SpringBody Ptr SP = SpringBodys_.push_back( S )
	
	SP->Particles_.Reserve( particles )
	SP->LinearSprings_.Reserve( particles )
	SP->AngularSprings_.Reserve( particles )
	
	For i As Integer = 0 To particles - 1
		
		Dim As Particle Ptr P = CreateParticle( 1.0, position + Vec2( Cos( angle ) * radius, Sin( angle ) * radius )  )
		
		SP->Particles_.push_back( P )
		
		angle += delta_angle
		
	Next
	
	For i As Integer = 0 To particles - 1
		
		Dim As Integer j = ( i + 1 ) Mod particles
		
		Dim As LinearSpring Ptr L = CreateLinearSpring( C_LINEAR_STIFFNESS, _
		                                                C_LINEAR_DAMPING, _
		                                                C_LINEAR_WARMSTART, _
		                                                *SP->Particles_[i], _
		                                                *SP->Particles_[j] )
		
		SP->LinearSprings_.push_back( L )
		
	Next
	
	For i As Integer = 0 To particles - 1
		
		Dim As Integer j = ( i + 1 ) Mod particles
		
		Dim As AngularSpring Ptr A = CreateAngularSpring( C_ANGULAR_STIFFNESS, _
		                                                  C_ANGULAR_DAMPING, _
		                                                  C_ANGULAR_WARMSTART, _
		                                                  *SP->LinearSprings_[i], _
		                                                  *SP->LinearSprings_[j] )
		
		SP->AngularSprings_.push_back( A )
		
	Next
	
	''
	SP->ComputeMass()
	SP->ComputeStateVectors()
	SP->ComputeInertia()
	SP->ComputeAngularVelocity()
	SP->ComputeAngle()
	SP->ComputeAngleVector()
	
	Return SP
	
End Function

Function World.CreateSpringBody( ByVal particles As Integer, _
	                              ByVal radius    As Single, _
	                              ByVal position  As Vec2 ) As SpringBody Ptr
	
	
	Dim As Single angle       = 0.0
	Dim As Single delta_angle = TWO_PI / particles
	
	Dim As SpringBody S = SpringBody()
	
	Dim As SpringBody Ptr SP = SpringBodys_.push_back( S )
	
	SP->Particles_.Reserve( particles )
	SP->LinearSprings_.Reserve( particles )
	SP->AngularSprings_.Reserve( particles )
	
	For i As Integer = 0 To particles - 1
		
		Dim As Particle Ptr P = CreateParticle( 1.0, position + Vec2( Cos( angle ) * radius, Sin( angle ) * radius )  )
		
		SP->Particles_.push_back( P )
		'SP->AddObject( P ) '' suspicious behaviour, sometimes crashes.
		
		angle += delta_angle
		
	Next
	
	For i As Integer = 0 To particles - 1
		
		Dim As Integer j = ( i + 1 ) Mod particles
		
		Dim As LinearSpring Ptr L = CreateLinearSpring( C_LINEAR_STIFFNESS, _
		                                                C_LINEAR_DAMPING, _
		                                                C_LINEAR_WARMSTART, _
		                                                *SP->Particles_[i], _
		                                                *SP->Particles_[j] )
		
		SP->LinearSprings_.push_back( L )
		
	Next
	
	For i As Integer = 0 To particles - 1
		
		Dim As Integer j = ( i + 1 ) Mod particles
		
		Dim As AngularSpring Ptr A = CreateAngularSpring( C_ANGULAR_STIFFNESS, _
		                                                  C_ANGULAR_DAMPING, _
		                                                  C_ANGULAR_WARMSTART, _
		                                                  *SP->LinearSprings_[i], _
		                                                  *SP->LinearSprings_[j] )
		
		SP->AngularSprings_.push_back( A )
		
	Next
	
	''
	
	SP->ComputeMass()
	SP->ComputeStateVectors()
	SP->ComputeInertia()
	SP->ComputeAngularVelocity()
	
	SP->RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
	Return SP
	
End Function

Function World.CreatePressureBody( ByVal particles As Integer, _
	                                ByVal position  As Vec2 ) As PressureBody Ptr
	
	Dim As Single radius      = 96.0
	Dim As Single angle       = 0.0
	Dim As Single delta_angle = TWO_PI / particles
	
	Dim As PressureBody B = PressureBody()
	
	Dim As PressureBody Ptr BP = PressureBodys_.push_back( B )
	
	BP->Particles_.Reserve( particles )
	BP->LinearSprings_.Reserve( particles )
	BP->ClosedLoopSprings_.Reserve( particles )
	
	''
	For i As Integer = 0 To particles - 1
		
		Dim As Particle Ptr PP = CreateParticle( 1.0, position + Vec2( Cos( angle ), Sin( angle ) ) * radius )
		
		BP->Particles_.push_back( PP )
		
		angle += delta_angle
		
	Next
	
	''
	For i As Integer = 0 To particles - 1
		
		Dim As Integer j = ( i + 1 ) Mod particles
		
		Dim As LinearSpring Ptr LP = CreateLinearSpring( 0.5, 0.5, 0.0, *BP->Particles_[i], *BP->Particles_[j] )
		
		BP->ClosedLoopSprings_.push_back( LP )
		
	Next
	
	''
	BP->ComputeMass()
	BP->ComputeStateVectors()
	BP->ComputeInertia()
	BP->ComputeAngularVelocity()
	BP->ComputeArea()
	
	BP->RestArea( BP->Area )
	
	Return BP
	
End Function

Function World.CreateRotate( ByVal _mass     As Single, _
	                          ByVal _radius   As Single, _
	                          ByVal _position As Vec2 ) As Rotate Ptr
	
	Dim As Rotate R = Rotate( _mass, _radius, _position )
   
   Dim As Rotate Ptr RP = Rotates_.push_back( R )
   
   Return RP
	
End Function

Function World.CreateRotate( ByVal _mass     As Single, _
	                          ByVal _radius   As Single, _
	                          ByVal _angle    As Single, _
	                          ByVal _position As Vec2 ) As Rotate Ptr
	
	Dim As Rotate R = Rotate( _mass, _radius, _angle, _position )
   
   Dim As Rotate Ptr RP = Rotates_.push_back( R )
   
   Return RP
	
End Function

Function World.CreateRotate( ByVal _mass        As Single, _
	                          ByVal _radius      As Single, _
	                          ByVal _anglevector As Vec2, _
	                          ByVal _position    As Vec2 ) As Rotate Ptr
	
	Dim As Rotate R = Rotate( _mass, _radius, _anglevector, _position )
   
   Dim As Rotate Ptr RP = Rotates_.push_back( R )
   
   Return RP
	
End Function


'' Merge / Split
Function World.MergeParticles( ByVal particle_a As Particle Ptr, _
	                            ByVal particle_b As Particle Ptr ) As Particle
	
	Dim As Particle P
	
	Dim As Single inverse_mass = 1.0 / ( particle_a->Mass + particle_b->Mass )
	
	P.Position( ( particle_a->Position * particle_a->Mass + _
	              particle_b->Position * particle_b->Mass ) * inverse_mass )
	
	P.Velocity( ( particle_a->Velocity * particle_a->Mass + _
	              particle_b->Velocity * particle_b->Mass ) * inverse_mass )
	
	P.Impulse( particle_a->Impulse + particle_b->Impulse )
	
	Dim As Single area_a = PI * particle_a->Radius * particle_a->Radius
	Dim As Single area_b = PI * particle_b->Radius * particle_b->Radius
	
	P.Radius( Sqr( ( area_a + area_b ) / PI ) )
	
	Return P
	
End Function

Function World.SplitParticle( ByVal P As Particle Ptr, _
	                           ByVal C As Single ) As Particle
	
	Dim As Particle P_a
	
	Return P_a
	
End Function


#EndIf ''__S2_WORLD_BI__
