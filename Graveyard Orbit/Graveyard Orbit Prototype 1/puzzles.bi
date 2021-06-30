''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 1, November 2016
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  Warning: Looking at the following code may cause permanent eye damage!
''
''  Controls:
''  
''  Puzzles                    :  F1 - F6
''  Double / halve iterations  :  1 - 9
''  Inc. / dec. iterations     :  I + up / down
''  Inc. / dec. stiffness      :  S + up / down
''  Inc. / dec. damping        :  D + up / down
''  Inc. / dec. warmstart      :  W + up / down
''  Warmstart on / off         :  Space bar
''  Exit demo                  :  Escape key
''  
''******************************************************************************* 


Sub GameType.Puzzle1()
	
	'' Wrecking ball
	
	iterations   = 10
	warmstart    = 1
	cStiffness   = 1.0    
	cDamping     = 1.0
	cWarmstart   = 0.5
	
	Dim As Integer num_Particles = 13
	Dim As Integer num_Springs   = 12
	Dim As Integer SpringLength  = 30 
	
	PuzzleText = "Demo 1: Wrecking ball. "
	
	''
	LinearStates.Clear()
	AngularStates.Clear()
	Roxels.Clear()
	Rigidbodys.Clear()
	Gravitys.Clear()
	FixedConstraints.Clear()
	LL_Constraints.Clear()
	angularconstraints.Clear()
	
	'' create particles
	Dim As LinearStateType R
		
	R.mass         = 1.0
	R.inverse_mass = 0
	R.position.x   = 0.5 * screen_wid
	R.position.y   = 0.25 * screen_hgt
	
	LinearStates.push_back( R )
	
	For i As integer = 2 To num_Particles
		
		Dim As LinearStateType R
		
		R.mass         = 1.0
		R.inverse_mass = 1.0 / R.mass
		
		If i = num_Particles Then
			
			R.mass         = 100.0
			R.inverse_mass = 1.0 / R.mass
			R.velocity.y   = 50
			
		EndIf
		
		R.position.x   = 0.5 * screen_wid + ( i - 1 ) * SpringLength
		R.position.y   = 0.25 * screen_hgt
		
		LinearStates.push_back( R )
		
	Next
	
	''  create springs
	For i As Integer = 0 To num_Springs-1
		
		Dim As LL_ConstraintType S
		
		S.particle_a    = LinearStates[i]
		S.particle_b    = LinearStates[i+1]
		S.rest_distance = (S.particle_b->position - S.particle_a->position).length()
		
		Dim As Single inverseMass = S.particle_a->inverse_mass + S.particle_b->inverse_mass
		
		S.reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
		
		LL_constraints.push_back( S )
		
	Next

End Sub

Sub GameType.Puzzle2()
	
	'' 
	
	iterations   = 10
	warmstart    = 1
	
	cStiffness   = 1.0 
	cDamping     = 1.0
	cWarmstart   = 1.0
	
	cAstiffness  = 0.1
	cAdamping    = 0.1
	cAwarmstart  = 0.0
	
	Dim As Integer num_Particles       = 16
	Dim As Integer num_Springs         = 15
	Dim As Integer num_angular_Springs = 14
	Dim As Integer SpringLength        = 100.0
	Dim As Single  Angle               = 0.0
	Dim As Single  delta_direction     = 2 * 4*Atn(1) / num_Springs
	
	PuzzleText = ""
	
	''
	LinearStates.Clear()
	AngularStates.Clear()
	Roxels.Clear()
	Rigidbodys.Clear()
	Gravitys.Clear()
	FixedConstraints.Clear()
	LL_Constraints.Clear()
	angularconstraints.Clear()
	
	Randomize
	
	'' create particles
	For i As integer = 0 To num_Particles - 1
		
		Dim As LinearStateType R
		
		R.mass = 1.0
		
		R.inverse_mass = 1.0 / R.mass
		
		R.position = 0.5 * Vec2( screen_wid, screen_hgt ) + Vec2( Cos(Angle), Sin(Angle) ) * SpringLength
		
		Angle += delta_direction
		
		LinearStates.push_back(R)
		
	Next
	
	'' create springs
	For i As Integer = 0 To num_Springs - 1
		
		Dim As LL_ConstraintType S
				
		S.particle_a    = LinearStates[i]
		S.particle_b    = LinearStates[i+1]
		S.rest_distance = ( S.particle_b->position - S.particle_a->position ).length()
		S.unit          = ( S.particle_b->position - S.particle_a->position ).unit()
		
		Dim As Single inverseMass = S.particle_a->inverse_mass + S.particle_b->inverse_mass
		
		S.reduced_mass = IIf( inverseMass > 0.0 , 1.0 / inverseMass , 0.0 )
		
		LL_constraints.push_back( S )
		
	Next
	
	'' create angular springs
	For i As Integer = 0 To num_angular_Springs-1 
		
		Dim As AngularConstraintType A
		
		A.spring_a = LL_constraints[i]
		A.spring_b = LL_constraints[i+1]
		
		A.rest_direction = Vec2( A.spring_a->unit.dot( A.spring_b->unit ), _
		                         A.spring_a->unit.perpdot( A.spring_b->unit ) )
		
		A.rest_direction = Vec2( Cos( 0.0 * 2 * PI ), Sin( 0.0 * 2 * PI ) )
		
		AngularConstraints.push_back( A )
		
	Next
	
