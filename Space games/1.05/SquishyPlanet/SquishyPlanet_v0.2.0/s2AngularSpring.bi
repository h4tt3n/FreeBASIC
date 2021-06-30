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
	
	
	
	'' Compute
	Declare Sub ComputeAngle           ()
	Declare Sub ComputeAngleVector     ()
	Declare Sub ComputeAngularVelocity ()
	Declare Sub ComputeReducedInertia  ()
	Declare Sub ComputeTorque          ()
	
	'' Get
	Declare Const Function Angle           () As Single
	Declare Const Function AngleVector     () As Vec2
	Declare Const Function AngularVelocity () As Single
	Declare Const Function Damping         () As Single
	Declare Const Function RotateA         () As Rotate Ptr
	Declare Const Function RotateB         () As Rotate Ptr
	Declare Const Function ReducedInertia  () As Single
	Declare Const Function RestAngle       () As Single
	Declare Const Function RestAngleVector () As Vec2
	Declare Const Function Stiffnes        () As Single
	
	'' Reset
	Declare Sub ResetAll       ()
	Declare Sub ResetVariables ()
	
	'' Set
	Declare Sub Damping         ( ByVal d As Single     )
	Declare Sub RotateA         ( ByRef r As Rotate Ptr )
	Declare Sub RotateB         ( ByRef r As Rotate Ptr )
	Declare Sub RestAngle       ( ByVal r As Single     )
	Declare Sub RestAngleVector ( ByVal r As Vec2       )
	Declare Sub Stiffnes        ( ByVal s As Single     )
	
	Private:
	
	'' Variables
	As Single Corrective_
	As Single AccumulatedImpulse_
	As Single Angle_
	As Vec2   AngleVector_
	As Single AngularImpulse_
	As Single AngularVelocity_
	As Single Damping_
	As Single ReducedInertia_
	As Single RestAngle_
	As Single RestImpulse_
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
	
	ComputeAngleVector()
	
	RestAngleVector( AngleVector() )
	
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
	
End Constructor


'' Operators
Operator AngularSpring.Let( ByRef a As AngularSpring )
	
	Angle_           = a.Angle_
	AngleVector_     = a.AngleVector_
	AngularVelocity_ = a.AngularVelocity_
	RotateA_         = a.RotateA_
	RotateB_         = a.RotateB_
	Damping_         = a.Damping_
	ReducedInertia_  = a.ReducedInertia_
	RestAngle_       = a.RestAngle_
	RestAngleVector_ = a.RestAngleVector_
	Stiffnes_        = a.Stiffnes_
	
End Operator


''	Compute
Sub AngularSpring.computeAngleVector()
	
	AngleVector_ = Vec2( RotateA_->AngleVector.Dot    ( RotateB_->AngleVector ), _
								RotateA_->AngleVector.PerpDot( RotateB_->AngleVector ) )
	
	'AngleVector_ = Vec2( Cos( Angle_ ), Sin( Angle_ ) )
	
End Sub

Sub AngularSpring.computeAngle()
	
  Angle_ = RotateB_->Angle - RotateA_->Angle
  
  'Angle_ = ATan2( angleVector_.y, angleVector_.x )
	
End Sub

Sub AngularSpring.computeAngularVelocity()
	
	AngularVelocity_ = RotateA_->AngularVelocity - RotateB_->AngularVelocity
	
End Sub

Sub AngularSpring.computeReducedInertia()
	
	ReducedInertia_ = 1.0 / ( RotateA_->InverseInertia + RotateB_->InverseInertia )
	
	'ReducedInertia_ = ( RotateA_->Inertia() * RotateB_->Inertia() ) / _
	'                  ( RotateA_->Inertia() + RotateB_->Inertia() )
	
End Sub

Sub AngularSpring.computeTorque()
	
	Dim As Single angle_error = angle_ - restAngle_
	
	AngularImpulse_ = -( stiffnes_ * INV_DT * angle_error + _
					         damping_ * angularVelocity_ ) * ReducedInertia_
	
	
	RotateA->AddAngularImpulse( -AngularImpulse_ )
	RotateB->AddAngularImpulse(  AngularImpulse_ )
	
End Sub


'' Get
Function AngularSpring.Angle() As Single
	
	Return Angle_
	
End Function

Function AngularSpring.AngleVector() As Vec2
	
	Return AngleVector_
	
End Function

Function AngularSpring.AngularVelocity() As Single
	
	Return AngularVelocity_
	
End Function

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

Function AngularSpring.Stiffnes() As Single
	
	Return Stiffnes_
	
End Function

Function AngularSpring.RotateA() As Rotate Ptr
	
	Return RotateA_
	
End Function

Function AngularSpring.RotateB() As Rotate Ptr
	
	Return RotateB_
	
End Function


'' Reset
Sub AngularSpring.ResetAll()
	
	RotateA_ = 0
	RotateB_ = 0
	
	ResetVariables()
	
End Sub

Sub AngularSpring.ResetVariables()
	
	Angle_           = 0.0
	AngleVector_     = Vec2( 0.0, 0.0 )
	AngularVelocity_ = 0.0
	Damping_         = 0.0
	ReducedInertia_  = 0.0
	RestAngle_       = 0.0
	RestAngleVector_ = Vec2( 0.0, 0.0 )
	Stiffnes_        = 0.0
	
End Sub


'' Set
Sub AngularSpring.Damping ( ByVal d As Single )
	
	damping_ = d
	
End Sub

Sub AngularSpring.RestAngle ( ByVal r As Single )
	
	restAngle_ = r
	
End Sub

Sub AngularSpring.RestAngleVector ( ByVal r As Vec2 )
	
	restAngleVector_ = r
	
End Sub

Sub AngularSpring.Stiffnes ( ByVal s As Single )
	
	stiffnes_ = s
	
End Sub

Sub AngularSpring.RotateA ( ByRef r As Rotate Ptr )
	
	RotateA_ = IIf( r <> RotateB_ , r , 0 )
	
End Sub

Sub AngularSpring.RotateB ( ByRef r As Rotate Ptr )
	
	RotateB_ = IIf( r <> RotateA_ , r , 0 )
	
End Sub


#EndIf ''__S2_ANGULAR_SPRING_BI__
