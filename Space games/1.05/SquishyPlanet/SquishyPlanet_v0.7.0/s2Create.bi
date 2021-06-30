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
''   Object creation wrappers. Moved away from s2World.bi because they are too bulky.
''
''****************************************************************************** 


''
#Ifndef __S2_CREATE_BI__
#Define __S2_CREATE_BI__


Function World.CreateAngularSpring( ByVal stiffnes  As Single, _
	                                 ByVal damping   As Single, _
	                                 ByVal warmstart As Single, _
	                                 ByRef rotate_a  As AngularState Ptr, _
	                                 ByRef rotate_b  As AngularState Ptr ) As AngularSpring Ptr
	
	Dim As AngularSpring A = AngularSpring( stiffnes, damping, warmstart, rotate_a, rotate_b )
	
	Dim As AngularSpring Ptr AP = AngularSprings_.push_back( A )
	
	Return AP
	
End Function

Function World.CreateAngularSpring( ByVal stiffnes        As Single, _
	                                 ByVal damping         As Single, _
	                                 ByVal warmstart       As Single, _
	                                 ByVal restanglevector As Vec2, _
	                                 ByRef rotate_a        As AngularState Ptr, _
	                                 ByRef rotate_b        As AngularState Ptr ) As AngularSpring Ptr
	
	Dim As AngularSpring A = AngularSpring( stiffnes, damping, warmstart, restanglevector, rotate_a, rotate_b )
	
	Dim As AngularSpring Ptr AP = AngularSprings_.push_back( A )
	
	Return AP
	
End Function

Function World.CreateAngularSpring( ByVal stiffnes  As Single, _
	                                 ByVal damping   As Single, _
	                                 ByVal warmstart As Single, _
	                                 ByVal restangle As Single, _
	                                 ByRef rotate_a  As AngularState Ptr, _
	                                 ByRef rotate_b  As AngularState Ptr ) As AngularSpring Ptr
	
	Dim As AngularSpring A = AngularSpring( stiffnes, damping, warmstart, restangle, rotate_a, rotate_b )
	
	Dim As AngularSpring Ptr AP = AngularSprings_.push_back( A )
	
	Return AP
	
End Function

Function World.CreateFixedSpring( ByVal stiffnes   As Single, _
                                  ByVal damping    As Single, _
                                  ByVal warmstart  As Single, _
                                  ByRef particle_a As LinearState Ptr, _
                                  ByRef particle_b As LinearState Ptr ) As FixedSpring Ptr
	
	Dim As FixedSpring F = FixedSpring( stiffnes, damping, warmstart, particle_a, particle_b )
	
	Dim As FixedSpring Ptr FP = FixedSprings_.push_back( F )
	
	Return FP
	
End Function

Function World.CreateFixedSpring( ByVal stiffnes   As Single, _
                                  ByVal damping    As Single, _
                                  ByVal warmstart  As Single, _
                                  ByVal restlength As Vec2, _
                                  ByRef particle_a As LinearState Ptr, _
                                  ByRef particle_b As LinearState Ptr ) As FixedSpring Ptr
	
	Dim As FixedSpring F = FixedSpring( stiffnes, damping, warmstart, restlength, particle_a, particle_b )
	
	Dim As FixedSpring Ptr FP = FixedSprings_.push_back( F )
	
	Return FP
	
End Function

Function World.CreateLinearState( ByVal mass     As Single, _
	                               ByVal position As Vec2 ) As LinearState Ptr
   
   Dim As LinearState P = LinearState( mass, position )
   
   Dim As LinearState Ptr PP = LinearStates_.push_back( P )
   
   Return PP
   
End Function

Function World.CreateKeplerOrbit( ByVal particle_a As LinearState Ptr, _
	                               ByVal particle_b As LinearState Ptr ) As KeplerOrbit Ptr
	
	Dim As KeplerOrbit K = KeplerOrbit( particle_a, particle_b )
	
	Dim As KeplerOrbit Ptr KP = KeplerOrbits_.push_back( K )
	
	Return KP
	
End Function

Function World.CreateLinearSpring( ByVal stiffness  As Single, _
	                                ByVal damping    As Single, _
	                                ByVal warmstart  As Single, _
	                                ByVal particle_a As LinearState Ptr, _
	                                ByVal particle_b As LinearState Ptr ) As LinearSpring Ptr
	
	Dim As LinearSpring L = LinearSpring( stiffness, damping, warmstart,particle_a, particle_b )
	
	Dim As LinearSpring Ptr LP = LinearSprings_.push_back( L )
	
	Return LP
	
