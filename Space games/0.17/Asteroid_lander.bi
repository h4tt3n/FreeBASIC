Type Pos_2D
  As Single X, Y
End Type

Type Pos_3D
  As Single X, Y, Z
End Type

Type Col
  As Ubyte R, G, B
End Type

Type Body_Point
  As Pos_2D stat_Dot, wrld_Dot
  As Col Col
End Type

Type Controls
  As Ubyte lft, rgt, fwd, esc
End Type

Type Body
  As Col Col
  As Pos_2D wrld_pos, Vel
  As Pos_3D Scrn_Pos
  As Single Mass
End Type

Type Particle
  Life_State as Ubyte
  Body as Body
  Radius As Single 
  Spawn_Speed as Single
  Spawn_Angle as Single
  Life_Time as Ushort
  Life_TimeLeft as Ushort
  Col As Col
End Type

Type Ship
  Life_State as Ubyte
  Body as Body
  Body_Point(1 to 4) as Body_Point
  Fuel as Single
  Radius As Single 
  Spawn_Angle as Single
  Spawn_Distance as Single
  Angle as Single
  Sin_Ang as Single
  Cos_Ang as Single
  Turn_Rate as Single
  Thrust_Force as Single
  Explosion_state as Ubyte
  Burst(1 to 30) as Particle
  Particle(1 to 120) as Particle
End Type

Type Asteroid
  Life_State as Ubyte
  Body as Body
  Num_Points as Ubyte
  Body_Point(0 to 64) as Body_Point
  Spawn_Angle as Single
  Spawn_Distance as Single
  Radius As Single 
  Angle as Single
  Sin_Ang as Single
  Cos_Ang as Single
  Turn_Rate as Single
End Type

Type Debris
  Life_State as Ubyte
  Body as Body
  Spawn_Angle as Single
  Spawn_Distance as Single
  Radius As Single
  Angle as Single
  Sin_Ang as Single
  Cos_Ang as Single
  Turn_Rate as Single
  Particle(1 to 60) as Particle
  Col As Col
End Type

Const As Single _
  Pi = 4*Atn(1), TwoPi = Pi*2, rad2deg = 360/TwoPi, deg2rad = TwoPi/360, _
  Phi = (Sqr(5)-1)/2, FALSE = 0, TRUE  = not FALSE
  
Dim Shared As Ubyte _
  Active

Dim Shared As Ushort _
  K, L, M, N

Dim Shared As Integer _
  Scrn_Wid, Scrn_Hgt, Scrn_Bpp, Scrn_Rate, Scrn_Full, Scrn_X_Mid, Scrn_Y_Mid

Dim Shared As Single _
  Dist_sqared, Distance, Force, Scrn_X, Scrn_Y, Pos_Factor, Col, Angle, _
  Sin_Ang, Cos_Ang, X, Y, Chk, Dist1, Dist2, Astr_X1, Astr_Y1, Astr_X2, _
  Astr_Y2, Ship_X, Ship_Y, Collision

Dim Shared as Pos_2D Dist

Dim Shared As Controls Controls
Dim Shared As Ship Ship(1 to 3)
Dim Shared As Asteroid Asteroid(1 to 2)

Sub Initialize_openGl_2D()
  screenres Scrn_Wid, Scrn_Hgt, Scrn_Bpp,, 2 OR Scrn_Full
  glMatrixMode(GL_PROJECTION)      ' Define matrix
  glLoadIdentity()
  glViewport (0, 0, Scrn_Wid, Scrn_Hgt)' Define axis as FB style (0,0 in top left)
  glOrtho(0, Scrn_Wid, Scrn_Hgt, 0, -128, 128)
  glMatrixMode(GL_MODELVIEW)       ' Deactivate rendering of backside
  glEnable(GL_CULL_FACE)
  glCullFace(GL_BACK)
  glEnable (GL_TEXTURE_2D)         ' Activate textures
  glLoadIdentity()
  glEnable(GL_DEPTH_TEST)          ' Depth test
  glDepthFunc(GL_LESS)
  glEnable(GL_ALPHA_TEST)          ' Alpha test
  glAlphaFunc(GL_GREATER, 0.1)
  glEnable(GL_BLEND)               ' Activate blending, including alpha channel
  glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
  'glENable(GL_SCISSOR_TEST)
