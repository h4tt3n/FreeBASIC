''******************************************************************************
''    
''  Graveyard Orbit - A 2D space physics puzzle game
''
''  Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''  Version 0.1.0, October 31. 2016
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
Function Game.CreatePlanet() As Planet Ptr
	
	Dim As Planet P = Planet()
   
   Dim As Planet Ptr PP = Planets_.push_back( P )
   
   Return PP
	
End Function

Function Game.CreatePlanet( ByVal _mass    As Single, _
	                         ByVal _radius  As Single = 0.0, _
	                         ByVal _Density As Single = 0.0 ) As Planet Ptr
	
	Dim As Planet P = Planet( _mass, _radius, _density )
   
   Dim As Planet Ptr PP = Planets_.push_back( P )
	
   Return PP
	
End Function

Function Game.CreateAsteroid( ByVal _mass   As Single, _
	                           ByVal _roxels As Integer, _
	                           ByVal _radius As Vec2 ) As RigidBody Ptr
	
	Dim As RigidBody R = RigidBody()
	
	Dim As RigidBody Ptr RP = GameWorld.RigidBodys_.push_back( R )
	
	RP->LinearStates_.Reserve( _roxels ) 
	
	For i As Integer = 0 To _Roxels - 1
		
		Dim As Integer scale = ( i / _roxels ) * 128
		
		Dim As Roxel Ptr R = CreateRoxel( 100.0, 32.0 + _Roxels - i, RGB( 0, 0, 0 ), RGB( 64 + scale, 48 + scale, 32 + scale ) )
		
		R->SetPosition( Vec2().RandomizeCircle( 1.0 ) * _radius )
		
		R->LowerFlag( IS_DYNAMIC )
		
		RP->LinearStates_.push_back( R )  
		
	Next
	
	RP->ComputeMass()
	RP->ComputestateVectors()
	RP->ComputeInertia()
	
	RP->RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
	Return RP
	
End Function

Function Game.CreateAsteroidBelt( ByVal _parent        As LinearState Ptr, _
	                               ByVal _num_asteroids As Integer, _
	                               ByVal _asteroid_mass As Vec2, _
	                               ByVal _eccentricity  As Vec2, _
	                               ByVal _semimajoraxis As Vec2, _
	                               ByVal _periapsis     As Vec2, _
	                               ByVal _direction     As Single ) As SoftBody Ptr
	
	Randomize
	
	Dim As Vec2 parent_postion = _Parent->GetPosition()
	
	Dim As SoftBody S = SoftBody()
	
	Dim As SoftBody Ptr SP = GameWorld.SoftBodys_.push_back( S )
	
	SP->LinearStates_.Reserve( _num_asteroids + 1 ) 
	
	For i As Integer = 0 To _num_asteroids - 1
		
		Dim As Integer scale = ( i / _num_asteroids ) * 128
		
		Dim As Single mass = _asteroid_mass.x + Rnd() * ( _asteroid_mass.y - _asteroid_mass.x )
		
		Dim As Roxel Ptr R = CreateRoxel( mass, Sqr( ( mass / 10.0 ) / PI ), RGB( 0, 0, 0 ), RGB( 64 + scale, 48 + scale, 32 + scale ) )
		
		SP->LinearStates_.push_back( R )  
		
	Next
	
	Dim As Single distribution = 3
	
	For i As Integer = 0 To _num_asteroids - 1
		
		Dim As LinearState Ptr LP = *SP->LinearStates_[i]
		
		Dim As KeplerOrbit K = KeplerOrbit( _Parent, LP )
		
		Dim As Single eccentricity     = _Eccentricity.x + Rnd() * ( _Eccentricity.y - _Eccentricity.x )
		'Dim As Single semimajor        = _SemiMajorAxis.x + Rnd() * ( _SemiMajorAxis.y - _SemiMajorAxis.x )
		
		Dim As Single semimajor_center = ( _SemiMajorAxis.y + _SemiMajorAxis.x ) * 0.5
		Dim As Single semimajor_half   = ( _SemiMajorAxis.y - _SemiMajorAxis.x ) * 0.5
		
		Dim As Integer sign = IIf( Rnd() < 0.5 , -1 , 1 )
		'Dim As Integer sign = Sgn( Rnd()-Rnd() )
		
		Dim As Single semimajor        = semimajor_center + sign * ( Rnd() * semimajor_half ^ ( 1.0 / distribution ) ) ^ distribution
		'Dim As Single semimajor        = semimajor_center + Sgn( Rnd()-Rnd() ) * ( Rnd() * semimajor_half ^ ( 1.0 / distribution ) ) ^ distribution
		                '.Orbit_Radius = Planet(0).Radius + 2500 + ( Rnd * ( 500 ^(1/3) ) )^3
		Dim As Single periapsis        = _Periapsis.x + Rnd() * ( _Periapsis.y - _Periapsis.x )
		Dim As Single eccentricanomaly = Rnd() * TWO_PI
		
		_Parent->SetPosition( parent_postion )
		
		K.ApplyOrbit( parent_postion, eccentricity, semimajor, periapsis, eccentricanomaly, _Direction )
		
		''
		Dim As NewtonGravity Ptr N = GameWorld.CreateNewtonGravity( _Parent, LP )
		
		N->LowerFlag( IS_VISIBLE )
		
	Next
	
	_Parent->SetPosition( parent_postion )
	
	SP->LinearStates_.push_back( _Parent ) 
	
	SP->ComputeMass()
	SP->ComputestateVectors()
	SP->ComputeInertia()
	SP->ComputeAngularVelocity()
	
	Return SP
	
