''                           DOGFIGHT IN SPACE
''                    (-the hunt for emerald asteroids)
''
''                                  by
''                           Michael S. Nissen
''                
''                          v. 1.00 - May 2006
''                          jernmager@yahoo.dk

Declare Sub Draw_Ellipse (Byval Buffer as Any Ptr = 0, ByVal cX As Single, ByVal cY As Single, ByVal Wid As Single, _
    ByVal Hgt As Single, ByVal angle As Single, byval col as integer, num_lines as Integer)

'Option Explicit

#include "Dogfight_in_Space_Simple.bi"

Dim Shared Player(1 to 2) as Player
Dim Shared Menu_scrn as Scrn
Dim Shared Scrn(1 to 2) as Scrn
Dim Shared Radar as Radar
Dim Shared Compass(1 to 2) as Compass

Dim Shared menu_col(1 to 3) as Col
Dim Shared radar_col(1 to 5) as Col
Dim Shared compass_col(1 to 5) as Col
Dim Shared debris_col as Col
Dim Shared emerald_col as Col

Dim Shared Planet(2) as Planet
Dim Shared Emerald(100) As Emerald
Dim Shared Ship(1 to 2) as Ship
Dim Shared Debris(300) as Debris

Dim shared Draw_Trajectory as Draw_Trajectory

Declare Sub DrawShip (Byval Buffer as Integer, Byval X as Double, Byval Y as Double, Byval Direction as Double, _
    Byval R as Integer, Byval G as Integer, Byval B as Integer)

Declare Sub DrawRocket (Byval Buffer as Integer, Byval X as Double, Byval Y as Double, Byval Direction as Double, _
    Byval R as Integer, Byval G as Integer, Byval B as Integer)

''  detect screen settings and apply them to the game
Screeninfo screen_x, screen_y,,,,Screen_Rate
'Screen_Rate = 40
'Screen_x = 800
'Screen_Y = 600
screenres screen_x, screen_y, 16, 2, 1


Screen_X_Mid = 0.5 * Screen_X
Screen_Y_Mid = 0.5 * Screen_Y

screen_update = 1/screen_rate
Wait_Rate = 2*screen_update
Turn_rate = 360/Screen_Rate

Menu_Wid = Screen_X
Menu_Hgt = (1/4)*Screen_Y
Border = 6

Loop_Rate = 80
Loop_update = 1/Loop_rate

Setmouse ,,0

Restart:

Randomize Timer

For i = Lbound(Player) to Ubound(Player)
    With Player(i)
        .Num_Ships = 5
    End With
Next

''  define screen buffers
With Menu_scrn
    .Wid = Menu_Wid
    .Hgt = Menu_Hgt
    .X = 0
    .Y =(Screen_Y-Menu_Hgt)
    .Content = ImageCreate(.Wid,.Hgt, RGB(40, 40, 40))
End With

With Scrn(1)
    .Wid = ((0.5*Screen_X)-(0.5*Border))
    .Hgt = (Screen_Y-Menu_Hgt)
    .X = 0
    .Y = 0
    .Zoom = 1
    .Screen_X_mid = 0.5*.Wid
    .Screen_Y_mid = 0.5*.Hgt
    .Content = ImageCreate(.Wid,.Hgt, 0)
End With

With Scrn(2)
    .Wid = ((0.5*Screen_X)-(0.5*Border))
    .Hgt = (Screen_Y-Menu_Hgt)
    .X = ((0.5*Screen_X)+(0.5*Border))
    .Y = 0
    .Zoom = 1
    .Screen_X_mid = 0.5*.Wid
    .Screen_Y_mid = 0.5*.Hgt
    .Content = ImageCreate(.Wid,.Hgt, 0)
End With

''  define celestial bodies & ships

'' Central Planet
With Planet(0)
    .state = 1
    .Mass = screen_update*7e15
    .Grav_Param = .mass*Spec_Grav
    .Radius = 700
    .Xvec = 0
    .Yvec = 0
    .R = 80
    .G = 48
    .B = 24
End With

'' Moon
With Planet(1)
    .state = 1
    .Orbit_Radius = Planet(0).Radius+4800
    .Angle = Rnd*(Pi*2)
    .X = Planet(0).X+.Orbit_Radius*Sin(.Angle) 
    .Y = Planet(0).Y+.Orbit_Radius*Cos(.Angle) 
    .Mass = Planet(0).Mass * 0.05
    .Grav_Param = .mass*Spec_Grav
    .Radius = 250
    .XVec = Planet(0).Xvec+sqr(Planet(0).Grav_Param/.Orbit_Radius)*Cos(.Angle)
    .YVec = Planet(0).Yvec+sqr(Planet(0).Grav_Param/.Orbit_Radius)*Sin(-.Angle) 
    .R = 72
    .G = 70
    .B = 68
End With 

'' Asteroid belt
For i = Lbound(Debris) To Ubound(Debris)
    With Debris(i) 
        .state = 1
        .Angle = Rnd*toxpi
        If Int(Rnd*2) = 0 Then
            .Orbit_Radius = Planet(0).Radius + 1800 + (Rnd*(300^(1/3)))^3
        Else
            .Orbit_Radius = Planet(0).Radius + 1800 - (Rnd*(300^(1/3)))^3
        End If
        .Mass = 500+(Rnd*(29500)^(1/3))^3
        .Density = 2.5+Rnd*5.5
        .Radius = ((.mass/.Density)/(4/3)*pi)^(1/3)
        .X = Planet(0).X+.Orbit_Radius*Sin(.Angle) 
        .Y = Planet(0).Y+.Orbit_Radius*Cos(.Angle) 
        .XVec = Planet(0).Xvec+sqr(Planet(0).Grav_Param/.Orbit_Radius)*Cos(.Angle)
        .YVec = Planet(0).Yvec+sqr(Planet(0).Grav_Param/.Orbit_Radius)*Sin(-.Angle)
        If Int(Rnd*16) = 0 Then 
            .XVec =- .XVec 
            .YVec =- .YVec 
        End If
        For i2 = Lbound(.Particle) to Ubound(.Particle)
            With .Particle(i2)
                .Speed = (Rnd*(3^(1/6)))^6
                .Direction = Rnd*(toxpi)
                .XVec = .Speed*Cos(.Direction)
                .YVec = .Speed*Sin(-.Direction)
                .State = 0
                .Time = 200+Rnd*50
                .R = 255
                .G = .R
                .B = .R
            End With
        Next
        .R = 56+Rnd*144
        .G = .R-28+Rnd*28
        .B = .G-28+Rnd*28
    End With 
Next 

''  Emeralds
For i = Lbound(Emerald)  To Ubound(Emerald) 
    With Emerald(i) 
        .state = 1
        .Angle = Planet(1).Angle + pi + (Rnd*0.25*pi) - (Rnd*0.25*pi)'Rnd*(toxpi)
'        If Int(Rnd*2) = 0 Then
'            .Orbit_Radius = Planet(0).Radius + 2400 + (Rnd*(50^(1/3)))^3
'        Else
'            .Orbit_Radius = Planet(0).Radius + 2400 - (Rnd*(50^(1/3)))^3
'        End If
        .Orbit_Radius = Planet(1).Orbit_Radius + (Rnd*400) - (Rnd*400)
        .Mass = 1500+(Rnd*(4500)^(1/3))^3
        .Density = 3+Rnd*2
        .Radius = (((.mass/.Density)/(4/3)*pi)^(1/3))
        .X = Planet(0).X+.Orbit_Radius*Sin(.Angle) 
        .Y = Planet(0).Y+.Orbit_Radius*Cos(.Angle) 
        .XVec = Planet(0).Xvec+sqr(Planet(0).Grav_Param/.Orbit_Radius)*Cos(.Angle)
        .YVec = Planet(0).Yvec+sqr(Planet(0).Grav_Param/.Orbit_Radius)*Sin(-.Angle)
'        If Int(Rnd*16) = 0 Then 
'            .XVec =- .XVec 
'            .YVec =- .YVec 
'        End If
        For i2 = Lbound(.Particle) to Ubound(.Particle)
            With .Particle(i2)
                .Speed = 5-(Rnd*(5^(1/6)))^6
                .Direction = Rnd*(toxpi)
                .XVec = .Speed*Cos(.Direction)
                .YVec = .Speed*Sin(-.Direction)
                .State = 0
                .Time = 50+Rnd*200
                .R = 239+(rnd*16-rnd*16)
                .G = 192+(rnd*16-rnd*16)
                .B = 240+(rnd*16-rnd*16)
            End With
        Next
        .R = 160+(rnd*56-rnd*56)
        .G = 56+(rnd*12-rnd*12)
        .B = 160+(rnd*56-rnd*56)
    End With 
Next 

''  define ships
With Ship(1)
    .Angle = -0
    .lft = 30
    .rgt = 32
    .fwd = 17
    .gun = 42
    .pck = 31
    .zoom_in = 16
    .zoom_out = 18
    .R = 116
    .G = 116
    .B = 144
End With 

With Ship(2)
    .Angle = Ship(1).Angle+pi
    .lft = 75
    .rgt = 77
    .fwd = 72
    .gun = 54
    .pck = 80
    .zoom_in = 51
    .zoom_out = 52
    .R = 144
    .G = 116
    .B = 116
End With 

For i = Lbound(Ship) To Ubound(Ship)
    With Ship(i)
        .state = 1
        .Orbit_Radius = Planet(0).Radius+3000
        .X = Planet(0).X+.Orbit_Radius*Sin(.Angle)
        .Y = Planet(0).Y+.Orbit_Radius*Cos(.Angle)
        .Fuel_Mass = 500
        .Mass = 500 + .Fuel_Mass
        .Direction = 90
        .Radius = 14
        .XVec = Planet(0).Xvec-sqr(Planet(0).Grav_Param/.Orbit_Radius)*Cos(.Angle)
        .YVec = Planet(0).Yvec-sqr(Planet(0).Grav_Param/.Orbit_Radius)*Sin(-.Angle)
        Rec (12, 245-.Direction)
        .Xrght = Xrec
        .Yrght = Yrec
        Rec (12, 115-.Direction)
        .Xl3ft = Xrec
        .Yl3ft = Yrec
        Rec (6, 180-.Direction)
        .Xburst = Xrec
        .Yburst = Yrec
        Rec (15, -.Direction)
        .Xgun = Xrec
        .Ygun = Yrec
        .Gun_type = 1
        .Shield_State = 0
        .Shield_Radius = 28
        .Payload_state = 0
        .Payload_mass = 0
        .Payload_num = -1
        For i2 = Lbound(.Burst) to Ubound(.Burst)
            With .Burst(i2)
                .Speed = screen_update*(20+Rnd*140)
                .State = 0
                .Time = 50
                .R = 255
                .G = 255
                .B = 255
            End With
        Next
        For i2 = Lbound(.Projectile) to Ubound(.Projectile)
            With .Projectile(i2)
                .Speed = 5
                .State = 0
                .Mass = 10
                .Time = 400
                .R = 255
                .G = 255
                .B = 255
            End With
        Next
        For i2 = Lbound(.Mine) to Ubound(.Mine)
            With .Mine(i2)
                .State = 0
                .Mass = 100
                .Radius = 6
                .warmup_Time = 400
                .Countdown_Time = 100
                .R = 80
                .G = 80
                .B = 80
                With .Beacon
                    .X = Ship(i).Mine(i2).X
                    .Y = Ship(i).Mine(i2).Y
                    .Radius = 2
                    .State = 1
                    .Trigger_Time = Ship(i).Mine(i2).Warmup_Time
                    .On_Time = 20
                    .Off_Time = 200
                    .FadeIn_Time = 20
                    .FadeOut_Time = 20
                    .R = 48
                    .G = 255
                    .B = 48
                End With
                For i3 = Lbound(.Particle) to Ubound(.Particle)
                    With .Particle(i3)
                    .Speed = 5-(Rnd*(5^(1/12)))^12
                    .Direction = Rnd*(toxpi)
                    .XVec = .Speed*Cos(.Direction)
                    .YVec = .Speed*Sin(-.Direction)
                    .State = 0
                    .Time = 50+Rnd*250
                    .R = 255
                    .G = 255
                    .B = 255
                    End With
                Next
            End With
        Next
        For i2 = Lbound(.Rocket) to Ubound(.Rocket)
            With .Rocket(i2)
                .State = 0
                .Mass = 50
                .Radius = 7
                .warmup_Time = 400
                .R = 96
                .G = 96
                .B = 96
                For i3 = Lbound(.Burst) to Ubound(.Burst)
                    With .Burst(i3)
                        .Speed = 0.15+Rnd*0.25
                        .State = 0
                        .Time = 60
                        .R = 255
                        .G = 255
                        .B = 255
                    End With
                Next
                For i3 = Lbound(.Particle) to Ubound(.Particle)
                    With .Particle(i3)
                        .Speed = 5-(Rnd*(5^(1/12)))^12
                        .Direction = Rnd*(toxpi)
                        .XVec = .Speed*Cos(.Direction)
                        .YVec = .Speed*Sin(-.Direction)
                        .State = 0
                        .Time = 50+Rnd*250
                        .R = 255
                        .G = 255
                        .B = 255
                    End With
                Next
            End With
        Next
        For i2 = Lbound(.Particle) to Ubound(.Particle)
            With .Particle(i2)
                .Speed = Rnd*5
                .Direction = Rnd*(toxpi)
                .XVec = .Speed*Cos(.Direction)
                .YVec = .Speed*Sin(-.Direction)
                .State = 0
                .Time = 50+Rnd*250
                .R = 255
                .G = 255
                .B = 255
            End With
        Next
    End With
Next

''  calculate reasonable background grid size
Distance = 0
For i = Lbound(Ship) to Ubound(Ship)
    If Ship(i).Orbit_Radius > Distance then Distance = Ship(i).Orbit_Radius
Next
For i = Lbound(Planet) to Ubound(Planet)
    If Planet(i).Orbit_Radius > Distance then Distance = Planet(i).Orbit_Radius
Next
For i = Lbound(Debris) to Ubound(Debris)
    If Debris(i).Orbit_Radius > Distance then Distance = Debris(i).Orbit_Radius
Next
For i = Lbound(Emerald) to Ubound(Emerald)
    If Emerald(i).Orbit_Radius > Distance then Distance = Emerald(i).Orbit_Radius
Next

Grid_color = Rgb(7, 42, 7)
Grid_Dist = (screen_y-menu_Hgt)
Grid_Num = (Distance/Grid_Dist)
Grid_Radius = Planet(0).Radius+(Grid_Num*Grid_Dist)

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
        .Wid = Planet(0).Radius+(i*Grid_Dist)
        .num_lines = 120+(Int((i/Ubound(Ellipse))*60)*4)
        For i2 = 0 To .Num_Lines
            Theta += Toxpi/Ellipse(i).Num_lines
            .X(i2) += .Wid * Cos(Theta) 
            .Y(i2) += .Wid * Sin(Theta)
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
        .X1 = -(Cos(Theta*i*radtodeg)*Grid_Radius)
        .Y1 = -(Sin(Theta*i*radtodeg)*Grid_Radius)
        .X2 = +(Cos(Theta*i*radtodeg)*Grid_Radius)
        .Y2 = +(Sin(Theta*i*radtodeg)*Grid_Radius)
    End With
Next
If Grid_Num > 2 Then
    i2 = i3+1
    i3 = i2+(360/Theta)
    For i = i2 to i3
        With Radian(i)
            .X1 = -(Cos(((Theta*i)+((1/2)*Theta))*radtodeg)*Grid_Radius)
            .Y1 = -(Sin(((Theta*i)+((1/2)*Theta))*radtodeg)*Grid_Radius)
            .X2 = -(Cos(((Theta*i)+((1/2)*Theta))*radtodeg)*(Planet(0).Radius+Grid_Dist*2))
            .Y2 = -(Sin(((Theta*i)+((1/2)*Theta))*radtodeg)*(Planet(0).Radius+Grid_Dist*2))
        End With
    Next
End If
If Grid_Num > 4 Then
    i2 = i3+1
    i3 = i2+(360/Theta)*2
    For i = i2 to i3
        With Radian(i)
            .X1 = -(Cos((((1/2)*Theta*i)+((1/4)*Theta))*radtodeg)*Grid_Radius)
            .Y1 = -(Sin((((1/2)*Theta*i)+((1/4)*Theta))*radtodeg)*Grid_Radius)
            .X2 = -(Cos((((1/2)*Theta*i)+((1/4)*Theta))*radtodeg)*(Planet(0).Radius+Grid_Dist*4))
            .Y2 = -(Sin((((1/2)*Theta*i)+((1/4)*Theta))*radtodeg)*(Planet(0).Radius+Grid_Dist*4))
        End With
    Next
