''*********************************************************************************
''
''   Squishy2D Spring Body Class
''   Written in FreeBASIC 1.05
''   version 0.2.0, May 2016, Michael "h4tt3n" Nissen
''
''
''*********************************************************************************


''
#Ifndef __S2_SPRING_BODY_BI__
#Define __S2_SPRING_BODY_BI__


''
Type SpringBody Extends Body
	
	Public:
	
	'' Constructors
	Declare Constructor()
	Declare Constructor( ByRef b As SpringBody )
	
	'' Destructor
	Declare Destructor()
	 
	'' Operators
	Declare Operator Let( ByRef b As SpringBody )
	
	'' Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	'Protected:
	
	''
	As AngularSpringPtrArray AngularSprings_
	As LinearSpringPtrArray  LinearSprings_
	
End Type


'' Constructors
Constructor SpringBody()
	
	ResetAll()
	
End Constructor

Constructor SpringBody( ByRef b As SpringBody )
	
	ResetAll()
	
	This = b
	
End Constructor


'' Destructor
Destructor SpringBody()

	ResetAll()
	
End Destructor


'' Operators
Operator SpringBody.Let( ByRef b As SpringBody )
	
	If ( @This <> @b ) Then
		
		AngularSprings_ = b.AngularSprings_
		LinearSprings_  = b.LinearSprings_
		
		Cast( Body, This ) = b
		
	EndIf
	
End Operator


'' Reset
Sub SpringBody.ResetAll()
	
	ResetVariables()
	
	AngularSprings_.Clear()
	LinearSprings_.Clear()
	
	Base.ResetAll()
	
End Sub

Sub SpringBody.ResetVariables()
	
	Base.ResetAll()
	
End Sub


#EndIf ''__S2_SPRING_BODY_BI__
