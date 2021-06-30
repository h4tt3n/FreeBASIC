
Type Pos_3D
  As Single X, Y, Z
End Type

Type Col
  As Ubyte R, G, B
End Type

Type Body_Point
  As Pos_3D stat_Dot, wrld_Dot
  As Col Col
End Type

Type Controls
  As Ubyte lft, rgt, fwd, dwn, esc
End Type

Type Fuel_Meter
  Wid as Integer
  Hgt as Integer
  Dot(1 to 4) as Pos_3D
End Type

Type Speedometer
  Wid as Integer
  Hgt as Integer
  Dot(1 to 4) as Pos_3D
End Type

Type Body
  As Col Col
  As Pos_3D wrld_pos, wrld_pos_old, Vel
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
  Speed as Single
  Speed_Max As Single
  Explosion_state as Ubyte
  Burst(1 to 40) as Particle
  Particle(1 to 400) as Particle
End Type

Type Landing_Site
  Host_Astr As Ubyte
  Host_Point As Integer
  Body_Point(1 to 4) as Body_Point
  Angle as Single
  Sin_Ang as Single
  Cos_Ang as Single
  Turn_Rate as Single
End Type

Type Asteroid
  Life_State as Ubyte
  Body as Body
  Num_Points as Ubyte
  Noise as Ubyte
  Body_Point(0 to 128) as Body_Point
  Spawn_Angle as Single
  Spawn_Distance as Single
  wid As Single 
  hgt As Single 
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
  Pi = 4*Atn(1), TwoPi = Pi*2, HalfPi = Pi/2, rad2deg = 360/TwoPi, _
  deg2rad = TwoPi/360, Phi = (Sqr(5)-1)/2
  
Dim Shared As Ubyte _
  Active, Collision

Dim Shared As Ushort _
  A, B, C, i, k, l, m, n

Dim Shared As Integer _
  Scrn_Wid, Scrn_Hgt, Scrn_Bpp, Scrn_Rate, Scrn_Full, Scrn_X_Mid, Scrn_Y_Mid
  
Dim Shared as uinteger handle(1 to 4)

Dim Shared As Single _
  Dist_sqared, Dist_Cubed, Distance, Force, Scrn_X, Scrn_Y, Pos_Factor, Col, Angle, _
  Sin_Ang, Cos_Ang, X, Y, Xrec, Yrec, Rpol, Tpol, Scrn_Angle, Scrn_Cos_Ang, _
  Scrn_Sin_Ang, zoom = 1, zoom_min, zoom_max

Dim Shared as Pos_3D Dist, Normal, ipoint, As_1, As_2, Sh_1, Sh_2 

Dim Shared As Controls Controls
Dim Shared As Ship Ship(1 to 3)
Dim Shared As Asteroid Asteroid(1 to 3)
Dim Shared As Landing_Site Landing_Site

Function Vector_Add (byref v1 As Pos_3D, byref v2 As Pos_3D) As Pos_3D
  Dim v as Pos_3D
  v.x = v1.x + v2.x
  v.y = v1.y + v2.y
  Return v
End Function

Function Vector_Cross (v1 As Pos_3D, v2 As Pos_3D) As Pos_3D
    Dim v As Pos_3D
    v.x = (v1.y * v2.z) - (v2.y * v1.z)
    v.y = (v1.z * v2.x) - (v2.z * v1.x)
    v.z = (v1.x * v2.y) - (v2.x * v1.y)
    Return v
End Function

Function Vector_Magnitude(V As Pos_3D) As Single 
    Dim Mag As Single 
    Mag = Sqr(v.x ^2 + v.y ^2 + v.z ^2) 
    If Mag = 0 Then Mag = 1 
    Vector_Magnitude = Mag 
End Function

Sub Vector_Normalize (v As Pos_3D) 
    Dim Mag As Single 
    Mag = Vector_Magnitude(V)    
    v.x = v.x / Mag 
    v.y = v.y / Mag 
    v.z = v.z / Mag 
End Sub 

