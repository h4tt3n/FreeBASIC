''******************************************************************************
''
''   Squishy2D Linear Spring Class
''   Written in FreeBASIC 1.05
''   version 0.2.0, May 2016, Michael "h4tt3n" Nissen
''
''
''******************************************************************************


'' 
#Ifndef __S2_LINEAR_SPRING_BI__
#Define __S2_LINEAR_SPRING_BI__


''
Type LinearSpring Extends LineSegment
	
	Public:
	
	'' Constructors
	Declare Constructor()
	
	Declare Constructor( ByRef l As LinearSpring )
	
	Declare Constructor( ByVal _stiffnes  As Single, _
	                     ByVal _damping   As Single, _
	                     ByRef _ParticleA As Particle Ptr, _
	                     ByRef _ParticleB As Particle Ptr )
	
	Declare Constructor( ByVal _stiffnes   As Single, _
	                     ByVal _damping    As Single, _
	                     ByVal _restlength As Single, _
	                     ByRef _ParticleA  As Particle Ptr, _
	                     ByRef _ParticleB  As Particle Ptr )
	
	''	Operator
	Declare Operator Let( ByRef l As LinearSpring )
	
	'' Apply
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	
	'' Compute
	Declare Sub ComputeRestImpulse()
	
	'' Get
	Declare Const Function Damping     () As Single
	Declare Const Function RestLength  () As Single
	Declare Const Function Stiffnes    () As Single
	Declare Const Function WarmStart   () As Single
	
	''	Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	'' Set
	Declare Sub Damping    ( ByVal d As Single )
	Declare Sub RestLength ( ByVal r As Single )
	Declare Sub Stiffnes   ( ByVal s As Single )
	Declare Sub WarmStart  ( ByVal w As Single )
	
	Private:
	
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
                          ByRef _Particlea As Particle Ptr, _
                          ByRef _Particleb As Particle Ptr )
	
	ResetAll()
	
'	Base( _Particlea, _Particleb )
	
	Damping   ( _damping )
	Stiffnes  ( _stiffnes )
	ParticleA ( _Particlea )
	ParticleB ( _Particleb )
	
	WarmStart ( C_LINEAR_WARMSTART )
	
	ComputeMass()
	ComputeReducedMass()
	ComputeStateVectors()
	ComputeInertia()
	ComputeAngularVelocity()
	
	ComputeLengths()
	RestLength( Length_ )
	
End Constructor

Constructor LinearSpring( ByVal _stiffnes   As Single, _
                          ByVal _damping    As Single, _
                          ByVal _restlength As Single, _
                          ByRef _Particlea  As Particle Ptr, _
                          ByRef _Particleb  As Particle Ptr )
	
	ResetAll()
	
'	Base( _Particlea, _Particleb )
	
	Damping   ( _damping )
	Stiffnes  ( _stiffnes )
	RestLength( _restlength )
	ParticleA ( _Particlea )
	ParticleB ( _Particleb )
	
	WarmStart ( C_LINEAR_WARMSTART )
	
	ComputeLengths()
	ComputeMass()
	ComputeReducedMass()
	ComputeStateVectors()
	ComputeInertia()
	ComputeAngularVelocity()
	
End Constructor


'' Operators
Operator LinearSpring.Let( ByRef l As LinearSpring )
	
	If ( @This <> @l ) Then
		
		Damping_            = l.Damping_
		AccumulatedImpulse_ = l.AccumulatedImpulse_
		RestLength_         = l.RestLength_
		Stiffnes_           = l.Stiffnes_
		WarmStart_          = l.WarmStart_
		
		Cast( LineSegment, This ) = l
		
	EndIf
	
End Operator


'' Apply
Sub LinearSpring.ApplyCorrectiveImpulse()
	
	Dim As Vec2 delta_impulse = ParticleB_->impulse_ - ParticleA_->impulse_
		
	Dim As Single impulse_error = AngleVector_.Dot( delta_impulse ) - RestImpulse_
	
	Dim As Vec2 corrective_impulse = - impulse_error * AngleVector_ * ReducedMass_
	
	ParticleA_->AddImpulse( -corrective_impulse * ParticleA_->InverseMass )
	ParticleB_->AddImpulse(  corrective_impulse * ParticleB_->InverseMass )
	
	AccumulatedImpulse_ += corrective_impulse
	
End Sub

Sub LinearSpring.ApplyWarmStart()
	
	Dim As Single projected_impulse = AngleVector_.Dot( AccumulatedImpulse_ )
	
	If ( projected_impulse < 0.0 ) Then
		
		Dim As Vec2 warmstart_impulse = Warmstart_ * projected_impulse * AngleVector_
		
		ParticleA_->AddImpulse( -warmstart_impulse * ParticleA_->InverseMass )
		ParticleB_->AddImpulse(  warmstart_impulse * ParticleB_->InverseMass )
		
	End If
	
	AccumulatedImpulse_ = Vec2( 0.0, 0.0 )
	
End Sub


'' Compute
Sub LinearSpring.ComputeRestImpulse()
	
	Dim As Vec2 delta_velocity = ParticleB_->Velocity_ - ParticleA_->Velocity_
	
	Dim As Single position_error = length_ - restLength_
	Dim As Single velocity_error = AngleVector_.dot( delta_velocity )
	
	RestImpulse_ = - Stiffnes_ * position_error * INV_DT - Damping_ * velocity_error
	
End Sub


'' Get
Function LinearSpring.Damping() As Single
	
	Return Damping_
	
End Function

Function LinearSpring.RestLength() As Single
	
	Return RestLength_
	
End Function

Function LinearSpring.Stiffnes() As Single
	
	Return Stiffnes_
	
End Function

Function LinearSpring.WarmStart() As Single
	
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
	RestLength_         = 0.0
	WarmStart_          = 0.0
	
	Base.ResetVariables()
	
End Sub


'' Set
Sub LinearSpring.Damping ( ByVal d As Single )
	
	Damping_ = d
	
End Sub

Sub LinearSpring.RestLength ( ByVal r As Single )
	
	RestLength_ = r
	
End Sub

Sub LinearSpring.Stiffnes ( ByVal s As Single )
	
	Stiffnes_ = s
	
End Sub

Sub LinearSpring.WarmStart ( ByVal w As Single )
	
	WarmStart_ = w
	
End Sub


#EndIf ''__S2_LINEAR_SPRING_BI__
