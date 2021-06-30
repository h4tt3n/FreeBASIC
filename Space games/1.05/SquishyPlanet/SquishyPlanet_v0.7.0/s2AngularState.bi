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
''   This is the inherited base type of all rotating physical objects.
''   It is the only object that does this, all other objects inherit their 
''   rotational motion properties from this class.
''
''   LinearState -> AngularState
''
''******************************************************************************


''
#Ifndef __S2_ANGULAR_STATE_BI__
#Define __S2_ANGULAR_STATE_BI__


''
Type AngularState Extends LinearState
	
	Public:
	
	'' Constructors
	Declare Constructor()
	
	Declare Constructor( ByRef R As AngularState )
	
	Declare Constructor( ByVal _mass     As Single, _
	                     ByVal _inertia  As Single, _
	                     ByVal _position As Vec2 )
	
	Declare Constructor( ByVal _mass     As Single, _
	                     ByVal _inertia  As Single, _
	                     ByVal _angle    As Single, _
	                     ByVal _position As Vec2 )
	
	Declare Constructor( ByVal _mass        As Single, _
	                     ByVal _inertia     As Single, _
	                     ByVal _anglevector As Vec2, _
	                     ByVal _position    As Vec2 )
	
	'' Destructor
	Declare Destructor()
	
	'' Operators
	Declare Operator Let( ByRef R As AngularState )
	
	'' Add
	Declare Virtual Sub AddAngle           ( ByVal a As Single )
	Declare Virtual Sub AddAngleVector     ( ByVal a As Vec2   )
	Declare Virtual Sub AddAngularImpulse  ( ByVal a As Single )
	Declare Virtual Sub AddAngularVelocity ( ByVal a As Single )
	'Declare Virtual Sub AddTorque          ( ByVal a As Single )
	
	'' Apply
	Declare Sub ApplyImpulse( ByVal impulse As Vec2, ByVal anchor As Vec2 )
	
	'' Compute
	Declare Virtual Sub ComputeAngle()
	Declare Virtual Sub ComputeAngleVector()
	Declare Virtual Sub ComputeInverseInertia()
	Declare Virtual Sub ComputeNewState()
	
	'' Get
	Declare Const Function GetAngle           () As Single
	Declare Const Function GetAngularImpulse  () As Single
	Declare Const Function GetAngularVelocity () As Single
	Declare Const Function GetInverseInertia  () As Single
	Declare Const Function GetInertia         () As Single
	'Declare Const Function GetTorque          () As Single
	Declare Const Function GetAngleVector           () As Vec2
	Declare Const Function GetAngularVelocityVector () As Vec2
	
	'' Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	'' Set
	Declare Virtual Sub SetAngle           ( ByVal a As Single )
	Declare Virtual Sub SetAngularImpulse  ( ByVal a As Single )
	Declare Virtual Sub SetAngularVelocity ( ByVal a As Single )
	Declare Virtual Sub SetInverseInertia  ( ByVal i As Single )
	Declare Virtual Sub SetInertia         ( ByVal i As Single )
	'Declare Virtual Sub SetTorque          ( ByVal t As Single )
	Declare Virtual Sub SetAngleVector           ( ByVal a As Vec2 )
	Declare Virtual Sub SetAngularVelocityVector ( ByVal a As Vec2 )
	
	Protected:
	
	As Vec2 AngleVector_
	As Vec2 AngularVelocityVector_
	
	As Single Angle_
	As Single AngularImpulse_
	As Single AngularVelocity_
	As Single Inertia_
	As Single InverseInertia_
	'As Single Torque_
	
End Type


'' Constructors
Constructor AngularState()
	
	Base()
	
	ResetAll()
	
End Constructor
	
Constructor AngularState( ByRef r As AngularState )
	
	ResetAll()
	
	This = r
	
End Constructor

Constructor AngularState( ByVal _mass     As Single, _
                          ByVal _inertia  As Single, _
                          ByVal _position As Vec2 )
	
	'Base( _mass, _position )
	
	ResetAll()
	
	SetMass     ( _mass )
	SetInertia  ( _inertia )
	SetPosition ( _position )
	
	ComputeInverseInertia()
	
	RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
End Constructor

Constructor AngularState( ByVal _mass     As Single, _
                          ByVal _inertia  As Single, _
	                       ByVal _angle    As Single, _
	                       ByVal _position As Vec2 )
	
	'Base( _mass, _position )
	
	ResetAll()
	
	SetMass     ( _mass )
	SetInertia  ( _inertia )
	SetAngle    ( _angle )
	SetPosition ( _position )
	
	ComputeAngleVector()
	ComputeInverseInertia()
	
	RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
End Constructor
	
Constructor AngularState( ByVal _mass        As Single, _
                          ByVal _inertia     As Single, _
	                       ByVal _anglevector As Vec2, _
	                       ByVal _position    As Vec2 )
	
	'Base( _mass, _position )
	
	ResetAll()
	
	SetMass        ( _mass )
	SetInertia     ( _inertia )
	SetAngleVector ( _anglevector )
	SetPosition    ( _position )
	
	ComputeAngle()
	ComputeInverseInertia()
	
	RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
End Constructor


'' Destructor
Destructor AngularState()

End Destructor


