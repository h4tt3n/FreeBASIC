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
''   This is a deformable body using shape-matching to restore original form.
''   It uses fixed-angle springs, which are very cpu-cheap, and adjust their
''   rest angle to body angle. 
''   The shape-matching body can optionally be pressurized for jelly or 
''   "squishy-ball" effect, or it can be kept un-pressurized for girders, vines,
''   or spider web effects.
''
''   Class inheritance map:
''
''   LinearState -> AngularState -> Body -> ShapeBody
''
''
''*********************************************************************************


''
#Ifndef __S2_SHAPE_BODY_BI__
#Define __S2_SHAPE_BODY_BI__


Type ShapeBody Extends Body
	
	Public:
	
	Declare Constructor()
	
	Declare Constructor( ByRef s As ShapeBody )
	
	Declare Destructor()
	 
	Declare Operator Let( ByRef s As ShapeBody )
	
	Declare Sub ComputeNewState()
	
	'' Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	'Protected:
	
	As FixedSpringPtrArray FixedSprings_
	
End Type


'' Constructors
Constructor ShapeBody()
	
	ResetAll()
	
End Constructor

Constructor ShapeBody( ByRef s As ShapeBody )
	
	ResetAll()
	
	This = s
	
End Constructor


'' Destructor
Destructor ShapeBody()
	
	ResetAll()
	
End Destructor

 
'' Operators
Operator ShapeBody.Let( ByRef s As ShapeBody )
	
	If ( @This <> @s ) Then
		
		Cast( Body, This ) = s
		
		FixedSprings_ = s.FixedSprings_
		
	EndIf
	
End Operator


''
Sub ShapeBody.ComputeNewState()
	
	'' This function rotates all fixed-spring rest angles to match 
	'' softbody global angle.
	
	Base.ComputeNewState()
	
	If ( Not FixedSprings_.empty ) Then
		
		For I As FixedSpring Ptr Ptr = FixedSprings_.p_front To FixedSprings_.p_back
			
			Dim As FixedSpring Ptr F = *I
			
			F->SetRestLength( F->GetRestLength.RotateCCW( AngularVelocityVector_ ) )
			
			F->SetImpulse( Vec2( 0.0, 0.0 ) )
			
		Next
		
	EndIf
	
End Sub


'' Reset
Sub ShapeBody.ResetAll()
	
	Base.ResetAll()
	
	FixedSprings_.Destroy()
	LinearStates_.Destroy()
	
End Sub

Sub ShapeBody.ResetVariables()
	
	Base.ResetVariables()
	
End Sub


''
#EndIf '' __S2_SHAPE_BODY_BI__
