''***************************************************************************
''  Fixed angle spring type
''***************************************************************************

Type FixedAngleSpringType
  
  Public:
  
  ''	constructor
  Declare Constructor( ByVal stiffnes   As Float, _
  							  ByVal damping    As Float, _		
  							  ByRef Translatea As PointMassType Ptr, _
  							  ByRef Translateb As PointMassType Ptr )
  
  Declare Constructor( ByVal stiffnes   As Float, _
  							  ByVal damping    As Float, _
  							  ByVal restlength As Vec2f, _			
  							  ByRef Translatea As PointMassType Ptr, _
  							  ByRef Translateb As PointMassType Ptr )
  
  ''  compute
  Declare Sub computeForce       ()
  Declare Sub computeLength      ()
  Declare Sub computeReducedMass ()
  Declare Sub computeVelocity    ()
  
  ''  get
  Declare Function getDamping     () As Float
  Declare Function getForce       () As Vec2f
  Declare Function getLength      () As Vec2f
  Declare Function getReducedMass () As FLoat
  Declare Function getRestlength  () As Vec2f
  Declare Function getStiffnes    () As Float
  Declare Function getVelocity    () As Vec2f
  Declare Function getTranslateA  () As PointMassType Ptr
  Declare Function getTranslateB  () As PointMassType Ptr
  
  ''  set
  Declare Sub setDamping    ( ByVal damping    As Float )
  Declare Sub setRestLength ( ByVal restlength As Vec2f )
  Declare Sub setStiffnes   ( ByVal stiffnes   As Float )
  Declare Sub setTranslateA ( ByRef Translatea As PointMassType Ptr )
  Declare Sub setTranslateB ( ByRef Translateb As PointMassType Ptr )
  
  Private:
  
  As float stiffnes_
  As float damping_
  As float reducedMass_
  
  As vec2f length_
  As vec2f restLength_
  As vec2f force_
  As vec2f velocity_
  
  As PointMassType Ptr TranslateA_
  As PointMassType Ptr TranslateB_
  
End Type


''	constructors
Constructor FixedAngleSpringType( ByVal stiffnes       As Float, _
  										            ByVal damping        As Float, _		
  										            ByRef Translatea As PointMassType Ptr, _
  										            ByRef Translateb As PointMassType Ptr )
	
	setDamping        ( damping )
  setStiffnes       ( stiffnes )
  setTranslateA ( Translatea )
  setTranslateB ( Translateb )	
	
End Constructor

Constructor FixedAngleSpringType( ByVal stiffnes       As Float, _
  										            ByVal damping        As Float, _
  										            ByVal restlength     As Vec2f, _	
  										            ByRef Translatea As PointMassType Ptr, _
  										            ByRef Translateb As PointMassType Ptr )
	
	setDamping        ( damping )
  setStiffnes       ( stiffnes )
  setRestLength     ( restlength )
  setTranslateA ( Translatea )
  setTranslateB ( Translateb )	
	
End Constructor



''	compute
Sub FixedAngleSpringType.computeForce()
	
	Dim As Vec2f displacement = length_ - restLength_

  force_ = -( stiffnes_ * INVERSE_DT_SQUARED * displacement + _
              damping_  * INVERSE_DT         * velocity_ )  * reducedMass_

  TranslateA_->setForce( TranslateA_->getForce() - force_ )
  TranslateB_->setForce( TranslateB_->getForce() + force_ )

End Sub

Sub FixedAngleSpringType.computeLength()
	
	length_ = TranslateB_->getPosition() - TranslateA_->getPosition()
	
End Sub

Sub FixedAngleSpringType.computeReducedMass()
	
	reducedMass_ = 1.0 / ( TranslateA_->getInverseMass() + TranslateB_->getInverseMass() )
	
End Sub

Sub FixedAngleSpringType.computeVelocity()
	
	velocity_ = TranslateB_->getVelocity() - TranslateA_->getVelocity()
	
End Sub


''	get
Function FixedAngleSpringType.getDamping() As Float
	Return damping_
End Function

Function FixedAngleSpringType.getForce() As Vec2f
	Return force_
End Function

Function FixedAngleSpringType.getLength() As Vec2f
	Return length_
End Function

Function FixedAngleSpringType.getReducedMass() As Float
	Return reducedMass_
End Function

Function FixedAngleSpringType.getRestLength() As Vec2f
	Return restLength_
End Function

Function FixedAngleSpringType.getStiffnes() As Float
	Return stiffnes_
End Function

Function FixedAngleSpringType.getVelocity() As Vec2f
	Return velocity_
End Function

Function FixedAngleSpringType.getTranslateA() As PointMassType Ptr
	Return TranslateA_
End Function

Function FixedAngleSpringType.getTranslateB() As PointMassType Ptr
	Return TranslateB_
End Function


''	set
Sub FixedAngleSpringType.setDamping ( ByVal damping As Float )
	damping_ = damping
End Sub

Sub FixedAngleSpringType.setRestLength ( ByVal restlength As Vec2f )
	restLength_ = restlength
End Sub

Sub FixedAngleSpringType.setStiffnes ( ByVal stiffnes As Float )
	stiffnes_ = stiffnes
End Sub

Sub FixedAngleSpringType.setTranslateA ( ByRef Translatea As PointMassType Ptr )
	TranslateA_ = Translatea
End Sub

Sub FixedAngleSpringType.setTranslateB ( ByRef Translateb As PointMassType Ptr )
	TranslateB_ = Translateb
End Sub