End If
If Grid_Num > 8 Then
    i2 = i3+1
    i3 = i2 + (360/Theta)*4
    For i = i2 to i3
        With Radian(i)
            .X1 = -(Cos((((1/4)*Theta*i)+((1/8)*Theta))*radtodeg)*Grid_Radius)
            .Y1 = -(Sin((((1/4)*Theta*i)+((1/8)*Theta))*radtodeg)*Grid_Radius)
            .X2 = -(Cos((((1/4)*Theta*i)+((1/8)*Theta))*radtodeg)*(Planet(0).Radius+Grid_Dist*8))
            .Y2 = -(Sin((((1/4)*Theta*i)+((1/8)*Theta))*radtodeg)*(Planet(0).Radius+Grid_Dist*8))
        End With
    Next
End If
If Grid_Num > 16 Then
    i2 = i3+1
    i3 = i2 + (360/Theta)*8
    For i = i2 to i3
        With Radian(i)
            .X1 = -(Cos((((1/8)*Theta*i)+((1/16)*Theta))*radtodeg)*Grid_Radius)
            .Y1 = -(Sin((((1/8)*Theta*i)+((1/16)*Theta))*radtodeg)*Grid_Radius)
            .X2 = -(Cos((((1/8)*Theta*i)+((1/16)*Theta))*radtodeg)*(Planet(0).Radius+Grid_Dist*16))
            .Y2 = -(Sin((((1/8)*Theta*i)+((1/16)*Theta))*radtodeg)*(Planet(0).Radius+Grid_Dist*16))
        End With
    Next
End If
If Grid_Num > 32 Then
    i2 = i3+1
    i3 = i2 + (360/Theta)*16
    For i = i2 to i3
        With Radian(i)
            .X1 = -(Cos((((1/16)*Theta*i)+((1/32)*Theta))*radtodeg)*Grid_Radius)
            .Y1 = -(Sin((((1/16)*Theta*i)+((1/32)*Theta))*radtodeg)*Grid_Radius)
            .X2 = -(Cos((((1/16)*Theta*i)+((1/32)*Theta))*radtodeg)*(Planet(0).Radius+Grid_Dist*32))
            .Y2 = -(Sin((((1/16)*Theta*i)+((1/32)*Theta))*radtodeg)*(Planet(0).Radius+Grid_Dist*32))
        End With
    Next
End If

''  define radar and compasses
With Radar
    .Radius = Menu_hgt*0.9
    .Scale = .Radius/Grid_Radius
    .X = Screen_X * 0.5
    .Y = Screen_Y-(.Radius+1)
    .State = 1
    .Content = ImageCreate(2*.Radius, 2*.Radius)
    .Content_border = ImageCreate(2*.Radius, 2*.Radius, RGB(0, 0, 0))
    Circle .Content_Border, (.Radius, .Radius), .Radius, Rgb(64, 64, 64),,,1,F
    Circle .Content_Border, (.Radius, .Radius), .Radius-4, RGB(255, 0, 255),,,1, f
End With

With Compass(1)
    .Radius = (Menu_hgt * 0.5)-Border
    .X = .Radius+Border
    .Y = .Radius+Border
    .State = 1
End With

With Compass(2)
    .Radius = (Menu_hgt * 0.5)-Border
    .X = (Menu_Wid-.Radius)-Border
    .Y = .Radius+Border
    .State = 1
End With

'' Main program loop
Do
    
    ''  make sure body movement calculation & update always runs at same # of loops / second.
    If Timer >= last_program_loop Then 
        last_program_loop = Timer + loop_update
        
        ''  calculate loops per second
        If Timer < LPS_timer Then
            LPS_Counter += 1
        Else
            LPS = LPS_Counter
            LPS_Counter = 0
            LPS_Timer = Timer+1
            ''  fine-tune lps to always be equal to predefined loop rate
            If LPS < Loop_rate Then Loop_update -= 2e-5
            If LPS > Loop_rate Then Loop_update += 2e-5
        End If
        
        ''  calculate gravitational influence using the principles of Isaac Newton
        ''  (and a bit of collision detection)
        For i = Lbound(Planet) To Ubound(Planet)
            If Planet(i).State = 1 Then
                For i2 = i+1 To Ubound(Planet)
                    If Planet(i2).State = 1 Then
                        Xdist = Planet(i).X-Planet(i2).X
                        Ydist = Planet(i).Y-Planet(i2).Y
                        Dist_sqared = Xdist^2 + Ydist^2
                        Distance = sqr(Dist_sqared)
                        MinDist = Planet(i).Radius+Planet(i2).Radius
                        If Distance < MinDist then
                            Distance = MinDist
                        End If
                        If i <> 0 Then
                            G_imass = Planet(i2).Grav_Param/Dist_sqared
                            Planet(i).Xvec -= (Xdist/Distance)*G_imass
                            Planet(i).Yvec -= (Ydist/Distance)*G_imass
                        End If
                        G_i2mass = Planet(i).Grav_Param/Dist_sqared
                        Planet(i2).Xvec += (Xdist/Distance)*G_i2mass
                        Planet(i2).Yvec += (Ydist/Distance)*G_i2mass
                    End If
                Next
                For i2 = Lbound(Ship) To Ubound(Ship)
                    For i3 = Lbound(Ship(i2).Mine) to Ubound(Ship(i2).Mine)
                        If Ship(i2).Mine(i3).State = 1 Then
                            Xdist = Planet(i).X-Ship(i2).Mine(i3).X
                            Ydist = Planet(i).Y-Ship(i2).Mine(i3).Y
                            Dist_sqared = Xdist^2 + Ydist^2
                            Distance = sqr(Dist_sqared)
                            MinDist = Planet(i).Radius+Ship(i2).Mine(i3).Radius
                            If Distance < MinDist then
                                ship(i2).Mine(i3).Xvec += 5*((ship(i2).Mine(i3).x-Planet(i).x)/distance)/(ship(i2).Mine(i3).mass)
                                ship(i2).Mine(i3).Yvec += 5*((ship(i2).Mine(i3).y-Planet(i).y)/distance)/(ship(i2).Mine(i3).mass)
                                ship(i2).Mine(i3).Xvec += Planet(i).Xvec
                                ship(i2).Mine(i3).Yvec += Planet(i).Yvec
                            End If
                            G_i2mass = Planet(i).Grav_Param/Dist_sqared
                            Ship(i2).Mine(i3).Xvec += (Xdist/Distance)*G_i2mass
                            Ship(i2).Mine(i3).Yvec += (Ydist/Distance)*G_i2mass
                        End If
                    Next
                    For i3 = Lbound(Ship(i2).Rocket) to Ubound(Ship(i2).Rocket)
                        If Ship(i2).Rocket(i3).State = 1 Then
                            Xdist = Planet(i).X-Ship(i2).Rocket(i3).X
                            Ydist = Planet(i).Y-Ship(i2).Rocket(i3).Y
                            Dist_sqared = Xdist^2 + Ydist^2
                            Distance = sqr(Dist_sqared)
                            MinDist = Planet(i).Radius+Ship(i2).Rocket(i3).Radius
                            If Distance < MinDist then
                                Ship(i2).Rocket(i3).State = 0
                                Ship(i2).Rocket(i3).Explosion_state = 1
                                Ship(i2).Rocket(i3).Explosion_trigger = 1
                            End If
                            G_i2mass = Planet(i).Grav_Param/Dist_sqared
                            Ship(i2).Rocket(i3).Xvec += (Xdist/Distance)*G_i2mass
                            Ship(i2).Rocket(i3).Yvec += (Ydist/Distance)*G_i2mass
                        End If
                    Next
                    If Ship(i2).State = 1 Then
                        Xdist = Planet(i).X-Ship(i2).X
                        Ydist = Planet(i).Y-Ship(i2).Y
                        Dist_sqared = Xdist^2 + Ydist^2
                        Distance = sqr(Dist_sqared)
                        MinDist = Planet(i).Radius+Ship(i2).Radius
                        If Distance < MinDist then
                            ship(i2).Xvec *= 0.9
                            ship(i2).Yvec *= 0.9
                            ship(i2).Xvec += 100*((ship(i2).x-Planet(i).x)/distance)/(ship(i2).mass)
                            ship(i2).Yvec += 100*((ship(i2).y-Planet(i).y)/distance)/(ship(i2).mass)
                        End If
                        G_i2mass = Planet(i).Grav_Param/Dist_sqared
                        Ship(i2).Xvec += (Xdist/Distance)*G_i2mass
                        Ship(i2).Yvec += (Ydist/Distance)*G_i2mass
                    End If
                Next
                For i2 = Lbound(Debris) To Ubound(Debris)
                    If Debris(i2).State = 1 Then
                        Xdist = Planet(i).X-Debris(i2).X
                        Ydist = Planet(i).Y-Debris(i2).Y
                        Dist_sqared = Xdist^2 + Ydist^2
                        Distance = sqr(Dist_sqared)
                        MinDist = Planet(i).Radius+Debris(i2).Radius
                        If Distance < MinDist then
                            Debris(i2).State = 0
                            Debris(i2).Xvec = Planet(i).Xvec
                            Debris(i2).Yvec = Planet(i).Yvec
                            Debris(i2).Explosion_trigger = 1
                            Debris(i2).Explosion_state = 1
                        End If
                        G_i2mass = Planet(i).Grav_Param/Dist_sqared
                        Debris(i2).Xvec += (Xdist/Distance)*G_i2mass
                        Debris(i2).Yvec += (Ydist/Distance)*G_i2mass
                    End If
                Next
                For i2 = Lbound(Emerald) To Ubound(Emerald)
                    If Emerald(i2).State = 1 Then
                        Xdist = Planet(i).X-Emerald(i2).X
                        Ydist = Planet(i).Y-Emerald(i2).Y
                        Dist_sqared = Xdist^2 + Ydist^2
                        Distance = sqr(Dist_sqared)
                        MinDist = Planet(i).Radius+Emerald(i2).Radius
                        If Distance < MinDist then
                            Emerald(i2).State = 0
                            Emerald(i2).Xvec = Planet(i).Xvec
                            Emerald(i2).Yvec = Planet(i).Yvec
                            Emerald(i2).Explosion_trigger = 1
                            Emerald(i2).Explosion_state = 1
                            For i3 = Lbound(ship) to Ubound(ship)
                                If Ship(i3).Payload_num = i2 Then
                                    Ship(i3).Payload_state = 0
                                    Ship(i3).Payload_num = -1
                                    Ship(i3).Payload_Mass = 0
                                End If
                            Next
                        End If
                        G_i2mass = Planet(i).Grav_Param/Dist_sqared
                        Emerald(i2).Xvec += (Xdist/Distance)*G_i2mass
                        Emerald(i2).Yvec += (Ydist/Distance)*G_i2mass
                    End If
                Next
            End If
        Next
        
        ''  Brake stray ships down and bounce them back into battle area
        For i = Lbound(Ship) To Ubound(Ship)
            With Ship(i)
                If .State = 1 Then
                    Xdist = Planet(0).X-.X
                    Ydist = Planet(0).Y-.Y
                    Distance = sqr((Xdist^2) + (Ydist^2))
                    If Distance > Grid_Radius-.Radius Then
                        .Xvec *= 0.97
                        .Yvec *= 0.97
                        .Xvec += 3e-2*(Xdist/Distance)
                        .Yvec += 3e-2*(Ydist/Distance)
                    End If
                End If
            End With
        Next
        
        '' payload stuff
        For i = Lbound(Ship) to Ubound(Ship)
            With Ship(i)
                If .State = 1 Then
                    If .Payload_State = 1 Then
                        ''  force between ship and payload
                        Force = 2
                        Xdist = (.Xburst+.X)-Emerald(.Payload_Num).X
                        Ydist = (.Yburst+.Y)-Emerald(.Payload_Num).Y
                        Distance = sqr(Xdist^2 + Ydist^2)
                        .Xvec -= Force*(Xdist/Distance)*((Distance-70)/.Mass)
                        .Yvec -= Force*(Ydist/Distance)*((Distance-70)/.Mass)
                        Emerald(.Payload_Num).Xvec += Force*(Xdist/Distance)*((Distance-70)/Emerald(.Payload_Num).Mass)
                        Emerald(.Payload_Num).Yvec += Force*(Ydist/Distance)*((Distance-70)/Emerald(.Payload_Num).Mass)
                        
                        ''  is emerald delivered at home or not?
                        Xdist = Emerald(.Payload_Num).X-Planet(0).X
                        Ydist = Emerald(.Payload_Num).Y-Planet(0).Y
                        Distance = sqr(Xdist^2 + Ydist^2)
                        If Distance-Emerald(.Payload_Num).Radius <= Planet(0).Radius+250 Then 
                            Emerald(.Payload_Num).State = 0
                            .Payload_State xor = 1
                            .Payload_Mass = 0
                            .Fuel_Mass += Emerald(.Payload_Num).Mass/10 
                            If .Fuel_Mass > 1500 Then .Fuel_Mass = 1500
                            .Mass = .Fuel_Mass+500
                        End If
                    End If
                End If
            End With
        Next
        
        ''  ship deflection shield
        For i = Lbound(Ship) to Ubound(Ship)
            If Ship(i).State = 1 Then
                If Ship(i).Shield_State = 1 Then
                    For i2 = 0 to Ubound(Debris)
                        If Debris(i2).State = 1 Then
                            If (Sgn(Debris(i2).X) = Sgn(Ship(i).X) or _
                            Sgn(Debris(i2).Y) = Sgn(Ship(i).Y)) Then
                                MinDist = Ship(i).Shield_Radius+Debris(i2).Radius
                                Xdist = Ship(i).X-Debris(i2).X
                                If Xdist < MinDist Then
                                    Ydist = Ship(i).Y-Debris(i2).Y
                                    Distance = sqr(Xdist^2 + Ydist^2)
                                    If Distance < MinDist Then
                                        Shield_Strength = 150+(0.15*Debris(i2).Mass)
                                        Ship(i).Xvec += Shield_Strength*(Xdist/Distance)/Ship(i).Mass
                                        Ship(i).Yvec += Shield_Strength*(Ydist/Distance)/Ship(i).Mass
                                        Debris(i2).Xvec -= Shield_Strength*(Xdist/Distance)/Debris(i2).Mass
                                        Debris(i2).Yvec -= Shield_Strength*(Ydist/Distance)/Debris(i2).Mass
                                    End If
                                End If
                            End If
                        End If
                    Next
                    For i2 = 0 to Ubound(Emerald)
                        If Emerald(i2).State = 1 Then
                            Xdist = Ship(i).X-Emerald(i2).X
                            Ydist = Ship(i).Y-Emerald(i2).Y
                            Distance = sqr(Xdist^2 + Ydist^2)
                            If Distance < Ship(i).Shield_Radius+Emerald(i2).Radius Then
                                Shield_Strength = 150+(0.15*Emerald(i2).Mass)
                                Ship(i).Xvec += Shield_Strength*(Xdist/Distance)/Ship(i).Mass
                                Ship(i).Yvec += Shield_Strength*(Ydist/Distance)/Ship(i).Mass
                                Emerald(i2).Xvec -= Shield_Strength*(Xdist/Distance)/Emerald(i2).Mass
                                Emerald(i2).Yvec -= Shield_Strength*(Ydist/Distance)/Emerald(i2).Mass
                            End If
                        End If
                    Next
                    For i2 = Lbound(Ship) to Ubound(Ship)
                        If i2 <> i Then
                            If Ship(i2).State = 1 Then
                                Xdist = Ship(i).X-Ship(i2).X
                                Ydist = Ship(i).Y-Ship(i2).Y
                                Distance = sqr(Xdist^2 + Ydist^2)
                                If Ship(i).Shield_State = 1 Xor Ship(i2).Shield_State = 1 Then MinDist = Ship(i).Shield_Radius+Ship(i2).Radius
                                If Ship(i).Shield_State = 1 and Ship(i2).Shield_State = 1 Then MinDist = Ship(i).Shield_Radius+Ship(i2).Shield_Radius
                                If Distance <= MinDist Then
                                    Shield_Strength = 150+(0.15*Ship(i2).Mass)
                                    Ship(i).Xvec += Shield_Strength*(Xdist/Distance)/Ship(i).Mass
                                    Ship(i).Yvec += Shield_Strength*(Ydist/Distance)/Ship(i).Mass
                                    Ship(i2).Xvec -= Shield_Strength*(Xdist/Distance)/Ship(i2).Mass
                                    Ship(i2).Yvec -= Shield_Strength*(Ydist/Distance)/Ship(i2).Mass
                                End If
                            End If
                        End If
                        for i3 = 0 to Ubound(Ship(i2).Projectile)
                            If Ship(i2).Projectile(i3).State = 1 Then
                                If Ship(i2).Projectile(i3).timeleft < Ship(i2).Projectile(i3).time-6 Then
                                    Xdist = Ship(i).X-Ship(i2).Projectile(i3).X
                                    Ydist = Ship(i).Y-Ship(i2).Projectile(i3).Y
                                    Distance = sqr(Xdist^2 + Ydist^2)
                                    If Distance <= Ship(i).Shield_Radius Then
                                        Shield_Strength = 150+(0.15*Ship(i2).Projectile(i3).Mass)
                                        Ship(i).Xvec += Shield_Strength*(Xdist/Distance)/Ship(i).Mass
                                        Ship(i).Yvec += Shield_Strength*(Ydist/Distance)/Ship(i).Mass
                                        Ship(i2).Projectile(i3).Xvec += Shield_Strength*(Xdist/Distance)/Ship(i2).Projectile(i3).Mass
                                        Ship(i2).Projectile(i3).Yvec += Shield_Strength*(Ydist/Distance)/Ship(i2).Projectile(i3).Mass
                                    End If
                                End If
                            End If
                        Next
                    Next
                End If
            End If
        Next  
        
        ''  *temporary* Rocket autopilot
        For i = Lbound(Ship) to Ubound(Ship)
            For i2 = Lbound(Ship(i).Rocket) to Ubound(Ship(i).Rocket)
                With Ship(i).Rocket(i2)
                    If .State = 1 Then