End Sub

Sub Find_Dist (byref Body_1 as Body, byref Body_2 as Body)
  Dist.X = Body_1.Wrld_Pos.X-Body_2.Wrld_Pos.X
  Dist.Y = Body_1.Wrld_Pos.Y-Body_2.Wrld_Pos.Y
  Dist_Sqared = Dist.X*Dist.X + Dist.Y*Dist.Y
  Distance = Sqr(Dist_Sqared)
End Sub

Sub G_Force_1way (byref Body_1 as Body, byref Body_2 as Body)
  Force = (Body_1.Mass/Dist_sqared)
  Body_2.Vel.X += (Dist.X/Distance)*Force
  Body_2.Vel.Y += (Dist.Y/Distance)*Force
End Sub

Sub G_Force_2way (byref Body_1 as Body, byref Body_2 as Body)
  Force = (Body_1.Mass/Dist_sqared)
  Body_2.Vel.X += (Dist.X/Distance)*Force
  Body_2.Vel.Y += (Dist.Y/Distance)*Force
  Force = (Body_2.Mass/Dist_sqared)
  Body_1.Vel.X -= (Dist.X/Distance)*Force
  Body_1.Vel.Y -= (Dist.Y/Distance)*Force
End Sub

Sub Update_Pos (byref Body as Body)
  With Body
    .Wrld_Pos.X += .Vel.X
    .Wrld_Pos.Y += .Vel.Y
    .Scrn_Pos.X = Scrn_X_Mid+.Wrld_Pos.X-ship(Active).Body.Wrld_Pos.X*pos_factor
    .Scrn_Pos.Y = Scrn_Y_Mid+.Wrld_Pos.Y-ship(Active).Body.Wrld_Pos.Y*pos_factor
  End With
End Sub

Sub Update_Ship_Angle (byref Ship As Ship)
  With Ship
    .Cos_Ang = Cos(.Angle*deg2rad)
    .Sin_Ang = Sin(.Angle*deg2rad)
    For m = Lbound(.Body_Point) to Ubound(.Body_Point)
      With .Body_Point(m)
        .Wrld_Dot.X = (Ship.Cos_Ang*.stat_Dot.X)-(Ship.Sin_Ang*.stat_Dot.Y)
        .Wrld_Dot.Y = (Ship.Cos_Ang*.stat_Dot.Y)+(Ship.Sin_Ang*.stat_Dot.X)
      End With
    Next
  End With
End Sub

Sub Update_Asteroid_Angle (byref Asteroid As Asteroid)
  With Asteroid
    .Angle += .Turn_Rate
    .Cos_Ang = Cos(.Angle*deg2rad)
    .Sin_Ang = Sin(.Angle*deg2rad)
    For m = Lbound(.Body_Point) to .Num_Points
      With .Body_Point(m)
        .Wrld_Dot.X = (Asteroid.Cos_Ang*.stat_Dot.X)+(Asteroid.Sin_Ang*.stat_Dot.Y)
        .Wrld_Dot.Y = (Asteroid.Cos_Ang*.stat_Dot.Y)-(Asteroid.Sin_Ang*.stat_Dot.X)
      End With
    Next
  End With
End Sub

Sub Draw_Particle (Byref Body As Body)
  With Body
    GlLoadIdentity
    GlTranslatef .scrn_pos.X, .scrn_pos.Y, .Scrn_Pos.Z
    glcolor3ub .Col.R, .Col.G, .Col.B
    GlPointSize(1)
    GlBegin GL_POINTS
      glvertex2f 0, 0
    GlEnd
  End With
End Sub

