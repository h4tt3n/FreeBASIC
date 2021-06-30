''******************************************************************************
''   SquishyPlanet - A 2D soft body and space physics library for games
''   Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''   Version 0.7.0, December 2016
''
''   Author:
''   Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''   Description:
''   This spring is really two perpendicular 1D springs which try to keep the 
''   particles at a certain distance in the X and Y plane, respectively.
''   Unlike LinearSpring, the FixedSpring cannot rotate freely but always
''   tries to keep the same orientation.
''   Conserves momentum. Computation is CPU cheap compared to other springs.
''   
''   LinearState -> AngularState -> LinearLink -> FixedSpring
''
''******************************************************************************


''
#Ifndef __S2_FIXED_SPRING_BI__
#Define __S2_FIXED_SPRING_BI__


''
Type FixedSpring Extends LinearLink
	
	Public:
	
	'' Constructors
	Declare Constructor()
	
	Declare Constructor( ByRef f As FixedSpring )
	
	Declare Constructor( ByVal _stiffnes   As Single          = C_FIXED_STIFFNESS, _
	                     ByVal _damping    As Single          = C_FIXED_DAMPING, _
	                     ByVal _warmstart  As Single          = C_FIXED_WARMSTART, _
	                     ByRef _particlea  As LinearState Ptr = 0, _
	                     ByRef _particleb  As LinearState Ptr = 0 )
	
	Declare Constructor( ByVal _stiffnes   As Single          = C_FIXED_STIFFNESS, _
	                     ByVal _damping    As Single          = C_FIXED_DAMPING, _
	                     ByVal _warmstart  As Single          = C_FIXED_WARMSTART, _
	                     ByVal _restlength As Vec2            = Vec2( 0.0, 0.0 ), _
	                     ByRef _particlea  As LinearState Ptr = 0, _
	                     ByRef _particleb  As LinearState Ptr = 0 )
	
	'' Destructor
	Declare Destructor()
	
	'' Operators
	Declare Operator Let( ByRef f As FixedSpring )
	
	'' Apply
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	
	'' Compute
	Declare Sub ComputeRestImpulse()
	
	'' Get
	Declare Const Function GetDamping    () As Single
	Declare Const Function GetRestlength () As Vec2
	Declare Const Function GetStiffnes   () As Single
	Declare Const Function GetWarmstart  () As Single
	
	'' Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	'' Set
	Declare Sub SetDamping    ( ByVal d As Single )
	Declare Sub SetRestLength ( ByVal r As Vec2   )
	Declare Sub SetStiffnes   ( ByVal s As Single )
	Declare Sub SetWarmStart  ( ByVal w As Single )
	
	Protected:
	
	'' Variables
	As Single Damping_
	As Vec2   Impulse_
	As Vec2   RestImpulse_
	As Vec2   RestLength_
	As Single Stiffnes_
	As Single Warmstart_
	
End Type


'' Constructors
Constructor FixedSpring()
	
	ResetAll()
	
End Constructor
	
Constructor FixedSpring( ByRef f As FixedSpring )
	
	ResetAll()
	
	This = f
	
End Constructor

Constructor FixedSpring( ByVal _stiffnes  As Single, _
                         ByVal _damping   As Single, _
                         ByVal _warmstart  As Single, _
                         ByRef _particlea As LinearState Ptr, _
                         ByRef _particleb As LinearState Ptr )
	
	ResetAll()
	
	SetDamping   ( _damping )
	SetStiffnes  ( _stiffnes )
	SetParticleA ( _particlea )
	SetParticleB ( _particleb )
	SetWarmStart ( _warmstart )
	
	
	ComputeMass()
	ComputeLengths()
	ComputestateVectors()
	ComputeInertia()
	ComputeAngularVelocity()
	
	SetRestLength( GetLengthVector )
	
	ComputeReducedMass()
	
	RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
End Constructor

