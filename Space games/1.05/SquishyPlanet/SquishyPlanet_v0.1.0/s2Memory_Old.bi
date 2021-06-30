''*******************************************************************************
''    
''   Squishy2D Memory Management Class
''   Written in FreeBASIC 1.04
''   version 0.1.0, November 2015, Michael "h4tt3n" Nissen
''
''*******************************************************************************


''
#Ifndef __S2_MEMORY_BI__
#Define __S2_MEMORY_BI__


'' Include
#Include Once "s2GlobalConstants.bi"
#Include Once "s2PointMass.bi"
#Include Once "s2LineSegment.bi"
#Include Once "s2Body.bi"
#Include Once "s2AngularSpring.bi"
#Include Once "s2FixedAngleSpring.bi"
#Include Once "s2LinearSpring.bi"


''
Type Memory
	
	Public:
	
	'' Constructor
	Declare Constructor()
	
	'' Destructor
	Declare Destructor()
	
	'' Create
	Declare Function Create OverLoad ( ByRef A As AngularSpring )    As AngularSpring Ptr
	Declare Function Create          ( ByRef B As Body )             As Body Ptr
	Declare Function Create          ( ByRef F As FixedAngleSpring ) As FixedAngleSpring Ptr
	Declare Function Create          ( ByRef L As LinearSpring )     As LinearSpring Ptr
	Declare Function Create          ( ByRef L As LineSegment )      As LineSegment Ptr
	Declare Function Create          ( ByRef P As PointMass )        As PointMass Ptr
	
	'' Dim
	Declare Sub DimAngularSprings    ( ByVal Num As Integer )
	Declare Sub DimBodys             ( ByVal Num As Integer )
	Declare Sub DimFixedAngleSprings ( ByVal Num As Integer )
	Declare Sub DimLinearSprings     ( ByVal Num As Integer )
	Declare Sub DimLineSegments      ( ByVal Num As Integer )
	Declare Sub DimPointMasses       ( ByVal Num As Integer )
	
	'' Get
	
	
	'Private:
	
	'' Max
	Const As Integer MaxAngularSprings    = MAX_ANGULAR_SPRINGS
	Const As Integer MaxBodys             = MAX_BODYS
	Const As Integer MaxFixedAngleSprings = MAX_FIXED_ANGLE_SPRINGS
	Const As Integer MaxLinearSprings     = MAX_LINEAR_SPRINGS
	Const As Integer MaxLineSegments      = MAX_LINE_SEGMENTS
	Const As Integer MaxPointMasses       = MAX_POINT_MASSES
	
	'' Num
	As Integer NumAngularSprings
	As Integer NumBodys
	As Integer NumFixedAngleSprings
	As Integer NumLinearSprings
	As Integer NumLineSegments
	As Integer NumPointMasses
	
	'' Lo - Hi
	As AngularSpring Ptr    AngularSpringLo, AngularSpringHi
	As Body Ptr             BodyLo, BodyHi
	As FixedAngleSpring Ptr FixedAngleSpringLo, FixedAngleSpringHi
	As LinearSpring Ptr     LinearSpringLo, LinearSpringHi
	As LineSegment Ptr      LineSegmentLo, LineSegmentHi
	As PointMass Ptr        PointMassLo, PointMassHi
	
	'' Physical object arrays
	As AngularSpring Ptr    AngularSprings
	As Body Ptr             Bodys
	As FixedAngleSpring Ptr FixedAngleSprings
	As LinearSpring Ptr     LinearSprings
	As LineSegment Ptr      LineSegments
	As PointMass Ptr        PointMasses
	
End Type 


''
Constructor Memory()
	
	DimAngularSprings    ( MaxAngularSprings )
	DimBodys             ( MaxBodys )
	DimFixedAngleSprings ( MaxFixedAngleSprings )
	DimLinearSprings     ( MaxLinearSprings )
	DimLineSegments      ( MaxLineSegments )
	DimPointMasses       ( MaxPointMasses )
	
End Constructor


''
Destructor Memory()
	
	If ( AngularSprings    > 0 ) Then Delete[] AngularSprings
	If ( Bodys             > 0 ) Then Delete[] Bodys
	If ( FixedAngleSprings > 0 ) Then Delete[] FixedAngleSprings
	If ( LinearSprings     > 0 ) Then Delete[] LinearSprings
	If ( LineSegments      > 0 ) Then Delete[] LineSegments
	If ( PointMasses       > 0 ) Then Delete[] PointMasses
	
