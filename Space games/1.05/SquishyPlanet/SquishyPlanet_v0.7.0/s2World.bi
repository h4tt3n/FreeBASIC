''******************************************************************************
''    
''   SquishyPlanet - A 2D soft body and space physics library for games
''   Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''   Version 0.7.0, December 2016
''
''   Author:
''   Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''   Description:
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
	Declare Sub ApplyImpulseDistribution()
	Declare Sub ApplyWarmStart()
	
	'' Compute
	Declare Sub ComputeBroadPhase()
	Declare Sub ComputeData()
	Declare Sub ComputeNarrowPhase()
	Declare Sub ComputeNewState()
	
	Declare Sub WhatAmIOrbiting( ByVal particle As LinearState Ptr, ByVal array As LinearLinkArray Ptr )
	
	
	'' Create
	Declare Function CreateAngularSpring( ByVal stiffnes  As Single, _
	                                      ByVal damping   As Single, _
	                                      ByVal warmstart As Single, _
	                                      ByRef rotate_a  As AngularState Ptr, _
	                                      ByRef rotate_b  As AngularState Ptr ) As AngularSpring Ptr
	
	Declare Function CreateAngularSpring( ByVal stiffnes        As Single, _
	                                      ByVal damping         As Single, _
	                                      ByVal warmstart       As Single, _
	                                      ByVal restanglevector As Vec2, _
	                                      ByRef rotate_a        As AngularState Ptr, _
	                                      ByRef rotate_b        As AngularState Ptr ) As AngularSpring Ptr
	
	Declare Function CreateAngularSpring( ByVal stiffnes  As Single, _
	                                      ByVal damping   As Single, _
	                                      ByVal warmstart As Single, _
	                                      ByVal restangle As Single, _
	                                      ByRef rotate_a  As AngularState Ptr, _
	                                      ByRef rotate_b  As AngularState Ptr ) As AngularSpring Ptr
	
	Declare Function CreateAngularState( ByVal mass     As Single, _
		                                  ByVal inertia  As Single, _
	                                     ByVal position As Vec2 ) As AngularState Ptr
	
	Declare Function CreateAngularState( ByVal mass     As Single, _
		                                  ByVal inertia  As Single, _
	                                     ByVal angle    As Single, _
	                                     ByVal position As Vec2 ) As AngularState Ptr
	
	Declare Function CreateAngularState( ByVal mass        As Single, _
		                                  ByVal inertia     As Single, _
	                                     ByVal anglevector As Vec2, _
	                                     ByVal position    As Vec2 ) As AngularState Ptr
	
	Declare Function CreateBody( ByVal _position    As Vec2, _
	                             ByVal _num_objects As Integer ) As Body Ptr
	
	Declare Function CreateFixedSpring( ByVal stiffnes   As Single, _
	                                    ByVal damping    As Single, _
	                                    ByVal warmstart  As Single, _
	                                    ByRef particle_a As LinearState Ptr, _
	                                    ByRef particle_b As LinearState Ptr ) As FixedSpring Ptr
	
	Declare Function CreateFixedSpring( ByVal stiffnes   As Single, _
	                                    ByVal damping    As Single, _
	                                    ByVal warmstart  As Single, _
	                                    ByVal restlength As Vec2, _
	                                    ByRef particle_a As LinearState Ptr, _
	                                    ByRef particle_b As LinearState Ptr ) As FixedSpring Ptr
	
	Declare Function CreateKeplerOrbit( ByVal particle_a As LinearState Ptr, _
	                                    ByVal particle_b As LinearState Ptr ) As KeplerOrbit Ptr
	
	Declare Function CreateLinearSpring( ByVal stiffness  As Single, _
	                                     ByVal damping    As Single, _
	                                     ByVal warmstart  As Single, _
	                                     ByVal particle_a As LinearState Ptr, _
	                                     ByVal particle_b As LinearState Ptr ) As LinearSpring Ptr
	
	Declare Function CreateLinearSpring( ByVal stiffness  As Single, _
	                                     ByVal damping    As Single, _
	                                     ByVal warmstart  As Single, _
	                                     ByVal restlength As Single, _
	                                     ByVal particle_a As LinearState Ptr, _
	                                     ByVal particle_b As LinearState Ptr ) As LinearSpring Ptr
	
	Declare Function CreateLinearState( ByVal mass     As Single, _
	                                    ByVal position As Vec2 ) As LinearState Ptr
	
	Declare Function CreateNewtonGravity( ByVal particle_a As LinearState Ptr, _
	                                      ByVal particle_b As LinearState Ptr ) As NewtonGravity Ptr
	
	Declare Function CreateRigidBody() As RigidBody Ptr
	
	Declare Function CreateRigidBody( ByVal particles As Integer, _
	                                  ByVal radius    As Single, _
	                                  ByVal position  As Vec2 ) As RigidBody Ptr
	
	Declare Function CreateShapeBody( ByVal particles As Integer, _
	                                  ByVal radius    As Single, _
	                                  ByVal position  As Vec2 ) As ShapeBody Ptr
	
	Declare Function CreateSoftBody( ByVal particles As Integer, _
	                                 ByVal position  As Vec2 ) As SoftBody Ptr
	
	Declare Function CreateSoftBody( ByVal particles As Integer, _
	                                 ByVal radius    As Single, _
	                                 ByVal position  As Vec2 ) As SoftBody Ptr
	
	
	'' Reset
	Declare Sub ResetAll()
	
	'' Merge / Split
	Declare Function MergeParticles( ByVal particle_a As LinearState Ptr, _
	                                 ByVal particle_b As LinearState Ptr ) As LinearState
	
	Declare Function SplitParticle( ByVal P As LinearState Ptr, _
	                                ByVal C As Single ) As LinearState
	
	'Protected:
	
	'' Flags
	As UInteger Flags                    ''           
	
	'' Object arrays ( All physical objects are stored here )
	As AngularSpringArray  AngularSprings_
	As BodyArray           Bodys_
	As FixedSpringArray    FixedSprings_
	As KeplerOrbitArray    KeplerOrbits_
	As LinearLinkArray     LinearLinks_
	As LinearSpringArray   LinearSprings_
	As NewtonGravityArray  NewtonGravitys_
	As LinearStateArray    LinearStates_
	As AngularStateArray   AngularStates_
	As SoftBodyArray       SoftBodys_
	As RigidBodyArray      RigidBodys_
	As ShapeBodyArray      ShapeBodys_
	
