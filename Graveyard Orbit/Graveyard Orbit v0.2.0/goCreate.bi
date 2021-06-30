''******************************************************************************
''    
''  Graveyard Orbit - A 2D space physics puzzle game
''
''  Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''  Version 0.2.0, May 1. 2017
''  
''  Author:
''  Michael "h4tt3n" SchmTagt Nissen, michaelschmTagtnissen@gmail.com
''    
''  Description:
''  This file contains all create fuctions declared in goGame.bi
''
''******************************************************************************


''
#Ifndef __GO_CREATE_BI__
#Define __GO_CREATE_BI__


''
Function Game.CreateTree( ByVal _type As integer ) As ShapeBody Ptr
	
	''
	Dim As ShapeBody T = ShapeBody()
	
	Dim As ShapeBody Ptr TP = GameWorld.ShapeBodys_.push_back( T )
	
	TP->LinearStates_.Reserve( 128 )
	TP->FixedSprings_.Reserve( 128 )
	
	Return TP
	
End Function

Function Game.CreatePlanet() As Planet Ptr
	
	Dim As Planet P = Planet()
   
   Dim As Planet Ptr PP = Planets_.push_back( P )
   
   Return PP
	
End Function

Function Game.CreatePlanet( ByVal _mass    As Single, _
	                         ByVal _radius  As Single = 0.0, _
	                         ByVal _density As Single = 0.0 ) As Planet Ptr
	
	Dim As Planet P = Planet( _mass, _radius, _density )
   
   Dim As Planet Ptr PP = Planets_.push_back( P )
	
   Return PP
	
End Function

