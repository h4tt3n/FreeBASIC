''*******************************************************************************
''
''   Squishy2D Kepler Orbit Class
''   Written in FreeBASIC 1.05
''   Version 0.2.0, May 2016, Michael "h4tt3n" Nissen
''
''   This class takes care of all the hairy orbital math and physics.
''
''   Particle -> Rotate -> LineSegment -> NewtonGravity -> KeplerOrbit
''
''   TODO:
''
''   Compute which body an object is orbiting (smallest mass and energy < 0)?
''   Sphere of influence / Hill sphere function
''   Lagrange points 1-5 function
''   implement inherited LineSegment 
''
''*******************************************************************************


''
#Ifndef __S2_KEPLER_ORBIT_BI__
#Define __S2_KEPLER_ORBIT_BI__


'' Kepler orbit class
Type KeplerOrbit Extends NewtonGravity
	
	Public:
	
	'' Constructors
	Declare Constructor()
	
	Declare Constructor( ByRef K As KeplerOrbit )
	
	Declare Constructor( ByRef A As Particle Ptr, _
	                     ByRef B As Particle Ptr )
	
	'' Operators
	Declare Operator Let( ByRef K As KeplerOrbit )
	
	'' Compute orbital elements
	Declare Sub ComputeBarycenter         ()
	Declare Sub ComputeEccentricity       ()
	Declare Sub ComputeEccentricityVector ()
	Declare Sub ComputeFlightPathAngle    ()
	Declare Sub ComputeFlightPathVector   ()
	Declare Sub ComputeMeanMotion         ()
	Declare Sub ComputePeriApsisVector    ()
	Declare Sub ComputePeriod             ()
	Declare Sub ComputeRadius             ()
	Declare Sub ComputeOrbitDirection     ()
	Declare Sub ComputeSemiMajorAxis      ()
	Declare Sub ComputeSemiMinorAxis      ()
	Declare Sub ComputeSpecAngularMomentum()
	Declare Sub computeSpecificEnergy     ()
	Declare Sub ComputeVelocity           ()
	Declare Sub ComputeVelocityVector     ()
	
	'' Compute anomalies
	Declare Sub ComputeEccentricFromMean()
	Declare Sub ComputeEccentricFromTrue()
	Declare Sub ComputeMeanFromEccentric()
	Declare Sub ComputeMeanFromTrue     ()
	Declare Sub ComputeTrueFromEccentric()
	Declare Sub ComputeTrueFromMean     ()
	Declare Sub ComputeTrueFromState    ()
	
	''
	Declare Sub ComputeStateFromKepler()
	Declare Sub ComputeKeplerFromState()
	
	
	Declare Sub DrawOrbit()
	
	'' Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()

	''
	Declare Sub CreateOrbit( ByVal Barycenter     As Vec2, _
	                         ByVal Eccentricity   As Single, _
	                         ByVal SemiMajorAxis  As Single, _
	                         ByVal Periapsis      As Single, _
	                         ByVal MeanAnomaly    As Single, _
	                         ByVal OrbitDirection As Single )

	'' Get
	Declare Const Function Barycenter         () As Vec2
	Declare Const Function EccentricAnomaly   () As Single
	Declare Const Function Eccentricity       () As Single
	Declare Const Function EccentricityVector () As Vec2
	Declare Const Function FlightPathAngle    () As Single
	Declare Const Function MeanAnomaly        () As Single
	Declare Const Function MeanMotion         () As Single
	Declare Const Function OrbitDirection     () As Single
	Declare Const Function Periapsis          () As Single
	Declare Const Function Period             () As Single
	Declare Const Function SemiMajorAxis      () As Single
	Declare Const Function SemiMinorAxis      () As Single
	Declare Const Function SpecificEnergy		() As Single
	Declare Const Function TrueAnomaly        () As Single
	Declare Const Function TrueAnomalyVector  () As Vec2
	Declare Const Function Velocity           () As Single
	Declare Const Function VelocityVector     () As Vec2

	'' Set
	Declare Sub Eccentricity   ( ByRef e As Single )
	Declare Sub MeanAnomaly    ( ByRef m As Single )
	Declare Sub OrbitDirection ( ByRef o As Single )
	Declare Sub Periapsis      ( ByRef p As Single )
	Declare Sub SemimajorAxis  ( ByRef s As Single )

	Private:

	'' Classical Keplerian Orbital elements
	As Single Eccentricity_
	As Vec2   EccentricityVector_
	As Single Periapsis_
	As Vec2   PeriapsisVector_
	As Single SemiMajorAxis_
	As Single SemiMinorAxis_

	'' State
	As Single Velocity_
	As Vec2   VelocityVector_

	'' Anomalies
	As Single EccentricAnomaly_
	As Vec2   EccentricAnomalyVector_
	As Single MeanAnomaly_
	As Vec2   MeanAnomalyVector_
	As Single TrueAnomaly_
	As Vec2   TrueAnomalyVector_

	''	Other usefull stuff
	As Vec2   Barycenter_
	As Single FlightPathAngle_
	As Vec2   FlightPathVector_
	As Single MeanMotion_
	As Single OrbitDirection_
	As Single SpecAngularMomentum_
	As Single SpecificEnergy_
	As Single Period_