'                        If .Warmup_Timeleft = 0 Then
'                            Pol ((.X-(.X+.Xvec)), (.Y-(.Y+.Yvec)))
'                            DegAdd (Tpol, 180)
'                            .Move_Direction = Deg
'                            Speed = sqr(.Xvec^2 + .Yvec^2)
'                            Pol (-Ship(.Target).X+.X, Ship(.Target).Y-.Y)
'                            If Tpol+180 < .Point_Direction Then
'                                DegSub (.Point_Direction, 0.3)
'                                .Point_Direction = Deg
'                            End If
'                            If Tpol+180 > .Point_Direction Then
'                                DegAdd (.Point_Direction, 0.3)
'                                .Point_Direction = Deg
'                            End If
'                        End If
                        .Xvec += 0.1*(Cos(.Point_Direction*Radtodeg)/.Mass)
                        .Yvec += 0.1*(Sin(-.Point_Direction*Radtodeg)/.Mass)
                    End If
                End With
            Next
        Next
        
        ''  Stage 1 Collision detection
        ''  ship - ship
        If Ship(1).State = 1 And Ship(2).State = 1 Then
            Xdist = Ship(1).X-Ship(2).X
            Ydist = Ship(1).Y-Ship(2).Y
            Distance = sqr((Xdist^2) + (Ydist^2))
            MinDist = Ship(1).Radius+Ship(2).Radius
            If Distance < MinDist then
                For i = Lbound(Ship) to Ubound(Ship)
                    Player(i).Num_ships -= 1
                    Player(i).Losses += 1
                    Ship(i).State = 0
                    Ship(i).Explosion_state = 1
                    Ship(i).Explosion_trigger = 1
                    Ship(i).Payload_state = 0
                    Ship(i).Payload_num = -1
                    Ship(i).Payload_mass = 0
                Next
            End If
        End If
        ''  Ship stuff
        For i = Lbound(Ship) To Ubound(Ship)
            If Ship(i).State = 1 Then
                ''ship - Debris
                For i2 = 0 to Ubound(Debris)
                    If Debris(i2).State = 1 Then
                        Xdist = Ship(i).X-Debris(i2).X
                        Ydist = Ship(i).Y-Debris(i2).Y
                        Distance = sqr((Xdist^2) + (Ydist^2))
                        MinDist = Ship(i).Radius+Debris(i2).Radius
                        If Distance < MinDist then
                            Player(i).Num_ships -= 1
                            Player(i).Losses += 1
                            Ship(i).State = 0
                            Ship(i).Explosion_state = 1
                            Ship(i).Explosion_trigger = 1
                            Ship(i).Payload_state = 0
                            Ship(i).Payload_num = -1
                            Ship(i).Payload_mass = 0
                            Debris(i2).State = 0
                            Debris(i2).Explosion_state = 1
                            Debris(i2).Explosion_trigger = 1
                        End If
                    End If
                Next
                ''  ship - emerald
                For i2 = 0 to Ubound(Emerald)
                    If Emerald(i2).State = 1 Then
                        Xdist = Emerald(i2).X-Ship(i).X
                        Ydist = Emerald(i2).Y-Ship(i).Y
                        Distance = sqr((Xdist^2) + (Ydist^2))
                        MinDist = Emerald(i2).Radius+Ship(i).Radius
                        If Distance < MinDist Then
                            Emerald(i2).Xvec += 30*(Xdist/Distance)/Emerald(i2).Mass
                            Emerald(i2).Yvec += 30*(Ydist/Distance)/Emerald(i2).Mass
                            Ship(i).Xvec -= 30*(Xdist/Distance)/Ship(i).Mass
                            Ship(i).Yvec -= 30*(Ydist/Distance)/Ship(i).Mass
                        End If   
                    End If
                Next
                For i2 = Lbound(Ship) To Ubound(Ship)
                    ''  ship - projectile
                    For i3 = 0 to Ubound(Ship(i2).Projectile)
                        If Ship(i2).Projectile(i3).State = 1 Then
                            Xdist = Ship(i).X-Ship(i2).Projectile(i3).X
                            Ydist = Ship(i).Y-Ship(i2).Projectile(i3).Y
                            Distance = sqr((Xdist^2) + (Ydist^2))
                            MinDist = Ship(i).Radius
                            If Distance < MinDist then
                                Player(i).Num_ships -= 1
                                Player(i).Losses += 1
                                Ship(i).State = 0
                                Ship(i).Payload_state = 0
                                Ship(i).Payload_num = -1
                                Ship(i).Payload_mass = 0
                                Ship(i).Explosion_state = 1
                                Ship(i).Explosion_trigger = 1
                                Ship(i2).Projectile(i3).State = 0
                            End If
                        End If
                    Next
                    ''  ship - mine
                    For i3 = Lbound(Ship(i2).Mine) to Ubound(Ship(i2).Mine)
                        With Ship(i2).Mine(i3)
                            If .State = 1 Then
                                If .Warmup_TimeLeft = 0 and .Trigger = 0 Then
                                    Xdist = Ship(i).X-.X
                                    Ydist = Ship(i).Y-.Y
                                    Distance = sqr((Xdist^2) + (Ydist^2))
                                    If Distance >= 200 Then
                                        .Beacon.On_Time = 20
                                        .Beacon.Off_Time = 200
                                        .Beacon.FadeIn_Time = 20
                                        .Beacon.FadeOut_Time = 20
                                        .Beacon.R = 48
                                        .Beacon.G = 255
                                        .Beacon.B = 48
                                    ElseIf Distance < 200 and Distance > 100 Then
                                        .Beacon.On_Time = 10
                                        .Beacon.Off_Time = 20
                                        .Beacon.FadeIn_Time = 10
                                        .Beacon.FadeOut_Time = 10
                                        .Beacon.R = 255
                                        .Beacon.G = 255
                                        .Beacon.B = 48
                                    ElseIf Distance <= 100 then
                                        .Trigger = 1 
                                        .Countdown_Timeleft = .Countdown_Time
                                    End If
                                End If
                            End If
                        End With
                    Next
                    ''  ship - rocket
                    For i3 = Lbound(Ship(i2).Rocket) to Ubound(Ship(i2).Rocket)
                        With Ship(i2).Rocket(i3)
                            If .State = 1 Then
                                If .Warmup_TimeLeft = 0 Then
                                    Xdist = Ship(i).X-.X
                                    Ydist = Ship(i).Y-.Y
                                    Distance = sqr((Xdist^2) + (Ydist^2))
                                    If Distance < Ship(i).Radius then
                                        Player(i).Num_ships -= 1
                                        Player(i).Losses += 1
                                        Ship(i).State = 0
                                        Ship(i).Payload_state = 0
                                        Ship(i).Payload_num = -1
                                        Ship(i).Payload_mass = 0
                                        Ship(i).Explosion_state = 1
                                        Ship(i).Explosion_trigger = 1
                                        .State = 0
                                        .Explosion_state = 1
                                        .Explosion_trigger = 1
                                    End If
                                End If
                            End If
                        End With
                    Next
                Next
                ''  Projectile stuff
                For i2 = 0 to Ubound(Ship(i).Projectile)
                    With Ship(i).Projectile(i2)
                        If .State = 1 Then
                            ''  Debris - projectile
                            For i3 = 0 to Ubound(Debris)
                                If Debris(i3).State = 1 Then
                                    Xdist = Debris(i3).X-.X
                                    Ydist = Debris(i3).Y-.Y
                                    Distance = sqr((Xdist^2) + (Ydist^2))
                                    MinDist = Debris(i3).Radius
                                    If Distance < MinDist Then
                                        Debris(i3).Xvec += 30*(Xdist/Distance)/Debris(i3).Mass
                                        Debris(i3).Yvec += 30*(Ydist/Distance)/Debris(i3).Mass
                                        .Xvec += 30*(Xdist/Distance)/.Mass
                                        .Yvec += 30*(Ydist/Distance)/.Mass
                                    End If   
                                End If
                            Next
                            ''  emerald - projectile
                            For i3 = 0 to Ubound(Emerald)
                                 If Emerald(i3).State = 1 Then
                                    Xdist = Emerald(i3).X-.X
                                    Ydist = Emerald(i3).Y-.Y
                                    Distance = sqr((Xdist^2) + (Ydist^2))
                                    MinDist = Emerald(i3).Radius
                                    If Distance < MinDist then
                                        Emerald(i3).State = 0
                                        Emerald(i3).Explosion_state = 1
                                        Emerald(i3).Explosion_trigger = 1
                                        .state = 0
                                        For i4 = Lbound(ship) to Ubound(ship)
                                            If Ship(i4).Payload_num = i3 Then
                                                Ship(i4).Payload_state = 0
                                                Ship(i4).Payload_num = -1
                                                Ship(i4).Payload_Mass = 0
                                            End If
                                        Next
                                    End If
                                End If
                            Next
                            ''  mine - projectile
                            For i3 = 0 to Ubound(Ship)
                                For i4 = 0 to Ubound(Ship(i3).Mine)
                                     If Ship(i3).Mine(i4).State = 1 Then
                                        Xdist = Ship(i3).Mine(i4).X-.X
                                        Ydist = Ship(i3).Mine(i4).Y-.Y
                                        Distance = sqr((Xdist^2) + (Ydist^2))
                                        MinDist = Ship(i3).Mine(i4).Radius
                                        If Distance < MinDist then
                                            Ship(i3).Mine(i4).State = 0
                                            Ship(i3).Mine(i4).Explosion_state = 1
                                            Ship(i3).Mine(i4).Explosion_trigger = 1
                                            .state = 0
                                        End If
                                    End If
                                Next
                            Next
                            ''  Rocket - projectile
                            For i3 = 0 to Ubound(Ship)
                                For i4 = 0 to Ubound(Ship(i3).Rocket)
                                     If Ship(i3).Rocket(i4).State = 1 Then
                                        Xdist = Ship(i3).Rocket(i4).X-.X
                                        Ydist = Ship(i3).Rocket(i4).Y-.Y
                                        Distance = sqr((Xdist^2) + (Ydist^2))
                                        MinDist = Ship(i3).Rocket(i4).Radius
                                        If Distance < MinDist then
                                            Ship(i3).Rocket(i4).State = 0
                                            Ship(i3).Rocket(i4).Explosion_state = 1
                                            Ship(i3).Rocket(i4).Explosion_trigger = 1
                                            .state = 0
                                        End If
                                    End If
                                Next
                            Next
                        End If
                    End With
                Next
                ''  Rocket stuff
                For i2 = 0 to Ubound(Ship(i).Rocket)
                    With Ship(i).Rocket(i2)
                        If .State = 1 Then
                            ''  Debris - Rocket
                            For i3 = 0 to Ubound(Debris)
                                If Debris(i3).State = 1 Then
                                    Xdist = Debris(i3).X-.X
                                    Ydist = Debris(i3).Y-.Y
                                    Distance = sqr((Xdist^2) + (Ydist^2))
                                    MinDist = Debris(i3).Radius+.Radius
                                    If Distance < MinDist Then
                                        .State = 0
                                        .Explosion_state = 1
                                        .Explosion_trigger = 1
                                    End If   
                                End If
                            Next
                            ''  emerald - Rocket
                            For i3 = 0 to Ubound(Emerald)
                                 If Emerald(i3).State = 1 Then
                                    Xdist = Emerald(i3).X-.X
                                    Ydist = Emerald(i3).Y-.Y
                                    Distance = sqr((Xdist^2) + (Ydist^2))
                                    MinDist = Emerald(i3).Radius+.Radius
                                    If Distance < MinDist then
                                        Emerald(i3).State = 0
                                        Emerald(i3).Explosion_state = 1
                                        Emerald(i3).Explosion_trigger = 1
                                        .State = 0
                                        .Explosion_state = 1
                                        .Explosion_trigger = 1
                                        For i4 = Lbound(ship) to Ubound(ship)
                                            If Ship(i4).Payload_num = i3 Then
                                                Ship(i4).Payload_state = 0
                                                Ship(i4).Payload_num = -1
                                                Ship(i4).Payload_Mass = 0
                                            End If
                                        Next
                                    End If
                                End If
                            Next
                            ''  mine - Rocket
                            For i3 = 0 to Ubound(Ship)
                                For i4 = 0 to Ubound(Ship(i3).Mine)
                                     If Ship(i3).Mine(i4).State = 1 Then
                                        Xdist = Ship(i3).Mine(i4).X-.X
                                        Ydist = Ship(i3).Mine(i4).Y-.Y
                                        Distance = sqr((Xdist^2) + (Ydist^2))
                                        MinDist = Ship(i3).Mine(i4).Radius+.Radius
                                        If Distance < MinDist then
                                            Ship(i3).Mine(i4).State = 0
                                            Ship(i3).Mine(i4).Explosion_state = 1
                                            Ship(i3).Mine(i4).Explosion_trigger = 1
                                            .State = 0
                                            .Explosion_state = 1
                                            .Explosion_trigger = 1
                                        End If
                                    End If
                                Next
                            Next
                            ''  Rocket - Rocket
                            For i3 = 0 to Ubound(Ship)
                                For i4 = 0 to Ubound(Ship(i3).Rocket)
                                     If Ship(i3).Rocket(i4).State = 1 Then
                                        Xdist = Ship(i3).Rocket(i4).X-.X
                                        Ydist = Ship(i3).Rocket(i4).Y-.Y
                                        Distance = sqr((Xdist^2) + (Ydist^2))
                                        MinDist = 0'.Radius
                                        If Distance < MinDist then
                                            Ship(i3).Rocket(i4).State = 0
                                            Ship(i3).Rocket(i4).Explosion_state = 1
                                            Ship(i3).Rocket(i4).Explosion_trigger = 1
                                            .State = 0
                                            .Explosion_state = 1
                                            .Explosion_trigger = 1
                                        End If
                                    End If
                                Next
                            Next
                        End If
                    End With
                Next
            End If
        Next
    
        ''  spawn particles on collision
        For i = Lbound(Ship) to Ubound(Ship)
            With Ship(i)
                If .Explosion_trigger = 1 Then
                    for i2 = 0 to Ubound(.Particle)
                        .Particle(i2).X = .X
                        .Particle(i2).Y = .Y
                        .Particle(i2).State = 1
                        .Particle(i2).TimeLeft = .Particle(i2).Time
                    Next
                End If
                For i2 = 0 to Ubound(.Mine)
                    If .Mine(i2).Explosion_trigger = 1 Then
                        for i3 = 0 to Ubound(.Mine(i2).Particle)
                            .Mine(i2).Particle(i3).X = .Mine(i2).X
                            .Mine(i2).Particle(i3).Y = .Mine(i2).Y
                            .Mine(i2).Particle(i3).State = 1
                            .Mine(i2).Particle(i3).TimeLeft = .Mine(i2).Particle(i3).Time
                        Next
                    End If
                Next
                For i2 = 0 to Ubound(.Rocket)
                    If .Rocket(i2).Explosion_trigger = 1 Then
                        for i3 = 0 to Ubound(.Rocket(i2).Particle)
                            .Rocket(i2).Particle(i3).X = .Rocket(i2).X
                            .Rocket(i2).Particle(i3).Y = .Rocket(i2).Y
                            .Rocket(i2).Particle(i3).State = 1
                            .Rocket(i2).Particle(i3).TimeLeft = .Rocket(i2).Particle(i3).Time
                        Next
                    End If
                Next
            End With
        Next
        For i = 0 to Ubound(Debris)
            With Debris(i)
                If .Explosion_trigger = 1 Then
                    for i2 = 0 to Ubound(.Particle)
                        .Particle(i2).X = .X
                        .Particle(i2).Y = .Y
                        .Particle(i2).State = 1
                        .Particle(i2).TimeLeft = .Particle(i2).Time
                    Next
                End If
            End With
        Next
        For i = 0 to Ubound(Emerald)
            With Emerald(i)
                If .Explosion_trigger = 1 Then
                    for i2 = 0 to Ubound(.Particle)
                        .Particle(i2).Speed = 0.4-(Rnd*(0.4^(1/8)))^8
                        .Particle(i2).X = .X
                        .Particle(i2).Y = .Y
                        .Particle(i2).State = 1
                        .Particle(i2).TimeLeft = .Particle(i2).Time
                    Next
                End If
            End With
        Next
        
        ''  calculate shock-wave's impact on other objects
        For i = Lbound(Ship) to Ubound(Ship)
            With Ship(i)
                If .Explosion_trigger = 1 Then
                    Shockwave_strength = 100*.Fuel_mass
                    For i2 = Lbound(Ship) to Ubound(Ship)
                        For i3 = 0 to Ubound(Ship(i2).Mine)
                            If Ship(i2).Mine(i3).State = 1 Then
                                Distance = sqr(((Ship(i2).Mine(i3).Y-.Y)^2) + ((Ship(i2).Mine(i3).X-.X)^2))
                                If Distance < 150 Then
                                    Ship(i2).Mine(i3).State = 0
                                    Ship(i2).Mine(i3).Explosion_state = 1
                                    Ship(i2).Mine(i3).Explosion_trigger = 1
                                Else
                                    Ship(i2).Mine(i3).Xvec += Shockwave_strength*((Ship(i2).Mine(i3).X-.X)/Distance)*((((Ship(i2).Mine(i3).Radius^2)*pi)/Distance^2)/Ship(i2).Mine(i3).Mass)
                                    Ship(i2).Mine(i3).Yvec += Shockwave_strength*((Ship(i2).Mine(i3).Y-.Y)/Distance)*((((Ship(i2).Mine(i3).Radius^2)*pi)/Distance^2)/Ship(i2).Mine(i3).Mass)
                                End If
                            End If
                        Next
                        For i3 = 0 to Ubound(Ship(i2).Rocket)
                            If Ship(i2).Rocket(i3).State = 1 Then
                                Distance = sqr(((Ship(i2).Rocket(i3).Y-.Y)^2) + ((Ship(i2).Rocket(i3).X-.X)^2))
                                If Distance < 150 Then
                                    Ship(i2).Rocket(i3).State = 0
                                    Ship(i2).Rocket(i3).Explosion_state = 1
                                    Ship(i2).Rocket(i3).Explosion_trigger = 1
                                Else
                                    Ship(i2).Rocket(i3).Xvec += Shockwave_strength*((Ship(i2).Rocket(i3).X-.X)/Distance)*((((Ship(i2).Rocket(i3).Radius^2)*pi)/Distance^2)/Ship(i2).Rocket(i3).Mass)
                                    Ship(i2).Rocket(i3).Yvec += Shockwave_strength*((Ship(i2).Rocket(i3).Y-.Y)/Distance)*((((Ship(i2).Rocket(i3).Radius^2)*pi)/Distance^2)/Ship(i2).Rocket(i3).Mass)
                                End If
                            End If
                        Next
                    Next
                    For i2 = 0 to Ubound(Debris)
                        If Debris(i2).State = 1 Then
                            Distance = sqr(((Debris(i2).Y-.Y)^2) + ((Debris(i2).X-.X)^2))
                            If Distance < 75 Then
                                Debris(i2).State = 0
                                Debris(i2).Explosion_state = 1
                                Debris(i2).Explosion_trigger = 1
                            Else
                                Debris(i2).Xvec += Shockwave_strength*((Debris(i2).X-.X)/Distance)*((((Debris(i2).Radius^2)*pi)/Distance^2)/Debris(i2).Mass)
                                Debris(i2).Yvec += Shockwave_strength*((Debris(i2).Y-.Y)/Distance)*((((Debris(i2).Radius^2)*pi)/Distance^2)/Debris(i2).Mass)
                            End If
                        End If
                    Next
                    For i2 = 0 to Ubound(Emerald)
                        If Emerald(i2).State = 1 Then
                            Distance = sqr(((Emerald(i2).Y-.Y)^2) + ((Emerald(i2).X-.X)^2))
                            If Distance < 75 Then
                                Emerald(i2).State = 0
                                Emerald(i2).Explosion_state = 1
                                Emerald(i2).Explosion_trigger = 1
                            Else
                                Emerald(i2).Xvec += Shockwave_strength*((Emerald(i2).X-.X)/Distance)*((((Emerald(i2).Radius^2)*pi)/Distance^2)/Emerald(i2).Mass)
                                Emerald(i2).Yvec += Shockwave_strength*((Emerald(i2).Y-.Y)/Distance)*((((Emerald(i2).Radius^2)*pi)/Distance^2)/Emerald(i2).Mass)
                            End If
                        End If
                    Next
                    For i2 = Lbound(Ship) to Ubound(Ship)
                        If Ship(i2).State = 1 Then
                            Distance = sqr(((Ship(i2).Y-.Y)^2) + ((Ship(i2).X-.X)^2))
                            If Distance < 75 Then
                                Ship(i2).State = 0
                                Ship(i2).Explosion_state = 1
                                Ship(i2).Explosion_trigger = 1
                            Else
                                Ship(i2).Xvec += Shockwave_strength*((Ship(i2).X-.X)/Distance)*((((Ship(i2).Radius^2)*pi)/Distance^2)/Ship(i2).Mass)
                                Ship(i2).Yvec += Shockwave_strength*((Ship(i2).Y-.Y)/Distance)*((((Ship(i2).Radius^2)*pi)/Distance^2)/Ship(i2).Mass)
                            End If
                        End If
                    Next
                    .Explosion_trigger = 0
                End If
            End With
        Next
        For i = 0 to Ubound(Debris)
            With Debris(i)
                If .Explosion_trigger = 1 Then
                    Shockwave_strength = 0.1*.mass
                    For i2 = Lbound(Ship) to Ubound(Ship)
                        For i3 = 0 to Ubound(Ship(i2).Mine)
                            If Ship(i2).Mine(i3).State = 1 Then
                                Distance = sqr(((Ship(i2).Mine(i3).Y-.Y)^2) + ((Ship(i2).Mine(i3).X-.X)^2))
                                If Distance < 150 Then
                                    Ship(i2).Mine(i3).State = 0
                                    Ship(i2).Mine(i3).Explosion_state = 1
                                    Ship(i2).Mine(i3).Explosion_trigger = 1
                                Else
                                    Ship(i2).Mine(i3).Xvec += Shockwave_strength*((Ship(i2).Mine(i3).X-.X)/Distance)*((((Ship(i2).Mine(i3).Radius^2)*pi)/Distance^2)/Ship(i2).Mine(i3).Mass)
                                    Ship(i2).Mine(i3).Yvec += Shockwave_strength*((Ship(i2).Mine(i3).Y-.Y)/Distance)*((((Ship(i2).Mine(i3).Radius^2)*pi)/Distance^2)/Ship(i2).Mine(i3).Mass)
                                End If
                            End If
                        Next
                        For i3 = 0 to Ubound(Ship(i2).Rocket)
                            If Ship(i2).Rocket(i3).State = 1 Then
                                Distance = sqr(((Ship(i2).Rocket(i3).Y-.Y)^2) + ((Ship(i2).Rocket(i3).X-.X)^2))
                                If Distance < 150 Then
                                    Ship(i2).Rocket(i3).State = 0
                                    Ship(i2).Rocket(i3).Explosion_state = 1
                                    Ship(i2).Rocket(i3).Explosion_trigger = 1
                                Else
                                    Ship(i2).Rocket(i3).Xvec += Shockwave_strength*((Ship(i2).Rocket(i3).X-.X)/Distance)*((((Ship(i2).Rocket(i3).Radius^2)*pi)/Distance^2)/Ship(i2).Rocket(i3).Mass)
                                    Ship(i2).Rocket(i3).Yvec += Shockwave_strength*((Ship(i2).Rocket(i3).Y-.Y)/Distance)*((((Ship(i2).Rocket(i3).Radius^2)*pi)/Distance^2)/Ship(i2).Rocket(i3).Mass)
                                End If
                            End If
                        Next
                    Next
                    For i2 = 0 to Ubound(Debris)
                        If Debris(i2).State = 1 Then
                            Distance = sqr(((Debris(i2).Y-.Y)^2) + ((Debris(i2).X-.X)^2))
                            If Distance < 25 Then
                                Debris(i2).State = 0
                                Debris(i2).Explosion_state = 1
                                Debris(i2).Explosion_trigger = 1
                            Else
                                Debris(i2).Xvec += Shockwave_strength*((Debris(i2).X-.X)/Distance)*((((Debris(i2).Radius^2)*pi)/Distance^2)/Debris(i2).Mass)
                                Debris(i2).Yvec += Shockwave_strength*((Debris(i2).Y-.Y)/Distance)*((((Debris(i2).Radius^2)*pi)/Distance^2)/Debris(i2).Mass)
                            End If
                        End If
                    Next
                    For i2 = 0 to Ubound(Emerald)
                        If Emerald(i2).State = 1 Then
                            Distance = sqr(((Emerald(i2).Y-.Y)^2) + ((Emerald(i2).X-.X)^2))
                            If Distance < 25 Then
                                Emerald(i2).State = 0
                                Emerald(i2).Explosion_state = 1
                                Emerald(i2).Explosion_trigger = 1
                            Else
                                Emerald(i2).Xvec += Shockwave_strength*((Emerald(i2).X-.X)/Distance)*((((Emerald(i2).Radius^2)*pi)/Distance^2)/Emerald(i2).Mass)
                                Emerald(i2).Yvec += Shockwave_strength*((Emerald(i2).Y-.Y)/Distance)*((((Emerald(i2).Radius^2)*pi)/Distance^2)/Emerald(i2).Mass)
                            End If
                        End If
                    Next
                    For i2 = Lbound(Ship) to Ubound(Ship)
                        If Ship(i2).State = 1 Then
                            Distance = sqr(((Ship(i2).Y-.Y)^2) + ((Ship(i2).X-.X)^2))
                            If Distance < 25 Then
                                Ship(i2).State = 0
                                Ship(i2).Explosion_state = 1
                                Ship(i2).Explosion_trigger = 1
                            Else
                                Ship(i2).Xvec += Shockwave_strength*((Ship(i2).X-.X)/Distance)*((((Ship(i2).Radius^2)*pi)/Distance^2)/Ship(i2).Mass)
                                Ship(i2).Yvec += Shockwave_strength*((Ship(i2).Y-.Y)/Distance)*((((Ship(i2).Radius^2)*pi)/Distance^2)/Ship(i2).Mass)
                            End If
                        End If
                    Next
                    .Explosion_trigger = 0
                End If
            End With
        Next
        For i = 0 to Ubound(Emerald)
            With Emerald(i)
                If .Explosion_trigger = 1 Then
                    Shockwave_strength = 10*.mass
                    For i2 = Lbound(Ship) to Ubound(Ship)
                        For i3 = 0 to Ubound(Ship(i2).Mine)
                            If Ship(i2).Mine(i3).State = 1 Then
                                Distance = sqr(((Ship(i2).Mine(i3).Y-.Y)^2) + ((Ship(i2).Mine(i3).X-.X)^2))
                                If Distance < 150 Then
                                    Ship(i2).Mine(i3).State = 0
                                    Ship(i2).Mine(i3).Explosion_state = 1
                                    Ship(i2).Mine(i3).Explosion_trigger = 1
                                Else
                                    Ship(i2).Mine(i3).Xvec += Shockwave_strength*((Ship(i2).Mine(i3).X-.X)/Distance)*((((Ship(i2).Mine(i3).Radius^2)*pi)/Distance^2)/Ship(i2).Mine(i3).Mass)
                                    Ship(i2).Mine(i3).Yvec += Shockwave_strength*((Ship(i2).Mine(i3).Y-.Y)/Distance)*((((Ship(i2).Mine(i3).Radius^2)*pi)/Distance^2)/Ship(i2).Mine(i3).Mass)
                                End If
                            End If
                        Next
                        For i3 = 0 to Ubound(Ship(i2).Rocket)
                            If Ship(i2).Rocket(i3).State = 1 Then
                                Distance = sqr(((Ship(i2).Rocket(i3).Y-.Y)^2) + ((Ship(i2).Rocket(i3).X-.X)^2))
                                If Distance < 150 Then
                                    Ship(i2).Rocket(i3).State = 0
                                    Ship(i2).Rocket(i3).Explosion_state = 1
                                    Ship(i2).Rocket(i3).Explosion_trigger = 1
                                Else
                                    Ship(i2).Rocket(i3).Xvec += Shockwave_strength*((Ship(i2).Rocket(i3).X-.X)/Distance)*((((Ship(i2).Rocket(i3).Radius^2)*pi)/Distance^2)/Ship(i2).Rocket(i3).Mass)
                                    Ship(i2).Rocket(i3).Yvec += Shockwave_strength*((Ship(i2).Rocket(i3).Y-.Y)/Distance)*((((Ship(i2).Rocket(i3).Radius^2)*pi)/Distance^2)/Ship(i2).Rocket(i3).Mass)
                                End If
                            End If
                        Next
                    Next
                    For i2 = 0 to Ubound(Debris)
                        If Debris(i2).State = 1 Then
                            Distance = sqr(((Debris(i2).Y-.Y)^2) + ((Debris(i2).X-.X)^2))
                            If Distance < 50 Then
                                Debris(i2).State = 0
                                Debris(i2).Explosion_state = 1
                                Debris(i2).Explosion_trigger = 1
                            Else
                                Debris(i2).Xvec += Shockwave_strength*((Debris(i2).X-.X)/Distance)*((((Debris(i2).Radius^2)*pi)/Distance^2)/Debris(i2).Mass)
                                Debris(i2).Yvec += Shockwave_strength*((Debris(i2).Y-.Y)/Distance)*((((Debris(i2).Radius^2)*pi)/Distance^2)/Debris(i2).Mass)
                            End If
                        End If
                    Next
                    For i2 = 0 to Ubound(Emerald)
                        If Emerald(i2).State = 1 Then
                            Distance = sqr(((Emerald(i2).Y-.Y)^2) + ((Emerald(i2).X-.X)^2))
                            If Distance < 50 Then
                                Emerald(i2).State = 0
                                Emerald(i2).Explosion_state = 1
                                Emerald(i2).Explosion_trigger = 1
                            Else
                                Emerald(i2).Xvec += Shockwave_strength*((Emerald(i2).X-.X)/Distance)*((((Emerald(i2).Radius^2)*pi)/Distance^2)/Emerald(i2).Mass)
                                Emerald(i2).Yvec += Shockwave_strength*((Emerald(i2).Y-.Y)/Distance)*((((Emerald(i2).Radius^2)*pi)/Distance^2)/Emerald(i2).Mass)
                            End If
                        End If
                    Next
                    For i2 = Lbound(Ship) to Ubound(Ship)
                        If Ship(i2).State = 1 Then
                            Distance = sqr(((Ship(i2).Y-.Y)^2) + ((Ship(i2).X-.X)^2))
                            If Distance < 50 Then
                                Ship(i2).State = 0
                                Ship(i2).Explosion_state = 1
                                Ship(i2).Explosion_trigger = 1
                            Else
                                Ship(i2).Xvec += Shockwave_strength*((Ship(i2).X-.X)/Distance)*((((Ship(i2).Radius^2)*pi)/Distance^2)/Ship(i2).Mass)
                                Ship(i2).Yvec += Shockwave_strength*((Ship(i2).Y-.Y)/Distance)*((((Ship(i2).Radius^2)*pi)/Distance^2)/Ship(i2).Mass)
                            End If
                        End If
                    Next
                    .Explosion_trigger = 0
                End If
            End With
        Next
        For i = Lbound(Ship) to Ubound(Ship)
            For i2 = 0 to Ubound(Ship(i).Mine)
                With Ship(i).Mine(i2)
                    If .Explosion_trigger = 1 Then
                        Shockwave_strength = 500*.mass
                        For i2 = Lbound(Ship) to Ubound(Ship)
                            For i3 = 0 to Ubound(Ship(i2).Mine)
                                If Ship(i2).Mine(i3).State = 1 Then
                                    Distance = sqr(((Ship(i2).Mine(i3).Y-.Y)^2) + ((Ship(i2).Mine(i3).X-.X)^2))
                                    If Distance < 150 Then
                                        Ship(i2).Mine(i3).State = 0
                                        Ship(i2).Mine(i3).Explosion_state = 1
                                        Ship(i2).Mine(i3).Explosion_trigger = 1
                                    Else
                                        Ship(i2).Mine(i3).Xvec += Shockwave_strength*((Ship(i2).Mine(i3).X-.X)/Distance)*((((Ship(i2).Mine(i3).Radius^2)*pi)/Distance^2)/Ship(i2).Mine(i3).Mass)
                                        Ship(i2).Mine(i3).Yvec += Shockwave_strength*((Ship(i2).Mine(i3).Y-.Y)/Distance)*((((Ship(i2).Mine(i3).Radius^2)*pi)/Distance^2)/Ship(i2).Mine(i3).Mass)
                                    End If
                                End If
                            Next
                            For i3 = 0 to Ubound(Ship(i2).Rocket)
                                If Ship(i2).Rocket(i3).State = 1 Then
                                    Distance = sqr(((Ship(i2).Rocket(i3).Y-.Y)^2) + ((Ship(i2).Rocket(i3).X-.X)^2))
                                    If Distance < 150 Then
                                        Ship(i2).Rocket(i3).State = 0
                                        Ship(i2).Rocket(i3).Explosion_state = 1
                                        Ship(i2).Rocket(i3).Explosion_trigger = 1
                                    Else
                                        Ship(i2).Rocket(i3).Xvec += Shockwave_strength*((Ship(i2).Rocket(i3).X-.X)/Distance)*((((Ship(i2).Rocket(i3).Radius^2)*pi)/Distance^2)/Ship(i2).Rocket(i3).Mass)
                                        Ship(i2).Rocket(i3).Yvec += Shockwave_strength*((Ship(i2).Rocket(i3).Y-.Y)/Distance)*((((Ship(i2).Rocket(i3).Radius^2)*pi)/Distance^2)/Ship(i2).Rocket(i3).Mass)
                                    End If
                                End If
                            Next
                        Next
                        For i2 = 0 to Ubound(Debris)
                            If Debris(i2).State = 1 Then
                                Distance = sqr(((Debris(i2).Y-.Y)^2) + ((Debris(i2).X-.X)^2))
                                If Distance < 150 Then
                                    Debris(i2).State = 0
                                    Debris(i2).Explosion_state = 1
                                    Debris(i2).Explosion_trigger = 1
                                Else
                                    Debris(i2).Xvec += Shockwave_strength*((Debris(i2).X-.X)/Distance)*((((Debris(i2).Radius^2)*pi)/Distance^2)/Debris(i2).Mass)
                                    Debris(i2).Yvec += Shockwave_strength*((Debris(i2).Y-.Y)/Distance)*((((Debris(i2).Radius^2)*pi)/Distance^2)/Debris(i2).Mass)
                                End If
                            End If
                        Next
                        For i2 = 0 to Ubound(Emerald)
                            If Emerald(i2).State = 1 Then
                                Distance = sqr(((Emerald(i2).Y-.Y)^2) + ((Emerald(i2).X-.X)^2))
                                If Distance < 150 Then
                                    Emerald(i2).State = 0
                                    Emerald(i2).Explosion_state = 1
                                    Emerald(i2).Explosion_trigger = 1
                                Else
                                    Emerald(i2).Xvec += Shockwave_strength*((Emerald(i2).X-.X)/Distance)*((((Emerald(i2).Radius^2)*pi)/Distance^2)/Emerald(i2).Mass)
                                    Emerald(i2).Yvec += Shockwave_strength*((Emerald(i2).Y-.Y)/Distance)*((((Emerald(i2).Radius^2)*pi)/Distance^2)/Emerald(i2).Mass)
                                End If
                            End If
                        Next
                        For i2 = Lbound(Ship) to Ubound(Ship)
                            If Ship(i2).State = 1 Then
                                Distance = sqr(((Ship(i2).Y-.Y)^2) + ((Ship(i2).X-.X)^2))
                                If Distance < 150 Then
                                    Ship(i2).State = 0
                                    Ship(i2).Explosion_state = 1
                                    Ship(i2).Explosion_trigger = 1
                                Else
                                    Ship(i2).Xvec += Shockwave_strength*((Ship(i2).X-.X)/Distance)*((((Ship(i2).Radius^2)*pi)/Distance^2)/Ship(i2).Mass)
                                    Ship(i2).Yvec += Shockwave_strength*((Ship(i2).Y-.Y)/Distance)*((((Ship(i2).Radius^2)*pi)/Distance^2)/Ship(i2).Mass)
                                End If
                            End If
                        Next
                        .Explosion_trigger = 0
                    End If
                End With
            Next
        Next
        For i = Lbound(Ship) to Ubound(Ship)
            For i2 = 0 to Ubound(Ship(i).Rocket)
                With Ship(i).Rocket(i2)
                    If .Explosion_trigger = 1 Then
                        Shockwave_strength = 500*.mass
                        For i2 = Lbound(Ship) to Ubound(Ship)
                            For i3 = 0 to Ubound(Ship(i2).Mine)
                                If Ship(i2).Mine(i3).State = 1 Then
                                    Distance = sqr(((Ship(i2).Mine(i3).Y-.Y)^2) + ((Ship(i2).Mine(i3).X-.X)^2))
                                    If Distance < 150 Then
                                        Ship(i2).Mine(i3).State = 0
                                        Ship(i2).Mine(i3).Explosion_state = 1
                                        Ship(i2).Mine(i3).Explosion_trigger = 1
                                    Else
                                        Ship(i2).Mine(i3).Xvec += Shockwave_strength*((Ship(i2).Mine(i3).X-.X)/Distance)*((((Ship(i2).Mine(i3).Radius^2)*pi)/Distance^2)/Ship(i2).Mine(i3).Mass)
                                        Ship(i2).Mine(i3).Yvec += Shockwave_strength*((Ship(i2).Mine(i3).Y-.Y)/Distance)*((((Ship(i2).Mine(i3).Radius^2)*pi)/Distance^2)/Ship(i2).Mine(i3).Mass)
                                    End If
                                End If
                            Next
                            For i3 = 0 to Ubound(Ship(i2).Rocket)
                                If Ship(i2).Rocket(i3).State = 1 Then
                                    Distance = sqr(((Ship(i2).Rocket(i3).Y-.Y)^2) + ((Ship(i2).Rocket(i3).X-.X)^2))
                                    If Distance < 150 Then
                                        Ship(i2).Rocket(i3).State = 0
                                        Ship(i2).Rocket(i3).Explosion_state = 1
                                        Ship(i2).Rocket(i3).Explosion_trigger = 1
                                    Else
                                        Ship(i2).Rocket(i3).Xvec += Shockwave_strength*((Ship(i2).Rocket(i3).X-.X)/Distance)*((((Ship(i2).Rocket(i3).Radius^2)*pi)/Distance^2)/Ship(i2).Rocket(i3).Mass)
                                        Ship(i2).Rocket(i3).Yvec += Shockwave_strength*((Ship(i2).Rocket(i3).Y-.Y)/Distance)*((((Ship(i2).Rocket(i3).Radius^2)*pi)/Distance^2)/Ship(i2).Rocket(i3).Mass)
                                    End If
                                End If
                            Next
                        Next
                        For i2 = 0 to Ubound(Debris)
                            If Debris(i2).State = 1 Then
                                Distance = sqr(((Debris(i2).Y-.Y)^2) + ((Debris(i2).X-.X)^2))
                                If Distance < 150 Then
                                    Debris(i2).State = 0
                                    Debris(i2).Explosion_state = 1
                                    Debris(i2).Explosion_trigger = 1
                                Else
                                    Debris(i2).Xvec += Shockwave_strength*((Debris(i2).X-.X)/Distance)*((((Debris(i2).Radius^2)*pi)/Distance^2)/Debris(i2).Mass)
                                    Debris(i2).Yvec += Shockwave_strength*((Debris(i2).Y-.Y)/Distance)*((((Debris(i2).Radius^2)*pi)/Distance^2)/Debris(i2).Mass)
                                End If
                            End If
                        Next
                        For i2 = 0 to Ubound(Emerald)
                            If Emerald(i2).State = 1 Then
                                Distance = sqr(((Emerald(i2).Y-.Y)^2) + ((Emerald(i2).X-.X)^2))
                                If Distance < 150 Then
                                    Emerald(i2).State = 0
                                    Emerald(i2).Explosion_state = 1
                                    Emerald(i2).Explosion_trigger = 1
                                Else
                                    Emerald(i2).Xvec += Shockwave_strength*((Emerald(i2).X-.X)/Distance)*((((Emerald(i2).Radius^2)*pi)/Distance^2)/Emerald(i2).Mass)
                                    Emerald(i2).Yvec += Shockwave_strength*((Emerald(i2).Y-.Y)/Distance)*((((Emerald(i2).Radius^2)*pi)/Distance^2)/Emerald(i2).Mass)
                                End If
                            End If
                        Next
                        For i2 = Lbound(Ship) to Ubound(Ship)
                            If Ship(i2).State = 1 Then
                                Distance = sqr(((Ship(i2).Y-.Y)^2) + ((Ship(i2).X-.X)^2))
                                If Distance < 150 Then
                                    Ship(i2).State = 0
                                    Ship(i2).Explosion_state = 1
                                    Ship(i2).Explosion_trigger = 1
                                Else
                                    Ship(i2).Xvec += Shockwave_strength*((Ship(i2).X-.X)/Distance)*((((Ship(i2).Radius^2)*pi)/Distance^2)/Ship(i2).Mass)
                                    Ship(i2).Yvec += Shockwave_strength*((Ship(i2).Y-.Y)/Distance)*((((Ship(i2).Radius^2)*pi)/Distance^2)/Ship(i2).Mass)
                                End If
                            End If
                        Next
                        .Explosion_trigger = 0
                    End If
                End With
            Next
        Next
        
        ''  update body movement
        For i = 1 To Ubound(Planet)
            With Planet(i)
                If .State = 1 Then
                    .Xold = .X
                    .Yold = .Y
                    .X += .XVec 
                    .Y += .YVec
                End If
            End With
        Next
        For i = Lbound(Debris) To Ubound(Debris)
            With Debris(i)
                If .State = 1 Then
                    .X += .XVec 
                    .Y += .YVec
                Else
                    If .Explosion_state = 1 Then
                        For i2 = Lbound(.Particle) To Ubound(.Particle)
                            If .Particle(i2).State = 1 Then
                                .Particle(i2).X -= .Particle(i2).Xvec
                                .Particle(i2).Y -= .Particle(i2).Yvec
                            End If
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
                            If .Particle(i2).State = 1 Then
                                .Particle(i2).X -= .Particle(i2).Xvec
                                .Particle(i2).Y -= .Particle(i2).Yvec
                            End If
                        Next
                    End If
                End If 
            End With
        Next
        For i = Lbound(Ship) To Ubound(Ship)
            With Ship(i)
                If .State = 1 Then
                    .Xold = .X
                    .Yold = .Y
                    .X += .XVec
                    .Y += .YVec
                    For i2 = Lbound(.Burst) To Ubound(.Burst)
                        If .Burst(i2).State = 1 Then
                            .Burst(i2).X -= .Burst(i2).Xvec
                            .Burst(i2).Y -= .Burst(i2).Yvec
                        End If
                    Next
                Else
                    If .Explosion_state = 1 Then
                        For i2 = Lbound(.Particle) To Ubound(.Particle)
                            If .Particle(i2).State = 1 Then
                                .Particle(i2).X -= .Particle(i2).Xvec
                                .Particle(i2).Y -= .Particle(i2).Yvec
                            End If
                        Next
                    End If
                End If
                For i2 = Lbound(.Projectile) to Ubound(.Projectile)
                    If .Projectile(i2).State = 1 Then
                        .Projectile(i2).X -= .Projectile(i2).Xvec
                        .Projectile(i2).Y -= .Projectile(i2).Yvec
                    End If
                Next
                For i2 = Lbound(.Mine) to Ubound(.Mine)
                    If .Mine(i2).State = 1 Then
                        .Mine(i2).X += .Mine(i2).Xvec
                        .Mine(i2).Y += .Mine(i2).Yvec
                    Else
                        If .Mine(i2).Explosion_state = 1 Then
                            For i3 = Lbound(.Mine(i2).Particle) To Ubound(.Mine(i2).Particle)
                                If .Mine(i2).Particle(i3).State = 1 Then
                                    .Mine(i2).Particle(i3).X -= .Mine(i2).Particle(i3).Xvec
                                    .Mine(i2).Particle(i3).Y -= .Mine(i2).Particle(i3).Yvec
                                End If
                            Next
                        End If
                    End If
                Next
                For i2 = 0 to Ubound(.Rocket)
                    If .Rocket(i2).State = 1 Then
                        .Rocket(i2).X += .Rocket(i2).Xvec 
                        .Rocket(i2).Y += .Rocket(i2).Yvec
                        For i3 = Lbound(.Rocket(i2).Burst) To Ubound(.Rocket(i2).Burst)
                            If .Rocket(i2).Burst(i3).State = 1 Then
                                .Rocket(i2).Burst(i3).X -= .Rocket(i2).Burst(i3).Xvec
                                .Rocket(i2).Burst(i3).Y -= .Rocket(i2).Burst(i3).Yvec
                            End If
                        Next
                    Else
                        If .Rocket(i2).Explosion_state = 1 Then
                            For i3 = Lbound(.Rocket(i2).Particle) To Ubound(.Rocket(i2).Particle)
                                If .Rocket(i2).Particle(i3).State = 1 Then
                                    .Rocket(i2).Particle(i3).X -= .Rocket(i2).Particle(i3).Xvec
                                    .Rocket(i2).Particle(i3).Y -= .Rocket(i2).Particle(i3).Yvec
                                End If
                            Next
                        End If
                    End If
                Next
            End With
        Next
        
        ''  press space bar to restart game
        If Multikey(57) Then
            If Ship(1).State = 0 or Ship(2).State = 0 Then goto Restart
        End If
        
        ''  press F1 to toggle radar on/off
        If Multikey(59) Then
            If Timer > Wait_Time(7) Then 
                Radar.State xor = 1
            End If
            Wait_Time(7) = Timer + Wait_Rate
        End If
        
        ''  Press F2 to toggle compasses on/off
        If Multikey(60) Then
            If Timer > Wait_Time(8) Then 
                For i = Lbound(Compass) to Ubound(Compass)
                    With Compass(i)
                        .State xor = 1
                        Circle Menu_Scrn.Content, (.X, .Y), .Radius, Rgb(40, 40, 40),,,1,F
                    End With
                Next
            End If
            Wait_Time(8) = Timer + Wait_Rate
        End If
        
        ''  Ship controls
        For i = Lbound(Ship) To Ubound(Ship)
            With Ship(i)
                If .State = 1 Then
                    ''  toggle ship turn left/right
                    If multikey (.Lft) and not Multikey (.Rgt) then 
                        .Direction += Turn_Rate
                        Rec (6, 180-.Direction)
                        .Xburst = Xrec
                        .Yburst = Yrec
                        Rec (15, -.Direction)
                        .Xgun = Xrec
                        .Ygun = Yrec
                        Rec (12, 245-.Direction)
                        .Xrght = Xrec
                        .Yrght = Yrec
                        Rec (12, 115-.Direction)
                        .Xl3ft = Xrec
                        .Yl3ft = Yrec
                    End If
                    If multikey (.rgt) and not multikey (.Lft) then 
                        .Direction -= Turn_Rate
                        Rec (6, 180-.Direction)
                        .Xburst = Xrec
                        .Yburst = Yrec
                        Rec (15, -.Direction)
                        .Xgun = Xrec
                        .Ygun = Yrec
                        Rec (12, 245-.Direction)
                        .Xrght = Xrec
                        .Yrght = Yrec
                        Rec (12, 115-.Direction)
                        .Xl3ft = Xrec
                        .Yl3ft = Yrec
                    End If
                    
                    ''  toggle ship thrust
                    If multikey (.fwd) then
                        If .Fuel_Mass >= 0.02 then
                            .Xvec += Screen_update*1000*(Cos(.Direction*Radtodeg)/.Mass)
                            .Yvec += Screen_update*1000*(Sin(-.Direction*Radtodeg)/.Mass)
                            .Fuel_Mass -= 0.02
                            .Mass -= 0.02
                            For i2 = 0 to Ubound(.Burst)
                                If .Burst(i2).State = 0 Then
                                    .Burst(i2).Direction = .Direction+(Rnd*7.5-Rnd*7.5)
                                    .Burst(i2).XVec = (.Burst(i2).Speed*Cos(.Burst(i2).Direction*Radtodeg))-.Xvec
                                    .Burst(i2).YVec = (.Burst(i2).Speed*Sin(-.Burst(i2).Direction*Radtodeg))-.Yvec
                                    .Burst(i2).X = .Xburst+.X
                                    .Burst(i2).Y = .Yburst+.Y
                                    .Burst(i2).TimeLeft = .Burst(i2).Time
                                    .Burst(i2).State = 1
                                    Exit For
                                End If
                            Next
                        Else 
                            .Fuel_Mass = 0
                        End If
                    End If
                    
                    ''  toggle ship deflection shield
                    If Multikey (.lft) and Multikey (.Rgt) Then
                        If Timer > Wait_Time(i+4) Then 
                            .Shield_State xor = 1
                        End If
                        Wait_Time(i+4) = Timer + Wait_Rate
                    End If
                    
                    ''  toggle ship weapon
                    If Multikey(.gun) Then
                        If Timer > Wait_Time(i) Then
                            If .Gun_Type = 1 Then
                                If .Fuel_Mass >= 1 then
                                    For i2 = 0 to Ubound(.Projectile)
                                        If .Projectile(i2).State = 0 Then
                                            .Projectile(i2).Direction = .Direction+180
                                            .Projectile(i2).XVec = (.Projectile(i2).Speed*Cos(.Projectile(i2).Direction*Radtodeg))-.Xvec
                                            .Projectile(i2).YVec = (.Projectile(i2).Speed*Sin(-.Projectile(i2).Direction*Radtodeg))-.Yvec
                                            .Projectile(i2).X = .Xgun+.X
                                            .Projectile(i2).Y = .Ygun+.Y
                                            .Projectile(i2).TimeLeft = .Projectile(i2).Time
                                            .Projectile(i2).State = 1
                                            .Fuel_Mass -= 1
                                            .Mass -= 1
                                            .Xvec += .Projectile(i2).XVec*(.Projectile(i2).mass/.Mass)
                                            .Yvec += .Projectile(i2).YVec*(.Projectile(i2).mass/.Mass)
                                            Exit For
                                        End If
                                    Next
                                End If
                            End If
                            If .Gun_Type = 2 Then
                                If .Fuel_Mass >= 10 then
                                    For i2 = 0 to Ubound(.Mine)
                                        If .Mine(i2).State = 0 Then
                                            .Mine(i2).XVec = .Xvec
                                            .Mine(i2).YVec = .Yvec
                                            .Mine(i2).X = .Xburst+.X
                                            .Mine(i2).Y = .Yburst+.Y
                                            .Mine(i2).State = 1
                                            .Mine(i2).Trigger = 0
                                            .Mine(i2).Warmup_TimeLeft = .Mine(i2).Warmup_Time
                                            .Mine(i2).Beacon.Trigger_Time = .Mine(i2).Warmup_Time
                                            .Fuel_Mass -= 10
                                            .Mass -= 10
                                            Exit For
                                        End If
                                    Next
                                End If
                            End If
                            If .Gun_Type = 3 Then
                                If .Fuel_Mass >= 100 then
                                    For i2 = 0 to Ubound(.Rocket)
                                        If .Rocket(i2).State = 0 and .Rocket(i2+1).State = 0 Then
                                            Degsub (.Direction, 6)
                                            .Rocket(i2).Point_Direction = Deg
                                            .Rocket(i2).XVec = .Xvec
                                            .Rocket(i2).YVec = .Yvec
                                            .Rocket(i2).X = .Xl3ft+.X
                                            .Rocket(i2).Y = .Yl3ft+.Y
                                            .Rocket(i2).Warmup_TimeLeft = .Rocket(i2).Warmup_Time
                                            If i = 1 Then 
                                                .Rocket(i2).Target = 2
                                            Else
                                                .Rocket(i2).Target = 1
                                            End If
                                            .Rocket(i2).State = 1
                                            Degadd (.Direction, 6)
                                            .Rocket(i2+1).Point_Direction = Deg
                                            .Rocket(i2+1).XVec = .Xvec
                                            .Rocket(i2+1).YVec = .Yvec
                                            .Rocket(i2+1).X = .Xrght+.X
                                            .Rocket(i2+1).Y = .Yrght+.Y
                                            .Rocket(i2+1).Warmup_TimeLeft = .Rocket(i2+1).Warmup_Time
                                            If i = 1 Then 
                                                .Rocket(i2+1).Target = 2
                                            Else
                                                .Rocket(i2+1).Target = 1
                                            End If
                                            .Rocket(i2+1).State = 1
                                            .Fuel_Mass -= 100
                                            .Mass -= 100
                                            Exit For
                                        End If
                                    Next
                                End If
                            End If
                        End If
                        Wait_Time(i) = Timer + Wait_Rate
                    End If
                    
                    ''  toggle emerald pick up / weapon swap
                    If multikey (.pck) then 
                        If Timer > Wait_Time(i+2) Then
                            If .Payload_State = 1 Then
                                .Payload_State xor = 1
                                .Payload_Mass = 0
                                .Payload_Num = -1
                                Wait_Time(i+2) = Timer + Wait_Rate
                            Else
                                i3 = 70
                                .Payload_Num = -1
                                For i2 = Lbound(Emerald) to Ubound(Emerald)
                                    If Emerald(i2).State = 1 Then
                                        Xpos = Ship(i).X-Emerald(i2).X
                                        Ypos = Ship(i).Y-Emerald(i2).Y
                                        Distance = sqr((Xpos^2) + (Ypos^2))
                                        If Distance <= i3 Then 
                                            i3 = Distance
                                            .Payload_Num = i2
                                        End If
                                    End If
                                Next
                                If .Payload_Num <> -1 Then
                                    .Payload_State xor = 1
                                    .Payload_Mass = Emerald(.Payload_Num).Mass
                                Else
                                    .Gun_type += 1
                                    If .Gun_type > 3 Then .Gun_type = 1
                                End If
                                Wait_Time(i+2) = Timer + Wait_Rate
                            End If
                        End If
                        Wait_Time(i+2) = Timer + Wait_Rate
                    End If
                    If .Shield_State = 1 Then
                        If .Fuel_mass >= 0.05 Then
                            .Fuel_Mass -= 0.05
                        Else
                            .Fuel_Mass = 0
                            .Shield_State = 0
                        End If
                    End If
                    
                    ''  toggle zoom
                    If multikey (.zoom_out) then
                    Scrn(i).Zoom += (Scrn(i).Zoom*(1/Screen_Rate))
                    End If
                    If multikey (.zoom_in) then
                        Scrn(i).Zoom -= (Scrn(i).Zoom*(1/Screen_Rate))
                    End If
                    ''  limit zoom
                    If Scrn(i).Zoom > 1 Then Scrn(i).Zoom = 1
                    If Scrn(i).Zoom < 0.04 Then Scrn(i).Zoom = 0.04
                Else
                    ''  restart player without restartig game
                    If Multikey (.Gun) Then
                        .state = 1
                        .X = Planet(0).X+.Orbit_Radius*Sin(.Angle)
                        .Y = Planet(0).Y+.Orbit_Radius*Cos(.Angle)
                        .Fuel_Mass = 500
                        .Mass = 500 + .Fuel_Mass
                        .Direction = 90
                        .XVec = Planet(0).Xvec-sqr((Spec_Grav*Planet(0).Mass)/.Orbit_Radius)*Cos(.Angle)
                        .YVec = Planet(0).Yvec-sqr((Spec_Grav*Planet(0).Mass)/.Orbit_Radius)*Sin(-.Angle)
                        Rec (12, 245-.Direction)
                        .Xrght = Xrec
                        .Yrght = Yrec
                        Rec (12, 115-.Direction)
                        .Xl3ft = Xrec
                        .Yl3ft = Yrec
                        Rec (6, 180-.Direction)
                        .Xburst = Xrec
                        .Yburst = Yrec
                        Rec (15, -.Direction)
                        .Xgun = Xrec
                        .Ygun = Yrec
                        .Gun_type = 1
                        .Shield_State = 0
                        .Payload_state = 0
                        .Payload_mass = 0
                        .Payload_num = -1
                        Wait_Time(i) = Timer + Wait_Rate
                    End If
                    
                    ''  free look mode while dead
                    If multikey (.Lft) Then
                        Ship(i).X -= (3/Scrn(i).Zoom)
                    End If
                    If multikey (.rgt) Then
                        Ship(i).X += (3/Scrn(i).Zoom)
                    End If
                    If multikey (.fwd) then
                        Ship(i).Y -= (3/Scrn(i).Zoom)
                    End If
                    If multikey (.pck) then 
                        Ship(i).Y += (3/Scrn(i).Zoom)
                    End If
                    If multikey (.zoom_out) then
                        Scrn(i).Zoom += (Scrn(i).Zoom/Screen_Rate)
                    End If
                    If multikey (.zoom_in) then
                        Scrn(i).Zoom -= (Scrn(i).Zoom/Screen_Rate)
                    End If
                    ''  limit zoom
                    If Scrn(i).Zoom >= 1 Then Scrn(i).Zoom = 1
                    If Scrn(i).Zoom <= (0.4*Scrn(i).wid)/(Grid_Num*Grid_Dist) Then Scrn(i).Zoom = (0.4*Scrn(i).wid)/(Grid_Num*Grid_Dist)
                End If
            End With
        Next
        
    End If
    
    ''  update screen every 1/screen_rate seconds
    If Timer >= last_screen_update Then 
        last_screen_update = Timer + screen_update
        
        ''  calculate fps
        If Timer < FPS_timer Then
            FPS_Counter += 1
        Else
            FPS = FPS_Counter
            FPS_Counter = 0
            FPS_Timer = Timer+1
            'Sleep 2
            ''  fine-tune fps to always be equal to screen update rate
            If FPS < Screen_rate Then screen_update -= 1e-4
            If FPS > Screen_rate Then screen_update += 1e-4
        End If
    
        ''  draw graphics to screen buffers
        For i = Lbound(Scrn) To Ubound(Scrn)
            
            'Pol(Ship(i).X-Planet(0).X, Ship(i).Y-Planet(0).Y)
            Scrn(i).Angle = pi'(-TPol+90)*Radtodeg
            'If Scrn(i).Angle > 2*pi Then Scrn(i).Angle -= 2*pi
            'If Scrn(i).Angle < 0 Then Scrn(i).Angle += 2*pi
            Scrn(i).Sin_Ang = Sin(Scrn(i).Angle)
            Scrn(i).Cos_Ang = Cos(Scrn(i).Angle)
            
            ''  erase buffer
            Line Scrn(i).Content,(0, 0)-(Scrn(i).Wid, Scrn(i).Hgt), 0, BF
            
            ''  center screen on ship
            X_Center = Scrn(i).Screen_X_Mid
            Y_Center = Scrn(i).Screen_Y_Mid
            
            ''  draw radiating lines in grid
            For i2 = 1 To Ubound(Radian)
                Xpos = X_Center+(Scrn(i).Cos_Ang*(Ship(i).X-Radian(i2).X1)-Scrn(i).Sin_Ang*(Ship(i).y-Radian(i2).Y1))*Scrn(i).Zoom
                Ypos = Y_Center+(Scrn(i).Cos_Ang*(Ship(i).Y-Radian(i2).Y1)+Scrn(i).Sin_Ang*(Ship(i).X-Radian(i2).X1))*Scrn(i).Zoom
                Xpos2 = X_Center+(Scrn(i).Cos_Ang*(Ship(i).X-Radian(i2).X2)-Scrn(i).Sin_Ang*(Ship(i).y-Radian(i2).Y2))*Scrn(i).Zoom
                Ypos2 = Y_Center+(Scrn(i).Cos_Ang*(Ship(i).Y-Radian(i2).Y2)+Scrn(i).Sin_Ang*(Ship(i).X-Radian(i2).X2))*Scrn(i).Zoom
                Line Scrn(i).Content, (Xpos, Ypos)-(Xpos2, Ypos2), Grid_color
            Next
            
            ''  draw concentric circles in grid
            For i2 = 1 to Ubound(Ellipse)
                With Ellipse(i2)
                    For i3 = 0 to .Num_Lines-1
                        Xpos = X_Center+(Scrn(i).Cos_Ang*(Ship(i).X-.X(i3))-Scrn(i).Sin_Ang*(Ship(i).y-.y(i3)))*Scrn(i).Zoom
                        Ypos = Y_Center+(Scrn(i).Cos_Ang*(Ship(i).Y-.Y(i3))+Scrn(i).Sin_Ang*(Ship(i).X-.X(i3)))*Scrn(i).Zoom
                        Xpos2 = X_Center+(Scrn(i).Cos_Ang*(Ship(i).X-.X(i3+1))-Scrn(i).Sin_Ang*(Ship(i).y-.Y(i3+1)))*Scrn(i).Zoom
                        Ypos2 = Y_Center+(Scrn(i).Cos_Ang*(Ship(i).Y-.Y(i3+1))+Scrn(i).Sin_Ang*(Ship(i).X-.X(i3+1)))*Scrn(i).Zoom
                        Line Scrn(i).Content, (Xpos, Ypos)-(Xpos2, Ypos2), .Col
                    Next
                End With
            Next
            
            ''  draw elliptic trajectory
            With Draw_Trajectory
                If .State = 0 Then
                    Dou_Var = 0
                    .Host = -1
                    ''  find hosting body
                    For i2 = Lbound(Planet) to Ubound(Planet)
                        If Planet(i2).State = 1 Then
                            .GM = Planet(i2).Grav_Param
                            .Distance = Sqr((Planet(i2).X-Ship(i).X)^2+(Planet(i2).Y-Ship(i).Y)^2)
                            .Speed = Sqr((Ship(i).Xvec-Planet(i2).Xvec)^2 + (Ship(i).Yvec-Planet(i2).Yvec)^2)
                            .semimajor_Axis = -1/((.Speed^2/.GM)-(2/.Distance))
                            .Spec_Orbital_Energy = -(.GM/(2*.Semimajor_Axis))
                        End If
                        If .Spec_Orbital_Energy < Dou_Var Then
                            Dou_Var = .Spec_Orbital_Energy
                            .Host = i2
                        End If
                    Next
                    If .Host <> -1 Then
                        .GM = Planet(.Host).Grav_Param
                        ''  find size and eccentricity of elliptic trajectory
                        Xdist = Planet(.Host).X-Ship(i).X
                        Ydist = Planet(.Host).Y-Ship(i).Y
                        .Distance = Sqr(Xdist^2 + Ydist^2)
                        Xdist2 = Planet(.Host).Xold-Ship(i).Xold
                        Ydist2 = Planet(.Host).Yold-Ship(i).Yold
                        .Distance_old = Sqr(Xdist2^2 + Ydist2^2)
                        .Speed = Sqr((Ship(i).Xvec-Planet(.host).Xvec)^2 + (Ship(i).Yvec-Planet(.host).Yvec)^2)
                        .Theta = Halfpi-Acos((.Speed^2+.Distance^2-.Distance_Old^2)/(2*.Speed*.Distance))
                        .semimajor_Axis = -1/((.Speed^2/.GM)-(2/.Distance))
                        .Eccentricity = Sqr(1-((cos(.Theta)*.Speed*.Distance*Sqr(.semimajor_axis^3/.GM))/.semimajor_axis^2)^2)
                        .Semiminor_axis = .Semimajor_axis*sqr(1-(.Eccentricity^2))
                        .Periapsis = (1-.Eccentricity)*.Semimajor_Axis
                        .Apoapsis = (1+.Eccentricity)*.Semimajor_Axis
                        .Foci_Dist = .Eccentricity*.semimajor_axis
                        ''  find the elliptic trajectory's angle relative to frame of reference
                        .True_Anomaly = Acos((((.semimajor_axis*(1-.Eccentricity^2))/.Distance)-1)/.Eccentricity)
                        Pol((Planet(.Host).X-Ship(i).X), (Planet(.Host).Y-Ship(i).Y))
                        '.Reference_Angle_Old = .Reference_Angle
                        '.Reference_Angle = Tpol*Radtodeg
                        'If .Reference_Angle < .Reference_Angle_Old Then
                        '    If .Theta > 0 Then
                        '        .Orbit_Angle = .True_Anomaly-.Reference_Angle
                        '    Else
                        '        .Orbit_Angle = -.Reference_Angle-.True_Anomaly
                        '    End If
                        'Else
                        '    If .Theta < 0 Then
                        '        .Orbit_Angle = .True_Anomaly-.Reference_Angle
                        '    Else
                        '        .Orbit_Angle = -.Reference_Angle-.True_Anomaly
                        '    End If
                        'End If
                        .Xpos = X_Center+(Planet(.Host).X-Ship(i).X+.Foci_Dist*Cos(.Orbit_Angle))*Scrn(i).Zoom
                        .Ypos = Y_Center+(Planet(.Host).Y-Ship(i).Y+.Foci_Dist*Sin(-.Orbit_Angle))*Scrn(i).Zoom
                        If .Periapsis > Planet(.Host).Radius+Ship(i).Radius and _
                            .Apoapsis < Grid_Radius Then
                            Draw_Ellipse(Scrn(i).Content, .Xpos, .Ypos, .semimajor_axis*Scrn(i).Zoom, .semiminor_axis*Scrn(i).Zoom, .Orbit_Angle, RGB(16,48,8), 720)
                        Else
                            Draw_Ellipse(Scrn(i).Content, .Xpos, .Ypos, .semimajor_axis*Scrn(i).Zoom, .semiminor_axis*Scrn(i).Zoom, .Orbit_Angle, RGB(48,16,8), 720)
                        End If
                    End If
                End If
            End With
            
            ''  draw ships to buffer
            For i2 = Lbound(Ship) To Ubound(Ship)
                With Ship(i2)
                    ''  draw burst
                    For i3 = 0 to Ubound(.burst)
                        With .burst(i3)
                            If .State = 1 Then
                                If .TimeLeft >= 1 Then
                                    .TimeLeft -= 1
                                    Col = .TimeLeft/.Time
                                    R = .R*col
                                    G = .G*col
                                    B = .B*col
                                    Xpos = X_Center+((Scrn(i).Cos_Ang*(Ship(i).X-.X))-(Scrn(i).Sin_Ang*(Ship(i).Y-.Y)))*Scrn(i).Zoom
                                    Ypos = Y_Center+((Scrn(i).Cos_Ang*(Ship(i).Y-.Y))+(Scrn(i).Sin_Ang*(Ship(i).X-.X)))*Scrn(i).Zoom
                                    Pset Scrn(i).Content, (Xpos, Ypos), RGB(R, G, B)
                                Else
                                    .State = 0
                                End If
                            End If
                        End With
                    Next
                    ''  draw projectiles
                    For i3 = 0 to Ubound(.Projectile)
                        With .Projectile(i3)
                            If .State = 1 Then
                                If .TimeLeft >= 1 Then
                                    .TimeLeft -= 1
                                    If .TimeLeft < 32 Then
                                        R = .Timeleft*8
                                        G = R
                                        B = R
                                    Else
                                        R = .R
                                        G = R
                                        B = R
                                    End If
                                    Xpos = X_Center+((Scrn(i).Cos_Ang*(Ship(i).X-.X))-(Scrn(i).Sin_Ang*(Ship(i).Y-.Y)))*Scrn(i).Zoom
                                    Ypos = Y_Center+((Scrn(i).Cos_Ang*(Ship(i).Y-.Y))+(Scrn(i).Sin_Ang*(Ship(i).X-.X)))*Scrn(i).Zoom
                                    Pset Scrn(i).Content, (Xpos, Ypos), RGB(R, G, B)
                                Else
                                    .State = 0
                                End If
                            End If
                        End With
                    Next
                    ''  draw mines
                    For i3 = 0 to Ubound(.Mine)
                        With .Mine(i3)
                            If .State = 1 Then
                                If .Warmup_TimeLeft > 0 Then
                                    .Warmup_TimeLeft -= 1
                                End If
                                If .Trigger = 1 Then
                                    If .Countdown_TimeLeft > 0 Then
                                        .Countdown_TimeLeft -= 1
                                        If .Countdown_TimeLeft = 0 Then
                                            .State = 0
                                            .Explosion_Trigger = 1
                                            .Explosion_State = 1
                                        End If
                                    End If
                                    .Beacon.On_Time = 10
                                    .Beacon.Off_Time = 10
                                    .Beacon.FadeIn_Time = 1
                                    .Beacon.FadeOut_Time = 1
                                    .Beacon.R = 255
                                    .Beacon.G = 48
                                    .Beacon.B = 48
                                End If
                                Xpos = X_Center+((Scrn(i).Cos_Ang*(Ship(i).X-.X))-(Scrn(i).Sin_Ang*(Ship(i).Y-.Y)))*Scrn(i).Zoom
                                Ypos = Y_Center+((Scrn(i).Cos_Ang*(Ship(i).Y-.Y))+(Scrn(i).Sin_Ang*(Ship(i).X-.X)))*Scrn(i).Zoom
                                Circle Scrn(i).Content, (Xpos, Ypos), .Radius*Scrn(i).Zoom, RGB(.R, .G, .B),,,1,f
                                With .Beacon
                                    If .State = 1 Then
                                        If .Trigger_Time > 0 then
                                            .Trigger_Time -= 1
                                            If .Trigger_Time = 0 Then .FadeIn_Timeleft = .FadeIn_Time
                                            Circle Scrn(i).Content, (Xpos, Ypos), .Radius*Scrn(i).Zoom, 0,,,1,F
                                        Else
                                            If .FadeIn_Timeleft > 0 Then
                                                .FadeIn_Timeleft -= 1
                                                If .FadeIn_Timeleft = 0 Then .On_Timeleft = .On_Time
                                                Col = 1-(.FadeIn_TimeLeft/.FadeIn_Time)
                                                R = .R*col
                                                G = .G*col
                                                B = .B*col
                                                Circle Scrn(i).Content, (Xpos, Ypos), .Radius*Scrn(i).Zoom, RGB(R, G, B),,,1,F
                                            End If
                                            If .On_Timeleft > 0 Then
                                                .On_Timeleft -= 1
                                                If .On_Timeleft = 0 Then .FadeOut_Timeleft = .FadeOut_Time
                                                Circle Scrn(i).Content, (Xpos, Ypos), .Radius*Scrn(i).Zoom, RGB(.R, .G, .B),,,1,F
                                            End If
                                            If .FadeOut_Timeleft > 0 Then
                                                .FadeOut_Timeleft -= 1
                                                If .FadeOut_Timeleft = 0 Then .Off_Timeleft = .Off_Time
                                                Col = .FadeOut_TimeLeft/.FadeOut_Time
                                                R = .R*col
                                                G = .G*col
                                                B = .B*col
                                                Circle Scrn(i).Content, (Xpos, Ypos), .Radius*Scrn(i).Zoom, RGB(R, G, B),,,1,F
                                            End If
                                            If .Off_Timeleft > 0 Then
                                                .Off_Timeleft -=1
                                                If .Off_Timeleft = 0 Then .FadeIn_Timeleft = .FadeIn_Time
                                                Circle Scrn(i).Content, (Xpos, Ypos), .Radius*Scrn(i).Zoom, 0,,,1,F
                                            End If
                                        End If
                                    Else
                                        Circle Scrn(i).Content, (Xpos, Ypos), .Radius, 0,,,1,F
                                    End If
                                End With
                            Else
                                If .Explosion_state = 1 Then
                                    .Explosion_state = 0
                                    For i4 = 0 To Ubound(.Particle)
                                        With .Particle(i4)
                                            If .State = 1 Then
                                                if .TimeLeft >= 1 then
                                                    Ship(i2).Mine(i3).Explosion_state = 1
                                                    .TimeLeft -= 1
                                                    Col = .TimeLeft/.Time
                                                    R = .R*col
                                                    G = .G*col
                                                    B = .B*col
                                                    Xpos = X_Center+((Scrn(i).Cos_Ang*(Ship(i).X-.X))-(Scrn(i).Sin_Ang*(Ship(i).Y-.Y)))*Scrn(i).Zoom
                                                    Ypos = Y_Center+((Scrn(i).Cos_Ang*(Ship(i).Y-.Y))+(Scrn(i).Sin_Ang*(Ship(i).X-.X)))*Scrn(i).Zoom
                                                    Pset Scrn(i).Content, (Xpos, Ypos), RGB(R, G, B)
                                                Else 
                                                    .State = 0
                                                End If
                                            End If
                                        End With
                                    Next
                                End If
                            End If
                        End With
                    Next
                    ''  draw rockets
                    For i3 = 0 to Ubound(.Rocket)
                        With .Rocket(i3)
                            If .State = 1 Then
                                If .Warmup_TimeLeft > 0 Then
                                    .Warmup_TimeLeft -= 1
                                End If
                                For i4 = 0 to Ubound(.Burst)
                                    With .Burst(i4)
                                        If .State = 0 Then
                                            .Direction = -Ship(i2).Rocket(i3).Point_Direction+(Rnd*5-Rnd*5)
                                            .XVec = (.Speed*Cos(.Direction*Radtodeg))-Ship(i2).Rocket(i3).Xvec
                                            .YVec = (.Speed*Sin(.Direction*Radtodeg))-Ship(i2).Rocket(i3).Yvec
                                            .X = Ship(i2).Rocket(i3).X
                                            .Y = Ship(i2).Rocket(i3).Y
                                            .TimeLeft = .Time
                                            .State = 1
                                            Exit For
                                        End If
                                    End With
                                Next
                                For i4 = 0 to Ubound(.burst)
                                    With .Burst(i4)
                                        If .State = 1 Then
                                            If .TimeLeft >= 1 Then
                                                .TimeLeft -= 1
                                                Col = .TimeLeft/.Time
                                                R = .R*col
                                                G = .G*col
                                                B = .B*col
                                                Xpos = X_Center+((Scrn(i).Cos_Ang*(Ship(i).X-.X))-(Scrn(i).Sin_Ang*(Ship(i).Y-.Y)))*Scrn(i).Zoom
                                                Ypos = Y_Center+((Scrn(i).Cos_Ang*(Ship(i).Y-.Y))+(Scrn(i).Sin_Ang*(Ship(i).X-.X)))*Scrn(i).Zoom
                                                Pset Scrn(i).Content, (Xpos, Ypos), RGB(R, G, B)
                                            Else
                                                .State = 0
                                            End If
                                        End If
                                    End With
                                Next
                                DrawRocket (i, .X, .Y, .Point_Direction, .R, .G, .B)
                            Else
                                If .Explosion_state = 1 Then
                                    .Explosion_state = 0
                                    For i4 = 0 To Ubound(.Particle)
                                        With .Particle(i4)
                                            If .State = 1 Then
                                                if .TimeLeft >= 1 then
                                                    Ship(i2).Rocket(i3).Explosion_state = 1
                                                    .TimeLeft -= 1
                                                    Col = .TimeLeft/.Time
                                                    R = .R*col
                                                    G = .G*col
                                                    B = .B*col
                                                    Xpos = X_Center+((Scrn(i).Cos_Ang*(Ship(i).X-.X))-(Scrn(i).Sin_Ang*(Ship(i).Y-.Y)))*Scrn(i).Zoom
                                                    Ypos = Y_Center+((Scrn(i).Cos_Ang*(Ship(i).Y-.Y))+(Scrn(i).Sin_Ang*(Ship(i).X-.X)))*Scrn(i).Zoom
                                                    Pset Scrn(i).Content, (Xpos, Ypos), RGB(R, G, B)
                                                Else 
                                                    .State = 0
                                                End If
                                            End If
                                        End With
                                    Next
                                End If
                            End If
                        End With
                    Next
                    If .State = 1 Then
                        ''  draw tractor-beam between ship and picked up Debris
                        If .Payload_State = 1 then
                            Xpos = X_Center+(Emerald(.Payload_Num).X-Ship(i).X)*Scrn(i).Zoom
                            Ypos = Y_Center+(Emerald(.Payload_Num).Y-Ship(i).Y)*Scrn(i).Zoom
                            Xpos2 = X_Center+(.Xburst+.X-Ship(i).X)*Scrn(i).Zoom
                            Ypos2 = Y_Center+(.Yburst+.Y-Ship(i).Y)*Scrn(i).Zoom
                            Line Scrn(i).Content, (Xpos, Ypos)-(Xpos2, Ypos2), Rgb(96, 96, 144)
                        End If
                        ''  draw deflection shield
                        If .Shield_State = 1 Then
                            Xpos = X_Center+(.X+(-Rnd+Rnd)-Ship(i).X)*Scrn(i).Zoom
                            Ypos = Y_Center+(.Y+(-Rnd+Rnd)-Ship(i).Y)*Scrn(i).Zoom
                            Xpos2 = X_Center+(.X+(-Rnd+Rnd)-Ship(i).X)*Scrn(i).Zoom
                            Ypos2 = Y_Center+(.Y+(-Rnd+Rnd)-Ship(i).Y)*Scrn(i).Zoom
                            Circle Scrn(i).Content, (Xpos, Ypos), (.Shield_Radius-2)*Scrn(i).Zoom,  Rgb(64, 64, 96),,,1
                            Circle Scrn(i).Content, (Xpos2, Ypos2), .Shield_Radius*Scrn(i).Zoom,  Rgb(96, 96, 144),,,1
                        End If
                        ''  draw mine at ship's tail
                        If .Gun_Type = 2 and .Fuel_mass >= 10 Then
                            Circle Scrn(i).Content, (X_Center+(.X+.Xburst-Ship(i).X)*Scrn(i).Zoom, Y_Center+(.Y+.Yburst-Ship(i).Y)*Scrn(i).Zoom), 6*Scrn(i).Zoom, RGB(80, 80, 80),,,1,F
                        End If
                        ''draw rockets
                        If .Gun_Type = 3 and .Fuel_mass >= 100 Then
                            R = .Rocket(Lbound(.Rocket)).R
                            g = .Rocket(Lbound(.Rocket)).G
                            b = .Rocket(Lbound(.Rocket)).B
                            DrawRocket (i, .X+.Xl3ft, .Y+.Yl3ft, .Direction, R, G, B)
                            DrawRocket (i, .X+.Xrght, .Y+.Yrght, .Direction, R, G, B)
                        End If
                        '' draw ship
                        DrawShip (i, .X, .Y, .Direction-((Scrn(i).Angle+pi)*degtorad), .R, .G, .B)
                    Else
                        ''  draw particles
                        If .Explosion_state = 1 Then
                            .Explosion_state = 0
                            For i3 = 0 To Ubound(.Particle)
                                With .Particle(i3)
                                    If .State = 1 Then
                                        if .TimeLeft >= 1 then
                                            Ship(i2).Explosion_state = 1
                                            .TimeLeft -= 1
                                            Col = .TimeLeft/.Time
                                            R = .R*col
                                            G = .G*col
                                            B = .B*col
                                            Xpos = X_Center+((Scrn(i).Cos_Ang*(Ship(i).X-.X))-(Scrn(i).Sin_Ang*(Ship(i).Y-.Y)))*Scrn(i).Zoom
                                            Ypos = Y_Center+((Scrn(i).Cos_Ang*(Ship(i).Y-.Y))+(Scrn(i).Sin_Ang*(Ship(i).X-.X)))*Scrn(i).Zoom
                                            Pset Scrn(i).Content, (Xpos, Ypos), RGB(R, G, B)
                                        Else 
                                            .State = 0
                                        End If
                                    End If
                                End With
                            Next
                        End If
                    End If
                End With
            Next
            
            ''  draw Debris to buffer
            For i2 = 0 To Ubound(Debris) 
                With Debris(i2)
                    If .State = 1 Then
                        Xpos = X_Center+((Scrn(i).Cos_Ang*(Ship(i).X-.X))-(Scrn(i).Sin_Ang*(Ship(i).Y-.Y)))*Scrn(i).Zoom
                        Ypos = Y_Center+((Scrn(i).Cos_Ang*(Ship(i).Y-.Y))+(Scrn(i).Sin_Ang*(Ship(i).X-.X)))*Scrn(i).Zoom
                        Circle Scrn(i).Content, (Xpos, Ypos), .Radius*Scrn(i).Zoom, Rgb(.R, .G, .B),,,1,F
                    Else
                        ''  draw particles
                        If .Explosion_state = 1 Then
                            .Explosion_state = 0
                            For i3 = 0 To Ubound(.Particle)
                                With .Particle(i3)
                                    If .State = 1 Then
                                        if .TimeLeft >= 1 then
                                            Debris(i2).Explosion_state = 1
                                            .TimeLeft -= 1
                                            Col = .TimeLeft/.Time
                                            R = .R*col
                                            G = .G*col
                                            B = .B*col
                                            Xpos = X_Center+((Scrn(i).Cos_Ang*(Ship(i).X-.X))-(Scrn(i).Sin_Ang*(Ship(i).Y-.Y)))*Scrn(i).Zoom
                                            Ypos = Y_Center+((Scrn(i).Cos_Ang*(Ship(i).Y-.Y))+(Scrn(i).Sin_Ang*(Ship(i).X-.X)))*Scrn(i).Zoom
                                            Pset Scrn(i).Content, (Xpos, Ypos), RGB(R, G, B)
                                        Else 
                                            .State = 0
                                        End If
                                    End If
                                End With
                            Next
                        End If
                    End If
                End With
            Next
            
            ''  Draw emeralds to buffer
            For i2 = 0 To Ubound(Emerald) 
                With Emerald(i2)
                    If .State = 1 Then
                        Xpos = X_Center+((Scrn(i).Cos_Ang*(Ship(i).X-.X))-(Scrn(i).Sin_Ang*(Ship(i).Y-.Y)))*Scrn(i).Zoom
                        Ypos = Y_Center+((Scrn(i).Cos_Ang*(Ship(i).Y-.Y))+(Scrn(i).Sin_Ang*(Ship(i).X-.X)))*Scrn(i).Zoom
                        Circle Scrn(i).Content, (Xpos, Ypos), .Radius*Scrn(i).Zoom, Rgb(.R, .G, .B),,,1,F
                        If Ship(i).State = 1 and Ship(i).Payload_state = 0 Then
                            Xdist = .X-Ship(i).X
                            Ydist = .Y-Ship(i).Y
                            Distance = sqr((Xdist^2) + (Ydist^2))
                            If Distance < 70 Then
                                Circle Scrn(i).Content, (Xpos, Ypos), (.Radius+5)*Scrn(i).Zoom, Rgb(96, 96, 144),,,1
                            End IF
                        End If
                    Else
                        ''  draw particles
                        If .Explosion_state = 1 Then
                            .Explosion_state = 0
                            For i3 = 0 To Ubound(.Particle)
                                With .Particle(i3)
                                    If .State = 1 Then
                                        if .TimeLeft >= 1 then
                                            Emerald(i2).Explosion_state = 1
                                            .TimeLeft -= 1
                                            Col = .TimeLeft/.Time
                                            R = .R*col
                                            G = .G*col
                                            B = .B*col
                                            Xpos = X_Center+((Scrn(i).Cos_Ang*(Ship(i).X-.X))-(Scrn(i).Sin_Ang*(Ship(i).Y-.Y)))*Scrn(i).Zoom
                                            Ypos = Y_Center+((Scrn(i).Cos_Ang*(Ship(i).Y-.Y))+(Scrn(i).Sin_Ang*(Ship(i).X-.X)))*Scrn(i).Zoom
                                            Pset Scrn(i).Content, (Xpos, Ypos), RGB(R, G, B)
                                        Else 
                                            .State = 0
                                        End If
                                    End If
                                End With
                            Next
                        End If
                    End If
                End With
            Next
            
            ''  draw planets to buffer
            For i2 = 0 To Ubound(Planet) 
                With Planet(i2)
                    If .State = 1 Then
                        Xpos = X_Center+((Scrn(i).Cos_Ang*(Ship(i).X-.X))-(Scrn(i).Sin_Ang*(Ship(i).Y-.Y)))*Scrn(i).Zoom
                        Ypos = Y_Center+((Scrn(i).Cos_Ang*(Ship(i).Y-.Y))+(Scrn(i).Sin_Ang*(Ship(i).X-.X)))*Scrn(i).Zoom
                        Circle Scrn(i).Content, (Xpos, Ypos), .Radius*Scrn(i).Zoom, Rgb(.R, .G, .B),,,1,F
                    End If
                End With
            Next
        
            ''  draw screen buffer content on screen
            Put (Scrn(i).X, Scrn(i).Y), Scrn(i).Content, Trans
            
        Next
        
        ''  Draw compasses to menu buffer
        For i = Lbound(Compass) to Ubound(Compass)
            With Compass(i)
                If .State = 1 Then
                    Circle Menu_Scrn.Content, (.X, .Y), .Radius, Rgb(64, 64, 64),,,1,F
                    Circle Menu_Scrn.Content, (.X, .Y), .Radius-4, rgb(5, 30, 5),,,1,F
                    For i2 = 0 to Ubound(Debris)
                        If Debris(i2).State = 1 Then
                            Pol (Debris(i2).X-Ship(i).X, Debris(i2).Y-Ship(i).y)
                            If Rpol < Screen_y*(1/Scrn(i).Zoom) Then
                                Rec (.Radius-4, Tpol)
                                Col = Rpol/(Screen_y*(1/Scrn(i).Zoom))
                                R = 5+(19*(1-Col))
                                G = 30+(114*(1-Col))
                                B = 5+(19*(1-Col))
                                line Menu_Scrn.Content, (.X, .Y)-(.X+Xrec, .Y+Yrec), RGB(R, G, B)
                            End If
                        End If
                    Next
                    For i2 = 0 to Ubound(Emerald)
                        If Emerald(i2).State = 1 Then
                            Pol (Emerald(i2).X-Ship(i).X, Emerald(i2).Y-Ship(i).y)
                            If Rpol < Screen_y*(1/Scrn(i).Zoom) Then
                                Rec (.Radius-4, Tpol)
                                Col = Rpol/(Screen_y*(1/Scrn(i).Zoom))
                                R = 5+(187*(1-Col))
                                G = 30+(-8*(1-Col))
                                B = 5+(67*(1-Col))
                                line Menu_Scrn.Content, (.X, .Y)-(.X+Xrec, .Y+Yrec), RGB(R, G, B)
                            End If
                        End If
                    Next
                    circle Menu_Scrn.Content, (.X, .Y), (2/3)*.Radius, rgb(5, 30, 5),,,1,f
                    circle Menu_Scrn.Content, (.X, .Y), (2/3)*.Radius, RGB(12, 72, 12),,,1
                    For i2 = 1 to Ubound(Planet)
                        If Planet(i2).State = 1 Then
                            Pol (Planet(i2).X-Ship(i).X, Planet(i2).Y-Ship(i).y)
                            Rec (.Radius-4, Tpol)
                            line Menu_Scrn.Content, (.X, .Y)-(.X+Xrec, .Y+Yrec), Rgb(32, 192, 32)
                        End If
                    Next
                    circle Menu_Scrn.Content, (.X, .Y), (1/3)*.Radius, rgb(5, 30, 5),,,1,f
                    circle Menu_Scrn.Content, (.X, .Y), (1/3)*.Radius, RGB(12, 72, 12),,,1
                    Pol (Planet(0).X-Ship(i).X, Planet(0).Y-Ship(i).y)
                    Rec (.Radius-4, Tpol)
                    line Menu_Scrn.Content, (.X, .Y)-(.X+Xrec, .Y+Yrec), Rgb(48, 224, 48)
                End If
            End With
        Next
        
        ''  draw menu buffer content on screen
        Put (Menu_Scrn.X, Menu_Scrn.Y), Menu_Scrn.Content, Trans
        
        ''  Draw border directly to screen
        Line (Screen_X_Mid-(0.5*Border), 0)-(Screen_X_Mid+(0.5*Border), Screen_Y-Menu_Hgt), RGB(40, 40, 40), BF
        
        ''  Draw radar to buffer
        With Radar
            If .State = 1 Then
                Circle .Content, (.Radius, .Radius), .Radius-4, rgb(5, 30, 5),,,1,F
                With Draw_Trajectory
                    For i = Lbound(ship) to Ubound(ship)
                        Xdist = Planet(.Host).X-Ship(i).X
                        Ydist = Planet(.Host).Y-Ship(i).Y
                        .Distance = Sqr(Xdist^2 + Ydist^2)
                        Xdist2 = Planet(.Host).Xold-Ship(i).Xold
                        Ydist2 = Planet(.Host).Yold-Ship(i).Yold
                        .Distance_old = Sqr(Xdist2^2 + Ydist2^2)
                        .Speed = Sqr((Ship(i).Xvec-Planet(.host).Xvec)^2 + (Ship(i).Yvec-Planet(.host).Yvec)^2)
                        .Theta = Halfpi-Acos((.Speed^2+.Distance^2-.Distance_Old^2)/(2*.Speed*.Distance))
                        .semimajor_Axis = -1/((.Speed^2/.GM)-(2/.Distance))
                        .Eccentricity = Sqr(1-((cos(.Theta)*.Speed*.Distance*Sqr(.semimajor_axis^3/.GM))/.semimajor_axis^2)^2)
                        .Semiminor_axis = .Semimajor_axis*sqr(1-(.Eccentricity^2))
                        .Periapsis = (1-.Eccentricity)*.Semimajor_Axis
                        .Apoapsis = (1+.Eccentricity)*.Semimajor_Axis
                        .Foci_Dist = .Eccentricity*.semimajor_axis
                        ''  find the elliptic trajectory's angle relative to frame of reference
                        .True_Anomaly = Acos((((.semimajor_axis*(1-.Eccentricity^2))/.Distance)-1)/.Eccentricity)
                        Pol((Planet(.Host).X-Ship(i).X), (Planet(.Host).Y-Ship(i).Y))
                        .Reference_Angle_Old = .Reference_Angle
                        .Reference_Angle = Tpol*Radtodeg
                        If .Reference_Angle < .Reference_Angle_Old Then
                            If .Theta > 0 Then
                                .Orbit_Angle = .True_Anomaly-.Reference_Angle
                            Else
                                .Orbit_Angle = -.Reference_Angle-.True_Anomaly
                            End If
                        Else
                            If .Theta < 0 Then
                                .Orbit_Angle = .True_Anomaly-.Reference_Angle
                            Else
                                .Orbit_Angle = -.Reference_Angle-.True_Anomaly
                            End If
                        End If
                        .Xpos = Radar.Radius+(Planet(.Host).X+.Foci_Dist*Cos(.Orbit_Angle))*Radar.Scale
                        .Ypos = Radar.Radius+(Planet(.Host).Y+.Foci_Dist*Sin(-.Orbit_Angle))*Radar.Scale
                        If .Periapsis > Planet(.Host).Radius+Ship(i).Radius and _
                            .Apoapsis < Grid_Radius Then
                            Draw_Ellipse(Radar.Content, .Xpos, .Ypos, .semimajor_axis*Radar.Scale, .semiminor_axis*Radar.Scale, .Orbit_Angle, RGB(8,48,8), 128)
                        Else
                            Draw_Ellipse(Radar.Content, .Xpos, .Ypos, .semimajor_axis*Radar.Scale, .semiminor_axis*Radar.Scale, .Orbit_Angle, RGB(48,8,8), 128)
                        End If
                    Next
                End With
                For i = 0 To Ubound(Planet)
                    If Planet(i).State = 1 Then
                        Xpos = Radar.Radius+Planet(i).X*.Scale
                        Ypos = Radar.Radius+Planet(i).Y*.Scale
                        Circle .Content, (Xpos, Ypos), Planet(i).Radius*.Scale, Rgb(32, 192, 32),,,1,F
                    End If
                Next
                For i = 0 To Ubound(Debris)
                    If Debris(i).State = 1 Then
                        Xpos = Radar.Radius+Debris(i).X*.Scale
                        Ypos = Radar.Radius+Debris(i).Y*.Scale
                        Pset .Content, (Xpos, Ypos), Rgb(32, 192, 32)
                    End If
                Next
                For i = 0 To Ubound(Emerald)
                    If Emerald(i).State = 1 Then
                        Xpos = Radar.Radius+Emerald(i).X*.Scale
                        Ypos = Radar.Radius+Emerald(i).Y*.Scale
                        Pset .Content, (Xpos, Ypos), Rgb(255, 32, 96)
                    End If
                Next
                For i = Lbound(Ship) To Ubound(Ship)
                    If Ship(i).State = 1 Then
                        Xpos = Radar.Radius+Ship(i).X*.Scale
                        Ypos = Radar.Radius+Ship(i).Y*.Scale
                        Circle .Content, (Xpos, Ypos), 1, Rgb(255, 255, 255),,,1, F
                    End If
                    For i2 = 0 to Ubound(Ship(i).Mine)
                        If Ship(i).Mine(i2).State = 1 Then
                            Xpos = Radar.Radius+Ship(i).Mine(i2).X*.Scale
                            Ypos = Radar.Radius+Ship(i).Mine(i2).Y*.Scale
                            Pset .Content, (Xpos, Ypos), Rgb(255, 255, 96)
                        End If
                    Next
                    For i2 = 0 to Ubound(Ship(i).Rocket)
                        If Ship(i).Rocket(i2).State = 1 Then
                            Xpos = Radar.Radius+Ship(i).Rocket(i2).X*.Scale
                            Ypos = Radar.Radius+Ship(i).Rocket(i2).Y*.Scale
                            Pset .Content, (Xpos, Ypos), Rgb(255, 255, 96)
                        End If
                    Next
                Next
            End If
        End With
        
        With Radar
            Put .Content, (0, 0), .Content_Border, trans
            Paint .Content, (1,1), RGB(255, 0, 255), Rgb(64, 64, 64)
            Paint .Content, (2*.Radius-1, 1), RGB(255, 0, 255), Rgb(64, 64, 64)
            Paint .Content, (1, 2*.Radius-1), RGB(255, 0, 255), Rgb(64, 64, 64)
            Paint .Content, (2*.Radius-1, 2*.Radius-1), RGB(255, 0, 255), Rgb(64, 64, 64)
            Put (.X-.Radius, .Y-.Radius), .Content, trans
        End With
        
        Color RGB(128, 128, 128), Rgb(40, 40, 40)
        Locate ((Screen_y/8)-(Menu_hgt/8))+8, ((menu_Wid*0.25)/8)-8:    Print using "Fuel: ###.#"; ship(1).Fuel_Mass
        Locate ((Screen_y/8)-(Menu_hgt/8))+8, ((menu_Wid*0.75)/8)-8:    Print using "Fuel: ###.#"; Ship(2).Fuel_Mass
        
        ''  flip screens and start all over...
        Swap P2, P1
        Screenset P2, P1 
        
    End if
    
    sleep 1, 1
    