End Type


'' Constructors
Constructor World()
	
	''
	AngularSprings_.Reserve ( MAX_ANGULAR_SPRINGS )
	Bodys_.Reserve          ( MAX_BODYS )
	FixedSprings_.Reserve   ( MAX_FIXED_SPRINGS )
	KeplerOrbits_.Reserve   ( MAX_KEPLER_ORBITS )
	LinearSprings_.Reserve  ( MAX_LINEAR_SPRINGS )
	LinearLinks_.Reserve    ( MAX_LINEAR_LINKS )
	NewtonGravitys_.Reserve ( MAX_NEWTON_GRAVITYS )
	LinearStates_.Reserve   ( MAX_LINEAR_STATES )
	AngularStates_.Reserve  ( MAX_ANGULAR_STATES )
	SoftBodys_.Reserve      ( MAX_SOFT_BODYS )
	RigidBodys_.Reserve     ( MAX_RIGID_BODYS )
	ShapeBodys_.Reserve     ( MAX_SHAPE_BODYS )
	
End Constructor

Constructor World( ByRef w As World )
	
	This = w
	
End Constructor


'' Destructor
Destructor World()
	
	''
	AngularSprings_.Destroy()
	Bodys_.Destroy()
	FixedSprings_.Destroy()
	KeplerOrbits_.Destroy()
	LinearSprings_.Destroy()
	LinearLinks_.Destroy()
	NewtonGravitys_.Destroy()
	LinearStates_.Destroy()
	AngularStates_.Destroy()
	SoftBodys_.Destroy()
	RigidBodys_.Destroy()
	ShapeBodys_.Destroy()
	
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
		LinearLinks_     = w.LinearLinks_
		NewtonGravitys_  = w.NewtonGravitys_
		LinearStates_    = w.LinearStates_
		AngularStates_   = w.AngularStates_
		SoftBodys_       = w.SoftBodys_
		RigidBodys_      = w.RigidBodys_
		ShapeBodys_      = w.ShapeBodys_
		
	EndIf
	
End Operator


