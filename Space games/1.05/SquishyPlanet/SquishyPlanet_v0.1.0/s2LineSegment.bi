''*******************************************************************************
''    
''   Squishy2D Line Segment Class
''   Written in FreeBASIC 1.04
''   version 0.1.0, November 2015, Michael "h4tt3n" Nissen
''
''   This is the inherited base type of all forces acting between two particles.
''
''   LineSegment --> LinearSpring / FixedAngleSpring
''
''*******************************************************************************


''
#Ifndef __S2_LINE_SEGMENT_BI__
#Define __S2_LINE_SEGMENT_BI__


''
Type LineSegment Extends Object
	
	Public:
	
	'' Constructors
	Declare Constructor()
	
	Declare Constructor( ByRef L As LineSegment )
	
	Declare Constructor( ByVal A As PointMass Ptr, _
	                     ByVal B As PointMass Ptr )
	
	'' Operators
	Declare Operator Let( ByRef L As LineSegment )
	
	'' Compute
	Declare Sub computeLengths()
	Declare Sub computeLength()
	Declare Sub computeLengthVector()
	Declare Sub computeLengthUnit()
	
	'' Get
	Declare Function getLength()       As Single
	Declare Function getLengthVector() As Vec2
	Declare Function getPointMassA()   As PointMass Ptr
	Declare Function getPointMassB()   As PointMass Ptr
	Declare Function getLengthUnit()   As Vec2
	
	''	Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	'' Set
	Declare Sub setPointMassA( ByVal A As PointMass Ptr )
	Declare Sub setPointMassB( ByVal B As PointMass Ptr )
	
	Protected:

	'' Variables
	As Single Length_
	As Vec2   LengthUnit_ 
	As Vec2   LengthVector_
	
	'' PointMass pointers
	As PointMass Ptr PointMassA_
	As PointMass Ptr PointMassB_
	
End Type


'' Constructors
Constructor LineSegment()
	
	ResetAll()
	
End Constructor
	
Constructor LineSegment( ByRef L As LineSegment )
	
	ResetAll()
	
	This = L
	
End Constructor
	
Constructor LineSegment( ByVal A As PointMass Ptr, _
	                      ByVal B As PointMass Ptr )
	
	ResetAll()
	
	If ( A <> B ) Then
		
		PointMassA_ = A
		PointMassB_ = B
		
	EndIf
	
End Constructor


'' Operators
Operator LineSegment.Let( ByRef L As LineSegment )
	
	Length_       = L.Length_
	LengthUnit_   = L.LengthUnit_
	LengthVector_ = L.LengthVector_
	PointMassA_   = L.PointMassA_    ''<--- problem here
	PointMassB_   = L.PointMassB_    ''<--- problem here

End Operator


'' Compute
Sub LineSegment.computeLengthUnit()
	
	LengthUnit_ = LengthVector_.Unit()
	
	'LengthUnit_ = LengthVector_ / Length_
	
End Sub

Sub LineSegment.computeLengths()
	
	computeLengthVector()
	computeLengthUnit()
	computeLength()
	
End Sub

Sub LineSegment.computeLength()
	
	Length_ = LengthVector_.Dot( LengthUnit_ )
	
	'If ( LengthVector_ <> Vec2( 0.0, 0.0 ) ) Then 
	'	
	'	If ( LengthUnit_ <> Vec2( 0.0, 0.0 ) ) Then 
	'		
	'		Length_ = LengthVector_.Dot( LengthUnit_ )
	'		
	'	Else
	'		
	'		Length_ = LengthVector_.Length()
	'		
	'	EndIf
	'
	'Else 
	'	
	'	Length_ = 0.0
	'
	'End If
	
End Sub

Sub LineSegment.computeLengthVector()
	
	LengthVector_ = PointMassB_->GetPosition() - PointMassA_->GetPosition()
	
End Sub


'' Get
Function LineSegment.getLengthUnit() As Vec2
	
	Return LengthUnit_
	
End Function

Function LineSegment.getLength() As Single
	
	Return Length_
	
End Function

Function LineSegment.getLengthVector() As Vec2
	
	Return LengthVector_
	
End Function

Function LineSegment.getPointMassA() As PointMass Ptr
	
	Return PointMassA_
	
End Function

Function LineSegment.getPointMassB() As PointMass Ptr
	
	Return PointMassB_
	
End Function


''	Reset
Sub LineSegment.ResetAll()
	
	PointMassA_ = 0
	PointMassB_ = 0
	
	ResetVariables()
	
End Sub

Sub LineSegment.ResetVariables()
	
	Length_       = 0.0
	LengthUnit_   = Vec2( 0.0, 0.0 )
	LengthVector_ = Vec2( 0.0, 0.0 )
	
End Sub


'' Set
Sub LineSegment.setPointMassA( ByVal A As PointMass Ptr )
	
	PointMassA_ = IIf( A <> PointMassB_ , A , 0 )
	
End Sub

Sub LineSegment.setPointMassB( ByVal B As PointMass Ptr )
	
	PointMassB_ = IIf( B <> PointMassA_ , B , 0 )
	
End Sub


#EndIf ''__S2_LINE_SEGMENT_BI__