Sub Draw_Ship (Byref Ship As Ship)
  With Ship
    GlLoadIdentity
    GlTranslatef .Body.scrn_pos.X, .Body.scrn_pos.Y, .Body.Scrn_Pos.Z
    GlBegin Gl_Polygon
      For k = Lbound(.Body_Point) to Ubound(.Body_Point)
        With .Body_Point(k)
          glcolor3ub .Col.R, .Col.G, .Col.B
          glvertex2f .Wrld_Dot.X, .Wrld_Dot.Y
        End With
      Next
    GlEnd
  End With
End Sub

Sub Draw_Asteroid (Byref Asteroid As Asteroid)
  With Asteroid
    GlLoadIdentity
    GlTranslatef .Body.scrn_pos.X, .Body.scrn_pos.Y, .Body.Scrn_Pos.Z
    GlBegin Gl_Triangle_Strip
      For k = Lbound(.Body_Point)+1 to .Num_Points-1
        With .Body_Point(0)
          glcolor3ub .Col.R, .Col.G, .Col.B
          glvertex2f .Wrld_Dot.X, .Wrld_Dot.Y
        End With
        With .Body_Point(k)
          glcolor3ub .Col.R, .Col.G, .Col.B
          glvertex2f .Wrld_Dot.X, .Wrld_Dot.Y
        End With
        With .Body_Point(k+1)
          glcolor3ub .Col.R, .Col.G, .Col.B
          glvertex2f .Wrld_Dot.X, .Wrld_Dot.Y
        End With
      Next
      With .Body_Point(0)
        glcolor3ub .Col.R, .Col.G, .Col.B
        glvertex2f .Wrld_Dot.X, .Wrld_Dot.Y
      End With
      With .Body_Point(1)
        glcolor3ub .Col.R, .Col.G, .Col.B
        glvertex2f .Wrld_Dot.X, .Wrld_Dot.Y
      End With
      With .Body_Point(.Num_Points)
        glcolor3ub .Col.R, .Col.G, .Col.B
        glvertex2f .Wrld_Dot.X, .Wrld_Dot.Y
      End With
    Glend
  End With
End Sub

Sub Burst()
  With Ship(Active)
    If .Fuel >= 0.01 then
      .Fuel -= 0.01
      .Body.Vel.X += .Sin_Ang*.Thrust_Force/(.Body.Mass+.Fuel)
      .Body.Vel.Y -= .Cos_Ang*.Thrust_Force/(.Body.Mass+.Fuel)
      For k = Lbound(.Burst) to Ubound(.Burst)
        If .Burst(k).Life_State = 0 Then
          .Burst(k).Body.Vel.X = .Body.vel.X-(.Burst(k).Spawn_Speed*.Sin_Ang+Rnd*0.3-Rnd*0.3)
          .Burst(k).Body.Vel.Y = .Body.Vel.Y+(.Burst(k).Spawn_Speed*.Cos_Ang+Rnd*0.3-Rnd*0.3)
          .Burst(k).Body.wrld_Pos.X = .Body.wrld_Pos.X+.Body_Point(3).Wrld_Dot.X
          .Burst(k).Body.wrld_Pos.Y = .Body.wrld_Pos.Y+.Body_Point(3).Wrld_Dot.Y
          .Burst(k).Life_TimeLeft = .Burst(k).Life_Time
          .Burst(k).Life_State = 1
          Exit For
        End If
      Next
    Else 
      .Fuel = 0
    End If
  End With
End Sub

Sub Draw_Burst()
  With Ship(Active)
    For k = Lbound(.burst) to Ubound(.burst)
      With .Burst(k)
        If .Life_State = 1 Then
          If .Life_TimeLeft >= 1 Then
            .Life_TimeLeft -= 1
            Col = .Life_TimeLeft/.Life_Time
            Draw_Particle(.Body)
          Else
            .Life_State = 0
            With .Body
              .Col.R = 255
              .Col.G = 255
              .Col.B = 255
            End With
          End If
        End If
      End With
    Next
  End With
End Sub

