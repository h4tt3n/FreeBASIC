''******************************************************************************
''
''   Squishy2D Angular Spring Class
''   Written in FreeBASIC 1.04
''   version 0.1.0, November 2015, Michael "h4tt3n" Nissen
''
''******************************************************************************


''
#Ifndef __S2_ANGULAR_SPRING_BI__
#Define __S2_ANGULAR_SPRING_BI__


''
Type AngularSpring
	
	Public:
	
	''	Constructors
	Declare Constructor()
	
	Declare Constructor( ByRef a As AngularSpring )
	
	Declare Constructor( ByVal _stiffnes As Single,     _
	                     ByVal _damping  As Single,     _
	                     ByRef _rotatea  As Rotate Ptr, _
	                     ByRef _rotateb  As Rotate Ptr )
	
	Declare Constructor( ByVal _stiffnes        As Single,     _
	                     ByVal _damping         As Single,     _
	                     ByVal _restanglevector As Vec2,       _
	                     ByRef _rotatea         As Rotate Ptr, _
	                     ByRef _rotateb         As Rotate Ptr )
	
	Declare Constructor( ByVal _stiffnes  As Single,     _
	                     ByVal _damping   As Single,     _
	                     ByVal _restangle As Single,     _
	                     ByRef _rotatea   As Rotate Ptr, _
	                     ByRef _rotateb   As Rotate Ptr )
	
	''	Operators
	Declare Operator Let( ByRef a As AngularSpring )
	
	'' Apply
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	
	'' Compute
	Declare Sub ComputeAngle()
	Declare Sub ComputeAngleVector()
	Declare Sub ComputeReducedInertia()
	Declare Sub ComputeRestImpulse()
	
	'' Get
	Declare Const Function Damping         () As Single
	Declare Const Function RotateA         () As Rotate Ptr
	Declare Const Function RotateB         () As Rotate Ptr
	Declare Const Function ReducedInertia  () As Single
	Declare Const Function RestAngle       () As Single
	Declare Const Function RestAngleVector () As Vec2
	Declare Const Function Stiffnes        () As Single
	Declare Const Function Warmstart       () As Single
	
	'' Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	'' Set
	Declare Sub Damping         ( ByVal d As Single )
	Declare Sub RotateA         ( ByRef r As Rotate Ptr )
	Declare Sub RotateB         ( ByRef r As Rotate Ptr )
	Declare Sub RestAngle       ( ByVal r As Single )
	Declare Sub RestAngleVector ( ByVal r As Vec2 )
	Declare Sub Stiffnes        ( ByVal s As Single )
	Declare Sub Warmstart       ( ByVal w As Single )
	
	' Private:
	
	'' Variables
	As Single AccumulatedImpulse_
	As Single AngularImpulse_
	As Single Damping_
	As Single ReducedInertia_
	As Single RestAngle_
	As Single RestImpulse_
	As Vec2   AngleVector_
	As Vec2   RestAngleVector_
	As Single Stiffnes_
	As Single Warmstart_
	
	'' Rotate Ptrs
	As Rotate Ptr RotateA_
	As Rotate Ptr RotateB_
	
End Type


''	Constructors
Constructor AngularSpring()
	
	ResetAll()
	
End Constructor

Constructor AngularSpring( ByRef a As AngularSpring )
	
	ResetAll()
	
	This = a
	
End Constructor

Constructor AngularSpring( ByVal _stiffnes As Single,     _
                           ByVal _damping  As Single,     _
                           ByRef _Rotatea  As Rotate Ptr, _
                           ByRef _Rotateb  As Rotate Ptr )
	
	ResetAll()
		
	RotateA  ( _Rotatea )
	RotateB  ( _Rotateb )
	Damping  ( _damping )
	Stiffnes ( _stiffnes )
	
	WarmStart ( COEFF_WARMSTART )
	
	ComputeAngleVector()
	
	RestAngleVector_ = AngleVector_
	
End Constructor

Constructor AngularSpring( ByVal _stiffnes        As Single,     _
                           ByVal _damping         As Single,     _
                           ByVal _restAngleVector As Vec2,       _
                           ByRef _Rotatea         As Rotate Ptr, _
                           ByRef _Rotateb         As Rotate Ptr )
	
	ResetAll()
	
	RotateA         ( _Rotatea )
	RotateB         ( _Rotateb )
	Damping         ( _damping )
	Stiffnes        ( _stiffnes )
	RestAngleVector ( _restanglevector )
	
	WarmStart ( COEFF_WARMSTART )
	
End Constructor

Constructor AngularSpring( ByVal _stiffnes  As Single,     _
                           ByVal _damping   As Single,     _
                           ByVal _restangle As Single,     _
                           ByRef _Rotatea   As Rotate Ptr, _
                           ByRef _Rotateb   As Rotate Ptr )
	
	ResetAll()
	
	RotateA   ( _Rotatea )
	RotateB   ( _Rotateb )
	Damping   ( _damping )
	Stiffnes  ( _stiffnes )
	RestAngle ( _restangle )
	
	WarmStart ( COEFF_WARMSTART )
	
End Constructor