End Sub

Sub GameType.Puzzle3()
	
	'' Horizontal steel girder
	
	iterations   = 10
	warmstart    = 1
	cStiffness   = 1.0
	cDamping     = 1.0
	cWarmstart   = 1.0
	
	Dim As Integer GirderWidth  = 2
	Dim As Integer GirderLength = 32
	Dim As Integer SpringLength = 20
	
	PuzzleText = ""
	
	''
	LinearStates.Clear()
	AngularStates.Clear()
	Roxels.Clear()
	Rigidbodys.Clear()
	Gravitys.Clear()
	FixedConstraints.Clear()
	LL_Constraints.Clear()
	angularconstraints.Clear()
	
	
	CreateGirder( Vec2( 200.0, 200.0 ), _
	              Vec2( Cos( 0.0 * PI ), Sin( 0.0 * PI )), _
	              GirderWidth, _
	              GirderLength, _
	              SpringLength, _
	              S_TRUSS )
	
	CreateGirder( Vec2( 200.0, 400.0 ), _
	              Vec2( Cos( 0.2 * PI ), Sin( 0.2 * PI )), _
	              GirderWidth, _
	              GirderLength, _
	              SpringLength, _
	              Z_TRUSS )
	
	CreateGirder( Vec2( 200.0, 600.0 ), _
	              Vec2( Cos( 0.8 * PI ), Sin( 0.8 * PI )), _
	              GirderWidth, _
	              GirderLength, _
	              SpringLength, _
	              X_TRUSS )
	
End Sub

Sub GameType.Puzzle4()
	
	''
	
	iterations   = 10
	warmstart    = 0
	
	cStiffness   = 1.0   
	cDamping     = 1.0
	cWarmstart   = 0.5
	
	cAstiffness  = 0.2
	cAdamping    = 0.5
	cAwarmstart  = 0.5
	
	PuzzleText = "Gravitational interaction"
	
	''
	LinearStates.Clear()
	AngularStates.Clear()
	Roxels.Clear()
	Rigidbodys.Clear()
	Gravitys.Clear()
	FixedConstraints.Clear()
	LL_Constraints.Clear()
	angularconstraints.Clear()
	
	
	Dim As RoxelType P1
	
	P1.Linear.mass         = 40.0
	P1.Linear.inverse_mass = 1.0 / P1.Linear.mass
	P1.radius              = 10.0
	P1.Linear.position.x   = 200
	P1.Linear.position.y   = 200
	
	Dim As RoxelType Ptr PP1 = Roxels.push_back(P1)
	
	Dim As RoxelType P2
	
	P2.Linear.mass         = 40.0
	P2.Linear.inverse_mass = 1.0 / P2.Linear.mass
	P2.radius       = 10.0
	P2.Linear.position.x   = 900
	P2.Linear.position.y   = 500
	
	Dim As RoxelType Ptr PP2 = Roxels.push_back(P2)
	
	Dim As RoxelType P3
	
	P3.Linear.mass         = 40.0
	P3.Linear.inverse_mass = 1.0 / P3.Linear.mass
	P3.radius       = 10.0
	P3.Linear.position.x   = 300
	P3.Linear.position.y   = 700
	
	Dim As RoxelType Ptr PP3 = Roxels.push_back(P3)
	
	Dim as GravityType G1
	
	G1.particle_a = @PP1->Linear
	G1.particle_b = @PP2->Linear
	
	Gravitys.push_back( G1 )
	
	Dim as GravityType G2
	
	G2.particle_a = @PP3->Linear
	G2.particle_b = @PP2->Linear
	
	Gravitys.push_back( G2 )
	
	Dim as GravityType G3
	
	G3.particle_a = @PP1->Linear
	G3.particle_b = @PP3->Linear
	
	Gravitys.push_back( G3 )
	
	'Dim As LL_ConstraintType Ptr S = CreateSpring()
	'
	'S->particle_a = @Particle(1)
	'S->particle_b = @Particle(2)
	'
End Sub

