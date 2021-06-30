''
''                      A S T E R O I D   L A N D E R
''
''                                    by
''
''                          Michael "h4tt3n" Nissen
''                            jernmager@yahoo.dk
''

Randomize Timer

#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "asteroid_lander.bi"

ScreenInfo Scrn_Wid, Scrn_Hgt, Scrn_Bpp

''  program settings
'Scrn_Wid = 640
'Scrn_Hgt = 400
'Scrn_bpp = 32
Scrn_X_Mid = Scrn_Wid\2
Scrn_Y_Mid = Scrn_Hgt\2
pos_factor = 1-Phi
scrn_full = 1
Active = 1

Update_Ship_Angle(Ship(Active))
Update_Asteroid_Angle(Asteroid(2))

Initialize_openGl_2D()

SetMouse ,, 0

''  main loop
Do
  
  ''  ship controls
  
  With Ship(Active)
    If multikey(Controls.Lft) then 
      .Angle -= 6
      Update_Ship_Angle(Ship(Active))
    End If
    If multikey(Controls.Rgt) then 
      .Angle += 6
      Update_Ship_Angle(Ship(Active))
    End If
    If multikey(Controls.Fwd) then 
      Burst()
    End If
  End With
  
  '' calculate gforce and do collision detection
  
  For k = Lbound(Asteroid) to Ubound(Asteroid)
    For l = k+1 To Ubound(Asteroid)
      Find_Dist(Asteroid(k).Body, Asteroid(l).Body)
      If k = 1 Then
        G_Force_1way(Asteroid(k).Body, Asteroid(l).Body)
      Else
        G_Force_2way(Asteroid(k).Body, Asteroid(l).Body)
      End If
    Next
    Find_Dist(Asteroid(k).Body, Ship(Active).Body)
    G_Force_1way(Asteroid(k).Body, Ship(Active).Body)
    
    Collision = Astr_Ship_Coldetec1(Asteroid(k), Ship(Active))
    If Collision = 1 Then
      Collision = Astr_Ship_Coldetec2(Asteroid(k), Ship(Active))
    End If
  Next

  ''update positions
  
  With Ship(Active)
    Update_Pos(.Body)
    For k = Lbound(.burst) to Ubound(.burst)
      With .Burst(k)
        Update_Pos(.Body)
      End With
    Next
  End With
  
  For k = Lbound(Asteroid) to Ubound(Asteroid)
    Update_Asteroid_Angle(Asteroid(k))
    Update_Pos(Asteroid(k).Body)
  Next
  
  ''  draw graphics
  
  glClear GL_COLOR_BUFFER_BIT Or GL_DEPTH_BUFFER_BIT

  Draw_Burst()

  Draw_Ship(Ship(Active))
  
  For k = Lbound(Asteroid) to Ubound(Asteroid)
    Draw_Asteroid(Asteroid(k))
  Next
  
  glFlush
  Flip
  ScreenSync
  
Loop Until Multikey(Controls.esc)

End
