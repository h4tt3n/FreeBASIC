''*******************************************************************************
''
''   FreeBASIC Camera Class
''   Written in FreeBASIC 1.05
''   Version 0.2.0, October 2015, Michael "h4tt3n" Nissen
''
''*******************************************************************************


''
#Ifndef __IO_CAMERA_BI__
#Define __IO_CAMERA_BI__


''
Type Camera
	
	Public:
	
	'' Constructors
	Declare Constructor()
	Declare Constructor( ByRef C As Camera )
	
	''
	Declare Destructor()
	
	'' Operators
	Declare Operator Let( ByRef C As Camera )
	
	''
	Declare Sub Create( ByVal _width  As Integer, _
                       ByVal _height As Integer, _
                       ByVal _zoom   As Single )
	
	''
	Declare Sub Update()
	
	'' Get
	Declare Function Position     () As Vec2
	Declare Function RestPosition () As Vec2
	Declare Function RestZoom     () As Single
	Declare Function ScrollRate   () As Single
	Declare Function Zoom         () As Single
	Declare Function ZoomRate     () As Single
	
	'' Set
	Declare Sub Position     ( ByVal p As Vec2   )
	Declare Sub RestPosition ( ByVal r As Vec2   )
	Declare Sub RestZoom     ( ByVal r As Single )
	Declare Sub ScrollRate   ( ByVal s As Single )
	Declare Sub Zoom         ( ByVal z As Single )
	Declare Sub ZoomRate     ( ByVal z As Single )
	
	'' Reset
	Declare Sub ResetVariables()
	
	'Private:
	
	''Variables
	As Vec2 Position_
	As Vec2 PrevPosition_
	As Vec2 RestPosition_
	
	As Single RestZoom_
	As Single PrevZoom_
	As Single ScrollRate_
	As Single Zoom_
	As Single ZoomRate_
	
	As Integer Width_
	As Integer Height_
	As Integer Top_
	As Integer Left_
	As Integer Bottom_
	As Integer Right_
	
End Type


'' Constructors
Constructor Camera()
	
	ResetVariables()
	
End Constructor

Constructor Camera( ByRef C As Camera )
	
	ResetVariables()
	
	This = C
	
End Constructor


''
Destructor Camera()

End Destructor


'' Operators
Operator Camera.Let( ByRef C As Camera )
	
	If ( @This <> @C ) Then
		
		Position_     = C.Position_
		RestPosition_ = C.RestPosition_
		RestZoom_     = C.RestZoom_
		ScrollRate_   = C.ScrollRate_
		Zoom_         = C.Zoom_
		ZoomRate_     = C.ZoomRate_
		Width_        = C.Width_  
		Height_       = C.Height_
		Top_          = C.Top_
		Left_         = C.Left_
		Bottom_       = C.Bottom_
		Right_        = C.Right_
		
	EndIf
	
End Operator


''
Sub Camera.Create( ByVal _width  As Integer, _
                   ByVal _height As Integer, _
                   ByVal _zoom   As Single )
   
   Width_  = _width
	Height_ = _height
	Zoom_   = _zoom
   
   Position_     = Vec2( 0.0, 0.0 )
	RestPosition_ = Vec2( 0.0, 0.0 )
	
	RestZoom_     = _zoom
	ScrollRate_   = CAMERA_SCROLL_RATE
	ZoomRate_     = CAMERA_ZOOM_RATE
   
   Top_    = Cast( Integer, Position_.y - 0.5 * Height_ * Zoom_ )
   Left_   = Cast( Integer, Position_.x - 0.5 * Width_  * Zoom_ )
	Bottom_ = Cast( Integer, Position_.y + 0.5 * Height_ * Zoom_ )
	Right_  = Cast( Integer, Position_.x + 0.5 * Width_  * Zoom_ )
   
   Window ( Left_, Top_ )-( Right_, Bottom_ )
   'Window ( Left_, Bottom_ )-( Right_, Top_ )
   
End Sub


'' 
Sub Camera.Update()
	
	If( ( Zoom_ <> RestZoom_ ) Or ( Position_ <> RestPosition_ ) ) Then
		
		PrevZoom_     = Zoom_
		PrevPosition_ = Position_
		
		RestZoom_ = IIf( RestZoom_ > CAMERA_ZOOM_MAX , CAMERA_ZOOM_MAX, RestZoom_ )
		RestZoom_ = IIf( RestZoom_ < CAMERA_ZOOM_MIN , CAMERA_ZOOM_MIN, RestZoom_ )
		
		Zoom_ += ( RestZoom_ - Zoom_ ) * ZoomRate_
		
		Position_ += ( RestPosition_ - Position_ ) * ScrollRate_
		
	   Top_    = Cast( Integer, Position_.y - 0.5 * Height_ * Zoom_ )
	   Left_   = Cast( Integer, Position_.x - 0.5 * Width_  * Zoom_ )
		Bottom_ = Cast( Integer, Position_.y + 0.5 * Height_ * Zoom_ )
		Right_  = Cast( Integer, Position_.x + 0.5 * Width_  * Zoom_ )
		
		'Window Screen ( Left_, Top_ )-( Right_, Bottom_ )
		Window ( Left_, Bottom_ )-( Right_, Top_ )
		
		   '' Cartesian ( 0,0 ) = bottom left
	   'Window ( lft, top )-( rgt, btm )
	   'Window ( 0, Hgt )-( wid, 0 )
	   
	   '' Default ( 0,0 ) = top left
		'Window Screen ( 0, 0 )-( wid, hgt )
		'Window Screen ( lft, btm )-( rgt, top )
		
	End If
	
End Sub


'' Get
Function Camera.Position() As Vec2
	
	Return Position_
	
End Function

Function Camera.RestPosition() As Vec2
	
	Return RestPosition_
	
End Function

Function Camera.RestZoom() As Single
	
	Return RestZoom_
	
End Function

Function Camera.ScrollRate() As Single
	
	Return ScrollRate_
	
End Function

Function Camera.Zoom() As Single
	
	Return Zoom_
	
End Function

Function Camera.ZoomRate() As Single
	
	Return ZoomRate_
	
End Function


'' Set
Sub Camera.Position( ByVal p As Vec2 )
	
	Position_ = p
	
End Sub

Sub Camera.RestPosition( ByVal r As Vec2 )
	
	RestPosition_ = r
	
End Sub

Sub Camera.RestZoom( ByVal r As Single )
	
	RestZoom_ = r
	
End Sub

Sub Camera.ScrollRate( ByVal s As Single )
	
	ScrollRate_ = s
	
End Sub

Sub Camera.Zoom( ByVal z As Single )
	
	Zoom_ = z
	
End Sub

Sub Camera.ZoomRate( ByVal z As Single )
	
	ZoomRate_ = z
	
End Sub


'' Reset
Sub Camera.ResetVariables()
	
	Position_     = Vec2( 0.0, 0.0 )
	RestPosition_ = Vec2( 0.0, 0.0 )
	RestZoom_     = 0.0
	ScrollRate_   = 0.0
	Zoom_         = 0.0
	ZoomRate_     = 0.0
	Width_        = 0  
	Height_       = 0
	Top_          = 0
	Left_         = 0
	Bottom_       = 0
	Right_        = 0
	
End Sub


#EndIf __IO_CAMERA_BI__
