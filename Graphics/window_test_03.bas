

ScreenRes 800, 600, 32


Dim As Single x = 0
Dim As Single y = 0
Dim As Single z = 0.0

Do
	
	x += 0.01
	y += 0.0133
	z += 0.001
	
	Dim As Single xx = Cos(x) * 400
	Dim As Single yy = Sin(y) * 300
	
	Window ( ( -400 + xx ) * z, ( -300 + yy ) * z )-( ( 400 + xx ) * z, ( 300 + yy ) * z )
	
	ScreenLock
		
		Cls
		
		Circle ( 0, 0 ), 32, RGB( 255, 0 ,0 ),,, 1, F
		
	ScreenUnLock
	
	Sleep 1, 1
	
Loop Until MultiKey(1)