'' Apply
Sub World.ApplyImpulseDistribution()
	
	'If ( Not LinearSprings_.Empty ) Then 
	'	
	'	For I As LinearSpring Ptr = LinearSprings_.p_front To LinearSprings_.p_back
	'		
	'		I->ApplyImpulseDistribution( 1.0 )
	'		
	'	Next
	'	
	'End If
	
	'''
	'If ( Not Bodys_.Empty ) Then
	'	
	'	For I As Body Ptr = Bodys_.p_front To Bodys_.p_back
	'		
	'		I->ApplyImpulseDistribution( 1.0 )
	'		
	'	Next
	'	
	'EndIf
	'
	'''
	'If ( Not SoftBodys_.Empty ) Then
	'	
	'	For I As SoftBody Ptr = SoftBodys_.p_front To SoftBodys_.p_back
	'		
	'		I->ApplyImpulseDistribution( 1.0 )
	'		
	'	Next
	'	
	'EndIf
	'
	'''
	'If ( Not ShapeBodys_.Empty ) Then
	'	
	'	For I As ShapeBody Ptr = ShapeBodys_.p_front To ShapeBodys_.p_back
	'		
	'		I->ApplyImpulseDistribution( 1.0 )
	'		
	'	Next
	'	
	'EndIf
	
	'If ( Not RigidBodys_.Empty ) Then
	'	
	'	For I As RigidBody Ptr = RigidBodys_.p_front To RigidBodys_.p_back
	'		
	'		I->ApplyImpulseDistribution( 1.0 )
	'		
	'	Next
	'	
	'EndIf
	
End Sub

Sub World.ApplyImpulses()
	
	''
	If ( NewtonGravitys_.size > 0 ) Then
			
		For I As NewtonGravity Ptr = NewtonGravitys_.p_front To NewtonGravitys_.p_back
			
			I->applyImpulse()
			
		Next
		
	EndIf
	
	''
	For I As Integer = 1 To NUM_ITERATIONS
		
		''
		If ( Not AngularSprings_.Empty ) Then 
			
			For II As AngularSpring Ptr = AngularSprings_.p_front To AngularSprings_.p_back
				
				II->applyCorrectiveImpulse()
				
			Next
			
		End If
		
		''
		If ( Not FixedSprings_.Empty ) Then 
			
			For II As FixedSpring Ptr = FixedSprings_.p_front To FixedSprings_.p_back
				
				II->applyCorrectiveImpulse()
				
			Next
			
		End If
		
		''
		If ( Not LinearSprings_.Empty ) Then 
			
			For II As LinearSpring Ptr = LinearSprings_.p_front To LinearSprings_.p_back
				
				II->applyCorrectiveImpulse()
				
			Next
			
		End If
		
		''
		ApplyImpulseDistribution()
		
	Next
	
End Sub

Sub World.ApplyWarmStart()
	
	''
	If ( Not AngularSprings_.Empty ) Then 
		
		For AP as AngularSpring Ptr = AngularSprings_.p_front To AngularSprings_.p_back
			
			AP->ApplyWarmStart()
			
		Next
		
	End If
	
	''
	If ( Not FixedSprings_.Empty ) Then 
		
		For FP As FixedSpring Ptr = FixedSprings_.p_front To FixedSprings_.p_back
			
			FP->ApplyWarmStart()
			 
		Next
		
	End If
	
	''
	If ( Not LinearSprings_.Empty ) Then 
		
		For LP As LinearSpring Ptr = LinearSprings_.p_front To LinearSprings_.p_back
			
			LP->ApplyWarmStart()
			 
		Next
	
	End If
	
End Sub


'' Compute
'Sub World.WhatAmIOrbiting( ByVal P As LinearState Ptr, Byval array As NewtonGravityArray Ptr )
Sub World.WhatAmIOrbiting( ByVal P As LinearState Ptr, Byval array As LinearLinkArray Ptr )
	
	'' Compute what object - or body of objects - I am orbiting
	
	'' Find the orbit around the lightest object with specific energy < 0
	
	Dim As Single energy = 0.0
	Dim As Single force = 0.0
	
	Dim As LinearState Ptr orbiting = NULL

	For N As LinearLink Ptr = array->p_front To array->p_back
		
		If ( Not P = N ) Then
			
			''
			If ( P = N->GetParticleB ) Then
				
				Dim As Single mju = G * ( N->GetParticleA->GetMass + P->GetMass )
				Dim As Single vel2 = ( N->GetParticleA->GetVelocity - P->GetVelocity ).LengthSquared
				Dim As Single e = vel2 / 2.0 - mju / N->GetLength
				
				Dim As Single f = ( N->GetParticleA->GetMass * P->GetMass ) / N->GetLength
				
				'If ( e < energy ) And (  N->GetParticleA->GetInverseMass > inversemass ) Then
				If ( e < energy ) And ( f > force ) Then
					
					'InverseMass =  N->GetParticleA->GetInverseMass
					'dist = Length
					energy = e
					force = f
					orbiting = N->GetParticleA
					
				EndIf
				
			EndIf
			
			''
			If ( P = N->GetParticleA ) Then
				
				Dim As Single mju = G * ( N->GetParticleB->GetMass + P->GetMass )
				Dim As Single vel2 = ( P->GetVelocity - N->GetParticleB->GetVelocity ).LengthSquared
				Dim As Single e = vel2 / 2.0 - mju / N->GetLength
				
				Dim As Single f = ( N->GetParticleB->GetMass * P->GetMass ) / N->GetLength
				
				'If ( e < energy ) And ( N->GetParticleB->GetInverseMass > inversemass ) Then
				If ( e < energy ) And ( f > force ) Then
					
					'inversemass = N->GetParticleB->GetInverseMass
					'dist = Length
					energy = e
					force = f
					orbiting = N->GetParticleB
					
				EndIf
				
			EndIf
		
		End If
		
	Next
	
	If ( Not orbiting = NULL ) Then
		
		Dim As KeplerOrbit K = KeplerOrbit( P, Orbiting )
			
		k.DrawOrbit()
		
	End If
	
End Sub

Sub World.ComputeBroadPhase()
	
	'' This function determines in which cell in the broad-phase collision detection
	'' grid each particle is placed. Computation is very fast and CPU cheap.
	
	'If ( LinearStates_.size > 0 ) Then 
	'	
	'	For I As LinearState Ptr = LinearStates_.p_front To LinearStates_.p_back
	'		
	'		Dim As Integer cell_x = Cast( Integer, I->position.x * Grid_.InvCellDiameter )
	'		
	'		If ( cell_x < 0 ) Or ( cell_x > Grid_.NumCellsX ) Then Continue For
	'		
	'		Dim As Integer cell_y = Cast( Integer, I->position.y * Grid_.InvCellDiameter )
	'		
	'		If ( cell_y < 0 ) Or ( cell_y > Grid_.NumCellsY ) Then Continue For
	'		
	'		'Dim As Cell Ptr CP = @Grid_
	'		
	'		'If CP->numParticles_ >= BroadPhaseGrid.numParticlesPerCell_ Then Continue For
	'		
	'		'CP->numParticles_ += 1
	'		
	'		'CP->Particles( PC->numParticles_ ) = I
	'		
	'	Next
	'	
	'End If
	
End Sub

Sub World.computeData()
	
	''	In this function all the necessary data is Computed, such as
	'' spring lengths, unit vectors, soft body state vectors and so on.
	'' The function is passive. No base object states are changed, 
	'' and no impulses are applied.
	
	''
	If ( Not LinearStates_.Empty ) Then 
		
		For I as LinearState Ptr = LinearStates_.p_front To LinearStates_.p_back
			
			
		Next
		
	End If
	
	''
	If ( Not AngularStates_.Empty ) Then 
		
		For I as AngularState Ptr = AngularStates_.p_front To AngularStates_.p_back
			
			'I->ComputeAngle()
			'I->ComputeAngleVector()
			
		Next
		
	End If
	
	''
	If ( Not LinearSprings_.Empty ) Then 
		
		For I as LinearSpring Ptr = LinearSprings_.p_front To LinearSprings_.p_back
			
			I->ComputestateVectors()
			I->ComputeLengths()
			I->ComputeInertia()
			I->ComputeAngularVelocity()
			'I->ComputeAngle()
			I->ComputeRestImpulse()
			
		Next
		
	End If
	
	''
	If ( Not FixedSprings_.Empty ) Then 
	
		For I as FixedSpring Ptr = FixedSprings_.p_front To FixedSprings_.p_back
			
			I->ComputestateVectors()
			I->ComputeLengthVector()
			I->ComputeRestImpulse()
			
		Next
	
	End If
	
	''
	If ( Not Bodys_.Empty ) Then 
		
		For I as Body Ptr = Bodys_.p_front To Bodys_.p_back
			
			'I->ComputestateVectors()
			'I->ComputeInertia()
			'I->ComputeAngularVelocity()
			'I->ComputeAngle()
			'I->ComputeAngleVector()
			
		Next
		
	End If
	
	''
	If ( Not SoftBodys_.Empty ) Then 
		
		For I as SoftBody Ptr = SoftBodys_.p_front To SoftBodys_.p_back
			
			I->ComputestateVectors()
			I->ComputeInertia()
			I->ComputeAngularVelocity()
			'I->ComputeAngle()
			'I->ComputeAngleVector()
			
		Next
		
	End If
	
	''
	If ( Not ShapeBodys_.Empty ) Then 
		
		For I as ShapeBody Ptr = ShapeBodys_.p_front To ShapeBodys_.p_back
			
			I->ComputestateVectors()
			I->ComputeInertia()
			I->ComputeAngularVelocity()
			'I->ComputeAngle()
			'I->ComputeAngleVector()
			
		Next
		
	End If
	
	''
	'If ( Not RigidBodys_.Empty ) Then 
	'	
	'	For I as RigidBody Ptr = RigidBodys_.p_front To RigidBodys_.p_back
	'		
	'		'I->ComputestateVectors()
	'		'I->ComputeInertia()
	'		'I->ComputeAngularVelocity()
	'		'I->ComputeAngle()
	'		'I->ComputeAngleVector()
	'		
	'	Next
	'	
	'End If
	
	''
	If ( Not NewtonGravitys_.Empty ) Then 
		
		For I as NewtonGravity Ptr = NewtonGravitys_.p_front To NewtonGravitys_.p_back
			
			If I->GetFlag( IS_ACTIVE ) Then
				
				I->ComputestateVectors()
				I->ComputeLengths()
				
			End If
				
		Next
		
	End If
	
	''
	If ( Not KeplerOrbits_.Empty ) Then 
		
		For I as KeplerOrbit Ptr = KeplerOrbits_.p_front To KeplerOrbits_.p_back
			
			'I->ComputeKeplerFromState()
			
		Next
		
	End If
	
	''
	If ( Not AngularSprings_.Empty ) Then 
		
		For I as AngularSpring Ptr = AngularSprings_.p_front To AngularSprings_.p_back
			
			'I->ComputeAngle()
			'I->ComputeAngleVector()
			'I->ComputeReducedInertia()
			I->ComputeRestImpulse()
			
		Next
	
	End If
	
End Sub

Sub World.ComputeNarrowPhase()
	
End Sub

Sub World.ComputeNewState()
	
	''
	If ( Not LinearStates_.Empty ) Then 
		
		For I As LinearState Ptr = LinearStates_.p_front To LinearStates_.p_back
			
			If ( I->GetFlag( IS_ACTIVE Or IS_DYNAMIC ) ) Then
				
				I->ComputeNewState()
				
			End If
			
		Next
		
	End If
	
	''
	If ( Not AngularStates_.Empty ) Then 
		
		For I As AngularState Ptr = AngularStates_.p_front To AngularStates_.p_back
			
			If ( I->GetFlag( IS_ACTIVE Or IS_DYNAMIC ) ) Then
				
				I->ComputeNewState()
				
			End If
			
		Next
		
	End If
	
	''
	If ( Not LinearSprings_.Empty ) Then 
		
		For I As LinearSpring Ptr = LinearSprings_.p_front To LinearSprings_.p_back
			
			If ( I->GetFlag( IS_ACTIVE Or IS_DYNAMIC ) ) Then
				
				I->SetAngularImpulse( 0.0 )
				I->SetImpulse( Vec2( 0.0, 0.0 ) )
				
				I->SetPrevAngularImpulse( 0.0 )
				I->SetPrevLinearImpulse( Vec2( 0.0, 0.0 ) )
				
			End If
			
		Next
		
	End If
	
	'''
	'If ( AngularSprings_.size > 0 ) Then 
	'	
	'	For I As AngularSpring Ptr = AngularSprings_.p_front To AngularSprings_.p_back
	'		
	'		If ( I->GetFlag( IS_ACTIVE Or IS_DYNAMIC ) ) Then
	'			
	'			''
	'			I->Impulse( Vec2( 0.0, 0.0 ) )
	'			I->AngularImpulse( 0.0 )
	'			
	'		End If
	'		
	'	Next
	'	
	'End If
	
	''
	If ( Not Bodys_.Empty ) Then 
		
		For I As Body Ptr = Bodys_.p_front To Bodys_.p_back
			
			If ( I->GetFlag( IS_ACTIVE Or IS_DYNAMIC ) ) Then
				
				I->ComputeNewState()
				
				I->SetAngularImpulse( 0.0 )
				I->SetImpulse( Vec2( 0.0, 0.0 ) )
				
				I->SetPrevAngularImpulse( 0.0 )
				I->SetPrevLinearImpulse( Vec2( 0.0, 0.0 ) )
				
			End If
			
		Next
		
	End If
	
	''
	If ( Not ShapeBodys_.Empty ) Then 
		
		For I As ShapeBody Ptr = ShapeBodys_.p_front To ShapeBodys_.p_back
			
			If ( I->GetFlag( IS_ACTIVE Or IS_DYNAMIC ) ) Then
				
				'I->ComputeAngularVelocity()
				I->ComputeNewState()
				
				I->SetAngularImpulse( 0.0 )
				I->SetImpulse( Vec2( 0.0, 0.0 ) )
				
				I->SetPrevAngularImpulse( 0.0 )
				I->SetPrevLinearImpulse( Vec2( 0.0, 0.0 ) )
				
			End If
			
		Next
		
	End If
	
	''
	If ( Not SoftBodys_.Empty ) Then 
		
		For I As SoftBody Ptr = SoftBodys_.p_front To SoftBodys_.p_back
			
			If ( I->GetFlag( IS_ACTIVE Or IS_DYNAMIC ) ) Then
				
				I->ComputeNewState()
				
				'I->SetAngularImpulse( 0.0 )
				'I->SetImpulse( Vec2( 0.0, 0.0 ) )
				'
				'I->SetPrevAngularImpulse( 0.0 )
				'I->SetPrevLinearImpulse( Vec2( 0.0, 0.0 ) )
				
			End If
			
		Next
		
	End If
	
	''
	If ( Not RigidBodys_.Empty ) Then 
		
		For I As RigidBody Ptr = RigidBodys_.p_front To RigidBodys_.p_back
			
			If ( I->GetFlag( IS_ACTIVE Or IS_DYNAMIC ) ) Then
				
				I->ComputeNewState()
				
			End If
			
		Next
		
	End If
	
