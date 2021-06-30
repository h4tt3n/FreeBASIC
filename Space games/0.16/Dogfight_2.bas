''
''                   D O G F I G H T   I N   S P A C E
''
''                                  by
''                           Michael S. Nissen
''                          jernmager@yahoo.dk
''                
''                        v. 2.00 - October 2006
''

Option Explicit
Randomize Timer

#include "Dogfight_2.bi"

Dim Shared Plr(1 to 2) as Plr
Dim Shared Planet(1 to 2) as Planet
Dim Shared Emerald(1 to 100) as Emerald
Dim Shared Asteroid(1 to 650) as Asteroid

Declare Sub DrawShip (Byval Player as Ubyte, Byval Shp as Ubyte, Byval Angle as Single, _
  Byval Col as Single)
    
Declare Sub DrawDock(Byval Player as Ubyte)

''  detect screen settings
Screeninfo Scrn_Wid, Scrn_Hgt,,,,Scrn_Rate

''  apply screen setings to the game
'Scrn_Wid = 800
'Scrn_Hgt = 500
Screenres Scrn_Wid, Scrn_Hgt, 16, 2, 1, Scrn_Rate
ScreenSet 1, 0
Setmouse ,,0
Scrn_X_Mid = Scrn_Wid/2
Scrn_Y_Mid = Scrn_Hgt/2
Scrn_Update = 1/Scrn_Rate
Loop_Rate = 100
Loop_update = 1/Loop_rate
Wait_Rate = Scrn_Update*2
Menu_Hgt = Scrn_Hgt/4
Sleep_Millisecs = 2
Border = 8

'' Sun
With Planet(1)
  .state = 1
  .Mass = Scrn_Update*8e5
  .Radius = 400
  .Xvec = 0
  .Yvec = 0
  .R = 80
  .G = 48
  .B = 24
  .Sprite = ImageCreate (2*.Radius+1, 2*.Radius+1)
  Bload "Sun.BMP", .Sprite
End With

'' Earth
With Planet(2)
  .state = 1
  .Host = 1
  periapsis = Planet(.Host).Radius+4200
  apoapsis = Planet(.Host).Radius+4200
  .Spawn_Distance = Apoapsis
  .Spawn_Angle = Rnd*twopi
  .Mass = Scrn_Update*4e4
  .Radius = 150
  .X = Planet(.Host).X+.Spawn_Distance*Sin(.Spawn_Angle) 
  .Y = Planet(.Host).Y+.Spawn_Distance*Cos(.Spawn_Angle) 
  Semimajor = (.Spawn_Distance+(periapsis+(apoapsis-periapsis)))/2
  Speed = Sqr(Planet(.Host).Mass*((2/.Spawn_Distance)-(1/Semimajor)))
  .XVec = Planet(.Host).Xvec+sqr(Planet(.Host).Mass/.Spawn_Distance)*Cos(.Spawn_Angle)
  .YVec = Planet(.Host).Yvec+sqr(Planet(.Host).Mass/.Spawn_Distance)*Sin(-.Spawn_Angle) 
  .R = 72
  .G = 70
  .B = 68
  .Sprite = ImageCreate (2*.Radius+1, 2*.Radius+1)
  Bload "Earth_small.BMP", .Sprite
End With 

'' Moon
With Planet(3)
  '.state = 1
  .Host = 2
  periapsis = Planet(.Host).Radius+600
  apoapsis = Planet(.Host).Radius+600
  .Spawn_Distance = Apoapsis
  .Spawn_Angle = Rnd*twopi
  .Mass = Scrn_Update*2e3
  .Radius = 50
  .X = Planet(.Host).X+.Spawn_Distance*Sin(.Spawn_Angle) 
  .Y = Planet(.Host).Y+.Spawn_Distance*Cos(.Spawn_Angle) 
  Semimajor = (.Spawn_Distance+(periapsis+(apoapsis-periapsis)))/2
  Speed = Sqr(Planet(.Host).Mass*((2/.Spawn_Distance)-(1/Semimajor)))
  .XVec = Planet(.Host).Xvec-sqr(Planet(.Host).Mass/.Spawn_Distance)*Cos(.Spawn_Angle)
  .YVec = Planet(.Host).Yvec-sqr(Planet(.Host).Mass/.Spawn_Distance)*Sin(-.Spawn_Angle) 
  .R = 72
  .G = 70
  .B = 68
  .Sprite = ImageCreate (2*.Radius+1, 2*.Radius+1)
  Bload "Moon_Small.BMP", .Sprite
End With 

'' Asteroid belt
For i = Lbound(Asteroid) To Ubound(Asteroid)
  With Asteroid(i) 
    .state = 1
    .Host = 1
    periapsis = Planet(.Host).Radius+1800
    apoapsis = Planet(.Host).Radius+2200
    .Spawn_Angle = Rnd*twopi
    .Spawn_Distance = periapsis+Rnd*(apoapsis-periapsis)
    .Mass = 200+(Rnd*(4800)^(1/5))^5
    .Radius = (.mass/(4/3)*pi)^(1/3)
    .X = Planet(.Host).X+.Spawn_Distance*Sin(.Spawn_Angle) 
    .Y = Planet(.Host).Y+.Spawn_Distance*Cos(.Spawn_Angle) 
    Semimajor = (.Spawn_Distance+(periapsis+Rnd*(apoapsis-periapsis)))/2
    Speed = Sqr(Planet(.Host).Mass*((2/.Spawn_Distance)-(1/Semimajor)))
    .Xvec = Planet(.Host).Xvec-Speed*Cos(.Spawn_Angle)
    .Yvec = Planet(.Host).Yvec-Speed*Sin(-.Spawn_Angle)
    If Int(Rnd*2) = 0 Then 
      .XVec =- .XVec 
      .YVec =- .YVec 
    End If
    .Sprite = ImageCreate (2*.Radius+1, 2*.Radius+1)
    'Bload "Asteroid_1.bmp", .Sprite
    .R = 56+Rnd*144
    .G = .R-28+Rnd*28
    .B = .G-28+Rnd*28
    Circle .Sprite, (.Radius, .Radius), .Radius, RGB(.R, .G, .B),,,1,F
    For i2 = Lbound(.Particle) to Ubound(.Particle)
      With .Particle(i2)
        Speed = Scrn_Update*(Rnd*(400^(1/6)))^6
        Direction = Rnd*twopi
        .XVec = Speed*Cos(Direction)
        .YVec = Speed*Sin(-Direction)
        .State = 0
        .Life_Time = 200+Rnd*50
        .R = 255
        .G = .R
        .B = .R
      End With
    Next
  End With 
Next 

''  Emeralds
For i = Lbound(Emerald)  To Ubound(Emerald) 
  With Emerald(i) 
    .state = 1
    .Host = 1
    periapsis = Planet(.Host).Radius+2000
    apoapsis = Planet(.Host).Radius+2200
    .Spawn_Angle = Rnd*twopi
    .Spawn_Distance = periapsis+Rnd*(apoapsis-periapsis)
    .Mass = 300+(Rnd*(1700)^(1/3))^3
    .Radius = ((.mass/(4/3)*pi)^(1/3))
    .X = Planet(.Host).X+.Spawn_Distance*Sin(.Spawn_Angle) 
    .Y = Planet(.Host).Y+.Spawn_Distance*Cos(.Spawn_Angle) 
    Semimajor = (.Spawn_Distance+(periapsis+Rnd*(apoapsis-periapsis)))/2
    Speed = Sqr(Planet(.Host).Mass*((2/.Spawn_Distance)-(1/Semimajor)))
    .Xvec = Planet(.Host).Xvec-Speed*Cos(.Spawn_Angle)
    .Yvec = Planet(.Host).Yvec-Speed*Sin(-.Spawn_Angle)
    .Sprite = ImageCreate (2*.Radius+1, 2*.Radius+1)
    .R = 48+(rnd*16-rnd*16)
    .G = 160+(rnd*48-rnd*48)
    .B = 128+(rnd*32-rnd*32)
    Circle .Sprite, (.Radius, .Radius), .Radius, RGB(.R, .G, .B),,,1,F
    For i2 = Lbound(.Particle) to Ubound(.Particle)
      With .Particle(i2)
        Speed = Scrn_Update*(600-(Rnd*(600^(1/6)))^6)
        Direction = Rnd*twopi
        .XVec = Speed*Cos(Direction)
        .YVec = Speed*Sin(-Direction)
        .State = 0
        .Life_Time = 50+Rnd*200
        .R = 48+(rnd*24-rnd*24)
        .G = 160+(rnd*16-rnd*16)
        .B = 96+(rnd*32-rnd*32)
      End With
    Next
  End With 
Next 

''  define Player specific foo
With Plr(1)
  .Col = RGB(255, 70, 70)
  With .Scrn
    .X = 0
  End With
  With .Menu
    .X = Plr(1).Scrn.X
  End With
  With .Controls
    .lft = 30
    .rgt = 32
    .fwd = 17
    .gun = 42
    .pck = 31
    .Scrn_Style = 60
    .Radar_State = 59
    .Radar_zoom_in = 16
    .Radar_zoom_out = 18
    .Radar_Alpha_Plus = 73
    .Radar_Alpha_Minus = 81
  End With
  With .Dock
    .Host = 1
    .Spawn_Angle = halfpi
    .Spawn_Distance = Planet(1).Radius+1200
    With .Beacon
      .R = 255
      .G = 24
      .B = 24
    End With
  End With
  For i = Lbound(.Ship) to Ubound(.Ship)
    With .Ship(i)
      .Col = RGB(144, 116, 116)
    End With
  Next
End With 

With Plr(2)
  .Col = RGB(70, 70, 255)
  With .Scrn
    .X = (Scrn_Wid/2)+(Border/2)
  End With
  With .Menu
    .X = Plr(2).Scrn.X
  End With
  With .Controls
    .lft = 75
    .rgt = 77
    .fwd = 72
    .gun = 54
    .pck = 80
    .Scrn_Style = 87
    .Radar_State = 88
    .Radar_zoom_in = 51
    .Radar_zoom_out = 52
  End With
  With .Dock
    .Host = 1
    .Spawn_Angle = Plr(1).Dock.Spawn_Angle+pi
    .Spawn_Distance = Plr(1).Dock.Spawn_Distance
    With .Beacon
      .R = 24
      .G = 24
      .B = 255
    End With
  End With
  For i = Lbound(.Ship) to Ubound(.Ship)
    With .Ship(i)
      .Col = RGB(116, 116, 144)
    End With
  Next
End With

