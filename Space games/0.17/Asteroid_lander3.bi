' Content:
'   types
'   declarations
'   constants and variables
'   subs
'   functions
'   data


'******************************************************************************
'
'   Types
'
'******************************************************************************


Type Controls
  As Ubyte lft, rgt, fwd, dwn, esc
End Type

Type Pos_2D
  As Single X, Y
End Type

Type Vertex
  As Ubyte R, G, B, A
  As Pos_2D Stat, wrld
End Type 

Type Segment
  As Ubyte R, G, B, A
  As Integer Num_Vertices
  As Single Start_Ang, End_Ang 
  As Vertex ptr Vertex_Ptr
End Type

Type Body
  As Ubyte R, G, B, A
  As Integer Num_Segments
  As Single Mass, radius, density, volume, Angle, Sin_Angle, Cos_Angle, Turn_Rate
  As Segment Ptr Segment_Ptr
  As Pos_2D wrld_pos, wrld_Vel, Scrn_Pos
End Type

Type Particle
  As Body Body
  As Single speed, angle
  As Ubyte Life_State
  As Ushort Life_Time, Life_TimeLeft
End Type

Type Planet
  As Body Body
  As Particle Ptr Debris_Ptr
  As Ubyte Life_State
End Type

Type Ship
  As Body Body
  As Particle Ptr Burst_Ptr, Debris_Ptr
  As Integer Num_Burst, Num_Debris
  As Ubyte Life_State, Explosion_state
  As Single Spawn_Angle, Spawn_Distance, fuel, Thrust_Force
End Type

Type Scrn
  As Integer wid, hgt, bpp, rate, full, X_Mid, Y_Mid, Scroll_Factor
  As Single Angle, Sin_Angle, Cos_Angle, Rotation_Factor, Scale_Factor, _
    Scale, Scale_Min, Scale_Max
End Type


'******************************************************************************
'
'   Declarations
'
'******************************************************************************


Declare Sub Init_Planet(Byref Num As Integer, Byref Pos_X As Integer, _
  Byref Pos_Y As Integer, Byref Angle As Integer = 0, Byref Radius As Integer, _
  Byref Crust_thickness As Integer, Byref Num_Vertices As Integer)
  
Declare Sub Init_Ship(Byref Num As Integer, Byref Host As Integer, _
  Byref Spawn_Angle As Single, Byref Spawn_Distance As Single)
  
Declare Sub Init_OpenGl(Byref Scrn_Wid As Integer = 0, _
  Byref Scrn_Hgt As Integer = 0, Byref Scrn_Bpp As Integer = 0, _
  Byref Scrn_Full As Integer = 0)

Declare Sub Find_Dist(Byref Body_1 as Body, Byref Body_2 as Body)

Declare Sub G_Force_1way(Byref Body_1 as Body, Byref Body_2 as Body)

Declare Sub G_Force_2way(Byref Body_1 as Body, Byref Body_2 as Body)

Declare Sub Apply_Gravity()

Declare Sub Burst()

Declare Sub Clear_Screen()

Declare Sub Flip_Buffers()

Declare Sub Free_Memory()


Declare Function Vector_Add (byref v1 As Pos_2D, byref v2 As Pos_2D) As Pos_2D

Declare Function SegmentsIntersect (ByVal a1 As Pos_2D, ByVal a2 As Pos_2D, _
  ByVal b1 As Pos_2D, ByVal b2 As Pos_2D) As Pos_2D


'******************************************************************************
'
'   Constants and variables
'
'******************************************************************************


Const As Single _
  Pi = 4*Atn(1), TwoPi = Pi*2, HalfPi = Pi/2, four_third_pi = Pi*(4/3), _
  rad2deg = 360/TwoPi, deg2rad = TwoPi/360, Phi = (Sqr(5)-1)/2
  
Dim Shared As Single _
  Distance, Dist_Squared, Dist_Cubed, view_factor
  