'' Operators
Operator AngularSpring.Let( ByRef a As AngularSpring )
	
	AccumulatedImpulse_ = a.AccumulatedImpulse_
	AngularImpulse_     = a.AngularImpulse_
	Damping_            = a.Damping_
	ReducedInertia_     = a.ReducedInertia_
	RestAngle_          = a.RestAngle_
	RestAngleVector_    = a.RestAngleVector_
	RestImpulse_        = a.RestImpulse_
	RotateA_            = a.RotateA_
	RotateB_            = a.RotateB_
	Stiffnes_           = a.Stiffnes_
	Warmstart_          = a.Warmstart_
	
End Operator


'' Apply
Sub AngularSpring.ApplyCorrectiveImpulse()
	
	Dim As Single delta_impulse = RotateB_->AngularImpulse - RotateA_->AngularImpulse
		
	Dim As Single impulse_error = delta_impulse - RestImpulse_
	
	Dim As Single corrective_impulse = - impulse_error * ReducedInertia_
	
	RotateA_->AddAngularImpulse( -corrective_impulse * RotateA_->InverseInertia )
	RotateB_->AddAngularImpulse(  corrective_impulse * RotateB_->InverseInertia )
	
	AccumulatedImpulse_ += corrective_impulse
	
End Sub

Sub AngularSpring.ApplyWarmStart()
	
	Dim As Single warmstart_impulse = Warmstart_ * AccumulatedImpulse_
	
	RotateA_->AddAngularImpulse( -warmstart_impulse * RotateA_->InverseInertia )
	RotateB_->AddAngularImpulse(  warmstart_impulse * RotateB_->InverseInertia )
	
	AccumulatedImpulse_ = 0.0
	'AccumulatedImpulse_ = warmstart_impulse
	
End Sub


''	Compute
Sub AngularSpring.computeAngleVector()
	
	AngleVector_ = Vec2( RotateA_->AngleVector.Dot    ( RotateB_->AngleVector ), _
								RotateA_->AngleVector.PerpDot( RotateB_->AngleVector ) )
	
	'AngleVector_ = Vec2( Cos( Angle_ ), Sin( Angle_ ) )
	
End Sub

Sub AngularSpring.computeReducedInertia()
	
	Dim As Single ii = RotateA_->InverseInertia + RotateB_->InverseInertia
	
	ReducedInertia_ = IIf( ii > 0.0 , 1.0 / ii , 0.0 )
	
End Sub

Sub AngularSpring.computeRestImpulse()
	
	'Dim As Single delta_angle = RotateB_->Angle - RotateA_->Angle
	
	'Dim As Single angle_error = delta_angle - restAngle_
	
	Dim As Single angle_error = RestAngleVector_.PerpDot( AngleVector_ )
	
	Dim As Single velocity_error = RotateB_->AngularVelocity - RotateA_->AngularVelocity
	
	RestImpulse_ = - stiffnes_ * INV_DT * angle_error - damping_ * velocity_error
	
End Sub


'' Get
Function AngularSpring.Damping() As Single
	
	Return Damping_
	
End Function

Function AngularSpring.ReducedInertia() As Single
	
	Return ReducedInertia_
	
End Function

Function AngularSpring.RestAngle() As Single
	
	Return RestAngle_
	
End Function

Function AngularSpring.RestAngleVector() As Vec2
	
	Return RestAngleVector_
	
End Function

Function AngularSpring.RotateA() As Rotate Ptr
	
	Return RotateA_
	
End Function

Function AngularSpring.RotateB() As Rotate Ptr
	
	Return RotateB_
	
End Function

Function AngularSpring.Stiffnes() As Single
	
	Return Stiffnes_
	
End Function

Function AngularSpring.Warmstart() As Single
	
	Return Warmstart_
	
End Function


'' Reset
Sub AngularSpring.ResetAll()
	
	RotateA_ = 0
	RotateB_ = 0
	
	ResetVariables()
	
End Sub

Sub AngularSpring.ResetVariables()
	
	AccumulatedImpulse_ = 0.0
	AngularImpulse_     = 0.0
	Damping_            = 0.0
	ReducedInertia_     = 0.0
	RestAngle_          = 0.0
	RestAngleVector_    = Vec2( 0.0, 0.0 )
	RestImpulse_        = 0.0
	Stiffnes_           = 0.0
	Warmstart_          = 0.0
	
End Sub


'' Set
Sub AngularSpring.Damping ( ByVal d As Single )
	
	Damping_ = d
	
End Sub

Sub AngularSpring.RestAngle ( ByVal r As Single )
	
	RestAngle_ = r
	
End Sub

Sub AngularSpring.RestAngleVector ( ByVal r As Vec2 )
	
	RestAngleVector_ = r
	
End Sub

Sub AngularSpring.RotateA ( ByRef r As Rotate Ptr )
	
	RotateA_ = IIf( r <> RotateB_ , r , 0 )
	
End Sub

Sub AngularSpring.RotateB ( ByRef r As Rotate Ptr )
	
	RotateB_ = IIf( r <> RotateA_ , r , 0 )
	
End Sub

Sub AngularSpring.Stiffnes ( ByVal s As Single )
	
	Stiffnes_ = s
	
End Sub

Sub AngularSpring.Warmstart ( ByVal w As Single )
	
	Warmstart_ = w
	
End Sub


#EndIf ''__S2_ANGULAR_SPRING_BI__
