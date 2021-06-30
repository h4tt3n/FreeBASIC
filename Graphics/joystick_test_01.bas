ScreenRes( 800, 600, 32 )

Dim x1 As Single
Dim y1 As Single
Dim x2 As Single
Dim y2 As Single

Dim buttons As Integer
Dim result As Integer
Dim a As Integer

Const JoystickID = 0

'This line checks to see if the joystick is ok.

If GetJoystick(JoystickID,buttons,x1,y1,x2,y2) = 1 Then 
    Print "Joystick doesn't exist or joystick error."
    Print
    Print "Press any key to continue."
    Sleep
    End
End If

Do

	ScreenLock
	
	Cls

    Locate 1,1
    
    result = GetJoystick(0,buttons,x1,y1,x2,y2)
    
    Print ;"result:";result;" x:" ;x1;" y:";y1;" Buttons:";buttons,"","",""
    
    'This tests to see which buttons from 1 to 27 are pressed. 
    For a = 0 To 26 
        If (buttons And (1 Shl a)) Then 
            Print "Button ";a;" pressed.    "
        Else 
            Print "Button ";a;" not pressed."
        End If
    Next a
    
    'result = GetJoystick(0,buttons,x1,y1,x2,y2)
    
    Circle ( 400 + x1 * 400, 300 + y1 * 300 ), 16, RGB( 255, 32, 32 ),,,1,f
    Circle ( 400 + x2 * 400, 300 + y2 * 300 ), 16, RGB( 255, 32, 32 ),,,1,f
    
    'result = GetJoystick(1,buttons,x1,y1,x2,y2)
    '
    'Circle ( 400 + x1 * 400, 300 + y1 * 300 ), 16, RGB( 32, 255, 32 ),,,1,f
    'Circle ( 400 + x2 * 400, 300 + y2 * 300 ), 16, RGB( 32, 255, 32 ),,,1,f
    
    Screenunlock
    
    Sleep 1, 1
    
Loop Until MultiKey(1)