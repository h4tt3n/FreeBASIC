''*******************************************************************************
''
''   FreeBASIC Screen Class
''   Written in FreeBASIC 1.04
''   Version 0.1.0, October 2015, Michael "h4tt3n" Nissen
''
''   Reference:
''   http://www.freebasic.net/wiki/wikka.php?wakka=CatPgGfxScreen
''
''*******************************************************************************


#Ifndef __SCREEN_BI__
#Define __SCREEN_BI__


''
#Include Once "fbgfx.bi"


''
Type ScreenType
	
	Public:
	
	Declare Constructor()
	
	Declare Sub GetAvailableResolutions( Depth As Integer )
	
	Declare Sub Create( Wid    As Integer, _
	                    Height As Integer, _
	                    Depth  As Integer, _
	                    Pages  As Integer, _
	                    Flags  As Integer, _
	                    Rate   As Integer )
	
	Declare Sub Create( Wid    As Integer, _
	                    Height As Integer, _
	                    Depth  As Integer, _
	                    Flags  As Integer )
	
	Declare Sub Create( Wid    As Integer, _
	                    Height As Integer, _
	                    Flags  As Integer )
	
	Declare Sub Create()
	
	
	Declare Function GetWidth() As Integer
	Declare Function GetHeight() As Integer
	Declare Function GetBitDepth() As Integer
	Declare Function GetNumPages() As Integer
	Declare Function GetUpdateRate() As Integer
	
	Declare Sub SetToLargestResolution()
	
	Declare Sub AddFlag   ( Flag As Integer )
	Declare Sub RemoveFlag( Flag As Integer )
	
	Private:
	
	As Integer Width_
	As Integer Height_
	As Integer Depth_
	As Integer Pages_
	As Integer Flags_
	As Integer Rate_
	
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
Sub ScreenType.GetAvailableResolutions( Depth As Integer )
	
	
	
End Sub

Sub ScreenType.Create( Wid    As Integer, _
	                    Height As Integer, _
	                    Depth  As Integer, _
	                    Pages  As Integer, _
	                    Flags  As Integer, _
	                    Rate   As Integer )
	
	Width_  = Wid
	Height_ = Height
	Depth_  = Depth
	Pages_  = Pages
	AddFlag( Flags )
	Rate_   = Rate
	
	If ( Width_ = 0 ) Or ( Height_ = 0 ) Then
		
		ScreenInfo Width_, Height_
		
		AddFlag( fb.GFX_FULLSCREEN )
		'AddFlag( fb.GFX_NO_SWITCH  )
		'AddFlag( fb.GFX_ALWAYS_ON_TOP  )
		
	End If
	
	If ( Depth_ = 0 ) Then ScreenInfo ,, Depth_
	If ( Rate_  = 0 ) Then ScreenInfo ,,,,, Rate_
	
	ScreenRes Width_, Height_, Depth_, Pages_, Flags_, Rate_

End Sub

Sub ScreenType.Create( Wid    As Integer, _
	                    Height As Integer, _
	                    Depth  As Integer, _
	                    Flags  As Integer )
	
	Width_  = Wid
	Height_ = Height
	Depth_  = Depth
	AddFlag( Flags )
	
	If ( Width_ = 0 ) Or ( Height_ = 0 ) Then
		
		ScreenInfo Width_, Height_
		AddFlag( fb.GFX_FULLSCREEN )
		
	End If
	
	If ( Depth_ = 0 ) Then ScreenInfo ,, Depth_
	
	ScreenInfo ,,,,, Rate_
	
	ScreenRes Width_, Height_, Depth_,, Flags_, Rate_

End Sub

Sub ScreenType.Create( Wid    As Integer, _
	                    Height As Integer, _
	                    Flags  As Integer )
	
	Width_  = Wid
	Height_ = Height
	AddFlag( Flags )
	
	If ( Width_ = 0 ) Or ( Height_ = 0 ) Then
		
		ScreenInfo Width_, Height_
		AddFlag( fb.GFX_FULLSCREEN )
		
	End If
	
	ScreenInfo ,, Depth_,,, Rate_
	
	ScreenRes Width_, Height_, Depth_,, Flags_, Rate_

End Sub

Sub ScreenType.Create()
	
	ScreenInfo Width_, Height_, Depth_,,, Rate_
		
	AddFlag( fb.GFX_FULLSCREEN )
	
	ScreenRes Width_, Height_, Depth_,, Flags_, Rate_

End Sub

Function ScreenType.GetWidth() As Integer
	
	Return Width_
	
End Function

Function ScreenType.GetHeight() As Integer
		
	Return Height_
	
End Function

Function ScreenType.GetBitDepth() As Integer
		
	Return Depth_
	
End Function

Function ScreenType.GetNumPages() As Integer
		
	Return Pages_
	
End Function

Function ScreenType.GetUpdateRate() As Integer
		
	Return Rate_
	
End Function

Sub ScreenType.SetToLargestResolution()
	
	'GetAvailableResolutions()
	
End Sub

Sub ScreenType.AddFlag( Flag As Integer )
	
	Flags_ Or= Flag
	
End Sub

Sub ScreenType.RemoveFlag( Flag As Integer )
	
	Flags_ And= ( Not Flag )
	
End Sub


#EndIf ''__SCREEN_BI__