Dim Shared As Pos_2D _
  Dist
  
Dim Shared As Planet Planet(0)

Dim Shared As Ship Ship(0)
  
Dim Shared As Scrn Scrn

Dim Shared As Controls Controls
  

'******************************************************************************
'
'   Subs
'
'******************************************************************************


Sub Init_Planet(Byref Num As Integer, Byref Pos_X As Integer, _
  Byref Pos_Y As Integer, Byref Angle As Integer = 0, Byref Radius As Integer, _
  Byref Crust_thickness As Integer, Byref Num_Vertices As Integer)
  
  Dim as Integer i, i2
  Dim As Single X, Y, Ang
  
  With Planet(Num)
    With .Body
      .Angle = Angle
      .Turn_Rate = 0.03
      .Sin_Angle = Sin(.Angle*Deg2Rad)
      .Cos_Angle = Cos(.Angle*Deg2Rad)
      .Wrld_Pos.X = Pos_X
      .Wrld_Pos.Y = Pos_Y
      .Mass = 10000
      .Radius = Radius
      .Num_Segments = 3
      .Segment_Ptr = Allocate(.Num_Segments*Sizeof(Segment))
      .Segment_Ptr[0].Start_Ang = 0
      .Segment_Ptr[0].End_Ang = 2
      .Segment_Ptr[0].Num_Vertices = 32
      .Segment_Ptr[1].Start_Ang = 2.2
      .Segment_Ptr[1].End_Ang = 2.7
      .Segment_Ptr[1].Num_Vertices = 16
      .Segment_Ptr[2].Start_Ang = 2.9
      .Segment_Ptr[2].End_Ang = 6
      .Segment_Ptr[2].Num_Vertices = 48
      For i = 0 To .Num_Segments-1
        With .Segment_Ptr[i]
          .Vertex_Ptr = Allocate(.Num_Vertices*Sizeof(Vertex))
          For i2 = 0 to .Num_Vertices-2 Step 2
            Ang = .Start_Ang+((.End_Ang-.Start_Ang)*(((.Num_Vertices-2)-(i2))/(.Num_Vertices-2)))
            X = Planet(Num).Body.Radius*Cos(Ang)
            Y = Planet(Num).Body.Radius*Sin(Ang)
            With .Vertex_Ptr[i2]
              .Stat.X = X
              .Stat.Y = Y
              .R = 191
              .G = .R
              .B = .R
            End With
            X = (Planet(Num).Body.Radius-Crust_Thickness)*Cos(Ang)
            Y = (Planet(Num).Body.Radius-Crust_Thickness)*Sin(Ang)
            With .Vertex_Ptr[i2+1]
              .Stat.X = X
              .Stat.Y = Y
              .R = 191
              .G = .R
              .B = .R
            End With
          Next i2
        End With
      Next i
    End With
  End With
End Sub

