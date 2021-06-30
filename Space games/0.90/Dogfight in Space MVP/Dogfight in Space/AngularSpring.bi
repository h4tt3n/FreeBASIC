''***************************************************************************
''  Angular spring type
''***************************************************************************

#Include Once "LinearSpring.bi"

Type AngularSpringType
  
  Public:
  
  ''	constructors
  Declare Constructor( ByVal stiffnes        As Float                = 0.0, _
                       ByVal damping         As Float                = 0.0, _
                       ByRef linearspringa   As LinearSpringType Ptr = 0, _
                       ByRef linearspringb   As LinearSpringType Ptr = 0 )
  
  Declare Constructor( ByVal stiffnes        As Float                = 0.0, _
                       ByVal damping         As Float                = 0.0, _
                       ByVal restAngleVector As Vec2f                = Vec2f(0.0, 0.0), _
                       ByRef linearspringa   As LinearSpringType Ptr = 0, _
                       ByRef linearspringb   As LinearSpringType Ptr = 0 )
  
  Declare Constructor( ByVal stiffnes        As Float                = 0.0, _
                       ByVal damping         As Float                = 0.0, _
                       ByVal restAngleScalar As Float                = 0.0, _
                       ByRef linearspringa   As LinearSpringType Ptr = 0, _
                       ByRef linearspringb   As LinearSpringType Ptr = 0 )
  
  ''  compute
  Declare Sub computeAngleScalar            ()
  Declare Sub computeAngleVector            ()
  Declare Sub computeAngularVelocity        ()
  Declare Sub computeReducedMomentOfInertia ()
  Declare Sub computeTorque                 ()
  
  ''  get
  Declare Function getAngleVector            () As Vec2f
  Declare Function getAngularVelocity        () As Float
  Declare Function getDamping                () As Float
  Declare Function getLinearSpringA          () As LinearSpringType Ptr
  Declare Function getLinearSpringB          () As LinearSpringType Ptr
  Declare Function getReducedMomentOfInertia () As Float
  Declare Function getRestAngleScalar        () As Float
  Declare Function getRestAngleVector        () As Vec2f
  Declare Function getStiffnes               () As Float
  Declare Function getTorque                 () As Float
  
  ''  set
  Declare Sub setDamping         ( ByVal damping         As Float )
  Declare Sub setLinearSpringA   ( ByRef linearspringa   As LinearSpringType Ptr )
  Declare Sub setLinearSpringB   ( ByRef linearspringb   As LinearSpringType Ptr )
  Declare Sub setRestAngleScalar ( ByVal restanglescalar As Float )
  Declare Sub setRestAngleVector ( ByVal restanglevector As Vec2f )
  Declare Sub setStiffnes        ( ByVal stiffnes        As Float )
  
  Protected:
  Private:
	
  As float                angleScalar_
  As vec2f                angleVector_
  As float                angularVelocity_
  As float                damping_
  As LinearSpringType Ptr linearSpringA_
  As LinearSpringType Ptr linearSpringB_
  As float                reducedMomentOfInertia_
  As float                restAngleScalar_
  As vec2f                restAngleVector_
  As float                stiffnes_
  As float                torque_
  
End Type


''	constructors
Constructor AngularSpringType( ByVal stiffnes        As Float, _
                               ByVal damping         As Float, _
                               ByRef linearspringa   As LinearSpringType Ptr, _
                               ByRef linearspringb   As LinearSpringType Ptr )
	
	setDamping       ( damping )
  setStiffnes      ( stiffnes )
  setLinearSpringA ( linearspringa )
  setLinearSpringB ( linearspringb )
  
  computeAngleVector()
  
  setRestAngleVector(angleVector_)
	
End Constructor

Constructor AngularSpringType( ByVal stiffnes        As Float, _
                               ByVal damping         As Float, _
                               ByVal restAngleVector As Vec2f, _
                               ByRef linearspringa   As LinearSpringType Ptr, _
                               ByRef linearspringb   As LinearSpringType Ptr )
	
	setDamping         ( damping )
  setStiffnes        ( stiffnes )
  setRestAngleVector ( restanglevector )
  setLinearSpringA   ( linearspringa )
  setLinearSpringB   ( linearspringb )
	
End Constructor

Constructor AngularSpringType( ByVal stiffnes        As Float, _
                               ByVal damping         As Float, _
                               ByVal restanglescalar As Float, _
                               ByRef linearspringa   As LinearSpringType Ptr, _
                               ByRef linearspringb   As LinearSpringType Ptr )
	
	setDamping         ( damping )
  setStiffnes        ( stiffnes )
  setRestAngleScalar ( restanglescalar )
  setLinearSpringA   ( linearspringa )
  setLinearSpringB   ( linearspringb )
	
End Constructor


''	compute
Sub AngularSpringType.computeAngleVector()
	
	angleVector_ = Vec2f( linearSpringA_->getN().dot  ( linearSpringB_->getN() ), _
												linearSpringA_->getN().cross( linearSpringB_->getN() ) )
	
	'angleVector_ = Vec2f( Cos( angleScalar_ ), Sin( angleScalar_ ) )
	
End Sub

Sub AngularSpringType.computeAngleScalar()
	
  angleScalar_ = ATan2( angleVector_.y, angleVector_.x )
	
End Sub

Sub AngularSpringType.computeAngularVelocity()
	
End Sub

Sub AngularSpringType.computeReducedMomentOfInertia()
	
End Sub

Sub AngularSpringType.computeTorque()
	
	torque_ = -( stiffnes_ * INVERSE_DT_SQUARED * ( angleScalar_ - restAngleScalar_ ) + _
							 damping_  * INVERSE_DT         * angularVelocity_ ) _
							 * reducedMomentOfInertia_
	
End Sub


''  get
Function AngularSpringType.getAngleVector() As Vec2f
	Return angleVector_
End Function

Function AngularSpringType.getAngularVelocity() As Float
	Return angularVelocity_
End Function

Function AngularSpringType.getDamping() As Float
	Return damping_
End Function

Function AngularSpringType.getReducedMomentOfInertia() As Float
	Return reducedMomentOfInertia_
End Function

Function AngularSpringType.getRestAngleScalar() As Float
	Return restAngleScalar_
End Function

Function AngularSpringType.getRestAngleVector() As Vec2f
	Return restAngleVector_
End Function

Function AngularSpringType.getStiffnes() As Float
	Return stiffnes_
End Function

Function AngularSpringType.getTorque() As Float
	Return torque_
End Function

Function AngularSpringType.getLinearSpringA() As LinearSpringType Ptr
	Return linearSpringA_
End Function

Function AngularSpringType.getLinearSpringB() As LinearSpringType Ptr
	Return linearSpringB_
End Function


  ''  set
Sub AngularSpringType.setDamping ( ByVal damping As Float )
	damping_ = damping
End Sub

Sub AngularSpringType.setRestAngleScalar ( ByVal restanglescalar As Float )
	restAngleScalar_ = restanglescalar
End Sub

Sub AngularSpringType.setRestAngleVector ( ByVal restanglevector As Vec2f )
	restAngleVector_ = restanglevector
End Sub

Sub AngularSpringType.setStiffnes ( ByVal stiffnes As Float )
	stiffnes_ = stiffnes
End Sub

Sub AngularSpringType.setLinearSpringA ( ByRef linearspringa As LinearSpringType Ptr )
	linearSpringA_ = linearspringa
End Sub

Sub AngularSpringType.setLinearSpringB ( ByRef linearspringb As LinearSpringType Ptr )
	linearSpringB_ = linearspringb
End Sub
