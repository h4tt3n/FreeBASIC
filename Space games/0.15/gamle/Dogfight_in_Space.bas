''                             Dogfight in Space
''                                   by
''                           Michael S. Nissen
''                
''                        v. 1.00 - February 2006
''                       micha3l_niss3n@yahoo.dk

Option explicit

#include "Dogfight_in_Space.bi"

Randomize Timer

Dim P1_Particle(500) as Particle
Dim P2_Particle(500) as Particle
Dim P1_Projectile(50) as Projectile
Dim P2_Projectile(50) as Projectile
Dim P1_Burst(50) as Burst
Dim P2_Burst(50) as Burst
Dim Asteroid(100) as Asteroid
Dim Planet(1) As Planet

Dim Station(1) As Station
Dim Ship(1) As Ship
Dim Player(1) as Player

For i = 0 to Ubound(P1_Particle)
    With P1_Particle(i)
        .Speed = Rnd*8
        .Direction = Rnd*(2*pi)
        .XVec = .Speed*Cos(.Direction)
        .YVec = .Speed*Sin(-.Direction)
        .State = 0
        .Time = 20+Rnd*120
        .R = 255
        .G = 255
        .B = 255
    End With
Next

For i = 0 to Ubound(P2_Particle)
    With P2_Particle(i)
        .Speed = Rnd*8
        .Direction = Rnd*(2*pi)
        .XVec = .Speed*Cos(.Direction)
        .YVec = .Speed*Sin(-.Direction)
        .State = 0
        .Time = 20+Rnd*120
        .R = 255
        .G = 255
        .B = 255
    End With
Next

For i = 0 to Ubound(P1_Projectile)
    With P1_Projectile(i)
        .Speed = 3
        .State = 0
        .Time = 500
        .R = 255
        .G = 255
        .B = 255
    End With
Next

For i = 0 to Ubound(P2_Projectile)
    With P2_Projectile(i)
        .Speed = 3
        .State = 0
        .Time = 500
        .R = 255
        .G = 255
        .B = 255
    End With
Next

For i = 0 to Ubound(P1_Burst)
    With P1_Burst(i)
        .Speed = 0.01+Rnd*4.99
        .State = 0
        .Time = 40
        .R = 255
        .G = 255
        .B = 255
    End With
Next

For i = 0 to Ubound(P2_Burst)
    With P2_Burst(i)
        .Speed = 0.01+Rnd*4.99
        .State = 0
        .Time = 40
        .R = 255
        .G = 255
        .B = 255
    End With
Next

''  The sun
With Planet(0) 
    .X = MidX 
    .Y = MidY 
    .Mass = 5e14
    .Radius = 48
    .State = 1
End With 

''  inner planet
With Planet(1)
    .Orbit_Radius = 500
    .Angle = Rnd*(Pi*2)
    .X = MidX-.Orbit_Radius*Sin(.Angle) 
    .Y = MidY-.Orbit_Radius*Cos(.Angle) 
    .Mass = 2e12
    .Radius = 48
    .XVec = sqr((Gravity*Planet(0).Mass)/(.Orbit_Radius))*Cos(.Angle)
    .YVec = sqr((Gravity*Planet(0).Mass)/(.Orbit_Radius))*Sin(-.Angle)
    .State = 1
    .R = 64
    .G = 32
    .B = 8
End With 

'' Asteroids 
For i = 0 To Ubound(Asteroid)
    With Asteroid(i) 
        .Angle = Rnd*(2*Pi)
        .Orbit_Radius = 500+Rnd*10
        .X = MidX-.Orbit_Radius*Sin(.Angle) 
        .Y = MidY-.Orbit_Radius*Cos(.Angle) 
        .Mass = 5+rnd*4995
        .Density = 2.5+Rnd*4.5
        .Radius = (((.mass/.Density)/(4/3)*pi)^(1/3))
        .XVec = -sqr((Gravity*(Planet(0).Mass))/(.Orbit_Radius))*Cos(.Angle)
        .YVec = -sqr((Gravity*(Planet(0).Mass))/(.Orbit_Radius))*Sin(-.Angle)
        If Int(Rnd*3) = 0 Then 
            .XVec =- .XVec 
            .YVec =- .YVec 
        End If
        .State = 1
        .R = 128+Rnd*64
        .G = .R-16+Rnd*16
        .B = .G-16+Rnd*16
    End With 
