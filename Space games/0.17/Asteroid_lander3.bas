''                   A S T E R O I D   L A N D E R   
''
''                      version 0.3b - july 2007
''
''           By Michael "h4tt3n" Nissen (jernmager@yahoo.dk)

#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "asteroid_lander3.bi"

Randomize Timer

With Scrn
  .Scale = 1
  .Angle = 0
  .Scale_Min = 0.5
  .Scale_Max = 2
  .Scroll_Factor = 4
  .Scale_Factor = 0.99
  .Rotation_Factor = 0.6
End With

With Controls
  .Lft = 75
  .Rgt = 77
  .fwd = 72
  .dwn = 80
  .esc = 1
End With

view_factor = 1

Init_OpenGl()
Init_Planet(0, 0, 0, 0, 512, 256, 128)
Init_Ship(0, 0, 0, 160)

Update_Scrn_Angle()

Do
  Read_Keyboard()
  Update_Angle(Planet(0).Body)
  Update_Angle(Ship(0).Body)
  Apply_Gravity()
  Update_Pos(Planet(0).Body)
  Update_Pos(Ship(0).Body)
  Collision_Detection()
  Clear_Screen()
  Draw_Planet(0)
  Draw_Ship(0)
  Flip_Buffers()
  
  Sleep 1, 1
  
Loop Until Multikey(1)
Free_Memory()
End