Sub Draw_Ellipse (Byref cX As Single, Byref cY As Single, _
  Byref Wid As Single, Byref Hgt As Single, Byref angle As Single, _
  Byref col as uinteger, Byref num_lines as Integer) 
    
    Dim as Single _
    SinAngle, CosAngle, Theta, DeltaTheta, X, Y, rX, rY
    
    Dim As Ubyte _
    R, G, B
    
    SinAngle = Sin(-Angle) 
    CosAngle = Cos(Angle)
    Theta = 0
    DeltaTheta = Twopi/num_lines
    
    glLoadIdentity()
    glTranslatef cX, Cy, 0
    GlColor3ub 128, 16, 16
    GLBegin Gl_Line_Loop
      Do
        X = Wid * Cos(Theta) 
        Y = Hgt * Sin(Theta) 
        rX = X * CosAngle + Y * SinAngle 
        rY = -X * SinAngle + Y * CosAngle
        Theta += DeltaTheta
        GlVertex2f rX, rY
      Loop Until Theta > TwoPi
    GlEnd
End Sub

Function Astr_Ship_ColDetec1(byref Asteroid as Asteroid, byref Ship as Ship) As Integer
  If Distance <= Asteroid.Radius+Ship.Radius Then
    Return 1
  Else
    Return 0
  End If
End Function

Function Astr_Ship_ColDetec2(byref Asteroid as Asteroid, byref Ship as Ship) As Integer
  For m = Lbound(Ship.Body_Point)+1 To Ubound(Ship.Body_Point)-1
      For n = Lbound(Asteroid.Body_Point)+1 To Asteroid.Num_Points-1
        
        Astr_X1 = Asteroid.Body.wrld_pos.X + Asteroid.Body_Point(n).wrld_dot.X
        Astr_Y1 = Asteroid.Body.wrld_pos.Y + Asteroid.Body_Point(n).wrld_dot.Y
        
        Astr_X2 = Asteroid.Body.wrld_pos.X + Asteroid.Body_Point(n+1).wrld_dot.X
        Astr_Y2 = Asteroid.Body.wrld_pos.Y + Asteroid.Body_Point(n+1).wrld_dot.Y
        
        Ship_X = Ship.Body.wrld_pos.X + Ship.Body_Point(m).wrld_dot.X
        Ship_Y = Ship.Body.wrld_pos.Y + Ship.Body_Point(m).wrld_dot.Y
        
        Dist.X = Astr_X1 - Astr_X2
        Dist.Y = Astr_Y1 - Astr_Y2
        Chk = (Dist.X*Dist.X)+(Dist.Y*Dist.Y)
        Distance = ((Dist.X*(Astr_Y1-Ship_Y))-((Astr_X1-Ship_X)*Dist.Y))/Sqr(Chk)
        If Distance < 2 Then
          dist1 = (Astr_X2-Ship_X)^2 + (Astr_Y2-Ship_Y)^2
          If Dist1 <= Chk Then
            dist2 = (Astr_X1-Ship_X)^2 + (Astr_Y1-Ship_Y)^2
            If dist2 <= Chk Then
              Return 1
            Else
              Return 0
            End If
          End If
        End If
      Next
    Next
End Function

With Controls
  .Lft = 75
  .Rgt = 77
  .fwd = 72
  .esc = 1
End With

With Asteroid(1)
  .Life_State = 1
  .Radius = 160
  .Num_Points = 24
  With .Body
    .wrld_pos.X = 0
    .wrld_pos.Y = 0
    .Scrn_Pos.Z = 1
    .Mass = 500
  End With
  With .Body_Point(0)
    .stat_dot.X = 0
    .stat_dot.y = 0
    .col.R = 144: .col.G = 144: .col.B = 144
  End With
  .Angle = Rnd*360
  .Sin_Ang = Sin(.Angle*Deg2Rad)
  .Cos_Ang = Cos(.Angle*Deg2Rad)
  .Turn_Rate = -0.05
  For l = Lbound(.Body_Point)+1 to .Num_Points
    Angle = TwoPi*((.Num_Points+1-l)/.Num_Points)
    Col = (Asteroid(1).Radius-10)+(Rnd*20)
    X = Col*Cos(Angle)
    Y = (Col+40)*Sin(Angle)
    With .Body_Point(l)
      .stat_dot.X = X * Asteroid(1).Cos_Ang + Y * Asteroid(1).Sin_Ang
      .stat_dot.y = -X * Asteroid(1).Sin_Ang + Y * Asteroid(1).Cos_Ang
      .col.R = 96: .col.G = 96: .col.B = 96
    End With
  Next