End Destructor


''
Function Memory.Create( ByRef A As AngularSpring ) As AngularSpring Ptr
				
	If ( NumAngularSprings >= MaxAngularSprings - 1 ) Then Return 0
		
	NumAngularSprings += 1
	
	AngularSpringHi = @AngularSprings[ NumAngularSprings ]
	
	*AngularSpringHi = A
	
	Return AngularSpringHi
	
End Function

Function Memory.Create( ByRef B As Body ) As Body Ptr
			
	If ( NumBodys >= MaxBodys - 1 ) Then Return 0
		
	NumBodys += 1
	
	BodyHi = @Bodys[ NumBodys ]
	
	*BodyHi = B
	
	Return BodyHi
	
End Function

Function Memory.Create( ByRef F As FixedAngleSpring ) As FixedAngleSpring Ptr
	
	If ( NumFixedAngleSprings >= MaxFixedAngleSprings - 1 ) Then Return 0
		
	NumFixedAngleSprings += 1
	
	FixedAngleSpringHi = @FixedAngleSprings[ NumFixedAngleSprings ]
	
	*FixedAngleSpringHi = F
	
	Return FixedAngleSpringHi
	
End Function

Function Memory.Create( ByRef L As LinearSpring ) As LinearSpring Ptr
		
	If ( NumLinearSprings >= MaxLinearSprings - 1 ) Then Return 0
		
	NumLinearSprings += 1
	
	LinearSpringHi = @LinearSprings[ NumLinearSprings ]
	
	*LinearSpringHi = L
	
	Return LinearSpringHi
	
End Function

Function Memory.Create( ByRef L As LineSegment ) As LineSegment Ptr
	
	If ( NumLineSegments >= MaxLineSegments - 1 ) Then Return 0
		
	NumLineSegments += 1
	
	LineSegmentHi = @LineSegments[ NumLineSegments ]
	
	*LineSegmentHi = L
	
	Return LineSegmentHi
	
End Function

Function Memory.Create( ByRef P As PointMass ) As PointMass Ptr
	
	If ( NumPointMasses >= MaxPointMasses - 1 ) Then Return 0
		
	NumPointMasses += 1
	
	PointMassHi = @PointMasses[ NumPointMasses ]
	
	*PointMassHi = P
	
	Return PointMassHi

End Function


''
Sub Memory.DimAngularSprings( ByVal Num As Integer )
	
	If ( Num <= 0 ) Then Exit Sub
		
	AngularSprings = New AngularSpring[ Num ]
	
	AngularSpringLo = @AngularSprings[ 0 ]
	AngularSpringHi = @AngularSprings[ 0 ]

End Sub

Sub Memory.DimBodys( ByVal Num As Integer )
	
	If ( Num <= 0 ) Then Exit Sub
		
	Bodys = New Body[ Num ]
	
	BodyLo = @Bodys[ 0 ]
	BodyHi = @Bodys[ 0 ]
	
End Sub

Sub Memory.DimFixedAngleSprings( ByVal Num As Integer )
	
	If ( Num <= 0 ) Then Exit Sub
		
	FixedAngleSprings = New FixedAngleSpring[ Num ]
	
	FixedAngleSpringLo = @FixedAngleSprings[ 0 ]
	FixedAngleSpringHi = @FixedAngleSprings[ 0 ]
	
End Sub

Sub Memory.DimLinearSprings( ByVal Num As Integer )
	
	If ( Num <= 0 ) Then Exit Sub
		
	LinearSprings = New LinearSpring[ Num ]
	
	LinearSpringLo = @LinearSprings[ 0 ]
	LinearSpringHi = @LinearSprings[ 0 ]
	
End Sub

Sub Memory.DimLineSegments( ByVal Num As Integer )
	
	If ( Num <= 0 ) Then Exit Sub
		
	LineSegments = New LineSegment[ Num ]
	
	LineSegmentLo = @LineSegments[ 0 ]
	LineSegmentHi = @LineSegments[ 0 ]
	
End Sub

Sub Memory.DimPointMasses( ByVal Num As Integer )
	
	If ( Num <= 0 ) Then Exit Sub
		
	PointMasses = New PointMass[ Num ]
	
	PointMassLo = @PointMasses[ 0 ]
	PointMassHi = @PointMasses[ 0 ]
	
End Sub


#EndIf ''__S2_MEMORY_BI__
