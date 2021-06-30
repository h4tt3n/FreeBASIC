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
''   This is the inherited base type of all connections between two LinearStates.
''   It is used for springs, gravity, collisions, and surface vertices.
''   
''   Since it takes two LinearState ptr's as parameters, and since LinearStates
''   are the inherited base type of all physical objects, it can connect any two
''   objects of any type, even oter LineSegments. Everything connects to everything.
''
''   LinearState -> AngularState -> LinearLink
''
''******************************************************************************


''
#Ifndef __S2_LINEAR_LINK_BI__
#Define __S2_LINEAR_LINK_BI__


''
Type LinearLink Extends AngularState
	
	Public:
	
	'' Constructors
	Declare Constructor()
	
	Declare Constructor( ByRef l As LinearLink )
	
	Declare Constructor( ByVal A As LinearState Ptr, _
	                     ByVal B As LinearState Ptr )
	
	'' Destructor
	Declare Destructor()
	
	'' Operators
	Declare Operator Let( ByRef L As LinearLink )
	
	'' Add
	Declare Sub AddAngle           ( ByVal a As Single )
	Declare Sub AddAngleVector     ( ByVal a As Vec2 )
	Declare Sub AddAngularImpulse  ( ByVal a As Single )
	Declare Sub AddAngularVelocity ( ByVal a As Single )
	Declare Sub AddImpulse         ( ByVal i As Vec2 )
	Declare Sub AddVelocity        ( ByVal v As Vec2 )
	Declare Sub AddPosition        ( ByVal p As Vec2 )
	
	''	Apply
	Declare Sub ApplyImpulseDistribution( ByVal c As Single )
	
	'' Compute
	Declare Sub ComputeAngularVelocity()
	Declare Sub ComputeInertia()
	Declare Sub ComputeLengths()
	Declare Sub ComputeLength()
	Declare Sub ComputeAngleVector()
	Declare Sub ComputeLengthVector()
	Declare Sub ComputeMass()
	Declare Sub ComputeReducedMass()
	Declare Sub ComputestateVectors()
	
	'' Get
	Declare Const Function GetLength()             As Single
	Declare Const Function GetLengthVector()       As Vec2
	Declare Const Function GetParticleA()          As LinearState Ptr
	Declare Const Function GetParticleB()          As LinearState Ptr
	Declare Const Function GetPrevAngularImpulse() As Single
	Declare Const Function GetPrevLinearImpulse()  As Vec2 
	Declare Const Function GetReducedMass()        As Single
	
	''	Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	'' Set
	Declare Sub SetParticleA          ( ByVal A As LinearState Ptr )
	Declare Sub SetParticleB          ( ByVal B As LinearState Ptr )
	Declare Sub SetPosition           ( ByVal p As Vec2 )
	Declare Sub SetPrevAngularImpulse ( ByVal i As Single )
	Declare Sub SetPrevLinearImpulse  ( ByVal i As Vec2 )
	Declare Sub SetVelocity           ( ByVal v As Vec2 )
	
	Protected: 
	
	As Single Length_
	As Vec2   LengthVector_
	As Single ReducedMass_
	
	As Vec2   PrevLinearImpulse_
	As Single PrevAngularImpulse_
	
	As LinearState Ptr ParticleA_
	As LinearState Ptr ParticleB_
	
End Type


'' Constructors
Constructor LinearLink()
	
	ResetAll()
	
End Constructor
	
Constructor LinearLink( ByRef L As LinearLink )
	
	ResetAll()
	
	This = L
	
End Constructor
	
Constructor LinearLink( ByVal A As LinearState Ptr, _
	                     ByVal B As LinearState Ptr )
	
	ResetAll()
	
	If ( A <> B ) Then
		
		ParticleA_ = A
		ParticleB_ = B
		
	Else
		
		ParticleA_ = 0
		ParticleB_ = 0
		
	EndIf
	
	ComputeMass()
	ComputestateVectors()
	ComputeLengths()
	
	RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
End Constructor


'' Destructor
Destructor LinearLink()

End Destructor


'' Operators
Operator LinearLink.Let( ByRef l As LinearLink )
	
	If ( @This <> @l ) Then
		
		Length_          = l.Length_
		LengthVector_    = l.LengthVector_
		ReducedMass_     = l.ReducedMass_
		ParticleA_       = l.ParticleA_
		ParticleB_       = l.ParticleB_
		
		Cast( AngularState, This ) = l
		
	End If 
	
