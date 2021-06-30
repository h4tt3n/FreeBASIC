
Dim As Long mode
Dim As Integer w, h, d

ScreenInfo ,,d

Print "Resolutions supported at " & d & " bits per pixel:"

mode = ScreenList(d)

While (mode <> 0)
	
    w = HiWord(mode)
    h = LoWord(mode)
    
    Print w & "x" & h
    
    mode = ScreenList()
    
Wend

Sleep

End
