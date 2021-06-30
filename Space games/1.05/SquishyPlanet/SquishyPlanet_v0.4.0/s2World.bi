''******************************************************************************
''    
''   Squishy2D World Class
''   Written in FreeBASIC 1.04
''   version 0.4.0, january 2016, Michael "h4tt3n" Nissen
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
	
	'' Create
	Declare Function CreateAngularSpring( ByVal stiffnes As Single, _
	                                      ByVal damping  As Single, _
	                                      ByRef rotate_a As Rotate Ptr, _
	                                      ByRef rotate_b As Rotate Ptr ) As AngularSpring Ptr
	
	Declare Function CreateAngularSpring( ByVal stiffnes        As Single, _
	                                      ByVal damping         As Single, _
	                                      ByVal restanglevector As Vec2, _
	                                      ByRef rotate_a        As Rotate Ptr, _
	                                      ByRef rotate_b        As Rotate Ptr ) As AngularSpring Ptr
	
	Declare Function CreateAngularSpring( ByVal stiffnes  As Single, _
	                                      ByVal damping   As Single, _
	                                      ByVal restangle As Single, _
	                                      ByRef rotate_a  As Rotate Ptr, _
	                                      ByRef rotate_b  As Rotate Ptr ) As AngularSpring Ptr
	
	Declare Function CreateFixedSpring( ByVal stiffnes   As Single, _
	                                    ByVal damping    As Single, _
	                                    ByRef particle_a As Particle Ptr, _
	                                    ByRef particle_b As Particle Ptr ) As FixedSpring Ptr
	
	Declare Function CreateFixedSpring( ByVal stiffnes   As Single, _
	                                    ByVal damping    As Single, _
	                                    ByVal restlength As Vec2, _
	                                    ByRef particle_a As Particle Ptr, _
	                                    ByRef particle_b As Particle Ptr ) As FixedSpring Ptr
	
	Declare Function CreateParticle( ByVal mass     As Single, _
	                                 ByVal position As Vec2 ) As Particle Ptr
	
	Declare Function CreateExternalLinearSpring( ByVal stiffness  As Single, _
	                                             ByVal damping    As Single, _
	                                             ByVal particle_a As Particle Ptr, _
	                                             ByVal particle_b As Particle Ptr ) As LinearSpring Ptr
	
	Declare Function CreateExternalAngularSpring( ByVal stiffnes As Single, _
	                                              ByVal damping  As Single, _
	                                              ByRef rotate_a As Rotate Ptr, _
	                                              ByRef rotate_b As Rotate Ptr ) As AngularSpring Ptr
	
	Declare Function CreateLinearSpring( ByVal stiffness  As Single, _
	                                     ByVal damping    As Single, _
	                                     ByVal particle_a As Particle Ptr, _
	                                     ByVal particle_b As Particle Ptr ) As LinearSpring Ptr
	
	Declare Function CreateLinearSpring( ByVal stiffness  As Single, _
	                                     ByVal damping    As Single, _
	                                     ByVal restlength As Single, _
	                                     ByVal particle_a As Particle Ptr, _
	                                     ByVal particle_b As Particle Ptr ) As LinearSpring Ptr
	
	Declare Function CreateSpringBody( ByVal n        As Integer, _
	                                   ByVal position As Vec2 ) As SpringBody Ptr
	
	Declare Function CreatePressureBody( ByVal n        As Integer, _
	                                     ByVal position As Vec2 ) As PressureBody Ptr
	
	''
	Declare Sub ComputeData()
	Declare Sub Solve()
	
	'Private:
	
	'' Variables
	
	'' Object pointer arrays ( All springs etc. not part of a body )
	As AngularSpringPtrArray  ExternalAngularSprings_
	As FixedSpringPtrArray    ExternalFixedSprings_
	As LinearSpringPtrArray   ExternalLinearSprings_
	
	'' Object arrays ( All physical objects are stored here )
	As AngularSpringArray  AngularSprings_
	As RotateArray         Rotates_
	As FixedSpringArray    FixedSprings_
	As LineSegmentArray    LineSegments_
	As LinearSpringArray   LinearSprings_
	As ParticleArray       Particles_
	As BodyArray           Bodys_
	As SpringBodyArray     SpringBodys_
	As PressureBodyArray   PressureBodys_
	
End Type