End Operator


'' Add
Sub LinearLink.AddAngle( ByVal a As Single )
	
End Sub

Sub LinearLink.AddAngleVector( ByVal a As Vec2 )
	
End Sub

Sub LinearLink.AddAngularImpulse( ByVal a As Single )
	
	AngularImpulse_ += a
	
	Dim As Vec2 LocalPositionA = GetPosition - ParticleA_->GetPosition
	Dim As Vec2 LocalPositionB = GetPosition - ParticleB_->GetPosition
	
	Dim As Vec2 LocalImpulseA = LocalPositionA.PerpDot( a )
	Dim As Vec2 LocalImpulseB = LocalPositionB.PerpDot( a )
	
	ParticleA_->addImpulse( LocalImpulseA )
	ParticleB_->addImpulse( LocalImpulseB )
	
End Sub

Sub LinearLink.AddAngularVelocity( ByVal a As Single )
	
End Sub

Sub LinearLink.AddImpulse( ByVal i As Vec2 )
	
	Base.AddImpulse( i )
	
	ParticleA_->AddImpulse( i )
	ParticleB_->AddImpulse( i )
	
End Sub

Sub LinearLink.AddVelocity( ByVal v As Vec2 )
	
	ParticleA_->AddVelocity( v )
	ParticleB_->AddVelocity( v )
	
	ComputestateVectors()
	
End Sub

Sub LinearLink.AddPosition( ByVal p As Vec2 )
	
	ParticleA_->AddPosition( p )
	ParticleB_->AddPosition( p )
	
	ComputestateVectors()
	
End Sub


