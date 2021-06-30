''***************************************************************************
''
''   Squishy2D Linear Spring Class
''   Written in FreeBASIC 1.04
''   version 0.1.0, November 2015, Michael "h4tt3n" Nissen
''
''   LineSegment --> LinearSpring / FixedAngleSpring
''
''***************************************************************************


'' 
#Ifndef __S2_LINEAR_SPRING_BI__
#Define __S2_LINEAR_SPRING_BI__


''
Type LinearSpring Extends LineSegment
	
	Public:
	
	'' Constructors
	Declare Constructor()
	
	Declare Constructor( ByRef L As LinearSpring )
	
	Declare Constructor( ByVal stiffnes   As Single, _
	                     ByVal damping    As Single, _
	                     ByRef PointMassA As PointMass Ptr, _
	                     ByRef PointMassB As PointMass Ptr )
	
	Declare Constructor( ByVal stiffnes   As Single, _
	                     ByVal damping    As Single, _
	                     ByVal restlength As Single, _
	                     ByRef PointMassA As PointMass Ptr, _
	                     ByRef PointMassB As PointMass Ptr )
	
	''	Operator
	Declare Operator Let( ByRef L As LinearSpring )
	
	'' Compute
	Declare Sub computeForce()
	Declare Sub computeReducedMass()
	Declare Sub computeProjectedVelocity()
	
	'' Get
	Declare Function getDamping           () As Single
	Declare Function getStiffnes          () As Single
	Declare Function getRestLength        () As Single
	Declare Function getReducedMass       () As Single
	Declare Function getProjectedVelocity () As Single
	
	''	Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	'' Set
	Declare Sub setDamping    ( ByVal damping    As Single )
	Declare Sub setRestLength ( ByVal restlength As Single )
	Declare Sub setStiffnes   ( ByVal stiffnes   As Single )
	
	Private:
	
	''	Variables
	As Single Damping_
	As Vec2   Force_
	As Vec2   Impulse_
	As Single ProjectedVelocity_
	As Single ReducedMass_
	As Single RestLength_
	As Single Stiffnes_
	
End Type


'' Constructors
Constructor LinearSpring()
	
	ResetAll()
	
End Constructor

Constructor LinearSpring( ByRef L As LinearSpring )
	
	ResetAll()
	
	This = L
	
End Constructor

Constructor LinearSpring( ByVal stiffnes   As Single, _
                          ByVal damping    As Single, _
                          ByRef PointMassa As PointMass Ptr, _
                          ByRef PointMassb As PointMass Ptr )
	
	ResetAll()
	
'	Base( PointMassa, PointMassb )
	
	setDamping    ( damping )
	setStiffnes   ( stiffnes )
	setPointMassA ( PointMassa )
	setPointMassB ( PointMassb )

End Constructor

Constructor LinearSpring( ByVal stiffnes   As Single, _
                          ByVal damping    As Single, _
                          ByVal restlength As Single, _
                          ByRef PointMassa As PointMass Ptr, _
                          ByRef PointMassb As PointMass Ptr )
	
	ResetAll()

'	Base( PointMassa, PointMassb )

	setDamping    ( damping )
	setStiffnes   ( stiffnes )
	setRestLength ( restlength )
	setPointMassA ( PointMassA )
	setPointMassB ( PointMassA )

End Constructor


'' Operators
Operator LinearSpring.Let( ByRef L As LinearSpring )

	Damping_           = L.Damping_
	Force_             = L.Force_
	ProjectedVelocity_ = L.ProjectedVelocity_
	ReducedMass_       = L.ReducedMass_
	RestLength_        = L.RestLength_
	Stiffnes_          = L.Stiffnes_
	
	Cast( LineSegment, This ) = L
	'Cast( LineSegment, This ) = Cast( LineSegment, L )

End Operator


'' Compute
Sub LinearSpring.computeForce()
	
	'Dim As Single displacement = length_ - restLength_
	
	Force_ = -( Stiffnes_ * INVERSE_DT_SQUARED * ( Length_ - RestLength_ ) + _
	            Damping_  * INVERSE_DT         * ProjectedVelocity_ ) * _
	            ReducedMass_ * LengthUnit_
	
	PointMassA_->AddForce( -Force_ )
	PointMassB_->AddForce(  Force_ )
	
End Sub

Sub LinearSpring.computeReducedMass()
	
	ReducedMass_ = 1.0 / ( PointMassA_->getInverseMass() + PointMassB_->getInverseMass() )
	
	'ReducedMass_ = ( PointMassA_->getMass() * PointMassB_->getMass() ) / _
	'               ( PointMassA_->getMass() + PointMassB_->getMass() )
	
End Sub

Sub LinearSpring.computeProjectedVelocity()
	
	Dim As Vec2 velocity = PointMassB_->getVelocity() - PointMassA_->getVelocity()
	
	projectedVelocity_ = velocity.Dot( LengthUnit_ )
	
End Sub


'' Get
Function LinearSpring.getStiffnes() As Single
	
	Return Stiffnes_
	
End Function

Function LinearSpring.getDamping() As Single
	
	Return Damping_
	
End Function

Function LinearSpring.getRestLength() As Single
	
	Return RestLength_
	
End Function

Function LinearSpring.getReducedMass() As Single
	
	Return ReducedMass_
	
End Function


''	Reset
Sub LinearSpring.ResetAll()
	
	ResetVariables()
	
	Base.ResetAll()
	
End Sub

Sub LinearSpring.ResetVariables()
	
	Damping_           = 0.0
	Force_             = Vec2( 0.0, 0.0 )
	ProjectedVelocity_ = 0.0
	ReducedMass_       = 0.0
	RestLength_        = 0.0
	Stiffnes_          = 0.0	
	
	Base.ResetVariables()
	
End Sub


'' Set
Sub LinearSpring.setDamping ( ByVal damping    As Single )
	
	Damping_ = damping
	
End Sub

Sub LinearSpring.setRestLength ( ByVal restlength As Single )
	
	RestLength_ = restlength
	
End Sub

Sub LinearSpring.setStiffnes ( ByVal stiffnes   As Single )
	
	Stiffnes_ = stiffnes
	
End Sub


#EndIf ''__S2_LINEAR_SPRING_BI__
