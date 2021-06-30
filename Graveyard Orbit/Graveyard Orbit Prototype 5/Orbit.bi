''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 5, june 2018
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''  Kepler orbit
''
''*******************************************************************************

Type OrbitType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub ApplyOrbit( ByVal Position       As Vec2, _
	                        ByVal Eccentricity   As Single, _
	                        ByVal SemiMajorAxis  As Single, _
	                        ByVal Periapsis      As Single, _
	                        ByVal MeanAnomaly    As Single, _
	                        ByVal OrbitDirection As Single )
	
	Declare Sub ComputeData()
	
	Declare Function ComputeEccentricFromMean( ByVal meanAnomaly  As Single, _
	                                           ByVal eccentricity As Single ) As Single
	
	As LinearLinkType LinearLink
	
End Type

Constructor OrbitType()
	
End Constructor

Destructor OrbitType()

End Destructor

Sub OrbitType.ApplyOrbit( ByVal Position       As Vec2, _
	                       ByVal Eccentricity   As Single, _
	                       ByVal SemiMajorAxis  As Single, _
	                       ByVal Periapsis      As Single, _
	                       ByVal MeanAnomaly    As Single, _
	                       ByVal OrbitDirection As Single )
	
	''
	LinearLink.Position = Position
	LinearLink.Velocity = Vec2( 0.0, 0.0 )
	
	''
	LinearLink.mass = LinearLink.a->mass + LinearLink.b->mass		
	LinearLink.inv_mass = IIf( LinearLink.mass <> 0.0 , 1.0 / LinearLink.mass, 0.0 )
	
	''
	Dim As Vec2 periapsisVector = Vec2( Cos( periapsis ), Sin( periapsis ) )
	
	Dim As Vec2 meanAnomalyVector = Vec2( Cos( meanAnomaly ), Sin( meanAnomaly ) )
	
	Dim As Single eccentricAnomaly = ComputeEccentricFromMean( meanAnomaly, eccentricity )
	
	Dim As Vec2 eccentricAnomalyVector = Vec2( Cos( eccentricAnomaly ), Sin( eccentricAnomaly ) )
	
	Dim As Vec2 trueAnomalyVector = Vec2( EccentricAnomalyVector.x - Eccentricity, _
	                                      EccentricAnomalyVector.y * Sqr( 1.0 - Eccentricity * Eccentricity ) ).unit()
	
	Dim As Vec2 flightPathVector = Vec2( 1.0 + eccentricity * trueAnomalyVector.x, _
	                                           eccentricity * trueAnomalyVector.y ).unit()
	
	Dim As Vec2 eccentricityVector = periapsisVector * eccentricity
	
	Dim As Single distance = semimajorAxis * ( 1 - eccentricity * eccentricAnomalyVector.x )
	
	LinearLink.unit_vector = trueAnomalyVector.RotateCCW( periapsisVector )
	
	Dim As Vec2 distanceVector = LinearLink.unit_vector * distance
	
	Dim As Single velocity = Sqr( ( C_GRAVITY * LinearLink.mass ) * ( ( 2.0 / distance ) - ( 1.0 / SemiMajorAxis ) ) )
	
	Dim As Vec2 VelocityUnitVector = LinearLink.unit_vector.RotateCCW( flightPathVector ).PerpCCW
	
	Dim As Vec2 VelocityVector = VelocityUnitVector * Velocity * Sgn( OrbitDirection )
	
	'' Compute state vectors scaled by mass
	Dim As Vec2 PositionVectorA =  LinearLink.Position - distanceVector * LinearLink.b->Mass * LinearLink.inv_mass
	Dim As Vec2 PositionVectorB =  LinearLink.Position + distanceVector * LinearLink.a->Mass * LinearLink.inv_mass
	
	Dim As Vec2 VelocityVectorA =  -VelocityVector * LinearLink.b->Mass * LinearLink.inv_mass
	Dim As Vec2 VelocityVectorB =   VelocityVector * LinearLink.a->Mass * LinearLink.inv_mass
	
	''	Apply state vectors
	LinearLink.a->Position = PositionVectorA
	LinearLink.b->Position = PositionVectorB
	
	LinearLink.a->Velocity = VelocityVectorA
	LinearLink.b->Velocity = VelocityVectorB
	
End Sub

Sub OrbitType.ComputeData()
	
	
	
End Sub


''
Function OrbitType.ComputeEccentricFromMean( ByVal meanAnomaly  As Single, _
	                                          ByVal eccentricity As Single ) As Single
	
	''	Compute eccentric anomaly from mean anomaly (Halley's method)
	
	Dim As Integer i  = 0
	Dim As Single  E  = meanAnomaly + ( Sgn( meanAnomaly ) - meanAnomaly / PI ) * ( eccentricity / 2.0 )
	Dim As Single  Eold = 0.0
	Dim As Single  fE1  = 0.0
	Dim As Single  fE2  = 0.0
	Dim As Single  fE3  = 0.0
	
	Do
		
		i    = i + 1
		Eold = E
		fE3  = eccentricity * Sin ( Eold )
		fE2  = 1.0 - eccentricity * Cos ( Eold )
		fE1  = Eold - fE3 - meanAnomaly
		E    = Eold - fE1 / ( fE2 - fE1 * fE3 / ( 2.0 * fE2 ) )
		
	Loop Until ( Abs( E - Eold ) < 9e-14 ) Or ( i = 16 )
	
	Return E
	
End Function
