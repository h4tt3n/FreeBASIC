''******************************************************************************
''    
''   Squishy2D Line Segment Class
''   Written in FreeBASIC 1.04
''   version 0.1.0, November 2015, Michael "h4tt3n" Nissen
''
''   This is the inherited base type of all forces acting between two particles.
''
''   Particle --> LineSegment --> LinearSpring / FixedSpring
''
''******************************************************************************


''
#Ifndef __S2_LINE_SEGMENT_BI__
#Define __S2_LINE_SEGMENT_BI__


''
Type LineSegment Extends Particle
	
	public:
	
	'' Constructors
	Declare Constructor()
	
	Declare Constructor( ByRef L As LineSegment )
	
	Declare Constructor( ByVal A As Particle Ptr, _
	                     ByVal B As Particle Ptr )
	
	'' Operators
	Declare Operator Let( ByRef L As LineSegment )
	
	'' Compute
	Declare Sub computeAngularVelocity()
	Declare Sub computeInertia()
	Declare Sub computeInverseInertia()
	Declare Sub computeInverseMass()
	Declare Sub computeLengths()
	Declare Sub computeLength()
	Declare Sub computeLengthUnit()
	Declare Sub computeLengthVector()
	Declare Sub computeMass()
	Declare Sub computeStateVectors()
	
	'' Add
	Declare Sub AddAngularImpulse( ByVal A As Single )
	
	''	Apply
	Declare Sub ApplyImpulseConcentration()
	Declare Sub ApplyImpulseDispersion()
	
	'' Get
	Declare Const Function AngularImpulse()  As Single
	Declare Const Function AngularVelocity() As Single
	Declare Const Function Inertia()         As Single
	Declare Const Function InverseInertia()  As Single
	Declare Const Function Length()          As Single
	Declare Const Function LengthUnit()      As Vec2
	Declare Const Function LengthVector()    As Vec2
	Declare Const Function ParticleA()       As Particle Ptr
	Declare Const Function ParticleB()       As Particle Ptr
	
	''	Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	'' Set
	Declare Sub AngularImpulse ( ByVal A As Single )
	Declare Sub ParticleA      ( ByVal A As Particle Ptr )
	Declare Sub ParticleB      ( ByVal B As Particle Ptr )
	
	Protected: 
	
	'' Variables
	As Single       AngularImpulse_
	As Single       AngularVelocity_
	As Single       Inertia_
	As Single       InverseInertia_
	As Single       Length_
	As Vec2         LengthUnit_
	As Vec2         LengthVector_
	As Particle Ptr ParticleA_
	As Particle Ptr ParticleB_
	
End Type


'' Constructors
Constructor LineSegment()
	
	ResetAll()
	
End Constructor
	
Constructor LineSegment( ByRef L As LineSegment )
	
	ResetAll()
	
	This = L
	
End Constructor
	
Constructor LineSegment( ByVal A As Particle Ptr, _
	                      ByVal B As Particle Ptr )
	
	ResetAll()
	
	If ( A <> B ) Then
		
		ParticleA_ = A
		ParticleB_ = B
		
	Else
		
		ParticleA_ = 0
		ParticleB_ = 0
		
	EndIf
	
End Constructor


'' Operators
Operator LineSegment.Let( ByRef L As LineSegment )
	
	If ( @This <> @L ) Then
		
		AngularImpulse_  = L.AngularImpulse_
		AngularVelocity_ = L.AngularVelocity_
		Inertia_         = L.Inertia_
		InverseInertia_  = L.InverseInertia_
		Length_          = L.Length_
		LengthUnit_      = L.LengthUnit_
		LengthVector_    = L.LengthVector_
		ParticleA_       = L.ParticleA_
		ParticleB_       = L.ParticleB_
		
		Cast( Particle, This ) = L
		
	Else
		
		ResetAll()
		
	End If 
	
End Operator


'' Compute
Sub LineSegment.computeAngularVelocity()
	
	Dim As Vec2 localPositionA = Position - ParticleA_->Position
	Dim As Vec2 localPositionB = Position - ParticleB_->Position
	
	Dim As Vec2 localVelocityA = Velocity - ParticleA_->Velocity
	Dim As Vec2 localVelocityB = Velocity - ParticleB_->Velocity
	
	AngularVelocity_ = ( localPositionA.PerpDot( localVelocityA * ParticleA_->Mass ) + _
	                     localPositionB.PerpDot( localVelocityB * ParticleB_->Mass ) ) * _
	                     InverseInertia_
	
End Sub

Sub LineSegment.computeInertia()
	
	Dim As Vec2 localPositionA = Position - ParticleA_->Position
	Dim As Vec2 localPositionB = Position - ParticleB_->Position
	
	Inertia_ = localPositionA.LengthSquared() * ParticleA_->Mass + _
	           localPositionB.LengthSquared() * ParticleB_->Mass
	
	ComputeInverseInertia()
	
End Sub

Sub LineSegment.computeInverseInertia()
	
	InverseInertia_ = IIf( Inertia_ > 0.0 , 1.0 / Inertia_ , 0.0 )
	
End Sub

Sub LineSegment.computeInverseMass()
	
	InverseMass_ = IIf( Mass_ > 0.0 , 1.0 / Mass_ , 0.0 )
	