Sub Initialize_openGl_2D()
  screenres Scrn_Wid, Scrn_Hgt, Scrn_Bpp,, 2 OR Scrn_Full
  glMatrixMode(GL_PROJECTION)      ' Define matrix
  glLoadIdentity()
  glViewport (0, 0, Scrn_Wid, Scrn_Hgt)' Define axis as FB style (0,0 in top left)
  glOrtho(0, Scrn_Wid, Scrn_Hgt, 0, -128, 128)
  glFrontFace(GL_CCW)
  glMatrixMode(GL_MODELVIEW)       ' Deactivate rendering of backside
  glEnable(GL_CULL_FACE)
  glCullFace(GL_BACK)
  glLoadIdentity()
  glEnable(GL_DEPTH_TEST)          ' Depth test
  glDepthFunc(GL_LESS)
  glEnable(GL_ALPHA_TEST)          ' Alpha test
  glAlphaFunc(GL_GREATER, 0.1)
  glEnable(GL_BLEND)               ' Activate blending, including alpha channel
  glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
  glEnable( GL_SCISSOR_TEST )
End Sub

Sub Initialize_GL_lighting()
  
  glEnable(Gl_LIGHTING)
  glShadeModel(GL_SMOOTH)
  
  Dim global_ambient(0 to 3) as single => { 0.0f, 0.0f, 0.0f, 1.0f }
  Dim mcolor(0 to 3) as single => { 0.2f, 0.2f, 0.2f, 1.0f }
  
  dim LightDiffuse(0 to 3) as single => {300, 300, 300, 1.0}
  dim LightPosition(0 to 3) as single => {500, 0, 3, 1.0}  ''  Position 
  
  glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mcolor(0))
  
  glLightModelfv(GL_LIGHT_MODEL_AMBIENT, @global_ambient(0))
  
  glEnable(GL_LIGHT0)
  glLightfv(GL_LIGHT0, GL_DIFFUSE, @LightDiffuse(0))   '' Setup The Diffuse Light
  glLightfv(GL_LIGHT0, GL_POSITION, @LightPosition(0))'' Position The Light
  
End Sub

''''''''''''''''''''''''''

  

''''''''''''''''''''''''''''''''''''''

Sub Find_Dist (byref Body_1 as Body, byref Body_2 as Body)
  Dist.X = Body_1.Wrld_Pos.X-Body_2.Wrld_Pos.X
  Dist.Y = Body_1.Wrld_Pos.Y-Body_2.Wrld_Pos.Y
  Dist_Sqared = Dist.X*Dist.X + Dist.Y*Dist.Y
  Distance = Sqr(Dist_Sqared)
  Dist_Cubed = Distance * Dist_Sqared
End Sub

Sub G_Force_1way (byref Body_1 as Body, byref Body_2 as Body)
  Body_2.Vel.X += Body_1.Mass*Dist.X/Dist_Cubed
  Body_2.Vel.Y += Body_1.Mass*Dist.Y/Dist_Cubed
End Sub

Sub G_Force_2way (byref Body_1 as Body, byref Body_2 as Body)
  Body_2.Vel.X += Body_1.Mass*Dist.X/Dist_Cubed
  Body_2.Vel.Y += Body_1.Mass*Dist.Y/Dist_Cubed
  Body_1.Vel.X -= Body_2.Mass*Dist.X/Dist_Cubed
  Body_1.Vel.Y -= Body_2.Mass*Dist.Y/Dist_Cubed
End Sub

Sub Scrn_Angle_Update ()
  Scrn_Cos_Ang = Cos(Scrn_Angle*deg2rad)
  Scrn_Sin_Ang = Sin(Scrn_Angle*deg2rad)
End Sub

Sub Update_Pos (byref Body as Body)
  With Body
    .Wrld_Pos_Old.X = .Wrld_Pos.X
    .Wrld_Pos_Old.Y = .Wrld_Pos.Y
    .Wrld_Pos.X += .Vel.X
    .Wrld_Pos.Y += .Vel.Y
    Scrn_X = .Wrld_Pos.X-ship(active).Body.Wrld_Pos.X
    Scrn_Y = .Wrld_Pos.Y-ship(active).Body.Wrld_Pos.Y
    .Scrn_Pos.X = Scrn_X_Mid+((Scrn_Cos_Ang*Scrn_X)-(Scrn_Sin_Ang*Scrn_Y))*zoom
    .Scrn_Pos.Y = Scrn_Y_Mid+((Scrn_Cos_Ang*Scrn_Y)+(Scrn_Sin_Ang*Scrn_X))*zoom
  End With
