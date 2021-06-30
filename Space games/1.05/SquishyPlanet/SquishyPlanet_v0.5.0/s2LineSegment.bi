''******************************************************************************
''    
''   Squishy2D Line Segment Class
''   Written in FreeBASIC 1.05
''   version 0.2.0, May 2016, Michael "h4tt3n" Nissen
''
''   This is the inherited base type of all forces acting between two particles.
''
''
''******************************************************************************


''
#Ifndef __S2_LINE_SEGMENT_BI__
#Define __S2_LINE_SEGMENT_BI__


''
Type LineSegment Extends Rotate
	
	public:
	
	'' Constructors
	Declare Constructor()
	
	Declare Constructor( ByRef l As LineSegment )
	
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
	Declare Sub computeAngleVector()
	Declare Sub computeLengthVector()
	Declare Sub computeMass()
	Declare Sub ComputeReducedMass()
	Declare Sub computeStateVectors()
	
	'' Add
	Declare Sub AddImpulse( ByVal i As Vec2 )
	Declare Sub AddVelocity( ByVal v As Vec2 )
	Declare Sub AddPosition( ByVal p As Vec2 )
	
	''	Apply
	Declare Sub ApplyImpulse( ByVal r As Vec2, ByVal i As Vec2 )
	Declare Sub ApplyImpulseConcentration()
	Declare Sub ApplyImpulseDispersion()
	
	'' Get
	Declare Const Function Length()       As Single
	Declare Const Function LengthVector() As Vec2
	Declare Const Function ParticleA()    As Particle Ptr
	Declare Const Function ParticleB()    As Particle Ptr
	Declare Const Function ReducedMass()  As Single
	
	''	Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	'' Set
	Declare Sub ParticleA( ByVal A As Particle Ptr )
	Declare Sub ParticleB( ByVal B As Particle Ptr )
	Declare Sub Position( ByVal p As Vec2 )
	Declare Sub Velocity( ByVal v As Vec2 )
	
	Protected: 
	
	'' Variables
	As Single       Length_
	As Vec2         LengthVector_
	As Single       ReducedMass_
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
	
	computeMass()
	computeStateVectors()
	computeLengths()
	
End Constructor


'' Operators
Operator LineSegment.Let( ByRef l As LineSegment )
	
	If ( @This <> @l ) Then
		
		Length_          = l.Length_
		LengthVector_    = l.LengthVector_
		ReducedMass_     = l.ReducedMass_
		ParticleA_       = l.ParticleA_
		ParticleB_       = l.ParticleB_
		
		Cast( Rotate, This ) = l
		
	End If 
	
End Operator


'' Compute
Sub LineSegment.computeAngularVelocity()
	
	Dim As Vec2 localPositionA = Base.Position - ParticleA_->Position
	Dim As Vec2 localPositionB = Base.Position - ParticleB_->Position
	
	Dim As Vec2 localVelocityA = Base.Velocity - ParticleA_->Velocity
	Dim As Vec2 localVelocityB = Base.Velocity - ParticleB_->Velocity
	
	AngularVelocity_ = ( localPositionA.PerpDot( localVelocityA * ParticleA_->Mass ) + _
	                     localPositionB.PerpDot( localVelocityB * ParticleB_->Mass ) ) * _
	                     InverseInertia_
	
End Sub

Sub LineSegment.computeInertia()
	
	Dim As Vec2 localPositionA = Base.Position - ParticleA_->Position
	Dim As Vec2 localPositionB = Base.Position - ParticleB_->Position
	
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

Sub LineSegment.computeAngleVector()
	
	AngleVector_ = LengthVector_.Unit()
	
End Sub

Sub LineSegment.computeLengths()
	
	computeLengthVector()
	computeAngleVector()
	computeLength()
	
End Sub

Sub LineSegment.computeLength()
	
	'Length_ = LengthVector_.Length()
	Length_ = LengthVector_.Dot( AngleVector_ )
	
End Sub

Sub LineSegment.computeLengthVector()
	
	LengthVector_ = ParticleB_->Position - ParticleA_->Position
	
End Sub

Sub LineSegment.computeMass()
	
	Mass_ = ParticleA_->Mass + ParticleB_->Mass
	
	computeInverseMass()
	
End Sub

Sub LineSegment.computeReducedMass()
	
	Dim As Single im = ParticleA_->InverseMass + ParticleB_->InverseMass
	
	ReducedMass_ = IIf( im > 0.0 , 1.0 / im , 0.0 )
	
End Sub

Sub LineSegment.computeStateVectors()
	
	Position_ = ( ParticleA_->Position * ParticleA_->Mass + _
	              ParticleB_->Position * ParticleB_->Mass ) * InverseMass_
	
	Velocity_ = ( ParticleA_->Velocity * ParticleA_->Mass + _
	              ParticleB_->Velocity * ParticleB_->Mass ) * InverseMass_
	
End Sub


'' Add
Sub LineSegment.AddImpulse( ByVal i As Vec2 )
	
	ParticleA_->Impulse_ += i
	ParticleB_->Impulse_ += i
	
End Sub

Sub LineSegment.AddVelocity( ByVal v As Vec2 )
	
	ParticleA_->Velocity_ += v
	ParticleB_->Velocity_ += v
	
End Sub

Sub LineSegment.AddPosition( ByVal p As Vec2 )
	
	ParticleA_->Position_ += p
	ParticleB_->Position_ += p
	
End Sub


'' Apply
Sub LineSegment.ApplyImpulse( ByVal r As Vec2, ByVal i As Vec2 )
	
	'' work in progress
	
	Impulse_ += i
	
	AngularImpulse_ -= Position_.Dot( AngleVector_.Rotate( r ) )
	
End Sub

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

Function LineSegment.ReducedMass() As Single
	
	Return ReducedMass_
	
End Function


''	Reset
Sub LineSegment.ResetAll()
	
	ParticleA_ = 0
	ParticleB_ = 0
	
	ResetVariables()
	
End Sub

Sub LineSegment.ResetVariables()
	
	Length_          = 0.0
	LengthVector_    = Vec2( 0.0, 0.0 )
	ReducedMass_     = 0.0
	
	Base.ResetAll()
	
End Sub


'' Set
Sub LineSegment.ParticleA( ByVal A As Particle Ptr )
	
	ParticleA_ = IIf( A <> ParticleB_ , A , 0 )
	
End Sub

Sub LineSegment.ParticleB( ByVal B As Particle Ptr )
	
	ParticleB_ = IIf( B <> ParticleA_ , B , 0 )
	
End Sub

Sub LineSegment.Position( ByVal p As Vec2 )
	
	ParticleA_->AddPosition( p - Position_ )
	ParticleB_->AddPosition( p - Position_ )
	
End Sub

Sub LineSegment.Velocity( ByVal v As Vec2 )
	
	ParticleA_->AddVelocity( v - Velocity_ )
	ParticleB_->AddVelocity( v - Velocity_ )
	
End Sub


#EndIf ''__S2_LINE_SEGMENT_BI__