''  define general foo
For i = Lbound(Plr) to Ubound(Plr)
  With Plr(i)
    .Active = 1
    .Num_Ships = 4
    .Num_Wins = 0
    .Num_losses = 0
    .Num_Draws = 0
    With .Scrn
      .Y = 0
      .Style = 0
      .Angle = 0
      .Sin_Ang = 0
      .Cos_Ang = 1
      .Wid = (Scrn_Wid/2)-(Border/2)
      .Hgt = Scrn_Hgt-Menu_Hgt
      .X_mid = .Wid/2
      .Y_mid = .Hgt/2
      .Content = ImageCreate(.Wid, .Hgt)
    End With
    With .Menu
      .Wid = Plr(i).Scrn.Wid
      .Hgt = Menu_Hgt
      .Y = (Scrn_Hgt-Menu_Hgt)
      .Col(1) = RGB(48, 48, 48)
      .Content = ImageCreate(.Wid, .Hgt, RGB(32, 32, 32))
    End With
    With .Radar
      .State = 3
      .Hgt = (Plr(i).Scrn.Hgt/2)+4
      .Wid = .Hgt
      .X = Plr(i).Scrn.X+Plr(i).Scrn.X_Mid-(.Wid/2)
      .Y = Scrn_Hgt-.Hgt
      .X_Mid = .Wid/2
      .Y_Mid = .Hgt/2
      .Zoom_Min = 1/6
      .zoom_speed = 1/40
      .Zoom = 1/24
      .Alpha = 64
      .Col(1) = RGB(96, 224, 0)
      .Col(2) = RGB(5, 30, 5)
      .Col(3) = RGB(255, 255, 32)
      .Content = ImageCreate(.Wid+1, .Hgt+1)
      .Content_border = ImageCreate(.Wid+1, .Hgt+1, Plr(i).Menu.Col(1))
    End With
    With .Dock
      .State = 1
      .Host = 1
      .HitPoints = 1000
      .Mass = 5000
      .Fuel_Mass = 5000
      .Fuel_Max = 10000
      .Radius = 140
      .Thrust_Force = Scrn_Update*.Mass*2
      .X = Planet(.Host).X+.Spawn_Distance*Sin(.Spawn_Angle)
      .Y = Planet(.Host).Y+.Spawn_Distance*Cos(.Spawn_Angle)
      .XVec = Planet(.Host).Xvec+sqr(Planet(.Host).Mass/.Spawn_Distance)*Cos(.Spawn_Angle)
      .YVec = Planet(.Host).Yvec+sqr(Planet(.Host).Mass/.Spawn_Distance)*Sin(-.Spawn_Angle)
      .Speed = Sqr(.Xvec^2 + .Yvec^2)
      Pol(Planet(.Host).X-.X, Planet(.Host).Y-.Y)
      DegAdd (Tpol, pi)
      .Angle = Deg
      .Sprite = ImageCreate(2*.Radius, 2*.Radius)
      With .Shield
        .State = 1
        .Radius = Plr(i).Dock.Radius-15
        .Strength = 400
        .Damping = 0.01
      End With
      With .Beacon
        .X = Plr(i).Dock.X
        .Y = Plr(i).Dock.Y
        .Radius = 3
        .State = 1
        .Trigger_Time = 0
        .On_Time = 120
        .FadeIn_Time = 60
        .FadeOut_Time = 60
        .Off_Time = 240
        .On_TimeLeft = 0
        .FadeIn_TimeLeft = 0
        .FadeOut_TimeLeft = 0
        .Off_TimeLeft = 0
      End With
      For i2 = Lbound(.Burst) to Ubound(.Burst)
        With .Burst(i2)
          .Speed = Scrn_Update*(20+Rnd*180)
          .State = 0
          .Life_Time = 60
          .R = 255
          .G = 255
          .B = 255
        End With
      Next
      For i2 = Lbound(.Particle) to Ubound(.Particle)
        With .Particle(i2)
          Speed = Scrn_Update*Rnd*600
          Direction = Rnd*twopi
          .XVec = Speed*Cos(Direction)
          .YVec = Speed*Sin(-Direction)
          .State = 0
          .Life_Time = 50+Rnd*250
          .R = 255
          .G = 255
          .B = 255
        End With
      Next
    End With
    For i2 = Lbound(.Ship) To Ubound(.Ship)
      With .Ship(i2)
        If i2 <= Plr(i).Num_Ships Then
          .state = 1
        End If
        .Spawn_Angle = Plr(i).Dock.Angle+((i2/4)*twopi)
        .Spawn_Distance = Plr(i).Dock.Radius*(3/5)
        .X = Plr(i).Dock.X+.Spawn_Distance*Sin(.Spawn_Angle)
        .Y = Plr(i).Dock.Y+.Spawn_Distance*Cos(.Spawn_Angle)
        .Xvec = Plr(i).Dock.Xvec
        .Yvec = Plr(i).Dock.Yvec
        .Hitpoints = 100
        .Fuel_Mass = 750
        .Fuel_Max = 1500
        .Mass = 500
        .Angle = .Spawn_Angle+halfpi
        .Radius = 14
        Rec (7, pi-.Angle)
        .X_dn = Xrec
        .Y_dn = Yrec
        Rec (15, -.Angle)
        .X_up = Xrec
        .Y_up = Yrec
        .Turn_rate = (twopi/Scrn_Rate)*1.5
        .Thrust_Force = Scrn_Update*.Mass*8
        .Tractor_Force = 3
        .Tractor_MinDist = 75
        .Tractor_Damping = 0.003
        .Payload_state = 0
        .Payload_num = 0
        .Sprite = ImageCreate(2*.Radius, 2*.Radius)
        With .Shield
          If i2 = Plr(i).Active Then
            .State = 0
          Else
            .State = 1
          End If
          .Radius = 32
          .Strength = 200
        End With
        For i3 = Lbound(.Burst) to Ubound(.Burst)
          With .Burst(i3)
            .Speed = Scrn_Update*(20+Rnd*180)
            .State = 0
            .Life_Time = 40
            .R = 255
            .G = 255
            .B = 255
          End With
        Next
        For i3 = Lbound(.Projectile) to Ubound(.Projectile)
          With .Projectile(i3)
            .Speed = Scrn_Update*400
            .Mass = 5
            .State = 0
            .Life_Time = 300
            .R = 255
            .G = 255
            .B = 255
          End With
        Next
        For i3 = Lbound(.Particle) to Ubound(.Particle)
          With .Particle(i3)
            Speed = Scrn_Update*Rnd*600
            Direction = Rnd*twopi
            .XVec = Speed*Cos(Direction)
            .YVec = Speed*Sin(-Direction)
            .State = 0
            .Life_Time = 50+Rnd*250
            .R = 255
            .G = 255
            .B = 255
          End With
        Next
      End With
    Next
  End With
Next

''  calculate reasonable background grid size
Distance = 0
For i = Lbound(Plr) to Ubound(Plr)
  If Plr(i).Dock.Spawn_Distance > Distance Then Distance = Plr(i).Dock.Spawn_Distance
Next
For i = Lbound(Planet) to Ubound(Planet)
  If Planet(i).Spawn_Distance > Distance then Distance = Planet(i).Spawn_Distance
Next
For i = Lbound(Asteroid) to Ubound(Asteroid)
  If Asteroid(i).Spawn_Distance > Distance then Distance = Asteroid(i).Spawn_Distance
Next
For i = Lbound(Emerald) to Ubound(Emerald)
  If Emerald(i).Spawn_Distance > Distance then Distance = Emerald(i).Spawn_Distance
Next

Grid_color = Rgb(7, 42, 7)
Grid_Dist = (Scrn_Hgt-menu_Hgt)
Grid_Num = (Distance/Grid_Dist)+1
Grid_Radius = Planet(1).Radius+(Grid_Num*Grid_Dist)

''  adjust radar zoom to actual world size 
For i = Lbound(Plr) to Ubound(Plr)
  With Plr(i)
    .Radar.Zoom_Max = .Radar.Wid/(Grid_Radius*2)
    .Radar.Object_X = Plr(i).Ship(Plr(i).Active).X
    .Radar.Object_Y = Plr(i).Ship(Plr(i).Active).Y
    With .Radar
      Circle .Content_Border, (.X_Mid, .X_Mid), .X_Mid, Rgb(64, 64, 64),,,1,F
      Circle .Content_Border, (.X_Mid, .X_Mid), .X_Mid-4, RGB(255, 0, 255),,,1, f
    End With
  End With
Next

''  pre-define x/y coordinates of all the points in the concentric circles
Dim Ellipse(1 to Grid_Num) as Ellipse

For i = Lbound(Ellipse) to Ubound(Ellipse)
  Theta = 0
  With Ellipse(i)
    If i <> Ubound(Ellipse) Then
      .Col = Grid_Color
    Else 
      .Col = RGB(72, 12, 12)
    End If
    .Radius = Planet(1).Radius+(i*Grid_Dist)
    .num_lines = 120+(Int((i/Ubound(Ellipse))*60)*4)
    For i2 = 0 To .Num_Lines
      Theta += Twopi/Ellipse(i).Num_lines
      .X(i2) += .Radius * Cos(Theta) 
      .Y(i2) += .Radius * Sin(Theta)
    Next
  End With
Next

''  ditto with the radiating lines
Dim Radian(1 to 48) as Radian

Theta = 60  ''degrees betw. radiating lines (ie. how many lines: 90 = 4, 60 = 6, 45 = 8 and so on)
i2 = 1
i3 = (180/Theta)
For i = i2 to i3
  With Radian(i)
    .X1 = -(Cos(Theta*i*degtorad)*Grid_Radius)
    .Y1 = -(Sin(Theta*i*degtorad)*Grid_Radius)
    .X2 = +(Cos(Theta*i*degtorad)*Grid_Radius)
    .Y2 = +(Sin(Theta*i*degtorad)*Grid_Radius)
  End With
Next
If Grid_Num > 2 Then
  i2 = i3+1
  i3 = i2+(360/Theta)
  For i = i2 to i3
    With Radian(i)
      .X1 = -(Cos(((Theta*i)+((1/2)*Theta))*degtorad)*Grid_Radius)
      .Y1 = -(Sin(((Theta*i)+((1/2)*Theta))*degtorad)*Grid_Radius)
      .X2 = -(Cos(((Theta*i)+((1/2)*Theta))*degtorad)*(Planet(1).Radius+Grid_Dist*2))
      .Y2 = -(Sin(((Theta*i)+((1/2)*Theta))*degtorad)*(Planet(1).Radius+Grid_Dist*2))
    End With
  Next
End If
If Grid_Num > 4 Then
    i2 = i3+1
    i3 = i2+(360/Theta)*2
    For i = i2 to i3
        With Radian(i)
            .X1 = -(Cos((((1/2)*Theta*i)+((1/4)*Theta))*degtorad)*Grid_Radius)
            .Y1 = -(Sin((((1/2)*Theta*i)+((1/4)*Theta))*degtorad)*Grid_Radius)
            .X2 = -(Cos((((1/2)*Theta*i)+((1/4)*Theta))*degtorad)*(Planet(1).Radius+Grid_Dist*4))
            .Y2 = -(Sin((((1/2)*Theta*i)+((1/4)*Theta))*degtorad)*(Planet(1).Radius+Grid_Dist*4))
        End With
    Next
End If
If Grid_Num > 8 Then
    i2 = i3+1
    i3 = i2 + (360/Theta)*4
    For i = i2 to i3
        With Radian(i)
            .X1 = -(Cos((((1/4)*Theta*i)+((1/8)*Theta))*degtorad)*Grid_Radius)
            .Y1 = -(Sin((((1/4)*Theta*i)+((1/8)*Theta))*degtorad)*Grid_Radius)
            .X2 = -(Cos((((1/4)*Theta*i)+((1/8)*Theta))*degtorad)*(Planet(1).Radius+Grid_Dist*8))
            .Y2 = -(Sin((((1/4)*Theta*i)+((1/8)*Theta))*degtorad)*(Planet(1).Radius+Grid_Dist*8))
        End With
    Next