End Sub

Sub Update_Ship_Angle (byref Ship As Ship)
  With Ship
    .Cos_Ang = Cos(.Angle*deg2rad)
    .Sin_Ang = Sin(.Angle*deg2rad)
    For b = Lbound(.Body_Point) to Ubound(.Body_Point)
      With .Body_Point(b)
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
    For b = Lbound(.Body_Point) to .Num_Points
      With .Body_Point(b)
        .Wrld_Dot.X = (Asteroid.Cos_Ang*.stat_Dot.X)-(Asteroid.Sin_Ang*.stat_Dot.Y)
        .Wrld_Dot.Y = (Asteroid.Cos_Ang*.stat_Dot.Y)+(Asteroid.Sin_Ang*.stat_Dot.X)
      End With
    Next
  End With
End Sub

Sub Update_Landing_Site_Angle (byref Landing_Site As Landing_Site)
  With Landing_Site
    .Angle += .Turn_Rate
    .Cos_Ang = Cos((.Angle+scrn_angle)*deg2rad)
    .Sin_Ang = Sin((.Angle+scrn_angle)*deg2rad)
    For b = Lbound(.Body_Point) to Ubound(.Body_Point)
      With .Body_Point(b)
        .Wrld_Dot.X = (Landing_Site.Cos_Ang*.stat_Dot.X)-(Landing_Site.Sin_Ang*.stat_Dot.Y)
        .Wrld_Dot.Y = (Landing_Site.Cos_Ang*.stat_Dot.Y)+(Landing_Site.Sin_Ang*.stat_Dot.X)
      End With
    Next
  End With
End Sub

Sub Draw_Particle (Byref Body As Body)
  With Body
    GlLoadIdentity
    GlTranslatef .scrn_pos.X, .scrn_pos.Y, .Scrn_Pos.Z
    GLScalef zoom, zoom, 0
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
    GLRotatef scrn_angle, 0, 0, 1
    GLScalef zoom, zoom, 0
    GlBegin Gl_Polygon
      For b = Lbound(.Body_Point) to Ubound(.Body_Point)
        With .Body_Point(b)
          glcolor3ub .Col.R, .Col.G, .Col.B
          glvertex2f .Wrld_Dot.X, .Wrld_Dot.Y
        End With
      Next
    GlEnd
  End With
End Sub

Sub Draw_Landing_Site (Byref Landing_Site As Landing_Site)
  With Landing_Site
    GlLoadIdentity
    With Asteroid(.Host_Astr)
      X = .Body.Scrn_Pos.X + .Body_Point(Landing_Site.Host_Point).Wrld_Dot.X
      Y = .Body.Scrn_Pos.Y + .Body_Point(Landing_Site.Host_Point).Wrld_Dot.Y
    End With
    GlTranslatef X, Y, -1
    'GLRotatef scrn_angle, 0, 0, 1
    GLScalef zoom, zoom, 0
    GlBegin Gl_Quads
      For b = Lbound(.Body_Point) to Ubound(.Body_Point)
        With .Body_Point(b)
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
    GLRotatef scrn_angle, 0, 0, 1
    GLScalef zoom, zoom, 0
    GlBindTexture (GL_TEXTURE_2D, handle(1))
    GlBegin Gl_Triangle_Strip
      For b = Lbound(.Body_Point)+1 to .Num_Points-1
        With .Body_Point(0)
          gltexcoord3f 0, 1, 0
          'glcolor3ub .Col.R, .Col.G, .Col.B
          glvertex3f .Wrld_Dot.X, .Wrld_Dot.Y, 0
        End With
        With .Body_Point(b)
          gltexcoord3f 1, 0, 0
          'glcolor3ub .Col.R, .Col.G, .Col.B
          glvertex3f .Wrld_Dot.X, .Wrld_Dot.Y, 0
        End With
        With .Body_Point(b+1)
          gltexcoord3f 1, 1, 0
          'glcolor3ub .Col.R, .Col.G, .Col.B
          glvertex3f .Wrld_Dot.X, .Wrld_Dot.Y, 0
        End With
      Next
      With .Body_Point(0)
        'glcolor3ub .Col.R, .Col.G, .Col.B
        glvertex3f .Wrld_Dot.X, .Wrld_Dot.Y, 0
      End With
      With .Body_Point(1)
        'glcolor3ub .Col.R, .Col.G, .Col.B
        glvertex3f .Wrld_Dot.X, .Wrld_Dot.Y, 0
      End With
      With .Body_Point(.Num_Points)
        'glcolor3ub .Col.R, .Col.G, .Col.B
        glvertex3f .Wrld_Dot.X, .Wrld_Dot.Y, 0
      End With
    Glend
    GlBindTexture (GL_TEXTURE_2D, 0)
  End With
