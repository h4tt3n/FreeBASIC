''*********************************************************************************
''
''   Squishy2D Pressurized Body Class
''   Written in FreeBASIC 1.05
''   version 0.2.0, May 2016, Michael "h4tt3n" Nissen
''
''   Particle -> Rotate -> Body -> SpringBody -> PressureBody
''
''*********************************************************************************


''
#Ifndef __S2_PRESSURE_BODY_BI__
#Define __S2_PRESSURE_BODY_BI__


''
Type PressureBody Extends SpringBody
	
	Public:
	
	'' Constructors
	Declare Constructor()
	Declare Constructor( ByRef b As PressureBody )
	
	'' Destructor
	Declare Destructor()
	 
	'' Operators
	Declare Operator Let( ByRef b As PressureBody )
	
	'' Apply
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	
	'' Compute
	Declare Sub ComputeArea()
	Declare Sub ComputeRestImpulse()
	
	'' Get
	Declare Const Function Area()      As Single
	Declare Const Function RestArea()  As Single
	Declare Const Function Cpressure() As Single
	
	'' Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	'' Set
	Declare Sub Area      ( ByVal a As Single )
	Declare Sub RestArea  ( ByVal r As Single )
	Declare Sub Cpressure ( ByVal p As Single )
	
	''
	'As AnyPtrArray  ClosedLoopSprings_
	As LinearSpringPtrArray  ClosedLoopSprings_
	
	'Protected:
	
	''
	As Single Area_
	As Single RestArea_
	As Single Cpressure_
	
End Type


'' Constructors
Constructor PressureBody()
	
	ResetAll()
	
End Constructor

Constructor PressureBody( ByRef b As PressureBody )
	
	ResetAll()
	
	This = b
	
End Constructor


'' Destructor
Destructor PressureBody()
	
	ResetAll()
	
End Destructor


'' Operators
Operator PressureBody.Let( ByRef b As PressureBody )
	
	If ( @This <> @b ) Then
		
		Area_      = b.Area_
		RestArea_  = b.RestArea_
		Cpressure_ = b.Cpressure_
		
		ClosedLoopSprings_ = b.ClosedLoopSprings_
		
		Cast( SpringBody, This ) = b
		
	EndIf
	
End Operator


'' Apply
Sub PressureBody.ApplyCorrectiveImpulse()
	
End Sub

Sub PressureBody.ApplyWarmStart()
	
End Sub


'' Compute
Sub PressureBody.ComputeArea()
	
	Area_ = 0.0
	
	For I As LinearSpring Ptr Ptr = ClosedLoopSprings_.p_front To ClosedLoopSprings_.p_back
		
		Dim As LinearSpring Ptr L = *I
		
		Area_ += L->ParticleA->Position.PerpDot( L->ParticleB->Position )
		
	Next
	
	Area_ *= 0.5
	
End Sub

Sub PressureBody.ComputeRestImpulse()
	
	'' needs improvement!
	'' impulses scaled by mass. 
	'' rest impulse, corrective impulse and warmstarting
	
	'Dim As Single scale_error = Sqr( Area_ ) - Sqr( RestArea_ )
	'Dim As Single scale_error = ( Sqr( Abs( Area_ ) ) - Sqr( RestArea_ ) ) * Sgn( Area_ )
	
	'Dim As Single area_error = Area_ - RestArea_
	'
	'For I As LinearSpring Ptr Ptr = ClosedLoopSprings_.p_front To ClosedLoopSprings_.p_back
	'	
	'	Dim As LinearSpring Ptr L = *I
	'	
	'	Dim As Single reduced_mass = 1.0 / ( L->InverseMass + InverseMass_ )
	'	
	'	'Dim As Vec2 PressureImpulse = -( Cpressure_ * area_error * L->AngleVector.Perp() )
	'	'Dim As Vec2 pressure_impulse = - Cpressure_ * scale_error * INV_DT * L->AngleVector.Perp()
	'	Dim As Vec2 pressure_impulse = -0.01 * area_error * reduced_mass * L->AngleVector.Perp()
	'	'Dim As Vec2 pressure_impulse = 0.0 * L->AngleVector.Perp()
	'   
	'  	L->AddImpulse( pressure_impulse * L->InverseMass )
	'  	
	'   This.AddImpulse( -pressure_impulse * InverseMass_ )
	'	
	'Next
	
End Sub


'' Get
Function PressureBody.Area() As Single
	
	Return Area_
	
End Function

Function PressureBody.RestArea() As Single
	
	Return RestArea_
	
End Function

Function PressureBody.Cpressure() As Single
	
	Return Cpressure_
	
End Function


'' Reset
Sub PressureBody.ResetAll()
	
	ResetVariables()
	
	ClosedLoopSprings_.Clear()
	
	Base.ResetAll()
	
End Sub

Sub PressureBody.ResetVariables()
	
	Area_      = 0.0
	RestArea_  = 0.0
	Cpressure_ = 0.0
	
	Base.ResetAll()
	
End Sub


'' Set
Sub PressureBody.Area ( ByVal a As Single )
	
	Area_ = a
	
End Sub

Sub PressureBody.RestArea ( ByVal r As Single )
	
	RestArea_ = r
	
End Sub

Sub PressureBody.Cpressure ( ByVal p As Single )
	
	Cpressure_ = p
	
End Sub


#EndIf ''__S2_PRESSURE_BODY_BI__