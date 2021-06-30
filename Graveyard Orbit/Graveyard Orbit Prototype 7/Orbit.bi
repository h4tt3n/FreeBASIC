''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 7, february 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''  Kepler orbit
''
''*******************************************************************************

Type OrbitType' Extends LinearLinkType
	
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
	
	As Vec2 PeriapsisVector
	
	As Single Eccentricity
	As Single SemiMajorAxis
	As Single SemiMinorAxis
	
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
	
	Dim As Single distance = semimajorAxis * ( 1.0 - eccentricity * eccentricAnomalyVector.x )
	
	LinearLink.unit_vector = trueAnomalyVector.RotateCCW( periapsisVector )
	
	Dim As Vec2 distanceVector = LinearLink.unit_vector * distance
	
	Dim As Single velocity = Sqr( ( C_GRAVITY * LinearLink.mass ) * ( ( 2.0 / distance ) - ( 1.0 / SemiMajorAxis ) ) )
	
	Dim As Vec2 VelocityUnitVector = LinearLink.unit_vector.RotateCCW( flightPathVector ).PerpCCW
	
	Dim As Vec2 VelocityVector = VelocityUnitVector * Velocity * Sgn( OrbitDirection )
	
	'' Compute state vectors scaled by mass
	Dim As Vec2 PositionVectorA =  LinearLink.Position - distanceVector * LinearLink.a->inv_mass * LinearLink.reduced_mass
	Dim As Vec2 PositionVectorB =  LinearLink.Position + distanceVector * LinearLink.b->inv_mass * LinearLink.reduced_mass
	
	Dim As Vec2 VelocityVectorA = -VelocityVector * LinearLink.a->inv_mass * LinearLink.reduced_mass
	Dim As Vec2 VelocityVectorB =  VelocityVector * LinearLink.b->inv_mass * LinearLink.reduced_mass
	
	''	Apply state vectors
	LinearLink.a->SetPosition( PositionVectorA )
	LinearLink.b->SetPosition( PositionVectorB )
	
	LinearLink.a->AddImpulse( VelocityVectorA )
	LinearLink.b->AddImpulse( VelocityVectorB )
	
End Sub

Sub OrbitType.ComputeData()
	
	LinearLink.ComputeStateVectors()
	LinearLink.ComputeUnitVector()
	
	'' State vectors
	Dim As vec2 distanceVector = LinearLink.b->position - LinearLink.a->position
	Dim As vec2 velocityVector = LinearLink.b->velocity - LinearLink.a->velocity
	
	Dim As Single length = LinearLink.unit_vector.dot( distanceVector )
	
	'' Eccentricity
	Dim As Vec2 EccentricityVector = ( velocityVector.Dot( velocityVector ) * distanceVector - _
                                      distanceVector.dot( velocityVector ) * velocityVector ) / _
                                      ( C_GRAVITY * LinearLink.mass ) - LinearLink.unit_vector
	
	eccentricity = eccentricityVector.Length()
	
	'' Periapsis
	PeriApsisVector = IIf( eccentricity > 0.0 , Vec2( eccentricityVector / eccentricity ) , Vec2( 0.0, 0.0 ) )

	'' Semi axes
	SemiMajorAxis = 1.0 / ( 2.0 / Length - velocityVector.Dot( velocityVector ) / ( C_GRAVITY * LinearLink.mass ) )
	semiMinorAxis = semiMajorAxis * Sqr( 1.0 - eccentricity * eccentricity )
	
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
