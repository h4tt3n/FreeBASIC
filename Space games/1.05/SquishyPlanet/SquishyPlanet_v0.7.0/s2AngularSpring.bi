''******************************************************************************
''
''   SquishyPlanet - A 2D soft body and space physics library for games
''   Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''   Version 0.7.0, December 2016
''
''   Author:
''   Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
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
	
	Declare Constructor( ByVal _stiffnes  As Single           = C_ANGULAR_STIFFNESS, _
	                     ByVal _damping   As Single           = C_ANGULAR_DAMPING, _
	                     ByVal _warmstart As Single           = C_ANGULAR_WARMSTART, _
	                     ByRef _rotatea   As AngularState Ptr = 0, _
	                     ByRef _rotateb   As AngularState Ptr = 0 )
	
	Declare Constructor( ByVal _stiffnes        As Single           = C_ANGULAR_STIFFNESS, _
	                     ByVal _damping         As Single           = C_ANGULAR_DAMPING, _
	                     ByVal _warmstart       As Single           = C_ANGULAR_WARMSTART, _
	                     ByVal _restanglevector As Vec2             = Vec2( 0.0, 0.0 ), _
	                     ByRef _rotatea         As AngularState Ptr = 0, _
	                     ByRef _rotateb         As AngularState Ptr = 0 )
	
	Declare Constructor( ByVal _stiffnes  As Single           = C_ANGULAR_STIFFNESS, _
	                     ByVal _damping   As Single           = C_ANGULAR_DAMPING, _
	                     ByVal _warmstart As Single           = C_ANGULAR_WARMSTART, _
	                     ByVal _restangle As Single           = 0.0, _
	                     ByRef _rotatea   As AngularState Ptr = 0, _
	                     ByRef _rotateb   As AngularState Ptr = 0 )
	
	'' Destructor
	Declare Destructor()
	
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
	
	'' Flags
	Declare Sub LowerFlag( ByVal Flag As Integer )
	Declare Sub RaiseFlag( ByVal Flag As Integer )
	Declare Sub ToggleFlag( ByVal Flag As Integer )
	
	'' Get
	Declare Const Function GetDamping         () As Single
	Declare Const Function GetAngularStateA   () As AngularState Ptr
	Declare Const Function GetAngularStateB   () As AngularState Ptr
	Declare Const Function GetReducedInertia  () As Single
	Declare Const Function GetRestAngle       () As Single
	Declare Const Function GetRestAngleVector () As Vec2
	Declare Const Function GetStiffnes        () As Single
	Declare Const Function GetWarmstart       () As Single
	
	'' Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	'' Set
	Declare Sub SetDamping         ( ByVal d As Single )
	Declare Sub SetAngularStateA   ( ByRef r As AngularState Ptr )
	Declare Sub SetAngularStateB   ( ByRef r As AngularState Ptr )
	Declare Sub SetRestAngle       ( ByVal r As Single )
	Declare Sub SetRestAngleVector ( ByVal r As Vec2 )
	Declare Sub SetStiffnes        ( ByVal s As Single )
	Declare Sub SetWarmstart       ( ByVal w As Single )
	
	'Protected:
	
	'' Variables
	As Single Angle_
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
	
	As UInteger Flags_
	
	'' AngularState Ptrs
	As AngularState Ptr AngularStateA_
	As AngularState Ptr AngularStateB_
	
End Type


''	Constructors
Constructor AngularSpring()
	
	ResetAll()
	
End Constructor

Constructor AngularSpring( ByRef a As AngularSpring )
	
	ResetAll()
	
	This = a
	
End Constructor

Constructor AngularSpring( ByVal _stiffnes  As Single,     _
                           ByVal _damping   As Single,     _
                           ByVal _warmstart As Single,     _
                           ByRef _Rotatea   As AngularState Ptr, _
                           ByRef _Rotateb   As AngularState Ptr )
	
	ResetAll()
		
	SetStiffnes      ( _stiffnes )
	SetDamping       ( _damping )
	SetWarmStart     ( _warmstart )
	SetAngularStateA ( _Rotatea )
	SetAngularStateB ( _Rotateb )
	
	SetRestAngle( GetAngularStateB->GetAngle - GetAngularStateA->GetAngle )
	ComputeAngleVector()
	SetRestAngleVector( AngleVector_ )
	
	ComputeReducedInertia()
	
End Constructor

Constructor AngularSpring( ByVal _stiffnes        As Single,     _
                           ByVal _damping         As Single,     _
                           ByVal _warmstart       As Single,     _
                           ByVal _restAngleVector As Vec2,       _
                           ByRef _Rotatea         As AngularState Ptr, _
                           ByRef _Rotateb         As AngularState Ptr )
	
	ResetAll()
	
	SetAngularStateA ( _Rotatea )
	SetAngularStateB ( _Rotateb )
	SetDamping       ( _damping )
	SetStiffnes      ( _stiffnes )
	SetWarmStart     ( _warmstart )
	
	SetRestAngleVector ( _restanglevector )
	SetRestAngle( ATan2( _restanglevector.y, _restanglevector.x ) )
	
	ComputeReducedInertia()
	
End Constructor

Constructor AngularSpring( ByVal _stiffnes  As Single,     _
                           ByVal _damping   As Single,     _
                           ByVal _warmstart As Single,     _
                           ByVal _restangle As Single,     _
                           ByRef _Rotatea   As AngularState Ptr, _
                           ByRef _Rotateb   As AngularState Ptr )
	
	ResetAll()
	
	SetAngularStateA   ( _Rotatea )
	SetAngularStateB   ( _Rotateb )
	SetDamping         ( _damping )
	SetStiffnes        ( _stiffnes )
	SetWarmStart       ( _warmstart )
	SetRestAngle       ( _restangle )
	SetRestAngleVector ( Vec2( Cos( _restangle ), Sin( _restangle ) ) )
	
	ComputeReducedInertia()
	