Next   

''  Player 1's Base
For i = 0 to Ubound(Station)
    With Station(i)
        .Orbit_Radius = 1000
        .Angle = i*pi
        .X = MidX-.Orbit_Radius*Sin(.Angle) 
        .Y = MidY-.Orbit_Radius*Cos(.Angle) 
        .Mass = 3e11
        .Radius = 32
        .XVec = sqr(Gravity*(Planet(0).Mass)/(.Orbit_Radius))*Cos(.Angle)
        .YVec = sqr(Gravity*(Planet(0).Mass)/(.Orbit_Radius))*Sin(-.Angle)
        .Shield_Minsize = 96
        .Shield_Strength = 200
        .Shield_State = 1
        .State = 1
        .R = 224
        .G = 128
        .B = 64
    End With 
Next

''  player 1's ship
For i = 0 to Ubound(Ship)
    With Ship(i)
        .Angle = 0
        .Orbit_Radius = 192
        .X = Station(i).X-.Orbit_Radius*Sin(.Angle)
        .Y = Station(i).Y-.Orbit_Radius*Cos(.Angle) 
        .Fuel_Mass = 150
        .Mass = 500 + .Fuel_Mass
        .Payload_Mass = 0
        .Direction = Rnd*(toxpi)
        .Radius = 16
        .XVec = Station(i).Xvec-sqr((Gravity*Station(i).Mass)/.Orbit_Radius)*Cos(.Angle)
        .YVec = Station(i).Yvec-sqr((Gravity*Station(i).Mass)/.Orbit_Radius)*Sin(-.Angle)
        .Shield_Minsize = 20
        .Shield_Strength = 0
        .Shield_State = 0
        .State = 1
        .R = 112
        .G = 96
        .B = 96
    End With 
Next

''  Detect screen settings and apply them to the game
Screeninfo screen_x, screen_y,,,,Screen_Rate
screenres screen_x, screen_y, 16, 2, 1

Screen_X_Mid = 0.5 * Screen_X
Screen_Y_Mid = 0.5 * Screen_Y

''  calculate reasonable grid size and scale values for minimap
For i = 0 to Ubound(Planet)
    If Planet(i).Orbit_Radius > i2 then i2 = Planet(i).Orbit_Radius
Next
For i = 0 to Ubound(Station)
    If Station(i).Orbit_Radius > i2 then i2 = Station(i).Orbit_Radius
Next
For i = 0 to Ubound(Asteroid)
    If Asteroid(i).Orbit_Radius > i2 then i2 = Asteroid(i).Orbit_Radius
Next

Grid_Dist = screen_y*1.25
Grid_Num = int((i2/Grid_Dist)*1.2)
Grid_Radius = Grid_Num*Grid_Dist

Dim Ellipse(Grid_Num) as Ellipse

For i = 0 to Ubound(Ellipse)
    With Ellipse(i)
        .X = 0
        .Y = 0
        .Hgt = (i+1)*Grid_Dist
        .Wid = .Hgt
        .Ang = 0
        .Col = RGB(6, 36, 6)
        .num_lines = toxpi/270'toxpi/((2*.Hgt*pi)/180)
    End With
Next

Dim Radian(21) as Radian

For i = 0 to 2
    With Radian(i)
        .X1 = -(Cos(60*i*radtodeg)*Grid_Dist*(Grid_Num))
        .Y1 = -(Sin(60*i*radtodeg)*Grid_Dist*(Grid_Num))
        .X2 = +(Cos(60*i*radtodeg)*Grid_Dist*(Grid_Num))
        .Y2 = +(Sin(60*i*radtodeg)*Grid_Dist*(Grid_Num))
    End With