'' Apply
Sub LinearLink.ApplyImpulseDistribution( ByVal c As Single )
	
	''
	''
	''
	
	''
	Dim As Vec2 localPositionA = GetPosition - GetParticleA->GetPosition
	Dim As Vec2 localPositionB = GetPosition - GetParticleB->GetPosition
	
	''
	Dim As Vec2 LocalMomentumA = GetParticleA->GetImpulse * GetParticleA->GetMass' * c
	Dim As Vec2 LocalMomentumB = GetParticleB->GetImpulse * GetParticleB->GetMass' * c
	
	''
	Dim As Vec2 LocalLinearMomentum = LocalMomentumA + LocalMomentumB 
	
	Dim As Single LocalAngularMomentum = localPositionA.PerpDot( LocalMomentumA ) + _
	                                     localPositionB.PerpDot( LocalMomentumB )
	
	''
	'ParticleA_->Impulse( Vec2( 0.0, 0.0 ) )
	'ParticleB_->Impulse( Vec2( 0.0, 0.0 ) )
	
	''
	AddImpulse( LocalLinearMomentum * GetInverseMass - PrevLinearImpulse_ )
	AddAngularImpulse( LocalAngularMomentum * GetInverseInertia - PrevAngularImpulse_ )
	
	'''
	GetParticleA->SetImpulse( GetImpulse + localPositionA.PerpDot( GetAngularImpulse ) )
	GetParticleB->SetImpulse( GetImpulse + localPositionB.PerpDot( GetAngularImpulse ) )
	''ParticleA_->AddImpulse( Impulse + localPositionA.PerpDot( AngularImpulse ) )
	''ParticleB_->AddImpulse( Impulse + localPositionB.PerpDot( AngularImpulse ) )
	'
	''
	SetPrevLinearImpulse( GetImpulse )
	SetPrevAngularImpulse( GetAngularImpulse )
	
End Sub


'' Compute
Sub LinearLink.ComputeAngularVelocity()
	
	Dim As Vec2 localPositionA = GetPosition - GetParticleA->GetPosition
	Dim As Vec2 localPositionB = GetPosition - GetParticleB->GetPosition
	
	Dim As Vec2 localVelocityA = GetVelocity - GetParticleA->GetVelocity
	Dim As Vec2 localVelocityB = GetVelocity - GetParticleB->GetVelocity
	
	AngularVelocity_ = ( localPositionA.PerpDot( localVelocityA * GetParticleA->GetMass ) + _
	                     localPositionB.PerpDot( localVelocityB * GetParticleB->GetMass ) ) * _
	                     GetInverseInertia
	
End Sub

Sub LinearLink.ComputeInertia()
	
	Dim As Vec2 localPositionA = GetPosition - GetParticleA->GetPosition
	Dim As Vec2 localPositionB = GetPosition - GetParticleB->GetPosition
	
	Inertia_ = localPositionA.LengthSquared() * GetParticleA->GetMass + _
	           localPositionB.LengthSquared() * GetParticleB->GetMass
	
	ComputeInverseInertia()
	
End Sub

Sub LinearLink.computeAngleVector()
	
	AngleVector_ = LengthVector_.Unit()
	
End Sub

Sub LinearLink.computeLengths()
	
	ComputeLengthVector()
	ComputeAngleVector()
	ComputeLength()
	
End Sub

Sub LinearLink.computeLength()
	
	'Length_ = LengthVector_.Length()
	Length_ = LengthVector_.Dot( AngleVector_ )
	
End Sub

Sub LinearLink.computeLengthVector()
	
	LengthVector_ = GetParticleB->GetPosition - GetParticleA->GetPosition
	
End Sub

Sub LinearLink.computeMass()
	
	Mass_ = ParticleA_->GetMass + ParticleB_->GetMass
	
	ComputeInverseMass()
	ComputeReducedMass()
	
End Sub

Sub LinearLink.computeReducedMass()
	
	Dim As Single im = ParticleA_->GetInverseMass + ParticleB_->GetInverseMass
	
	ReducedMass_ = IIf( im > 0.0 , 1.0 / im , 0.0 )
	
End Sub

Sub LinearLink.computeStateVectors()
	
	Position_ = ( ParticleA_->GetPosition * ParticleA_->GetMass + _
	              ParticleB_->GetPosition * ParticleB_->GetMass ) * InverseMass_
	
	Velocity_ = ( ParticleA_->GetVelocity * ParticleA_->GetMass + _
	              ParticleB_->GetVelocity * ParticleB_->GetMass ) * InverseMass_
	
End Sub


'' Get
Function LinearLink.GetLength() As Single
	
	Return Length_
	
End Function

Function LinearLink.GetLengthVector() As Vec2
	
	Return LengthVector_
	
End Function

Function LinearLink.GetParticleA() As LinearState Ptr
	
	Return ParticleA_
	
End Function

Function LinearLink.GetParticleB() As LinearState Ptr
	
	Return ParticleB_
	
End Function

Function LinearLink.GetPrevAngularImpulse() As Single
	
	Return PrevAngularImpulse_
	
End Function

Function LinearLink.GetPrevLinearImpulse()  As Vec2 
	
	Return PrevLinearImpulse_
	
End Function

Function LinearLink.GetReducedMass() As Single
	
	Return ReducedMass_
	
End Function


''	Reset
Sub LinearLink.ResetAll()
	
	ParticleA_ = 0
	ParticleB_ = 0
	
	ResetVariables()
	
End Sub

Sub LinearLink.ResetVariables()
	
	Length_       = 0.0
	LengthVector_ = Vec2( 0.0, 0.0 )
	ReducedMass_  = 0.0
	
	Base.ResetAll()
	
End Sub


'' Set
Sub LinearLink.SetParticleA( ByVal A As LinearState Ptr )
	
	ParticleA_ = IIf( A <> ParticleB_ , A , 0 )
	
End Sub

Sub LinearLink.SetParticleB( ByVal B As LinearState Ptr )
	
	ParticleB_ = IIf( B <> ParticleA_ , B , 0 )
	
End Sub

Sub LinearLink.SetPrevAngularImpulse( ByVal i As Single )
	
	PrevAngularImpulse_ = i
	
End Sub

Sub LinearLink.SetPrevLinearImpulse( ByVal i As Vec2 )
	
	PrevLinearImpulse_ = i
	
End Sub

Sub LinearLink.SetPosition( ByVal p As Vec2 )
	
	ParticleA_->AddPosition( p - Position_ )
	ParticleB_->AddPosition( p - Position_ )
	
	'ComputestateVectors()
	
End Sub

Sub LinearLink.SetVelocity( ByVal v As Vec2 )
	
	ParticleA_->AddVelocity( v - Velocity_ )
	ParticleB_->AddVelocity( v - Velocity_ )
	
	'ComputestateVectors()
	
End Sub


#EndIf ''__S2_LINEAR_LINK_BI__
