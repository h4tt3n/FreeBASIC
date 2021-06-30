''*******************************************************************************
''    
''   Squishy2D World Class
''   Written in FreeBASIC 1.04
''   version 0.1.0, November 2015, Michael "h4tt3n" Nissen
''
''******************************************************************************* 


''
#Ifndef __S2_WORLD_BI__
#Define __S2_WORLD_BI__


''
Type World
	
	Public:
	
	''
	Declare Constructor()
	Declare Constructor( ByRef w As World )
	
	''
	Declare Destructor()
	
	''
	Declare Operator Let( ByRef w As World )
	
	'Private:
	
	As AngularSpringArray    AngularSprings
	As BodyArray             Bodys
	As FixedAngleSpringArray FixedAngleSprings
	As LineSegmentArray      LineSegments
	As LinearSpringArray     LinearSprings
	As PointMassArray        PointMasses
	
End Type


''
Constructor World()
	
End Constructor

Constructor World( ByRef w As World )
	
	This = w
	
End Constructor


''
Destructor World()
	
	
	
End Destructor


''
Operator World.Let( ByRef w As World )
	
End Operator


#EndIf ''__S2_WORLD_BI__