Sub GameType.Puzzle5()
	
	'' 
	
	iterations   = 10
	warmstart    = 0
	
	cStiffness   = 0.1 
	cDamping     = 0.1
	cWarmstart   = 0.1
	
	cAstiffness  = 0.0
	cAdamping    = 0.0
	cAwarmstart  = 0.0
	
	PuzzleText = ""
	
	''
	LinearStates.Clear()
	AngularStates.Clear()
	Roxels.Clear()
	Rigidbodys.Clear()
	Gravitys.Clear()
	FixedConstraints.Clear()
	LL_Constraints.Clear()
	angularconstraints.Clear()
	
	''
	Dim As RigidBodyType R
	
	R.Linear.position = Vec2( 400.0, 400.0 )
	R.Linear.velocity = Vec2( 0.0, 0.0 )
	
	R.Angular.direction = 0.0
	R.Angular.direction_Vector = Vec2( Cos( R.Angular.direction ) , Sin( R.Angular.direction ) )
	'R.Angular.Velocity = 0.0
	
	'R.Linear.mass = 20.0
	'R.Linear.inverse_mass = 1.0 / R.Linear.mass
	
	'R.Angular.inertia = 8000
	'R.Angular.inverse_inertia = 1.0 / R.Angular.inertia
	
	''
	Dim As RoxelType P
	
	P.linear.position = R.Linear.position + Vec2( 0.0, 200.0 )
	P.linear.mass = 10.0
	P.linear.inverse_mass = 1.0 / P.linear.mass
	P.radius = 10.0
	P.colour = RGB( 255, 0, 0 )
	
	'R.AddRoxel( P )
	R.Roxels.push_back( P )
	
	''
	P.linear.position = R.Linear.position + Vec2( 0.0, -200.0 )
	P.linear.mass = 10.0
	P.linear.inverse_mass = 1.0 / P.linear.mass
	P.radius = 10.0
	P.colour = RGB( 0, 255, 0 )
	
	
	'R.angular.impulse = 0.1
	P.Linear.impulse = Vec2( 10.0, 0.0 )
	'P.Linear.velocity = Vec2( 10.0, 0.0 )
	
	R.Roxels.push_back( P )
	
	R.computeData()
	
	Dim As rigidbodytype Ptr rbp = rigidbodys.push_Back( R )
	
	''
	Dim As RoxelType P1
	
	P1.Linear.mass         = 40.0
	P1.Linear.inverse_mass = 1.0 / P1.Linear.mass
	P1.radius              = 10.0
	P1.Linear.position.x   = 700
	P1.Linear.position.y   = 550
	P1.Linear.velocity.x   = 200
	
	Dim As RoxelType Ptr PP1 = Roxels.push_back(P1)
	
	
	''
	Dim As LL_ConstraintType S
	
	S.particle_a = @RigidBodys[0]->Roxels[0]->linear
	S.particle_b = @Roxels[0]->Linear
	
	S.rest_distance = (S.particle_b->position - S.particle_a->position).length()
	
	Dim As Single inverseMass = S.particle_a->inverse_mass + S.particle_b->inverse_mass
	
	S.reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
	
	LL_constraints.push_back( S )
	
	''
	Dim As RoxelType P2
	
	P2.Linear.mass         = 10.0
	P2.Linear.inverse_mass = 0'1.0 / P2.Linear.mass
	P2.radius              = 10.0
	P2.Linear.position.x   = 600
	P2.Linear.position.y   = 450
	
	Dim As RoxelType Ptr PP2 = Roxels.push_back(P2)
	
	''
	S.particle_a = @RigidBodys[0]->Roxels[1]->linear
	S.particle_b = @Roxels[1]->Linear
	
	S.rest_distance = (S.particle_b->position - S.particle_a->position).length()
	
	inverseMass = S.particle_a->inverse_mass + S.particle_b->inverse_mass
	
	S.reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
	
	LL_constraints.push_back( S )
	
End Sub

