

#Include "GameIO.bi"

Dim As ScreenType GameScreen

Dim As Joystick Joystick_1

Joystick_1.Id( 0 )

GameScreen.Create( 600, 600, 32, 0 )

Do
	
	Joystick_1.Update()
	
	ScreenLock
		
		Cls
		
		'' Joystick test
		
		Locate 1, 1: Print Joystick_1.Axis(1).x; Joystick_1.Axis(1).y
		Locate 2, 1: Print Joystick_1.Axis(2).x; Joystick_1.Axis(2).y
		Locate 3, 1: Print Joystick_1.Axis(3).x; Joystick_1.Axis(3).y
		Locate 4, 1: Print Joystick_1.Axis(4).x; Joystick_1.Axis(4).y
		
		Locate 6, 1
		
		For i As Integer = 0 To 27
			
			Print "Button " ; i + 1 , Joystick_1.Button(i)
			
		Next
		
		Circle ( 300 + Joystick_1.Axis(1).x * 300, 300 + Joystick_1.Axis(1).y * 300 ), 16, RGB( 255,  32,  32 ),,,1,f
		Circle ( 300 + Joystick_1.Axis(2).x * 300, 300 + Joystick_1.Axis(2).y * 300 ), 16, RGB(  32, 255,  32 ),,,1,f
		Circle ( 300 + Joystick_1.Axis(3).x * 300, 300 + Joystick_1.Axis(3).y * 300 ), 16, RGB(  32,  32, 255 ),,,1,f
		Circle ( 300 + Joystick_1.Axis(4).x * 300, 300 + Joystick_1.Axis(4).y * 300 ), 16, RGB( 255, 255,  32 ),,,1,f
		
	Screenunlock
	
	Sleep 1, 1
	
Loop Until MultiKey(1)