End Function

Function World.CreateLinearSpring( ByVal stiffness  As Single, _
	                                ByVal damping    As Single, _
	                                ByVal warmstart  As Single, _
	                                ByVal restlength As Single, _
	                                ByVal particle_a As LinearState Ptr, _
	                                ByVal particle_b As LinearState Ptr ) As LinearSpring Ptr
	
	Dim As LinearSpring L = LinearSpring( stiffness, damping, warmstart, restlength, particle_a, particle_b )
	
	Dim As LinearSpring Ptr LP = LinearSprings_.push_back( L )
	
	Return LP
	
End Function

Function World.CreateNewtonGravity( ByVal particle_a As LinearState Ptr, _
	                                 ByVal particle_b As LinearState Ptr ) As NewtonGravity Ptr
	
	Dim As NewtonGravity N = NewtonGravity( particle_a, particle_b )
	
	Dim As NewtonGravity Ptr NP = NewtonGravitys_.push_back( N )
	
	Return NP
	
End Function

Function World.CreateBody( ByVal _position    As Vec2, _
	                        ByVal _num_objects As Integer ) As Body Ptr
	
	Dim As Body B = Body()
	
	Dim As Body Ptr BP = Bodys_.push_back( B )
	
	BP->LinearStates_.Reserve( _num_objects )
	
	Return BP
	
End Function

Function World.CreateRigidBody() As RigidBody Ptr
	
	Dim As RigidBody R = RigidBody()
	
	Dim As RigidBody Ptr RP = RigidBodys_.push_back( R )
	
	Return RP
	
End Function

Function World.CreateRigidBody( ByVal particles As Integer, _
	                             ByVal radius    As Single, _
	                             ByVal position  As Vec2 ) As RigidBody Ptr
	
	Dim As RigidBody R = RigidBody()
	
	Dim As RigidBody Ptr RP = RigidBodys_.push_back( R )
	
	RP->LinearStates_.Reserve( particles )
	
	''
	For i As Integer = 0 To particles - 1
		
		Dim As LinearState Ptr P = CreateLinearState( 1.0, position + Vec2().RandomizeCircle( 1.0 ) * radius )
		
		P->LowerFlag( IS_DYNAMIC )
		
		RP->LinearStates_.push_back( P )
		
	Next
	
	''
	RP->ComputeMass()
	RP->ComputestateVectors()
	RP->ComputeInertia()
	RP->ComputeAngularVelocity()
	RP->ComputeAngle()
	RP->ComputeAngleVector()
	
	RP->RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
	Return RP
	
End Function

Function World.CreateShapeBody( ByVal particles As Integer, _
	                             ByVal radius    As Single, _
	                             ByVal position  As Vec2 ) As ShapeBody Ptr
	
	Dim As Single angle       = 0.0
	Dim As Single delta_angle = TWO_PI / particles
	
	Dim As ShapeBody S = ShapeBody()
	
	Dim As ShapeBody Ptr SP = ShapeBodys_.push_back( S )
	
	SP->LinearStates_.Reserve( particles )
	SP->FixedSprings_.Reserve( particles )
	
	''
	For i As Integer = 0 To particles - 1
		
		Dim As LinearState Ptr P = CreateLinearState( 1.0, position + Vec2( Cos( angle ) * radius, Sin( angle ) * radius )  )
		
		SP->LinearStates_.push_back( P )
		
		angle += delta_angle
		
	Next
	
	''
	For i As Integer = 0 To particles - 1
		
		Dim As Integer j = ( i + 1 ) Mod particles
		
		Dim As FixedSpring Ptr F = CreateFixedSpring( C_FIXED_STIFFNESS, _
		                                              C_FIXED_DAMPING, _
		                                              C_FIXED_WARMSTART, _
		                                              *SP->LinearStates_[i], _
		                                              *SP->LinearStates_[j] )
		
		SP->FixedSprings_.push_back( F )
		
	Next
	
	''
	SP->ComputeMass()
	SP->ComputestateVectors()
	SP->ComputeInertia()
	SP->ComputeAngularVelocity()
	SP->ComputeAngle()
	SP->ComputeAngleVector()
	
	SP->RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
	Return SP
	
End Function