End With

With Asteroid(2)
  .Life_State = 1
  .Radius = 40
  .Spawn_Angle = Rnd*twopi
  .Spawn_Distance = 480
  .Num_Points = 12
  With .Body
    .wrld_Pos.X = Asteroid(1).Body.wrld_Pos.X-Asteroid(2).Spawn_Distance*Sin(Asteroid(2).Spawn_Angle) 
    .wrld_Pos.Y = Asteroid(1).Body.wrld_Pos.Y-Asteroid(2).Spawn_Distance*Cos(Asteroid(2).Spawn_Angle) 
    .Vel.X = 0.96*sqr(Asteroid(1).Body.Mass/Asteroid(2).Spawn_Distance)*Cos(Asteroid(2).Spawn_Angle)
    .Vel.Y = 0.96*sqr(Asteroid(1).Body.Mass/Asteroid(2).Spawn_Distance)*Sin(-Asteroid(2).Spawn_Angle)
    .Scrn_Pos.Z = 1
    .Mass = 50
  End With
  With .Body_Point(0)
    .stat_dot.X = 0
    .stat_dot.y = 0
    .col.R = 128: .col.G = 96: .col.B = 96
  End With
  .Angle = Rnd*360
  .Sin_Ang = Sin(.Angle*Deg2Rad)
  .Cos_Ang = Cos(.Angle*Deg2Rad)
  .Turn_Rate = 0.3
  For l = Lbound(.Body_Point)+1 to .Num_Points
    Angle = TwoPi*((.Num_Points+1-l)/.Num_Points)
    Col = (Asteroid(2).Radius-8)+(Rnd*16)
    X = Col*Cos(Angle)
    Y = (Col+20)*Sin(Angle)
    With .Body_Point(l)
      .stat_dot.X = X * Asteroid(2).Cos_Ang + Y * Asteroid(2).Sin_Ang
      .stat_dot.y = -X * Asteroid(2).Sin_Ang + Y * Asteroid(2).Cos_Ang
      .col.R = 96: .col.G = 72: .col.B = 72
    End With
  Next
End With

With Ship(1)
  .Life_State = 1
  .Spawn_Angle = Rnd*TwoPi
  .Spawn_Distance = 80
  With .Body
    .wrld_Pos.X = Asteroid(2).Body.wrld_Pos.X+Ship(1).Spawn_Distance*Sin(Ship(1).Spawn_Angle) 
    .wrld_Pos.Y = Asteroid(2).Body.wrld_Pos.Y+Ship(1).Spawn_Distance*Cos(Ship(1).Spawn_Angle) 
    .Vel.X = Asteroid(2).Body.Vel.X+sqr(Asteroid(2).Body.Mass/Ship(1).Spawn_Distance)*Cos(Ship(1).Spawn_Angle)
    .Vel.Y = Asteroid(2).Body.Vel.Y+sqr(Asteroid(2).Body.Mass/Ship(1).Spawn_Distance)*Sin(-Ship(1).Spawn_Angle)
    .Mass = 10
  End With
  With .Body_Point(1)
    .stat_dot.X = 0:.stat_dot.y = -14
    .col.R = 244:.col.G = 244:.col.B = 244
  End With
  With .Body_Point(2)
    .stat_dot.X = -10:.stat_dot.y = 8
    .col.R = 192:.col.G = 192:.col.B = 192
  End With
  With .Body_Point(3)
    .stat_dot.X = 0:.stat_dot.y = 6
    .col.R = 128:.col.G = 128:.col.B = 128
  End With
  With .Body_Point(4)
    .stat_dot.X = 10:.stat_dot.y = 8
    .col.R = 192:.col.G = 192:.col.B = 192
  End With
  .Fuel = 20
  .Radius = 14
  .Spawn_Angle = Rnd*TwoPi
  .Spawn_Distance = 500
  .Turn_Rate = 6
  .Thrust_Force = 1.5
  .Explosion_state = 0
  For l = Lbound(.Burst) to Ubound(.Burst)
    With .Burst(l)
      '.Spawn_Angle
      .Spawn_Speed = 1+Rnd*2
      .Life_State = 0
      .Life_Time = 8+Rnd*4
      With .Body
        .Col.R = 255
        .Col.G = 255
        .Col.B = 255
      End With
    End With
  Next