End Function

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
   
   RP->RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
   
   Return RP
	
End Function

Function Game.CreateGirder( ByVal _points As Vec2, _
	                         ByVal _length As Vec2, _
	                         ByVal _type   As integer ) As SoftBody Ptr
	
	'' Todo: merge girder functions || give them same name && overload
	
	''
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
			
			LS = GameWorld.CreateLinearState( 1.0, Vec2( x * _length.x, y * _length.y ) )
			 
		  	SP->LinearStates_.push_back( LS )
		  	
		Next
	Next
	
	''  Longitudinal springs, "===="
	For y as integer = 0 to _points.y - 1
		For x as integer = 0 to _points.x - 2
			
			LP = GameWorld.CreateLinearSpring( 1.0, 1.0, 1.0, _
														  *SP->LinearStates_[ x + y * _points.x ], _
														  *SP->LinearStates_[ x + y * _points.x + 1 ] )
			
			SP->LinearSprings_.push_back( LP )
			
		Next
	Next
	
	''  Transverse springs, "||||"
	for y as integer = 0 to _points.y - 2
		For x as integer = 0 to _points.x - 1
			
			LP = GameWorld.CreateLinearSpring( 1.0, 1.0, 1.0, _
														  *SP->LinearStates_[ x + y * _points.x  ], _
														  *SP->LinearStates_[ x + ( y + 1 ) * _points.x ] )
			
			SP->LinearSprings_.push_back( LP )
			
		Next
	Next
	
	''  diagonal springs, S-Truss
	If ( _type = S_TRUSS Or _type = X_TRUSS Or _type = W_TRUSS ) Then
		
		for y as integer = 0 to _points.y - 2
			For x as integer = 0 to _points.x - 2
				
			LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
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
				
			LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
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
				
			LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
														  *SP->LinearStates_[ x + 1 + y * _points.x  ], _
														  *SP->LinearStates_[ x + ( y + 1 ) *_points.x  ] )
			
			SP->LinearSprings_.push_back( LP )
				
			Next
		Next
		
		For y as integer = 0 to _points.y - 2
			For x as integer = 1 to _points.x - 2 Step 2
				
			LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
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
				
				LP = GameWorld.CreateLinearSpring( 1.0, 1.0, 1.0, _
															  *SP->LinearStates_[ x + 1 + y * _points.x ], _
															  *SP->LinearSprings_[ x + y * _points.x + _points.y * ( _points.x - 1 ) ] )
			
				SP->LinearSprings_.push_back( LP )
				
				LP = GameWorld.CreateLinearSpring( 1.0, 1.0, 1.0, _
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
			
			If ( x = 0 ) Then
				
				'' Endpoint springs
				LP = GameWorld.CreateLinearSpring( 1.0, 1.0, 1.0, _
															  *SP->LinearSprings_[ ( _points.x - 1 ) + y * ( _points.x - 1 )], _
															  *SP->LinearSprings_[ y * _points.x + _points.y * ( _points.x - 1 ) ] )
			
				SP->LinearSprings_.push_back( LP )
				
				'LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
				'											  *SP->LinearSprings_[ ( _points.x - 1 ) + y * ( _points.x - 1 ) * 2 ], _
				'											  *SP->LinearSprings_[ y * _points.x + _points.y * ( _points.x - 1 ) ] )
			
				'SP->LinearSprings_.push_back( LP )
				
			EndIf
			
			LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
														  *SP->LinearSprings_[ x + y * ( _points.x - 1 ) ], _
														  *SP->LinearSprings_[ x + 1 + ( y + 1 ) * ( _points.x - 1 ) ] )
			
			SP->LinearSprings_.push_back( LP )
			
			LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
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
	
	SP->RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
	Return SP
	