Function World.CreateSoftBody( ByVal particles As Integer, _
	                            ByVal position  As Vec2 ) As SoftBody Ptr
	
	Dim As Single radius      = 96.0
	Dim As Single angle       = 0.0
	Dim As Single delta_angle = TWO_PI / particles
	
	Dim As SoftBody S = SoftBody()
	
	Dim As SoftBody Ptr SP = SoftBodys_.push_back( S )
	
	SP->LinearStates_.Reserve( particles )
	SP->LinearSprings_.Reserve( particles )
	SP->AngularSprings_.Reserve( particles )
	
	For i As Integer = 0 To particles - 1
		
		Dim As LinearState Ptr P = CreateLinearState( 1.0, position + Vec2( Cos( angle ) * radius, Sin( angle ) * radius )  )
		
		SP->LinearStates_.push_back( P )
		
		angle += delta_angle
		
	Next
	
	For i As Integer = 0 To particles - 1
		
		Dim As Integer j = ( i + 1 ) Mod particles
		
		Dim As LinearSpring Ptr L = CreateLinearSpring( C_LINEAR_STIFFNESS, _
		                                                C_LINEAR_DAMPING, _
		                                                C_LINEAR_WARMSTART, _
		                                                *SP->LinearStates_[i], _
		                                                *SP->LinearStates_[j] )
		
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
	SP->ComputestateVectors()
	SP->ComputeInertia()
	SP->ComputeAngularVelocity()
	SP->ComputeAngle()
	SP->ComputeAngleVector()
	
	Return SP
	
End Function

Function World.CreateSoftBody( ByVal particles As Integer, _
	                            ByVal radius    As Single, _
	                            ByVal position  As Vec2 ) As SoftBody Ptr
	
	
	Dim As Single angle       = 0.0
	Dim As Single delta_angle = TWO_PI / particles
	
	Dim As SoftBody S = SoftBody()
	
	Dim As SoftBody Ptr SP = SoftBodys_.push_back( S )
	
	SP->LinearStates_.Reserve( particles )
	SP->LinearSprings_.Reserve( particles )
	SP->AngularSprings_.Reserve( particles )
	
	For i As Integer = 0 To particles - 1
		
		Dim As LinearState Ptr P = CreateLinearState( 1.0, position + Vec2( Cos( angle ) * radius, Sin( angle ) * radius )  )
		
		SP->LinearStates_.push_back( P )
		'SP->AddObject( P ) '' suspicious behaviour, sometimes crashes.
		
		angle += delta_angle
		
	Next
	
	For i As Integer = 0 To particles - 1
		
		Dim As Integer j = ( i + 1 ) Mod particles
		
		Dim As LinearSpring Ptr L = CreateLinearSpring( C_LINEAR_STIFFNESS, _
		                                                C_LINEAR_DAMPING, _
		                                                C_LINEAR_WARMSTART, _
		                                                *SP->LinearStates_[i], _
		                                                *SP->LinearStates_[j] )
		
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
	SP->ComputestateVectors()
	SP->ComputeInertia()
	SP->ComputeAngularVelocity()
	
	SP->RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
	Return SP
	
End Function

Function World.CreateAngularState( ByVal _mass     As Single, _
	                                ByVal _inertia  As Single, _
	                                ByVal _position As Vec2 ) As AngularState Ptr
	
	Dim As AngularState R = AngularState( _mass, _inertia, _position )
   
   Dim As AngularState Ptr RP = AngularStates_.push_back( R )
   
   Return RP
	
End Function

Function World.CreateAngularState( ByVal _mass     As Single, _
	                                ByVal _inertia  As Single, _
	                                ByVal _angle    As Single, _
	                                ByVal _position As Vec2 ) As AngularState Ptr
	
	Dim As AngularState R = AngularState( _mass, _inertia, _angle, _position )
   
   Dim As AngularState Ptr RP = AngularStates_.push_back( R )
   
   Return RP
	
End Function

Function World.CreateAngularState( ByVal _mass        As Single, _
	                                ByVal _inertia  As Single, _
	                                ByVal _anglevector As Vec2, _
	                                ByVal _position    As Vec2 ) As AngularState Ptr
	
	Dim As AngularState R = AngularState( _mass, _inertia, _anglevector, _position )
   
   Dim As AngularState Ptr RP = AngularStates_.push_back( R )
   
   Return RP
	
End Function


#EndIf ''__S2_CREATE_BI__