'' Constructors
Constructor World()
	
	'AngularSprings_.Reserve ( MAX_ANGULAR_SPRINGS )
	'Rotates_.Reserve        ( MAX_ROTATES )
	'FixedSprings_.Reserve   ( MAX_FIXED_SPRINGS )
	'LineSegments_.Reserve   ( MAX_LINE_SEGMENTS )
	'LinearSprings_.Reserve  ( MAX_LINEAR_SPRINGS )
	'Particles_.Reserve      ( MAX_PARTICLES )
	'Bodys_.Reserve          ( MAX_BODYS )
	
End Constructor

Constructor World( ByRef w As World )
	
	This = w
	
End Constructor


'' Destructor
Destructor World()
	
	''
	ExternalAngularSprings_.Clear()
	ExternalFixedSprings_.Clear()
	ExternalLinearSprings_.Clear()
	
	''
	AngularSprings_.Clear()
	Rotates_.Clear()
	FixedSprings_.Clear()
	LineSegments_.Clear()
	LinearSprings_.Clear()
	Particles_.Clear()
	Bodys_.Clear()
	SpringBodys_.Clear()
	PressureBodys_.Clear()
	
End Destructor


'' Operators
Operator World.Let( ByRef w As World )
	
	''
	ExternalAngularSprings_ = w.ExternalAngularSprings_
	ExternalFixedSprings_   = w.ExternalFixedSprings_
	ExternalLinearSprings_  = w.ExternalLinearSprings_
	
	''
	AngularSprings_  = w.AngularSprings_
	Rotates_         = w.Rotates_
	FixedSprings_    = w.FixedSprings_
	LineSegments_    = w.LineSegments_
	LinearSprings_   = w.LinearSprings_
	Particles_       = w.Particles_
	Bodys_           = w.Bodys_
	SpringBodys_     = w.SpringBodys_
	PressureBodys_   = w.PressureBodys_
	
End Operator


'' Apply
Sub World.ApplyImpulses()
	
	For I As Integer = 1 To NUM_ITERATIONS
		
		
		'' Apply external impulses ( from outside the body )
		If ( ExternalLinearSprings_.size > 0 ) Then 
			
			For II As LinearSpring Ptr Ptr = ExternalLinearSprings_.Front To ExternalLinearSprings_.Back
				
				Dim As LinearSpring Ptr L = *II
				
				L->applyCorrectiveImpulse()
				
			Next
			
		End If
		
		'If ( ExternalAngularSprings_.size > 0 ) Then 
		'	
		'	For II As AngularSpring Ptr Ptr = ExternalAngularSprings_.Front To ExternalAngularSprings_.Back
		'		
		'		Dim As AngularSpring Ptr A = *II
		'		
		'		A->applyCorrectiveImpulse()
		'		
		'	Next
		'	
		'End If
		
		
		'' Concentrate external impulses
		'If ( SpringBodys_.size > 0 ) Then 
		'	
		'	For II As SpringBody Ptr = SpringBodys_.Front To SpringBodys_.Back
		'		
		'		II->ApplyImpulseConcentration( 0.0 )
		'		
		'	Next
		'	
		'End If
		
		'If ( PressureBodys_.size > 0 ) Then 
		'	
		'	For II As PressureBody Ptr = PressureBodys_.Front To PressureBodys_.Back
		'		
		'		II->ApplyImpulseConcentration( 0.0 )
		'		
		'	Next
		'	
		'EndIf
		
		'If ( LinearSprings_.size > 0 ) Then 
		'	
		'	For II As LinearSpring Ptr = LinearSprings_.Front To LinearSprings_.Back
		'		
		'		II->ApplyImpulseConcentration()
		'		
		'	Next
		'	
		'End If
		
		
		'' Apply internal impulses ( from inside the bodys )
		If ( SpringBodys_.size > 0 ) Then 
			
			For II As SpringBody Ptr = SpringBodys_.Front To SpringBodys_.Back
				
				If ( II->AngularSprings_.size > 0 ) Then
					
					For III As AngularSpring Ptr Ptr = II->AngularSprings_.Front To II->AngularSprings_.Back
					
						Dim As AngularSpring Ptr L = *III
					
						L->applyCorrectiveImpulse()
					
					Next
					
				End If
				
				If ( II->LinearSprings_.size > 0 ) Then
					
					For III As LinearSpring Ptr Ptr = II->LinearSprings_.Front To II->LinearSprings_.Back
					
						Dim As LinearSpring Ptr L = *III
					
						L->applyCorrectiveImpulse()
					
					Next
					
				End If
				
			Next
			
		End If
		
		'If ( PressureBodys_.size > 0 ) Then 
		'	
		'	For II As PressureBody Ptr = PressureBodys_.Front To PressureBodys_.Back
		'		
		'		If ( II->AngularSprings_.size > 0 ) Then
		'			
		'			For III As AngularSpring Ptr Ptr = II->AngularSprings_.Front To II->AngularSprings_.Back
		'			
		'				Dim As AngularSpring Ptr L = *III
		'			
		'				L->applyCorrectiveImpulse()
		'			
		'			Next
		'			
		'		End If
		'		
		'		If ( II->LinearSprings_.size > 0 ) Then
		'			
		'			For III As LinearSpring Ptr Ptr = II->LinearSprings_.Front To II->LinearSprings_.Back
		'			
		'				Dim As LinearSpring Ptr L = *III
		'			
		'				L->applyCorrectiveImpulse()
		'			
		'			Next
		'			
		'		End If
		'		
		'		If ( II->ClosedLoopSprings_.size > 0 ) Then
		'			
		'			For III As LinearSpring Ptr Ptr = II->ClosedLoopSprings_.Front To II->ClosedLoopSprings_.Back
		'			
		'				Dim As LinearSpring Ptr L = *III
		'			
		'				L->applyCorrectiveImpulse()
		'			
		'			Next
		'			
		'		End If
		'		
		'	Next
		'	
		'End If
		
		
		'' Disperse impulses
		'If ( LinearSprings_.size > 0 ) Then 
		'	
		'	For n As Integer = 1 To 4
		'		
		'		For II As LinearSpring Ptr = LinearSprings_.Front To LinearSprings_.Back
		'			
		'			II->ApplyImpulseDispersion()
		'			
		'		Next
		'		
		'	Next
		'		
		'End If
		'
		'If ( SpringBodys_.size > 0 ) Then 
		'	
		'	For II As SpringBody Ptr = SpringBodys_.Front To SpringBodys_.Back
		'		
		'		II->ApplyImpulseDispersion()
		'		
		'	Next
		'	
		'End If
		'
		'If ( PressureBodys_.size > 0 ) Then 
		'	
		'	For II As PressureBody Ptr = PressureBodys_.Front To PressureBodys_.Back
		'		
		'		II->ApplyImpulseDispersion()
		'		
		'	Next
		'	
		'End If
		
	Next
	