Sub Init_Ship(Byref Num As Integer, Byref Host As Integer, _
  Byref Spawn_Angle As Single, Byref Spawn_Distance As Single)
  
  Dim as Integer i, i2
  
  Spawn_Distance += Planet(Host).Body.Radius
  
  With Ship(Num)
    .Life_State = 1
    With .Body
      .Turn_Rate = 6
      .wrld_Pos.X = Planet(Host).Body.wrld_Pos.X+Spawn_Distance*Sin(Spawn_Angle) 
      .wrld_Pos.Y = Planet(Host).Body.wrld_Pos.Y+Spawn_Distance*Cos(Spawn_Angle) 
      .wrld_Vel.X = sqr(Planet(Host).Body.Mass/Spawn_Distance)*Cos(Spawn_Angle)
      .wrld_Vel.Y = sqr(Planet(Host).Body.Mass/Spawn_Distance)*Sin(-Spawn_Angle)
      .Mass = 10
      .Num_Segments = 1
      .Segment_Ptr = Allocate(.Num_Segments*Sizeof(Segment))
      With .Segment_Ptr[0]
        .Num_Vertices = 4
        .Vertex_Ptr = Allocate(.Num_Vertices*Sizeof(Vertex))
        With .Vertex_Ptr[0]
          .stat.X = 0
          .stat.y = -14
          .R = 244
          .G = 244
          .B = 244
        End With
        With .Vertex_Ptr[1]
          .stat.X = -10
          .stat.y = 8
          .R = 192
          .G = 192
          .B = 192
        End With
        With .Vertex_Ptr[2]
          .stat.X = 0
          .stat.y = 6
          .R = 128
          .G = 128
          .B = 128
        End With
        With .Vertex_Ptr[3]
          .stat.X = 10
          .stat.y = 8
          .R = 192
          .G = 192
          .B = 192
        End With
      End With
    End With
    .Fuel = 20
    .Thrust_Force = 2
    .Num_Burst = 60
    .Burst_Ptr = Allocate(.Num_Burst*Sizeof(Particle))
    For i = 0 To .Num_Burst-1
      With .Burst_Ptr[i]
        .Speed = 1+Rnd*2
        .Life_State = 0
        .Life_Time = 4+Rnd*20
        With .Body
          .R = 255
          .G = 255
          .B = 255
        End With
      End With
    Next
    .Explosion_state = 0
    .Num_Debris = 60
    .Debris_Ptr = Allocate(.Num_Debris*Sizeof(Particle))
    For i = 0 to .Num_Debris-1
      With .Debris_Ptr[i]
        .Angle = Rnd*twopi
        .Speed = 3-(Rnd*(3^(1/3)))^3
        .Life_State = 0
        .Life_Time = 12+Rnd*24
        .Body.Wrld_pos.x = Rnd*4-Rnd*4
        .Body.Wrld_pos.y = Rnd*4-Rnd*4
        .Body.Wrld_Vel.X = .Speed * Cos(.Angle)
        .Body.Wrld_Vel.Y = .Speed * Sin(.Angle)
        .Body.R = 255
        .Body.G = 255
        .Body.B = 255
      End With
    Next
  End With
  
End Sub

Sub Init_OpenGl(Byref Scrn_Wid As Integer = 0, Byref Scrn_Hgt As Integer = 0, _
  Byref Scrn_Bpp As Integer = 0, Byref Scrn_Full As Integer = 0)
  
  ''  define screen settings
  Scrn.Full = Scrn_Full
  If Scrn_Wid = 0 Or Scrn_Hgt = 0 Then
    ScreenInfo Scrn.Wid, Scrn.Hgt
    Scrn.Full = 1
  End If
  If Scrn_Bpp = 0 Then
    ScreenInfo ,, Scrn.Bpp
  End If
  ScreenRes Scrn.Wid, Scrn.Hgt, Scrn.Bpp,, 2 Or Scrn.Full
  If Scrn.Full = 1 Then
    SetMouse ,, 0
  End If
  Scrn.X_Mid = Scrn.Wid\2
  Scrn.Y_Mid = Scrn.Hgt\2
  
  ''  define ogl settings
  glMatrixMode(GL_PROJECTION)      
  glLoadIdentity()
  glViewport (0, 0, Scrn.Wid, Scrn.Hgt)
  glOrtho(0, Scrn.Wid, Scrn.Hgt, 0, -128, 128)
  glMatrixMode(GL_MODELVIEW)
  glLoadIdentity()
  glShadeModel(GL_SMOOTH)
  glClearColor(0.0, 0.0, 0.0, 0.0)
  glEnable(GL_CULL_FACE)
  glCullFace(GL_BACK)
  glClearDepth(128.0)
  glEnable(GL_DEPTH_TEST)          
  glDepthFunc(GL_LESS)
  glEnable(GL_ALPHA_TEST)          
  glAlphaFunc(GL_GREATER, 0.1)
  glEnable(GL_BLEND)               
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
End Sub

