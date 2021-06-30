''******************************************************************************
''
''   Squishy2D Rotate Class
''   Written in FreeBASIC 1.04
''   version 0.1.0, November 2015, Michael "h4tt3n" Nissen
''
''   This is the inherited base type of all rotating physical objects.
''   It takes care of rotation and translation.
''   It is the only object that does this, all other objects inherit their 
''   rotational motion properties from this class.
''
''   Particle --> Rotate --> LineSegment / Body --> SpringBody --> PressureBody
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
	 
	'' Operators
	Declare Operator Let( ByRef R As Rotate )
	
	'' Add
	Declare Sub AddAngularImpulse( ByVal a As Single )
	
	'' Compute
	Declare Virtual Sub ComputeAngle()
	Declare Virtual Sub ComputeAngleVector()
	
	'' Get
	Declare Const Function Angle           () As Single
	Declare Const Function AngleVector     () As Vec2
	Declare Const Function AngularImpulse  () As Single
	Declare Const Function AngularVelocity () As Single
	Declare Const Function InverseInertia  () As Single
	Declare Const Function Inertia         () As Single
	
	'' Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	'' Set
	Declare Sub Angle           ( ByVal a As Single )
	Declare Sub AngleVector     ( ByVal a As Vec2   )
	Declare Sub AngularImpulse  ( ByVal a As Single )
	Declare Sub AngularVelocity ( ByVal a As Single )
	Declare Sub InverseInertia  ( ByVal i As Single )
	Declare Sub Inertia         ( ByVal i As Single )
	
	Protected:
	
	'' Variables
	As Single Angle_
	As Vec2   AngleVector_
	As Single AngularImpulse_
	As Single AngularVelocity_
	As Single Inertia_
	As Single InverseInertia_
	
End Type


'' Constructors
Constructor Rotate()
	
	ResetAll()
	
End Constructor
	
Constructor Rotate( ByRef r As Rotate )
	
	ResetAll()
	
	This = r
	
End Constructor


'' Operators
Operator Rotate.Let( ByRef r As Rotate )

	Angle_           = r.Angle_
	AngleVector_     = r.AngleVector_
	AngularImpulse_  = r.AngularImpulse_
	AngularVelocity_ = r.AngularVelocity_
	Inertia_         = r.Inertia_
	InverseInertia_  = r.InverseInertia_
	
	Cast( Particle, This ) = r
		
End Operator


'' Add
Sub Rotate.AddAngularImpulse ( ByVal a As Single )
	
	AngularImpulse_ += a
	
End Sub


''	Compute
Sub Rotate.computeAngle()
	
	Angle_ = ATan2( AngleVector_.y, AngleVector_.x )
	
End Sub

Sub Rotate.computeAngleVector()
	
	AngleVector_ = Vec2( Cos( Angle_ ), Sin( Angle_ ) )
	
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
	AngleVector_     = Vec2( 0.0, 0.0 )
	AngularImpulse_  = 0.0
	AngularVelocity_ = 0.0
	Inertia_         = 0.0
	InverseInertia_  = 0.0
	
	Base.ResetAll()
	
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