End Sub

Sub Burst()
  With Ship(Active)
    If .Fuel >= 0.01 then
      .Fuel -= 0.01
      .Body.Vel.X += .Sin_Ang*.Thrust_Force/(.Body.Mass+.Fuel)
      .Body.Vel.Y -= .Cos_Ang*.Thrust_Force/(.Body.Mass+.Fuel)
      For k = 1 to 2
        For a = Rnd*Ubound(.Burst) to Ubound(.Burst)
          If .Burst(a).Life_State = 0 Then
            .Burst(a).Body.Vel.X = .Body.vel.X-(.Burst(a).Spawn_Speed*.Sin_Ang+Rnd*0.3-Rnd*0.3)
            .Burst(a).Body.Vel.Y = .Body.Vel.Y+(.Burst(a).Spawn_Speed*.Cos_Ang+Rnd*0.3-Rnd*0.3)
            .Burst(a).Body.wrld_Pos.X = .Body.wrld_Pos.X+.Body_Point(3).Wrld_Dot.X
            .Burst(a).Body.wrld_Pos.Y = .Body.wrld_Pos.Y+.Body_Point(3).Wrld_Dot.Y
            .Burst(a).Life_TimeLeft = .Burst(a).Life_Time
            .Burst(a).Life_State = 1
            Exit For
          End If
        Next
      Next
    Else 
      .Fuel = 0
    End If
  End With
End Sub

Sub Draw_Burst()
  With Ship(Active)
    For b = Lbound(.burst) to Ubound(.burst)
      With .Burst(b)
        If .Life_State = 1 Then
          If .Life_TimeLeft >= 1 Then
            .Life_TimeLeft -= 1
            Col = .Life_TimeLeft/.Life_Time
'            With .Body
'              .Col.R *= col
'              .Col.G *= col
'              .Col.B *= col
'            End With
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
    
    Dim as Single SinAngle, CosAngle, Theta, DeltaTheta, X, Y, rX, rY
    Dim As Ubyte R, G, B
    
    SinAngle = Sin(-Angle) 
    CosAngle = Cos(Angle)
    Theta = 0
    DeltaTheta = Twopi/num_lines
    
    glLoadIdentity()
    glTranslatef cX, Cy, -10
    glRotatef scrn_angle, 0, 0, 1
    glscalef zoom, zoom, 0
    GlColor3ub 32, 64, 16
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

''  define function that calculates rectangular coordinates from polar coordinates
Function Rec (Byref Rpol as Single, Byref Tpol as Single) As Integer
  Xrec = Cos(Tpol)*Rpol
  Yrec = Sin(Tpol)*Rpol
  Return Xrec
  Return Yrec
End Function 

''  define function that calculates polar coordinates from rectangular coordinates
Function Pol (byref Xrec as Single, byref Yrec as Single) As Integer
  Rpol = Sqr(Xrec^2+Yrec^2) 
  Tpol = Atn(Yrec/Xrec)
  If Xrec < 0 Then
    If Yrec > 0 then 
      Tpol += pi
    Else 
      Tpol -= pi
    End If
  End If
  Return Rpol
  Return Tpol
End Function