Next
For i = 3 to 8
    With Radian(i)
        .X1 = -(Cos(((60*i)+30)*radtodeg)*Grid_Dist*(Grid_Num))
        .Y1 = -(Sin(((60*i)+30)*radtodeg)*Grid_Dist*(Grid_Num))
        .X2 = -(Cos(((60*i)+30)*radtodeg)*(Grid_Dist*(1)))
        .Y2 = -(Sin(((60*i)+30)*radtodeg)*(Grid_Dist*(1)))
    End With
Next
For i = 9 to 21
    With Radian(i)
        .X1 = -(Cos(((30*i)+15)*radtodeg)*Grid_Dist*(Grid_Num))
        .Y1 = -(Sin(((30*i)+15)*radtodeg)*Grid_Dist*(Grid_Num))
        .X2 = -(Cos(((30*i)+15)*radtodeg)*(Grid_Dist*(3)))
        .Y2 = -(Sin(((30*i)+15)*radtodeg)*(Grid_Dist*(3)))
    End With
Next

Setmouse ,,0

Do 
    
    screenset page, page xor 1 
    page xor = 1 
    cls
    
    ''  Spaceship controls
    For i = 0 to Ubound(Ship)
        If Ship(i).State = 1 Then
            
            ''  toggle ship turn left/right
            If multikey (75) then 
                Ship(0).Direction += 4: If Ship(i).Direction >= 360 then Ship(i).Direction -= 360
                Rec (8, 180-Ship(i).Direction)
                Ship(i).Xtrac = Xrec
                Ship(i).Ytrac = Yrec
            End If
            If multikey (77) then 
                Ship(i).Direction -= 4: If Ship(i).Direction < 0 then Ship(i).Direction += 360
                Rec (8, 180-Ship(i).Direction)
                Ship(i).Xtrac = Xrec
                Ship(i).Ytrac = Yrec
            End If
            
            ''  toggle ship thrust
            If multikey (72) then
                If Ship(i).Fuel_Mass >= 0.01 then
                    Ship(i).Xvec += 20*(Cos(Ship(i).Direction*Radtodeg)/Ship(i).Mass)
                    Ship(i).Yvec += 20*(Sin(-Ship(i).Direction*Radtodeg)/Ship(i).Mass)
                    Ship(i).Fuel_Mass -= 0.01
                    Ship(i).Mass -= 0.01
                    For i = 0 to Ubound(P1_Burst)
                        If Burst(i).State = 0 Then
                            Burst(i).Direction = Ship(i).Direction+(Rnd*7.5-Rnd*7.5)
                            Burst(i).XVec = (Burst(i).Speed*Cos(Burst(i).Direction*Radtodeg))-Ship(i).Xvec
                            Burst(i).YVec = (Burst(i).Speed*Sin(-Burst(i).Direction*Radtodeg))-Ship(i).Yvec
                            Burst(i).X = Ship(i).Xtrac+Ship(i).X
                            Burst(i).Y = Ship(i).Ytrac+Ship(i).Y
                            Burst(i).TimeLeft = Burst(i).Time
                            Burst(i).State = 1
                            Exit For
                        End If
                    Next
                End If
            End If
            
            ''  toggle ship gun
            If Multikey(54) Then
                If Timer > Wait_Time7 Then
                    For i = 0 to Ubound(Projectile)
                        If Projectile(i).State = 0 Then
                            Projectile(i).Direction = Ship(i).Direction+180
                            Projectile(i).XVec = (Projectile(i).Speed*Cos(Projectile(i).Direction*Radtodeg))-Ship(i).Xvec
                            Projectile(i).YVec = (Projectile(i).Speed*Sin(-Projectile(i).Direction*Radtodeg))-Ship(i).Yvec
                            Projectile(i).X = Ship(i).X
                            Projectile(i).Y = Ship(i).Y
                            Projectile(i).TimeLeft = Projectile(i).Time
                            Projectile(i).State = 1
                            Exit For
                        End If
                    Next
                End If
                Wait_Time7 = Timer + 0.04
            End If
            
            ''  toggle asteroid pick up on/off
            If multikey (80) then 
                If Timer > Wait_Time0 and Payload_State = 1 Then
                    swap Payload_Val0, Payload_Val1
                    Payload_State = Payload_Val0
                    Ship(i).Payload_Mass = 0
                    Pay_Num = 0
                    Wait_Time0 = Timer + 0.1
                End If
                For i = 0 to Ubound(Emerald)
                    If Emerald(i).State = 1 Then
                        Distance = sqr(((Emerald(i).Y-Ship(i).Y)^2) + ((Emerald(i).X-Ship(i).X)^2))
                        If Distance <= 70 and Payload_State = 0 and Timer > Wait_Time0 then
                            swap Payload_Val0, Payload_Val1
                            Payload_State = Payload_Val0
                            Pay_Num = i
                            Ship(i).Payload_Mass = Emerald(i).Mass
                        End If
                    End If
                Next
                Wait_Time0 = Timer + 0.1
            End If
            
            ''  toggle shield and shock-wave (temporary)
            If Multikey(83) Then
                If Ship(i).Fuel_Mass >= 0.5 and Wait_Time1 < Timer Then
                    Ship(i).Shield_Strength += 1
                    Ship(i).Shock_Strength += 25
                    Ship(i).Fuel_Mass -= 0.5
                    Ship(i).Mass -= 0.5
                End If
                If Ship(i).Shield_State = 1 Then
                    Ship(i).Shock_State = 1
                    Ship(i).Shield_State = 0
                    Ship(i).Shield_Strength = 0
                    Wait_Time1 = Timer + 0.1
                End If
            End If
            If Multikey(83) = 0 and Ship(i).Shield_Strength > 0 Then
                Ship(i).Shield_State = 1
            End If
            
            ''  update shield strength and shock-wave strength
            If Ship(i).Shield_State = 1 Then
                Ship(i).Shield_Strength -= 0.01
                Ship(i).Shock_Strength -= 0.25
                If Ship(i).Shield_Strength <= 0 Then 
                    Ship(i).Shield_State = 0
                    Ship(i).Shield_Strength = 0
                End If
            End If
            
        End If
    Next
    
    If Ship(0).State = 0 Then
        
        If Multikey(54) Then
            Ship(0).X = Station(0).X-Ship(0).Orbit_Radius*Sin(Ship(0).Angle)
            Ship(0).Y = Station(0).Y-Ship(0).Orbit_Radius*Cos(Ship(0).Angle) 
            Ship(0).Fuel_Mass = 150
            Ship(0).Mass = 500 + Ship(0).Fuel_Mass
            Ship(0).Payload_Mass = 0
            Ship(0).XVec = Station(0).Xvec-sqr((Gravity*Station(0).Mass)/Ship(0).Orbit_Radius)*Cos(Ship(0).Angle)
            Ship(0).YVec = Station(0).Yvec-sqr((Gravity*Station(0).Mass)/Ship(0).Orbit_Radius)*Sin(-Ship(0).Angle)
            Ship(0).Shield_State = 0
            Ship(0).Shield_Strength = 0
            Ship(0).State = 1
        End If
        
        If Multikey(28) then goto Restart
    
    End If
    
    ''  calculate gravitational influence
    For i = 0 To Ubound(Planet)
        For i2 = i+1 To Ubound(Planet)
            If Planet(i).State = 1 and Planet(i2).State = 1 Then
                Distance = sqr(((Planet(i).Y-Planet(i2).Y)^2) + ((Planet(i).X-Planet(i2).X)^2))
                MinDist = Planet(i).Radius+Planet(i2).Radius
                    If Distance < MinDist then
                        Distance = MinDist'Planet(i2).State = 0
                        If Payload_State = 1 and i2 = Pay_Num Then 
                            Payload_State = 0
                            Ship(0).Payload_Mass = 0
                            swap Payload_Val0, Payload_Val1
                        End If
                    End If
                Gforce = Gravity*((Planet(i).Mass*Planet(i2).Mass)/(Distance^2))
                Planet(i).Xvec -= ((Planet(i).X-Planet(i2).X)/Distance)*(Gforce/Planet(i).Mass)
                Planet(i).Yvec -= ((Planet(i).Y-Planet(i2).Y)/Distance)*(Gforce/Planet(i).Mass) 
                Planet(i2).Xvec -= ((Planet(i2).X-Planet(i).X)/Distance)*(Gforce/Planet(i2).Mass)
                Planet(i2).Yvec -= ((Planet(i2).Y-Planet(i).Y)/Distance)*(Gforce/Planet(i2).Mass)
            End If
        Next
        For i2 = 0 To Ubound(Ship)  '' from 0 to # of ships
            If Planet(i).State = 1 and Ship(i2).State = 1 Then
                Distance = sqr(((Planet(i).Y-Ship(i2).Y)^2) + ((Planet(i).X-Ship(i2).X)^2))
                MinDist = Planet(i).Radius+Ship(i2).Radius
                    If Distance < MinDist then
                        Distance = MinDist
                    End If
                Gforce = Gravity*((Planet(i).Mass*Ship(i2).Mass)/(Distance^2))
                Ship(i2).Xvec -= ((Ship(i2).X-Planet(i).X)/Distance)*(Gforce/Ship(i2).Mass)
                Ship(i2).Yvec -= ((Ship(i2).Y-Planet(i).Y)/Distance)*(Gforce/Ship(i2).Mass)
                Planet(i).Xvec -= ((Planet(i).X-Ship(i2).X)/Distance)*(Gforce/Planet(i).Mass)
                Planet(i).Yvec -= ((Planet(i).Y-Ship(i2).Y)/Distance)*(Gforce/Planet(i).Mass)
            End If
        Next
        For i2 = 0 To Ubound(Station)  '' from 0 to # of stations
            If Planet(i).State = 1 and Station(i2).State = 1 Then
                Distance = sqr(((Planet(i).Y-Station(i2).Y)^2) + ((Planet(i).X-Station(i2).X)^2))
                MinDist = Planet(i).Radius+Station(i2).Radius
                    If Distance < MinDist then
                        Distance = MinDist
                    End If
                Gforce = Gravity*((Planet(i).Mass*Station(i2).Mass)/(Distance^2))
                Station(i2).Xvec -= ((Station(i2).X-Planet(i).X)/Distance)*(Gforce/Station(i2).Mass)
                Station(i2).Yvec -= ((Station(i2).Y-Planet(i).Y)/Distance)*(Gforce/Station(i2).Mass)
                Planet(i).Xvec -= ((Planet(i).X-Station(i2).X)/Distance)*(Gforce/Planet(i).Mass)
                Planet(i).Yvec -= ((Planet(i).Y-Station(i2).Y)/Distance)*(Gforce/Planet(i).Mass)
            End If
        Next
        For i2 = 0 To Ubound(Asteroid)  '' from 0 to # of asteroids
            If Planet(i).State = 1 and Asteroid(i2).State = 1 Then
                Distance = sqr(((Planet(i).Y-Asteroid(i2).Y)^2) + ((Planet(i).X-Asteroid(i2).X)^2))
                MinDist = Planet(i).Radius+Asteroid(i2).Radius
                    If Distance < MinDist then
                        Distance = MinDist
                    End If
                Gforce = Gravity*((Planet(i).Mass*Asteroid(i2).Mass)/(Distance^2))
                Asteroid(i2).Xvec -= ((Asteroid(i2).X-Planet(i).X)/Distance)*(Gforce/Asteroid(i2).Mass)
                Asteroid(i2).Yvec -= ((Asteroid(i2).Y-Planet(i).Y)/Distance)*(Gforce/Asteroid(i2).Mass)
                Planet(i).Xvec -= ((Planet(i).X-Asteroid(i2).X)/Distance)*(Gforce/Planet(i).Mass)
                Planet(i).Yvec -= ((Planet(i).Y-Asteroid(i2).Y)/Distance)*(Gforce/Planet(i).Mass)
            End If
        Next
    Next
    For i = 0 to Ubound(Station)
        For i2 = 0 To Ubound(Ship)  '' from 0 to # of ships
            If Station(i).State = 1 and Ship(i2).State = 1 Then
                Distance = sqr(((Station(i).Y-Ship(i2).Y)^2) + ((Station(i).X-Ship(i2).X)^2))
                MinDist = Station(i).Radius+Ship(i2).Radius
                    If Distance < MinDist then
                        Distance = MinDist
                    End If
                Gforce = Gravity*((Station(i).Mass*Ship(i2).Mass)/(Distance^2))
                Ship(i2).Xvec -= ((Ship(i2).X-Station(i).X)/Distance)*(Gforce/Ship(i2).Mass)
                Ship(i2).Yvec -= ((Ship(i2).Y-Station(i).Y)/Distance)*(Gforce/Ship(i2).Mass)
                Station(i).Xvec -= ((Station(i).X-Ship(i2).X)/Distance)*(Gforce/Station(i).Mass)
                Station(i).Yvec -= ((Station(i).Y-Ship(i2).Y)/Distance)*(Gforce/Station(i).Mass)
            End If
        Next
        For i2 = 0 To Ubound(Asteroid)  '' from 0 to # of asteroids
            If Station(i).State = 1 and Asteroid(i2).State = 1 Then
                Distance = sqr(((Station(i).Y-Asteroid(i2).Y)^2) + ((Station(i).X-Asteroid(i2).X)^2))
                MinDist = Station(i).Radius+Asteroid(i2).Radius
                    If Distance < MinDist then
                        Distance = MinDist
                    End If
                Gforce = Gravity*((Station(i).Mass*Asteroid(i2).Mass)/(Distance^2))
                Asteroid(i2).Xvec -= ((Asteroid(i2).X-Station(i).X)/Distance)*(Gforce/Asteroid(i2).Mass)
                Asteroid(i2).Yvec -= ((Asteroid(i2).Y-Station(i).Y)/Distance)*(Gforce/Asteroid(i2).Mass)
                Station(i).Xvec -= ((Station(i).X-Asteroid(i2).X)/Distance)*(Gforce/Station(i).Mass)
                Station(i).Yvec -= ((Station(i).Y-Asteroid(i2).Y)/Distance)*(Gforce/Station(i).Mass)
            End If
        Next
    Next
    
    ''  calculate planet asteroid deflection shield
    For i = 0 to Ubound(Station)
        If Station(i).Shield_State = 1 Then
            For i2 = 0 to Ubound(Asteroid)
                If Asteroid(i2).State = 1 Then
                    Distance = sqr(((Asteroid(i2).Y-Station(i).Y)^2) + ((Asteroid(i2).X-Station(i).X)^2))
                    If Distance <= Station(i).Shield_Minsize+Asteroid(i2).Radius Then
                        Asteroid(i2).Xvec += (300*((Asteroid(i2).X-Station(i).X)/Distance))/Asteroid(i2).Mass
                        Asteroid(i2).Yvec += (300*((Asteroid(i2).Y-Station(i).Y)/Distance))/Asteroid(i2).Mass
                        Station(i).Xvec += (300*((Station(i).X-Asteroid(i2).X)/Distance))/Station(i).Mass
                        Station(i).Yvec += (300*((Station(i).Y-Asteroid(i2).Y)/Distance))/Station(i).Mass
                    End If
                End If
            Next
            For i2 = 0 to Ubound(Projectile)
                If Projectile(i2).State = 1 Then
                    Distance = sqr(((Projectile(i2).Y-Station(i).Y)^2) + ((Projectile(i2).X-Station(i).X)^2))
                    If Distance <= Station(i).Shield_Minsize Then
                        Projectile(i2).Xvec += -0.2*((Projectile(i2).X-Station(i).X)/Distance)
                        Projectile(i2).Yvec += -0.2*((Projectile(i2).Y-Station(i).Y)/Distance)
                    End If
                End If
            Next
        End If
    Next
    
    ''  center screen on ship x-y coordinates
    MidX = (Ship(0).X-Ship(1).X)*0.5
    MidY = (Ship(0).Y-Ship(1).Y)*0.5
    
    ''  draw grid
    If Grid_State = 1 Then
        For i = 0 to Grid_Num-1
            DrawEllipse(Ellipse(i).X+MidX, Ellipse(i).Y+MidY, Ellipse(i).Hgt, Ellipse(i).Wid, 0, Ellipse(i).Col, Ellipse(i).num_lines)
        Next
        For i = 0 To Ubound(Radian)
            Line(Radian(i).X1+MidX, Radian(i).Y1+MidY)-(Radian(i).X2+MidX, Radian(i).Y2+MidY), RGB(6, 36, 6)
        Next
    End If
    
    ''  draw sun
    ''  uncomment next two lines to make sun react on gravitiational influence
    ''  keep them commented to keep sun fixed in centre of map
    'Planet(0).X += Planet(0).XVec
    'Planet(0).Y += Planet(0).YVec
    Circle (Planet(0).X+MidX, Planet(0).Y+MidY), 128, Rgb(255, 104, 0),,,1,f
    Circle (Planet(0).X+MidX, Planet(0).Y+MidY), 126, Rgb(255, 240, 160),,,1,f
    Circle (Planet(0).X+MidX, Planet(0).Y+MidY), 122, Rgb(255, 255, 255),,,1,f
    
    '' draw planets
    For i = 1 To Ubound(Planet)
        If Planet(i).State = 1 Then
            Planet(i).X+=Planet(i).XVec 
            Planet(i).Y+=Planet(i).YVec
            R = Planet(i).R 
            G = Planet(i).G 
            B = Planet(i).B 
            Circle(Planet(i).X+MidX, Planet(i).Y+MidY), Planet(i).Radius, Rgb(R,G,B),,,1,F
        End If
    Next 
    
    ''  draw stations
    For i = 0 to Ubound(Station)
        If Station(i).State = 1 Then
            Station(i).X+=Station(i).XVec
            Station(i).Y+=Station(i).YVec 
            R = Station(i).R 
            G = Station(i).G 
            B = Station(i).B 
            Circle(Station(i).X+MidX, Station(i).Y+MidY), Station(i).Radius, Rgb(R,G,B),,,1,F
        End If
    Next
    
    '' draw asteroids
    For i = 0 To Ubound(Asteroid)
        If Asteroid(i).State = 1 Then
            Asteroid(i).X+=Asteroid(i).XVec 
            Asteroid(i).Y+=Asteroid(i).YVec
            R = Asteroid(i).R 
            G = Asteroid(i).G 
            B = Asteroid(i).B 
            Circle(Asteroid(i).X+MidX, Asteroid(i).Y+MidY), Asteroid(i).Radius, Rgb(R,G,B),,,1,F
        End If
    Next 
    
    '' draw ships
    For i = 0 to Ubound(Ship)
        If Ship(i).State = 1 Then
            Ship(i).X+=Ship(i).XVec
            Ship(i).Y+=Ship(i).YVec 
            R = Ship(i).R 
            G = Ship(i).G 
            B = Ship(i).B 
            Drawship (Ship(i).X+MidX, Ship(i).Y+MidY, Ship(i).Direction, Rgb(R,G,B))
        End If
    Next
    
Loop until Multikey(1)

End
