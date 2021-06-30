''***************************************************************************
''
''   Squishy2D Angular Spring Class
''   Written in FreeBASIC 1.04
''   version 0.1.0, November 2015, Michael "h4tt3n" Nissen
''
''***************************************************************************


''
#Ifndef __S2_ANGULAR_SPRING_BI__
#Define __S2_ANGULAR_SPRING_BI__


'' Includes
#Include Once "../../Math/Vector2.bi"
#Include Once "s2GlobalConstants.bi"
#Include Once "s2Body.bi"


''
Type AngularSpring
	
	Public:
	
	''	Constructors
	Declare Constructor()
	
	Declare Constructor( ByRef A As AngularSpring )
	
	Declare Constructor( ByVal stiffnes As Single   = 0.0, _
	                     ByVal damping  As Single   = 0.0, _
	                     ByRef Bodya    As Body Ptr = 0  , _
	                     ByRef Bodyb    As Body Ptr = 0 )
	
	Declare Constructor( ByVal stiffnes        As Single   = 0.0           , _
	                     ByVal damping         As Single   = 0.0           , _
	                     ByVal restanglevector As Vec2     = Vec2(0.0, 0.0), _
	                     ByRef Bodya           As Body Ptr = 0             , _
	                     ByRef Bodyb           As Body Ptr = 0 )
	
	Declare Constructor( ByVal stiffnes  As Single   = 0.0, _
	                     ByVal damping   As Single   = 0.0, _
	                     ByVal restangle As Single   = 0.0, _
	                     ByRef Bodya     As Body Ptr = 0  , _
	                     ByRef Bodyb     As Body Ptr = 0 )
	
	''	Operators
	Declare Operator Let( ByRef A As AngularSpring )
	
	'' Compute
	Declare Sub computeAngle           ()
	Declare Sub computeAngleVector     ()
	Declare Sub computeAngularVelocity ()
	Declare Sub computeReducedInertia  ()
	Declare Sub computeTorque          ()
	
	'' Get
	Declare Function getAngle           () As Single
	Declare Function getAngleVector     () As Vec2
	Declare Function getAngularVelocity () As Single
	Declare Function getDamping         () As Single
	Declare Function getBodyA           () As Body Ptr
	Declare Function getBodyB           () As Body Ptr
	Declare Function getReducedInertia  () As Single
	Declare Function getRestAngle       () As Single
	Declare Function getRestAngleVector () As Vec2
	Declare Function getStiffnes        () As Single
	Declare Function getTorque          () As Single
	
	'' Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	'' Set
	Declare Sub setDamping         ( ByVal damping         As Single   )
	Declare Sub setBodyA           ( ByRef Bodya           As Body Ptr )
	Declare Sub setBodyB           ( ByRef Bodyb           As Body Ptr )
	Declare Sub setRestAngle       ( ByVal restangle       As Single   )
	Declare Sub setRestAngleVector ( ByVal restanglevector As Vec2     )
	Declare Sub setStiffnes        ( ByVal stiffnes        As Single   )
	
	Private:
	
	'' Variables
	As Single Angle_
	As Vec2   AngleVector_
	As Single AngularVelocity_
	As Single Damping_
	As Single ReducedInertia_
	As Single RestAngle_
	As Vec2   RestAngleVector_
	As Single Stiffnes_
	As Single Torque_
	
	'' Body pointers
	As Body Ptr BodyA_
	As Body Ptr BodyB_
	
End Type


''	Constructors
Constructor AngularSpring()
	
	ResetAll()
	
End Constructor

Constructor AngularSpring( ByRef A As AngularSpring )
	
	ResetAll()
	
	This = A
	
End Constructor

Constructor AngularSpring( ByVal stiffnes As Single,   _
                           ByVal damping  As Single,   _
                           ByRef Bodya    As Body Ptr, _
                           ByRef Bodyb    As Body Ptr )
	
	ResetAll()
		
	setBodyA    ( Bodya )
	setBodyB    ( Bodyb )
	
	setDamping  ( damping )
	setStiffnes ( stiffnes )
	
	computeAngleVector()
	
	setRestAngleVector( getAngleVector() )
	
End Constructor

Constructor AngularSpring( ByVal stiffnes        As Single,   _
                           ByVal damping         As Single,   _
                           ByVal restAngleVector As Vec2,     _
                           ByRef Bodya           As Body Ptr, _
                           ByRef Bodyb           As Body Ptr )
	
	ResetAll()
	
	setBodyA           ( Bodya )
	setBodyB           ( Bodyb )
	
	setDamping         ( damping )
	setStiffnes        ( stiffnes )
	setRestAngleVector ( restanglevector )
	
End Constructor

