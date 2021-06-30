''******************************************************************************
''
''   Squishy2D Rotate Class
''   Written in FreeBASIC 1.05
''   version 0.2.0, May 2016, Michael "h4tt3n" Nissen
''
''   This is the inherited base type of all rotating physical objects.
''   It is the only object that does this, all other objects inherit their 
''   rotational motion properties from this class.
''
''   Particle -> Rotate
''
''******************************************************************************


''
#Ifndef __S2_ROTATE_BI__
#Define __S2_ROTATE_BI__


''
Type Rotate Extends Particle
	
	Public:
	
	'' Constructors
	Declare Constructor()
	
	Declare Constructor( ByRef R As Rotate )
	
	Declare Constructor( ByVal _mass     As Single, _
	                     ByVal _radius   As Single, _
	                     ByVal _position As Vec2 )
	
	Declare Constructor( ByVal _mass     As Single, _
	                     ByVal _radius   As Single, _
	                     ByVal _angle    As Single, _
	                     ByVal _position As Vec2 )
	
	Declare Constructor( ByVal _mass        As Single, _
	                     ByVal _radius      As Single, _
	                     ByVal _anglevector As Vec2, _
	                     ByVal _position    As Vec2 )
	
	'' Operators
	Declare Operator Let( ByRef R As Rotate )
	
	'' Add
	Declare Virtual Sub AddAngle           ( ByVal a As Single )
	Declare Virtual Sub AddAngleVector     ( ByVal a As Vec2   )
	Declare Virtual Sub AddAngularImpulse  ( ByVal a As Single )
	Declare Virtual Sub AddAngularVelocity ( ByVal a As Single )
	'Declare Virtual Sub AddTorque          ( ByVal a As Single )
	
	'' Apply
	Declare Virtual Sub ApplyImpulse( ByVal r As Vec2, ByVal i As Vec2 )
	
	'' Compute
	Declare Virtual Sub ComputeAngle()
	Declare Virtual Sub ComputeAngleVector()
	
	'' Get
	Declare Const Virtual Function Angle           () As Single
	Declare Const Virtual Function AngleVector     () As Vec2
	Declare Const Virtual Function AngularImpulse  () As Single
	Declare Const Virtual Function AngularVelocity () As Single
	Declare Const Virtual Function InverseInertia  () As Single
	Declare Const Virtual Function Inertia         () As Single
	'Declare Const Virtual Function Torque          () As Single
	
	'' Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	'' Set
	Declare Virtual Sub Angle           ( ByVal a As Single )
	Declare Virtual Sub AngleVector     ( ByVal a As Vec2   )
	Declare Virtual Sub AngularImpulse  ( ByVal a As Single )
	Declare Virtual Sub AngularVelocity ( ByVal a As Single )
	Declare Virtual Sub InverseInertia  ( ByVal i As Single )
	Declare Virtual Sub Inertia         ( ByVal i As Single )
	'Declare Virtual Sub Torque          ( ByVal t As Single )
	
	Protected:
	
	'' Variables
	As Single Angle_
	As Vec2   AngleVector_
	As Single AngularImpulse_
	As Single AngularVelocity_
	As Single Inertia_
	As Single InverseInertia_
	'As Single Torque_
	
End Type


'' Constructors
Constructor Rotate()
	
	Base()
	
	ResetAll()
	
End Constructor
	
Constructor Rotate( ByRef r As Rotate )
	
	ResetAll()
	
	This = r
	
End Constructor

Constructor Rotate( ByVal _mass As Single, _
                    ByVal _radius As Single, _
                    ByVal _position As Vec2 )
	
	Base( _mass, _radius, _position )
	
	ComputeInverseMass()
	
	RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
End Constructor

Constructor Rotate( ByVal _mass     As Single, _
	                 ByVal _radius   As Single, _
	                 ByVal _angle    As Single, _
	                 ByVal _position As Vec2 )
	
	Base( _mass, _radius, _position )
	
	Angle_ = _angle
	
	ComputeAngleVector()
	ComputeInverseMass()
	
	RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