End Sub

Sub World.ApplyWarmStart()
	
	If ( FixedSprings_.size > 0 ) Then 
		
		For F As FixedSpring Ptr = FixedSprings_.Front To FixedSprings_.Back
			
			F->ApplyWarmStart()
			 
		Next
		
	End If
	
	If ( LinearSprings_.size > 0 ) Then 
		
		For L As LinearSpring Ptr = LinearSprings_.Front To LinearSprings_.Back
			
			L->ApplyWarmStart()
			 
		Next
	
	End If
	
	'If ( AngularSprings_.size > 0 ) Then 
	'	
	'	For I as AngularSpring Ptr = AngularSprings_.Front To AngularSprings_.Back
	'		
	'		I->ApplyWarmStart()
	'		
	'	Next
	'	
	'End If
	
End Sub


'' Create
Function World.CreateAngularSpring( ByVal stiffnes As Single, _
	                                 ByVal damping  As Single, _
	                                 ByRef rotate_a As Rotate Ptr, _
	                                 ByRef rotate_b As Rotate Ptr ) As AngularSpring Ptr
	
	Dim As AngularSpring A = AngularSpring( stiffnes, damping, rotate_a, rotate_b )
	
	Dim As AngularSpring Ptr AP = AngularSprings_.push_back( A )
	
	Return AP
	
End Function

Function World.CreateAngularSpring( ByVal stiffnes        As Single, _
	                                 ByVal damping         As Single, _
	                                 ByVal restanglevector As Vec2, _
	                                 ByRef rotate_a        As Rotate Ptr, _
	                                 ByRef rotate_b        As Rotate Ptr ) As AngularSpring Ptr
	
	Dim As AngularSpring A = AngularSpring( stiffnes, damping, restanglevector, rotate_a, rotate_b )
	
	Dim As AngularSpring Ptr AP = AngularSprings_.push_back( A )
	
	Return AP
	
End Function

Function World.CreateAngularSpring( ByVal stiffnes  As Single, _
	                                 ByVal damping   As Single, _
	                                 ByVal restangle As Single, _
	                                 ByRef rotate_a  As Rotate Ptr, _
	                                 ByRef rotate_b  As Rotate Ptr ) As AngularSpring Ptr
	
	Dim As AngularSpring A = AngularSpring( stiffnes, damping, restangle, rotate_a, rotate_b )
	
	Dim As AngularSpring Ptr AP = AngularSprings_.push_back( A )
	
	Return AP
	
End Function

