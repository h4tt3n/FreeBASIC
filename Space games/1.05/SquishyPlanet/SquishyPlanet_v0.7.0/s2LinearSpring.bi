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
''   This is a Hooke's law of elasticity damped spring. It is heavily improved
''   for increased stability and stiffness. It uses sequential impulses and 
''   warmstarting.
''
''   LinearState -> AngularState -> LinearLink -> LinearSpring
''
''******************************************************************************


'' 
#Ifndef __S2_LINEAR_SPRING_BI__
#Define __S2_LINEAR_SPRING_BI__


''
Type LinearSpring Extends LinearLink
	
	Public:
	
	'' Constructors
	Declare Constructor()
	
	Declare Constructor( ByRef l As LinearSpring )
	
	Declare Constructor( ByVal _stiffnes  As Single          = C_LINEAR_STIFFNESS, _
	                     ByVal _damping   As Single          = C_LINEAR_DAMPING, _
	                     ByVal _warmstart As Single          = C_LINEAR_WARMSTART, _
	                     ByRef _ParticleA As LinearState Ptr = 0, _
	                     ByRef _ParticleB As LinearState Ptr = 0 )
	
	Declare Constructor( ByVal _stiffnes   As Single          = C_LINEAR_STIFFNESS, _
	                     ByVal _damping    As Single          = C_LINEAR_DAMPING, _
	                     ByVal _warmstart  As Single          = C_LINEAR_WARMSTART, _
	                     ByVal _restlength As Single          = 0.0, _
	                     ByRef _ParticleA  As LinearState Ptr = 0, _
	                     ByRef _ParticleB  As LinearState Ptr = 0 )
	
	'' Destructor
	Declare Destructor()
	
	''	Operator
	Declare Operator Let( ByRef l As LinearSpring )
	
	'' Apply
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	
	'' Compute
	Declare Sub ComputeRestImpulse()
	
	'' Get
	Declare Const Function GetDamping    () As Single
	Declare Const Function GetRestLength () As Single
	Declare Const Function GetStiffnes   () As Single
	Declare Const Function GetWarmStart  () As Single
	
	''	Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	'' Set
	Declare Sub SetDamping    ( ByVal d As Single )
	Declare Sub SetRestLength ( ByVal r As Single )
	Declare Sub SetStiffnes   ( ByVal s As Single )
	Declare Sub SetWarmStart  ( ByVal w As Single )
	
	Protected:
	
	''	Variables
	As Single Damping_
	As Vec2   AccumulatedImpulse_
	As Single RestImpulse_
	As Single RestLength_
	As Single Stiffnes_
	As Single Warmstart_
	
End Type


'' Constructors
Constructor LinearSpring()
	
	ResetAll()
	
End Constructor

Constructor LinearSpring( ByRef l As LinearSpring )
	
	ResetAll()
	
	This = l
	
End Constructor

Constructor LinearSpring( ByVal _stiffnes  As Single, _
                          ByVal _damping   As Single, _
                          ByVal _warmstart As Single, _
                          ByRef _Particlea As LinearState Ptr, _
                          ByRef _Particleb As LinearState Ptr )
	
	ResetAll()
	
	SetDamping   ( _damping )
	SetStiffnes  ( _stiffnes )
	SetWarmStart ( _warmstart )
	SetParticleA ( _Particlea )
	SetParticleB ( _Particleb )
	
	ComputeMass()
	ComputeLengths()
	ComputestateVectors()
	ComputeInertia()
	ComputeAngularVelocity()
	
	SetRestLength( Length_ )
	
	RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
End Constructor

Constructor LinearSpring( ByVal _stiffnes   As Single, _
                          ByVal _damping    As Single, _
                          ByVal _warmstart  As Single, _
                          ByVal _restlength As Single, _
                          ByRef _Particlea  As LinearState Ptr, _
                          ByRef _Particleb  As LinearState Ptr )
	
	ResetAll()
	
	SetDamping   ( _damping )
	SetStiffnes  ( _stiffnes )
	SetWarmStart ( _warmstart )
	SetRestLength( _restlength )
	SetParticleA ( _Particlea )
	SetParticleB ( _Particleb )
	
	ComputeMass()
	ComputeLengths()
	ComputestateVectors()
	ComputeInertia()
	ComputeAngularVelocity()
	
	RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
