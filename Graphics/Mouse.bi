''*******************************************************************************
''
''   FreeBASIC Mouse Class
''   Written in FreeBASIC 1.04
''   Version 0.1.0, October 2015, Michael "h4tt3n" Nissen
''
''
''*******************************************************************************


''
#Ifndef __MOUSE_BI__
#Define __MOUSE_BI__


''
#Include Once "fbgfx.bi"
#include Once "../Math/Vector2.bi"


''
Type Mouse
	
	Public:
	
	Declare Constructor()
	
	Declare Sub UpdateState()
	
	'Private:
	
	As fb.EVENT E
	
	As Integer Button_
	As Integer Wheel_
	As Vec2    Position_
	As Vec2    DeltaPosition_
	
	
End Type


''
Constructor Mouse()

End Constructor


''
Sub Mouse.UpdateState()
	
	If ScreenEvent( @E ) Then
		
		Select Case E.Type
			
			Case fb.EVENT_MOUSE_BUTTON_PRESS
				
				Button_ = E.Button
				
			Case fb.EVENT_MOUSE_BUTTON_RELEASE
				
				Button_ = E.Button
			
			Case fb.EVENT_MOUSE_MOVE
				
				Position_ = Vec2( E.x, E.y )
				DeltaPosition_ = Vec2( E.dx, E.dy )
			
			Case fb.EVENT_MOUSE_WHEEL
				
				Wheel_ = E.z
				
		End Select
		
	EndIf
	
End Sub


#Endif ''__MOUSE_BI__

