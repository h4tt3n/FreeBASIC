''*******************************************************************************
''
''   FreeBASIC Mouse Class
''   Written in FreeBASIC 1.05
''   Version 0.2.0, October 2015, Michael "h4tt3n" Nissen
''
''
''*******************************************************************************


''
#Ifndef __G2_MOUSE_BI__
#Define __G2_MOUSE_BI__


''
Type Mouse
	
	Public:
	
	''
	Declare Constructor()
	Declare Constructor( ByRef m As Mouse )
	
	''
	Declare Operator Let( ByRef m As Mouse )
	
	'' Get
	
	
	'' Set
	
	
	''
	Declare Sub Update()
	
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

Constructor Mouse( ByRef m As Mouse )

End Constructor


''
Operator Mouse.Let( ByRef m As Mouse )
	
End Operator


''
Sub Mouse.Update()
	
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


''
#Endif ''__G2_MOUSE_BI__