End Function

Function Game.CreateGirder( ByVal _points  As Vec2, _
	                               ByVal _Length  As Vec2, _
	                               ByVal _Radians As Single, _
	                               ByVal _Radius  As Single, _
	                               ByVal _type    As integer ) As SoftBody Ptr
	
	'' This function creates arched, curved girders for more interesting architecture, 
	'' and for girders that follow the curvature of orbits etc. 
	
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
			
			LS = GameWorld.CreateLinearState( 1.0, Vec2( ( _Radius + y * _Length.y ) * Cos( _Radians * ( x / ( _points.x - 1 ) ) ), _
			                                             ( _Radius + y * _Length.y ) * Sin( _Radians * ( x / ( _points.x - 1 ) ) ) )  )
			 
		  	SP->LinearStates_.push_back( LS )
		  	
		Next
	Next
	
	''  Longitudinal springs, "===="
	For y as integer = 0 to _points.y - 1
		For x as integer = 0 to _points.x - 2
			
			LP = GameWorld.CreateLinearSpring( 1, 1, 1, _
														  *SP->LinearStates_[ x + y * _points.x ], _
														  *SP->LinearStates_[ x + y * _points.x + 1 ] )
			
			SP->LinearSprings_.push_back( LP )
			
		Next
	Next
	
	''  Transverse springs, "||||"
	for y as integer = 0 to _points.y - 2
		For x as integer = 0 to _points.x - 1
			
			LP = GameWorld.CreateLinearSpring( 1, 1, 1, _
														  *SP->LinearStates_[ x + y * _points.x  ], _
														  *SP->LinearStates_[ x + ( y + 1 ) * _points.x ] )
			
			SP->LinearSprings_.push_back( LP )
			
		Next
	Next
	
	''  diagonal springs, S-Truss
	If ( _type = S_TRUSS Or _type = X_TRUSS Or _type = W_TRUSS ) Then
		
		for y as integer = 0 to _points.y - 2
			For x as integer = 0 to _points.x - 2
				
			LP = GameWorld.CreateLinearSpring( 1, 1, 1, _
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
				
			LP = GameWorld.CreateLinearSpring( 1, 1, 1, _
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
				
			LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
														  *SP->LinearStates_[ x + 1 + y * _points.x  ], _
														  *SP->LinearStates_[ x + ( y + 1 ) *_points.x  ] )
			
			SP->LinearSprings_.push_back( LP )
				
			Next
		Next
		
		For y as integer = 0 to _points.y - 2
			For x as integer = 1 to _points.x - 2 Step 2
				
			LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
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
				
				LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
															  *SP->LinearStates_[ x + 1 + y * _points.x ], _
															  *SP->LinearSprings_[ x + y * _points.x + _points.y * ( _points.x - 1 ) ] )
			
				SP->LinearSprings_.push_back( LP )
				
				LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
															  *SP->LinearStates_[ x + 1 + ( y + 1 ) * _points.x ], _
															  *SP->LinearSprings_[ x + y * _points.x + _points.y * ( _points.x - 1 ) ] )
			
				SP->LinearSprings_.push_back( LP )
				
			Next
		Next
		
	EndIf
	
	'' O-Truss 
	If ( _type = O_TRUSS Or _type = W_TRUSS ) Then
		
		'' Endpoint springs
		LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
													  *SP->LinearSprings_[ 0 ], _
													  *SP->LinearSprings_[ ( _points.x - 1 ) * 2  ] )
			
		SP->LinearSprings_.push_back( LP )
		
		LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
													  *SP->LinearSprings_[ _points.x - 1 ], _
													  *SP->LinearSprings_[ ( _points.x - 1 ) * 2  ] )
			
		SP->LinearSprings_.push_back( LP )
		
		''
		For y as integer = 0 to _points.y - 2
			For x as integer = 0 to _points.x - 3
				 
			LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
														  *SP->LinearSprings_[ x + y * ( _points.x - 1 ) ], _
														  *SP->LinearSprings_[ x + 1 + ( y + 1 ) * ( _points.x - 1 ) ] )
			
			SP->LinearSprings_.push_back( LP )
			
			LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
														  *SP->LinearSprings_[ x + 1 + y * ( _points.x - 1 ) ], _
														  *SP->LinearSprings_[ x + ( y + 1 ) * ( _points.x - 1 ) ] )
			
			SP->LinearSprings_.push_back( LP )
				
			Next
		Next
		
		'' Endpoint springs
		LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
													  *SP->LinearSprings_[ ( _points.x - 1 ) - 1 ], _
													  *SP->LinearSprings_[ ( _points.x - 1 ) * 3 ] )
			
		SP->LinearSprings_.push_back( LP )
		
		LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
													  *SP->LinearSprings_[ ( _points.x - 1 ) * 2 - 1 ], _
													  *SP->LinearSprings_[ ( _points.x - 1 ) * 3 ] )
			
		SP->LinearSprings_.push_back( LP )
	
	EndIf
	
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
	
	'For y as integer = 1 to _points.y - 2 Step 2
	'	For x as integer = 0 to ( _points.x * 0.5 ) - 2
	'		
	'		LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
	'													  *SP->LinearStates_[ x + ( _points.x * 0.5 ) + 2 + y * ( _points.x * 0.5 ) + y  ], _
	'													  *SP->LinearSprings_[ x + y * ( _points.x * 0.5 ) + 1 ] )
	'		
	'		SP->LinearSprings_.push_back( LP )
	'		
	'		LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
	'													  *SP->LinearStates_[ x + 1 + y * ( _points.x * 0.5 ) + y ], _
	'													  *SP->LinearSprings_[ x + ( _points.x * 0.5 ) + 1 + y * ( _points.x * 0.5 ) - 1 ] )
	'		
	'		SP->LinearSprings_.push_back( LP )
	'	
	'	Next
	'Next
	
	
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
	
	
	'''  diagonal springs, Z-Truss
	'If ( _type = Z_TRUSS Or _type = X_TRUSS ) Then	
	'
	'	For y as integer = 0 to _points.y - 2
	'		For x as integer = 0 to ( _points.x * 0.5 ) - 2
	'			
	'			LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
	'														  *SP->LinearStates_[ x + ( _points.x * 0.5 ) + 2 ], _
	'														  *SP->LinearStates_[ x  ] )
	'			
	'			SP->LinearSprings_.push_back( LP )
	'			
	'			LP = GameWorld.CreateLinearSpring( 0.5, 0.5, 0.5, _
	'														  *SP->LinearSprings_[ x + ( _points.x * 0.5 ) + 1 ], _
	'														  *SP->LinearSprings_[ x  ] )
	'			
	'			SP->LinearSprings_.push_back( LP )
	'		
	'		Next
	'	Next
	'
	'EndIf
	
	''
	SP->ComputeMass()
	SP->ComputestateVectors()
	SP->ComputeInertia()
	
	SP->RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
	Return SP
	
End Function


#EndIf __GO_CREATE_BI__