''  This function finds the intersection point of two line segments 
''  each defined by two (x, y) points. 
''  It returns 0 if the line segments does not cross and -1 if they do.
Function SegmentsIntersect _
  (ByVal a1 As Pos_3D, ByVal a2 As Pos_3D, _
  ByVal b1 As Pos_3D, ByVal b2 As Pos_3D) As Integer
    
  Dim As Single ax, ay, bx, by, t, s, denom
    
  ax = a2.x - a1.x
  ay = a2.y - a1.y
  bx = b2.x - b1.x
  by = b2.y - b1.y
  denom = (bx * ay - by * ax)
  
  If denom = 0 Then
    
    Return 0
    
  Else
    
    s = (ax*(b1.y-a1.y) + ay*(a1.x-b1.x)) / denom
    t = (bx*(a1.y-b1.y) + by*(b1.x-a1.x)) / -denom
    Return (s >= 0 And s <= 1 And t >= 0 And t <= 1)
    
  End If

End Function

'Function SegmentsIntersect _
'  (ByVal X1 As Single, ByVal Y1 As Single, _
'   ByVal X2 As Single, ByVal Y2 As Single, _
'   ByVal X3 As Single, ByVal Y3 As Single, _
'   ByVal X4 As Single, ByVal Y4 As Single) As Integer
'  
'  Dim As Single ax, ay, bx, by, t, s, denom
'  
'  ax = X2 - X1  :   ay = Y2 - Y1
'  bx = X4 - X3  :   by = Y4 - Y3
'  denom = (bx * ay - by * ax)
'  s = (ax*(Y3-Y1) + ay*(X1-X3)) / denom
'  t = (bx*(Y1-Y3) + by*(X3-X1)) / -denom
'  SegmentsIntersect = (s >= 0 And s <= 1 And t >= 0 And t <= 1)
'End Function

With Controls
  .Lft = 75
  .Rgt = 77
  .fwd = 72
  .dwn = 80
  .esc = 1
End With

Randomize timer

With Asteroid(1)
  .Life_State = 1
  .wid = 256
  .hgt = 230
  .Num_Points = (Pi*(3*(.wid+.hgt)-Sqr((3*.wid+.hgt)*(.wid+3*.hgt))))/24
  .Angle = Rnd*360
  .Sin_Ang = Sin(.Angle*Deg2Rad)
  .Cos_Ang = Cos(.Angle*Deg2Rad)
  With .Body
    .wrld_pos.X = 0
    .wrld_pos.Y = 0
    .Scrn_Pos.Z = 1
    .Mass = 1200
  End With
  With .Body_Point(0)
    .stat_dot.X = 1
    .stat_dot.y = 1
    .stat_dot.z = 10
    .col.R = 144: .col.G = 144: .col.B = 160
  End With
  .Turn_Rate = (Rnd*0.1)-(Rnd*0.1)
  For b = Lbound(.Body_Point)+1 to .Num_Points
    Angle = TwoPi*((.Num_Points+1-b)/.Num_Points)
    Col = Rnd*16
    X = (.wid-Col)*Cos(Angle)
    Y = (.hgt-Col)*Sin(Angle)
    With .Body_Point(b)
      .stat_dot.X = X * Asteroid(1).Cos_Ang + Y * Asteroid(1).Sin_Ang
      .stat_dot.y = -X * Asteroid(1).Sin_Ang + Y * Asteroid(1).Cos_Ang
      .stat_dot.z = -10
      Col = 96 + (Rnd*2) - (Rnd*2)
      .col.R = Col: .col.G = Col: .col.B = Col+8
    End With
  Next
End With

