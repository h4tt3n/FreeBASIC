''*********************************************************************************
''
''   SquishyPlanet - A 2D soft body and space physics library for games
''   Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''   Version 0.7.0, December 2016
''
''   Author:
''   Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''   Description:
''   This is the inherited base type of all body types.
''   It holds a list of the particles assigned to it and
''   takes care of overall, body-level rotation and translation.
''
''   LinearState -> AngularState -> Body
''
''*********************************************************************************


''
#Ifndef __S2_BODY_BI__
#Define __S2_BODY_BI__


''
Type Body Extends AngularState
	
	Public:
	
	'' Constructors
	Declare Constructor()
	Declare Constructor( ByRef b As Body )
	
	'' Destructor
	Declare Destructor()
	  
	'' Operators
	Declare Operator Let( ByRef b As Body )
	
	'' Apply
	Declare Sub ApplyImpulseDistribution( Byval c as Single )
	
	'' Add
	Declare Sub AddAngle           ( ByVal a As Single )
	Declare Sub AddAngleVector     ( ByVal a As Vec2 )
	Declare Sub AddAngularImpulse  ( ByVal a As Single )
	Declare Sub AddAngularVelocity ( ByVal a As Single )
	Declare Sub AddImpulse         ( ByVal i As Vec2 )
	Declare Sub AddVelocity        ( ByVal v As Vec2 )
	Declare Sub AddPosition        ( ByVal p As Vec2 )
	
	'' Compute
	Declare Sub ComputeAngularVelocity()
	Declare Sub ComputeArea()
	Declare Sub ComputeInertia()
	Declare Sub ComputeMass()
	Declare Sub ComputeNewState()
	Declare Sub ComputestateVectors()
	
	'' Get
	Declare Const Function GetPrevAngularImpulse() As Single
	Declare Const Function GetPrevLinearImpulse()  As Vec2 
	
	'' Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	'' Set
	Declare Sub SetAngle              ( ByVal a As Single )
	Declare Sub SetPosition           ( ByVal p As Vec2 )
	Declare Sub SetPrevAngularImpulse ( ByVal i As Single )
	Declare Sub SetPrevLinearImpulse  ( ByVal i As Vec2 )
	Declare Sub SetVelocity           ( ByVal v As Vec2 )
	
	'Protected:
	
	As Single Area_
	As Single RestArea_
	As Vec2   PrevLinearImpulse_
	As Single PrevAngularImpulse_
	
	As LinearStatePtrArray LinearStates_
	
End Type


'' Constructors
Constructor Body()
	
	Base()
	
	ResetAll()
	
End Constructor
	
Constructor Body( ByRef b As Body )
	
	ResetAll()
	
	This = b
	
End Constructor


'' Destructor
Destructor Body()
	
	ResetAll()
	
End Destructor


'' Operators
Operator Body.Let( ByRef b As Body )
	
	If ( @This <> @b ) Then
		
		Angle_           = b.Angle_
		AngleVector_     = b.AngleVector_
		AngularImpulse_  = b.AngularImpulse_
		AngularVelocity_ = b.AngularVelocity_
		Inertia_         = b.Inertia_
		InverseInertia_  = b.InverseInertia_
		LinearStates_    = b.LinearStates_
		
		Cast( AngularState, This ) = b
		
	EndIf
		
End Operator


'' Add
Sub Body.AddAngle( ByVal a As Single )
	
	Dim As Vec2 delta_angle = AngleToUnit( a )
	
	Base.AddAngle( a )
	
	Base.AddAngleVector( delta_angle )
	
	For I as LinearState Ptr Ptr = LinearStates_.p_front To LinearStates_.p_back
		
		Dim As LinearState Ptr P = *I
		
		Dim As Vec2 LocalPosition = P->GetPosition - Position_
			
		Dim As Vec2 NewPosition = delta_angle.RotateCCW( LocalPosition )
			
		P->SetPosition( Position_ - NewPosition )
		
	Next
	
End Sub

Sub Body.AddAngleVector( ByVal a As Vec2 )
	
	AngleVector_ = a.RotateCCW( AngleVector_ )
	
	Angle_ = UnitToAngle( AngleVector_ )
	
	For I as LinearState Ptr Ptr = LinearStates_.p_front To LinearStates_.p_back
		
		Dim As LinearState Ptr P = *I
		
		If Not P->GetFlag( IS_DYNAMIC ) Then
			
			Dim As Vec2 LocalPosition = P->GetPosition - Position_
			
			Dim As Vec2 NewPosition = a.RotateCCW( LocalPosition )
			
			P->SetPosition( Position_ - NewPosition )
		
		EndIf
		
	Next
	