Function World.CreateFixedSpring( ByVal stiffnes   As Single, _
                                  ByVal damping    As Single, _
                                  ByRef particle_a As Particle Ptr, _
                                  ByRef particle_b As Particle Ptr ) As FixedSpring Ptr
	
	Dim As FixedSpring F = FixedSpring( stiffnes, damping, particle_a, particle_b )
	
	Dim As FixedSpring Ptr FP = FixedSprings_.push_back( F )
	
	Return FP
	
End Function

Function World.CreateFixedSpring( ByVal stiffnes   As Single, _
                                  ByVal damping    As Single, _
                                  ByVal restlength As Vec2, _
                                  ByRef particle_a As Particle Ptr, _
                                  ByRef particle_b As Particle Ptr ) As FixedSpring Ptr
	
	Dim As FixedSpring F = FixedSpring( stiffnes, damping, restlength, particle_a, particle_b )
	
	Dim As FixedSpring Ptr FP = FixedSprings_.push_back( F )
	
	Return FP
	
End Function

Function World.CreateParticle( ByVal mass     As Single, _
	                            ByVal position As Vec2 ) As Particle Ptr
   
   Dim As Particle P = Particle( mass, position )
   
   Dim As Particle Ptr PP = Particles_.Push_Back( P )
   
   Return PP
   
End Function

Function World.CreateExternalLinearSpring( ByVal stiffness  As Single, _
	                                        ByVal damping    As Single, _
	                                        ByVal particle_a As Particle Ptr, _
	                                        ByVal particle_b As Particle Ptr ) As LinearSpring Ptr
	
	Dim As LinearSpring L = LinearSpring( stiffness, damping, particle_a, particle_b )
	
	Dim As LinearSpring Ptr LP = LinearSprings_.push_Back( L )
	
	ExternalLinearSprings_.push_back( LP )
	
	Return LP
	
End Function

Function World.CreateExternalAngularSpring( ByVal stiffnes As Single, _
	                                         ByVal damping  As Single, _
	                                         ByRef rotate_a As Rotate Ptr, _
	                                         ByRef rotate_b As Rotate Ptr ) As AngularSpring Ptr
	
	Dim As AngularSpring A = AngularSpring( stiffnes, damping, rotate_a, rotate_b )
	
	Dim As AngularSpring Ptr AP = AngularSprings_.push_back( A )
	
	ExternalAngularSprings_.push_back( AP )
	
	Return AP
	
End Function

Function World.CreateLinearSpring( ByVal stiffness  As Single, _
	                                ByVal damping    As Single, _
	                                ByVal particle_a As Particle Ptr, _
	                                ByVal particle_b As Particle Ptr ) As LinearSpring Ptr
	
	Dim As LinearSpring L = LinearSpring( stiffness, damping, particle_a, particle_b )
	
	Dim As LinearSpring Ptr LP = LinearSprings_.push_Back( L )
	
	Return LP
	
End Function

Function World.CreateLinearSpring( ByVal stiffness  As Single, _
	                                ByVal damping    As Single, _
	                                ByVal restlength As Single, _
	                                ByVal particle_a As Particle Ptr, _
	                                ByVal particle_b As Particle Ptr ) As LinearSpring Ptr
	
	Dim As LinearSpring L = LinearSpring( stiffness, damping, restlength, particle_a, particle_b )
	
	Dim As LinearSpring Ptr LP = LinearSprings_.push_Back( L )
	
	Return LP
	
End Function

Function World.CreateSpringBody( ByVal n        As Integer, _
	                              ByVal position As Vec2 ) As SpringBody Ptr
	
	Dim As Single radius      = 96.0
	Dim As Single angle       = 0.0
	Dim As Single delta_angle = TWO_PI / n
	
	Dim As SpringBody S = SpringBody()
	
	Dim As SpringBody Ptr SP = SpringBodys_.push_Back( S )
	
	SP->Particles_.Reserve( n )
	SP->LinearSprings_.Reserve( n )
	SP->AngularSprings_.Reserve( n )
	
	For i As Integer = 0 To n - 1
		
		Dim As Particle Ptr P = CreateParticle( 1.0, position + Vec2( Cos( angle ), Sin( angle ) ) * radius )
		
		SP->Particles_.push_Back( P )
		
		angle += delta_angle
		
	Next
	
	For i As Integer = 0 To n - 1
		
		Dim As Integer j = ( i + 1 ) Mod n
		
		Dim As LinearSpring Ptr L = CreateLinearSpring( 0.5, 0.5, *SP->Particles_[i], *SP->Particles_[j] )
		
		SP->LinearSprings_.push_Back( L )
		
	Next
	
	For i As Integer = 0 To n - 1
		
		Dim As Integer j = ( i + 1 ) Mod n
		
		Dim As AngularSpring Ptr A = CreateAngularSpring( 0.5, 0.0, *SP->LinearSprings_[i], *SP->LinearSprings_[j] )
		
		SP->AngularSprings_.push_Back( A )
		
	Next
	
	''
	SP->ComputeMass()
	SP->ComputeStateVectors()
	SP->ComputeInertia()
	SP->ComputeAngularVelocity()
	
	Return SP
	
