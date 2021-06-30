''***************************************************************************
''  Linear spring type
''***************************************************************************

Type LinearSpringType
  
  Public:
  
  ''	constructors
  Declare Constructor( ByVal stiffnes       As Float, _
  										 ByVal damping        As Float, _	
  										 ByRef Translatea As PointMassType Ptr, _
  										 ByRef Translateb As PointMassType Ptr )
  
  Declare Constructor( ByVal stiffnes       As Float, _
  										 ByVal damping        As Float, _
  										 ByVal restlength     As Float, _			
  										 ByRef Translatea As PointMassType Ptr, _
  										 ByRef Translateb As PointMassType Ptr )
  
  ''  compute
  Declare Sub computeForce             ()
  Declare Sub computeLength            ()
  Declare Sub computeN                 ()
  Declare Sub computeReducedMass       ()
  Declare Sub computeProjectedVelocity ()
  
  ''  get
  Declare Function getStiffnes          () As Float
  Declare Function getDamping           () As Float
  Declare Function getRestLength        () As Float
  Declare Function getLength            () As Float
  Declare Function getReducedMass       () As Float
  Declare Function getProjectedVelocity () As Float
  Declare Function getN                 () As vec2f
  Declare Function getForce             () As vec2f
  Declare Function getTranslateA    () As PointMassType Ptr
  Declare Function getTranslateB    () As PointMassType Ptr
  
  ''  set
  Declare Sub setDamping        ( ByVal damping    As Float )
  Declare Sub setRestLength     ( ByVal restlength As Float )
  Declare Sub setStiffnes       ( ByVal stiffnes   As Float )
  Declare Sub setTranslateA ( ByRef Translatea As PointMassType Ptr )
  Declare Sub setTranslateB ( ByRef Translateb As PointMassType Ptr )
  
  Private:
  
  As float damping_
  As float length_
  As float projectedVelocity_
  As float reducedMass_
  As float restLength_
  As float stiffnes_
  
  As vec2f force_
  As vec2f n_
  
  As PointMassType Ptr TranslateA_
  As PointMassType Ptr TranslateB_
  
End Type



''	constructors
Constructor LinearSpringType( ByVal stiffnes       As Float, _
  										        ByVal damping        As Float, _	
  										        ByRef Translatea As PointMassType Ptr, _
  										        ByRef Translateb As PointMassType Ptr )
	
	setDamping        ( damping )
  setStiffnes       ( stiffnes )
  setTranslateA ( Translatea )
  setTranslateB ( Translateb )
	
End Constructor

Constructor LinearSpringType( ByVal stiffnes       As Float, _
  										        ByVal damping        As Float, _
  										        ByVal restlength     As Float, _			
  										        ByRef Translatea As PointMassType Ptr, _
  										        ByRef Translateb As PointMassType Ptr )
	
	setDamping        ( damping )
  setStiffnes       ( stiffnes )
  setRestLength     ( restlength )
  setTranslateA ( Translatea )
  setTranslateB ( Translateb )
	
End Constructor

Sub LinearSpringType.computeForce()
	
	'Dim As float displacement = length_ - restLength_

  force_ = -( stiffnes_ * INVERSE_DT_SQUARED * ( length_ - restLength_ ) + _
              damping_  * INVERSE_DT         * projectedVelocity_ ) * _
              reducedMass_ * n_

  TranslateA_->setForce( TranslateA_->getForce() - force_ )
  TranslateB_->setForce( TranslateB_->getForce() + force_ )
  
End Sub

Sub LinearSpringType.computeLength()
	
End Sub

Sub LinearSpringType.computeN()
	
End Sub

Sub LinearSpringType.computeReducedMass()
	
	reducedMass_ = 1.0 / ( TranslateA_->getInverseMass() + TranslateB_->getInverseMass() )
	
End Sub

Sub LinearSpringType.computeProjectedVelocity()
	
	Dim As Vec2f velocity = TranslateB_->getVelocity() - _
                     			TranslateA_->getVelocity()
	
  projectedVelocity_ = velocity.dot(n_)
  
End Sub

Function LinearSpringType.getStiffnes() As Float
	Return stiffnes_
End Function

Function LinearSpringType.getDamping() As Float
	Return damping_
End Function

Function LinearSpringType.getRestLength() As Float
	Return restLength_
End Function

Function LinearSpringType.getLength() As Float
	Return length_
End Function

Function LinearSpringType.getReducedMass() As Float
	Return reducedMass_
End Function

Function LinearSpringType.getForce() As vec2f
	Return force_
End Function

Function LinearSpringType.getN() As vec2f
	Return n_
End Function

Function LinearSpringType.getTranslateA () As PointMassType Ptr
	Return TranslateA_
End Function

Function LinearSpringType.getTranslateB () As PointMassType Ptr
	Return TranslateB_
End Function

Sub LinearSpringType.setDamping ( ByVal damping    As Float )
	damping_ = damping
End Sub

Sub LinearSpringType.setRestLength ( ByVal restlength As Float )
	restLength_ = restlength
End Sub

Sub LinearSpringType.setStiffnes ( ByVal stiffnes   As Float )
	stiffnes_ = stiffnes
End Sub

Sub LinearSpringType.setTranslateA ( ByRef Translatea As PointMassType Ptr )
	TranslateA_ = Translatea
End Sub

Sub LinearSpringType.setTranslateB ( ByRef Translateb As PointMassType Ptr )
	TranslateB_ = Translateb
End Sub