End Sub

Sub Body.AddAngularImpulse( ByVal a As Single )
	
	Base.AddAngularImpulse( a )
	
	For I as LinearState Ptr Ptr = LinearStates_.p_front To LinearStates_.p_back
		
		Dim As LinearState Ptr P = *I
		
		Dim As Vec2 LocalPosition = P->GetPosition - Position_
		
		Dim As Vec2 LocalImpulse = LocalPosition.PerpDot( a )
		
		P->AddImpulse( LocalImpulse )
		
	Next
	
End Sub

Sub Body.AddAngularVelocity ( ByVal a As Single )
	
	Base.AddAngularVelocity( a )
	
	For I as LinearState Ptr Ptr = LinearStates_.p_front To LinearStates_.p_back
		
		Dim As LinearState Ptr P = *I
		
		Dim As Vec2 LocalPosition = P->GetPosition - Position_
		
		Dim As Vec2 LocalVelocity = LocalPosition.PerpDot( a )
		
		P->AddVelocity( LocalVelocity )
		
	Next
	
End Sub

Sub Body.AddImpulse( ByVal i As Vec2 )
	
	Base.AddImpulse( i )
	
	'For II as LinearState Ptr Ptr = LinearStates_.p_front To LinearStates_.p_back
	'	
	'	Dim As LinearState Ptr PP = *II
	'	
	'	PP->AddImpulse( i )
	'	
	'Next
	
End Sub

Sub Body.AddPosition( ByVal p As Vec2 )
	
	'Base.AddPosition( p )
	
	For I as LinearState Ptr Ptr = LinearStates_.p_front To LinearStates_.p_back
		
		Dim As LinearState Ptr PP = *I
		
		PP->AddPosition( p )
		
	Next
	
End Sub

Sub Body.AddVelocity( ByVal v As Vec2 )
	
	'Base.AddVelocity( v )
	
	For I as LinearState Ptr Ptr = LinearStates_.p_front To LinearStates_.p_back
		
		Dim As LinearState Ptr P = *I
		
		P->AddVelocity( v )
		
	Next
	
End Sub


'' Apply
Sub Body.ApplyImpulseDistribution( ByVal c As Single )
	
	'' This function sums up impulses applied to the individual LinearStates
	'' of the body, computes a global linear and angular impulse, and re-
	'' distributes this to all LinearStates.
	'' This makes the corrective impulse applied by one constraint influence
	'' all other connected constraints within the same iteration, not just
	'' within the same loop.
		
	'' 
	Dim As Vec2 LocalLinearMomentum = Vec2( 0.0, 0.0 )
	Dim As Single LocalAngularMomentum = 0.0
	
	''
	For I as LinearState Ptr Ptr = LinearStates_.p_front To LinearStates_.p_back
		
		Dim As LinearState Ptr P = *I
		
		Dim As Vec2 LocalPosition = P->GetPosition - Position_
		Dim As Vec2 LocalMomentum = P->GetImpulse * P->GetMass' * c
		
		LocalLinearMomentum += LocalMomentum
		
		LocalAngularMomentum += LocalPosition.perpdot( LocalMomentum )
		
		'P->Impulse( P->Impulse * ( 1.0 - c ) )
		
	Next
	
	'' 
	AddImpulse( LocalLinearMomentum * GetInverseMass - GetPrevLinearImpulse )
	AddAngularImpulse( LocalAngularMomentum * GetInverseInertia - GetPrevAngularImpulse )
	
	''
	For I as LinearState Ptr Ptr = LinearStates_.p_front To LinearStates_.p_back
		
		Dim As LinearState Ptr P = *I
		
		Dim As Vec2 LocalPosition = P->GetPosition - Position_
		
		P->SetImpulse( GetImpulse + LocalPosition.perpdot( GetAngularImpulse ) )
		'P->AddImpulse( Impulse + LocalPosition.perpdot( GetAngularImpulse ) )
		
	Next
	
	'' 
	SetPrevLinearImpulse( GetImpulse )
	SetPrevAngularImpulse( GetAngularImpulse )
	
End Sub


''	Compute
Sub Body.ComputeArea()
	
	
	
End Sub

