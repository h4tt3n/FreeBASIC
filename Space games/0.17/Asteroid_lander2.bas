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
#include once "asteroid_lander2.bi"

ScreenInfo Scrn_Wid, Scrn_Hgt, Scrn_Bpp

'scrn_wid = 1000
'scrn_hgt = 500
'scrn_bpp = 32

''  program settings
Scrn_X_Mid = (Scrn_Wid\4)
Scrn_Y_Mid = (Scrn_Hgt\2)
pos_factor = 1-Phi
scrn_full = 1
Active = 1

Update_Ship_Angle(Ship(Active))
Scrn_Angle_Update()

Initialize_openGl_2D()
'Initialize_GL_lighting()

handle(1) = GL_Load_Bmp("enceladus512.bmp")

SetMouse ,, 0

Do
  
  ''  rotate screen image
  
  If Multikey (&h1e) Then
    Scrn_Angle -= 0.6
    Scrn_Angle_Update()
  End If
  
  If Multikey (&h20) Then
    Scrn_Angle += 0.6
    Scrn_Angle_Update()
  End If
  
  ''  zoom screen image
  
  If Multikey (&h1f) Then
    zoom *= 0.99
    If zoom < phi Then zoom = phi
  End If
  
  If Multikey (&h11) Then
    zoom /= 0.99
    If zoom > halfpi Then zoom = halfpi
  End If
  
  ''  controls
  
  With Ship(Active)
    If .Life_State = 1 Then
      If multikey(Controls.Lft) then 
        .Angle -= .Turn_Rate
        Update_Ship_Angle(Ship(Active))
      End If
      If multikey(Controls.Rgt) then 
        .Angle += .Turn_Rate
        Update_Ship_Angle(Ship(Active))
      End If
      If multikey(Controls.Fwd) then 
        Burst()
      End If
      If multikey(Controls.Dwn) then 
      
      End If
    Else
      If multikey(Controls.Lft) then 
        Scrn_X_Mid += 4*zoom
      End If
      If multikey(Controls.Rgt) then 
        Scrn_X_Mid -= 4*zoom
      End If
      If multikey(Controls.Fwd) then 
        Scrn_Y_Mid +=4*zoom
      End If
      If multikey(Controls.Dwn) then 
        Scrn_Y_Mid -=4*zoom
      End If
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
    
    If Ship(Active).Life_State = 1 Then
      
      Find_Dist(Asteroid(k).Body, Ship(Active).Body)
      G_Force_1way(Asteroid(k).Body, Ship(Active).Body)
      
      ''  collision detection using line segment - line segment intersection  
      If Distance <= Asteroid(k).wid + Ship(Active).Radius Then
        For l = 1 To Asteroid(k).Num_Points
          m = l+1: If m > Asteroid(k).Num_Points Then m = 1
          With Asteroid(k)
            As_1 = Vector_Add(.body.wrld_pos, .body_point(l).wrld_dot)
            As_2 = Vector_Add(.body.wrld_pos, .body_point(m).wrld_dot)
          End With
          For n = Lbound(Ship(Active).Body_Point) To Ubound(Ship(Active).Body_Point)
            With Ship(Active)
              m = n+1: If m > Ubound(Ship(Active).Body_Point) Then m = 1
              Sh_1 = Vector_Add(.body.wrld_pos, .body_point(n).wrld_dot)
              Sh_2 = Vector_Add(.body.wrld_pos, .body_point(m).wrld_dot)
            End With
            If SegmentsIntersect (As_1, As_2, Sh_1, Sh_2) = -1 Then
              With Ship(Active)
                .Life_State = 0
                .Explosion_State = 1
                For b = Lbound(.Particle) To Ubound(.Particle)
                  With .Particle(b)
                    .Life_State = 1
                    .Body.Wrld_Pos.X += Ship(Active).Body.Wrld_Pos.X/2
                    .Body.Wrld_Pos.Y += Ship(Active).Body.Wrld_Pos.Y/2
                    Update_Pos(.Body)
                  End With
                Next
              End With 
            End If
          Next
        Next
      End If
    Else
      If Ship(Active).Explosion_state = 1 Then
        For b = Lbound(Ship(Active).Particle) To Ubound(Ship(Active).Particle)
          With Ship(Active)
            If .Particle(b).Life_State = 1 Then
              Find_Dist(Asteroid(k).Body, .Particle(b).Body)
              G_Force_1way(Asteroid(k).Body, .Particle(b).Body)
              If Distance < Asteroid(k).wid Then
                For l = 1 To Asteroid(k).Num_Points
                  With Asteroid(k)
                    m = l+1: If m > .Num_Points Then m = 1
                    As_1 = Vector_Add(.body.wrld_pos, .body_point(l).wrld_dot)
                    As_2 = Vector_Add(.body.wrld_pos, .body_point(m).wrld_dot)
                  End With
                  With .Particle(b)
                    Sh_1 = .body.wrld_pos
                    Sh_2 = .Body.Wrld_Pos_old
                  End With
                  If SegmentsIntersect _
                    (As_1, As_2, Sh_1, Sh_2) = -1 Then 
                    .Particle(b).Life_State = 0
                  End If
                Next l
              End If
            End If
          End With
        Next
      End If
    End If
  Next
  
  ''update positions
  
  With Ship(Active)
    If .Life_State = 1 Then
      Update_Pos(.Body)
      .Speed =Sqr((.Body.Wrld_pos.X+.Body.Vel.X)^2 + (.Body.Wrld_pos.Y+.Body.Vel.Y)^2)
    Else
      If .Explosion_state = 1 Then
        For b = Lbound(.Particle) To Ubound(.Particle)
          With .Particle(b)
            If .Life_State = 1 Then
              Update_Pos(.Body)
            End If
          End With
        Next
      End If
    End If
    For b = Lbound(.burst) to Ubound(.burst)
      With .Burst(b)
        If .Life_State = 1 Then
          Update_Pos(.Body)
        End If
      End With
    Next
  End With
  
  ''  keep ship within screen
  
  With Ship(Active).Body
    
    If  (.scrn_pos.X > Scrn_Wid-Ship(Active).Radius) Or _
        (.scrn_pos.X < Ship(Active).Radius) Then 
      .Wrld_pos.X -= .vel.X
      .vel.X = -.Vel.X*0.1
      .Vel.Y *= 0.1
    End If
      
    If  (.scrn_pos.Y > Scrn_Hgt-Ship(Active).Radius) Or _
        (.scrn_pos.Y < Ship(Active).Radius) Then 
      .Wrld_pos.Y -= .vel.Y
      .Vel.X *= 0.1
      .vel.Y = -.Vel.Y*0.1
    End If
    
  End With
  
  For a = Lbound(Asteroid) to Ubound(Asteroid)
    Update_Asteroid_Angle(Asteroid(a))
    Update_Pos(Asteroid(a).Body)
  Next
  
  Update_Landing_Site_Angle(Landing_Site)
  
  ''  draw graphics
  
  glViewport( 0, 0, scrn_wid, scrn_hgt )
  glScissor( 0, 0, scrn_wid/2, scrn_hgt )
  
  glClear GL_COLOR_BUFFER_BIT Or GL_DEPTH_BUFFER_BIT

  Draw_Burst()
  
  With Ship(Active)
    If .Life_State = 1 Then
      'Draw_Trajectory (Ship(Active).Body)
      Draw_Ship(Ship(Active))
    Else
      If .Explosion_state = 1 Then
          For b = Lbound(.Particle) To Ubound(.Particle)
            With .Particle(b)
              If .Life_State = 1 Then
                Draw_Particle(.Body)
              End If
            End With
          Next
        End If
    End If
  End With
  
  Draw_Landing_Site(Landing_Site)
  
  For a = Lbound(Asteroid) to Ubound(Asteroid)
    'Draw_Trajectory (Asteroid(a).Body)
    Draw_Asteroid(Asteroid(a))
  Next
  
  glViewport(scrn_wid/2, 0, scrn_wid, scrn_hgt )
  glScissor(scrn_wid/2, 0, scrn_wid/2, scrn_hgt )
  
  glClear GL_COLOR_BUFFER_BIT Or GL_DEPTH_BUFFER_BIT

  Draw_Burst()
  
  With Ship(Active)
    If .Life_State = 1 Then
      'Draw_Trajectory (Ship(Active).Body)
      Draw_Ship(Ship(Active))
    Else
      If .Explosion_state = 1 Then
          For b = Lbound(.Particle) To Ubound(.Particle)
            With .Particle(b)
              If .Life_State = 1 Then
                Draw_Particle(.Body)
              End If
            End With
          Next
        End If
    End If
  End With
  
  Draw_Landing_Site(Landing_Site)
  
  For a = Lbound(Asteroid) to Ubound(Asteroid)
    'Draw_Trajectory (Asteroid(a).Body)
    Draw_Asteroid(Asteroid(a))
  Next
  
  glFlush
  Flip

  Sleep 1, 1

Loop Until Multikey(Controls.esc)

End
