''******************************************************************************
''
''   Squishy2D Angular Spring Class
''   Written in FreeBASIC 1.04
''   version 0.1.0, November 2015, Michael "h4tt3n" Nissen
''
''   This "lite" angular spring only works between two linear springs.
 ''   
''
''******************************************************************************


''
#Ifndef __S2_ANGULITE_SPRING_BI__
#Define __S2_ANGULITE_SPRING_BI__


''
Type AnguliteSpring
	
	Public:
	
	''	Constructors
	Declare Constructor()
	
	Declare Constructor( ByRef a As AnguliteSpring )
	
	Declare Constructor( ByVal _stiffnes      As Single, _
	                     ByVal _damping       As Single, _
	                     ByRef _linearspringa As LinearSpring Ptr, _
	                     ByRef _linearspringb As LinearSpring Ptr )
	
	Declare Constructor( ByVal _stiffnes        As Single, _
	                     ByVal _damping         As Single, _
	                     ByVal _restanglevector As Vec2, _
	                     ByRef _linearspringa   As LinearSpring Ptr, _
	                     ByRef _linearspringb   As LinearSpring Ptr )
	
	Declare Constructor( ByVal _stiffnes      As Single, _
	                     ByVal _damping       As Single, _
	                     ByVal _restangle     As Single, _
	                     ByRef _linearspringa As LinearSpring Ptr, _
	                     ByRef _linearspringb As LinearSpring Ptr )
	
	''	Operators
	Declare Operator Let( ByRef a As AnguliteSpring )
	
	'' Apply
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	
	'' Compute
	Declare Sub ComputeAngleVector()
	Declare Sub ComputeReducedInertia()
	Declare Sub ComputeRestImpulse()
	
	'' Get
	Declare Const Function AngleVector     () As Vec2
	Declare Const Function Corrective      () As Single
	Declare Const Function Damping         () As Single
	Declare Const Function LinearSpringA   () As LinearSpring Ptr
	Declare Const Function LinearSpringB   () As LinearSpring Ptr
	Declare Const Function ReducedInertia  () As Single
	Declare Const Function RestAngleVector () As Vec2
	Declare Const Function Stiffnes        () As Single
	Declare Const Function Warmstart       () As Single
	
	'' Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	'' Set
	Declare Sub Damping         ( ByVal d As Single )
	Declare Sub Corrective      ( ByVal c As Single )
	Declare Sub LinearSpringA   ( ByRef a As LinearSpring Ptr )
	Declare Sub LinearSpringB   ( ByRef b As LinearSpring Ptr )
	Declare Sub RestAngleVector ( ByVal r As Vec2   )
	Declare Sub Stiffnes        ( ByVal s As Single )
	Declare Sub Warmstart       ( ByVal w As Single )
	
	Private:
	
	'' Variables
	As Vec2   AngleVector_
	As Single Corrective_
	As Single Damping_
	As Single AccumulatedImpulse_
	As Single ReducedInertia_
	As Vec2   RestAngleVector_
	As Single RestImpulse_
	As Single Stiffnes_
	As Single Warmstart_
	
	'' LinearSpring Ptrs
	As LinearSpring Ptr LinearSpringA_
	As LinearSpring Ptr LinearSpringB_
	
End Type


''	Constructors
Constructor AnguliteSpring()
	
	ResetAll()
	
End Constructor

Constructor AnguliteSpring( ByRef a As AnguliteSpring )
	
	ResetAll()
	
	This = a
	
End Constructor

Constructor AnguliteSpring( ByVal _stiffnes      As Single, _
                            ByVal _damping       As Single, _
                            ByRef _LinearSpringa As LinearSpring Ptr, _
                            ByRef _LinearSpringb As LinearSpring Ptr )
	
	ResetAll()
		
	LinearSpringA ( _LinearSpringa )
	LinearSpringB ( _LinearSpringb )
	Damping       ( _damping )
	Stiffnes      ( _stiffnes )
	
	Corrective( COEFF_CORRECTIVE )
	WarmStart ( COEFF_WARMSTART )
	
	ComputeAngleVector()
	
	RestAngleVector( AngleVector )
	
	ComputeReducedInertia()
	
End Constructor

Constructor AnguliteSpring( ByVal _stiffnes        As Single, _
                            ByVal _damping         As Single, _
                            ByVal _restAngleVector As Vec2, _
                            ByRef _LinearSpringa   As LinearSpring Ptr, _
                            ByRef _LinearSpringb   As LinearSpring Ptr )
	
	ResetAll()
	
	LinearSpringA   ( _LinearSpringa )
	LinearSpringB   ( _LinearSpringb )
	Damping         ( _damping )
	Stiffnes        ( _stiffnes )
	RestAngleVector ( _restanglevector )
	
	Corrective( COEFF_CORRECTIVE )
	WarmStart ( COEFF_WARMSTART )
	
	ComputeReducedInertia()
	
End Constructor

Constructor AnguliteSpring( ByVal _stiffnes      As Single, _
	                         ByVal _damping       As Single, _
	                         ByVal _restangle     As Single, _
	                         ByRef _linearspringa As LinearSpring Ptr, _
	                         ByRef _linearspringb As LinearSpring Ptr )
	
	ResetAll()
	
	LinearSpringA   ( _LinearSpringa )
	LinearSpringB   ( _LinearSpringb )
	Damping         ( _damping )
	Stiffnes        ( _stiffnes )
	RestAngleVector ( AngleToUnit( _restangle ) )
	
	Corrective( COEFF_CORRECTIVE )
	WarmStart ( COEFF_WARMSTART )
	
	ComputeReducedInertia()
	