'' Operators
Operator AngularState.Let( ByRef r As AngularState )
	
	If ( @This <> @r ) Then
		
		Angle_                 = r.Angle_
		AngleVector_           = r.AngleVector_
		AngularImpulse_        = r.AngularImpulse_
		AngularVelocity_       = r.AngularVelocity_
		AngularVelocityVector_ = r.AngularVelocityVector_
		Inertia_               = r.Inertia_
		InverseInertia_        = r.InverseInertia_
		
		Cast( LinearState, This ) = r
		
	EndIf
		
End Operator


'' Add
Sub AngularState.AddAngle( ByVal a As Single )
	
	Angle_ += a	
	
End Sub

Sub AngularState.AddAngleVector( ByVal a As Vec2 )
	
	AngleVector_ = AngleVector_.RotateCCW( a )
	
End Sub

Sub AngularState.AddAngularImpulse( ByVal a As Single )
	
	AngularImpulse_ += a
	
End Sub

Sub AngularState.AddAngularVelocity ( ByVal a As Single )
	
	AngularVelocity_ += a
	
End Sub


'' Apply
Sub AngularState.ApplyImpulse( ByVal impulse As Vec2, ByVal anchor As Vec2 )
	
	AddImpulse( impulse )
	
	Dim As Single LocalAngularImpulse = anchor.PerpDot( impulse )
	
	AddAngularImpulse( LocalAngularImpulse )
	
End Sub


'' Compute
Sub AngularState.ComputeAngle()
	
	Angle_ = ATan2( AngleVector_.y, AngleVector_.x )
	
End Sub

Sub AngularState.ComputeAngleVector()
	
	AngleVector_ = Vec2( Cos( Angle_ ), Sin( Angle_ ) )
	
End Sub

Sub AngularState.ComputeInverseInertia()
	
	InverseInertia_ = IIf( Inertia_ > 0.0 , 1.0 / Inertia_ , 0.0 )
	
End Sub

Sub AngularState.ComputeNewState()
	
	Base.ComputeNewState()
	
	'' Global Angular
	'If ( AngularImpulse_ <> 0.0 ) Then
		
		AngularVelocity_ += AngularImpulse_
		
		AngularVelocityVector_ = Vec2( Cos( AngularVelocity_ * DT ), _
		                               Sin( AngularVelocity_ * DT ) )
	
	'EndIf
	
	Angle_ += AngularVelocity_ * DT
	AngleVector_ = AngleVector_.RotateCCW( AngularVelocityVector_ )
	
	AngularImpulse_ = 0.0
	
	'Base.ComputeNewState()
	'
	''If ( GetAngularImpulse <> 0.0 ) Then
	'	
	'	AddAngularVelocity( GetAngularImpulse )
	'	
	'	SetAngularVelocityVector( Vec2( Cos( GetAngularVelocity * DT ), _
	'	                                Sin( GetAngularVelocity * DT ) ) )
	'
	''EndIf
	'
	'AddAngle( GetAngularVelocity * DT )
	'AddAngleVector( GetAngularVelocityVector )
	''AngleVector( AngleVector.RotateCCW( AngularVelocityVector ) )
	'
	'SetAngularImpulse( 0.0 )
	
End Sub


'' Get
Function AngularState.GetAngle() As Single
	
	Return Angle_
	
End Function

Function AngularState.GetAngleVector() As Vec2
	
	Return AngleVector_
	
End Function

Function AngularState.GetAngularVelocityVector() As Vec2
	
	Return AngularVelocityVector_
	
End Function

Function AngularState.GetAngularImpulse() As Single
	
	Return AngularImpulse_
	
End Function

Function AngularState.GetAngularVelocity() As Single
	
	Return AngularVelocity_
	
End Function

Function AngularState.GetInertia() As Single
	
	Return Inertia_
	
End Function

Function AngularState.GetInverseInertia() As Single
	
	Return InverseInertia_
	
End Function


'' Reset
Sub AngularState.ResetAll()
	
	ResetVariables()
	
	Base.ResetAll()
	
End Sub

Sub AngularState.ResetVariables()
	
	AngleVector_           = Vec2( 1.0, 0.0 )
	AngularVelocityVector_ = Vec2( 1.0, 0.0 )
	
	Angle_           = 0.0
	AngularImpulse_  = 0.0
	AngularVelocity_ = 0.0
	Inertia_         = 0.0
	InverseInertia_  = 0.0
	
	Base.ResetAll()
	
End Sub


'' Set
Sub AngularState.SetAngle( ByVal a As Single )
	
	Angle_ = a
	
End Sub

Sub AngularState.SetAngleVector( ByVal a As Vec2 )
	
	AngleVector_ = a
	
End Sub

Sub AngularState.SetAngularVelocityVector( ByVal a As Vec2 )
	
	AngularVelocityVector_ = a
	
End Sub

Sub AngularState.SetAngularImpulse( ByVal a As Single )
	
	AngularImpulse_ = a
	
End Sub

Sub AngularState.SetAngularVelocity( ByVal a As Single )
	
	AngularVelocity_ = a
	
End Sub

Sub AngularState.SetInertia( ByVal i As Single )
	
	Inertia_ = i
	
End Sub

Sub AngularState.SetInverseInertia( ByVal i As Single )
	
	InverseInertia_ = i
	
End Sub


#EndIf ''__S2_ANGULAR_STATE_BI__
