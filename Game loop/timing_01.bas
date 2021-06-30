

Dim As Double lasttime = 0

Do
	
	Print Timer - lasttime
	
	Lasttime = timer
	
	Do
	
	Sleep 1, 1
	
	Loop Until Timer - lasttime > 0.016
	
Loop Until MultiKey(1)