Sub Body.computeAngularVelocity()
	
	'' This function computes the global soft body angular velocity.
	'' The angular momentum of each particle is summed up and
	'' divided by the global moment of inertia.
	
	AngularVelocity_ = 0.0
	
	For I as LinearState Ptr Ptr = LinearStates_.p_front To LinearStates_.p_back
		
		Dim As LinearState Ptr P = *I
		
		Dim As Vec2 LocalPosition = P->GetPosition - Position_
		Dim As Vec2 LocalVelocity = P->GetVelocity - Velocity_
		
		AngularVelocity_ += LocalPosition.PerpDot( LocalVelocity * P->GetMass )
		
	Next
	
	AngularVelocity_ *= InverseInertia_
	
End Sub

Sub Body.computeInertia()
	
	'' This function computes the global soft body moment of inertia,
	'' which is the rotational equivalent to inertial mass.
	
	Inertia_ = 0.0
	
	For I as LinearState Ptr Ptr = LinearStates_.p_front To LinearStates_.p_back
		
		Dim As LinearState Ptr P = *I
		
		Dim As Vec2 LocalPosition = P->GetPosition - Position_
		
		Inertia_ += LocalPosition.LengthSquared() * P->GetMass
		
	Next
	
	ComputeInverseInertia()
	
End Sub

Sub Body.computeMass()
	
	Mass_ = 0.0
	
	For I as LinearState Ptr Ptr = LinearStates_.p_front To LinearStates_.p_back
		
		Dim As LinearState Ptr P = *I
		
		Mass_ += P->GetMass
		
	Next
	
	ComputeInverseMass()
	
End Sub

Sub Body.ComputeNewState()
	
	'Base.ComputeNewState()
	
	'' Global Angular
		
	AngularVelocity_ += AngularImpulse_
		
	AngularVelocityVector_ = Vec2( Cos( AngularVelocity_ * DT ), _
		                            Sin( AngularVelocity_ * DT ) )
	
	Angle_ += AngularVelocity_ * DT
	AngleVector_ = AngleVector_.RotateCCW( AngularVelocityVector_ )
	
	AngularImpulse_ = 0.0
	
	For I as LinearState Ptr Ptr = LinearStates_.p_front To LinearStates_.p_back
		
		Dim As LinearState Ptr P = *I
		
		P->Impulse_ = Vec2( 0.0, 0.0 )
		
	Next
	
End Sub

Sub Body.computeStateVectors()
	
	Position_ = Vec2( 0.0, 0.0 )
	Velocity_ = Vec2( 0.0, 0.0 )
	
	For I as LinearState Ptr Ptr = LinearStates_.p_front To LinearStates_.p_back
		
		Dim As LinearState Ptr P = *I
		
		Position_ += P->Position_ * P->Mass_
		Velocity_ += P->Velocity_ * P->Mass_
		
	Next
	
	Position_ *= InverseMass_
	Velocity_ *= InverseMass_
	
End Sub


'' Get
Function Body.GetPrevAngularImpulse() As Single
	
	Return PrevAngularImpulse_
	
End Function

Function Body.GetPrevLinearImpulse()  As Vec2 
	
	Return PrevLinearImpulse_
	
End Function


'' Reset
Sub Body.ResetAll()
	
	ResetVariables()
	
	LinearStates_.Destroy()
	
	Base.ResetAll()
	
End Sub

Sub Body.ResetVariables()
	
	Base.ResetAll()
	
End Sub


'' Set
Sub Body.SetAngle( ByVal a As Single )
	
	AddAngle( a - GetAngle )
	
End Sub

Sub Body.SetPosition( ByVal p As Vec2 )
	
	Dim As Vec2 delta_postion = p - GetPosition()
	
	Base.Base.AddPosition( delta_postion )
	
	For I as LinearState Ptr Ptr = LinearStates_.p_front To LinearStates_.p_back
		
		Dim As LinearState Ptr PP = *I
		
		'PP->SetPosition( PP->GetPosition + p  )
		PP->AddPosition( delta_postion )
		
	Next
	
End Sub

Sub Body.SetPrevAngularImpulse( ByVal i As Single )
	
	PrevAngularImpulse_ = i
	
End Sub

Sub Body.SetPrevLinearImpulse( ByVal i As Vec2 )
	
	PrevLinearImpulse_ = i
	
End Sub

Sub Body.SetVelocity( ByVal v As Vec2 )
	
	For I as LinearState Ptr Ptr = LinearStates_.p_front To LinearStates_.p_back
		
		Dim As LinearState Ptr PP = *I
		
		PP->SetVelocity( v )
		
	Next
	
End Sub


#EndIf ''__S2_BODY_BI__