End If

''  draw border between two screens
Line (0, 0)-(Scrn_Wid, Scrn_Hgt), RGB(40, 40, 40), bf
flip
Line (0, 0)-(Scrn_Wid, Scrn_Hgt), RGB(40, 40, 40), bf

'' Main program loop
Do
  
'    ''  calculate total loops / second
'    If Timer < Total_loop_timer Then
'        Total_loop_Counter += 1
'    Else
'        Total_LPS = Total_loop_Counter
'        Total_loop_Counter = 0
'        Total_loop_timer = Timer+1
'    End If
    
    ''  make sure body movement calculation & update always runs at same # of loops / second.
    If Timer >= last_program_loop Then 
        last_program_loop = Timer + loop_update
        
        ''  calculate loops per second
        If Timer < LPS_timer Then
            ''  fine-tune lps to always be equal to pre-defined loop rate
            LPS_Counter += 1
        Else
            LPS = LPS_Counter
            LPS_Counter = 0
            LPS_Timer = Timer+1
            If LPS < Loop_rate Then Loop_update -= 4e-5
            If LPS > Loop_rate Then Loop_update += 4e-5
        End If
        
        ''  calculate gravitational pull using the principles of Isaac Newton
        ''  (and a bit of collision detection, now we're at it...)
        For i = Lbound(Planet) To Ubound(Planet)
            If Planet(i).State = 1 Then
                For i2 = i+1 To Ubound(Planet)
                    With Planet(i2)
                        If .State = 1 Then
                            Xdist = Planet(i).X-.X
                            Ydist = Planet(i).Y-.Y
                            Dist_sqared = Xdist^2 + Ydist^2
                            Distance = sqr(Dist_sqared)
                            MinDist = Planet(i).Radius+.Radius
                            If i <> 1 Then
                                Gforce = .Mass/Dist_sqared
                                Planet(i).Xvec -= (Xdist/Distance)*Gforce
                                Planet(i).Yvec -= (Ydist/Distance)*Gforce
                            End If
                            Gforce = Planet(i).Mass/Dist_sqared
                            .Xvec += (Xdist/Distance)*Gforce
                            .Yvec += (Ydist/Distance)*Gforce
                        End If
                    End With
                Next
                For i2 = Lbound(Plr) to Ubound(Plr)
                    With Plr(i2)
                        With .Dock
                            If .State = 1 Then
                                Xdist = Planet(i).X-.X
                                Ydist = Planet(i).Y-.Y
                                Dist_sqared = Xdist^2 + Ydist^2
                                Distance = sqr(Dist_sqared)
                                MinDist = Planet(i).Radius+.Radius
                                If Distance < MinDist then
                                    Dist_Sqared = MinDist^2
                                End If
                                Gforce = Planet(i).Mass/Dist_sqared
                                .Xvec += (Xdist/Distance)*Gforce
                                .Yvec += (Ydist/Distance)*Gforce
                            End If
                        End With
                        For i3 = Lbound(.Ship) To Ubound(.Ship)
                            With .Ship(i3)
                                If .State = 1 Then
                                    Xdist = Planet(i).X-.X
                                    Ydist = Planet(i).Y-.Y
                                    Dist_sqared = Xdist^2 + Ydist^2
                                    Distance = sqr(Dist_sqared)
                                    MinDist = Planet(i).Radius+.Radius
                                    If Distance < MinDist then
                                        .Xvec -= 0.3*(Xdist/distance)
                                        .Yvec -= 0.3*(Ydist/distance)
                                        .Xvec -= 0.2*(.Xvec-Planet(i).Xvec)
                                        .Yvec -= 0.2*(.Yvec-Planet(i).Yvec)
                                    End If
                                    Gforce = Planet(i).Mass/Dist_sqared
                                    .Xvec += (Xdist/Distance)*Gforce
                                    .Yvec += (Ydist/Distance)*Gforce
                                End If
                            End With
                        Next
                    End With
                Next
                For i2 = Lbound(Asteroid) To Ubound(Asteroid)
                    With Asteroid(i2)
                        If .State = 1 Then
                            Xdist = Planet(i).X-.X
                            Ydist = Planet(i).Y-.Y
                            Dist_sqared = Xdist^2 + Ydist^2
                            Distance = sqr(Dist_sqared)
                            MinDist = Planet(i).Radius+.Radius
                            If Distance < MinDist then
                                .State = 0
                                .Xvec = Planet(i).Xvec
                                .Yvec = Planet(i).Yvec
                                .Explosion_trigger = 1
                                .Explosion_state = 1
                            End If
                            Gforce = Planet(i).Mass/Dist_sqared
                            .Xvec += (Xdist/Distance)*Gforce
                            .Yvec += (Ydist/Distance)*Gforce
                        End If
                    End With
                Next
                For i2 = Lbound(Emerald) To Ubound(Emerald)
                    With Emerald(i2)
                        If .State = 1 Then
                            Xdist = Planet(i).X-.X
                            Ydist = Planet(i).Y-.Y
                            Dist_sqared = Xdist^2 + Ydist^2
                            Distance = sqr(Dist_sqared)
                            MinDist = Planet(i).Radius+.Radius
                            If Distance < MinDist then
                                .State = 0
                                .Xvec = Planet(i).Xvec
                                .Yvec = Planet(i).Yvec
                                .Explosion_trigger = 1
                                .Explosion_state = 1
                                For i3 = Lbound(Plr) to Ubound(Plr)
                                    With Plr(i3)
                                        If .Ship(.Active).Payload_num = i2 Then
                                            .Ship(.Active).Payload_state = 0
                                            .Ship(.Active).Payload_num = 0
                                        End If
                                    End With
                                Next
                            End If
                            Gforce = Planet(i).Mass/Dist_sqared
                            .Xvec += (Xdist/Distance)*Gforce
                            .Yvec += (Ydist/Distance)*Gforce
                        End If
                    End With
                Next
            End If
        Next
        
        For i = Lbound(Plr) to Ubound(Plr)
            
            ''  ship stuff
            With Plr(i).Ship(Plr(i).Active)
                If .State = 1 Then
                    
                    ''  Bounce stray ships back into battle area
                    Xdist = Planet(1).X-.X
                    Ydist = Planet(1).Y-.Y
                    Distance = sqr(Xdist^2 + Ydist^2)
                    If Distance > Grid_Radius-.Radius Then
                        .Xvec *= 0.96
                        .Yvec *= 0.96
                        .Xvec += (Xdist/Distance)/6
                        .Yvec += (Ydist/Distance)/6
                    End If
                    
                    ''  emerald pick up
                    If .Payload_State = 1 Then
                        
                        ''  calc force betw. ship and payload emerald
                        Xdist = (.X_dn+.X)-Emerald(.Payload_Num).X
                        Ydist = (.Y_dn+.Y)-Emerald(.Payload_Num).Y
                        Distance = sqr(Xdist^2 + Ydist^2)
                        .Xvec -= .Tractor_Damping*(.Xvec-Emerald(.Payload_Num).Xvec)
                        .Yvec -= .Tractor_Damping*(.Yvec-Emerald(.Payload_Num).Yvec)
                        .Xvec -= .Tractor_Force*(Xdist/Distance)*((Distance-.Tractor_MinDist)/.Mass)
                        .Yvec -= .Tractor_Force*(Ydist/Distance)*((Distance-.Tractor_MinDist)/.Mass)
                        Emerald(.Payload_Num).Xvec += .Tractor_Damping*(.Xvec-Emerald(.Payload_Num).Xvec)
                        Emerald(.Payload_Num).Yvec += .Tractor_Damping*(.Yvec-Emerald(.Payload_Num).Yvec)
                        Emerald(.Payload_Num).Xvec += .Tractor_Force*(Xdist/Distance)*((Distance-.Tractor_MinDist)/Emerald(.Payload_Num).Mass)
                        Emerald(.Payload_Num).Yvec += .Tractor_Force*(Ydist/Distance)*((Distance-.Tractor_MinDist)/Emerald(.Payload_Num).Mass)
                        
                        ''  is emerald delivered at home or not?
                        Xdist = Emerald(.Payload_Num).X-Plr(i).Dock.X
                        Ydist = Emerald(.Payload_Num).Y-Plr(i).Dock.Y
                        Distance = sqr(Xdist^2 + Ydist^2)
                        If Distance-Emerald(.Payload_Num).Radius < Plr(i).Dock.Shield.Radius Then
                            .Fuel_Mass += Emerald(.Payload_Num).Mass*(1/10)
                            Plr(i).Dock.Fuel_Mass += Emerald(.Payload_Num).Mass*(9/10)
                            If .Fuel_Mass > .Fuel_Max Then .Fuel_Mass = .Fuel_Max
                            If Plr(i).Dock.Fuel_Mass > Plr(i).Dock.Fuel_Max Then 
                              Plr(i).Dock.Fuel_Mass = Plr(i).Dock.Fuel_Max
                            End If
                            If Plr(i).Dock.Shield.State = 0 and Plr(i).Dock.Fuel_Mass > 0.5 Then
                              Plr(i).Dock.Shield.State = 1
                            End If
                            Emerald(.Payload_Num).State = 0
                            .Payload_State = 0
                            .Payload_Num = 0
                        End If
                        
                    End If
                    
                End If
                
            End With
            
            ''  ship deflection shield
            For i2 = Lbound(Plr(i).Ship) to Ubound(Plr(i).Ship)
                With Plr(i).Ship(i2)
                    If .State = 1 Then
                        If .Shield.State = 1 Then
                            For i3 = Lbound(Asteroid) to Ubound(Asteroid)
                                If Asteroid(i3).State = 1 Then
                                    If (Sgn(Asteroid(i3).X) = Sgn(.X) or _
                                    Sgn(Asteroid(i3).Y) = Sgn(.Y)) Then
                                        MinDist = .Shield.Radius+Asteroid(i3).Radius
                                        Xdist = .X-Asteroid(i3).X
                                        If Xdist < MinDist Then
                                            Ydist = .Y-Asteroid(i3).Y
                                            Distance = sqr(Xdist^2 + Ydist^2)
                                            If Distance < MinDist Then
                                                .Shield.Strength = 0.5
                                                Asteroid(i3).Xvec -= .Shield.Strength*(Xdist/Distance)
                                                Asteroid(i3).Yvec -= .Shield.Strength*(Ydist/Distance)
                                                .Xvec += .Shield.Strength*(Xdist/Distance)*(Asteroid(i3).Mass/(.Mass+.Fuel_Mass))
                                                .Yvec += .Shield.Strength*(Ydist/Distance)*(Asteroid(i3).Mass/(.Mass+.Fuel_Mass))
                                            End If
                                        End If
                                    End If
                                End If
                            Next
                            For i3 = Lbound(Emerald) to Ubound(Emerald)
                                If Emerald(i3).State = 1 Then
                                    If (Sgn(Emerald(i3).X) = Sgn(.X) or _
                                    Sgn(Emerald(i3).Y) = Sgn(.Y)) Then
                                        MinDist = .Shield.Radius+Emerald(i3).Radius
                                        Xdist = .X-Emerald(i3).X
                                        If Xdist < MinDist Then
                                            Ydist = .Y-Emerald(i3).Y
                                            Distance = sqr(Xdist^2 + Ydist^2)
                                            If Distance < MinDist Then
                                                .Shield.Strength = Emerald(i3).Mass/2
                                                .Xvec += .Shield.Strength*(Xdist/Distance)/(.Mass+.Fuel_Mass)
                                                .Yvec += .Shield.Strength*(Ydist/Distance)/(.Mass+.Fuel_Mass)
                                                Emerald(i3).Xvec -= .Shield.Strength*(Xdist/Distance)/Emerald(i3).Mass
                                                Emerald(i3).Yvec -= .Shield.Strength*(Ydist/Distance)/Emerald(i3).Mass
                                            End If
                                        End If
                                    End If
                                End If
                            Next
                            For i3 = Lbound(Plr) to Ubound(Plr)
                                For i4 = Lbound(Plr(i3).Ship) to Ubound(Plr(i3).Ship)
                                    If Plr(i3).Ship(i4).State = 1 Then
                                        Xdist = Plr(i).Ship(i2).X-Plr(i3).Ship(i4).X
                                        Ydist = Plr(i).Ship(i2).Y-Plr(i3).Ship(i4).Y
                                        Distance = sqr(Xdist^2 + Ydist^2)
                                        If Distance <> 0 Then
                                            If Plr(i).Ship(i2).Shield.State = 1 Xor Plr(i3).Ship(i4).Shield.State = 1 Then 
                                                MinDist = Plr(i).Ship(i2).Shield.Radius+Plr(i3).Ship(i4).Radius
                                            ElseIf Plr(i).Ship(i2).Shield.State = 1 and Plr(i3).Ship(i4).Shield.State = 1 Then 
                                                MinDist = Plr(i).Ship(i2).Shield.Radius+Plr(i3).Ship(i4).Shield.Radius
                                            End If
                                            If Distance <= MinDist Then
                                                Plr(i).Ship(i2).Shield.Strength = (Plr(i).Ship(i2).Mass+Plr(i).Ship(i2).Fuel_Mass)/2
                                                Plr(i).Ship(i2).Xvec += Plr(i).Ship(i2).Shield.Strength*(Xdist/Distance)/(Plr(i).Ship(i2).Mass+Plr(i).Ship(i2).Fuel_Mass)
                                                Plr(i).Ship(i2).Yvec += Plr(i).Ship(i2).Shield.Strength*(Ydist/Distance)/(Plr(i).Ship(i2).Mass+Plr(i).Ship(i2).Fuel_Mass)
                                                Plr(i3).Ship(i4).Xvec -= Plr(i).Ship(i2).Shield.Strength*(Xdist/Distance)/(Plr(i3).Ship(i4).Mass+Plr(i3).Ship(i4).Fuel_Mass)
                                                Plr(i3).Ship(i4).Yvec -= Plr(i).Ship(i2).Shield.Strength*(Ydist/Distance)/(Plr(i3).Ship(i4).Mass+Plr(i3).Ship(i4).Fuel_Mass)
                                            End If
                                        End If
                                    End If
                                Next
                                For i4 = Lbound(Plr(i3).Ship(Plr(i3).Active).Projectile) to Ubound(Plr(i3).Ship(Plr(i3).Active).Projectile)
                                    With Plr(i3).Ship(Plr(i3).Active).Projectile(i4)
                                        If .State = 1 Then
                                            Xdist = Plr(i).Ship(i2).X-.X
                                            Ydist = Plr(i).Ship(i2).Y-.Y
                                            Distance = sqr(Xdist^2 + Ydist^2)
                                            If Distance <= Plr(i).Ship(i2).Shield.Radius Then
                                                Plr(i).Ship(i2).Shield.Strength = .Mass*4
                                                Plr(i).Ship(i2).Xvec += Plr(i).Ship(i2).Shield.Strength*(Xdist/Distance)/(Plr(i).Ship(i2).Mass+Plr(i).Ship(i2).Fuel_Mass)
                                                Plr(i).Ship(i2).Yvec += Plr(i).Ship(i2).Shield.Strength*(Ydist/Distance)/(Plr(i).Ship(i2).Mass+Plr(i).Ship(i2).Fuel_Mass)
                                                .Xvec += Plr(i).Ship(i2).Shield.Strength*(Xdist/Distance)/.Mass
                                                .Yvec += Plr(i).Ship(i2).Shield.Strength*(Ydist/Distance)/.Mass
                                            End If
                                        End If
                                    End With
                                Next
                            Next
                        End If
                    End If
                End With
            Next
        
            ''  dock stuff
            With Plr(i).Dock
                If .State = 1 Then
                  If .Shield.State = 1 Then
                    ''  dock deflection shield
                    ''  keep inactive ships inside dock shield
                    For i2 = Lbound(Plr(i).Ship) to Ubound(Plr(i).Ship)
                        If Plr(i).Ship(i2).State = 1 Then
                            If i2 <> Plr(i).Active Then
                                Xdist = .X-Plr(i).Ship(i2).X
                                Ydist = .Y-Plr(i).Ship(i2).Y
                                Distance = sqr(Xdist^2 + Ydist^2)
                                MinDist = .Shield.Radius-Plr(i).Ship(i2).Shield.Radius
                                If Distance > MinDist and Distance < .Shield.Radius Then
                                    .Xvec -= .Shield.Damping*(.Xvec-Plr(i).Ship(i2).Xvec)
                                    .Yvec -= .Shield.Damping*(.Yvec-Plr(i).Ship(i2).Yvec)
                                    .Xvec -= .Shield.Strength*(Xdist/Distance)/.Mass
                                    .Yvec -= .Shield.Strength*(Ydist/Distance)/.Mass
                                    Plr(i).Ship(i2).Xvec += .Shield.Damping*(.Xvec-Plr(i).Ship(i2).Xvec)
                                    Plr(i).Ship(i2).Yvec += .Shield.Damping*(.Yvec-Plr(i).Ship(i2).Yvec)
                                    Plr(i).Ship(i2).Xvec += .Shield.Strength*(Xdist/Distance)/Plr(i).Ship(i2).Mass
                                    Plr(i).Ship(i2).Yvec += .Shield.Strength*(Ydist/Distance)/Plr(i).Ship(i2).Mass
                                End If
                            End If
                        End If
                    Next
                    ''  keep asteroids outside shield
                    For i2 = Lbound(Asteroid) to Ubound(Asteroid)
                        If Asteroid(i2).State = 1 Then
                            If (Sgn(Asteroid(i2).X) = Sgn(.X) or _
                            Sgn(Asteroid(i2).Y) = Sgn(.Y)) Then
                                MinDist = .Shield.Radius+Asteroid(i2).Radius
                                Xdist = .X-Asteroid(i2).X
                                If Xdist < MinDist Then
                                    Ydist = .Y-Asteroid(i2).Y
                                    Distance = sqr(Xdist^2 + Ydist^2)
                                    If Distance < MinDist Then
                                        .Xvec += .Shield.Strength*(Xdist/Distance)/.Mass
                                        .Yvec += .Shield.Strength*(Ydist/Distance)/.Mass
                                        Asteroid(i2).Xvec -= .Shield.Strength*(Xdist/Distance)/Asteroid(i2).Mass
                                        Asteroid(i2).Yvec -= .Shield.Strength*(Ydist/Distance)/Asteroid(i2).Mass
                                    End If
                                End If
                            End If
                        End If
                    Next
                  End If
                    
                    ''  dock autopilot - keeps dock in a steady orbit
                    Xdist = Planet(.Host).X-.X
                    Ydist = Planet(.Host).Y-.Y
                    Speed = sqr(.Xvec^2 + .Yvec^2)
                    Distance = Sqr(Xdist^2 + Ydist^2)
                    Pol(Xdist, Ydist)
                    DegAdd (Tpol, pi)
                    .Angle = Deg
                    Pol (-.Xvec, -.Yvec)
                    DegAdd (Tpol, pi)
                    .Move_Direction = Deg
                    Rec(.Shield.Radius, .Angle+(225*Degtorad))
                    .X_tr = Xrec
                    .Y_tr = Yrec
                    Rec(.Shield.Radius, .Angle+(135*Degtorad))
                    .X_tl = Xrec
                    .Y_tl = Yrec
                    Rec(.Shield.Radius, .Angle+(315*Degtorad))
                    .X_br = Xrec
                    .Y_br = Yrec
                    Rec(.Shield.Radius, .Angle+(45*Degtorad))
                    .X_bl = Xrec
                    .Y_bl = Yrec
                    If Distance < .Spawn_Distance-5 Then
                        DegSub (.Move_Direction, .Angle)
                        If Deg > Halfpi or Deg < ThrqPi Then
                            .Xvec += .Thrust_Force*(Cos(.Angle)/.Mass)
                            .Yvec += .Thrust_Force*(Sin(.Angle)/.Mass)
                            For i2 = Lbound(.Burst) to Ubound(.Burst)
                                If .Burst(i2).State = 0 Then
                                    .Burst(i2).Direction = .Angle+((Rnd*5-Rnd*5)*Degtorad)
                                    .Burst(i2).XVec = (.Burst(i2).Speed*Cos(.Burst(i2).Direction))-.Xvec
                                    .Burst(i2).YVec = (.Burst(i2).Speed*Sin(.Burst(i2).Direction))-.Yvec
                                    .Burst(i2).X = .X-.X_bl
                                    .Burst(i2).Y = .Y-.Y_bl
                                    .Burst(i2).Life_TimeLeft = .Burst(i2).Life_Time
                                    .Burst(i2).State = 1
                                    Exit For
                                End If
                            Next
                            For i2 = Lbound(.Burst) to Ubound(.Burst)
                                If .Burst(i2).State = 0 Then
                                    .Burst(i2).Direction = .Angle+((Rnd*5-Rnd*5)*Degtorad)
                                    .Burst(i2).XVec = (.Burst(i2).Speed*Cos(.Burst(i2).Direction))-.Xvec
                                    .Burst(i2).YVec = (.Burst(i2).Speed*Sin(.Burst(i2).Direction))-.Yvec
                                    .Burst(i2).X = .X-.X_br
                                    .Burst(i2).Y = .Y-.Y_br
                                    .Burst(i2).Life_TimeLeft = .Burst(i2).Life_Time
                                    .Burst(i2).State = 1
                                    Exit For
                                End If
                            Next
                        End If
                    ElseIf Distance > .Spawn_Distance+5 Then
                        DegSub (.Move_Direction, .Angle)
                        If Deg < Halfpi or Deg > ThrqPi Then
                            DegAdd (Pi, .Angle)
                            .Xvec += .Thrust_Force*(Cos(Deg)/.Mass)
                            .Yvec += .Thrust_Force*(Sin(Deg)/.Mass)
                            For i2 = Lbound(.Burst) to Ubound(.Burst)
                                If .Burst(i2).State = 0 Then
                                    .Burst(i2).Direction = Deg+((Rnd*5-Rnd*5)*Degtorad)
                                    .Burst(i2).XVec = (.Burst(i2).Speed*Cos(.Burst(i2).Direction))-.Xvec
                                    .Burst(i2).YVec = (.Burst(i2).Speed*Sin(.Burst(i2).Direction))-.Yvec
                                    .Burst(i2).X = .X-.X_tl
                                    .Burst(i2).Y = .Y-.Y_tl
                                    .Burst(i2).Life_TimeLeft = .Burst(i2).Life_Time
                                    .Burst(i2).State = 1
                                    Exit For
                                End If
                            Next
                            For i2 = Lbound(.Burst) to Ubound(.Burst)
                                If .Burst(i2).State = 0 Then
                                    .Burst(i2).Direction = Deg+((Rnd*5-Rnd*5)*Degtorad)
                                    .Burst(i2).XVec = (.Burst(i2).Speed*Cos(.Burst(i2).Direction))-.Xvec
                                    .Burst(i2).YVec = (.Burst(i2).Speed*Sin(.Burst(i2).Direction))-.Yvec
                                    .Burst(i2).X = .X-.X_tr
                                    .Burst(i2).Y = .Y-.Y_tr
                                    .Burst(i2).Life_TimeLeft = .Burst(i2).Life_Time
                                    .Burst(i2).State = 1
                                    Exit For
                                End If
                            Next
                        End If
                    End If
                    If Speed < .Speed*0.99 Then
                        DegSub (.Move_Direction, .Angle)
                        If Deg > Pi Then
                            DegAdd (ThrqPi, .Angle)
                            .Xvec += .Thrust_Force*(Cos(Deg)/.Mass)
                            .Yvec += .Thrust_Force*(Sin(Deg)/.Mass)
                            For i2 = Lbound(.Burst) to Ubound(.Burst)
                                If .Burst(i2).State = 0 Then
                                    .Burst(i2).Direction = Deg+((Rnd*5-Rnd*5)*Degtorad)
                                    .Burst(i2).XVec = (.Burst(i2).Speed*Cos(.Burst(i2).Direction))-.Xvec
                                    .Burst(i2).YVec = (.Burst(i2).Speed*Sin(.Burst(i2).Direction))-.Yvec
                                    .Burst(i2).X = .X-.X_br
                                    .Burst(i2).Y = .Y-.Y_br
                                    .Burst(i2).Life_TimeLeft = .Burst(i2).Life_Time
                                    .Burst(i2).State = 1
                                    Exit For
                                End If
                            Next
                            For i2 = Lbound(.Burst) to Ubound(.Burst)
                                If .Burst(i2).State = 0 Then
                                    .Burst(i2).Direction = Deg+((Rnd*5-Rnd*5)*Degtorad)
                                    .Burst(i2).XVec = (.Burst(i2).Speed*Cos(.Burst(i2).Direction))-.Xvec
                                    .Burst(i2).YVec = (.Burst(i2).Speed*Sin(.Burst(i2).Direction))-.Yvec
                                    .Burst(i2).X = .X-.X_tr
                                    .Burst(i2).Y = .Y-.Y_tr
                                    .Burst(i2).Life_TimeLeft = .Burst(i2).Life_Time
                                    .Burst(i2).State = 1
                                    Exit For
                                End If
                            Next
                        Else
                            DegAdd (Halfpi, .Angle)
                            .Xvec += .Thrust_Force*(Cos(Deg)/.Mass)
                            .Yvec += .Thrust_Force*(Sin(Deg)/.Mass)
                        End If
                    ElseIf Speed > .Speed*1.01 Then
                        DegSub (.Move_Direction, .Angle)
                        If Deg > Pi Then
                            DegAdd (Halfpi, .Angle)
                            .Xvec += .Thrust_Force*(Cos(Deg)/.Mass)
                            .Yvec += .Thrust_Force*(Sin(Deg)/.Mass)
                        Else
                            DegAdd (ThrqPi, .Angle)
                            .Xvec += .Thrust_Force*(Cos(Deg)/.Mass)
                            .Yvec += .Thrust_Force*(Sin(Deg)/.Mass)
                        End If
                    End If
                End If
            End With
            
        Next

        ''  update body movement
        For i = Lbound(Planet)+1 To Ubound(Planet)
            With Planet(i)
                If .State = 1 Then
                    .X += .XVec 
                    .Y += .YVec
                End If
            End With
        Next
        For i = Lbound(Asteroid) To Ubound(Asteroid)
            With Asteroid(i)
                If .State = 1 Then
                    .X += .XVec 
                    .Y += .YVec
                Else
                    If .Explosion_state = 1 Then
                        For i2 = Lbound(.Particle) To Ubound(.Particle)
                            With .Particle(i2)
                                If .State = 1 Then
                                    .X -= .Xvec
                                    .Y -= .Yvec
                                End If
                            End With
                        Next
                    End If
                End If 
            End With
        Next
        For i = Lbound(Emerald) To Ubound(Emerald)
            With Emerald(i)
                If .State = 1 Then
                    .X += .XVec 
                    .Y += .YVec
                Else
                    If .Explosion_state = 1 Then
                        For i2 = Lbound(.Particle) To Ubound(.Particle)
                            With .Particle(i2)
                                If .State = 1 Then
                                    .X -= .Xvec
                                    .Y -= .Yvec
                                End If
                            End With
                        Next
                    End If
                End If 
            End With
        Next
        For i = Lbound(Plr) to Ubound(Plr)
            With Plr(i)
                With .Dock
                    For i2 = Lbound(.Burst) To Ubound(.Burst)
                        If .Burst(i2).State = 1 Then
                            .Burst(i2).X -= .Burst(i2).Xvec
                            .Burst(i2).Y -= .Burst(i2).Yvec
                        End If
                    Next
                    If .State = 1 Then
                        .X += .XVec 
                        .Y += .YVec
                    Else
                        If .Explosion_state = 1 Then
                            For i2 = Lbound(.Particle) To Ubound(.Particle)
                                With .Particle(i2)
                                    If .State = 1 Then
                                        .X -= .Xvec
                                        .Y -= .Yvec
                                    End If
                            End With
                            Next
                        End If
                    End If
                End With
                For i2 = Lbound(.Ship) to Ubound(.Ship)
                    With .Ship(i2)
                        For i3 = Lbound(.Burst) To Ubound(.Burst)
                            If .Burst(i3).State = 1 Then
                                .Burst(i3).X -= .Burst(i3).Xvec
                                .Burst(i3).Y -= .Burst(i3).Yvec
                            End If
                        Next
                        For i3 = Lbound(.Projectile) to Ubound(.Projectile)
                            If .Projectile(i3).State = 1 Then
                                .Projectile(i3).X -= .Projectile(i3).Xvec
                                .Projectile(i3).Y -= .Projectile(i3).Yvec
                            End If
                        Next
                        If .State = 1 Then
                            .X += .XVec 
                            .Y += .YVec
                        Else
                            If .Explosion_state = 1 Then
                                For i2 = Lbound(.Particle) To Ubound(.Particle)
                                    With .Particle(i2)
                                        If .State = 1 Then
                                            .X -= .Xvec
                                            .Y -= .Yvec
                                        End If
                                    End With
                                Next
                            End If
                        End If
                    End With
                Next
            End With
        Next
        
    End If
    
    ''  update screen every 1/Scrn_Rate seconds
    If Timer >= last_Scrn_Update Then 
        last_Scrn_Update = Timer + Scrn_Update
        
        ''  calculate fps
        If Timer < FPS_timer Then
            FPS_Counter += 1
        Else
            FPS = FPS_Counter
            FPS_Counter = 0
            FPS_Timer = Timer+1
            ''  fine-tune fps to always be equal to screen update rate
            If FPS < Scrn_rate Then Scrn_Update -= 1e-4
            If FPS > Scrn_rate Then Scrn_Update += 1e-4
            Sleep Sleep_Millisecs
        End If
        
        For i = Lbound(Plr) to Ubound(Plr)
            With Plr(i)
                
                ''  CONTROLS
                
                ''  radar foo
                With .Radar
                    ''  toggle radar on/off & radar type
                    If multikey (Plr(i).Controls.Radar_State) then 
                        If Timer > Plr(i).Wait_Time(1) Then
                            .State += 1
                            If .State > 4 Then .State = 0
                            If .State = 1 or .State = 2 Then
                                .Wid = Plr(i).Scrn.Wid
                                .Hgt = Plr(i).Scrn.Hgt
                                .X = Plr(i).Scrn.X
                                .Y = Plr(i).Scrn.Y
                                If .State = 1 Then
                                    ImageDestroy(.Content)
                                    .Content = ImageCreate(.Wid, .Hgt)
                                    .Zoom = .Zoom_Old*2
                                    .Zoom_Min *= 2
                                    .Zoom_Max *= 2
                                    .X_Mid = Plr(i).Scrn.X_Mid
                                    .Y_Mid = Plr(i).Scrn.Y_Mid
                                    .Object_X = Plr(i).Ship(Plr(i).Active).X
                                    .Object_Y = Plr(i).Ship(Plr(i).Active).Y
                                ElseIf .State = 2 Then
                                    .Zoom_Old = .Zoom
                                    .Zoom = .Zoom_Max
                                    .Object_X = 0
                                    .Object_Y = 0
                                End If
                            ElseIf .State = 3 or .State = 4 Then
                                .Hgt = (Plr(i).Scrn.Hgt/2)+4
                                .Wid = .Hgt
                                .X = Plr(i).Scrn.X+Plr(i).Scrn.X_Mid-(.Wid/2)
                                .Y = Scrn_Hgt-.Hgt
                                If .State = 3 Then
                                    ImageDestroy(.Content)
                                    .Content = ImageCreate(.Wid+1, .Hgt+1)
                                    .Zoom = .Zoom_Old/2
                                    .Zoom_Min /= 2
                                    .Zoom_Max /= 2
                                    .X_Mid = .Wid/2
                                    .Y_Mid = .Hgt/2
                                    .Object_X = Plr(i).Ship(Plr(i).Active).X
                                    .Object_Y = Plr(i).Ship(Plr(i).Active).Y
                                ElseIf .State = 4 Then
                                    .Zoom_Old = .Zoom
                                    .Zoom = .Zoom_Max
                                    .Object_X = 0
                                    .Object_Y = 0
                                End If
                            End If
                        End If
                        Plr(i).Wait_Time(1) = Timer + Wait_Rate
                    End If
                    
                    ''  toggle radar zoom
                    If .State <> 0 Then
                        If .State = 1 or .State = 3 Then
                            If multikey (Plr(i).Controls.Radar_zoom_out) then
                                .Zoom += .Zoom*.zoom_speed
                                If .Zoom > .Zoom_Min Then .Zoom = .Zoom_Min
                            End If
                            If multikey (Plr(i).Controls.Radar_zoom_in) then
                                .Zoom -= .Zoom*.zoom_speed
                                If .Zoom < .Zoom_Max Then .Zoom = .Zoom_Max
                            End If
                        ElseIf .State = 2 or .State = 4 Then
                            .Zoom = .Zoom_Max
                        End If
                    End If
                    
                    If multikey (Plr(i).Controls.Radar_Alpha_Plus) then 
                      If .Alpha < 255 Then .Alpha += 1
                    End If
                    
                    If multikey (Plr(i).Controls.Radar_Alpha_Minus) then 
                      If .Alpha > 0 Then .Alpha -= 1
                    End If
 
                    
                End With
                
                ''  toggle screen style - absolute or relative
                If Multikey (Plr(i).Controls.Scrn_Style) Then
                    If Timer > Plr(i).Wait_Time(2) Then 
                        Plr(i).Scrn.Style xor = 1
                    End If
                    If .Scrn.Style = 0 Then
                        .Scrn.Angle = 0
                        .Scrn.Sin_Ang = 0
                        .Scrn.Cos_Ang = 1
                    End If
                    Plr(i).Wait_Time(2) = Timer + Wait_Rate
                End If
                
                ''  toggle ship controls
                With .Ship(.Active)
                    If .State = 1 Then
                        ''  toggle ship turn right
                        If multikey (Plr(i).Controls.Lft) and not _
                        Multikey (Plr(i).Controls.Rgt) then 
                            .Angle += .Turn_Rate
                            Rec (7, pi-.Angle)
                            .X_dn = Xrec
                            .Y_dn = Yrec
                            Rec (15, -.Angle)
                            .X_up = Xrec
                            .Y_up = Yrec
                        End If
                        
                        ''  toggle ship turn left
                        If multikey (Plr(i).Controls.rgt) and not _
                        multikey (Plr(i).Controls.Lft) then 
                            .Angle -= .Turn_Rate
                            Rec (7, pi-.Angle)
                            .X_dn = Xrec
                            .Y_dn = Yrec
                            Rec (15, -.Angle)
                            .X_up = Xrec
                            .Y_up = Yrec
                        End If
                        
                        ''  toggle ship thrust
                        If multikey (Plr(i).Controls.fwd) then
                            If .Fuel_Mass >= 0.02 then
                                .Fuel_Mass -= 0.02
                                .Xvec -= .Thrust_Force*(Cos(.Angle)/(.Mass+.Fuel_Mass))
                                .Yvec -= .Thrust_Force*(Sin(-.Angle)/(.Mass+.Fuel_Mass))
                                For i2 = Lbound(.Burst) to Ubound(.Burst)
                                    If .Burst(i2).State = 0 Then
                                        .Burst(i2).Direction = .Angle+pi+((Rnd*10-Rnd*10)*Degtorad)
                                        .Burst(i2).XVec = (.Burst(i2).Speed*Cos(.Burst(i2).Direction))-.Xvec
                                        .Burst(i2).YVec = (.Burst(i2).Speed*Sin(-.Burst(i2).Direction))-.Yvec
                                        .Burst(i2).X = .X-.X_dn
                                        .Burst(i2).Y = .Y-.Y_dn
                                        .Burst(i2).Life_TimeLeft = .Burst(i2).Life_Time
                                        .Burst(i2).State = 1
                                        Exit For
                                    End If
                                Next
                            Else 
                                .Fuel_Mass = 0
                            End If
                        End If
                        
                        ''  toggle emerald pick up / weapon swap
                        If multikey (Plr(i).Controls.pck) then 
                            If Timer > Plr(i).Wait_Time(3) Then
                                If .Payload_State = 1 Then
                                    .Payload_State = 0
                                    .Payload_Num = 0
                                ElseIf .Payload_State = 0 Then
                                    i3 = .Tractor_MinDist
                                    For i2 = Lbound(Emerald) to Ubound(Emerald)
                                        If Emerald(i2).State = 1 Then
                                            Xpos = .X-Emerald(i2).X
                                            Ypos = .Y-Emerald(i2).Y
                                            Distance = sqr(Xpos^2 + Ypos^2)
                                            If Distance <= i3 Then 
                                                i3 = Distance
                                                .Payload_Num = i2
                                            End If
                                        End If
                                    Next
                                    If .Payload_Num <> 0 Then
                                        .Payload_State = 1
                                    End If
                                End If
                            End If
                            Plr(i).Wait_Time(3) = Timer + Wait_Rate
                        End If
                        
                        ''  toggle ship deflection shield
                        If Multikey (Plr(i).Controls.lft) and Multikey (Plr(i).Controls.Rgt) Then
                            If Timer > Plr(i).Wait_Time(4) Then 
                                .Shield.State xor = 1
                            End If
                            Plr(i).Wait_Time(4) = Timer + Wait_Rate
                        End If
                        If .Shield.State = 1 Then
                            If .Fuel_mass >= 0.05 Then
                                .Fuel_Mass -= 0.05
                            Else
                                .Fuel_Mass = 0
                                .Shield.State = 0
                            End If
                        End If
                        
                        ''  toggle ship weapon
                        If Multikey(Plr(i).Controls.gun) Then
                            If .Shield.State = 0 Then
                                If Timer > Plr(i).Wait_Time(5) Then
                                    If .Fuel_Mass >= 5 then
                                        For i2 = Lbound(.Projectile) to Ubound(.Projectile)
                                            If .Projectile(i2).State = 0 Then
                                                .Projectile(i2).Direction = .Angle
                                                .Projectile(i2).XVec = (.Projectile(i2).Speed*Cos(.Projectile(i2).Direction))-.Xvec
                                                .Projectile(i2).YVec = (.Projectile(i2).Speed*Sin(-.Projectile(i2).Direction))-.Yvec
                                                .Projectile(i2).X = .X-.X_up
                                                .Projectile(i2).Y = .Y-.Y_up
                                                .Projectile(i2).Life_TimeLeft = .Projectile(i2).Life_Time
                                                .Projectile(i2).State = 1
                                                .Fuel_Mass -= 5
                                                .Xvec += .Projectile(i2).XVec*(.Projectile(i2).mass/(.Mass+.Fuel_Mass))
                                                .Yvec += .Projectile(i2).YVec*(.Projectile(i2).mass/(.Mass+.Fuel_Mass))
                                                Exit For
                                            End If
                                        Next
                                    End If
                                End If
                                Plr(i).Wait_Time(5) = Timer + Wait_Rate
                            End If
                        End If
                        
                    End If
                End With
                
                ''  Update vars
                
                For i2 = Lbound(.Ship) to Ubound(.Ship)
                  With .Ship(i2)
                    If .State = 1 Then
                      If .Shield.State = 1 Then
                          If .Fuel_mass >= 0.02 Then
                              .Fuel_Mass -= 0.02
                          Else
                              .Fuel_Mass = 0
                              .Shield.State = 0
                          End If
                      End If
                    End If
                  End With
                Next
                
                With .Dock
                  If .State = 1 Then
                    If .Shield.State = 1 Then
                        If .Fuel_mass >= 0.1 Then
                            .Fuel_Mass -= 0.1
                        Else
                            .Fuel_Mass = 0
                            .Shield.State = 0
                        End If
                    End If
                  End If
                End With
                
                ''  DRAW GRAPHICS
                
                ''  erase screen buffer
                Line .Scrn.Content, (0, 0)-(.Scrn.Wid, .Scrn.Hgt), 0, BF
                
                ''  erase menu buffer
                Line .Menu.Content, (0, 0)-(.Menu.Wid, .Menu.Hgt), .Menu.Col(1), BF
                
                ''  erase radar buffer 
                If .Radar.State <> 0 Then
                    If .Radar.State = 1 Then
                        .Radar.Object_X = Plr(i).Ship(Plr(i).Active).X
                        .Radar.Object_Y = Plr(i).Ship(Plr(i).Active).Y
                        Line .Radar.Content, (0, 0)-(.Radar.Wid, .Radar.Hgt), RGB(255, 0, 255), BF
                    ElseIf .Radar.State = 2 Then
                        Line .Radar.Content, (0, 0)-(.Radar.Wid, .Radar.Hgt), RGB(255, 0, 255), BF
                    ElseIf .Radar.State = 3 Then
                        .Radar.Object_X = Plr(i).Ship(Plr(i).Active).X
                        .Radar.Object_Y = Plr(i).Ship(Plr(i).Active).Y
                        Line .Radar.Content, (0, 0)-(.Radar.Wid, .Radar.Hgt), .Radar.Col(2), BF
                    ElseIf .Radar.State = 4 Then
                        Line .Radar.Content, (0, 0)-(.Radar.Wid, .Radar.Hgt), .Radar.Col(2), BF
                    End If
                End If
                
                ''  if screen style is 1 - rotate world relative to ship's position
                ''  this makes the ship appear as always beeing above center planet
                If .Scrn.Style = 1 Then
                    Pol(.Ship(.Active).X-Planet(1).X, .Ship(.Active).Y-Planet(1).Y)
                    .Scrn.Angle = -TPol+HalfPi
                    If .Scrn.Angle > Twopi Then .Scrn.Angle -= Twopi
                    If .Scrn.Angle < 0 Then .Scrn.Angle += Twopi
                    .Scrn.Sin_Ang = Sin(.Scrn.Angle)
                    .Scrn.Cos_Ang = Cos(.Scrn.Angle)
                End If
                
                ''  draw radiating lines in grid
                For i2 = 1 To Ubound(Radian)
                    Xpos = .Scrn.X_Mid+(.Scrn.Cos_Ang*(.Ship(.Active).X-Radian(i2).X1)-.Scrn.Sin_Ang*(.Ship(.Active).y-Radian(i2).Y1))
                    Ypos = .Scrn.Y_Mid+(.Scrn.Cos_Ang*(.Ship(.Active).Y-Radian(i2).Y1)+.Scrn.Sin_Ang*(.Ship(.Active).X-Radian(i2).X1))
                    Xpos2 = .Scrn.X_Mid+(.Scrn.Cos_Ang*(.Ship(.Active).X-Radian(i2).X2)-.Scrn.Sin_Ang*(.Ship(.Active).y-Radian(i2).Y2))
                    Ypos2 = .Scrn.Y_Mid+(.Scrn.Cos_Ang*(.Ship(.Active).Y-Radian(i2).Y2)+.Scrn.Sin_Ang*(.Ship(.Active).X-Radian(i2).X2))
                    Line .Scrn.Content, (Xpos, Ypos)-(Xpos2, Ypos2), Grid_color
                Next
                
                ''  draw concentric circles in grid
                For i2 = 1 to Ubound(Ellipse)
                    For i3 = 0 to Ellipse(i2).Num_Lines-1
                        Xdist = .Ship(.Active).X-Ellipse(i2).X(i3)
                        Ydist = .Ship(.Active).y-Ellipse(i2).y(i3)
                        Xdist2 = .Ship(.Active).X-Ellipse(i2).X(i3+1)
                        Ydist2 = .Ship(.Active).y-Ellipse(i2).y(i3+1)
                        Xpos = .Scrn.X_Mid+((.Scrn.Cos_Ang*Xdist)-(.Scrn.Sin_Ang*Ydist))
                        Ypos = .Scrn.Y_Mid+((.Scrn.Cos_Ang*Ydist)+(.Scrn.Sin_Ang*Xdist))
                        Xpos2 = .Scrn.X_Mid+((.Scrn.Cos_Ang*Xdist2)-(.Scrn.Sin_Ang*Ydist2))
                        Ypos2 = .Scrn.Y_Mid+((.Scrn.Cos_Ang*Ydist2)+(.Scrn.Sin_Ang*Xdist2))
                        Line .Scrn.Content, (Xpos, Ypos)-(Xpos2, Ypos2), Ellipse(i2).Col
                    Next
                Next
                
                ''  draw Plr's dock & ships to buffer
                For i2 = Lbound(Plr) to Ubound(Plr)
                    With Plr(i2)
                        With .Dock
                            ''  draw burst
                            For i4 = Lbound(.burst) to Ubound(.burst)
                                With .Burst(i4)
                                    If .State = 1 Then
                                        If .Life_TimeLeft >= 1 Then
                                            .Life_TimeLeft -= 1
                                            Col = .Life_TimeLeft/.Life_Time
                                            R = .R*col
                                            G = .G*col
                                            B = .B*col
                                            With Plr(i)
                                                Xdist = .Ship(.Active).X-Plr(i2).Dock.Burst(i4).X
                                                Ydist = .Ship(.Active).Y-Plr(i2).Dock.Burst(i4).Y
                                                Xpos = .Scrn.X_Mid+(.Scrn.Cos_Ang*Xdist)-(.Scrn.Sin_Ang*Ydist)
                                                Ypos = .Scrn.Y_Mid+(.Scrn.Cos_Ang*Ydist)+(.Scrn.Sin_Ang*Xdist)
                                                Pset .Scrn.Content, (Xpos, Ypos), RGB(R, G, B)
                                            End With
                                        Else
                                            .State = 0
                                        End If
                                    End If
                                End With
                            Next
                            If .State = 1 Then
                                With Plr(i)
                                    Xpos = (.Scrn.Cos_Ang*(.Ship(.Active).X-Plr(i2).Dock.X))-(.Scrn.Sin_Ang*(.Ship(.Active).Y-Plr(i2).Dock.Y))
                                    Ypos = (.Scrn.Cos_Ang*(.Ship(.Active).Y-Plr(i2).Dock.Y))+(.Scrn.Sin_Ang*(.Ship(.Active).X-Plr(i2).Dock.X))
                                    Xpos2 = .Scrn.X_Mid-Plr(i2).Dock.Radius+Xpos
                                    Ypos2 = .Scrn.Y_Mid-Plr(i2).Dock.Radius+Ypos
                                    DrawDock(i)
                                    Put .Scrn.Content, (Xpos2, Ypos2), Plr(i2).Dock.Sprite, Trans
                                    If .Radar.State <> 0 Then
                                        Xpos = (.Scrn.Cos_Ang*(.Radar.Object_X-Plr(i2).Dock.X))-(.Scrn.Sin_Ang*(.Radar.Object_Y-Plr(i2).Dock.Y))
                                        Ypos = (.Scrn.Cos_Ang*(.Radar.Object_Y-Plr(i2).Dock.Y))+(.Scrn.Sin_Ang*(.Radar.Object_X-Plr(i2).Dock.X))
                                        Xpos2 = .Radar.X_Mid+Xpos*.Radar.Zoom
                                        Ypos2 = .Radar.Y_Mid+Ypos*.Radar.Zoom
                                        Radius = Plr(i2).Dock.Radius*.Radar.Zoom
                                        Circle .Radar.Content, (Xpos2, Ypos2), Radius, Plr(i2).Col,,,1
                                    End If
                                End With
                            End If
                        End With
                        For i3 = Lbound(.Ship) to Ubound(.Ship)
                            With .Ship(i3)
                                ''  draw burst
                                For i4 = Lbound(.burst) to Ubound(.burst)
                                    With .Burst(i4)
                                        If .State = 1 Then
                                            If .Life_TimeLeft >= 1 Then
                                                .Life_TimeLeft -= 1
                                                Col = .Life_TimeLeft/.Life_Time
                                                R = .R*col
                                                G = .G*col
                                                B = .B*col
                                                With Plr(i)
                                                    Xpos = (.Scrn.Cos_Ang*(.Ship(.Active).X-Plr(i2).Ship(i3).Burst(i4).X))-(.Scrn.Sin_Ang*(.Ship(.Active).Y-Plr(i2).Ship(i3).Burst(i4).Y))
                                                    Ypos = (.Scrn.Cos_Ang*(.Ship(.Active).Y-Plr(i2).Ship(i3).Burst(i4).Y))+(.Scrn.Sin_Ang*(.Ship(.Active).X-Plr(i2).Ship(i3).Burst(i4).X))
                                                    Xpos2 = .Scrn.X_Mid+Xpos
                                                    Ypos2 = .Scrn.Y_Mid+Ypos
                                                    Pset .Scrn.Content, (Xpos2, Ypos2), RGB(R, G, B)
                                                End With
                                            Else
                                                .State = 0
                                            End If
                                        End If
                                    End With
                                Next
                                ''  draw projectiles
                                For i4 = Lbound(.Projectile) to Ubound(.Projectile)
                                    With .Projectile(i4)
                                        If .State = 1 Then
                                            If .Life_TimeLeft >= 1 Then
                                                .Life_TimeLeft -= 1
                                                If .Life_TimeLeft < 32 Then
                                                    R = .Life_Timeleft*8
                                                    G = R
                                                    B = R
                                                Else
                                                    R = .R
                                                    G = R
                                                    B = R
                                                End If
                                                With Plr(i)
                                                    Xpos = (.Scrn.Cos_Ang*(.Ship(.Active).X-Plr(i2).Ship(i3).Projectile(i4).X))-(.Scrn.Sin_Ang*(.Ship(.Active).Y-Plr(i2).Ship(i3).Projectile(i4).Y))
                                                    Ypos = (.Scrn.Cos_Ang*(.Ship(.Active).Y-Plr(i2).Ship(i3).Projectile(i4).Y))+(.Scrn.Sin_Ang*(.Ship(.Active).X-Plr(i2).Ship(i3).Projectile(i4).X))
                                                    Xpos2 = .Scrn.X_Mid+Xpos
                                                    Ypos2 = .Scrn.Y_Mid+Ypos
                                                Pset .Scrn.Content, (Xpos2, Ypos2), RGB(R, G, B)
                                                End With
                                            Else
                                                .State = 0
                                            End If
                                        End If
                                    End With
                                Next
                                ''  draw ship
                                If .State = 1 Then
                                    With Plr(i)
                                        ''  draw tractor-beam between ship and picked up Debris
                                        If Plr(i2).Ship(i3).Payload_State = 1 then
                                            Xdist = .Ship(.Active).X-Plr(i2).Ship(i3).X+Plr(i2).Ship(i3).X_dn
                                            Ydist = .Ship(.Active).Y-Plr(i2).Ship(i3).Y+Plr(i2).Ship(i3).Y_dn
                                            Xdist2 = .Ship(.Active).X-Emerald(Plr(i2).Ship(i3).Payload_Num).X
                                            Ydist2 = .Ship(.Active).Y-Emerald(Plr(i2).Ship(i3).Payload_Num).Y
                                            Xpos = .Scrn.X_Mid+(.Scrn.Cos_Ang*Xdist)-(.Scrn.Sin_Ang*Ydist)
                                            Ypos = .Scrn.Y_Mid+(.Scrn.Cos_Ang*Ydist)+(.Scrn.Sin_Ang*Xdist)
                                            Xpos2 = .Scrn.X_Mid+(.Scrn.Cos_Ang*Xdist2)-(.Scrn.Sin_Ang*Ydist2)
                                            Ypos2 = .Scrn.Y_Mid+(.Scrn.Cos_Ang*Ydist2)+(.Scrn.Sin_Ang*Xdist2)
                                            Line .Scrn.Content, (Xpos, Ypos)-(Xpos2, Ypos2), Rgb(96, 96, 144)
                                        End If
                                        
                                        ''  draw deflection shield
                                        If Plr(i2).Ship(i3).Shield.State = 1 Then
                                            Xdist = .Ship(.Active).X-Plr(i2).Ship(i3).X
                                            Ydist = .Ship(.Active).Y-Plr(i2).Ship(i3).Y
                                            Xpos = .Scrn.X_Mid+(.Scrn.Cos_Ang*Xdist)-(.Scrn.Sin_Ang*Ydist)
                                            Ypos = .Scrn.Y_Mid+(.Scrn.Cos_Ang*Ydist)+(.Scrn.Sin_Ang*Xdist)
                                            Circle .Scrn.Content, (Xpos+Rnd-Rnd, Ypos+Rnd-Rnd), Plr(i2).Ship(i3).Shield.Radius-2,  Rgb(64, 64, 96),,,1
                                            Circle .Scrn.Content, (Xpos+Rnd-Rnd, Ypos+Rnd-Rnd), Plr(i2).Ship(i3).Shield.Radius,  Rgb(96, 96, 144),,,1
                                        End If
                                        
                                        ''  draw ship
                                        Xdist = .Ship(.Active).X-Plr(i2).Ship(i3).X
                                        Ydist = .Ship(.Active).Y-Plr(i2).Ship(i3).Y
                                        Xpos = .Scrn.X_Mid-Plr(i2).Ship(i3).Radius+(.Scrn.Cos_Ang*Xdist)-(.Scrn.Sin_Ang*Ydist)
                                        Ypos = .Scrn.Y_Mid-Plr(i2).Ship(i3).Radius+(.Scrn.Cos_Ang*Ydist)+(.Scrn.Sin_Ang*Xdist)
                                        DrawShip (i2, i3, Plr(i2).Ship(i3).Angle-Plr(i).Scrn.Angle, Plr(i2).Ship(i3).Col)
                                        Put .Scrn.Content, (Xpos, Ypos), Plr(i2).Ship(i3).Sprite, Trans
                                        If .Radar.State <> 0 Then
                                            Xpos = (.Scrn.Cos_Ang*(.Radar.Object_X-Plr(i2).Ship(i3).X))-(.Scrn.Sin_Ang*(.Radar.Object_Y-Plr(i2).Ship(i3).Y))
                                            Ypos = (.Scrn.Cos_Ang*(.Radar.Object_Y-Plr(i2).Ship(i3).Y))+(.Scrn.Sin_Ang*(.Radar.Object_X-Plr(i2).Ship(i3).X))
                                            Xpos2 = .Radar.X_Mid+Xpos*.Radar.Zoom
                                            Ypos2 = .Radar.Y_Mid+Ypos*.Radar.Zoom
                                            Radius = Plr(i2).Ship(i3).Radius*.Radar.Zoom
                                            Circle .Radar.Content, (Xpos2, Ypos2), Radius, Plr(i2).Col,,,1,f
                                        End If
                                    End With
                                End If
                            End With
                        Next
                    End With
                Next
                
                ''  draw planets to buffer
                For i2 = Lbound(Planet)  To Ubound(Planet) 
                    With Planet(i2)
                        If .State = 1 Then
                            With Plr(i)
                                Xpos = (.Scrn.Cos_Ang*(.Ship(.Active).X-Planet(i2).X))-(.Scrn.Sin_Ang*(.Ship(.Active).Y-Planet(i2).Y))
                                Ypos = (.Scrn.Cos_Ang*(.Ship(.Active).Y-Planet(i2).Y))+(.Scrn.Sin_Ang*(.Ship(.Active).X-Planet(i2).X))
                                Xpos2 = .Scrn.X_Mid-Planet(i2).Radius+Xpos
                                Ypos2 = .Scrn.Y_Mid-Planet(i2).Radius+Ypos
                                Put .Scrn.Content, (Xpos2, Ypos2), Planet(i2).Sprite, Trans
                                If .Radar.State <> 0 Then
                                    Xdist = .Radar.Object_X-Planet(i2).X
                                    Ydist = .Radar.Object_Y-Planet(i2).Y
                                    Xpos = .Radar.X_Mid+((.Scrn.Cos_Ang*Xdist)-(.Scrn.Sin_Ang*Ydist))*.Radar.Zoom
                                    Ypos = .Radar.Y_Mid+((.Scrn.Cos_Ang*Ydist)+(.Scrn.Sin_Ang*Xdist))*.Radar.Zoom
                                    Radius = Planet(i2).Radius*.Radar.Zoom
                                    If Radius < 0.5 Then
                                        Pset .Radar.Content, (Xpos, Ypos), .Radar.Col(1)
                                    Else
                                        Circle .Radar.Content, (Xpos, Ypos), Radius, .Radar.Col(1),,,1,f
                                    End If
                                End If
                            End With
                        End If
                    End With
                Next
                
                ''  draw asteroids to buffer
                For i2 = Lbound(Asteroid)  To Ubound(Asteroid) 
                    With Asteroid(i2)
                        If .State = 1 Then 
                            With Plr(i)
                                If (Sgn(Asteroid(i2).X) = Sgn(.Ship(.Active).X) or _
                                Sgn(Asteroid(i2).Y) = Sgn(.Ship(.Active).Y)) Then
                                    Xdist = .Ship(.Active).X-Asteroid(i2).X
                                    If Abs(Xdist) < Scrn_X_Mid Then
                                        Ydist = .Ship(.Active).Y-Asteroid(i2).Y
                                        If Abs(Ydist) < Scrn_Y_Mid Then
                                            Xpos = .Scrn.X_Mid-Asteroid(i2).Radius+(.Scrn.Cos_Ang*Xdist)-(.Scrn.Sin_Ang*Ydist)
                                            Ypos = .Scrn.Y_Mid-Asteroid(i2).Radius+(.Scrn.Cos_Ang*Ydist)+(.Scrn.Sin_Ang*Xdist)
                                            Put .Scrn.Content, (Xpos, Ypos), Asteroid(i2).Sprite, Trans
                                        End If
                                    End If
                                End If
                                If .Radar.State <> 0 Then
                                    Xdist = .Radar.Object_X-Asteroid(i2).X
                                    Ydist = .Radar.Object_Y-Asteroid(i2).Y
                                    Xpos = .Radar.X_Mid+((.Scrn.Cos_Ang*Xdist)-(.Scrn.Sin_Ang*Ydist))*.Radar.Zoom
                                    Ypos = .Radar.Y_Mid+((.Scrn.Cos_Ang*Ydist)+(.Scrn.Sin_Ang*Xdist))*.Radar.Zoom
                                    Radius = Asteroid(i2).Radius*.Radar.Zoom
                                    If Radius < 0.5 Then
                                        Pset .Radar.Content, (Xpos, Ypos), .Radar.Col(1)
                                    Else
                                        Circle .Radar.Content, (Xpos, Ypos), Radius, .Radar.Col(1),,,1,f
                                    End If
                                End If
                            End With
                        End If
                    End With
                Next
                
                ''  draw emeralds to buffer
                For i2 = Lbound(Emerald)  To Ubound(Emerald) 
                    With Emerald(i2)
                        If .State = 1 Then
                            With Plr(i)
                                If (Sgn(Emerald(i2).X) = Sgn(.Ship(.Active).X) or _
                                Sgn(Emerald(i2).Y) = Sgn(.Ship(.Active).Y)) Then
                                    Xdist = .Ship(.Active).X-Emerald(i2).X
                                    If Abs(Xdist) < Scrn_X_Mid Then
                                        Ydist = .Ship(.Active).Y-Emerald(i2).Y
                                        If Abs(Ydist) < Scrn_Y_Mid Then
                                            Xpos = .Scrn.X_Mid-Emerald(i2).Radius+(.Scrn.Cos_Ang*Xdist)-(.Scrn.Sin_Ang*Ydist)
                                            Ypos = .Scrn.Y_Mid-Emerald(i2).Radius+(.Scrn.Cos_Ang*Ydist)+(.Scrn.Sin_Ang*Xdist)
                                            Put .Scrn.Content, (Xpos, Ypos), Emerald(i2).Sprite, Trans
                                            ''  draw blue circle around emerald when it's within reach of ships tracor beam
                                            If .Ship(.Active).State = 1 and .Ship(.Active).Payload_State = 0 Then
                                              If Abs(Xdist) < .Ship(.Active).Tractor_Mindist and _
                                                Abs(Ydist) < .Ship(.Active).Tractor_Mindist Then
                                                  Distance = Sqr(Xdist^2+Ydist^2)
                                                  If Distance < .Ship(.Active).Tractor_Mindist Then
                                                    Circle .Scrn.Content, (Xpos+Emerald(i2).Radius, Ypos+Emerald(i2).Radius), Emerald(i2).Radius+10,  Rgb(96, 96, 144),,,1
                                                  End If
                                              End If
                                            End If
                                        End If
                                    End If
                                End If
                                If .Radar.State <> 0 Then
                                    Xdist = .Radar.Object_X-Emerald(i2).X
                                    Ydist = .Radar.Object_Y-Emerald(i2).Y
                                    Xpos = .Radar.X_Mid+((.Scrn.Cos_Ang*Xdist)-(.Scrn.Sin_Ang*Ydist))*.Radar.Zoom
                                    Ypos = .Radar.Y_Mid+((.Scrn.Cos_Ang*Ydist)+(.Scrn.Sin_Ang*Xdist))*.Radar.Zoom
                                    Radius = Emerald(i2).Radius*.Radar.Zoom
                                    If Radius < 0.5 Then
                                        Pset .Radar.Content, (Xpos, Ypos), .Radar.Col(3)
                                    Else
                                        Circle .Radar.Content, (Xpos, Ypos), Radius, .Radar.Col(3),,,1,f
                                    End If
                                End If
                            End With
                        End If
                    End With
                Next
                
                With .Menu
                    
                    With Plr(i).Ship(Plr(i).Active)
                        Ypos = menu_hgt-((.Fuel_Mass/.Fuel_Max)*menu_Hgt)
                    End With
                    Line .Content, (0, Menu_Hgt)-(10, Ypos), RGB(192,0,0), bf
                    
                End With
                
                ''  draw screen buffer to screen
                Put (.Scrn.X, .Scrn.Y), .Scrn.Content, Pset
                
                ''  draw menu buffer to screen
                Put (.Menu.X, .Menu.Y), .Menu.Content, Pset
                
                ''  draw radar buffer to screen
                If .Radar.State <> 0 Then
                    If .Radar.State = 1 or .Radar.State = 2 Then
                        Put (.Radar.X, .Radar.Y), .Radar.Content, Alpha, .Radar.Alpha
                    ElseIf .Radar.State = 3 or .Radar.State = 4 Then
                        Put .Radar.Content, (0, 0), .Radar.Content_Border, trans
                        Paint .Radar.Content, (1,1), RGB(255, 0, 255), Rgb(64, 64, 64)
                        Paint .Radar.Content, (.Radar.Wid-1,1), RGB(255, 0, 255), Rgb(64, 64, 64)
                        Put (.Radar.X, .Radar.Y), .Radar.Content, Trans
                    End If
                End If
                    
            End With
        Next
        
        '' print data
        Color RGB(12, 72, 12), 0
        Locate 1, 1:    Print using " screen update (frames/sec): #####"; FPS
        Locate 2, 1:    Print using "  program speed (loops/sec): #####"; LPS
        Locate 3, 1:    Print using "   total number loops / sec: #####"; Total_LPS
        
        ''  flip screens and start all over...
        screenset page, page xor 1 
        page xor = 1 
        'Flip
        
    End If
    
Loop Until Multikey(1)

End

'' draw ship
Sub DrawShip (Byval Player as Ubyte, Byval Shp as Ubyte, Byval Angle as Single, _
    Byval Col as Single)
    
    dim Buffer as Ubyte Ptr = Plr(Player).Ship(Shp).Sprite
    dim head as Single = 0*Degtorad
    dim rght as Single = 228*Degtorad
    dim tail as Single = 180*Degtorad
    dim l3ft as Single = 132*Degtorad
    dim size as Single = 14
    dim oldx as Single
    dim oldy as Single
    dim x as Single = size
    dim Y as Single = size

    Line Buffer, (0, 0)-(2*size, 2*size), RGB(255,0,255), BF
    Rec (size, head-Angle)
    oldx = Xrec: oldy = Yrec
    Rec (size, rght-Angle)
    Line Buffer, (X+oldx, Y+oldy)-(X+Xrec, Y+Yrec), Col
    Rec (size*0.5, tail-Angle)
    Line Buffer, -(X+Xrec, Y+Yrec), Col
    Rec (size, l3ft-Angle)
    Line Buffer, -(X+Xrec, Y+Yrec), Col
    Line Buffer, -(X+oldx, Y+oldy), Col
    Paint Buffer, (X, Y), Col

End Sub

Sub DrawDock (Byval Player as Ubyte)
    
    dim Buffer as Ubyte Ptr = Plr(Player).Dock.Sprite
    dim radius as Single = Plr(Player).Dock.Radius
    dim Angle as Single = Plr(Player).Dock.Angle

    Line Buffer, (0, 0)-(2*radius, 2*radius), RGB(255,0,255), BF
    Color RGB(R, G, B)
    Circle Buffer, (radius, radius), radius/3, RGB(64, 64, 64),,,1,f
    If Plr(Player).Dock.Shield.State = 1 Then
        Circle Buffer, (radius, radius), Plr(Player).Dock.Shield.Radius-2+Rnd-Rnd,  Rgb(64, 64, 96),,,1
        Circle Buffer, (radius, radius), Plr(Player).Dock.Shield.Radius+Rnd-Rnd,  Rgb(96, 96, 144),,,1
    Else
      Circle Buffer, (radius, radius), Plr(Player).Dock.Shield.Radius,  Rgb(32, 32, 72),,,1
    End If
    Circle Buffer, (radius+Plr(Player).Dock.X_tr, radius+Plr(Player).Dock.Y_tr), 12, RGB(64, 64, 64),,,1,f
    Circle Buffer, (radius+Plr(Player).Dock.X_tl, radius+Plr(Player).Dock.Y_tl), 12, RGB(64, 64, 64),,,1,f
    Circle Buffer, (radius+Plr(Player).Dock.X_br, radius+Plr(Player).Dock.Y_br), 12, RGB(64, 64, 64),,,1,f
    Circle Buffer, (radius+Plr(Player).Dock.X_bl, radius+Plr(Player).Dock.Y_bl), 12, RGB(64, 64, 64),,,1,f
End Sub

