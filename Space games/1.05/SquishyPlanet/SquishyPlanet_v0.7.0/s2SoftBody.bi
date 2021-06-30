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
''   LinearState -> AngularState -> Body -> SoftBody
''
''
''*********************************************************************************


''
#Ifndef __S2_SOFT_BODY_BI__
#Define __S2_SOFT_BODY_BI__


''
Type SoftBody Extends Body
	
	Public:
	
	'' Constructors
	Declare Constructor()
	Declare Constructor( ByRef b As SoftBody )
	
	'' Destructor
	Declare Destructor()
	 
	'' Operators
	Declare Operator Let( ByRef b As SoftBody )
	
	Declare Sub ComputeNewState()
	
	'' Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	''
	As AngularSpringPtrArray AngularSprings_
	As LinearSpringPtrArray  LinearSprings_
	
End Type


'' Constructors
Constructor SoftBody()
	
	ResetAll()
	
End Constructor

Constructor SoftBody( ByRef b As SoftBody )
	
	ResetAll()
	
	This = b
	
End Constructor


'' Destructor
Destructor SoftBody()

	ResetAll()
	
End Destructor


'' Operators
Operator SoftBody.Let( ByRef b As SoftBody )
	
	If ( @This <> @b ) Then
		
		Cast( Body, This ) = b
		
		AngularSprings_ = b.AngularSprings_
		LinearSprings_  = b.LinearSprings_
		
	EndIf
	
End Operator

''
Sub SoftBody.ComputeNewState()
	
	Base.ComputeNewState()
	
	
	
End Sub


'' Reset
Sub SoftBody.ResetAll()
	
	ResetVariables()
	
	AngularSprings_.Destroy()
	LinearSprings_.Destroy()
	
	Base.ResetAll()
	
End Sub

Sub SoftBody.ResetVariables()
	
	Base.ResetAll()
	
End Sub


#EndIf ''__S2_SOFT_BODY_BI__