Sub GameType.Puzzle6()
	
	'' 
	
	iterations   = 10
	warmstart    = 1
	
	cStiffness   = 1.0  
	cDamping     = 1.0
	cWarmstart   = 1.0
	
	cAstiffness  = 0.0
	cAdamping    = 0.0
	cAwarmstart  = 0.0
	
	PuzzleText = ""
	
	''
	LinearStates.Clear()
	AngularStates.Clear()
	Roxels.Clear()
	Rigidbodys.Clear()
	Gravitys.Clear()
	FixedConstraints.Clear()
	LL_Constraints.Clear()
	angularconstraints.Clear()
	
	''
	CreatePlanet( Vec2( 200, 400 ), 0.0, 80, 160, 24 )
	CreatePlanet( Vec2( 400, 400 ), 0.0, 80, 160, 32 )
	CreatePlanet( Vec2( 600, 400 ), 0.0, 80, 160, 48 )
	CreatePlanet( Vec2( 800, 600 ), 0.0, 80, 160, 64 )
	
	'RigidBodys[0]->Roxels[0]->Linear.impulse = Vec2( 100.0,  0.0 )
	
	
	'RigidBodys[0]->Linear.impulse = Vec2( 0.0, -96.0 )
	'RigidBodys[1]->Linear.impulse = Vec2( 0.0,  48.0 )
	''
	RigidBodys[0]->Angular.impulse =  -8.0
	RigidBodys[1]->Angular.impulse =  8.0
	RigidBodys[2]->Angular.impulse =  -8.0
	RigidBodys[3]->Angular.impulse =  8.0
	'RigidBodys[1]->Angular.impulse = -0.1
	
	''
	'Dim as GravityType G
	'
	'G.particle_a = @RigidBodys[0]->Linear
	'G.particle_b = @RigidBodys[1]->Linear
	'
	'Gravitys.push_back( G )
	
	''
	'Dim As RoxelType P1
	'
	'P1.Linear.mass         = 1.0
	'P1.Linear.inverse_mass = 0'1.0 / P1.Linear.mass
	'P1.radius              = 10.0
	'P1.Linear.position.x   = 200
	'P1.Linear.position.y   = 400
	'
	'Dim As RoxelType Ptr PP1 = Roxels.push_back(P1)
	
	''
	Dim As LL_ConstraintType S
	
	S.particle_a = @RigidBodys[0]->Roxels[0]->Linear
	S.particle_b = @RigidBodys[1]->Linear
	
	S.rest_distance = (S.particle_b->position - S.particle_a->position).length()
	
	Dim As Single inverseMass = S.particle_a->inverse_mass + S.particle_b->inverse_mass
	
	S.reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
	
	LL_constraints.push_back( S )
	
	''
	S.particle_a = @RigidBodys[1]->Roxels[0]->Linear
	S.particle_b = @RigidBodys[2]->Linear
	
	S.rest_distance = (S.particle_b->position - S.particle_a->position).length()
	
	inverseMass = S.particle_a->inverse_mass + S.particle_b->inverse_mass
	
	S.reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
	
	LL_constraints.push_back( S )
	
	''
	S.particle_a = @RigidBodys[2]->Roxels[0]->Linear
	S.particle_b = @RigidBodys[3]->Linear
	
	S.rest_distance = (S.particle_b->position - S.particle_a->position).length()
	
	inverseMass = S.particle_a->inverse_mass + S.particle_b->inverse_mass
	
	S.reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
	
	LL_constraints.push_back( S )
	
	''
	S.particle_a = @RigidBodys[3]->Roxels[0]->Linear
	S.particle_b = @RigidBodys[0]->Linear
	
	S.rest_distance = (S.particle_b->position - S.particle_a->position).length()
	
	inverseMass = S.particle_a->inverse_mass + S.particle_b->inverse_mass
	
	S.reduced_mass = IIf( inverseMass = 0.0 , 0.0 , 1.0 / inverseMass )
	
	LL_constraints.push_back( S )
	
End Sub

Sub GameType.Puzzle7()
	
	'' Horizontal steel girder
	
	iterations   = 10
	warmstart    = 1
	
	cStiffness   = 0.5   
	cDamping     = 0.5
	cWarmstart   = 0.5
	
	cAstiffness  = 0.2
	cAdamping    = 0.5
	cAwarmstart  = 0.5
	
	PuzzleText = ""
	
	''
	LinearStates.Clear()
	AngularStates.Clear()
	Roxels.Clear()
	Rigidbodys.Clear()
	Gravitys.Clear()
	FixedConstraints.Clear()
	LL_Constraints.Clear()
	angularconstraints.Clear()
	
	Dim As RoxelType P1
	
	P1.Linear.mass         = 50.0
	P1.Linear.inverse_mass = 1.0 / P1.Linear.mass
	P1.radius              = 10.0
	P1.Linear.position.x   = 200
	P1.Linear.position.y   = 200
	
	Dim As RoxelType Ptr PP1 = Roxels.push_back(P1)
	
	Dim As RoxelType P2
	
	P2.Linear.mass         = 50.0
	P2.Linear.inverse_mass = 1.0 / P1.Linear.mass
	P2.radius              = 10.0
	P2.Linear.position.x   = 800
	P2.Linear.position.y   = 600
	
	Dim As RoxelType Ptr PP2 = Roxels.push_back(P2)
	
	CreateRope( @PP1->linear , @PP2->linear, 25 )
	
End Sub