End Function

Function World.CreatePressureBody( ByVal n        As Integer, _
	                                ByVal position As Vec2 ) As PressureBody Ptr
	
	Dim As Single radius      = 96.0
	Dim As Single angle       = 0.0
	Dim As Single delta_angle = TWO_PI / n
	
	Dim As PressureBody B = PressureBody()
	
	Dim As PressureBody Ptr BP = PressureBodys_.push_Back( B )
	
	BP->Particles_.Reserve( n )
	BP->LinearSprings_.Reserve( n )
	BP->ClosedLoopSprings_.Reserve( n )
	
	For i As Integer = 0 To n - 1
		
		Dim As Particle Ptr PP = CreateParticle( 2.0, position + Vec2( Cos( angle ), Sin( angle ) ) * radius )
		
		BP->Particles_.push_Back( PP )
		
		angle += delta_angle
		
	Next
	
	For i As Integer = 0 To n - 1
		
		Dim As Integer j = ( i + 1 ) Mod n
		
		Dim As LinearSpring Ptr LP = CreateLinearSpring( 1.0, 1.0, *BP->Particles_[i], *BP->Particles_[j] )
		
		BP->ClosedLoopSprings_.push_Back( LP )
		
	Next
	
	''
	BP->ComputeMass()
	BP->ComputeStateVectors()
	BP->ComputeInertia()
	BP->ComputeAngularVelocity()
	BP->ComputeArea()
	
	Return BP
	
End Function


'' Compute
Sub World.computeData()
	
	''	In this function all the necessary data is computed, such as
	'' spring lengths, unit vectors, soft body state vectors and so on.
	'' No impulses are applied.
	
	If ( LinearSprings_.size > 0 ) Then 
		
		For I as LinearSpring Ptr = LinearSprings_.Front To LinearSprings_.Back
			
			I->ComputeStateVectors()
			I->ComputeInertia()
			I->ComputeAngularVelocity()
			I->ComputeLengths()
			I->ComputeRestImpulse()
			
		Next
		
	End If
	
	If ( FixedSprings_.size > 0 ) Then 
	
		For I as FixedSpring Ptr = FixedSprings_.Front To FixedSprings_.Back
			
			I->ComputeLengthVector()
			I->ComputeRestImpulse()
			
		Next
	
	End If
	
	If ( AngularSprings_.size > 0 ) Then 
		
		For I as AngularSpring Ptr = AngularSprings_.Front To AngularSprings_.Back
			
			'I->ComputeAngle()
			I->ComputeAngleVector()
			I->ComputeReducedInertia()
			I->ComputeRestImpulse()
			
		Next
	
	End If
	
	'For I as Body Ptr = Bodys_.Front To Bodys_.Back
	'	
	'	I->ComputeStateVectors()
	'	I->ComputeInertia()
	'	I->ComputeAngularVelocity()
	'	
	'Next
	
	If ( SpringBodys_.size > 0 ) Then 
		
		For I as SpringBody Ptr = SpringBodys_.Front To SpringBodys_.Back
			
			I->ComputeStateVectors()
			I->ComputeInertia()
			I->ComputeAngularVelocity()
			
		Next
		
	End If
	
	'If ( PressureBodys_.size > 0 ) Then 
	'	
	'	For I as PressureBody Ptr = PressureBodys_.Front To PressureBodys_.Back
	'		
	'		I->ComputeStateVectors()
	'		I->ComputeInertia()
	'		I->ComputeAngularVelocity()
	'		I->ComputeArea()
	'		'I->ComputeRestImpulse()
	'		
	'	Next
	'	
	'End If
	
End Sub

Sub World.Solve()
	
	If ( Particles_.size > 0 ) Then 
		
		For I As Particle Ptr = Particles_.front To Particles_.back
			
			I->AddVelocity( I->Impulse )
			I->AddPosition( I->Velocity * DT )
			
			I->Impulse( Vec2( 0.0, 0.0 ) )
			
		Next
		
	End If
	
End Sub


#EndIf ''__S2_WORLD_BI__