End Type


'' Constructors
Constructor KeplerOrbit()
	
	ResetAll()

End Constructor

Constructor KeplerOrbit( ByRef K As KeplerOrbit )
	
	ResetAll()
	
	This = K

End Constructor

Constructor KeplerOrbit( ByRef A As Particle Ptr, _
                         ByRef B As Particle Ptr )
	
	ResetAll()
	
	If ( A <> B ) Then
		
		ParticleA( A )
		ParticleB( B )
		
	Else
		
		ParticleA( 0 )
		ParticleB( 0 )
		
	End If
	
	ComputeMass()
	'ComputeReducedMass()
	ComputeGravParam()

End Constructor


'' Operators
Operator KeplerOrbit.Let( ByRef K As KeplerOrbit )
	
	If ( @This <> @K ) Then
		
		Barycenter_             = K.Barycenter_
		EccentricAnomaly_       = K.EccentricAnomaly_
		EccentricAnomalyVector_ = K.EccentricAnomalyVector_
		Eccentricity_           = K.Eccentricity_
		EccentricityVector_     = K.EccentricityVector_
		FlightPathAngle_        = K.FlightPathAngle_
		FlightPathVector_       = K.FlightPathVector_
		MeanAnomaly_            = K.MeanAnomaly_
		MeanAnomalyVector_      = K.MeanAnomalyVector_
		MeanMotion_             = K.MeanMotion_
		OrbitDirection_         = K.OrbitDirection_
		PeriApsis_              = K.PeriApsis_
		PeriApsisVector_        = K.PeriApsisVector_
		Period_                 = K.Period_
		SemiMajorAxis_          = K.SemiMajorAxis_
		SemiMinorAxis_          = K.SemiMinorAxis_
		SpecAngularMomentum_    = K.SpecAngularMomentum_
		SpecificEnergy_         = K.SpecificEnergy_
		TrueAnomaly_            = K.TrueAnomaly_
		TrueAnomalyVector_      = K.TrueAnomalyVector_
		Velocity_               = K.Velocity_
		VelocityVector_         = K.VelocityVector_
		
		Cast( NewtonGravity, This ) = K
		
	End If
	
End Operator


'' Compute
Sub KeplerOrbit.computeBarycenter()

	Barycenter_ = Vec2( ( ParticleA_->Position * ParticleA_->Mass + _
	                      ParticleB_->Position * ParticleB_->Mass ) * InverseMass )

End Sub