End Constructor


'' Destructor
Destructor LinearSpring()

End Destructor


'' Operators
Operator LinearSpring.Let( ByRef l As LinearSpring )
	
	If ( @This <> @l ) Then
		
		AccumulatedImpulse_ = l.AccumulatedImpulse_
		Damping_            = l.Damping_
		RestImpulse_        = l.RestImpulse_
		RestLength_         = l.RestLength_
		Stiffnes_           = l.Stiffnes_
		WarmStart_          = l.WarmStart_
		
		Cast( LinearLink, This ) = l
		
	EndIf
	
End Operator


'' Apply
Sub LinearSpring.ApplyCorrectiveImpulse()
	
	Dim As Vec2 delta_impulse = ParticleB_->impulse_ - ParticleA_->impulse_
		
	Dim As Single impulse_error = AngleVector_.Dot( delta_impulse ) - RestImpulse_
	
	Dim As Vec2 corrective_impulse = - impulse_error * AngleVector_ * ReducedMass_
	
	ParticleA_->AddImpulse( -corrective_impulse * ParticleA_->GetInverseMass )
	ParticleB_->AddImpulse(  corrective_impulse * ParticleB_->GetInverseMass )
	
	AccumulatedImpulse_ += corrective_impulse
	
End Sub

Sub LinearSpring.ApplyWarmStart()
	
	Dim As Single projected_impulse = AngleVector_.Dot( AccumulatedImpulse_ )
	
	If ( projected_impulse < 0.0 ) Then
		
		Dim As Vec2 warmstart_impulse = Warmstart_ * projected_impulse * AngleVector_
		
		ParticleA_->AddImpulse( -warmstart_impulse * ParticleA_->GetInverseMass )
		ParticleB_->AddImpulse(  warmstart_impulse * ParticleB_->GetInverseMass )
		
	End If
	
	AccumulatedImpulse_ = Vec2( 0.0, 0.0 )
	
End Sub


'' Compute
Sub LinearSpring.ComputeRestImpulse()
	
	Dim As Vec2 delta_velocity = ParticleB_->Velocity_ - ParticleA_->Velocity_
	
	Dim As Single position_error = length_ - restLength_
	Dim As Single velocity_error = AngleVector_.Dot( delta_velocity )
	
	RestImpulse_ = - Stiffnes_ * position_error * INV_DT - Damping_ * velocity_error
	
End Sub


'' Get
Function LinearSpring.GetDamping() As Single
	
	Return Damping_
	
End Function

Function LinearSpring.GetRestLength() As Single
	
	Return RestLength_
	
End Function

Function LinearSpring.GetStiffnes() As Single
	
	Return Stiffnes_
	
End Function

Function LinearSpring.GetWarmStart() As Single
	
	Return WarmStart_
	
End Function


''	Reset
Sub LinearSpring.ResetAll()
	
	ResetVariables()
	
	Base.ResetAll()
	
End Sub

Sub LinearSpring.ResetVariables()
	
	Damping_            = 0.0
	AccumulatedImpulse_ = Vec2( 0.0, 0.0 )
	RestImpulse_        = 0.0
	RestLength_         = 0.0
	Stiffnes_           = 0.0
	WarmStart_          = 0.0
	
	Base.ResetVariables()
	
End Sub


'' Set
Sub LinearSpring.SetDamping ( ByVal d As Single )
	
	Damping_ = d
	
End Sub

Sub LinearSpring.SetRestLength ( ByVal r As Single )
	
	RestLength_ = r
	
End Sub

Sub LinearSpring.SetStiffnes ( ByVal s As Single )
	
	Stiffnes_ = s
	
End Sub

Sub LinearSpring.SetWarmStart ( ByVal w As Single )
	
	WarmStart_ = w
	
End Sub


#EndIf ''__S2_LINEAR_SPRING_BI__