End Sub


''
Sub World.ResetAll()
	
	''
	Flags = 0
	
	''
	AngularSprings_.Clear()
	Bodys_.Clear()
	FixedSprings_.Clear()
	KeplerOrbits_.Clear()
	LinearLinks_.Clear()
	LinearSprings_.Clear()
	NewtonGravitys_.Clear()
	LinearStates_.Clear()
	AngularStates_.Clear()
	SoftBodys_.Clear()
	RigidBodys_.Clear()
	ShapeBodys_.Clear()
	
End Sub


'' Merge / Split
Function World.MergeParticles( ByVal particle_a As LinearState Ptr, _
	                            ByVal particle_b As LinearState Ptr ) As LinearState
	
	Dim As LinearState P
	
	Dim As Single inverse_mass = particle_a->GetInverseMass + particle_b->GetInverseMass
	
	P.SetPosition( ( particle_a->GetPosition * particle_a->GetMass + _
	                 particle_b->GetPosition * particle_b->GetMass ) * inverse_mass )
	
	P.SetVelocity( ( particle_a->GetVelocity * particle_a->GetMass + _
	                 particle_b->GetVelocity * particle_b->GetMass ) * inverse_mass )
	
	P.SetImpulse( ( particle_a->GetImpulse * particle_a->GetMass + _
	                particle_b->GetImpulse * particle_b->GetMass ) * inverse_mass )
	
	Return P
	
End Function

Function World.SplitParticle( ByVal P As LinearState Ptr, _
	                           ByVal C As Single ) As LinearState
	
	Dim As LinearState P_a
	
	Return P_a
	
End Function


#EndIf ''__S2_WORLD_BI__
