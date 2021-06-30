''******************************************************************************
''
''   Squishy2D Fixed Angle Spring Class
''   Written in FreeBASIC 1.04
''   version 0.1.0, November 2015, Michael "h4tt3n" Nissen
''
''   This spring is really two 1D springs which try to keep the particles at a 
''   certain distance in the X and Y plane, respectively.
''   Unlike LinearSpring, the FixedSpring cannot rotate freely but always
''   tries to keep the same orientation.
''   Conserves momentum. Computation is CPU cheap.
''   
''
''******************************************************************************


''
#Ifndef __S2_FIXED_SPRING_BI__
#Define __S2_FIXED_SPRING_BI__


''
Type FixedSpring Extends LineSegment
	
	Public:
	
	'' Constructors
	Declare Constructor()
	
	Declare Constructor( ByRef f As FixedSpring )
	
	Declare Constructor( ByVal _stiffnes   As Single, _
	                     ByVal _damping    As Single, _
	                     ByRef _particlea  As Particle Ptr, _
	                     ByRef _particleb  As Particle Ptr )
	
	Declare Constructor( ByVal _stiffnes   As Single, _
	                     ByVal _damping    As Single, _
	                     ByVal _restlength As Vec2, _
	                     ByRef _particlea  As Particle Ptr, _
	                     ByRef _particleb  As Particle Ptr )
	
	'' Operators
	Declare Operator Let( ByRef f As FixedSpring )
	
	'' Apply
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	
	'' Compute
	Declare Sub ComputeReducedMass()
	Declare Sub ComputeRestImpulse()
	
	'' Get
	Declare Const Function Damping    () As Single
	Declare Const Function ReducedMass() As Single
	Declare Const Function Restlength () As Vec2
	Declare Const Function Stiffnes   () As Single
	Declare Const Function Warmstart  () As Single
	
	'' Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	'' Set
	Declare Sub Damping    ( ByVal d As Single )
	Declare Sub RestLength ( ByVal r As Vec2   )
	Declare Sub Stiffnes   ( ByVal s As Single )
	Declare Sub WarmStart  ( ByVal w As Single )
	
	Private:
	
	'' Variables
	As Single Damping_
	As Vec2   Impulse_
	As Single ReducedMass_
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
                         ByRef _particlea As Particle Ptr, _
                         ByRef _particleb As Particle Ptr )
	
	ResetAll()
	
	Damping   ( _damping )
	Stiffnes  ( _stiffnes )
	ParticleA ( _particlea )
	ParticleB ( _particleb )
	
	WarmStart ( COEFF_WARMSTART )
	
	ComputeLengthVector()
	
	RestLength( LengthVector )
	
	ComputeReducedMass()
	
End Constructor

Constructor FixedSpring( ByVal _stiffnes   As Single, _
                         ByVal _damping    As Single, _
                         ByVal _restlength As Vec2, _
                         ByRef _particlea As Particle Ptr, _
                         ByRef _particleb As Particle Ptr )
	
	ResetAll()
	
	Damping   ( _damping )
	Stiffnes  ( _stiffnes )
	RestLength( _restlength )
	ParticleA ( _Particlea )
	ParticleB ( _Particleb )
	
	WarmStart ( COEFF_WARMSTART )
	
	ComputeReducedMass()

End Constructor


'' Operators
Operator FixedSpring.Let( ByRef f As FixedSpring )
	
	ResetAll()
	
	Damping_     = f.Damping_
	Impulse_     = f.Impulse_
	ReducedMass_ = f.ReducedMass_
	RestImpulse_ = f.RestImpulse_
	RestLength_  = f.RestLength_
	Stiffnes_    = f.Stiffnes_
	WarmStart_   = f.WarmStart_
	
	Cast( LineSegment, This ) = f

End Operator


'' Apply
Sub FixedSpring.ApplyCorrectiveImpulse()
	
	Dim As Vec2 impulse_vector = ParticleB_->Impulse - ParticleA_->Impulse
		
	Dim As Vec2 impulse_error = impulse_vector - RestImpulse_
	
	Dim As Vec2 corrective_impulse = - impulse_error * ReducedMass_
	
	ParticleA_->AddImpulse( -corrective_impulse * ParticleA_->InverseMass )
	ParticleB_->AddImpulse(  corrective_impulse * ParticleB_->InverseMass )
	
	Impulse_ += corrective_impulse
	
End Sub

Sub FixedSpring.ApplyWarmStart()
	
	Dim As Vec2 projected_impulse = LengthVector_.Project( Impulse_ )
	
	If ( projected_impulse < Vec2( 0.0, 0.0 ) ) Then
		
		Dim As Vec2 warmstart_impulse = Warmstart_ * projected_impulse
		
		ParticleA_->AddImpulse( -warmstart_impulse * ParticleA_->InverseMass )
		ParticleB_->AddImpulse(  warmstart_impulse * ParticleB_->InverseMass )
		
		Impulse_ = warmstart_impulse
		
	Else
		
		Impulse_ = Vec2( 0.0, 0.0 )
		
	End If
	
End Sub


'' Compute
Sub FixedSpring.computeRestImpulse()
	
	Dim As Vec2 distance_error = LengthVector_ - restLength_
	
	Dim As Vec2 velocity_error = ParticleB_->Velocity - ParticleA_->Velocity
	
	RestImpulse_ = -Stiffnes_ * INV_DT * distance_error - Damping_ * velocity_error
	
End Sub

Sub FixedSpring.ComputeReducedMass()
	
	Dim As Single im = ParticleA_->InverseMass + ParticleB_->InverseMass
	
	ReducedMass_ = IIf( im > 0.0 , 1.0 / im , 0.0 )
	
End Sub


'' Get
Function FixedSpring.Damping() As Single
	
	Return Damping_
	
End Function

Function FixedSpring.ReducedMass() As Single
	
	Return ReducedMass_
	
End Function

Function FixedSpring.RestLength() As Vec2
	
	Return RestLength_
	
End Function

Function FixedSpring.Stiffnes() As Single
	
	Return Stiffnes_
	
End Function

Function FixedSpring.Warmstart() As Single
	
	Return Warmstart_
	
End Function


'' Reset
Sub FixedSpring.ResetAll()
	
	ResetVariables()
	
	Base.ResetAll()
	
End Sub

Sub FixedSpring.ResetVariables()
	
	Damping_     = 0.0
	ReducedMass_ = 0.0
	RestLength_  = Vec2( 0.0, 0.0 )
	Stiffnes_    = 0.0
	WarmStart_   = 0.0
	
	Base.ResetVariables()
	
End Sub


'' Set
Sub FixedSpring.Damping ( ByVal d As Single )
	
	Damping_ = d
	
End Sub

Sub FixedSpring.RestLength ( ByVal r As Vec2 )
	
	RestLength_ = r
	
End Sub

Sub FixedSpring.Stiffnes ( ByVal s As Single )
	
	Stiffnes_ = s
	
End Sub

Sub FixedSpring.WarmStart ( ByVal w As Single )
	
	WarmStart_ = w
	
End Sub


#EndIf ''__S2_FIXED_ANGLE_SPRING_BI__
