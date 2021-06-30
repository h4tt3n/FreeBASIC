''***************************************************************************
''
''   Squishy2D Body Class
''   Written in FreeBASIC 1.04
''   version 0.1.0, November 2015, Michael "h4tt3n" Nissen
''
''   This is the inherited base type of all soft body types.
''   It holds a list of the pointmasses assigned to it and -
''   takes care of overall, body-level rotation and translation.
''
''   PointMass --> Body --> SpringBody / PressureBody / SlimeBody
''
''***************************************************************************


''
#Ifndef __S2_BODY_BI__
#Define __S2_BODY_BI__


''
Type Body Extends PointMass
	
	Public:
	
	'' Constructors
	Declare Constructor()
	Declare Constructor( ByRef body As Body )
	
	'' Destructor
	Declare Destructor()
	 
	'' Operators
	Declare Operator Let( ByRef body As Body )
	
	'' Compute
	Declare Sub computeAngleVector()
	Declare Sub computeAngularMomentum()
	Declare Sub computeAngularVelocity()
	Declare Sub computeInertia()
	Declare Sub computeMass()
	Declare Sub computeStateVectors()
	
	'' Get
	Declare Function getAngle           () As Single
	Declare Function getAngleVector     () As Vec2
	Declare Function getAngularImpulse  () As Single
	Declare Function getAngularVelocity () As Single
	Declare Function getInverseInertia  () As Single
	Declare Function getInertia         () As Single
	Declare Function getTorque          () As Single
	
	'' Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	'' Set       
	Declare Sub setAngle           ( ByVal angle           As Single )
	Declare Sub setAngleVector     ( ByVal anglevector     As Vec2   )
	Declare Sub setAngularImpulse  ( ByVal angularimpulse  As Single )
	Declare Sub setAngularVelocity ( ByVal angularvelocity As Single )
	Declare Sub setInverseInertia  ( ByVal inverseinertia  As Single )
	Declare Sub setInertia         ( ByVal inertia         As Single )
	Declare Sub setTorque          ( ByVal torque          As Single )
	
	Protected:
	
	'' Variables
	As Single Angle_
	As Vec2   AngleVector_
	As Single AngularImpulse_
	As Single AngularMomentum_
	As Single AngularVelocity_
	As Single Inertia_
	As Single InverseInertia_
	As Single Torque_
	
	''	Pointmass pointers
	As PointMassPointerArray PointMasses
	
End Type


'' Constructors
Constructor Body()
	
	ResetAll()
	
End Constructor
	
Constructor Body( ByRef body As Body )
	
	ResetAll()
	
	This = body
	
End Constructor


'' Destructor
Destructor Body()
	
	'PointMasses.Clear()
	
End Destructor


'' Operators
Operator Body.Let( ByRef body As Body )

	Angle_           = body.Angle_
	AngleVector_     = body.AngleVector_
	AngularImpulse_  = body.AngularImpulse_
	AngularVelocity_ = body.AngularVelocity_
	Inertia_         = body.Inertia_
	InverseInertia_  = body.InverseInertia_
	Torque_          = body.Torque_
	
	'PointMasses      = body.PointMasses
	
	Cast( PointMass, This ) = body
	'Cast( PointMass, This ) = Cast( PointMass, body )
		
End Operator


''	Compute
Sub Body.computeAngleVector()
	
	AngleVector_ = Vec2( Cos( Angle_ ), Sin( Angle_ ) )
	
End Sub

Sub Body.computeAngularMomentum()
	
	
	
End Sub

Sub Body.computeAngularVelocity()
	
	AngularVelocity_ = AngularMomentum_ * InverseInertia_
	
End Sub

Sub Body.computeInertia()
	
	''	Calculate moment of inertia and inverse moment of inertia
	
End Sub

Sub Body.computeMass()
	
	Mass_ = 0.0
	
	'For I as PointMass Ptr = PointMasses.Front TO PointMasses.Back
		
	'	Mass_ += I->Mass_
		
	'Next
	
End Sub

Sub Body.computeStateVectors()
	
End Sub


'' Get
Function Body.getAngle() As Single
	
	Return Angle_
	
End Function


Function Body.getAngleVector() As Vec2
	
	Return AngleVector_
	
End Function

Function Body.getAngularImpulse() As Single
	
	Return AngularImpulse_
	
End Function

Function Body.getAngularVelocity() As Single
	
	Return AngularVelocity_
	
End Function

Function Body.getInertia() As Single
	
	Return Inertia_
	
End Function

Function Body.getInverseInertia() As Single
	
	Return InverseInertia_
	
End Function

Function Body.getTorque() As Single
	
	Return Torque_
	
End Function


'' Reset
Sub Body.ResetAll()
	
	ResetVariables()
	
	'PointMassess.Clear()
	
	Base.ResetAll()
	
End Sub

Sub Body.ResetVariables()
	
	Angle_           = 0.0
	AngleVector_     = Vec2( 0.0, 0.0 )
	AngularImpulse_  = 0.0
	AngularVelocity_ = 0.0
	Inertia_         = 0.0
	InverseInertia_  = 0.0
	Torque_          = 0.0
	
	Base.ResetAll()
	
End Sub


'' Set
Sub Body.setAngle( ByVal angle As Single )
	
	Angle_ = angle
	
End Sub

Sub Body.setAngleVector( ByVal anglevector As Vec2 )
	
	AngleVector_ = anglevector
	
End Sub

Sub Body.setAngularImpulse( ByVal AngularImpulse As Single )
	
	AngularImpulse_ = AngularImpulse
	
End Sub

Sub Body.setAngularVelocity( ByVal angularvelocity As Single )
	
	AngularVelocity_ = angularvelocity
	
End Sub

Sub Body.setInertia( ByVal inertia As Single )
	
	Inertia_ = inertia
	
End Sub

Sub Body.setInverseInertia( ByVal inverseinertia As Single )
	
	InverseInertia_ = inverseinertia
	
End Sub

Sub Body.setTorque( ByVal torque As Single )
	
	Torque_ = torque
	
End Sub


#EndIf ''__S2_BODY_BI__