Constructor AngularSpring( ByVal stiffnes  As Single,   _
                           ByVal damping   As Single,   _
                           ByVal restangle As Single,   _
                           ByRef Bodya     As Body Ptr, _
                           ByRef Bodyb     As Body Ptr )
	
	ResetAll()
	
	setBodyA     ( Bodya )
	setBodyB     ( Bodyb )
	
	setDamping   ( damping )
	setStiffnes  ( stiffnes )
	setRestAngle ( restangle )
	
End Constructor


'' Operators
Operator AngularSpring.Let( ByRef A As AngularSpring )
	
	Angle_           = A.Angle_
	AngleVector_     = A.AngleVector_
	AngularVelocity_ = A.AngularVelocity_
	BodyA_           = A.BodyA_
	BodyB_           = A.BodyB_
	Damping_         = A.Damping_
	ReducedInertia_  = A.ReducedInertia_
	RestAngle_       = A.RestAngle_
	RestAngleVector_ = A.RestAngleVector_
	Stiffnes_        = A.Stiffnes_
	Torque_          = A.Torque_
	
End Operator


''	Compute
Sub AngularSpring.computeAngleVector()
	
	AngleVector_ = Vec2( BodyA_->getAngleVector().Dot    ( BodyB_->getAngleVector() ), _
								BodyA_->getAngleVector().PerpDot( BodyB_->getAngleVector() ) )
	
	'AngleVector_ = Vec2( Cos( Angle_ ), Sin( Angle_ ) )
	
End Sub

Sub AngularSpring.computeAngle()
	
  Angle_ = BodyB_->getAngle() - BodyA_->getAngle()
  
  'Angle_ = ATan2( angleVector_.y, angleVector_.x )
	
End Sub

Sub AngularSpring.computeAngularVelocity()
	
	AngularVelocity_ = BodyB_->getAngularVelocity() - BodyA_->getAngularVelocity()
	
End Sub

Sub AngularSpring.computeReducedInertia()
	
	ReducedInertia_ = 1.0 / ( BodyA_->getInverseInertia() + BodyB_->getInverseInertia() )
	
	'ReducedInertia_ = ( BodyA_->getInertia() * BodyB_->getInertia() ) / _
	'                  ( BodyA_->getInertia() + BodyB_->getInertia() )
	
End Sub

Sub AngularSpring.computeTorque()
	
	Torque_ = -( stiffnes_ * INVERSE_DT_SQUARED * ( angle_ - restAngle_ ) + _
					 damping_  * INVERSE_DT         * angularVelocity_ ) * ReducedInertia_
	
End Sub


'' Get
Function AngularSpring.getAngle() As Single
	
	Return Angle_
	
End Function

Function AngularSpring.getAngleVector() As Vec2
	
	Return AngleVector_
	
End Function

Function AngularSpring.getAngularVelocity() As Single
	
	Return AngularVelocity_
	
End Function

Function AngularSpring.getDamping() As Single
	
	Return Damping_
	
End Function

Function AngularSpring.getReducedInertia() As Single
	
	Return ReducedInertia_
	
End Function

Function AngularSpring.getRestAngle() As Single
	
	Return RestAngle_
	
End Function

Function AngularSpring.getRestAngleVector() As Vec2
	
	Return RestAngleVector_
	
End Function

Function AngularSpring.getStiffnes() As Single
	
	Return Stiffnes_
	
End Function

Function AngularSpring.getTorque() As Single
	
	Return Torque_
	
End Function

Function AngularSpring.getBodyA() As Body Ptr
	
	Return BodyA_
	
End Function

Function AngularSpring.getBodyB() As Body Ptr
	
	Return BodyB_
	
End Function


'' Reset
Sub AngularSpring.ResetAll()
	
	BodyA_ = 0
	BodyB_ = 0
	
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
	Torque_          = 0.0
	
End Sub


'' Set
Sub AngularSpring.setDamping ( ByVal damping As Single )
	
	damping_ = damping
	
End Sub

Sub AngularSpring.setRestAngle ( ByVal restangle As Single )
	
	restAngle_ = restangle
	
End Sub

Sub AngularSpring.setRestAngleVector ( ByVal restanglevector As Vec2 )
	
	restAngleVector_ = restanglevector
	
End Sub

Sub AngularSpring.setStiffnes ( ByVal stiffnes As Single )
	
	stiffnes_ = stiffnes
	
End Sub

Sub AngularSpring.setBodyA ( ByRef bodya As Body Ptr )
	
	BodyA_ = IIf( bodya <> BodyB_ , bodya , 0 )
	
End Sub

Sub AngularSpring.setBodyB ( ByRef Bodyb As Body Ptr )
	
	BodyB_ = IIf( bodyb <> BodyA_ , bodyb , 0 )
	
End Sub


#EndIf ''__S2_ANGULAR_SPRING_BI__