End Constructor


'' Operators
Operator AnguliteSpring.Let( ByRef a As AnguliteSpring )
	
	ResetAll()
	
	AngleVector_        = a.AngleVector_
	Corrective_         = a.Corrective_
	LinearSpringA_      = a.LinearSpringA_
	LinearSpringB_      = a.LinearSpringB_
	Damping_            = a.Damping_
	AccumulatedImpulse_ = a.AccumulatedImpulse_
	ReducedInertia_     = a.ReducedInertia_
	RestAngleVector_    = a.RestAngleVector_
	RestImpulse_        = a.RestImpulse_
	Stiffnes_           = a.Stiffnes_
	Warmstart_          = a.Warmstart_
	
End Operator


'' Apply
Sub AnguliteSpring.ApplyCorrectiveImpulse()
	
	Dim As Single delta_impulse = LinearSpringB->AngularImpulse - LinearSpringA->AngularImpulse
		
	Dim As Single impulse_error = delta_impulse - RestImpulse_
	
	Dim As Single corrective_impulse = -Corrective_ * impulse_error * ReducedInertia_
	
	LinearSpringA->AddAngularImpulse( -corrective_impulse * LinearSpringA->InverseInertia )
	LinearSpringB->AddAngularImpulse(  corrective_impulse * LinearSpringB->InverseInertia )
	
	AccumulatedImpulse_ += corrective_impulse
	
End Sub

Sub AnguliteSpring.ApplyWarmStart()
		
	Dim As Single warmstart_impulse = Warmstart_ * AccumulatedImpulse_
	
	LinearSpringA->AddAngularImpulse( -warmstart_impulse * LinearSpringA->InverseInertia )
	LinearSpringB->AddAngularImpulse(  warmstart_impulse * LinearSpringB->InverseInertia )

	AccumulatedImpulse_ = 0.0
	
End Sub


''	Compute
Sub AnguliteSpring.computeAngleVector()
	
	AngleVector_ = Vec2( LinearSpringA->LengthUnit.Dot    ( LinearSpringB->LengthUnit ), _
								LinearSpringA->LengthUnit.PerpDot( LinearSpringB->LengthUnit ) )
	
End Sub   

Sub AnguliteSpring.computeReducedInertia()
	
	ReducedInertia_ = 1.0 / ( LinearSpringA->InverseInertia + LinearSpringB->InverseInertia )
	
End Sub

Sub AnguliteSpring.computeRestImpulse()
	
	Dim As Single angle_error = RestAngleVector_.PerpDot( AngleVector_ )
	
	Dim As Single velocity_error = LinearSpringB->AngularVelocity - LinearSpringA->AngularVelocity
	
	RestImpulse_ = - stiffnes_ * INV_DT * angle_error - damping_ * velocity_error
	
End Sub


'' Get
Function AnguliteSpring.AngleVector() As Vec2
	
	Return AngleVector_
	
End Function

Function AnguliteSpring.Corrective() As Single
	
	Return Corrective_
	
End Function

Function AnguliteSpring.Damping() As Single
	
	Return Damping_
	
End Function

Function AnguliteSpring.ReducedInertia() As Single
	
	Return ReducedInertia_
	
End Function

Function AnguliteSpring.RestAngleVector() As Vec2
	
	Return RestAngleVector_
	
End Function

Function AnguliteSpring.Stiffnes() As Single
	
	Return Stiffnes_
	
End Function

Function AnguliteSpring.Warmstart() As Single
	
	Return Warmstart_
	
End Function

Function AnguliteSpring.LinearSpringA() As LinearSpring Ptr
	
	Return LinearSpringA_
	
End Function

Function AnguliteSpring.LinearSpringB() As LinearSpring Ptr
	
	Return LinearSpringB_
	
End Function


'' Reset
Sub AnguliteSpring.ResetAll()
	
	LinearSpringA_ = 0
	LinearSpringB_ = 0
	
	ResetVariables()
	
End Sub

Sub AnguliteSpring.ResetVariables()
	
	AngleVector_        = Vec2( 0.0, 0.0 )
	Corrective_         = 0.0
	Damping_            = 0.0
	AccumulatedImpulse_ = 0.0
	ReducedInertia_     = 0.0
	RestAngleVector_    = Vec2( 0.0, 0.0 )
	RestImpulse_        = 0.0
	Stiffnes_           = 0.0
	Warmstart_          = 0.0
	
End Sub


'' Set
Sub AnguliteSpring.Corrective ( ByVal c As Single )
	
	Corrective_ = c
	
End Sub

Sub AnguliteSpring.Damping ( ByVal d As Single )
	
	damping_ = d
	
End Sub

Sub AnguliteSpring.RestAngleVector ( ByVal r As Vec2 )
	
	restAngleVector_ = r
	
End Sub

Sub AnguliteSpring.Stiffnes ( ByVal s As Single )
	
	stiffnes_ = s
	
End Sub

Sub AnguliteSpring.Warmstart ( ByVal w As Single )
	
	Warmstart_ = w
	
End Sub

Sub AnguliteSpring.LinearSpringA ( ByRef a As LinearSpring Ptr )
	
	LinearSpringA_ = IIf( a <> LinearSpringB_ , a , 0 )
	
End Sub

Sub AnguliteSpring.LinearSpringB ( ByRef b As LinearSpring Ptr )
	
	LinearSpringB_ = IIf( b <> LinearSpringA_ , b , 0 )
	
End Sub


#EndIf ''__S2_ANGULITE_SPRING_BI__