Loop Until Multikey(1)

End

'' draw ship
Sub DrawShip (Byval Buffer as Integer, Byval X as Double, Byval Y as Double, Byval Direction as Double, _
    Byval R as Integer, Byval G as Integer, Byval B as Integer)

    dim head as double = 0
    dim rght as double = 228
    dim tail as double = 180
    dim l3ft as double = 132
    dim size as double = 14*Scrn(buffer).Zoom
    dim oldx as double
    dim oldy as double

    'Xpos = X_Center+(.x-Ship(buffer).X)*Scrn(i).Zoom
    'Ypos = Y_Center+(.y-Ship(buffer).Y)*Scrn(i).Zoom
    Xpos = X_Center+((Scrn(i).Cos_Ang*(Ship(i).X-.X))-(Scrn(i).Sin_Ang*(Ship(i).Y-.Y)))*Scrn(i).Zoom
    Ypos = Y_Center+((Scrn(i).Cos_Ang*(Ship(i).Y-.Y))+(Scrn(i).Sin_Ang*(Ship(i).X-.X)))*Scrn(i).Zoom
    'Xpos = X_Center+(X-Ship(buffer).X)*Scrn(buffer).Zoom
    'Ypos = Y_Center+(Y-Ship(buffer).Y)*Scrn(buffer).Zoom
    Color RGB(R, G, B)
    Rec (size, head-Direction)
    oldx = Xrec: oldy = Yrec
    Rec (size, rght-Direction)
    Line Scrn(Buffer).Content, (Xpos+oldx, Ypos+oldy)-(Xpos+Xrec, Ypos+Yrec)
    Rec (size*0.5, tail-Direction)
    Line Scrn(Buffer).Content, -(Xpos+Xrec, Ypos+Yrec)
    Rec (size, l3ft-Direction)
    Line Scrn(Buffer).Content, -(Xpos+Xrec, Ypos+Yrec)
    Line Scrn(Buffer).Content, -(Xpos+oldx, Ypos+oldy)
    Paint Scrn(Buffer).Content,(Xpos, Ypos), RGB(R, G, B)

