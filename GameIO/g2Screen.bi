''*******************************************************************************
''
''   FreeBASIC Screen Class
''   Written in FreeBASIC 1.05
''   Version 0.2.0, October 2016, Michael "h4tt3n" Nissen
''
''   Reference:
''   http://www.freebasic.net/wiki/wikka.php?wakka=CatPgGfxScreen
''
''*******************************************************************************


''
#Ifndef __G2_SCREEN_BI__
#Define __G2_SCREEN_BI__


''
Type ScreenType
	
	Public:
	
	''
	Declare Constructor()
	
	''
	Declare Sub AvailableResolutions( ByVal Depth As Integer )
	
	Declare Sub Create( ByVal _width  As Integer, _
	                    ByVal _height As Integer, _
	                    ByVal _depth  As Integer, _
	                    ByVal _flags  As UInteger )
	
	Declare Sub Create()
	
	'' Get
	Declare Function Width() As Integer
	Declare Function Height() As Integer
	Declare Function BitDepth() As Integer
	Declare Function NumPages() As Integer
	Declare Function UpdateRate() As Integer
	
	Declare Sub SetToLargestResolution()
	
	Declare Sub AddFlag   ( ByVal Flag As UInteger )
	Declare Sub RemoveFlag( ByVal Flag As UInteger )
	
	'Private:
	
	As Integer Width_
	As Integer Height_
	As Integer Depth_
	As Integer Pages_
	As Integer Rate_
	
	As UInteger Flags_
	
End Type


''
Constructor ScreenType()
	
	Width_  = 0
	Height_ = 0
	Depth_  = 0
	Pages_  = 0
	Flags_  = 0
	Rate_   = 0
	
End Constructor


''
Sub ScreenType.AvailableResolutions( ByVal Depth As Integer )
	
	
	
End Sub

Sub ScreenType.Create( ByVal _width  As Integer, _
	                    ByVal _height As Integer, _
	                    ByVal _depth  As Integer, _
	                    ByVal _flags  As UInteger )
	
	Width_  = _width
	Height_ = _height
	Depth_  = _depth
	AddFlag( _flags )
	
	If ( Width_ = 0 ) Or ( Height_ = 0 ) Then
		
		ScreenInfo Width_, Height_
		AddFlag( fb.GFX_FULLSCREEN )
		
	End If
	
	If ( Depth_ = 0 ) Then ScreenInfo ,, Depth_
	
	ScreenInfo ,,,,, Rate_
	
	ScreenRes Width_, Height_, Depth_, 2, Flags_, Rate_
	
	View( 0, 0 )-( Width_, Height_ )
	'View( 0, Height_ )-( Width_, 0 )
	
	'ScreenSet( 0, 1 )
	
End Sub

Sub ScreenType.Create()
	
	ScreenInfo Width_, Height_, Depth_,,,Rate_
		
	AddFlag( fb.GFX_FULLSCREEN )
	
	'ScreenRes Width_, Height_, Depth_, 2, Flags_, Rate_
	ScreenRes Width_, Height_, Depth_,, Flags_, Rate_
	
	View( 0, 0 )-( Width_, Height_ )
	
	'ScreenSet( 0, 1 )
	
End Sub

'' Get
Function ScreenType.Width() As Integer
	
	Return Width_
	
End Function

Function ScreenType.Height() As Integer
		
	Return Height_
	
End Function

Function ScreenType.BitDepth() As Integer
		
	Return Depth_
	
End Function

Function ScreenType.NumPages() As Integer
		
	Return Pages_
	
End Function

Function ScreenType.UpdateRate() As Integer
		
	Return Rate_
	
End Function

Sub ScreenType.SetToLargestResolution()
	
	'AvailableResolutions()
	
End Sub

Sub ScreenType.AddFlag( ByVal Flag As UInteger )
	
	Flags_ Or= Flag
	
End Sub

Sub ScreenType.RemoveFlag( ByVal Flag As UInteger )
	
	Flags_ And= ( Not Flag )
	
End Sub


''
#EndIf ''__G2_SCREEN_BI__