With Asteroid(2)
  .Life_State = 1
  .wid = 56
  .hgt = 48
  .Num_Points = (Pi*(3*(.wid+.hgt)-Sqr((3*.wid+.hgt)*(.wid+3*.hgt))))/24
  .Spawn_Angle = Rnd*twopi
  .Spawn_Distance = Asteroid(1).wid + 200
  .Num_Points = 12
  With .Body
    .wrld_Pos.X = Asteroid(1).Body.wrld_Pos.X+Asteroid(2).Spawn_Distance*Sin(Asteroid(2).Spawn_Angle) 
    .wrld_Pos.Y = Asteroid(1).Body.wrld_Pos.Y+Asteroid(2).Spawn_Distance*Cos(Asteroid(2).Spawn_Angle) 
    .Vel.X = sqr(Asteroid(1).Body.Mass/Asteroid(2).Spawn_Distance)*Cos(Asteroid(2).Spawn_Angle)
    .Vel.Y = sqr(Asteroid(1).Body.Mass/Asteroid(2).Spawn_Distance)*Sin(-Asteroid(2).Spawn_Angle)
    .Scrn_Pos.Z = 1
    .Mass = 120
  End With
  With .Body_Point(0)
    .stat_dot.X = 0
    .stat_dot.y = 0
    .col.R = 128: .col.G = 104: .col.B = 96
  End With
  .Angle = Rnd*360
  .Sin_Ang = Sin(.Angle*Deg2Rad)
  .Cos_Ang = Cos(.Angle*Deg2Rad)
  .Turn_Rate = -0.1
  For b = Lbound(.Body_Point)+1 to .Num_Points
    Angle = TwoPi*((.Num_Points+1-b)/.Num_Points)
    Col = Rnd*12
    X = (.wid-Col)*Cos(Angle)
    Y = (.hgt-Col)*Sin(Angle)
    With .Body_Point(b)
      .stat_dot.X = X * Asteroid(2).Cos_Ang + Y * Asteroid(2).Sin_Ang
      .stat_dot.y = -X * Asteroid(2).Sin_Ang + Y * Asteroid(2).Cos_Ang
      Col = 64 + (Rnd*2) - (Rnd*2)
      .col.R = Col+32: .col.G = Col+8: .col.B = Col
    End With
  Next
End With

With Asteroid(3)
  .Life_State = 1
  .wid = 64
  .hgt = 32
  .Num_Points = (Pi*(3*(.wid+.hgt)-Sqr((3*.wid+.hgt)*(.wid+3*.hgt))))/24
  .Spawn_Angle =  Asteroid(2).Spawn_Angle + pi
  .Spawn_Distance = Asteroid(1).wid + 300
  .Num_Points = 12
  With .Body
    .wrld_Pos.X = Asteroid(1).Body.wrld_Pos.X+Asteroid(3).Spawn_Distance*Sin(Asteroid(3).Spawn_Angle) 
    .wrld_Pos.Y = Asteroid(1).Body.wrld_Pos.Y+Asteroid(3).Spawn_Distance*Cos(Asteroid(3).Spawn_Angle) 
    .Vel.X = sqr(Asteroid(1).Body.Mass/Asteroid(3).Spawn_Distance)*Cos(Asteroid(3).Spawn_Angle)
    .Vel.Y = sqr(Asteroid(1).Body.Mass/Asteroid(3).Spawn_Distance)*Sin(-Asteroid(3).Spawn_Angle)
    .Scrn_Pos.Z = 1
    .Mass = 120
  End With
  With .Body_Point(0)
    .stat_dot.X = 0
    .stat_dot.y = 0
    .col.R = 96: .col.G = 80: .col.B = 72
  End With
  .Angle = Rnd*360
  .Sin_Ang = Sin(.Angle*Deg2Rad)
  .Cos_Ang = Cos(.Angle*Deg2Rad)
  .Turn_Rate = 1
  For b = Lbound(.Body_Point)+1 to .Num_Points
    Angle = TwoPi*((.Num_Points+1-b)/.Num_Points)
    Col = Rnd*12
    X = (.wid-Col)*Cos(Angle)
    Y = (.hgt-Col)*Sin(Angle)
    With .Body_Point(b)
      .stat_dot.X = X * Asteroid(3).Cos_Ang + Y * Asteroid(3).Sin_Ang
      .stat_dot.y = -X * Asteroid(3).Sin_Ang + Y * Asteroid(3).Cos_Ang
      Col = 64 + (Rnd*2) - (Rnd*2)
      .col.R = Col+24: .col.G = Col: .col.B = Col
    End With
  Next
End With