End Sub

Sub LineSegment.computeLengthUnit()
	
	LengthUnit_ = LengthVector_.Unit()
	
End Sub

Sub LineSegment.computeLengths()
	
	computeLengthVector()
	computeLengthUnit()
	computeLength()
	
End Sub

Sub LineSegment.computeLength()
	
	'Length_ = LengthVector_.Length()
	Length_ = LengthVector_.Dot( LengthUnit_ )
	
End Sub

Sub LineSegment.computeLengthVector()
	
	LengthVector_ = ParticleB_->Position - ParticleA_->Position
	
End Sub

Sub LineSegment.computeMass()
	
	Mass_ = ParticleA_->Mass + ParticleB_->Mass
	
	computeInverseMass()
	
End Sub

Sub LineSegment.computeStateVectors()
	
	Position_ = ( ParticleA_->Position * ParticleA_->Mass + _
	              ParticleB_->Position * ParticleB_->Mass ) * InverseMass_
	
	Velocity_ = ( ParticleA_->Velocity * ParticleA_->Mass + _
	              ParticleB_->Velocity * ParticleB_->Mass ) * InverseMass_
	
End Sub


'' Add
Sub LineSegment.AddAngularImpulse( ByVal A As Single )
	
	AngularImpulse_ += A
	
End Sub


''
Sub LineSegment.ApplyImpulseConcentration()
	
	''
	
	Impulse_ += ParticleA_->Impulse * ParticleA_->Mass * InverseMass_
	Impulse_ += ParticleB_->Impulse * ParticleB_->Mass * InverseMass_
	
	Dim As Vec2 LocalPositionA = Position_ - ParticleA_->Position
	Dim As Vec2 LocalPositionB = Position_ - ParticleB_->Position
	
	Dim As Single LocalImpulseA = LocalPositionA.PerpDot( ParticleA_->Impulse )
	Dim As Single LocalImpulseB = LocalPositionB.PerpDot( ParticleB_->Impulse )
	
	AngularImpulse_ += LocalImpulseA * ParticleA_->Mass * inverseInertia_
	AngularImpulse_ += LocalImpulseB * ParticleB_->Mass * inverseInertia_
	
	ParticleA_->Impulse( Vec2( 0.0, 0.0 ) )
	ParticleB_->Impulse( Vec2( 0.0, 0.0 ) )

End Sub

Sub LineSegment.ApplyImpulseDispersion()
	
	''
	
	ParticleA_->AddImpulse( Impulse_ )
	ParticleB_->AddImpulse( Impulse_ )
	
	Dim As Vec2 LocalPositionA = Position_ - ParticleA_->Position
	Dim As Vec2 LocalPositionB = Position_ - ParticleB_->Position
	
	Dim As Vec2 LocalImpulseA = LocalPositionA.PerpDot( AngularImpulse_ )
	Dim As Vec2 LocalImpulseB = LocalPositionB.PerpDot( AngularImpulse_ )
	
	ParticleA_->addImpulse( LocalImpulseA )
	ParticleB_->addImpulse( LocalImpulseB )
	
	Impulse_        = Vec2( 0.0, 0.0 )
	AngularImpulse_ = 0.0 

End Sub


'' Get
Function LineSegment.AngularImpulse() As Single
	
	Return AngularImpulse_
	
End Function

Function LineSegment.AngularVelocity() As Single
	
	Return AngularVelocity_
	
End Function

Function LineSegment.Inertia() As Single
	
	Return Inertia_
	
End Function

Function LineSegment.InverseInertia() As Single
	
	Return InverseInertia_
	
End Function

Function LineSegment.LengthUnit() As Vec2
	
	Return LengthUnit_
	
End Function

Function LineSegment.Length() As Single
	
	Return Length_
	
End Function

Function LineSegment.LengthVector() As Vec2
	
	Return LengthVector_
	
End Function

Function LineSegment.ParticleA() As Particle Ptr
	
	Return ParticleA_
	
End Function

Function LineSegment.ParticleB() As Particle Ptr
	
	Return ParticleB_
	
End Function


''	Reset
Sub LineSegment.ResetAll()
	
	ParticleA_ = 0
	ParticleB_ = 0
	
	ResetVariables()
	
End Sub

Sub LineSegment.ResetVariables()
	
	AngularImpulse_  = 0.0
	AngularVelocity_ = 0.0
	Inertia_         = 0.0
	InverseInertia_  = 0.0
	Length_          = 0.0
	LengthVector_    = Vec2( 0.0, 0.0 )
	LengthUnit_      = Vec2( 0.0, 0.0 )
	
	Base.ResetAll()
	
End Sub


'' Set
Sub LineSegment.AngularImpulse( ByVal A As Single )
	
	AngularImpulse_ = A
	
End Sub

Sub LineSegment.ParticleA( ByVal A As Particle Ptr )
	
	ParticleA_ = IIf( A <> ParticleB_ , A , 0 )
	
End Sub

Sub LineSegment.ParticleB( ByVal B As Particle Ptr )
	
	ParticleB_ = IIf( B <> ParticleA_ , B , 0 )
	
End Sub


#EndIf ''__S2_LINE_SEGMENT_BI__
