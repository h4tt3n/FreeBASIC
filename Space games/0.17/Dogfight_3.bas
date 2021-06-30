''
''              ---- D O G F I G H T   I N   S P A C E ---->
''
''                          v. 0.3b - june 2007
''
''                                  by
''
''                        Michael "h4tt3n" Nissen
''                          jernmager@yahoo.dk
''

#include "Dogfight_3.bi"

Initialize_Screen()

Do
  
  If Timer > last_Scrn_Update Then 
    last_Scrn_Update = Timer + Scrn_Update
    Calc_FPS()
    
    Draw_Ellipse (0, Scrn_X_Mid, Scrn_Y_Mid, 64, 192, 0.785, RGB(32, 255, 32), 128)
    
    Locate 2, 2:  Print Using "###"; FPS
    
  End If
  
Loop Until Multikey(1)

End
