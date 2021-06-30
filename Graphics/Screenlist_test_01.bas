Dim As Long mode
Dim As Integer w, h

Print "Resolutions supported at 32 bits per pixel:"

mode = ScreenList(32)

While (mode <> 0)
	
    w = HiWord(mode)
    h = LoWord(mode)
    
    Print w & "x" & h
    
    mode = ScreenList()
    
Wend

Sleep

End