Function Game.CreateAsteroid( ByVal _mass   As Single, _
	                           ByVal _roxels As Integer, _
	                           ByVal _radius As Vec2 ) As RigidBody Ptr
	
	Randomize
	
	Dim As RigidBody R = RigidBody()
	
	Dim As RigidBody Ptr RP = GameWorld.RigidBodys_.push_back( R )
	
	If ( Not RP = 0 ) Then
		
		'RP->LinearStates_.Reserve( _roxels + 100 ) 
		RP->LinearStates_.Reserve( 4096 ) 
		
		For i As Integer = 0 To _Roxels - 1
			
			Dim As Single distribution = 1.0
			
			Dim As Single mass_min = ( _mass / _roxels ) * 0.1
			Dim As Single mass_max = ( _mass / _roxels ) * 1.0
			
			'Dim As Single mass = ( _mass / _roxels ) + ( ( Rnd() - Rnd() ) * ( 0.5 * ( _mass / _roxels ) ) ^ ( 1.0 / distribution ) ) ^ distribution
			Dim As Single mass = mass_min + ( mass_max - mass_min ) * Rnd()
			
			Dim as Single density = 500.0
			
			Dim as Single radius = Sqr( ( mass / density ) / PI )
			
			Dim As Integer scale = 16 + Cast( Integer, Rnd() * 32 )
			
			Dim As Roxel Ptr R = CreateRoxel( mass, radius, RGB( 0, 0, 0 ), RGB( 96 + scale, 48 + scale, 16 + scale ) )
			
			R->SetPosition( Vec2().RandomizeCircle( 1.0 ) * _radius )
			
			R->LowerFlag( IS_DYNAMIC )
			
			RP->InsertLinearState( R )
			
		Next
		
		'' correct mass
		RP->ComputeMass()
		
		Dim As Single mass_error = _mass / RP->GetMass()
		
		For I as LinearState Ptr Ptr = RP->LinearStates_.p_front To RP->LinearStates_.p_back	
			
			'Dim As LinearState Ptr P = *I
			 Dim As Roxel Ptr P = Cast( Roxel Ptr, *I )
			
			P->SetMass( P->GetMass() * mass_error )
			
			Dim as Single density = 500.0
			
			Dim as Single radius = Sqr( ( P->GetMass() / density ) / PI )
			
			P->SetRadius( radius )
			
		Next
		
		RP->ComputeMass()
		RP->ComputestateVectors()
		RP->ComputeInertia()
		
		RP->RaiseFlag( IS_ALIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
	EndIf
	
	Return RP
	
End Function

Function Game.CreateAsteroidBelt( ByVal _parent        As LinearState Ptr, _
	                               ByVal _num_asteroids As Integer, _
	                               ByVal _asteroid_mass As Vec2, _
	                               ByVal _eccentricity  As Vec2, _
	                               ByVal _semimajoraxis As Vec2, _
	                               ByVal _periapsis     As Vec2, _
	                               ByVal _direction     As Single ) As Body Ptr
	
	Randomize
	
	Dim As Vec2 parent_position = _Parent->GetPosition()
	Dim As Vec2 parent_velocity = _Parent->GetVelocity()
	
	Dim As Body S = Body()
	
	Dim As Body Ptr SP = GameWorld.Bodys_.push_back( S )
	
	SP->LinearStates_.Reserve( _num_asteroids + 1 ) 
	
	For i As Integer = 0 To _num_asteroids - 1
		
		Dim As Integer scale = ( i / _num_asteroids ) * 128
		
		Dim As Single mass = _asteroid_mass.x + Rnd() * ( _asteroid_mass.y - _asteroid_mass.x )
		
		Dim As Roxel Ptr R = CreateRoxel( mass, Sqr( ( mass / 10.0 ) / PI ), RGB( 0, 0, 0 ), RGB( 64 + scale, 48 + scale, 32 + scale ) )
		
		SP->LinearStates_.push_back( Cast( LinearState Ptr, R ) )  
		
	Next
	
	Dim As Single distribution = 1.0'2.2
	
	For i As Integer = 0 To _num_asteroids - 1
		
		Dim As LinearState Ptr LP = *SP->LinearStates_[i]
		
		Dim As KeplerOrbit K = KeplerOrbit( _Parent, LP )
		
		Dim As Single eccentricity     = _Eccentricity.x + Rnd() * ( _Eccentricity.y - _Eccentricity.x )
		'Dim As Single semimajor        = _SemiMajorAxis.x + Rnd() * ( _SemiMajorAxis.y - _SemiMajorAxis.x )
		
		Dim As Single semimajor_center = ( _SemiMajorAxis.y + _SemiMajorAxis.x ) * 0.5
		Dim As Single semimajor_half   = ( _SemiMajorAxis.y - _SemiMajorAxis.x ) * 0.5
		
		'Dim As Integer sign = IIf( Rnd() < 0.5 , -1 , 1 )
		Dim As Integer sign = Sgn( Rnd()-Rnd() )
		
		Dim As Single semimajor        = semimajor_center + sign * ( Rnd() * semimajor_half ^ ( 1.0 / distribution ) ) ^ distribution
		'Dim As Single semimajor        = semimajor_center + Sgn( Rnd()-Rnd() ) * ( Rnd() * semimajor_half ^ ( 1.0 / distribution ) ) ^ distribution
		                '.Orbit_Radius = Planet(0).Radius + 2500 + ( Rnd * ( 500 ^(1/3) ) )^3
		Dim As Single periapsis        = _Periapsis.x + Rnd() * ( _Periapsis.y - _Periapsis.x )
		Dim As Single eccentricanomaly = Rnd() * TWO_PI
		
		'_Parent->SetPosition( parent_position )
		'_Parent->SetVelocity( parent_velocity )
		
		K.ApplyOrbit( parent_position, eccentricity, semimajor, periapsis, eccentricanomaly, _direction )
		
		'LP->AddVelocity( parent_velocity )
		
		''
		Dim As NewtonGravity Ptr N = GameWorld.CreateNewtonGravity( _Parent, LP )
		
		N->LowerFlag( IS_VISIBLE )
		
	Next
	
	'_Parent->SetPosition( parent_position )
	'_Parent->SetVelocity( parent_velocity )
	
	SP->LinearStates_.push_back( _Parent ) 
	
	SP->ComputeMass()
	SP->ComputestateVectors()
	SP->ComputeInertia()
	SP->ComputeAngularVelocity()
	
	Return SP
	
End Function

''
Function Game.CreateThruster( ByVal _mass             As Single, _
	                           ByVal _position         As Vec2, _
	                           ByVal _exhaust_velocity As Single, _
	                           ByVal _fuel_flow_rate   As Single ) As Thruster Ptr
	
	Dim As Thruster T = Thruster( _mass, _position, _exhaust_velocity, _fuel_flow_rate )
	
	Dim As Thruster Ptr TP = Thrusters_.push_back( T )
	
	Return TP
	
End Function

'' 
Function Game.CreateRocket() As Rocket Ptr
	
	Dim As Rocket R = Rocket()
   
   Dim As Rocket Ptr RP = Rockets_.push_back( R )
   
   Return RP
   
End Function

Function Game.CreateRocket( ByVal _dry_mass         As Single, _
	                         ByVal _exhaust_velocity As Single, _
	                         ByVal _fuel_flow_rate   As Single, _
	                         ByVal _position         As Vec2 ) As Rocket Ptr
	
	Dim As Rocket R = Rocket( _dry_mass, _exhaust_velocity, _fuel_flow_rate, _position )
   
   Dim As Rocket Ptr RP = Rockets_.push_back( R )
   
   Return RP
	
End Function


''
Function Game.CreateRoxel() As Roxel Ptr
	
	Dim As Roxel R = Roxel()
   
   Dim As Roxel Ptr RP = Roxels_.push_back( R )
   
   Return RP
	
End Function

Function Game.CreateRoxel( ByVal _mass              As Single, _
	                        ByVal _radius            As Single, _
	                        ByVal _background_colour As UInteger, _
	                        ByVal _foreground_colour As UInteger ) As Roxel Ptr
	
	Dim As Roxel R = Roxel( _mass, _radius, _background_colour, _foreground_colour )
   
   Dim As Roxel Ptr RP = Roxels_.push_back( R )
   
   RP->RaiseFlag( IS_ALIVE Or IS_DYNAMIC Or IS_VISIBLE )
   
   Return RP
	
End Function

Function Game.CreateGirder( ByVal _points As Vec2, _
	                         ByVal _length As Vec2, _
	                         ByVal _type   As integer ) As SoftBody Ptr
	
	''
	Dim As Single stiffness = 1.0
	Dim As Single damping   = 1.0
	Dim As Single warmstart = 1.0
	
	Dim As LinearState Ptr  LS = 0
	Dim As LinearSpring Ptr LP = 0
	
	Dim As Integer num_linearstates = _points.x * _points.y 
	
	Dim As Integer num_linearsprings = _
		( _points.x - 1 ) * _points.y + _                                             '' longitudinal springs
		_points.x * ( _points.y - 1 ) + _                                             '' transverse springs
		IIf( _type = S_TRUSS, ( _points.x - 1 ) * ( _points.y - 1 ), 0 ) + _          '' S_Truss
		IIf( _type = Z_TRUSS, ( _points.x - 1 ) * ( _points.y - 1 ), 0 ) + _          '' Z_Truss
		IIf( _type = V_TRUSS, ( _points.x - 1 ) * ( _points.y - 1 ), 0 ) + _          '' V_Truss
		IIf( _type = X_TRUSS, ( _points.x - 1 ) * ( _points.y - 1 ) * 2, 0 ) + _      '' X_Truss
		IIf( _type = K_TRUSS, ( _points.x - 1 ) * ( _points.y - 1 ) * 2, 0 ) + _      '' K_Truss
		IIf( _type = O_TRUSS, ( _points.x - 1 ) * ( _points.y - 1 ) * 2 + 4, 0  ) + _ '' O_Truss
		IIf( _type = W_TRUSS, 0 , 0 ) + 100                                           '' W_Truss
	
	''
	Dim As SoftBody S = SoftBody()
	
	Dim As SoftBody Ptr SP = GameWorld.SoftBodys_.push_back( S )
	
	SP->LinearStates_.Reserve( num_linearstates )
	SP->LinearSprings_.Reserve( num_linearsprings )
	
	
	''	LinearStates
	for y as integer = 0 to _points.y - 1
		for x as integer = 0 to _points.x - 1
			
			LS = GameWorld.CreateLinearState( 100.0, Vec2( x * _length.x, y * _length.y ) )
			 
		  	SP->LinearStates_.push_back( LS )
		  	
		Next
	Next
	
	''  Longitudinal springs, "===="
	For y as integer = 0 to _points.y - 1
		For x as integer = 0 to _points.x - 2
			
			LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
														  *SP->LinearStates_[ x + y * _points.x ], _
														  *SP->LinearStates_[ x + y * _points.x + 1 ] )
			
			SP->LinearSprings_.push_back( LP )
			
		Next
	Next
	
	''  Transverse springs, "||||"
	for y as integer = 0 to _points.y - 2
		For x as integer = 0 to _points.x - 1
			
			LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
														  *SP->LinearStates_[ x + y * _points.x  ], _
														  *SP->LinearStates_[ x + ( y + 1 ) * _points.x ] )
			
			SP->LinearSprings_.push_back( LP )
			
		Next
	Next
	
	''  diagonal springs, S-Truss
	If ( _type = S_TRUSS Or _type = X_TRUSS Or _type = W_TRUSS ) Then
		
		for y as integer = 0 to _points.y - 2
			For x as integer = 0 to _points.x - 2
				
			LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
														  *SP->LinearStates_[ x + 1 + y * _points.x  ], _
														  *SP->LinearStates_[ x + ( y + 1 ) *_points.x  ] )
			
			SP->LinearSprings_.push_back( LP )
				
			Next
		Next
	
	EndIf
	
	''  diagonal springs, Z-Truss
	If ( _type = Z_TRUSS Or _type = X_TRUSS Or _type = W_TRUSS ) Then
		
		for y as integer = 0 to _points.y - 2
			For x as integer = 0 to _points.x - 2
				
			LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
														  *SP->LinearStates_[ x + y * _points.x ], _
														  *SP->LinearStates_[ x + 1 + ( y + 1 ) * _points.x ] )
			
			SP->LinearSprings_.push_back( LP )
				
			Next
		Next
	
	EndIf
	
	''  V-Truss
	If ( _type = V_TRUSS ) Then
		
		For y as integer = 0 to _points.y - 2
			For x as integer = 0 to _points.x - 2 Step 2
				
			LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
														  *SP->LinearStates_[ x + 1 + y * _points.x  ], _
														  *SP->LinearStates_[ x + ( y + 1 ) *_points.x  ] )
			
			SP->LinearSprings_.push_back( LP )
				
			Next
		Next
		
		For y as integer = 0 to _points.y - 2
			For x as integer = 1 to _points.x - 2 Step 2
				
			LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
														  *SP->LinearStates_[ x + y * _points.x ], _
														  *SP->LinearStates_[ x + 1 + ( y + 1 ) * _points.x ] )
			
			SP->LinearSprings_.push_back( LP )
				
			Next
		Next
	
	EndIf
	
	'' K-Truss 
	If ( _type = K_TRUSS ) Then
		
		for y as integer = 0 to _points.y - 2
			For x as integer = 0 to _points.x - 2
				
				LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
															  *SP->LinearStates_[ x + 1 + y * _points.x ], _
															  *SP->LinearSprings_[ x + y * _points.x + _points.y * ( _points.x - 1 ) ] )
			
				SP->LinearSprings_.push_back( LP )
				
				LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
															  *SP->LinearStates_[ x + 1 + ( y + 1 ) * _points.x ], _
															  *SP->LinearSprings_[ x + y * _points.x + _points.y * ( _points.x - 1 ) ] )
			
				SP->LinearSprings_.push_back( LP )
				
			Next
		Next
		
	EndIf
	
	'' O-Truss 
	If ( _type = O_TRUSS Or _type = W_TRUSS ) Then
		
		''
		For y as integer = 0 to _points.y - 2
			For x as integer = 0 to _points.x - 3
			
			'If ( x = 0 ) Then
			'	
			'	'' Endpoint springs
			'	LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
			'												  *SP->LinearSprings_[ ( _points.x - 1 ) + y * ( _points.x - 1 )], _
			'												  *SP->LinearSprings_[ y * _points.x + _points.y * ( _points.x - 1 ) ] )
			'
			'	SP->LinearSprings_.push_back( LP )
			'	
			'	'LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
			'	'											  *SP->LinearSprings_[ ( _points.x - 1 ) + y * ( _points.x - 1 ) * 2 ], _
			'	'											  *SP->LinearSprings_[ y * _points.x + _points.y * ( _points.x - 1 ) ] )
			'
			'	'SP->LinearSprings_.push_back( LP )
			'	
			'EndIf
			
			LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
														  *SP->LinearSprings_[ x + y * ( _points.x - 1 ) ], _
														  *SP->LinearSprings_[ x + 1 + ( y + 1 ) * ( _points.x - 1 ) ] )
			
			SP->LinearSprings_.push_back( LP )
			
			LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
														  *SP->LinearSprings_[ x + 1 + y * ( _points.x - 1 ) ], _
														  *SP->LinearSprings_[ x + ( y + 1 ) * ( _points.x - 1 ) ] )
			
			SP->LinearSprings_.push_back( LP )
				
			Next
		Next
		
		''' Endpoint springs
		'LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
		'											  *SP->LinearSprings_[ ( _points.x - 1 ) - 1 ], _
		'											  *SP->LinearSprings_[ ( _points.x - 1 ) * 3 ] )
		'	
		'SP->LinearSprings_.push_back( LP )
		'
		'LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
		'											  *SP->LinearSprings_[ ( _points.x - 1 ) * 2 - 1 ], _
		'											  *SP->LinearSprings_[ ( _points.x - 1 ) * 3 ] )
		'	
		'SP->LinearSprings_.push_back( LP )
	
	EndIf
	
	''
	SP->ComputeMass()
	SP->ComputestateVectors()
	SP->ComputeInertia()
	
	SP->RaiseFlag( IS_ALIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
	Return SP
	
End Function

Function Game.CreateArchedGirder( ByVal _points  As Vec2, _
	                               ByVal _Length  As Vec2, _
	                               ByVal _Radians As Single, _
	                               ByVal _Radius  As Single, _
	                               ByVal _type    As integer ) As SoftBody Ptr
	
	'' This function creates arched, curved girders for more interesting architecture, 
	'' and for girders that follow the curvature of orbits etc. 
	
	Dim As Single stiffness = 1.0
	Dim As Single damping   = 1.0
	Dim As Single warmstart = 1.0
	
	Dim As LinearState Ptr LS = 0
	Dim As LinearSpring Ptr LP = 0
	
	Dim As Integer num_linearstates = _points.x * _points.y
	
	Dim As Integer num_linearsprings = _
		( _points.x - 1 ) * _points.y + _                                             '' longitudinal springs
		_points.x * ( _points.y - 1 ) + _                                             '' transverse springs
		IIf( _type = S_TRUSS, ( _points.x - 1 ) * ( _points.y - 1 ), 0 ) + _          '' S_Truss
		IIf( _type = Z_TRUSS, ( _points.x - 1 ) * ( _points.y - 1 ), 0 ) + _          '' Z_Truss
		IIf( _type = V_TRUSS, ( _points.x - 1 ) * ( _points.y - 1 ), 0 ) + _          '' V_Truss
		IIf( _type = X_TRUSS, ( _points.x - 1 ) * ( _points.y - 1 ) * 2, 0 ) + _      '' X_Truss
		IIf( _type = K_TRUSS, ( _points.x - 1 ) * ( _points.y - 1 ) * 2, 0 ) + _      '' K_Truss
		IIf( _type = O_TRUSS, ( _points.x - 1 ) * ( _points.y - 1 ) * 2 + 4, 0  ) + _ '' O_Truss
		IIf( _type = W_TRUSS, 0 , 0 )                                                 '' W_Truss
	
	''
	Dim As SoftBody S = SoftBody()
	
	Dim As SoftBody Ptr SP = GameWorld.SoftBodys_.push_back( S )
	
	SP->LinearStates_.Reserve( num_linearstates )
	SP->LinearSprings_.Reserve( num_linearsprings ) 
	
	''	LinearStates
	for y as integer = 0 to _points.y - 1
		for x as integer = 0 to _points.x - 1
			
			LS = GameWorld.CreateLinearState( 64.0, Vec2( ( _Radius + y * _Length.y ) * Cos( _Radians * ( x / ( _points.x - 1 ) ) ), _
			                                             ( _Radius + y * _Length.y ) * Sin( _Radians * ( x / ( _points.x - 1 ) ) ) )  )
			 
		  	SP->LinearStates_.push_back( LS )
		  	
		Next
	Next
	
	''  Longitudinal springs, "===="
	For y as integer = 0 to _points.y - 1
		For x as integer = 0 to _points.x - 2
			
			LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
														  *SP->LinearStates_[ x + y * _points.x ], _
														  *SP->LinearStates_[ x + y * _points.x + 1 ] )
			
			SP->LinearSprings_.push_back( LP )
			
		Next
	Next
	
	''  Transverse springs, "||||"
	for y as integer = 0 to _points.y - 2
		For x as integer = 0 to _points.x - 1
			
			LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
														  *SP->LinearStates_[ x + y * _points.x  ], _
														  *SP->LinearStates_[ x + ( y + 1 ) * _points.x ] )
			
			SP->LinearSprings_.push_back( LP )
			
		Next
	Next
	
	''  diagonal springs, S-Truss
	If ( _type = S_TRUSS Or _type = X_TRUSS Or _type = W_TRUSS ) Then
		
		for y as integer = 0 to _points.y - 2
			For x as integer = 0 to _points.x - 2
				
			LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
														  *SP->LinearStates_[ x + 1 + y * _points.x  ], _
														  *SP->LinearStates_[ x + ( y + 1 ) *_points.x  ] )
			
			SP->LinearSprings_.push_back( LP )
				
			Next
		Next
	
	EndIf
	
	''  diagonal springs, Z-Truss
	If ( _type = Z_TRUSS Or _type = X_TRUSS Or _type = W_TRUSS ) Then
		
		for y as integer = 0 to _points.y - 2
			For x as integer = 0 to _points.x - 2
				
			LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
														  *SP->LinearStates_[ x + y * _points.x ], _
														  *SP->LinearStates_[ x + 1 + ( y + 1 ) * _points.x ] )
			
			SP->LinearSprings_.push_back( LP )
				
			Next
		Next
	
	EndIf
	
	''  V-Truss
	If ( _type = V_TRUSS ) Then
		
		For y as integer = 0 to _points.y - 2
			For x as integer = 0 to _points.x - 2 Step 2
				
			LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
														  *SP->LinearStates_[ x + 1 + y * _points.x  ], _
														  *SP->LinearStates_[ x + ( y + 1 ) *_points.x  ] )
			
			SP->LinearSprings_.push_back( LP )
				
			Next
		Next
		
		For y as integer = 0 to _points.y - 2
			For x as integer = 1 to _points.x - 2 Step 2
				
			LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
														  *SP->LinearStates_[ x + y * _points.x ], _
														  *SP->LinearStates_[ x + 1 + ( y + 1 ) * _points.x ] )
			
			SP->LinearSprings_.push_back( LP )
				
			Next
		Next
	
	EndIf
	
	'' K-Truss 
	If ( _type = K_TRUSS ) Then
		
		for y as integer = 0 to _points.y - 2
			For x as integer = 0 to _points.x - 2
				
				LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
															  *SP->LinearStates_[ x + 1 + y * _points.x ], _
															  *SP->LinearSprings_[ x + y * _points.x + _points.y * ( _points.x - 1 ) ] )
			
				SP->LinearSprings_.push_back( LP )
				
				LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
															  *SP->LinearStates_[ x + 1 + ( y + 1 ) * _points.x ], _
															  *SP->LinearSprings_[ x + y * _points.x + _points.y * ( _points.x - 1 ) ] )
			
				SP->LinearSprings_.push_back( LP )
				
			Next
		Next
		
	EndIf
	
	'' O-Truss 
	If ( _type = O_TRUSS Or _type = W_TRUSS ) Then
		
		'' Endpoint springs
		'LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
		'											  *SP->LinearSprings_[ 0 ], _
		'											  *SP->LinearSprings_[ ( _points.x - 1 ) * 2  ] )
		'	
		'SP->LinearSprings_.push_back( LP )
		'
		'LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
		'											  *SP->LinearSprings_[ _points.x - 1 ], _
		'											  *SP->LinearSprings_[ ( _points.x - 1 ) * 2  ] )
		'	
		'SP->LinearSprings_.push_back( LP )
		
		''
		For y as integer = 0 to _points.y - 2
			For x as integer = 0 to _points.x - 3
				 
			LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
														  *SP->LinearSprings_[ x + y * ( _points.x - 1 ) ], _
														  *SP->LinearSprings_[ x + 1 + ( y + 1 ) * ( _points.x - 1 ) ] )
			
			SP->LinearSprings_.push_back( LP )
			
			LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
														  *SP->LinearSprings_[ x + 1 + y * ( _points.x - 1 ) ], _
														  *SP->LinearSprings_[ x + ( y + 1 ) * ( _points.x - 1 ) ] )
			
			SP->LinearSprings_.push_back( LP )
				
			Next
		Next
		
		'' Endpoint springs
		'LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
		'											  *SP->LinearSprings_[ ( _points.x - 1 ) - 1 ], _
		'											  *SP->LinearSprings_[ ( _points.x - 1 ) * 3 ] )
		'	
		'SP->LinearSprings_.push_back( LP )
		'
		'LP = GameWorld.CreateLinearSpring( stiffness, damping, warmstart, _
		'											  *SP->LinearSprings_[ ( _points.x - 1 ) * 2 - 1 ], _
		'											  *SP->LinearSprings_[ ( _points.x - 1 ) * 3 ] )
		'	
		'SP->LinearSprings_.push_back( LP )
	
	EndIf
	
	''
	SP->ComputeMass()
	SP->ComputestateVectors()
	SP->ComputeInertia()
	SP->ComputeAngularVelocity()
	SP->ComputeAngle()
	SP->ComputeAngleVector()
	
	SP->RaiseFlag( IS_ALIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
	Return SP
	
End Function

Function Game.CreateStrongGirder( ByVal _points As Vec2, _
	                               ByVal _Length As Vec2, _
	                               ByVal _type   As integer ) As SoftBody Ptr
	
	'' This girder contains about 25-33% fewer springs, which makes it less
	'' cpu-demanding than the regular CreateGirder. The springs are shifted
	'' in a way that makes the structure stronger.
	'' The drawback is that you have less girder types to choose from.
	
	Dim As LinearState Ptr LS = 0
	Dim As LinearSpring Ptr LP = 0
	
	Dim As Integer num_linearstates = _points.x * 0.5 * _points.y + _points.y
	Dim As Integer num_linearsprings = 512
	
	
	
	''
	Dim As SoftBody S = SoftBody()
	
	Dim As SoftBody Ptr SP = GameWorld.SoftBodys_.push_back( S )
	
	SP->LinearStates_.Reserve( num_linearstates )
	SP->LinearSprings_.Reserve( num_linearsprings )
	
	''	LinearStates - Works!
	for y as integer = 0 to _points.y - 1
		for x as integer = 0 to ( _points.x * 0.5 ) - 1
			
			Dim As Integer IS_EVEN = IIf( ( y Mod 2 ) = 0 , TRUE , FALSE )
			
			'' Endpoint
			If ( ( IS_EVEN = FALSE ) And ( x = 0 ) ) Then
				
				LS = GameWorld.CreateLinearState( 1.0, Vec2( 0 , y * _length.y )  )
			 
		  		SP->LinearStates_.push_back( LS )
				
			EndIf
			
			Dim As Single pos_x = IIf( IS_EVEN = TRUE , x * _length.x * 2 , _length.x + x * _length.x * 2 )
			
			Dim As Single pos_y = y * _length.y
			
			LS = GameWorld.CreateLinearState( 1.0, Vec2( pos_x , pos_y )  )
			 
		  	SP->LinearStates_.push_back( LS )
		  	
		  	'' Endpoint
			If ( ( IS_EVEN = TRUE ) And ( x = ( _points.x * 0.5 ) - 1 ) ) Then
				
				LS = GameWorld.CreateLinearState( 1.0, Vec2( x * _length.x * 2 + _length.x , y * _length.y )  )
			 
		  		SP->LinearStates_.push_back( LS )
				
			EndIf
		  	
		Next
	Next
	
	''  Longitudinal springs, "====" Works!
	For y as integer = 0 to _points.y - 1
		For x as integer = 0 to ( _points.x * 0.5 ) - 1
			
			LP = GameWorld.CreateLinearSpring( 1.0, 1.0, 1.0, _
														  *SP->LinearStates_[ x + y * ( _points.x * 0.5 ) + y  ], _
														  *SP->LinearStates_[ x + y * ( _points.x * 0.5 ) + y + 1  ] )
			
			SP->LinearSprings_.push_back( LP )
			
		Next
	Next
	
	''  Transverse springs, "||||"
	LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
												  *SP->LinearStates_[ ( _points.x * 0.5 ) + 1 ], _
												  *SP->LinearStates_[ 0 ] )
			
	SP->LinearSprings_.push_back( LP )
	
	For y as integer = 0 to _points.y - 2 Step 2
		For x as integer = 0 to ( _points.x * 0.5 ) - 2
			
			LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
														  *SP->LinearStates_[ x + ( _points.x * 0.5 ) + 2 + y * ( _points.x * 0.5 ) + y ], _
														  *SP->LinearSprings_[ x + y * ( _points.x * 0.5 )  ] )
			
			SP->LinearSprings_.push_back( LP )
			
			LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
														  *SP->LinearStates_[ x + 1 + y * ( _points.x * 0.5 ) + y ], _
														  *SP->LinearSprings_[ x + ( _points.x * 0.5 ) + 1 + y * ( _points.x * 0.5 ) ] )
			
			SP->LinearSprings_.push_back( LP )
		
		Next
	Next
	
	LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
												  *SP->LinearStates_[ ( _points.x * 0.5 ) ], _
												  *SP->LinearStates_[ _points.x + 1 ] )
			
	SP->LinearSprings_.push_back( LP )
	
	For y as integer = 1 to _points.y - 2 Step 2
		For x as integer = 0 to ( _points.x * 0.5 ) - 2
			
			LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
														  *SP->LinearStates_[ x + ( _points.x * 0.5 ) + 2 + y * ( _points.x * 0.5 ) + y  ], _
														  *SP->LinearSprings_[ x + y * ( _points.x * 0.5 ) + 1 ] )
			
			SP->LinearSprings_.push_back( LP )
			
			LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
														  *SP->LinearStates_[ x + 1 + y * ( _points.x * 0.5 ) + y ], _
														  *SP->LinearSprings_[ x + ( _points.x * 0.5 ) + 1 + y * ( _points.x * 0.5 ) - 1 ] )
			
			SP->LinearSprings_.push_back( LP )
		
		Next
	Next
	
	
	''  diagonal springs, S-Truss
	If ( _type = S_TRUSS Or _type = X_TRUSS ) Then
		
		For y as integer = 0 to _points.y - 2
			For x as integer = 0 to ( _points.x * 0.5 ) - 2
				
				LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
															  *SP->LinearStates_[ x + ( _points.x * 0.5 ) + 2  + y * ( _points.x * 0.5 ) + y], _
															  *SP->LinearStates_[ x + 1  + y * ( _points.x * 0.5 ) + y] )
				
				SP->LinearSprings_.push_back( LP )
				
				'LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
				'											  *SP->LinearSprings_[ x + ( _points.x * 0.5 )  ], _
				'											  *SP->LinearSprings_[ x  ] )
				'
				'SP->LinearSprings_.push_back( LP )
			
			Next
		Next
	
	EndIf
	
	
	''  diagonal springs, Z-Truss
	If ( _type = Z_TRUSS Or _type = X_TRUSS ) Then	
	
		For y as integer = 0 to _points.y - 2
			For x as integer = 0 to ( _points.x * 0.5 ) - 2
				
				LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
															  *SP->LinearStates_[ x + ( _points.x * 0.5 ) + 2 ], _
															  *SP->LinearStates_[ x  ] )
				
				SP->LinearSprings_.push_back( LP )
				
				LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
															  *SP->LinearSprings_[ x + ( _points.x * 0.5 ) + 1 ], _
															  *SP->LinearSprings_[ x  ] )
				
				SP->LinearSprings_.push_back( LP )
			
			Next
		Next
	
	EndIf
	
	''
	''
	SP->ComputeMass()
	SP->ComputestateVectors()
	SP->ComputeInertia()
	'SP->ComputeAngularVelocity()
	'SP->ComputeAngle()
	'SP->ComputeAngleVector()
	
	SP->RaiseFlag( IS_ALIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
	Return SP
	
End Function

Function Game.CreateShapeGirder( ByVal _points As Vec2, _
	                              ByVal _Length As Vec2, _
	                              ByVal _type   As integer ) As ShapeBody Ptr
	   
	''
	Dim As Single stiffness = 1.0
	Dim As Single damping   = 1.0
	Dim As Single warmstart = 1.0
	
	Dim As LinearState Ptr LS = 0
	Dim As FixedSpring Ptr FP = 0
	
	Dim As Integer num_linearstates = _points.x * _points.y 
	
	Dim As Integer num_fixedsprings = _
		( _points.x - 1 ) * _points.y + _                                             '' longitudinal springs
		_points.x * ( _points.y - 1 ) + _                                             '' transverse springs
		IIf( _type = S_TRUSS, ( _points.x - 1 ) * ( _points.y - 1 ), 0 ) + _          '' S_Truss
		IIf( _type = Z_TRUSS, ( _points.x - 1 ) * ( _points.y - 1 ), 0 ) + _          '' Z_Truss
		IIf( _type = V_TRUSS, ( _points.x - 1 ) * ( _points.y - 1 ), 0 ) + _          '' V_Truss
		IIf( _type = X_TRUSS, ( _points.x - 1 ) * ( _points.y - 1 ) * 2, 0 ) + _      '' X_Truss
		IIf( _type = K_TRUSS, ( _points.x - 1 ) * ( _points.y - 1 ) * 2, 0 ) + _      '' K_Truss
		IIf( _type = O_TRUSS, ( _points.x - 1 ) * ( _points.y - 1 ) * 2 + 4, 0  ) + _ '' O_Truss
		IIf( _type = W_TRUSS, 0 , 0 ) + 100                                           '' W_Truss
	
	''
	Dim As ShapeBody S = ShapeBody()
	
	Dim As ShapeBody Ptr SP = GameWorld.ShapeBodys_.push_back( S )
	
	SP->LinearStates_.Reserve( num_linearstates )
	SP->FixedSprings_.Reserve( num_fixedsprings )
	
	''	LinearStates
	for y as integer = 0 to _points.y - 1
		for x as integer = 0 to _points.x - 1
			
			LS = GameWorld.CreateLinearState( 100.0, Vec2( x * _length.x, y * _length.y ) )
			 
		  	SP->LinearStates_.push_back( LS )
		  	
		Next
	Next
	
	''  Longitudinal springs
	For y as integer = 0 to _points.y - 1
		For x as integer = 0 to _points.x - 2
			
			FP = GameWorld.CreateFixedSpring( stiffness, damping, warmstart, _
														 *SP->LinearStates_[ x + y * _points.x ], _
														 *SP->LinearStates_[ x + y * _points.x + 1 ] )
			
			SP->FixedSprings_.push_back( FP )
			
		Next
	Next
	
	''  Transverse springs
	for y as integer = 0 to _points.y - 2
		For x as integer = 0 to _points.x - 1
			
			FP = GameWorld.CreateFixedSpring( stiffness, damping, warmstart, _
														 *SP->LinearStates_[ x + y * _points.x  ], _
														 *SP->LinearStates_[ x + ( y + 1 ) * _points.x ] )
			
			SP->FixedSprings_.push_back( FP )
			
		Next
	Next
	
	''  diagonal springs, S-Truss
	If ( _type = S_TRUSS Or _type = X_TRUSS Or _type = W_TRUSS ) Then
		
		for y as integer = 0 to _points.y - 2
			For x as integer = 0 to _points.x - 2
				
			FP = GameWorld.CreateFixedSpring( stiffness, damping, warmstart, _
														  *SP->LinearStates_[ x + 1 + y * _points.x  ], _
														  *SP->LinearStates_[ x + ( y + 1 ) *_points.x  ] )
			
			SP->FixedSprings_.push_back( FP )
				
			Next
		Next
	
	EndIf
	
	''  diagonal springs, Z-Truss
	If ( _type = Z_TRUSS Or _type = X_TRUSS Or _type = W_TRUSS ) Then
		
		for y as integer = 0 to _points.y - 2
			For x as integer = 0 to _points.x - 2
				
			FP = GameWorld.CreateFixedSpring( stiffness, damping, warmstart, _
														  *SP->LinearStates_[ x + y * _points.x ], _
														  *SP->LinearStates_[ x + 1 + ( y + 1 ) * _points.x ] )
			
			SP->FixedSprings_.push_back( FP )
				
			Next
		Next
	
	EndIf
	
	''  V-Truss
	If ( _type = V_TRUSS ) Then
		
		For y as integer = 0 to _points.y - 2
			For x as integer = 0 to _points.x - 2 Step 2
				
			FP = GameWorld.CreateFixedSpring( stiffness, damping, warmstart, _
														  *SP->LinearStates_[ x + 1 + y * _points.x  ], _
														  *SP->LinearStates_[ x + ( y + 1 ) *_points.x  ] )
			
			SP->FixedSprings_.push_back( FP )
				
			Next
		Next
		
		For y as integer = 0 to _points.y - 2
			For x as integer = 1 to _points.x - 2 Step 2
				
			FP = GameWorld.CreateFixedSpring( stiffness, damping, warmstart, _
														  *SP->LinearStates_[ x + y * _points.x ], _
														  *SP->LinearStates_[ x + 1 + ( y + 1 ) * _points.x ] )
			
			SP->FixedSprings_.push_back( FP )
				
			Next
		Next
	
	EndIf
	
	'' K-Truss 
	If ( _type = K_TRUSS ) Then
		
		for y as integer = 0 to _points.y - 2
			For x as integer = 0 to _points.x - 2
				
				FP = GameWorld.CreateFixedSpring( stiffness, damping, warmstart, _
															  *SP->LinearStates_[ x + 1 + y * _points.x ], _
															  *SP->FixedSprings_[ x + y * _points.x + _points.y * ( _points.x - 1 ) ] )
			
				SP->FixedSprings_.push_back( FP )
				
				FP = GameWorld.CreateFixedSpring( stiffness, damping, warmstart, _
															  *SP->LinearStates_[ x + 1 + ( y + 1 ) * _points.x ], _
															  *SP->FixedSprings_[ x + y * _points.x + _points.y * ( _points.x - 1 ) ] )
			
				SP->FixedSprings_.push_back( FP )
				
			Next
		Next
		
	EndIf
	
	''
	SP->ComputeMass()
	SP->ComputestateVectors()
	SP->ComputeInertia()
	SP->ComputeAngularVelocity()
	SP->ComputeAngle()
	SP->ComputeAngleVector()
	
	SP->RaiseFlag( IS_ALIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
	Return SP
	
End Function

Function Game.CreateArchedShapeGirder( ByVal _points  As Vec2, _
	                                    ByVal _Length  As Vec2, _
	                                    ByVal _Radians As Single, _
	                                    ByVal _Radius  As Single, _
	                                    ByVal _type    As integer ) As ShapeBody Ptr
	
	'' This function creates arched, curved girders for more interesting architecture, 
	'' and for girders that follow the curvature of orbits etc. 
	
	Dim As Single stiffness = 1.0
	Dim As Single damping   = 1.0
	Dim As Single warmstart = 1.0
	
	Dim As LinearState Ptr LS = 0
	Dim As FixedSpring Ptr LP = 0
	
	Dim As Integer num_linearstates = _points.x * _points.y
	
	Dim As Integer num_fixedsprings = _
		( _points.x - 1 ) * _points.y + _                                             '' longitudinal springs
		_points.x * ( _points.y - 1 ) + _                                             '' transverse springs
		IIf( _type = S_TRUSS, ( _points.x - 1 ) * ( _points.y - 1 ), 0 ) + _          '' S_Truss
		IIf( _type = Z_TRUSS, ( _points.x - 1 ) * ( _points.y - 1 ), 0 ) + _          '' Z_Truss
		IIf( _type = V_TRUSS, ( _points.x - 1 ) * ( _points.y - 1 ), 0 ) + _          '' V_Truss
		IIf( _type = X_TRUSS, ( _points.x - 1 ) * ( _points.y - 1 ) * 2, 0 ) + _      '' X_Truss
		IIf( _type = K_TRUSS, ( _points.x - 1 ) * ( _points.y - 1 ) * 2, 0 ) + _      '' K_Truss
		IIf( _type = O_TRUSS, ( _points.x - 1 ) * ( _points.y - 1 ) * 2 + 4, 0  ) + _ '' O_Truss
		IIf( _type = W_TRUSS, 0 , 0 )                                                 '' W_Truss
	
	''
	Dim As ShapeBody S = ShapeBody()
	
	Dim As ShapeBody Ptr SP = GameWorld.ShapeBodys_.push_back( S )
	
	SP->LinearStates_.Reserve( num_linearstates )
	SP->FixedSprings_.Reserve( num_fixedsprings ) 
	
	''	LinearStates
	for y as integer = 0 to _points.y - 1
		for x as integer = 0 to _points.x - 1
			
			LS = GameWorld.CreateLinearState( 64.0, Vec2( ( _Radius + y * _Length.y ) * Cos( _Radians * ( x / ( _points.x - 1 ) ) ), _
			                                               ( _Radius + y * _Length.y ) * Sin( _Radians * ( x / ( _points.x - 1 ) ) ) )  )
			 
		  	SP->LinearStates_.push_back( LS )
		  	
		Next
	Next
	
	''  Longitudinal springs, "===="
	For y as integer = 0 to _points.y - 1
		For x as integer = 0 to _points.x - 2
			
			LP = GameWorld.CreateFixedSpring( stiffness, damping, warmstart, _
														  *SP->LinearStates_[ x + y * _points.x ], _
														  *SP->LinearStates_[ x + y * _points.x + 1 ] )
			
			SP->FixedSprings_.push_back( LP )
			
		Next
	Next
	
	''  Transverse springs, "||||"
	for y as integer = 0 to _points.y - 2
		For x as integer = 0 to _points.x - 1
			
			LP = GameWorld.CreateFixedSpring( stiffness, damping, warmstart, _
														  *SP->LinearStates_[ x + y * _points.x  ], _
														  *SP->LinearStates_[ x + ( y + 1 ) * _points.x ] )
			
			SP->FixedSprings_.push_back( LP )
			
		Next
	Next
	
	''  diagonal springs, S-Truss
	If ( _type = S_TRUSS Or _type = X_TRUSS Or _type = W_TRUSS ) Then
		
		for y as integer = 0 to _points.y - 2
			For x as integer = 0 to _points.x - 2
				
			LP = GameWorld.CreateFixedSpring( stiffness, damping, warmstart, _
														  *SP->LinearStates_[ x + 1 + y * _points.x  ], _
														  *SP->LinearStates_[ x + ( y + 1 ) *_points.x  ] )
			
			SP->FixedSprings_.push_back( LP )
				
			Next
		Next
	
	EndIf
	
	''  diagonal springs, Z-Truss
	If ( _type = Z_TRUSS Or _type = X_TRUSS Or _type = W_TRUSS ) Then
		
		for y as integer = 0 to _points.y - 2
			For x as integer = 0 to _points.x - 2
				
			LP = GameWorld.CreateFixedSpring( stiffness, damping, warmstart, _
														  *SP->LinearStates_[ x + y * _points.x ], _
														  *SP->LinearStates_[ x + 1 + ( y + 1 ) * _points.x ] )
			
			SP->FixedSprings_.push_back( LP )
				
			Next
		Next
	
	EndIf
	
	''  V-Truss
	If ( _type = V_TRUSS ) Then
		
		For y as integer = 0 to _points.y - 2
			For x as integer = 0 to _points.x - 2 Step 2
				
			LP = GameWorld.CreateFixedSpring( stiffness, damping, warmstart, _
														  *SP->LinearStates_[ x + 1 + y * _points.x  ], _
														  *SP->LinearStates_[ x + ( y + 1 ) *_points.x  ] )
			
			SP->FixedSprings_.push_back( LP )
				
			Next
		Next
		
		For y as integer = 0 to _points.y - 2
			For x as integer = 1 to _points.x - 2 Step 2
				
			LP = GameWorld.CreateFixedSpring( stiffness, damping, warmstart, _
														  *SP->LinearStates_[ x + y * _points.x ], _
														  *SP->LinearStates_[ x + 1 + ( y + 1 ) * _points.x ] )
			
			SP->FixedSprings_.push_back( LP )
				
			Next
		Next
	
	EndIf
	
	'' K-Truss 
	If ( _type = K_TRUSS ) Then
		
		for y as integer = 0 to _points.y - 2
			For x as integer = 0 to _points.x - 2
				
				LP = GameWorld.CreateFixedSpring( stiffness, damping, warmstart, _
															  *SP->LinearStates_[ x + 1 + y * _points.x ], _
															  *SP->FixedSprings_[ x + y * _points.x + _points.y * ( _points.x - 1 ) ] )
			
				SP->FixedSprings_.push_back( LP )
				
				LP = GameWorld.CreateFixedSpring( stiffness, damping, warmstart, _
															  *SP->LinearStates_[ x + 1 + ( y + 1 ) * _points.x ], _
															  *SP->FixedSprings_[ x + y * _points.x + _points.y * ( _points.x - 1 ) ] )
			
				SP->FixedSprings_.push_back( LP )
				
			Next
		Next
		
	EndIf
	
	'' O-Truss 
	If ( _type = O_TRUSS Or _type = W_TRUSS ) Then
		
		'' Endpoint springs
		'LP = GameWorld.CreateFixedSpring( stiffness, damping, warmstart, _
		'											  *SP->FixedSprings_[ 0 ], _
		'											  *SP->FixedSprings_[ ( _points.x - 1 ) * 2  ] )
		'	
		'SP->FixedSprings_.push_back( LP )
		'
		'LP = GameWorld.CreateFixedSpring( stiffness, damping, warmstart, _
		'											  *SP->FixedSprings_[ _points.x - 1 ], _
		'											  *SP->FixedSprings_[ ( _points.x - 1 ) * 2  ] )
		'	
		'SP->FixedSprings_.push_back( LP )
		
		''
		For y as integer = 0 to _points.y - 2
			For x as integer = 0 to _points.x - 3
				 
			LP = GameWorld.CreateFixedSpring( stiffness, damping, warmstart, _
														  *SP->FixedSprings_[ x + y * ( _points.x - 1 ) ], _
														  *SP->FixedSprings_[ x + 1 + ( y + 1 ) * ( _points.x - 1 ) ] )
			
			SP->FixedSprings_.push_back( LP )
			
			LP = GameWorld.CreateFixedSpring( stiffness, damping, warmstart, _
														  *SP->FixedSprings_[ x + 1 + y * ( _points.x - 1 ) ], _
														  *SP->FixedSprings_[ x + ( y + 1 ) * ( _points.x - 1 ) ] )
			
			SP->FixedSprings_.push_back( LP )
				
			Next
		Next
		
		'' Endpoint springs
		'LP = GameWorld.CreateFixedSpring( stiffness, damping, warmstart, _
		'											  *SP->FixedSprings_[ ( _points.x - 1 ) - 1 ], _
		'											  *SP->FixedSprings_[ ( _points.x - 1 ) * 3 ] )
		'	
		'SP->FixedSprings_.push_back( LP )
		'
		'LP = GameWorld.CreateFixedSpring( stiffness, damping, warmstart, _
		'											  *SP->FixedSprings_[ ( _points.x - 1 ) * 2 - 1 ], _
		'											  *SP->FixedSprings_[ ( _points.x - 1 ) * 3 ] )
		'	
		'SP->FixedSprings_.push_back( LP )
	
	EndIf
	
	''
	SP->ComputeMass()
	SP->ComputestateVectors()
	SP->ComputeInertia()
	SP->ComputeAngularVelocity()
	SP->ComputeAngle()
	SP->ComputeAngleVector()
	
	SP->RaiseFlag( IS_ALIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
	Return SP
	
End Function


#EndIf __GO_CREATE_BI__