Constructor FixedSpring( ByVal _stiffnes   As Single, _
                         ByVal _damping    As Single, _
                         ByVal _warmstart  As Single, _
                         ByVal _restlength As Vec2, _
                         ByRef _particlea As LinearState Ptr, _
                         ByRef _particleb As LinearState Ptr )
	
	ResetAll()
	
	SetDamping   ( _damping )
	SetStiffnes  ( _stiffnes )
	SetRestLength( _restlength )
	SetParticleA ( _Particlea )
	SetParticleB ( _Particleb )
	SetWarmStart ( _warmstart )
	
	ComputeReducedMass()
	
	RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )

End Constructor


'' Destructor
Destructor FixedSpring()

End Destructor


'' Operators
Operator FixedSpring.Let( ByRef f As FixedSpring )
	
	If ( @This <> @f ) Then
		
		Damping_     = f.Damping_
		Impulse_     = f.Impulse_
		RestImpulse_ = f.RestImpulse_
		RestLength_  = f.RestLength_
		Stiffnes_    = f.Stiffnes_
		WarmStart_   = f.WarmStart_
		
		Cast( LinearLink, This ) = f
		
	EndIf

End Operator


'' Apply
Sub FixedSpring.ApplyCorrectiveImpulse()
	
	Dim As Vec2 impulse_vector = ParticleB_->GetImpulse - ParticleA_->GetImpulse
		
	Dim As Vec2 impulse_error = impulse_vector - RestImpulse_
	
	Dim As Vec2 corrective_impulse = - impulse_error * ReducedMass_
	
	ParticleA_->AddImpulse( -corrective_impulse * ParticleA_->GetInverseMass )
	ParticleB_->AddImpulse(  corrective_impulse * ParticleB_->GetInverseMass )
	
	Impulse_ += corrective_impulse
	
End Sub

Sub FixedSpring.ApplyWarmStart()
	
	Dim As Vec2 projected_impulse = LengthVector_.Project( Impulse_ )
	
	If ( LengthVector_.Dot( projected_impulse ) < 0.0 ) Then
		
		Dim As Vec2 warmstart_impulse = Warmstart_ * projected_impulse
		
		ParticleA_->AddImpulse( -warmstart_impulse * ParticleA_->GetInverseMass )
		ParticleB_->AddImpulse(  warmstart_impulse * ParticleB_->GetInverseMass )
		
	End If
	
	Impulse_ = Vec2( 0.0, 0.0 )
	
End Sub


'' Compute
Sub FixedSpring.ComputeRestImpulse()
	
	Dim As Vec2 distance_error = LengthVector_ - restLength_
	
	Dim As Vec2 velocity_error = ParticleB_->GetVelocity - ParticleA_->GetVelocity
	
	RestImpulse_ = - Stiffnes_ * INV_DT * distance_error - Damping_ * velocity_error
	
End Sub


'' Get
Function FixedSpring.GetDamping() As Single
	
	Return Damping_
	
End Function

Function FixedSpring.GetRestLength() As Vec2
	
	Return RestLength_
	
End Function

Function FixedSpring.GetStiffnes() As Single
	
	Return Stiffnes_
	
End Function

Function FixedSpring.GetWarmstart() As Single
	
	Return Warmstart_
	
End Function


'' Reset
Sub FixedSpring.ResetAll()
	
	ResetVariables()
	
	Base.ResetAll()
	
End Sub

Sub FixedSpring.ResetVariables()
	
	Damping_     = 0.0
	RestLength_  = Vec2( 0.0, 0.0 )
	Stiffnes_    = 0.0
	WarmStart_   = 0.0
	
	Base.ResetVariables()
	
End Sub


'' Set
Sub FixedSpring.SetDamping ( ByVal d As Single )
	
	Damping_ = d
	
End Sub

Sub FixedSpring.SetRestLength ( ByVal r As Vec2 )
	
	RestLength_ = r
	
End Sub

Sub FixedSpring.SetStiffnes ( ByVal s As Single )
	
	Stiffnes_ = s
	
End Sub

Sub FixedSpring.SetWarmStart ( ByVal w As Single )
	
	WarmStart_ = w
	
End Sub


#EndIf ''__S2_FIXED_ANGLE_SPRING_BI__