End Sub

Sub DrawRocket (Byval Buffer as Integer, Byval X as Double, Byval Y as Double, Byval Direction as Double, _
    Byval R as Integer, Byval G as Integer, Byval B as Integer)
    
    dim head as double = 0
    dim rght as double = 200
    dim l3ft as double = 160
    dim size as double = 7*Scrn(buffer).Zoom
    dim oldx as double
    dim oldy as double

    Xpos = X_Center+(X-Ship(buffer).X)*Scrn(buffer).Zoom
    Ypos = Y_Center+(Y-Ship(buffer).Y)*Scrn(buffer).Zoom
    Color RGB(R, G, B)
    Rec (size, head-Direction)
    oldx = Xrec: oldy = Yrec
    Rec (size, rght-Direction)
    Line Scrn(Buffer).Content, (Xpos+oldx, Ypos+oldy)-(Xpos+Xrec, Ypos+Yrec)
    Rec (size, l3ft-Direction)
    Line Scrn(Buffer).Content, -(Xpos+Xrec, Ypos+Yrec)
    Line Scrn(Buffer).Content, -(Xpos+oldx, Ypos+oldy)
    Paint Scrn(Buffer).Content,(Xpos, Ypos), RGB(R, G, B)
    Line Scrn(Buffer).Content, -(Xpos+oldx, Ypos+oldy)
    Circle Scrn(Buffer).Content, (Xpos+oldX, Ypos+oldY), Scrn(buffer).Zoom, RGB(144, 32, 32),,,1,f
    
End Sub