End Constructor
	
Constructor Rotate( ByVal _mass        As Single, _
	                 ByVal _radius      As Single, _
	                 ByVal _anglevector As Vec2, _
	                 ByVal _position    As Vec2 )
	
	Base( _mass, _radius, _position )
	
	AngleVector_ = _anglevector
	
	ComputeAngle()
	ComputeInverseMass()
	
	RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
End Constructor


'' Operators
Operator Rotate.Let( ByRef r As Rotate )
	
	If ( @This <> @r ) Then
		
		Angle_           = r.Angle_
		AngleVector_     = r.AngleVector_
		AngularImpulse_  = r.AngularImpulse_
		AngularVelocity_ = r.AngularVelocity_
		Inertia_         = r.Inertia_
		InverseInertia_  = r.InverseInertia_
		
		Cast( Particle, This ) = r
		
	EndIf
		
End Operator


'' Add
Sub Rotate.AddAngle( ByVal a As Single )
	
	Angle_ += a	
	
End Sub

Sub Rotate.AddAngleVector( ByVal a As Vec2 )
	
	Dim As Vec2 new_anglevector = AngleVector_.Rotate( a )
	
	AngleVector_ = new_anglevector
	
End Sub

Sub Rotate.AddAngularImpulse( ByVal a As Single )
	
	AngularImpulse_ += a
	
End Sub

Sub Rotate.AddAngularVelocity ( ByVal a As Single )
	
	AngularVelocity_ += a
	
End Sub


'' Apply
Sub Rotate.ApplyImpulse( ByVal r As Vec2, ByVal i As Vec2 )
	
	AddImpulse( i )
	
	Dim As Single LocalAngularImpulse = r.PerpDot( i )
	
	AddAngularImpulse( LocalAngularImpulse )
	
End Sub


'' Compute
Sub Rotate.ComputeAngle()
	
	'Angle_ += AngularVelocity_ * DT
	
End Sub

Sub Rotate.ComputeAngleVector()
	
	AngleVector_ = AngleToUnit( Angle_ )
	
End Sub


'' Get
Function Rotate.Angle() As Single
	
	Return Angle_
	
End Function

Function Rotate.AngleVector() As Vec2
	
	Return AngleVector_
	
End Function

Function Rotate.AngularImpulse() As Single
	
	Return AngularImpulse_
	
End Function

Function Rotate.AngularVelocity() As Single
	
	Return AngularVelocity_
	
End Function

Function Rotate.Inertia() As Single
	
	Return Inertia_
	
End Function

Function Rotate.InverseInertia() As Single
	
	Return InverseInertia_
	
End Function


'' Reset
Sub Rotate.ResetAll()
	
	ResetVariables()
	
	Base.ResetAll()
	
End Sub

Sub Rotate.ResetVariables()
	
	Angle_           = 0.0
	AngleVector_     = Vec2( 1.0, 0.0 )
	AngularImpulse_  = 0.0
	AngularVelocity_ = 0.0
	Inertia_         = 0.0
	InverseInertia_  = 0.0
	
	'Base.ResetAll()
	
End Sub


'' Set
Sub Rotate.Angle( ByVal a As Single )
	
	Angle_ = a
	
End Sub

Sub Rotate.AngleVector( ByVal a As Vec2 )
	
	AngleVector_ = a
	
End Sub

Sub Rotate.AngularImpulse( ByVal a As Single )
	
	AngularImpulse_ = a
	
End Sub

Sub Rotate.AngularVelocity( ByVal a As Single )
	
	AngularVelocity_ = a
	
End Sub

Sub Rotate.Inertia( ByVal i As Single )
	
	Inertia_ = i
	
End Sub

Sub Rotate.InverseInertia( ByVal i As Single )
	
	InverseInertia_ = i
	
End Sub


#EndIf ''__S2_ROTATE_BI__