Sub Find_Dist(Byref Body_1 as Body, Byref Body_2 as Body)
  Dist.X = Body_1.Wrld_Pos.X-Body_2.Wrld_Pos.X
  Dist.Y = Body_1.Wrld_Pos.Y-Body_2.Wrld_Pos.Y
  Dist_Squared = Dist.X*Dist.X + Dist.Y*Dist.Y
  Distance = Sqr(Dist_Squared)
  Dist_Cubed = Distance * Dist_Squared
End Sub

Sub G_Force_1way(Byref Body_1 as Body, Byref Body_2 as Body)
  If Distance > Body_1.Radius Then
    Body_2.Wrld_Vel.X += Body_1.Mass*Dist.X/Dist_Cubed
    Body_2.Wrld_Vel.Y += Body_1.Mass*Dist.Y/Dist_Cubed
  Else
    Body_2.Wrld_Vel.X += four_third_pi*Dist.X*Body_1.Density
    Body_2.Wrld_Vel.Y += four_third_pi*Dist.Y*Body_1.Density
  End If
End Sub

Sub G_Force_2way(Byref Body_1 as Body, Byref Body_2 as Body)
  Body_2.Wrld_Vel.X += Body_1.Mass*Dist.X/Dist_Cubed
  Body_2.Wrld_Vel.Y += Body_1.Mass*Dist.Y/Dist_Cubed
  Body_1.Wrld_Vel.X -= Body_2.Mass*Dist.X/Dist_Cubed
  Body_1.Wrld_Vel.Y -= Body_2.Mass*Dist.Y/Dist_Cubed
End Sub

Sub Apply_Gravity()
  Dim As Integer i, i2
  For i = Lbound(Planet) To Ubound(Planet)
    For i2 = i+1 To Ubound(Planet)
      Find_Dist(Planet(i).Body, Planet(i2).Body)
      G_Force_2way(Planet(i).Body, Planet(i2).Body)
    Next
    For i2 = 0 To Ubound(Ship)
      Find_Dist(Planet(i).Body, Ship(i2).Body)
      G_Force_1way(Planet(i).Body, Ship(i2).Body)
    Next
  Next
End Sub

Sub Burst()
  With Ship(0)
    If .Fuel >= 0.01 then
      .Fuel -= 0.01
      .Body.wrld_Vel.X += .Body.Sin_Angle*.Thrust_Force/(.Body.Mass+.Fuel)
      .Body.wrld_Vel.Y -= .Body.Cos_Angle*.Thrust_Force/(.Body.Mass+.Fuel)
    Else 
      .Fuel = 0
    End If
  End With
End Sub

Sub Update_Angle(Byref Body As Body)
  Dim as Integer i, i2
  With Body
    .Cos_Angle = Cos(.Angle*deg2rad)
    .Sin_Angle = Sin(.Angle*deg2rad)
    For i = 0 To .Num_Segments-1
      With .Segment_Ptr[i]
        For i2 = 0 to .Num_Vertices-1
          With .Vertex_Ptr[i2]
            .Wrld.X = (Body.Cos_Angle*.stat.X)-(Body.Sin_Angle*.stat.Y)
            .Wrld.Y = (Body.Cos_Angle*.stat.Y)+(Body.Sin_Angle*.stat.X)
          End With
        Next i2
      End With
    Next i
  End With
End Sub

Sub Update_Pos(Byref Body As Body)
  Dim As Single Scrn_X, Scrn_Y
  With Body
    .Wrld_Pos.X += .wrld_Vel.X
    .Wrld_Pos.Y += .wrld_Vel.Y
    Scrn_X = .Wrld_Pos.X-ship(0).Body.Wrld_Pos.X*view_factor
    Scrn_Y = .Wrld_Pos.Y-ship(0).Body.Wrld_Pos.Y*view_factor
    .Scrn_Pos.X = Scrn.X_Mid+((Scrn.Cos_Angle*Scrn_X)-(Scrn.Sin_Angle*Scrn_Y))*Scrn.Scale
    .Scrn_Pos.Y = Scrn.Y_Mid+((Scrn.Cos_Angle*Scrn_Y)+(Scrn.Sin_Angle*Scrn_X))*Scrn.Scale
  End With