With Ship(1)
  .Life_State = 1
  .Spawn_Angle = Rnd*twopi
  .Spawn_Distance = Asteroid(1).wid + 100
  With .Body
    .wrld_Pos.X = Asteroid(1).Body.wrld_Pos.X+Ship(1).Spawn_Distance*Sin(Ship(1).Spawn_Angle) 
    .wrld_Pos.Y = Asteroid(1).Body.wrld_Pos.Y+Ship(1).Spawn_Distance*Cos(Ship(1).Spawn_Angle) 
    .Vel.X = -sqr(Asteroid(1).Body.Mass/Ship(1).Spawn_Distance)*Cos(Ship(1).Spawn_Angle)
    .Vel.Y = -sqr(Asteroid(1).Body.Mass/Ship(1).Spawn_Distance)*Sin(-Ship(1).Spawn_Angle)
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
  .Radius = 16
  .Turn_Rate = 6
  .Thrust_Force = 1.5
  .Explosion_state = 0
  For b = Lbound(.Burst) to Ubound(.Burst)
    With .Burst(b)
      .Spawn_Speed = 1+Rnd*2
      .Life_State = 0
      .Life_Time = 4+Rnd*20
      With .Body
        .Col.R = 255
        .Col.G = 255
        .Col.B = 255
      End With
    End With
  Next
  For b = Lbound(.Particle) to Ubound(.Particle)
    With .Particle(b)
      .Spawn_Angle = Rnd*twopi
      .Spawn_Speed = 3-(Rnd*(3^(1/3)))^3
      .Life_State = 0
      .Life_Time = 12+Rnd*24
      .Body.Wrld_pos.x = Rnd*4-Rnd*4
      .Body.Wrld_pos.y = Rnd*4-Rnd*4
      .Body.Vel.X = .Spawn_Speed * Cos(.Spawn_Angle)
      .Body.Vel.Y = .Spawn_Speed * Sin(.Spawn_Angle)
      .Body.Col.R = 255
      .Body.Col.G = 255
      .Body.Col.B = 255
    End With
  Next
End With

Update_Asteroid_Angle(Asteroid(1))
Update_Asteroid_Angle(Asteroid(2))
Update_Asteroid_Angle(Asteroid(3))

With Landing_Site
  .Host_Astr = 1
  .Host_Point = Int(Rnd*Asteroid(.Host_Astr).Num_Points)+1
  With .Body_Point(1)
    .stat_dot.X = -24: .stat_dot.y = -24
    .col.R = 244:.col.G = 244:.col.B = 244
  End With
  With .Body_Point(2)
    .stat_dot.X = -64: .stat_dot.y = 64
    .col.R = 64:.col.G = 64:.col.B = 64
  End With
  With .Body_Point(3)
    .stat_dot.X = 64: .stat_dot.y = 64
    .col.R = 32:.col.G = 32:.col.B = 32
  End With
  With .Body_Point(4)
    .stat_dot.X = 24: .stat_dot.y = -24
    .col.R = 192:.col.G = 192:.col.B = 192
  End With
  With Asteroid(.Host_Astr)
    Dist.X = .Body.Wrld_Pos.X-.Body_Point(Landing_Site.Host_Point).Wrld_Dot.X
    Dist.Y = .Body.Wrld_Pos.Y-.Body_Point(Landing_Site.Host_Point).Wrld_Dot.Y
    Pol (Dist.X, Dist.Y)
  End With
  .Angle = (Tpol-halfpi)*Rad2Deg
  .Turn_Rate = Asteroid(.Host_Astr).Turn_Rate
End With

