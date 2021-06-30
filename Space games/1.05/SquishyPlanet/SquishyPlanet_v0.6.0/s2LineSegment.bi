''******************************************************************************
''    
''   Squishy2D Line Segment Class
''   Written in FreeBASIC 1.05
''   version 0.2.0, May 2016, Michael "h4tt3n" Nissen
''
''   This is the inherited base type of all impulses acting between two particles.
''   It is used for springs, gravitational interaction, and surface vertices.
''   
''   Since it takes two particle ptr's as parameters, and since particles are
''   the inherited base type of all physical objects, it can connect any two
''   object of any type, even oter linesegments. Everything connects to everything.
''
''   Particle -> Rotate -> LineSegment
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
	
	'' Add
	Declare Sub AddAngle           ( ByVal a As Single )
	Declare Sub AddAngleVector     ( ByVal a As Vec2 )
	Declare Sub AddAngularImpulse  ( ByVal a As Single )
	Declare Sub AddAngularVelocity ( ByVal a As Single )
	Declare Sub AddImpulse         ( ByVal i As Vec2 )
	Declare Sub AddVelocity        ( ByVal v As Vec2 )
	Declare Sub AddPosition        ( ByVal p As Vec2 )
	
	''	Apply
	Declare Sub ApplyImpulse( ByVal i As Vec2, ByVal r As Vec2 )
	
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
	
	'' Get
	Declare Const Function Length()       As Single
	Declare Const Function LengthVector() As Vec2
	Declare Const Function ParticleA()    As Particle Ptr
	Declare Const Function ParticleB()    As Particle Ptr
	Declare Const Function Position()     As Vec2
	Declare Const Function ReducedMass()  As Single
	Declare Const Function Velocity()     As Vec2
	
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
	
	RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
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


'' Add
Sub LineSegment.AddAngle( ByVal a As Single )
	
End Sub

Sub LineSegment.AddAngleVector( ByVal a As Vec2 )
	
End Sub

Sub LineSegment.AddAngularImpulse( ByVal a As Single )
	
	Dim As Vec2 LocalPositionA = Position_ - ParticleA_->Position
	Dim As Vec2 LocalPositionB = Position_ - ParticleB_->Position
	
	Dim As Vec2 LocalImpulseA = LocalPositionA.PerpDot( a )
	Dim As Vec2 LocalImpulseB = LocalPositionB.PerpDot( a )
	
	ParticleA_->addImpulse( LocalImpulseA )
	ParticleB_->addImpulse( LocalImpulseB )
	
End Sub

Sub LineSegment.AddAngularVelocity( ByVal a As Single )
	
End Sub

Sub LineSegment.AddImpulse( ByVal i As Vec2 )
	
	ParticleA_->AddImpulse( i )
	ParticleB_->AddImpulse( i )
	
End Sub

Sub LineSegment.AddVelocity( ByVal v As Vec2 )
	
	ParticleA_->AddVelocity( v )
	ParticleB_->AddVelocity( v )
	
	computeStateVectors()
	
End Sub

Sub LineSegment.AddPosition( ByVal p As Vec2 )
	
	ParticleA_->AddPosition( p )
	ParticleB_->AddPosition( p )
	
	computeStateVectors()
	
End Sub


'' Apply
Sub LineSegment.ApplyImpulse( ByVal i As Vec2, ByVal r As Vec2 )
	
	AddImpulse( i * InverseMass )
	
	Dim As Single LocalAngularImpulse = r.PerpDot( i )
	
	AddAngularImpulse( LocalAngularImpulse * InverseInertia )
	
End Sub


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
	computeReducedMass()
	
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

Function LineSegment.Position() As Vec2
	
	Return Position_
	
End Function

Function LineSegment.ReducedMass() As Single
	
	Return ReducedMass_
	
End Function

Function LineSegment.Velocity() As Vec2
	
	Return Velocity_
	
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
	
	computeStateVectors()
	
End Sub

Sub LineSegment.Velocity( ByVal v As Vec2 )
	
	ParticleA_->AddVelocity( v - Velocity_ )
	ParticleB_->AddVelocity( v - Velocity_ )
	
	computeStateVectors()
	
End Sub


#EndIf ''__S2_LINE_SEGMENT_BI__