End Sub

Sub Collision_Detection()
'  
'  Dim As Integer i, i2, i3, i4, i5, PV(1), SV(1)
'  Dim As Pos_2D Null_2D => (0, 0)
'  
'  For i = 0 to Ubound(Planet)
'      
'    Find_Dist(Planet(i).Body, Ship(0).Body)
'    
'    If Distance <= Planet(i).Body.Radius + Ship(0).Body.Radius Then
'      For i2 = 0 To Planet(i).Body.Num_Segments-1
'        With Planet(i).Body.Segment_Ptr[i2]
'          For i3 = 0 To .Num_Vertices-1
'            PV(0) = Vector_Add(Planet(i).Body.wrld_pos, .Vertex_Ptr[i3].wrld)
'            PV(1) = Vector_Add(Planet(i).Body.wrld_pos, .Vertex_Ptr[i4].wrld)
'          Next
'        End With
'        For n = Lbound(Ship(Active).Body_Point) To Ubound(Ship(Active).Body_Point)
'          With Ship(Active)
'            m = n+1: If m > Ubound(Ship(Active).Body_Point) Then m = 1
'            Sh_1 = Vector_Add(.body.wrld_pos, .body_point(n).wrld_dot)
'            Sh_2 = Vector_Add(.body.wrld_pos, .body_point(m).wrld_dot)
'          End With
'          If SegmentsIntersect (PV(0), PV(2), Sh_1, Sh_2) <> Null_2D Then
'            With Ship(Active)
'              .Life_State = 0
'            End With 
'          End If
'        Next
'      Next
'    End If
'  Next
End Sub

Sub Update_Scrn_Angle()
  Scrn.Cos_Angle = Cos(Scrn.Angle*deg2rad)
  Scrn.Sin_Angle = Sin(Scrn.Angle*deg2rad)
End Sub

Sub Draw_Planet(Byref Num As Integer)
  Dim As Integer i, i2
  With Planet(Num).Body
    GlLoadIdentity()
    GlTranslatef .Scrn_Pos.X, .Scrn_Pos.Y, 0
    GLScalef Scrn.Scale, Scrn.Scale, 0
    GLRotatef Scrn.Angle, 0, 0, 1
    For i = 0 To .Num_Segments-1
      glbegin Gl_Triangle_Strip
      'Glbegin Gl_Quad_Strip
        With .Segment_ptr[i]
          For i2 = 0 to .Num_Vertices-2 Step 2
            With .Vertex_Ptr[i2+1]
              glcolor3ub .R, .G, .B
              glvertex2f .Wrld.X, .Wrld.Y
            End With
            With .Vertex_Ptr[i2]
              glcolor3ub .R, .G, .B
              glvertex2f .Wrld.X, .Wrld.Y
            End With
          Next i2
        End With
      Glend
    Next i
  End With
End Sub

Sub Draw_Ship(Byref Num As Integer)
  Dim As Integer i
  With Ship(Num).Body
    GlLoadIdentity()
    GlTranslatef .Scrn_Pos.X, .Scrn_Pos.Y, 0
    GLScalef Scrn.Scale, Scrn.Scale, 0
    GLRotatef Scrn.Angle, 0, 0, 1
    glbegin Gl_Polygon
      With .Segment_ptr[0]
        For i = 0 to .Num_Vertices-1
          With .Vertex_Ptr[i]
            glcolor3ub .R, .G, .B
            glvertex2f .Wrld.X, .Wrld.Y
          End With
        Next i
      End With
    Glend
  End With
End Sub

