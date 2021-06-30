''***************************************************************************
''
''   Squishy2D Fixed Angle Spring Class
''   Written in FreeBASIC 1.04
''   version 0.1.0, November 2015, Michael "h4tt3n" Nissen
''
''   This spring is really two 1D springs, which each try to keep the 
''   particles at a certain distance in the X and Y plane, respectively.
''   It is computationally very cheap, as it does not call sqr().
''
''***************************************************************************


''
#Ifndef __S2_FIXED_ANGLE_SPRING_BI__
#Define __S2_FIXED_ANGLE_SPRING_BI__


''
Type FixedAngleSpring Extends LineSegment
	
	Public:
	
	'' Constructors
	Declare Constructor()
	
	Declare Constructor( ByRef F As FixedAngleSpring )
	
	Declare Constructor( ByVal stiffnes   As Single, _
	                     ByVal damping    As Single, _
	                     ByRef PointMassa As PointMass Ptr, _
	                     ByRef PointMassb As PointMass Ptr )
	
	Declare Constructor( ByVal stiffnes   As Single, _
	                     ByVal damping    As Single, _
	                     ByVal restlength As Vec2, _
	                     ByRef PointMassa As PointMass Ptr, _
	                     ByRef PointMassb As PointMass Ptr )
	
	'' Operators
	Declare Operator Let( ByRef F As FixedAngleSpring )
	
	'' Compute
	Declare Sub computeForce       ()
	Declare Sub computeReducedMass ()
	Declare Sub computeVelocity    ()
	
	'' Get
	Declare Function getDamping     () As Single
	Declare Function getReducedMass () As Single
	Declare Function getRestlength  () As Vec2
	Declare Function getStiffnes    () As Single
	
	'' Reset
	Declare Sub ResetAll       ()
	Declare Sub ResetVariables ()
	
	'' Set
	Declare Sub setDamping    ( ByVal damping    As Single )
	Declare Sub setRestLength ( ByVal restlength As Vec2   )
	Declare Sub setStiffnes   ( ByVal stiffnes   As Single )
	
	Private:
	
	'' Variables
	As Single Damping_
	As Vec2   Force_
	As Single ReducedMass_
	As Vec2   RestLength_
	As Single Stiffnes_
	As Vec2   Velocity_
	
End Type


'' Constructors
Constructor FixedAngleSpring()
	
	ResetAll()
	
End Constructor
	
Constructor FixedAngleSpring( ByRef F As FixedAngleSpring )
	
	ResetAll()
	
	This = F
	
End Constructor

Constructor FixedAngleSpring( ByVal stiffnes   As Single, _
                              ByVal damping    As Single, _
                              ByRef PointMassa As PointMass Ptr, _
                              ByRef PointMassb As PointMass Ptr )
	
	ResetAll()
	
	setDamping    ( damping )
	setStiffnes   ( stiffnes )
	setPointMassA ( PointMassa )
	setPointMassB ( PointMassb )

End Constructor

Constructor FixedAngleSpring( ByVal stiffnes   As Single, _
                              ByVal damping    As Single, _
                              ByVal restlength As Vec2, _
                              ByRef PointMassa As PointMass Ptr, _
                              ByRef PointMassb As PointMass Ptr )
	
	ResetAll()
	
	setDamping    ( damping )
	setStiffnes   ( stiffnes )
	setRestLength ( restlength )
	setPointMassA ( PointMassa )
	setPointMassB ( PointMassb )

End Constructor


'' Operators
Operator FixedAngleSpring.Let( ByRef F As FixedAngleSpring )

	Damping_     = F.Damping_
	ReducedMass_ = F.ReducedMass_
	RestLength_  = F.RestLength_
	Stiffnes_    = F.Stiffnes_
	
	'Cast( LineSegment, This ) = Cast( LineSegment, F )
	Cast( LineSegment, This ) = F

End Operator


'' Compute
Sub FixedAngleSpring.computeForce()
	
	Dim As Vec2 displacement = LengthVector_ - restLength_
	
	force_ = -( stiffnes_ * INVERSE_DT_SQUARED * displacement + _
	            damping_  * INVERSE_DT         * velocity_ )  * reducedMass_
	
	PointMassA_->addForce( -force_ )
	PointMassB_->addForce(  force_ )

End Sub

Sub FixedAngleSpring.computeReducedMass()
	
	reducedMass_ = 1.0 / ( PointMassA_->getInverseMass() + PointMassB_->getInverseMass() )
	
End Sub

Sub FixedAngleSpring.computeVelocity()
	
	velocity_ = PointMassB_->getVelocity() - PointMassA_->getVelocity()
	
End Sub


'' Get
Function FixedAngleSpring.getDamping() As Single
	
	Return damping_
	
End Function

Function FixedAngleSpring.getReducedMass() As Single
	
	Return reducedMass_
	
End Function

Function FixedAngleSpring.getRestLength() As Vec2
	
	Return restLength_
	
End Function

Function FixedAngleSpring.getStiffnes() As Single
	
	Return stiffnes_
	
End Function


'' Reset
Sub FixedAngleSpring.ResetAll()
	
	ResetVariables()
	
	Base.ResetAll()
	
End Sub

Sub FixedAngleSpring.ResetVariables()
	
	Damping_     = 0.0
	ReducedMass_ = 0.0
	RestLength_  = Vec2( 0.0, 0.0 )
	Stiffnes_    = 0.0
	
	Base.ResetVariables()
	
End Sub


'' Set
Sub FixedAngleSpring.setDamping ( ByVal damping As Single )
	
	damping_ = damping
	
End Sub

Sub FixedAngleSpring.setRestLength ( ByVal restlength As Vec2 )
	
	restLength_ = restlength
	
End Sub

Sub FixedAngleSpring.setStiffnes ( ByVal stiffnes As Single )
	
	stiffnes_ = stiffnes
	
End Sub


#EndIf ''__S2_FIXED_ANGLE_SPRING_BI__
