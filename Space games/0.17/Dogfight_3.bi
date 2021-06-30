''  ------------
''    Types
''  ------------

Type Vector_2D
  As Single X, Y
End Type

Type Controls
    lft as Ubyte
    rgt as Ubyte
    fwd as Ubyte
    gun as Ubyte
    pck as Ubyte
End Type

Type Obj
  As Single mass
  As Vector_2D wrld_pos, scrn_pos, vel
End Type 

''  ------------
''    Constants
''  ------------

Const As Single _
Pi = 4*atn(1), _            '' Pi                   = 180 degrees
TwoPi = pi*2, _             '' two x pi             = 360 degrees
ThrqPi = pi*1.5, _          '' one and a half x pi  = 270 degrees
HalfPi = pi*0.5, _          '' half pi              =  90 degrees
radtodeg = 360/TwoPi, _     '' multiply w. this to convert radians to degrees
degtorad = TwoPi/360        '' vice versa

''  ------------
''    Variables
''  ------------

'Dim Shared As Ubyte _      '' 0 to 255

Dim Shared As Ushort _      '' 0 to 65365
i, i2, i3, i4, FPS, FPS_Counter

Dim Shared As Integer _     ''
Xrec, Yrec

Dim Shared As Uinteger _    '' 0 to 4294967295
Scrn_Wid, Scrn_Hgt, Scrn_Bpp, Scrn_Rate, Scrn_X_Mid, Scrn_Y_Mid

Dim Shared As Single _ 
Distance, Dist_Sqared, Force, Time_Scale, Zoom_Scale, Tpol, Rpol

Dim Shared As Double _
last_Scrn_Update, FPS_timer, Scrn_Update

Dim Shared As Vector_2D Dist, Scrn_Center

''  ------------
''    Functions
''  ------------

''  define function that calculates rectangular coordinates from polar coordinates
Function Rec (Byref Rpol as Single, Byref Tpol as Single) As Integer
  Xrec = Cos(Tpol)*Rpol
  Yrec = Sin(Tpol)*Rpol
  Return Xrec
  Return Yrec
End Function 

''  define function that calculates polar coordinates from rectangular coordinates
Function Pol (byref Xrec as Single, byref Yrec as Single) As Integer
  If Xrec < 0 Then
    If Yrec > 0 then 
      Tpol += pi
    Else 
      Tpol -= pi
    End If
  End If
  Rpol = Sqr(Xrec^2+Yrec^2) 
  Tpol = Atn(Yrec/Xrec)
  Return Rpol
  Return Tpol
End Function

''  ------------
''      Subs
''  ------------

Sub Initialize_Screen()
  Screeninfo Scrn_Wid, Scrn_Hgt, Scrn_Bpp,,,Scrn_Rate
  Scrn_Wid = 640
  Scrn_Hgt = 400
  Scrn_Bpp = 32
  Scrn_Rate = 100
  Screenres Scrn_Wid, Scrn_Hgt, Scrn_Bpp,, 1
  Setmouse ,,0
  Scrn_X_Mid = Scrn_Wid\2
  Scrn_Y_Mid = Scrn_Hgt\2
  Scrn_Update = 1/Scrn_Rate
End Sub

Sub Calc_FPS()
  If Timer < FPS_timer Then
    FPS_Counter += 1
  Else
    FPS = FPS_Counter
    FPS_Counter = 0
    FPS_Timer = Timer+1
    ''  fine-tune fps to always be equal to screen update rate
    If FPS < Scrn_rate Then Scrn_Update *= 0.999
    If FPS > Scrn_rate Then Scrn_Update *= 1.001
    Sleep 10, 1
  End If
End Sub

Sub Find_Dist (byref Obj_1 as Obj, byref Obj_2 as Obj)
  Dist.X = Obj_1.wrld_pos.X-Obj_2.wrld_pos.X
  Dist.Y = Obj_1.wrld_pos.Y-Obj_2.wrld_pos.Y
  Dist_Sqared = Dist.X^2 + Dist.Y^2
  Distance = Sqr(Dist_Sqared)
End Sub

Sub Gpull_1way (byref Obj_1 as Obj, byref Obj_2 as Obj)
  Find_Dist (Obj_1, Obj_2)
  Force = (Obj_1.Mass/Dist_sqared)*Time_Scale
  Obj_2.Vel.X += (Dist.X/Distance)*Force
  Obj_2.Vel.Y += (Dist.Y/Distance)*Force
End Sub

Sub Gpull_2way (byref Obj_1 as Obj, byref Obj_2 as Obj)
  Find_Dist (Obj_1, Obj_2)
  Force = (Obj_2.Mass/Dist_sqared)*Time_Scale
  Obj_1.Vel.X -= (Dist.X/Distance)*Force
  Obj_1.Vel.Y -= (Dist.Y/Distance)*Force
  Force = (Obj_1.Mass/Dist_sqared)*Time_Scale
  Obj_2.Vel.X += (Dist.X/Distance)*Force
  Obj_2.Vel.Y += (Dist.Y/Distance)*Force
End Sub

Sub Update_pos (byref Obj as Obj)
  With Obj
    .wrld_pos.X += .Vel.X*Time_Scale
    .wrld_pos.Y += .Vel.Y*Time_Scale
    .scrn_pos.X = Scrn_X_Mid+(.wrld_pos.X+Scrn_Center.X)*Zoom_Scale
    .scrn_pos.Y = Scrn_Y_Mid+(.wrld_pos.Y+Scrn_Center.Y)*Zoom_Scale
  End With
End Sub

Sub Draw_Ellipse (Byval Buffer as Ubyte Ptr, ByVal cX As Single, _
  ByVal cY As Single, ByVal Wid As Single, ByVal Hgt As Single, _
  ByVal angle As Single, byval col as Uinteger, num_lines as Integer)
    
    Dim as Single SinAngle, CosAngle, Theta, DeltaTheta, X, Y, rX, rY
    
    SinAngle = Sin(Angle) 
    CosAngle = Cos(Angle)
    DeltaTheta = Twopi/num_lines
    X = Wid * Cos(Theta) 
    Y = Hgt * Sin(Theta) 
    rX = cX + X * CosAngle + Y * SinAngle 
    rY = cY - X * SinAngle + Y * CosAngle
    Pset buffer, (rX, rY), col
    
    Do While Theta < twopi 
      Theta += DeltaTheta 
      X = Wid * Cos(Theta) 
      Y = Hgt * Sin(Theta) 
      rX = cX + X * CosAngle + Y * SinAngle 
      rY = cY - X * SinAngle + Y * CosAngle
      Line buffer, -(rX, rY), col
    Loop 
End Sub
