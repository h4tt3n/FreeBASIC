''*******************************************************************************
''
''   FreeBASIC Camera Class
''   Written in FreeBASIC 1.04
''   Version 0.1.0, October 2015, Michael "h4tt3n" Nissen
''
''*******************************************************************************


''
#Ifndef __CAMERA_BI__
#Define __CAMERA_BI__


''
#Include Once "../Math/Vector2.bi"
#Include Once "r2Rotate.bi"


''
Type Camera Extends Rotate
	
	Public:
	
	'' Constructors
	Declare Constructor()
	
	'' Operators
	Declare Operator Let( ByRef C As Camera )
	
	'' Compute
	Declare Sub ComputeNewState()
	
	'' Get
	Declare Function GetRestPosition () As Vec2
	Declare Function GetRestZoom     () As Single
	Declare Function GetScrollRate   () As Single
	Declare Function GetZoom         () As Single
	Declare Function GetZoomRate     () As Single
	
	''	Reset
	Declare Sub ResetAll()
	
	'' Set
	Declare Sub SetRestPosition ( ByVal RestPosition As Vec2   )
	Declare Sub SetRestZoom     ( ByVal RestZoom     As Single )
	Declare Sub SetScrollRate   ( ByVal ScrollRate   As Single )
	Declare Sub SetZoom         ( ByVal Zoom         As Single )
	Declare Sub SetZoomRate     ( ByVal ZoomRate     As Single )
	
	Private:
	
	''Variables
	As Vec2   RestPosition_
	As Single RestZoom_
	As Single ScrollRate_
	As Single Zoom_
	As Single ZoomRate_
	
End Type


'' Constructors
Constructor Camera()
	
	ResetAll()
	
End Constructor


'' Operators
Operator Camera.Let( ByRef C As Camera )
	
	If ( @This <> @C ) Then
		
		RestPosition_ = C.RestPosition_
		RestZoom_     = C.RestZoom_
		ScrollRate_   = C.ScrollRate_
		Zoom_         = C.Zoom_
		ZoomRate_     = C.ZoomRate_
		
	Else
		
		ResetAll()
		
	EndIf
	
End Operator


'' Compute
Sub Camera.ComputeNewState()
	
	Zoom_ += ( Zoom_ - RestZoom_ ) * ScrollRate_
	
	Position_ += ( Position_ - RestPosition_ ) * ZoomRate_
	
End Sub


'' Get
Function Camera.GetRestPosition() As Vec2
	
	Return RestPosition_
	
End Function

Function Camera.GetRestZoom() As Single
	
	Return RestZoom_
	
End Function

Function Camera.GetScrollRate() As Single
	
	Return ScrollRate_
	
End Function

Function Camera.GetZoom() As Single
	
	Return Zoom_
	
End Function

Function Camera.GetZoomRate() As Single
	
	Return ZoomRate_
	
End Function


'' Reset
Sub Camera.ResetAll()
	
	RestPosition_ = Vec2( 0.0, 0.0 )
	RestZoom_     = 0
	ScrollRate_   = 0
	Zoom_         = 0
	ZoomRate_     = 0
	
	Base.ResetAll()
	
End Sub


'' Set
Sub Camera.SetRestPosition( ByVal RestPosition As Vec2 )
	
	RestPosition_ = RestPosition
	
End Sub

Sub Camera.SetRestZoom( ByVal RestZoom As Single )
	
	RestZoom_ = RestZoom
	
End Sub

Sub Camera.SetScrollRate( ByVal ScrollRate As Single )
	
	ScrollRate_ = ScrollRate
	
End Sub

Sub Camera.SetZoom( ByVal Zoom As Single )
	
	Zoom_ = Zoom
	
End Sub

Sub Camera.SetZoomRate( ByVal ZoomRate As Single )
	
	ZoomRate_ = ZoomRate
	
End Sub


#EndIf '' __CAMERA_BI__