End With




'  .GM = Body(.Host).Grav_Param+Body(Traced).Grav_Param
'  ''  find size and eccentricity of elliptic trajectory
'  Xdist = Body(.Host).X-Body(Traced).X
'  Ydist = Body(.Host).Y-Body(Traced).Y
'  .Distance = Sqr(Xdist^2 + Ydist^2)
'  Xdist2 = Body(.Host).Xold-Body(Traced).Xold
'  Ydist2 = Body(.Host).Yold-Body(Traced).Yold
'  .Distance_old = Sqr(Xdist2^2 + Ydist2^2)
'  .Speed = Sqr((Body(Traced).Xvec-Body(.host).Xvec)^2 + (Body(Traced).Yvec-Body(.host).Yvec)^2)
'  .Theta = Halfpi-Acos((.Speed^2+.Distance^2-.Distance_Old^2)/(2*.Speed*.Distance))
'  .Areal_Velocity = (cos(.Theta)*.Speed*.Distance)/2
'  .semimajor_Axis = -1/((.Speed^2/.GM)-(2/.Distance))
'  .Orbital_Period = TwoPi*Sqr(.semimajor_axis^3/.GM)
'  .Eccentricity = Sqr(1-((.Areal_velocity*.Orbital_period)/(pi*.semimajor_axis^2))^2)
'  '.Eccentricity = Sqr(1-((cos(.Theta)*.Speed*.Distance*Sqr(.semimajor_axis^3/.GM))/.semimajor_axis^2)^2)
'  .Semiminor_axis = .Semimajor_axis*sqr(1-(.Eccentricity^2))
'  .Foci_Dist = .Eccentricity*.semimajor_axis
'  ''  find the elliptic trajectory's angle relative to frame of reference
'  .True_Anomaly = Acos((((.semimajor_axis*(1-.Eccentricity^2))/.Distance)-1)/.Eccentricity)
'  Pol((Body(.Host).X-Body(Traced).X), (Body(.Host).Y-Body(Traced).Y))
'  .Reference_Angle_Old = .Reference_Angle
'  .Reference_Angle = Tpol
'  'Pol((Body(Host).X-Body(Host).Xvec-Body(Traced).X-Body(Traced).Xvec), (Body(Host).y-Body(Host).yvec-Body(Traced).y-Body(Traced).yvec))
'  '.Reference_Angle_Old = Tpol
'  If .Reference_Angle < .Reference_Angle_Old Then
'      If .Theta < 0 Then
'          .Orbit_Angle = .True_Anomaly-.Reference_Angle
'      Else
'          .Orbit_Angle = -.Reference_Angle-.True_Anomaly
'      End If
'  Else
'      If .Theta > 0 Then
'          .Orbit_Angle = .True_Anomaly-.Reference_Angle
'      Else
'          .Orbit_Angle = -.Reference_Angle-.True_Anomaly
'      End If
'  End If

Sub Draw_Trajectory (Byref Ship as Ship)
  
  Dim As Ushort Host
  
  Dim as Single Distance_Old
  
  Host = 1
  
  Find_Dist (Ship.Body, Asteroid(Host).Body)
  
End Sub