Sub Read_Keyboard()
  
    ''  rotate screen image
  If Multikey(&h1e) Then
    Scrn.Angle -= scrn.Rotation_factor
    Update_Scrn_Angle()
  End If
  If Multikey(&h20) Then
    Scrn.Angle += scrn.Rotation_factor
    Update_Scrn_Angle()
  End If
  
  ''  zoom screen image
  If Multikey(&h1f) Then
    Scrn.Scale *= Scrn.Scale_Factor
    If Scrn.Scale < Scrn.Scale_Min Then Scrn.Scale = Scrn.Scale_Min
  End If
  If Multikey(&h11) Then
    Scrn.Scale /= Scrn.Scale_Factor
    If Scrn.Scale > Scrn.Scale_Max Then Scrn.Scale = Scrn.Scale_Max
  End If
  
  With Ship(0)
    'If .Life_State = 1 Then
      If multikey(Controls.Lft) then 
        .Body.Angle -= .Body.Turn_Rate
        Update_Angle(.Body)
      End If
      If multikey(Controls.Rgt) then 
        .Body.Angle += .Body.Turn_Rate
        Update_Angle(.Body)
      End If
      If multikey(Controls.Fwd) then 
        Burst()
      End If
      If multikey(Controls.Dwn) then 
      End If
    'End If
  End With
  
'  ''  scroll screen image
'  If multikey(75) then 
'    Scrn.X_Mid += Scrn.Scroll_Factor
'  End If
'  If multikey(77) then 
'    Scrn.X_Mid -= Scrn.Scroll_Factor
'  End If
'  If multikey(72) then 
'    Scrn.Y_Mid += Scrn.Scroll_Factor
'  End If
'  If multikey(80) then 
'    Scrn.Y_Mid -= Scrn.Scroll_Factor
'  End If
  
End Sub

Sub Clear_Screen()
  glClear GL_COLOR_BUFFER_BIT Or GL_DEPTH_BUFFER_BIT
End Sub

Sub Flip_Buffers()
  glFlush
  ScreenLock
    Flip
  ScreenUnlock
End Sub

Sub Free_Memory()
  Dim As Integer i, i2
  For i = Lbound(Planet) To Ubound(Planet)
    For i2 = 0 To Planet(i).Body.Num_Segments-1
      Deallocate Planet(i).Body.Segment_Ptr[i2].Vertex_Ptr
    Next i2
    Deallocate Planet(i).Body.Segment_Ptr
  Next i
End Sub


'******************************************************************************
'
'   Functions
'
'******************************************************************************

Function Vector_Add (byref v1 As Pos_2D, byref v2 As Pos_2D) As Pos_2D
  Dim v as Pos_2D
  v.x = v1.x + v2.x
  v.y = v1.y + v2.y
  Return v
End Function

Function SegmentsIntersect _
  (ByVal a1 As Pos_2D, ByVal a2 As Pos_2D, _
  ByVal b1 As Pos_2D, ByVal b2 As Pos_2D) As Pos_2D

  Dim as Pos_2D r
  Dim As Single ax, ay, bx, by, t, s, denom
  
  ax = a2.x - a1.x
  ay = a2.y - a1.y
  bx = b2.x - b1.x
  by = b2.y - b1.y
  denom = (bx * ay - by * ax)
  
  If denom <> 0 Then
    
    s = (ax*(b1.y-a1.y) + ay*(a1.x-b1.x)) / denom
    t = (bx*(a1.y-b1.y) + by*(b1.x-a1.x)) / -denom
    
    If (s >= 0 And s <= 1 And t >= 0 And t <= 1) = -1 Then
      
      r.x = a1.x + t * ax
      r.y = a1.y + t * ay
      Return r
      
    End If
    
  End If
  
  r.x = 0
  r.y = 0
  Return r

End Function


'******************************************************************************
'
'   Data
'
'******************************************************************************


Planet_1:

Data 0