End Constructor


'' Destructor
Destructor AngularSpring()

End Destructor


'' Operators
Operator AngularSpring.Let( ByRef a As AngularSpring )
	
	If ( @This <> @a ) Then
		
		AccumulatedImpulse_ = a.AccumulatedImpulse_
		AngleVector_        = a.AngleVector_
		AngularImpulse_     = a.AngularImpulse_
		Damping_            = a.Damping_
		ReducedInertia_     = a.ReducedInertia_
		RestAngle_          = a.RestAngle_
		RestAngleVector_    = a.RestAngleVector_
		RestImpulse_        = a.RestImpulse_
		AngularStateA_      = a.AngularStateA_
		AngularStateB_      = a.AngularStateB_
		Stiffnes_           = a.Stiffnes_
		Warmstart_          = a.Warmstart_
		
	End If
	
End Operator


'' Apply
Sub AngularSpring.ApplyCorrectiveImpulse()
	
	Dim As Single delta_impulse = AngularStateB_->GetAngularImpulse - AngularStateA_->GetAngularImpulse
		
	Dim As Single impulse_error = delta_impulse - RestImpulse_
	
	Dim As Single corrective_impulse = - impulse_error * ReducedInertia_
	
	AngularStateA_->AddAngularImpulse( -corrective_impulse * AngularStateA_->GetInverseInertia )
	AngularStateB_->AddAngularImpulse(  corrective_impulse * AngularStateB_->GetInverseInertia )
	
	'AccumulatedImpulse_ += corrective_impulse
	
End Sub

Sub AngularSpring.ApplyWarmStart()
	'
	'Dim As Single warmstart_impulse = Warmstart_ * AccumulatedImpulse_
	'
	'AngularStateA_->AddAngularImpulse( -warmstart_impulse * AngularStateA_->InverseInertia )
	'AngularStateB_->AddAngularImpulse(  warmstart_impulse * AngularStateB_->InverseInertia )
	'
	'AccumulatedImpulse_ = 0.0
	
End Sub


''	Compute
Sub AngularSpring.ComputeAngle()
	
	Angle_ = ATan2( AngleVector_.y, AngleVector_.x )
	
End Sub

Sub AngularSpring.computeAngleVector()
	
	'AngleVector_ = Vec2( AngularStateB_->AngleVector.Dot    ( AngularStateA_->AngleVector ), _
	'							AngularStateB_->AngleVector.PerpDot( AngularStateA_->AngleVector ) )
	
	AngleVector_ = Vec2( Cos( Angle_ ), Sin( Angle_ ) )
	
End Sub

Sub AngularSpring.computeReducedInertia()
	
	Dim As Single ii = AngularStateA_->GetInverseInertia + AngularStateB_->GetInverseInertia
	
	ReducedInertia_ = IIf( ii > 0.0 , 1.0 / ii , 0.0 )
	
End Sub

Sub AngularSpring.computeRestImpulse()
	
	Dim As Single delta_angle = AngularStateB_->GetAngle - AngularStateA_->GetAngle
	
	Dim As Single angle_error = delta_angle - restAngle_
	
	'Dim As Single angle_error = AngleVector_.PerpDot( RestAngleVector_ )
	'Dim As Single angle_error = RestAngleVector_.PerpDot( AngleVector_ )
	
	Dim As Single velocity_error = AngularStateB_->GetAngularVelocity - AngularStateA_->GetAngularVelocity
	
	RestImpulse_ = - stiffnes_ * INV_DT * angle_error - damping_ * velocity_error
	
End Sub


'' Get
Function AngularSpring.GetDamping() As Single
	
	Return Damping_
	
End Function

Function AngularSpring.GetReducedInertia() As Single
	
	Return ReducedInertia_
	
End Function

Function AngularSpring.GetRestAngle() As Single
	
	Return RestAngle_
	
End Function

Function AngularSpring.GetRestAngleVector() As Vec2
	
	Return RestAngleVector_
	
End Function

Function AngularSpring.GetAngularStateA() As AngularState Ptr
	
	Return AngularStateA_
	
End Function

Function AngularSpring.GetAngularStateB() As AngularState Ptr
	
	Return AngularStateB_
	
End Function

Function AngularSpring.GetStiffnes() As Single
	
	Return Stiffnes_
	
End Function

Function AngularSpring.GetWarmstart() As Single
	
	Return Warmstart_
	
End Function


'' Reset
Sub AngularSpring.ResetAll()
	
	AngularStateA_ = 0
	AngularStateB_ = 0
	
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
Sub AngularSpring.SetDamping( ByVal d As Single )
	
	Damping_ = d
	
End Sub

Sub AngularSpring.SetRestAngle( ByVal r As Single )
	
	RestAngle_ = r
	
End Sub

Sub AngularSpring.SetRestAngleVector( ByVal r As Vec2 )
	
	RestAngleVector_ = r
	
End Sub

Sub AngularSpring.SetAngularStateA( ByRef r As AngularState Ptr )
	
	AngularStateA_ = IIf( r <> AngularStateB_ , r , 0 )
	
End Sub

Sub AngularSpring.SetAngularStateB( ByRef r As AngularState Ptr )
	
	AngularStateB_ = IIf( r <> AngularStateA_ , r , 0 )
	
End Sub

Sub AngularSpring.SetStiffnes( ByVal s As Single )
	
	Stiffnes_ = s
	
End Sub

Sub AngularSpring.SetWarmstart( ByVal w As Single )
	
	Warmstart_ = w
	
End Sub


#EndIf ''__S2_ANGULAR_SPRING_BI__