Sub KeplerOrbit.ComputeEccentricFromMean()
	
	''	Compute eccentric anomaly from mean anomaly (Halley's method)
	
	Dim As Integer i  = 0
	Dim As Double  E  = meanAnomaly_ + ( Sgn( meanAnomaly_ ) - meanAnomaly_ / PI ) * ( eccentricity_ / 2.0 )
	Dim As Double  Eold = 0.0
	Dim As Double  fE1  = 0.0
	Dim As Double  fE2  = 0.0
	Dim As Double  fE3  = 0.0
	
	Do
		
		i    = i + 1
		Eold = E
		fE3  = eccentricity_ * Sin ( Eold )
		fE1  = Eold - fE3 - meanAnomaly_
		fE2  = 1.0 - eccentricity_ * Cos ( Eold )
		E    = Eold - fE1 / ( fE2 - fE1 * fE3 / ( 2.0 * fE2 ) )
		
	Loop Until ( Abs( E - Eold ) < 9e-14 ) Or ( i > 16 )
	
	eccentricAnomaly_ = E
	
End Sub

Sub KeplerOrbit.ComputeEccentricFromTrue()

	eccentricAnomaly_ = ATan2( Sqr( 1.0 - eccentricity_ * eccentricity_ ) * Sin( trueAnomaly_ ), _
	                           eccentricity_ + Cos( trueAnomaly_ ) )

End Sub

Sub KeplerOrbit.computeEccentricity()

	eccentricity_ = eccentricityVector_.Length()

End Sub

Sub KeplerOrbit.computeEccentricityVector()

	EccentricityVector_ = velocityVector_.perpdot( LengthVector_.perpdot( velocityvector_ ) ) / _
								 GravParam_ - AngleVector_

	'EccentricityVector_ = ( velocityVector_.LengthSquared() * LengthVector_- _
	'	                   LengthVector_.dot( velocityVector_ ) * velocityVector_ ) / GravParam_ - AngleVector_

End Sub

Sub KeplerOrbit.computeFlightPathAngle()

	FlightPathAngle_ = ATan2( eccentricity_ * Sin( trueAnomaly_ ), 1.0 + eccentricity_ * Cos( trueAnomaly_ ) )

	'FlightPathAngle_ = UnitToAngle( FlightPathVector_ )

End Sub

Sub KeplerOrbit.computeFlightPathVector()
	
	'' this can be optimized / improved! It's really velocity projected onto length.
	
	'FlightPathVector_ = Vec2( LengthVector_.perpdot( velocityvector_ ) / ( Length_ * VelocityVector_.Length() ), _
	'								  LengthVector_.dot( velocityvector_ ) / ( Length_ * VelocityVector_.Length() ) )

	FlightPathVector_ = ( Vec2( 1.0 + eccentricity_, eccentricity_ ) * TrueAnomalyVector_ ).Rotate( LengthVector_.Perp() )

	'FlightPathVector_ = AngleToUnit( FlightPathAngle_ )

End Sub

Sub KeplerOrbit.ComputeKeplerFromState()

	'' State vectors
	ComputeLengths()
	ComputeVelocityVector()

	'' Mass related stuff
	ComputeBarycenter()

	''
	ComputeEccentricityVector()
	ComputeEccentricity()
	ComputePeriApsisVector()

	'' Anomalies
	ComputeTrueFromState()
	ComputeEccentricFromTrue()
	ComputeMeanFromEccentric()

	'' Semi axes
	ComputeSemimajorAxis()
	ComputeSemiminorAxis()

	ComputeFlightPathVector()

	ComputeOrbitDirection()

End Sub

Sub KeplerOrbit.computeMeanMotion()

	MeanMotion_ = Sqr( GravParam_ / ( semimajorAxis_ * semimajorAxis_ * semimajorAxis_ ) )

End Sub

Sub KeplerOrbit.ComputeMeanFromEccentric()

	''	Kepler's equation
	MeanAnomaly_ = EccentricAnomaly_ - Eccentricity_ * Sin ( EccentricAnomaly_ )

End Sub

Sub KeplerOrbit.ComputeMeanFromTrue()

	ComputeEccentricFromTrue()
	ComputeMeanFromEccentric()

End Sub

Sub KeplerOrbit.ComputeOrbitDirection()

	OrbitDirection_ = Sgn( LengthVector_.PerpDot( VelocityVector_ ) )

End Sub

Sub KeplerOrbit.ComputePeriApsisVector()
	
	PeriApsisVector_ = IIf( Eccentricity_ > 0.0 , Vec2( EccentricityVector_ / Eccentricity_) , Vec2( 0.0, 0.0 ) )
	
	Periapsis_ = UnitToAngle( PeriApsisVector_ )
	
End Sub

Sub KeplerOrbit.computePeriod()

	Period_ = TWO_PI * Sqr( ( SemiMajorAxis_ * SemiMajorAxis_ * SemiMajorAxis_ ) / GravParam_ )

End Sub

Sub KeplerOrbit.ComputeRadius()

	'Length_ = LengthVector_.Length()

	Length_ = semimajorAxis_ * ( 1 - eccentricity_ * Cos ( eccentricAnomaly_ ) )

	'Length_ = ( SpecAngularmomentum_ * SpecAngularmomentum_ ) / GravParam_ * _
	'            1.0 / ( 1.0 + Eccentricity_ * Cos( TrueAnomaly_ ) )

End Sub

Sub KeplerOrbit.computeSemiMajorAxis()

	SemiMajorAxis_ = 1.0 / ( 2.0 / Length_ - VelocityVector_.Dot( VelocityVector_ ) / GravParam_ )

End Sub

Sub KeplerOrbit.computeSemiMinorAxis()

	semiMinorAxis_ = semiMajorAxis_ * Sqr( 1.0 - eccentricity_ * eccentricity_ )

End Sub

Sub KeplerOrbit.ComputeSpecAngularMomentum()

	SpecAngularMomentum_ = SemiMinorAxis_ * Sqr( GravParam_ / SemiMajorAxis_ )

End Sub

Sub KeplerOrbit.computeSpecificEnergy()

	'SpecificEnergy_ = GravParam_ / ( 2.0 * SemiMajorAxis_ )

	SpecificEnergy_ = VelocityVector_.Dot( VelocityVector_ ) / 2.0 - GravParam_ / Length_

End Sub

Sub KeplerOrbit.ComputeStateFromKepler()

	PeriapsisVector_ = AngleToUnit( Periapsis_ )

	MeanAnomalyVector_ = AngleToUnit( MeanAnomaly_ )

	computeSemiMinorAxis()

	ComputeEccentricFromMean()

	EccentricAnomalyVector_ = AngleToUnit( EccentricAnomaly_ )

	computeTrueFromEccentric()
	
	computeFlightPathAngle()

	EccentricityVector_ = PeriapsisVector_ * Eccentricity_
	
	ComputeRadius()

	Dim As Single RadiusAngle =  Periapsis_ - TrueAnomaly_

	Dim As Vec2 _RadiusUnitVector = AngleToUnit( RadiusAngle )

	LengthVector_ = _RadiusUnitVector * Length_
	
	ComputeVelocity()

	Dim As Vec2 VelocityUnitVector_ = AngleToUnit( RadiusAngle - FlightPathAngle_ ).Perp()

	VelocityVector_ = VelocityUnitVector_ * Velocity_ * Sgn( OrbitDirection_ )

End Sub

Sub KeplerOrbit.ComputeTrueFromEccentric()

	trueAnomaly_ = ATan2( Sqr( 1.0 - Eccentricity_ * Eccentricity_ ) * Sin( EccentricAnomaly_ ), _
	                      Cos( EccentricAnomaly_ ) - Eccentricity_ )

	'trueAnomaly_ = 2.0 * ATan2( Sqr( 1.0 + Eccentricity_ ) * Sin( EccentricAnomaly_ / 2.0 ), _
	'						          Sqr( 1.0 - Eccentricity_ ) * Cos( EccentricAnomaly_ / 2.0 ) )

End Sub

Sub KeplerOrbit.ComputeTrueFromMean()

	ComputeEccentricFromMean()
	ComputeTrueFromEccentric()

End Sub

Sub KeplerOrbit.ComputeTrueFromState()

	TrueAnomalyVector_ = Vec2( PeriApsisVector_.Dot( AngleVector_ ) , _
									   PeriApsisVector_.PerpDot( AngleVector_ ) )

	'TrueAnomalyVector_ = Vec2( EccentricityVector_.Dot( LengthVector_ ) / ( Eccentricity_ * Length_ ), _
	'                           EccentricityVector_.PerpDot( LengthVector_ ) / ( Eccentricity_ * Length_ ) )

End Sub

Sub KeplerOrbit.computeVelocity()

	'' Vis-Viva Equation

	Velocity_ = Sqr( GravParam_ * ( 2.0 / Length_ - 1.0 / SemiMajorAxis_ ) )

End Sub

Sub KeplerOrbit.computeVelocityVector()

	VelocityVector_ = ParticleA_->Velocity - ParticleB_->Velocity

End Sub

Sub KeplerOrbit.DrawOrbit()

	''	Scale axes by mass (only used for drawing)
	Dim As Vec2 SemiAxesA = Vec2( semiMajorAxis_, semiMinorAxis_ ) * ParticleA_->Mass * InverseMass
	Dim As Vec2 SemiAxesB = Vec2( semiMajorAxis_, semiMinorAxis_ ) * ParticleB_->Mass * InverseMass

	'' Distance between focal points
	Dim As Single FocalDistA = Eccentricity_ * SemiAxesA.x
	Dim As Single FocalDistB = Eccentricity_ * SemiAxesB.x

	''	Compute orbit centers (only used for drawing)
	Dim As Vec2 OrbitCenterA = Barycenter_ - PeriApsisVector_ * FocalDistA
	Dim As Vec2 OrbitCenterB = Barycenter_ + PeriApsisVector_ * FocalDistB
	
	'' Empty focal points
	Dim As Vec2 EmptyFocusA = Barycenter_ - PeriApsisVector_ * FocalDistA * 2.0
	Dim As Vec2 EmptyFocusB = Barycenter_ + PeriApsisVector_ * FocalDistB * 2.0

	''	Draw orbits
	FastEllipse( OrbitCenterA, SemiAxesA, PeriApsisVector_, RGB( 8, 128, 32 ) )
	FastEllipse( OrbitCenterB, SemiAxesB, PeriApsisVector_, RGB( 8, 128, 32 ) )

	''	Draw focal points
	Circle( EmptyFocusA.x, EmptyFocusA.y ), 4, RGB( 4, 64, 16 ),,,1
	Circle( EmptyFocusB.x, EmptyFocusB.y ), 4, RGB( 4, 64, 16 ),,,1
	Circle( Barycenter_.x, Barycenter_.y ), 8, RGB( 8, 128, 32 ),,,1

End Sub

Sub KeplerOrbit.ResetAll()
	
	''	Reset everything
	
	ResetVariables()
	
	Base.ResetAll()
	
End Sub

Sub KeplerOrbit.ResetVariables()

	''	Reset everything except celestial body pointers
	
	Barycenter_             = Vec2( 0.0, 0.0 )
	EccentricAnomaly_       = 0.0
	EccentricAnomalyVector_ = Vec2( 0.0, 0.0 )
	Eccentricity_           = 0.0
	EccentricityVector_     = Vec2( 0.0, 0.0 )
	FlightPathAngle_        = 0.0
	FlightPathVector_       = Vec2( 0.0, 0.0 )
	MeanAnomaly_            = 0.0
	MeanAnomalyVector_      = Vec2( 0.0, 0.0 )
	MeanMotion_             = 0.0
	OrbitDirection_         = 0.0
	PeriApsis_              = 0.0
	PeriApsisVector_        = Vec2( 0.0, 0.0 )
	Period_                 = 0.0
	Length_                 = 0.0
	LengthVector_           = Vec2( 0.0, 0.0 )
	AngleVector_            = Vec2( 0.0, 0.0 )
	SemiMajorAxis_          = 0.0
	SemiMinorAxis_          = 0.0
	SpecAngularMomentum_    = 0.0
	SpecificEnergy_         = 0.0
	TrueAnomaly_            = 0.0
	TrueAnomalyVector_      = Vec2( 0.0, 0.0 )
	Velocity_               = 0.0
	VelocityVector_         = Vec2( 0.0, 0.0 )
	
	Base.ResetVariables()
	
End Sub


''
Sub KeplerOrbit.CreateOrbit( ByVal _Barycenter     As Vec2, _
	                          ByVal _Eccentricity   As Single, _
	                          ByVal _SemiMajorAxis  As Single, _
	                          ByVal _Periapsis      As Single, _
	                          ByVal _MeanAnomaly    As Single, _
	                          ByVal _OrbitDirection As Single )

	''
	Barycenter_     = _Barycenter
	Eccentricity_   = _Eccentricity
	SemimajorAxis_  = _SemiMajorAxis
	Periapsis_      = _Periapsis
	MeanAnomaly_    = _MeanAnomaly
	OrbitDirection_ = _OrbitDirection
	
	''
	ComputeStateFromKepler()

	'' Compute state vectors scaled by mass
	Dim As Vec2 RadiusVectorA = Barycenter_ - LengthVector_ * ParticleB_->Mass * InverseMass
	Dim As Vec2 RadiusVectorB = Barycenter_ + LengthVector_ * ParticleA_->Mass * InverseMass

	Dim As Vec2 VelocityVectorA = -VelocityVector_ * ParticleB_->Mass * InverseMass
	Dim As Vec2 VelocityVectorB =  VelocityVector_ * ParticleA_->Mass * InverseMass

	''	Apply state vectors
	ParticleA_->Position( RadiusVectorA )
	ParticleB_->Position( RadiusVectorB )

	ParticleA_->AddImpulse( VelocityVectorA )
	ParticleB_->AddImpulse( VelocityVectorB )
	
	computeStateVectors()
	computeLengths()
	
End Sub


'' Get
Function KeplerOrbit.EccentricAnomaly() As Single

	Return eccentricAnomaly_

End Function

Function KeplerOrbit.Eccentricity() As Single

	Return eccentricity_

End Function

Function KeplerOrbit.EccentricityVector() As Vec2

	Return eccentricityVector_

End Function

Function KeplerOrbit.FlightPathAngle() As Single

	Return flightPathAngle_

End Function

Function KeplerOrbit.MeanAnomaly() As Single

	Return meanAnomaly_

End Function

Function KeplerOrbit.MeanMotion() As Single

	Return meanMotion_

End Function

Function KeplerOrbit.OrbitDirection() As Single

	Return OrbitDirection_

End Function

Function KeplerOrbit.Periapsis() As Single
	
	Return Periapsis_
	
End Function

Function KeplerOrbit.Period() As Single

	Return Period_

End Function

Function KeplerOrbit.SemiMajorAxis() As Single

	Return semiMajorAxis_

End Function

Function KeplerOrbit.SemiMinorAxis() As Single

	Return semiMinorAxis_

End Function

Function KeplerOrbit.SpecificEnergy() As Single

	Return specificEnergy_

End Function

Function KeplerOrbit.trueAnomaly() As Single

	Return TrueAnomaly_

End Function

Function KeplerOrbit.trueAnomalyVector() As Vec2

	Return trueAnomalyVector_

End Function

Function KeplerOrbit.VelocityVector() As Vec2

	Return velocityVector_

End Function



'' Set
Sub KeplerOrbit.OrbitDirection ( ByRef o As Single )

	OrbitDirection_ = Sgn( o )

End Sub

Sub KeplerOrbit.Periapsis ( ByRef p As Single )

	Periapsis_ = p

End Sub

Sub KeplerOrbit.Eccentricity ( ByRef e As Single )

	eccentricity_ = e

End Sub

Sub KeplerOrbit.MeanAnomaly ( ByRef m As Single )

	meanAnomaly_ = m

End Sub

Sub KeplerOrbit.SemiMajorAxis ( ByRef s As Single )

	semiMajorAxis_ = s

End Sub


#EndIf ''__S2_KEPLER_ORBIT_BI__