Sub Draw_Trajectory (Byref Body as Body)
  
  Dim As Ushort Host
  Dim as Single Dstnc, Dstnc_Old, Rel_Speed, Theta, Areal_Velocity, _
  Semimajor_Axis, Semiminor_Axis, Orbital_Period, Eccentricity, Foci_Dstnc, _
  True_Anomaly, Mass, reference_angle, reference_angle_old, orbit_angle
  
  Host = 1
  Mass = Asteroid(Host).Body.Mass
  Dist.X = Asteroid(Host).Body.Wrld_Pos_Old.X - Body.Wrld_Pos_Old.X
  Dist.Y = Asteroid(Host).Body.Wrld_Pos_Old.Y - Body.Wrld_Pos_Old.Y
  Dstnc_Old = Sqr(Dist.X^2+Dist.Y^2)
  Find_Dist (Body, Asteroid(Host).Body)
  Dstnc = Distance
  Rel_Speed = Sqr((Asteroid(Host).Body.Vel.X-Body.Vel.X)^2 + _
                  (Asteroid(Host).Body.Vel.Y-Body.Vel.Y)^2)
  Theta = Halfpi-Acos((Rel_Speed^2+Dstnc^2-.Dstnc_Old^2)/(2*Rel_Speed*Dstnc))
  Areal_Velocity = (cos(Theta)*Rel_Speed*Dstnc)/2
  semimajor_Axis = -1/((Rel_Speed^2/Mass)-(2/Dstnc))
  Orbital_Period = TwoPi*Sqr(Semimajor_axis^3/Mass)
  Eccentricity = Sqr(1-((Areal_velocity*Orbital_period)/(pi*Semimajor_axis^2))^2)
  Semiminor_axis = Semimajor_axis*sqr(1-(Eccentricity^2))
  Foci_Dstnc = Eccentricity*Semimajor_axis
  True_Anomaly = Acos((((semimajor_axis*(1-Eccentricity^2))/.Dstnc)-1)/Eccentricity)
  Dist.X = Asteroid(Host).Body.wrld_pos.X-Body.wrld_pos.X
  Dist.Y = Asteroid(Host).Body.wrld_pos.Y-Body.wrld_pos.Y
  Pol(Dist.X, Dist.Y)
  reference_angle_old = reference_Angle
  Reference_Angle = Tpol
  
  Draw_Ellipse(Asteroid(Host).Body.Scrn_Pos.X + Foci_Dstnc*Cos(Orbit_Angle), _
               Asteroid(Host).Body.Scrn_Pos.Y + Foci_Dstnc*Sin(Orbit_Angle), _
               Semimajor_Axis, Semiminor_Axis, Orbit_Angle, 0, 256)
  
End Sub

Function GL_Load_Bmp(Byref bmp As String) as Uinteger
  
  ''  This function creates an OpenGL texture from a bitmap image. 
  ''  it returns the OpenGL handle number on success and 0 on failure.
  
  Dim as Uinteger handle, bmih_wid, bmih_hgt, w, h, x, y, col, hdr, lin, f = FreeFile
  dim as uinteger ptr buffer
  
  ''  test 1: does file exist, and can we open it?
  If Open (bmp For Input Access Read As #f) <> 0 Then return 0

  ''  get image width and height from info header
  Get #f, 19, bmih_wid   
  Get #f, 23, bmih_hgt
  Close #f
  
  ''  test 2: is the image quadratic?
  if bmih_wid <> bmih_hgt Then return 0
  
  '' test 3: are width and height powers of 2
  if ((bmih_wid and (bmih_wid-1)) or (bmih_hgt and (bmih_hgt-1))) then return 0

  ''  Ok then, create image buffer and load image
  buffer = imagecreate(bmih_wid, bmih_hgt)
  Bload bmp, buffer
 
  ''  check if header is old or new style
  ''  Get width and height, set correct header size
  If buffer[0] = 7 Then
    w = buffer[2]
    h = buffer[3]
    hdr = 8
  Else
    w = (buffer[0] And &hfff8) Shr 3
    h = (buffer[0] Shr 16)
    hdr = 1
  End If
  
  ''  iterate through all pixels in order to:
  ''    -swap R and B channels so we can use the GL_RGBA texture format
  ''    -offset pixels a bit to the left to get rid of the header
  For y = 0 To h-1
    lin = y*w
    For x = 0 To w-1
      col = buffer[hdr+x+lin]
      col = RGB(col and &hFF, (col shr 8) and &hFF, (col shr 16) and &hFF)
      buffer[x+lin] = col
    Next
  Next
  
  ''  generate OpenGL texture and bind it to texture handle
  glGenTextures 1, @handle
  glBindTexture GL_TEXTURE_2D, handle
  glTexImage2D GL_TEXTURE_2D, 0, GL_RGBA, w, h, 0, GL_RGBA, GL_UNSIGNED_BYTE, Buffer
  
  ''  generate mipmaps and set a few texture parameters
  gluBuild2DMipmaps GL_TEXTURE_2D, GL_RGBA, w, h, GL_RGBA, GL_UNSIGNED_BYTE, Buffer
  glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR
  glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR_MIPMAP_LINEAR
  
  ImageDestroy Buffer
  return handle

End Function




