''                             GRAVITY WARS 
''                                  by
''                           Michael S. Nissen
''                
''                        v. 1.00 - December 2005
''                        micha3l_niss3n@yahoo.dk

'Option Explicit 

Restart:

#Include "Gravity_Wars.bi"

Randomize Timer

Dim Particle(500) as Particle

For i = 0 to Ubound(Particle)
    With Particle(i)
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

Dim Projectile(50) as Projectile

For i = 0 to Ubound(Projectile)
    With Projectile(i)
        .Speed = 3
        .State = 0
        .Time = 500
        .R = 255
        .G = 255
        .B = 255
    End With
Next

Dim Burst(100) as Burst

For i = 0 to Ubound(Burst)
    With Burst(i)
        .Speed = 0.01+Rnd*4.99
        .State = 0
        .Time = 40
        .R = 255
        .G = 255
        .B = 255
    End With
Next

Dim Planet(2) As Planet

''  The sun
With Planet(0) 
    .X = MidX 
    .Y = MidY 
    .Mass = 5e13
    .Radius = 48
    .State = 1
End With 

Dim Asteroid(500) as Asteroid

'' Asteroids 
For i = 0 To Ubound(Asteroid)
    With Asteroid(i) 
        .Angle = Rnd*(2*Pi)
        .Orbit_Radius = 5000+Rnd*1000
        .X = MidX-.Orbit_Radius*Sin(.Angle) 
        .Y = MidY-.Orbit_Radius*Cos(.Angle) 
        .Mass = 5+rnd*4995
        .Density = 2.5+Rnd*4.5
        .Radius = (((.mass/.Density)/(4/3)*pi)^(1/3))
        .XVec = -sqr((Gravity*(Planet(0).Mass))/(.Orbit_Radius))*Cos(.Angle)
        .YVec = -sqr((Gravity*(Planet(0).Mass))/(.Orbit_Radius))*Sin(-.Angle)
        If Int(Rnd*20) = 0 Then 
            .XVec =- .XVec 
            .YVec =- .YVec 
        End If
        .State = 1
        .R = 128+Rnd*64
        .G = .R-16+Rnd*16
        .B = .G-16+Rnd*16
    End With 
Next 

Dim Emerald(50) as Emerald

'' Emerald Asteroids
For i = 0 To Ubound(Emerald)
    With Emerald(i) 
        .Angle = Rnd*(2*Pi)
        .Orbit_Radius = 5000+Rnd*500
        .X = MidX-.Orbit_Radius*Sin(.Angle) 
        .Y = MidY-.Orbit_Radius*Cos(.Angle) 
        .Mass = 150+Rnd*850
        .Density = 3.5+Rnd*3
        .Radius = (((.mass/.Density)/(4/3)*pi)^(1/3))
        .XVec = -sqr((Gravity*(Planet(0).Mass))/(.Orbit_Radius))*Cos(.Angle)
        .YVec = -sqr((Gravity*(Planet(0).Mass))/(.Orbit_Radius))*Sin(-.Angle)
        If Int(Rnd*25) = 0 Then 
            .XVec =- .XVec 
            .YVec =- .YVec 
        End If
        .State = 1
        .R = 160+(rnd*56-rnd*56)
        .G = 56+(rnd*12-rnd*12)
        .B = 160+(rnd*56-rnd*56)
    End With 
Next  

Dim Station(0) As Station

''  Player 1's Base
With Station(0)
    .Orbit_Radius = 8000
    .Angle = Rnd*(Pi*2)
    .X = MidX-.Orbit_Radius*Sin(.Angle) 
    .Y = MidY-.Orbit_Radius*Cos(.Angle) 
    .Mass = 3e11
    .Radius = 128
    .XVec = sqr(Gravity*(Planet(0).Mass+.mass)/(.Orbit_Radius))*Cos(.Angle)
    .YVec = sqr(Gravity*(Planet(0).Mass+.mass)/(.Orbit_Radius))*Sin(-.Angle)
    .Shield_Minsize = 320
    .Shield_Strength = 200
    .Shield_State = 1
    .State = 1
    .R = 224
    .G = 128
    .B = 64
End With 

Dim Ship(0) As Ship

''  player 1's ship
With Ship(0)
    .Angle = 0
    .Orbit_Radius = 192
    .X = Station(0).X-.Orbit_Radius*Sin(.Angle)
    .Y = Station(0).Y-.Orbit_Radius*Cos(.Angle) 
    .Fuel_Mass = 150
    .Mass = 500 + .Fuel_Mass
    .Payload_Mass = 0
    .Direction = Rnd*(toxpi)
    .Radius = 16
    .XVec = Station(0).Xvec-sqr((Gravity*Station(0).Mass)/.Orbit_Radius)*Cos(.Angle)
    .YVec = Station(0).Yvec-sqr((Gravity*Station(0).Mass)/.Orbit_Radius)*Sin(-.Angle)
    .Shield_Minsize = 25
    .Shield_Strength = 0
    .Shield_State = 0
    .State = 1
    .R = 112
    .G = 96
    .B = 96
End With 

''  home planet's moon
With Planet(1) 
    .Angle = Rnd*(Pi*2) 
    .Orbit_Radius = 1000
    .Mass = 1e10
    .X = Station(0).X-.Orbit_Radius*Sin(.Angle) 
    .Y = Station(0).Y-.Orbit_Radius*Cos(.Angle) 
    .Radius = 28
    .XVec = Station(0).Xvec-sqr((Gravity*(Station(0).Mass+.mass))/.Orbit_Radius)*Cos(.Angle) 
    .YVec = Station(0).Yvec-sqr((Gravity*(Station(0).Mass+.mass))/.Orbit_Radius)*Sin(-.Angle) 
    .State = 1
    .R = 64
    .G = 64
    .B = 64
End With 

''  inner planet
With Planet(2)
    .Orbit_Radius = 4000
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

Dim Comet(0) as Comet

With Comet(0)
    .Angle = Rnd*(2*Pi)
    .Orbit_Radius = 10000
    .X = MidX-.Orbit_Radius*Sin(.Angle) 
    .Y = MidY-.Orbit_Radius*Cos(.Angle) 
    .Mass = 1.5e3
    .Density = 1.5
    .Radius = (((.mass/.Density)/(4/3)*pi)^(1/3))
    .XVec = -0.5*sqr((Gravity*(Planet(0).Mass))/(.Orbit_Radius))*Cos(.Angle)
    .YVec = -0.5*sqr((Gravity*(Planet(0).Mass))/(.Orbit_Radius))*Sin(-.Angle)
    .State = 1
    .R = 224
    .G = 224
    .B = 224
End With

Dim Comet_Debris(400) as Comet_Debris

For i = 0 to Ubound(Comet_Debris)
    With Comet_Debris(i)
        .State = 0
        .Density = 1.5
        .mass = 0.5+Rnd*9.5
        .Radius = (((.mass/.Density)/(4/3)*pi)^(1/3))
        .Time = 1e5+Rnd*9e5
        .R = 192+(Rnd*64-Rnd*64)
        .G = .R
        .B = .R
    End With
Next

Dim Comet_Particle(3000) as Comet_Particle

For i = 0 to Ubound(Comet_Particle)
    With Comet_Particle(i)
        .Speed = 0.05+Rnd*0.45
        .State = 0
        .Time = 300+Rnd*150
        .R = 255
        .G = 255
        .B = 255
    End With
Next

''  Detect screen settings and apply them to the game
Screeninfo screen_x, screen_y,,,,Screen_Rate
screenres screen_x, screen_y, 16, 2, 1

screen_update = 1/screen_rate

Screen_X_Mid = 0.5 * Screen_X
Screen_Y_Mid = 0.5 * Screen_Y

MidX = Screen_X_Mid
MidY = Screen_Y_Mid

Map_Radius = Int((1/5.2)*Screen_Y)
Map_X_Mid = Map_Radius
Map_Y_Mid = Screen_Y - (Map_Radius+1)

Compass_Radius = 0.4*Map_Radius
Compass_X_Mid = Compass_Radius
Compass_Y_Mid = 0.55*Screen_Y

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
For i = 0 to Ubound(Emerald)
    If Emerald(i).Orbit_Radius > i2 then i2 = Emerald(i).Orbit_Radius
Next
For i = 0 to Ubound(Comet)
    If Comet(i).Orbit_Radius > i2 then i2 = Comet(i).Orbit_Radius
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

Dim Radian(95) as Radian

For i = 0 to 2
    With Radian(i)
        .X1 = -(Cos(60*i*radtodeg)*Grid_Dist*Grid_Num)
        .Y1 = -(Sin(60*i*radtodeg)*Grid_Dist*Grid_Num)
        .X2 = +(Cos(60*i*radtodeg)*Grid_Dist*Grid_Num)
        .Y2 = +(Sin(60*i*radtodeg)*Grid_Dist*Grid_Num)
    End With
Next
If Grid_Num > 2 Then
    For i = 3 to 8
        With Radian(i)
            .X1 = -(Cos(((60*i)+30)*radtodeg)*Grid_Dist*Grid_Num)
            .Y1 = -(Sin(((60*i)+30)*radtodeg)*Grid_Dist*Grid_Num)
            .X2 = -(Cos(((60*i)+30)*radtodeg)*(Grid_Dist*2))
            .Y2 = -(Sin(((60*i)+30)*radtodeg)*(Grid_Dist*2))
        End With
    Next
End If
If Grid_Num > 4 Then
    For i = 9 to 21
        With Radian(i)
            .X1 = -(Cos(((30*i)+15)*radtodeg)*Grid_Dist*Grid_Num)
            .Y1 = -(Sin(((30*i)+15)*radtodeg)*Grid_Dist*Grid_Num)
            .X2 = -(Cos(((30*i)+15)*radtodeg)*(Grid_Dist*4))
            .Y2 = -(Sin(((30*i)+15)*radtodeg)*(Grid_Dist*4))
        End With
    Next
End If
If Grid_Num > 8 Then
    For i = 22 to 46
        With Radian(i)
            .X1 = -(Cos(((15*i)+7.5)*radtodeg)*Grid_Dist*Grid_Num)
            .Y1 = -(Sin(((15*i)+7.5)*radtodeg)*Grid_Dist*Grid_Num)
            .X2 = -(Cos(((15*i)+7.5)*radtodeg)*(Grid_Dist*8))
            .Y2 = -(Sin(((15*i)+7.5)*radtodeg)*(Grid_Dist*8))
        End With
    Next
End If
If Grid_Num > 16 Then
    For i = 47 to 95
        With Radian(i)
            .X1 = -(Cos(((7.5*i)+3.75)*radtodeg)*Grid_Dist*Grid_Num)
            .Y1 = -(Sin(((7.5*i)+3.75)*radtodeg)*Grid_Dist*Grid_Num)
            .X2 = -(Cos(((7.5*i)+3.75)*radtodeg)*(Grid_Dist*16))
            .Y2 = -(Sin(((7.5*i)+3.75)*radtodeg)*(Grid_Dist*16))
        End With
    Next
End If

Map_Scale = (Map_Radius/Grid_Radius)
Map_Scale_Start = Map_Scale
Map_Scale_Old2 = Map_Scale
Map_Scale_Old = 2*Map_Scale

Setmouse ,,0

Do 
    
    ''  calculate loops per second
    If Timer < LPS_timer+1 Then
        LPS_Counter += 1
    Else
        LPS = LPS_Counter
        LPS_Counter = 0
        LPS_Timer = Timer
    End If
    
    If Ship(0).State = 1 Then
        
        ''  update shield strength and shock-wave strength
        If Ship(0).Shield_State = 1 Then
            Ship(0).Shield_Strength -= 0.01
            Ship(0).Shock_Strength -= 0.15
            If Ship(0).Shield_Strength <= 0 Then 
                Ship(0).Shield_State = 0
                Ship(0).Shield_Strength = 0
            End If
        End If
        
    End If
    
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
    
    ''  update shock-wave state
    If Wait_Time1 < Timer and Ship(0).Shock_State = 1 then
        Ship(0).Shock_Strength = 0
        Ship(0).Shock_State = 0
    End If
    
    '' calculate comet debris spawning
    If int(Rnd*sqr(((Planet(0).Y-Comet(0).Y)^2) + ((Planet(0).X-Comet(0).X)^2))) < 10 Then
        For i = 0 to Ubound(Comet_Debris)
            If Comet_Debris(i).State = 0 Then
                Comet_Debris(i).TimeLeft = Comet_Debris(i).Time
                Comet_Debris(i).X = Comet(0).X
                Comet_Debris(i).Y = Comet(0).Y
                Comet_Debris(i).Direction = Rnd*(Pi*2)
                Comet_Debris(i).Speed = 0.01+Rnd*0.03
                Comet_Debris(i).Xvec = Comet(0).Xvec + Comet_Debris(i).Speed*Cos(Comet_Debris(i).Direction)
                Comet_Debris(i).Yvec = Comet(0).Yvec + Comet_Debris(i).Speed*Sin(-Comet_Debris(i).Direction)
                Comet_Debris(i).State = 1
                Exit for
            End If
        Next
    End If
    
    ''  calculate gravitational influence
    For i = 0 To Ubound(Planet)
        For i2 = i+1 To Ubound(Planet)
            If Planet(i).State = 1 and Planet(i2).State = 1 Then
                Xdist = Planet(i).X-Planet(i2).X
                Ydist = Planet(i).Y-Planet(i2).Y
                Distance = sqr((Xdist^2) + (Ydist^2))
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
                Planet(i).Xvec -= (Xdist/Distance)*(Gforce/Planet(i).Mass)
                Planet(i).Yvec -= (Ydist/Distance)*(Gforce/Planet(i).Mass) 
                Planet(i2).Xvec += (Xdist/Distance)*(Gforce/Planet(i2).Mass)
                Planet(i2).Yvec += (Ydist/Distance)*(Gforce/Planet(i2).Mass)
            End If
        Next
        For i2 = 0 To Ubound(Ship)  '' from 0 to # of ships
            If Planet(i).State = 1 and Ship(i2).State = 1 Then
                Xdist = Planet(i).X-Ship(i2).X
                Ydist = Planet(i).Y-Ship(i2).Y
                Distance = sqr((Xdist^2) + (Ydist^2))
                MinDist = Planet(i).Radius+Ship(i2).Radius
                    If Distance < MinDist then
                        Distance = MinDist
                    End If
                Gforce = Gravity*((Planet(i).Mass*Ship(i2).Mass)/(Distance^2))
                Planet(i).Xvec -= (Xdist/Distance)*(Gforce/Planet(i).Mass)
                Planet(i).Yvec -= (Ydist/Distance)*(Gforce/Planet(i).Mass)
                Ship(i2).Xvec += (Xdist/Distance)*(Gforce/Ship(i2).Mass)
                Ship(i2).Yvec += (Ydist/Distance)*(Gforce/Ship(i2).Mass)
            End If
        Next
        For i2 = 0 To Ubound(Station)  '' from 0 to # of stations
            If Planet(i).State = 1 and Station(i2).State = 1 Then
                Xdist = Planet(i).X-Station(i2).X
                Ydist = Planet(i).Y-Station(i2).Y
                Distance = sqr((Xdist^2) + (Ydist^2))
                MinDist = Planet(i).Radius+Station(i2).Radius
                    If Distance < MinDist then
                        Distance = MinDist
                    End If
                Gforce = Gravity*((Planet(i).Mass*Station(i2).Mass)/(Distance^2))
                Planet(i).Xvec -= (Xdist/Distance)*(Gforce/Planet(i).Mass)
                Planet(i).Yvec -= (Ydist/Distance)*(Gforce/Planet(i).Mass)
                Station(i2).Xvec += (Xdist/Distance)*(Gforce/Station(i2).Mass)
                Station(i2).Yvec += (Ydist/Distance)*(Gforce/Station(i2).Mass)
            End If
        Next
        For i2 = 0 To Ubound(Asteroid)  '' from 0 to # of asteroids
            If Planet(i).State = 1 and Asteroid(i2).State = 1 Then
                Xdist = Planet(i).X-Asteroid(i2).X
                Ydist = Planet(i).Y-Asteroid(i2).Y
                Distance = sqr((Xdist^2) + (Ydist^2))
                MinDist = Planet(i).Radius+Asteroid(i2).Radius
                    If Distance < MinDist then
                        Distance = MinDist
                    End If
                Gforce = Gravity*((Planet(i).Mass*Asteroid(i2).Mass)/(Distance^2))
                Planet(i).Xvec -= (Xdist/Distance)*(Gforce/Planet(i).Mass)
                Planet(i).Yvec -= (Ydist/Distance)*(Gforce/Planet(i).Mass)
                Asteroid(i2).Xvec += (Xdist/Distance)*(Gforce/Asteroid(i2).Mass)
                Asteroid(i2).Yvec += (Ydist/Distance)*(Gforce/Asteroid(i2).Mass)
            End If
        Next
        For i2 = 0 To Ubound(Emerald)  '' from 0 to # of emerald asteroids
            If Planet(i).State = 1 and Emerald(i2).State = 1 Then
                Xdist = Planet(i).X-Emerald(i2).X
                Ydist = Planet(i).Y-Emerald(i2).Y
                Distance = sqr((Xdist^2) + (Ydist^2))
                MinDist = Planet(i).Radius+Emerald(i2).Radius
                    If Distance < MinDist then
                        Distance = MinDist
                    End If
                Gforce = Gravity*((Planet(i).Mass*Emerald(i2).Mass)/(Distance^2))
                Planet(i).Xvec -= (Xdist/Distance)*(Gforce/Planet(i).Mass)
                Planet(i).Yvec -= (Ydist/Distance)*(Gforce/Planet(i).Mass)
                Emerald(i2).Xvec += (Xdist/Distance)*(Gforce/Emerald(i2).Mass)
                Emerald(i2).Yvec += (Ydist/Distance)*(Gforce/Emerald(i2).Mass)
            End If
        Next
        For i2 = 0 To Ubound(Comet)  '' from 0 to # of comets
            If Planet(i).State = 1 and Comet(i2).State = 1 Then
                Xdist = Planet(i).X-Comet(i2).X
                Ydist = Planet(i).Y-Comet(i2).Y
                Distance = sqr((Xdist^2) + (Ydist^2))
                MinDist = Planet(i).Radius+Comet(i2).Radius
                    If Distance < MinDist then
                        Distance = MinDist
                    End If
                Gforce = Gravity*((Planet(i).Mass*Comet(i2).Mass)/(Distance^2))
                Planet(i).Xvec -= (Xdist/Distance)*(Gforce/Planet(i).Mass)
                Planet(i).Yvec -= (Ydist/Distance)*(Gforce/Planet(i).Mass)
                Comet(i2).Xvec += (Xdist/Distance)*(Gforce/Comet(i2).Mass)
                Comet(i2).Yvec += (Ydist/Distance)*(Gforce/Comet(i2).Mass)
            End If
        Next
        For i2 = 0 To Ubound(Comet_Debris)  '' from 0 to # of comet debris
            If Planet(i).State = 1 and Comet_Debris(i2).State = 1 Then
                Xdist = Planet(i).X-Comet_Debris(i2).X
                Ydist = Planet(i).Y-Comet_Debris(i2).Y
                Distance = sqr((Xdist^2) + (Ydist^2))
                MinDist = Planet(i).Radius+Comet_Debris(i2).Radius
                    If Distance < MinDist then
                        Distance = MinDist
                    End If
                Gforce = Gravity*((Planet(i).Mass*Comet_Debris(i2).Mass)/(Distance^2))
                Planet(i).Xvec -= (Xdist/Distance)*(Gforce/Planet(i).Mass)
                Planet(i).Yvec -= (Ydist/Distance)*(Gforce/Planet(i).Mass)
                Comet_Debris(i2).Xvec += (Xdist/Distance)*(Gforce/Comet_Debris(i2).Mass)
                Comet_Debris(i2).Yvec += (Ydist/Distance)*(Gforce/Comet_Debris(i2).Mass)
            End If
        Next
    Next
    For i = 0 to Ubound(Station)
        For i2 = 0 To Ubound(Ship)  '' from 0 to # of ships
            If Station(i).State = 1 and Ship(i2).State = 1 Then
                Xdist = Station(i).X-Ship(i2).X
                Ydist = Station(i).Y-Ship(i2).Y
                Distance = sqr((Xdist^2) + (Ydist^2))
                MinDist = Station(i).Radius+Ship(i2).Radius
                    If Distance < MinDist then
                        ship(i2).Xvec += 100*(((ship(i2).x-station(i).x)/distance)/(ship(i2).mass))
                        ship(i2).Yvec += 100*(((ship(i2).y-station(i).y)/distance)/(ship(i2).mass))
                        ship(i2).Xvec *= 0.995'0.01*Station(i).Xvec
                        ship(i2).Yvec *= 0.995'0.01*Station(i).Yvec
                    End If
                    Gforce = Gravity*((Station(i).Mass*Ship(i2).Mass)/(Distance^2))
                    Station(i).Xvec -= (Xdist/Distance)*(Gforce/Station(i).Mass)
                    Station(i).Yvec -= (Ydist/Distance)*(Gforce/Station(i).Mass)
                    Ship(i2).Xvec += (Xdist/Distance)*(Gforce/Ship(i2).Mass)
                    Ship(i2).Yvec += (Ydist/Distance)*(Gforce/Ship(i2).Mass)
            End If
        Next
        For i2 = 0 To Ubound(Asteroid)  '' from 0 to # of asteroids
            If Station(i).State = 1 and Asteroid(i2).State = 1 Then
                Xdist = Station(i).X-Asteroid(i2).X
                Ydist = Station(i).Y-Asteroid(i2).Y
                Distance = sqr((Xdist^2) + (Ydist^2))
                MinDist = Station(i).Radius+Asteroid(i2).Radius
                    If Distance < MinDist then
                        Distance = MinDist
                    End If
                Gforce = Gravity*((Station(i).Mass*Asteroid(i2).Mass)/(Distance^2))
                Station(i).Xvec -= (Xdist/Distance)*(Gforce/Station(i).Mass)
                Station(i).Yvec -= (Ydist/Distance)*(Gforce/Station(i).Mass)
                Asteroid(i2).Xvec += (Xdist/Distance)*(Gforce/Asteroid(i2).Mass)
                Asteroid(i2).Yvec += (Ydist/Distance)*(Gforce/Asteroid(i2).Mass)
            End If
        Next
        For i2 = 0 To Ubound(Emerald)  '' from 0 to # of emerald asteroids
            If Station(i).State = 1 and Emerald(i2).State = 1 Then
                Xdist = Station(i).X-Emerald(i2).X
                Ydist = Station(i).Y-Emerald(i2).Y
                Distance = sqr((Xdist^2) + (Ydist^2))
                Gforce = Gravity*((Station(i).Mass*Emerald(i2).Mass)/(Distance^2))
                MinDist = Station(i).Radius+Emerald(i2).Radius
                    If Distance < MinDist then
                        Distance = MinDist
                    End If
                Station(i).Xvec -= (Xdist/Distance)*(Gforce/Station(i).Mass)
                Station(i).Yvec -= (Ydist/Distance)*(Gforce/Station(i).Mass)
                Emerald(i2).Xvec += (Xdist/Distance)*(Gforce/Emerald(i2).Mass)
                Emerald(i2).Yvec += (Ydist/Distance)*(Gforce/Emerald(i2).Mass)
            End If
        Next
        For i2 = 0 To Ubound(Comet)  '' from 0 to # of comets
            If Station(i).State = 1 and Comet(i2).State = 1 Then
                Xdist = Station(i).X-Comet(i2).X
                Ydist = Station(i).Y-Comet(i2).Y
                Distance = sqr((Xdist^2) + (Ydist^2))
                MinDist = Station(i).Radius+Comet(i2).Radius
                    If Distance < MinDist then
                        Distance = MinDist
                    End If
                Gforce = Gravity*((Station(i).Mass*Comet(i2).Mass)/(Distance^2))
                Station(i).Xvec -= (Xdist/Distance)*(Gforce/Station(i).Mass)
                Station(i).Yvec -= (Ydist/Distance)*(Gforce/Station(i).Mass)
                Comet(i2).Xvec += (Xdist/Distance)*(Gforce/Comet(i2).Mass)
                Comet(i2).Yvec += (Ydist/Distance)*(Gforce/Comet(i2).Mass)
            End If
        Next
        For i2 = 0 To Ubound(Comet_Debris)  '' from 0 to # of comet debris
            If Station(i).State = 1 and Comet_Debris(i2).State = 1 Then
                Xdist = Station(i).X-Comet_Debris(i2).X
                Ydist = Station(i).Y-Comet_Debris(i2).Y
                Distance = sqr((Xdist^2) + (Ydist^2))
                MinDist = Station(i).Radius+Comet_Debris(i2).Radius
                    If Distance < MinDist then
                        Distance = MinDist
                    End If
                Gforce = Gravity*((Station(i).Mass*Comet_Debris(i2).Mass)/(Distance^2))
                Station(i).Xvec -= (Xdist/Distance)*(Gforce/Station(i).Mass)
                Station(i).Yvec -= (Ydist/Distance)*(Gforce/Station(i).Mass)
                Comet_Debris(i2).Xvec += (Xdist/Distance)*(Gforce/Comet_Debris(i2).Mass)
                Comet_Debris(i2).Yvec += (Ydist/Distance)*(Gforce/Comet_Debris(i2).Mass)
            End If
        Next
    Next
    
    For i = 0 To Ubound(asteroid)
        If Asteroid(i).State = 1 Then
            Asteroid(i).X+=Asteroid(i).XVec 
            Asteroid(i).Y+=Asteroid(i).YVec
        End If 
    Next
    For i = 0 To Ubound(Emerald)
        If Emerald(i).State = 1 Then
            Emerald(i).X+=Emerald(i).XVec 
            Emerald(i).Y+=Emerald(i).YVec
        End If
    Next
    For i = 1 To Ubound(Planet)
        If Planet(i).State = 1 Then
            Planet(i).X+=Planet(i).XVec 
            Planet(i).Y+=Planet(i).YVec
        End If
    Next
    For i = 0 To Ubound(Burst)
        If Burst(i).State = 1 Then
            Burst(i).X -= Burst(i).Xvec
            Burst(i).Y -= Burst(i).Yvec
        End If
    Next
    For i = 0 To Ubound(station)
        If Station(i).State = 1 Then
            Station(i).X+=Station(i).XVec
            Station(i).Y+=Station(i).YVec
        End If
    Next
    For i = 0 To Ubound(Comet_Debris)
        If Comet_Debris(i).State = 1 Then
            If Comet_Debris(i).TimeLeft >= 1 Then
                Comet_Debris(i).TimeLeft -= 1
                Comet_Debris(i).X+=Comet_Debris(i).XVec 
                Comet_Debris(i).Y+=Comet_Debris(i).YVec
            End If
        End If
    Next
    For i = 0 To Ubound(Comet)
        If Comet(i).State = 1 Then
            Comet(i).X+=Comet(i).XVec 
            Comet(i).Y+=Comet(i).YVec
        End If
    Next
    For i = 0 to Ubound(Ship)
        If Ship(i).State = 1 Then
            Ship(i).X+=Ship(i).XVec
            Ship(i).Y+=Ship(i).YVec
        End If
    Next
    
    ''  stage 1 collision detection
    For i2 = 0 To Ubound(Ship)
        For i = 0 To Ubound(Asteroid)
            If Asteroid(i).State = 1 and Ship(i2).State = 1 Then
                Distance = sqr(((Asteroid(i).Y-Ship(i2).Y)^2) + ((Asteroid(i).X-Ship(i2).X)^2))
                MinDist = Asteroid(i).Radius+Ship(i2).Radius
                If Distance < MinDist then
                    Ship(i2).State = 0
                    Ship(i2).Shock_State = 1
                    Wait_Time1 = Timer + 0.1
                    Payload_State = 0
                    for i3 = 0 to Ubound(Particle)
                        Particle(i3).X = Ship(i2).X
                        Particle(i3).Y = Ship(i2).Y
                        Particle(i3).State = 1
                        Particle(i3).TimeLeft = Particle(i3).Time
                    Next
                End If
            End If
        Next
        For i = 0 To Ubound(Comet_Debris)
            If Comet_Debris(i).State = 1 and Ship(i2).State = 1 Then
                Distance = sqr(((Comet_Debris(i).Y-Ship(i2).Y)^2) + ((Comet_Debris(i).X-Ship(i2).X)^2))
                MinDist = Comet_Debris(i).Radius+Ship(i2).Radius
                If Distance < MinDist then
                    Ship(i2).State = 0
                    Ship(i2).Shock_State = 1
                    Wait_Time1 = Timer + 0.1
                    Payload_State = 0
                    for i3 = 0 to Ubound(Particle)
                        Particle(i3).X = Ship(i2).X
                        Particle(i3).Y = Ship(i2).Y
                        Particle(i3).State = 1
                        Particle(i3).TimeLeft = Particle(i3).Time
                    Next
                End If
            End If
        Next
    Next
    
    For i = 0 to Ubound(Ship)
        If Ship(i).State = 0 and Ship(i).Shock_State = 1 Then
            Ship(i).Shock_Strength += Ship(i).Fuel_Mass*150
            Ship(i).Fuel_Mass = 0
            Ship(i).Shield_State = 0
            If Payload_State = 1 Then
                swap Payload_Val0, Payload_Val1
                Payload_State = 0
            End If
        End If
    Next
 
    '' calculate physical influence betw. ship and payload
    If Payload_State = 1 Then
        Emerald(Pay_Num).Xvec -= 0.001*Ship(0).Xvec
        Emerald(Pay_Num).Yvec -= 0.001*Ship(0).Yvec
        Distance = sqr((((Ship(0).Y+Ship(0).Ytrac)-Emerald(Pay_Num).Y)^2) + (((Ship(0).Xtrac+Ship(0).X)-Emerald(Pay_Num).X)^2))
        Ship(0).Xvec -= 0.5*(((Ship(0).Xtrac+Ship(0).X)-Emerald(Pay_Num).X)/Distance)*((Distance-70)/Ship(0).Mass)
        Ship(0).Yvec -= 0.5*(((Ship(0).Y+Ship(0).Ytrac)-Emerald(Pay_Num).Y)/Distance)*((Distance-70)/Ship(0).Mass)
        Emerald(Pay_Num).Xvec -= 0.5*((Emerald(Pay_Num).X-(Ship(0).Xtrac+Ship(0).X))/Distance)*((Distance-70)/Emerald(Pay_Num).Mass)
        Emerald(Pay_Num).Yvec -= 0.5*((Emerald(Pay_Num).Y-(Ship(0).Y+Ship(0).Ytrac))/Distance)*((Distance-70)/Emerald(Pay_Num).Mass)
    End If
    
    ''  calculate planet asteroid deflection shield
    For i = 0 to Ubound(Station)
        For i2 = 0 to Ubound(Emerald)
            If Emerald(i2).State = 1 Then
                Distance = sqr(((Emerald(i2).Y-Station(i).Y)^2) + ((Emerald(i2).X-Station(i).X)^2))
                    If Distance <= Station(i).Shield_Minsize+Emerald(i2).Radius Then
                        Station(0).Shield_Strength += Emerald(i2).Mass/10
                        Emerald(i2).State = 0
                    End If
            End If
        Next
        If Station(i).Shield_State = 1 Then
            For i2 = 0 to Ubound(Asteroid)
                If Asteroid(i2).State = 1 Then
                    Distance = sqr(((Asteroid(i2).Y-Station(i).Y)^2) + ((Asteroid(i2).X-Station(i).X)^2))
                    If Distance <= Station(i).Shield_Minsize+Asteroid(i2).Radius Then
                        Asteroid(i2).Xvec += (0.3*Asteroid(i2).Mass*((Asteroid(i2).X-Station(i).X)/Distance))/Asteroid(i2).Mass
                        Asteroid(i2).Yvec += (0.3*Asteroid(i2).Mass*((Asteroid(i2).Y-Station(i).Y)/Distance))/Asteroid(i2).Mass
                        Station(i).Xvec += (0.3*Asteroid(i2).Mass*((Station(i).X-Asteroid(i2).X)/Distance))/Station(i).Mass
                        Station(i).Yvec += (0.3*Asteroid(i2).Mass*((Station(i).Y-Asteroid(i2).Y)/Distance))/Station(i).Mass
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
            For i2 = 0 to Ubound(Comet_Debris)
                If Comet_Debris(i2).State = 1 Then
                    Distance = sqr(((Comet_Debris(i2).Y-Station(i).Y)^2) + ((Comet_Debris(i2).X-Station(i).X)^2))
                    If Distance <= Station(i).Shield_Minsize+Comet_Debris(i2).Radius Then
                        Comet_Debris(i2).Xvec += (3*((Comet_Debris(i2).X-Station(i).X)/Distance))/Comet_Debris(i2).Mass
                        Comet_Debris(i2).Yvec += (3*((Comet_Debris(i2).Y-Station(i).Y)/Distance))/Comet_Debris(i2).Mass
                        Station(i).Xvec += (3*((Station(i).X-Comet_Debris(i2).X)/Distance))/Station(i).Mass
                        Station(i).Yvec += (3*((Station(i).Y-Comet_Debris(i2).Y)/Distance))/Station(i).Mass
                    End If
                End If
            Next
        End If
        Station(i).Shield_Strength -= 0.001
        If Station(i).Shield_Strength <= 0 Then 
            Station(i).Shield_Strength = 0
            Station(i).Shield_State = 0
        End If
    Next

    ''  calculate ship Asteroid deflection shield
    For i = 0 to Ubound(Ship)
        If Ship(i).Shield_State = 1 Then
             For i2 = 0 to Ubound(Asteroid)
                If Asteroid(i2).State = 1 Then
                    Distance = sqr(((Asteroid(i2).Y-Ship(i).Y)^2) + ((Asteroid(i2).X-Ship(i).X)^2))
                    If Distance < Ship(i).Shield_Minsize+2+sqr(Ship(i).Shield_Strength/pi)+Asteroid(i2).Radius Then
                        Asteroid(i2).Xvec += (0.1*Asteroid(i2).Mass*((Asteroid(i2).X-Ship(i).X)/Distance))/Asteroid(i2).Mass
                        Asteroid(i2).Yvec += (0.1*Asteroid(i2).Mass*((Asteroid(i2).Y-Ship(i).Y)/Distance))/Asteroid(i2).Mass
                        Ship(i).Xvec += (0.2*Asteroid(i2).Mass*((Ship(i).X-Asteroid(i2).X)/Distance))/Ship(i).Mass
                        Ship(i).Yvec += (0.2*Asteroid(i2).Mass*((Ship(i).Y-Asteroid(i2).Y)/Distance))/Ship(i).Mass
                    End If
                End If
            Next
            For i2 = 0 to Ubound(Comet_Debris)
                If Comet_Debris(i2).State = 1 Then
                    Distance = sqr(((Comet_Debris(i2).Y-Ship(i).Y)^2) + ((Comet_Debris(i2).X-Ship(i).X)^2))
                    If Distance <= Ship(i).Shield_Minsize+Comet_Debris(i2).Radius Then
                        Comet_Debris(i2).Xvec += (3*((Comet_Debris(i2).X-Ship(i).X)/Distance))/Comet_Debris(i2).Mass
                        Comet_Debris(i2).Yvec += (3*((Comet_Debris(i2).Y-Ship(i).Y)/Distance))/Comet_Debris(i2).Mass
                        Ship(i).Xvec += (3*((Ship(i).X-Comet_Debris(i2).X)/Distance))/Ship(i).Mass
                        Ship(i).Yvec += (3*((Ship(i).Y-Comet_Debris(i2).Y)/Distance))/Ship(i).Mass
                    End If
                End If
            Next
        End If
    Next
    
    ''  calculate shock-wave's asteroid deflection
    For i = 0 to Ubound(Ship)
        If Ship(i).Shock_State = 1 Then
            For i2 = 0 to Ubound(Asteroid)
                If Asteroid(i2).State = 1 Then
                    Distance = sqr(((Asteroid(i2).Y-Ship(i).Y)^2) + ((Asteroid(i2).X-Ship(i).X)^2))
                    Asteroid(i2).Xvec += Ship(i).Shock_Strength*((Asteroid(i2).X-Ship(i).X)/Distance)*(((Asteroid(i2).Radius^2*pi)/Distance^2)/Asteroid(i2).Mass)
                    Asteroid(i2).Yvec += Ship(i).Shock_Strength*((Asteroid(i2).Y-Ship(i).Y)/Distance)*(((Asteroid(i2).Radius^2*pi)/Distance^2)/Asteroid(i2).Mass)
                End If
            Next
            For i2 = 0 to Ubound(Emerald)
                If Emerald(i2).State = 1 Then
                    Distance = sqr(((Emerald(i2).Y-Ship(i).Y)^2) + ((Emerald(i2).X-Ship(i).X)^2))
                    Emerald(i2).Xvec += Ship(i).Shock_Strength*((Emerald(i2).X-Ship(i).X)/Distance)*(((Emerald(i2).Radius^2*pi)/Distance^2)/Emerald(i2).Mass)
                    Emerald(i2).Yvec += Ship(i).Shock_Strength*((Emerald(i2).Y-Ship(i).Y)/Distance)*(((Emerald(i2).Radius^2*pi)/Distance^2)/Emerald(i2).Mass)
                End If
            Next
            For i2 = 0 to Ubound(Comet)
                If Comet(i2).State = 1 Then
                    Distance = sqr(((Comet(i2).Y-Ship(i).Y)^2) + ((Comet(i2).X-Ship(i).X)^2))
                    Comet(i2).Xvec += Ship(i).Shock_Strength*((Comet(i2).X-Ship(i).X)/Distance)*(((Comet(i2).Radius^2*pi)/Distance^2)/Comet(i2).Mass)
                    Comet(i2).Yvec += Ship(i).Shock_Strength*((Comet(i2).Y-Ship(i).Y)/Distance)*(((Comet(i2).Radius^2*pi)/Distance^2)/Comet(i2).Mass)
                End If
            Next
            For i2 = 0 to Ubound(Comet_Debris)
                If Comet_Debris(i2).State = 1 Then
                    Distance = sqr(((Comet_Debris(i2).Y-Ship(i).Y)^2) + ((Comet_Debris(i2).X-Ship(i).X)^2))
                    Comet_Debris(i2).Xvec += Ship(i).Shock_Strength*((Comet_Debris(i2).X-Ship(i).X)/Distance)*(((Comet_Debris(i2).Radius^2*pi)/Distance^2)/Comet_Debris(i2).Mass)
                    Comet_Debris(i2).Yvec += Ship(i).Shock_Strength*((Comet_Debris(i2).Y-Ship(i).Y)/Distance)*(((Comet_Debris(i2).Radius^2*pi)/Distance^2)/Comet_Debris(i2).Mass)
                End If
            Next
        End If
    Next
    
    '' calculate when picked up emerald asteroid is delivered at home-planet
    If Payload_State = 1 Then
        Distance = sqr(((Emerald(Pay_Num).X-Station(0).X)^2) + ((Emerald(Pay_Num).Y-Station(0).Y)^2))
        If Distance-Emerald(Pay_Num).Radius <= Station(0).Shield_Minsize Then 
            swap Payload_Val0, Payload_Val1
            Emerald(Pay_Num).State = 0
            Payload_State = Payload_Val0
            Ship(0).Payload_Mass = 0
            Ship(0).Fuel_Mass += Emerald(Pay_Num).Mass/10 
            If Ship(0).Fuel_Mass > 500 Then Ship(0).Fuel_Mass = 500
            Ship(0).Mass += Emerald(Pay_Num).Mass/10 
            Station(0).Shield_Strength += Emerald(Pay_Num).Mass/10
        End If
    End If
    
    ''  center screen on ship x-y coordinates
    MidX = Screen_X_Mid-(Ship(0).X+Ship(0).Xvec)
    MidY = Screen_Y_Mid-(Ship(0).Y+Ship(0).Yvec)
    
    ''  calculate and draw particles
    For i = 0 to Ubound(Ship)
        If Ship(i).State = 0 Then
            For i2 = 0 To Ubound(Particle)
                If Particle(i2).State = 1 Then
                    if Particle(i2).TimeLeft >= 1 then
                        Particle(i2).TimeLeft -= 1
                        Particle(i2).X -= (Particle(i2).Xvec-Ship(i).Xvec)
                        Particle(i2).Y -= (Particle(i2).Yvec-Ship(i).Yvec)
                        R = Particle(i2).R*(Particle(i2).TimeLeft/Particle(i2).Time)
                        G = Particle(i2).G*(Particle(i2).TimeLeft/Particle(i2).Time)
                        B = Particle(i2).B*(Particle(i2).TimeLeft/Particle(i2).Time)
                        Pset(Particle(i2).X+MidX, Particle(i2).Y+MidY), Rgb(R, G, B)
                    Else 
                        Particle(i).State = 0
                    End If
                End If
            Next
        End If
    Next
    
    ''  update screen every 1/screen_rate seconds
    If Timer >= last_screen_update + screen_update Then 
        last_screen_update = Timer
        
        ''  beregn fps
        If Timer < FPS_timer + 1 Then
            FPS_Counter += 1
        Else
            FPS = FPS_Counter
            FPS_Counter = 0
            FPS_Timer = Timer
            If FPS < Screen_rate Then screen_update -= 1e-4
            If FPS > Screen_rate Then screen_update += 1e-4
        End If
        
        ''  Spaceship controls
        If Ship(0).State = 1 Then
            
            ''  toggle ship turn left/right
            If multikey (75) then 
                Ship(0).Direction += 4: If Ship(0).Direction >= 360 then Ship(0).Direction -= 360
                Rec (8, 180-Ship(0).Direction)
                Ship(0).Xtrac = Xrec
                Ship(0).Ytrac = Yrec
            End If
            If multikey (77) then 
                Ship(0).Direction -= 4: If Ship(0).Direction < 0 then Ship(0).Direction += 360
                Rec (8, 180-Ship(0).Direction)
                Ship(0).Xtrac = Xrec
                Ship(0).Ytrac = Yrec
            End If
            
            ''  toggle ship thrust
            If multikey (72) then
                If Ship(0).Fuel_Mass >= 0.01 then
                    Ship(0).Xvec += 20*(Cos(Ship(0).Direction*Radtodeg)/Ship(0).Mass)
                    Ship(0).Yvec += 20*(Sin(-Ship(0).Direction*Radtodeg)/Ship(0).Mass)
                    Ship(0).Fuel_Mass -= 0.01
                    Ship(0).Mass -= 0.01
                    For i = 0 to Ubound(Burst)
                        If Burst(i).State = 0 Then
                            Burst(i).Direction = Ship(0).Direction+(Rnd*7.5-Rnd*7.5)
                            Burst(i).XVec = (Burst(i).Speed*Cos(Burst(i).Direction*Radtodeg))-Ship(0).Xvec
                            Burst(i).YVec = (Burst(i).Speed*Sin(-Burst(i).Direction*Radtodeg))-Ship(0).Yvec
                            Burst(i).X = Ship(0).Xtrac+Ship(0).X
                            Burst(i).Y = Ship(0).Ytrac+Ship(0).Y
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
                            Projectile(i).Direction = Ship(0).Direction+180
                            Projectile(i).XVec = (Projectile(i).Speed*Cos(Projectile(i).Direction*Radtodeg))-Ship(0).Xvec
                            Projectile(i).YVec = (Projectile(i).Speed*Sin(-Projectile(i).Direction*Radtodeg))-Ship(0).Yvec
                            Projectile(i).X = Ship(0).X
                            Projectile(i).Y = Ship(0).Y
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
                    Ship(0).Payload_Mass = 0
                    Pay_Num = 0
                    Wait_Time0 = Timer + 0.1
                End If
                For i = 0 to Ubound(Emerald)
                    If Emerald(i).State = 1 Then
                        Distance = sqr(((Emerald(i).Y-Ship(0).Y)^2) + ((Emerald(i).X-Ship(0).X)^2))
                        If Distance <= 70 and Payload_State = 0 and Timer > Wait_Time0 then
                            swap Payload_Val0, Payload_Val1
                            Payload_State = Payload_Val0
                            Pay_Num = i
                            Ship(0).Payload_Mass = Emerald(i).Mass
                        End If
                    End If
                Next
                Wait_Time0 = Timer + 0.1
            End If
            
            ''  toggle shield and shock-wave (temporary)
            If Multikey(83) Then
                If Ship(0).Fuel_Mass >= 0.5 and Wait_Time1 < Timer Then
                    Ship(0).Shield_Strength += 1
                    Ship(0).Shock_Strength += 15
                    Ship(0).Fuel_Mass -= 0.5
                    Ship(0).Mass -= 0.5
                End If
                If Ship(0).Shield_State = 1 Then
                    Ship(0).Shock_State = 1
                    Ship(0).Shield_State = 0
                    Ship(0).Shield_Strength = 0
                    Wait_Time1 = Timer + 0.1
                End If
            End If
            If Multikey(83) = 0 and Ship(0).Shield_Strength > 0 Then
                Ship(0).Shield_State = 1
            End If
            
        End If
        
        ''  turn minimap on/off and switch mode using "m"
        If Multikey (50) Then
            If Timer > Wait_Time2 Then
                swap Map_Val0, Map_Val1
                swap Map_Val1, Map_Val2
                Map_State = Map_Val0
            End If
            Wait_Time2 = Timer + 0.1
        End If
        
        ''  turn compass on/off and switch mode using "c"
        If Multikey (46) Then
            If Timer > Wait_Time3 Then
                swap Compass_Val0, Compass_Val1
                swap Compass_Val1, Compass_Val2
                Compass_State = Compass_Val0
            End If
            Wait_Time3 = Timer + 0.1
        End If
        
        ''  turn data-screen on/off and switch mode using "b"
        If Multikey (48) Then
            If Timer > Wait_Time4 then 
                swap Data_Val0, Data_Val1
                swap Data_Val1, Data_Val2
                Data_State = Data_Val0
            End IF
            Wait_Time4 = Timer + 0.1
        End If
        
        ''  pause using "p"
        If Multikey (25) Then
            Do
                If Multikey (25) then
                    If Timer > Wait_Time5 Then
                        swap Pause_Val0, Pause_Val1
                        Pause_State = Pause_Val0
                    End If
                Wait_Time5 = Timer + 0.1
                End If
            Loop until Pause_State = 0
        End If
        
        '' turn grid on/off using "g"
        If Multikey (34) Then
            If Timer > Wait_Time6 Then
                swap Grid_Val0, Grid_Val1
                Grid_State = Grid_Val0
            End If
            Wait_Time6 = Timer + 0.1
        End If
        
        Screenset P2, P1 
        Swap P2, P1 
        Cls
        
            ''  precalculate comet tail (to prevent off-centre placement at high comet speeds)
    Comet_Counter = 0
    For i = 0 to Ubound(Comet_Particle)
        If Comet_Particle(i).State = 0 Then
            Comet_Particle(i).Direction = Rnd*(2*pi)
            Comet_Particle(i).XVec = ((Comet_Particle(i).Speed*Cos(Comet_Particle(i).Direction))-Comet(0).Xvec)
            Comet_Particle(i).YVec = ((Comet_Particle(i).Speed*Sin(-Comet_Particle(i).Direction))-Comet(0).Yvec)
            Comet_Particle(i).X = Comet(0).X+(Rnd*Comet(0).Radius-Rnd*Comet(0).Radius)
            Comet_Particle(i).Y = Comet(0).Y+(Rnd*Comet(0).Radius-Rnd*Comet(0).Radius)
            Comet_Particle(i).TimeLeft = Comet_Particle(i).Time
            Comet_Particle(i).State = 1
            Comet_Counter += 1
            If Comet_Counter = 10 Then Exit For
        Else
            If Comet_Particle(i).TimeLeft >= 1 Then
                Comet_Particle(i).TimeLeft -= 1
                Distance = sqr(((Planet(0).Y-Comet_Particle(i).Y)^2) + ((Planet(0).X-Comet_Particle(i).X)^2))
                Comet_Particle(i).Xvec -= 1.5e-2*((Comet_Particle(i).X-Planet(0).X)/Distance)
                Comet_Particle(i).Yvec -= 1.5e-2*((Comet_Particle(i).Y-Planet(0).Y)/Distance)
                Comet_Particle(i).X -= Comet_Particle(i).Xvec
                Comet_Particle(i).Y -= Comet_Particle(i).Yvec
            Else
                Comet_Particle(i).State = 0
            END iF
        End If
    Next
        
    ''  Calculate and draw projectiles
    For i = 0 to Ubound(Projectile)
        If Projectile(i).State = 1 Then
            If Projectile(i).TimeLeft >= 1 Then
                Projectile(i).TimeLeft -= 1
                Projectile(i).X -= Projectile(i).Xvec
                Projectile(i).Y -= Projectile(i).Yvec
                If Projectile(i).TimeLeft < 32 Then
                    R = Projectile(i).Timeleft*8
                    G = R
                    B = R
                Else
                    R = Projectile(i).R
                    G = R
                    B = R
                End If
                Pset(Projectile(i).X+MidX, Projectile(i).Y+MidY), RGB(R, G, B)
            Else
                Projectile(i).State = 0
            End If
        End If
    Next
        
        ''  draw grid
        If Grid_State = 1 Then
            For i = 0 to Grid_Num-1
                DrawEllipse(Ellipse(i).X+MidX, Ellipse(i).Y+MidY, Ellipse(i).Hgt, Ellipse(i).Wid, 0, Ellipse(i).Col, Ellipse(i).num_lines)
            Next
            For i = 0 To Ubound(Radian)
                Line(Radian(i).X1+MidX, Radian(i).Y1+MidY)-(Radian(i).X2+MidX, Radian(i).Y2+MidY), RGB(6, 36, 6)
            Next
        End If
        
        ''  draw tractor-beam between ship and picked up asteroid
        If Payload_State = 1 then
            Line (Ship(0).XTrac+Ship(0).X+Ship(0).Xvec+MidX, Ship(0).YTrac+Ship(0).Y+Ship(0).Yvec+MidY)-(Emerald(Pay_Num).X+Emerald(Pay_Num).Xvec+MidX, Emerald(Pay_Num).Y+Emerald(Pay_Num).Yvec+MidY), Rgb(96, 96, 144)
        End If
        
        ''  draw Planet shield
        For i = 0 to Ubound(Station)
            If Station(i).State = 1 and Station(i).Shield_State = 1 Then
                Circle (Station(i).X+MidX+(-Rnd*1.5+Rnd*1.5), Station(i).Y+MidY+(-Rnd*1.5+Rnd*1.5)), Station(i).Shield_Minsize-3,  Rgb(64, 64, 96),,,1
                Circle (Station(i).X+MidX+(-Rnd*1.5+Rnd*1.5), Station(i).Y+MidY+(-Rnd*1.5+Rnd*1.5)), Station(i).Shield_Minsize,  Rgb(96, 96, 144),,,1
            Else
                Circle (Station(i).X+MidX, Station(i).Y+MidY), Station(i).Shield_Minsize,  Rgb(64, 16, 16),,,1
            End If
        Next
        
        ''  draw sun
        Circle (Planet(0).X+MidX, Planet(0).Y+MidY), 128, Rgb(255, 104, 0),,,1,f
        Circle (Planet(0).X+MidX, Planet(0).Y+MidY), 126, Rgb(255, 240, 160),,,1,f
        Circle (Planet(0).X+MidX, Planet(0).Y+MidY), 122, Rgb(255, 255, 255),,,1,f
        
        '' draw asteroids
        For i = 0 To Ubound(Asteroid)
            If Asteroid(i).State = 1 Then
                R = Asteroid(i).R 
                G = Asteroid(i).G 
                B = Asteroid(i).B 
                Circle(Asteroid(i).X+MidX, Asteroid(i).Y+MidY), Asteroid(i).Radius, Rgb(R,G,B),,,1,F
            End If
        Next 
        
        '' draw emerald asteroids
        For i = 0 To Ubound(Emerald)
            If Emerald(i).State = 1 Then
                R = Emerald(i).R 
                G = Emerald(i).G 
                B = Emerald(i).B 
                Circle(Emerald(i).X+MidX, Emerald(i).Y+MidY), Emerald(i).Radius, Rgb(R,G,B),,,1,F
            End If
        Next 
        
        '' draw planets
        For i = 1 To Ubound(Planet)
            If Planet(i).State = 1 Then
                R = Planet(i).R 
                G = Planet(i).G 
                B = Planet(i).B 
                Circle(Planet(i).X+MidX, Planet(i).Y+MidY), Planet(i).Radius, Rgb(R,G,B),,,1,F
            End If
        Next 
        
        ''  draw stations
        For i = 0 to Ubound(Station)
            If Station(i).State = 1 Then
                R = Station(i).R 
                G = Station(i).G 
                B = Station(i).B 
                Circle(Station(i).X+MidX, Station(i).Y+MidY), Station(i).Radius, Rgb(R,G,B),,,1,F
            End If
        Next
        
        '' draw Comet debris
        For i = 0 To Ubound(Comet_Debris)
            If Comet_Debris(i).State = 1 Then
                If Comet_Debris(i).TimeLeft >= 1 Then
                    Comet_Radius = Comet_Debris(i).Radius*(Comet_Debris(i).TimeLeft/Comet_Debris(i).Time)
                    R = Comet_Debris(i).R
                    G = Comet_Debris(i).G
                    B = Comet_Debris(i).B
                    Circle(Comet_Debris(i).X+MidX, Comet_Debris(i).Y+MidY), Comet_Radius, Rgb(R,G,B),,,1,F
                Else
                    Comet_Debris(i).State = 0
                End If
            End If
        Next
        
        '' draw Comets
        For i = 0 To Ubound(Comet)
            If Comet(i).State = 1 Then
                R = Comet(i).R 
                G = Comet(i).G 
                B = Comet(i).B 
                Circle(Comet(i).X+MidX, Comet(i).Y+MidY), Comet(i).Radius, Rgb(R,G,B),,,1,F
            End If
        Next
        
        ''  calculate and draw comet tail
        For i = 0 to Ubound(Comet_Particle)
            If Comet_Particle(i).State = 1 Then
                If Comet_Particle(i).TimeLeft < 64 Then
                    R = Comet_Particle(i).Timeleft*4
                    G = R
                    B = R
                Else
                    R = Comet_Particle(i).R
                    G = R
                    B = R
                End If
                Pset(Comet_Particle(i).X+MidX, Comet_Particle(i).Y+MidY), RGB(R, G, B)
            End If
        Next
        
        ''  draw ship shield
        For i = 0 to Ubound(Ship)
            If Ship(i).Shield_State = 1 Then
                Circle (Ship(i).X+MidX+(-Rnd*1+Rnd*1), Ship(i).Y+MidY+(-Rnd*1+Rnd*1)), Ship(i).Shield_Minsize+sqr(Ship(i).Shield_Strength/pi),  Rgb(64, 64, 96),,,1
                Circle (Ship(i).X+MidX+(-Rnd*1+Rnd*1), Ship(i).Y+MidY+(-Rnd*1+Rnd*1)), Ship(i).Shield_Minsize+2+sqr(Ship(i).Shield_Strength/pi),  Rgb(96, 96, 144),,,1
            End If
        Next
        
        ''  calculate and draw burst
        For i = 0 to Ubound(burst)
            If Burst(i).State = 1 Then
                If Burst(i).TimeLeft >= 1 Then
                    Burst(i).TimeLeft -= 1
                    R = Burst(i).R*(Burst(i).TimeLeft/Burst(i).Time)
                    G = Burst(i).G*(Burst(i).TimeLeft/Burst(i).Time)
                    B = Burst(i).B*(Burst(i).TimeLeft/Burst(i).Time)
                    Pset(Burst(i).X+MidX, Burst(i).Y+MidY), RGB(R, G, B)
                Else
                    Burst(i).State = 0
                End If
            End If
        Next
        
        '' draw ships
        For i = 0 to Ubound(Ship)
            If Ship(i).State = 1 Then
                R = Ship(i).R 
                G = Ship(i).G 
                B = Ship(i).B 
                Drawship (Ship(i).X+MidX, Ship(i).Y+MidY, Ship(i).Direction, Rgb(R,G,B))
            End If
        Next
        
        ''  decide wether compass is on or off
        If Compass_State <> 0 Then
            If Compass_State = 1 Then
                Compass_X = Screen_X_Mid
                Compass_Y = Screen_Y_Mid
                Compassstate$="Compass: Center on ship"
            Else
                Compass_X = Compass_X_Mid
                Compass_Y = Compass_Y_Mid
                Compassstate$="Compass: Center on self"
            End If
            
            ''  draw compass background
            circle (Compass_X_Mid, Compass_Y_Mid), Compass_Radius, RGB(2, 12, 2),,,1,f
            
            ''  needles pointing towards nearest asteroids / comet debris
            For i = 0 to Ubound(Asteroid)
                If Asteroid(i).State = 1 Then
                    Pol ((Compass_X-Screen_X_Mid)-(Asteroid(i).X-Ship(0).X), (Compass_Y-Screen_Y_Mid)-(Asteroid(i).Y-Ship(0).y))
                    If Rpol < Screen_X Then
                        Rec (Compass_Radius-1, Tpol+180)
                        line (Compass_X_Mid, Compass_Y_Mid)-(Compass_X_Mid+Xrec, Compass_Y_Mid+Yrec), Rgb(8, 48, 8)
                    End If
                End If
            Next
            For i = 0 to Ubound(Comet_Debris)
                If Comet_Debris(i).State = 1 Then
                    Pol ((Compass_X-Screen_X_Mid)-(Comet_Debris(i).X-Ship(0).X), (Compass_Y-Screen_Y_Mid)-(Comet_Debris(i).Y-Ship(0).y))
                    If Rpol < Screen_X Then
                        Rec (Compass_Radius-1, Tpol+180)
                        line (Compass_X_Mid, Compass_Y_Mid)-(Compass_X_Mid+Xrec, Compass_Y_Mid+Yrec), Rgb(8, 48, 8)
                    End If
                End If
            Next
            
            ''  needles pointing towards nearest emerald asteroids
            For i = 0 to Ubound(Emerald)
                If Emerald(i).State = 1 Then
                    Pol ((Compass_X-Screen_X_Mid)-(Emerald(i).X-Ship(0).X), (Compass_Y-Screen_Y_Mid)-(Emerald(i).Y-Ship(0).y))
                    If Rpol < Screen_X Then
                        Rec (Compass_Radius-1, Tpol+180)
                        R = 128
                        G = 0.2*R
                        B = 0.2*R
                        line (Compass_X_Mid, Compass_Y_Mid)-(Compass_X_Mid+Xrec, Compass_Y_Mid+Yrec), Rgb(R, G, B)
                    End If
                End If
            Next
            
            ''  draw compass foreground
            circle (Compass_X_Mid, Compass_Y_Mid), 0.66*Compass_Radius, RGB(2, 12, 2),,,1,f
            circle (Compass_X_Mid, Compass_Y_Mid), 0.66*Compass_Radius, RGB(8, 48, 8),,,1
            
            ''  needle pointing towards home planet
            Pol ((Compass_X-Screen_X_Mid)-(Station(0).X-Ship(0).X), (Compass_Y-Screen_Y_Mid)-(Station(0).Y-Ship(0).Y))
            rec (Compass_Radius-1, Tpol+180)
            line(Compass_X_Mid, Compass_Y_Mid)-(Compass_X_Mid+Xrec, Compass_Y_Mid+Yrec), Rgb(16, 96, 16)
            
            ''  needles pointing towards planets
            For i = 1 to Ubound(Planet)
                If Planet(i).State = 1 Then
                    Pol ((Compass_X-Screen_X_Mid)-(Planet(i).X-Ship(0).X), (Compass_Y-Screen_Y_Mid)-(Planet(i).Y-Ship(0).y))
                    Rec (Compass_Radius-1, Tpol+180)
                    line (Compass_X_Mid, Compass_Y_Mid)-(Compass_X_Mid+Xrec, Compass_Y_Mid+Yrec), Rgb(16, 96, 16)
                End If
            Next
            
            circle (Compass_X_Mid, Compass_Y_Mid), 0.33*Compass_Radius, RGB(2, 12, 2),,,1, f
            circle (Compass_X_Mid, Compass_Y_Mid), 0.33*Compass_Radius, RGB(8, 48, 8),,,1
            
            ''  needle pointing towards the sun
            Pol ((Compass_X-Screen_X_Mid)-(Planet(0).X-Ship(0).X), (Compass_Y-Screen_Y_Mid)-(Planet(0).Y-Ship(0).Y))
            rec (Compass_Radius-1, Tpol+180)
            line (Compass_X_Mid, Compass_Y_Mid)-(Compass_X_Mid+Xrec, Compass_Y_Mid+Yrec), Rgb(32, 192, 32)
            
            circle (Compass_X_Mid, Compass_Y_Mid), Compass_Radius, RGB(8, 48, 8),,,1
            
        Else
            
            Compassstate$ = "Compass: Off"
        
        End If
        
        ''  decide wether minimap is on or off
        If Map_State <> 0 then 
            
            '' what to do if minimap is on...
            If Map_State = 1 then
                ''  change minimap scale using "," and "."
                If multikey (51) then 
                    Map_Scale -= Map_Scale*(2/FPS)
                    If Map_Scale < 1/5000 then Map_Scale = 1/5000
                    Map_Scale_Old = Map_Scale
                End If
                If multikey (52) then 
                    Map_Scale += Map_Scale*(2/FPS)
                    If Map_Scale > 1/5 then Map_Scale = 1/5
                    Map_Scale_Old = Map_Scale
                End If
                ''  if map_state is 1 then center minimap on tracked Planet
                Map_X = -(Ship(0).X)
                Map_Y = -(Ship(0).Y)
                Mapstate$ = "Minimap: Center on ship"
                Map_Scale = Map_Scale_Old
            Else 
                ''  change minimap scale using "," and "."
                If multikey (51) then 
                    Map_Scale -= Map_Scale*(2/FPS)
                    If Map_Scale < 1/5000 then Map_Scale = 1/5000
                    Map_Scale_Old2 = Map_Scale
                End If
                If multikey (52) then 
                    Map_Scale += Map_Scale*(2/FPS)
                    If Map_Scale > Map_Scale_Start then Map_Scale = Map_Scale_Start
                    Map_Scale_Old2 = Map_Scale
                End If
                ''  if map_state is 2 then center minimap on sun
                Map_X = -(Planet(0).X)
                Map_Y = -(Planet(0).Y)
                Mapstate$ = "Minimap: Center on sun"
                Map_Scale = Map_Scale_Old2
            End If
            
            ''  draw minimap background
            circle (Map_X_Mid, Map_Y_Mid), Map_Radius, rgb(2, 12, 2),,,1,f
            
            ''  draw punctured screen rectangle on minimap
            Map_X_Scale = Map_X*Map_Scale
            Map_Y_Scale = Map_Y*Map_Scale
            
            Pol (Screen_X_Mid-MidX, Screen_Y_Mid-MidY)
            Rpol=Rpol*Map_Scale
            Rec (Rpol, Tpol)
            Map_Xrec = Xrec
            Map_Yrec = Yrec
            
            for i = -(Screen_X_Mid*Map_Scale)+Map_X_Scale to (Screen_X_Mid*Map_Scale)+Map_X_Scale step 2
                Pol (Map_Xrec+i, Map_Yrec+abs(Screen_Y_Mid*Map_Scale)+Map_Y_Scale)
                Rec (Rpol, Tpol)
                if Rpol < Map_Radius then pset (Map_X_Mid+Xrec, Map_Y_Mid+Yrec), Rgb(8, 48, 8)
                Pol (Map_Xrec+i, Map_Yrec-abs(Screen_Y_Mid*Map_Scale)+Map_Y_Scale)
                Rec (Rpol, Tpol)
                if Rpol < Map_Radius then pset (Map_X_Mid+Xrec, Map_Y_Mid+Yrec), Rgb(8, 48, 8)
            next
            for i = -(Screen_Y_Mid*Map_Scale)+Map_Y_Scale to (Screen_Y_Mid*Map_Scale)+Map_Y_Scale step 2
                Pol (Map_Xrec-abs(Screen_X_Mid*Map_Scale)+Map_X_Scale, Map_Yrec+i)
                Rec (Rpol, Tpol)
                if Rpol < Map_Radius then pset (Map_X_Mid+Xrec, Map_Y_Mid+Yrec), Rgb(8, 48, 8)
                Pol (Map_Xrec+abs(Screen_X_Mid*Map_Scale)+Map_X_Scale, Map_Yrec+i)
                Rec (Rpol, Tpol)
                if Rpol < Map_Radius then pset (Map_X_Mid+Xrec, Map_Y_Mid+Yrec), Rgb(8, 48, 8)
            next
            
            ''  draw asteroids on minimap
            For i = 0 to Ubound(Asteroid)
                If Asteroid(i).State = 1 Then
                    Pol ((Asteroid(i).X+Map_X)*Map_Scale, (Asteroid(i).Y+Map_Y)*Map_Scale)
                    If Rpol < Map_Radius then Pset(Map_X_Mid+(Asteroid(i).X+Map_X)*Map_Scale, Map_Y_Mid+(Asteroid(i).Y+Map_Y)*Map_Scale), Rgb(24, 144, 24)
                End If
            Next 
            
            ''  draw comets on minimap
            For i = 0 to Ubound(Comet)
                If Comet(i).State = 1 Then
                    Pol ((Comet(i).X+Map_X)*Map_Scale, (Comet(i).Y+Map_Y)*Map_Scale)
                    If Rpol < Map_Radius then Circle(Map_X_Mid+(Comet(i).X+Map_X)*Map_Scale, Map_Y_Mid+(Comet(i).Y+Map_Y)*Map_Scale), 1, Rgb(24, 144, 24),,,1,f
                End If
            Next 
            
            ''  draw comet debris on minimap
            For i = 0 to Ubound(Comet_Debris)
                If Comet_Debris(i).State = 1 Then
                    Pol ((Comet_Debris(i).X+Map_X)*Map_Scale, (Comet_Debris(i).Y+Map_Y)*Map_Scale)
                    If Rpol < Map_Radius then Pset(Map_X_Mid+(Comet_Debris(i).X+Map_X)*Map_Scale, Map_Y_Mid+(Comet_Debris(i).Y+Map_Y)*Map_Scale), Rgb(24, 144, 24)
                End If
            Next 
            
            ''  draw comet tail on minimap
            For i = 0 to Ubound(Comet_Particle) step 8
                If Comet_Particle(i).State = 1 Then
                    Pol ((Comet_Particle(i).X+Map_X)*Map_Scale, (Comet_Particle(i).Y+Map_Y)*Map_Scale)
                    If Rpol < Map_Radius then Pset(Map_X_Mid+(Comet_Particle(i).X+Map_X)*Map_Scale, Map_Y_Mid+(Comet_Particle(i).Y+Map_Y)*Map_Scale), Rgb(24, 144, 24)
                End If
            Next 
            
            ''  draw emerald asteroids on minimap
            For i = 0 to Ubound(Emerald)
                If Emerald(i).State = 1 Then
                    Pol ((Emerald(i).X+Map_X)*Map_Scale, (Emerald(i).Y+Map_Y)*Map_Scale)
                    If Rpol < Map_Radius then Pset(Map_X_Mid+(Emerald(i).X+Map_X)*Map_Scale, Map_Y_Mid+(Emerald(i).Y+Map_Y)*Map_Scale), Rgb(192, 32, 32)
                End IF
           Next 
           
           ''   draw projectiles on minimap
           For i = 0 to Ubound(Projectile)
                If Projectile(i).State = 1 Then
                    Pol ((Projectile(i).X+Map_X)*Map_Scale, (Projectile(i).Y+Map_Y)*Map_Scale)
                    If Rpol < Map_Radius then Pset(Map_X_Mid+(Projectile(i).X+Map_X)*Map_Scale, Map_Y_Mid+(Projectile(i).Y+Map_Y)*Map_Scale), Rgb(255, 255, 96)
                End If
            Next
            
            ''  draw planets on minimap
            For i = 0 to Ubound(Planet)
                If Planet(i).State = 1 Then
                    Pol ((Planet(i).X+Map_X)*Map_Scale, (Planet(i).Y+Map_Y)*Map_Scale)
                    If Rpol < Map_Radius then circle(Map_X_Mid+(Planet(i).X+Map_X)*Map_Scale, Map_Y_Mid+(Planet(i).Y+Map_Y)*Map_Scale), 1, Rgb(32, 192, 32),,,1,f
                End iF
            Next 
            
            ''  draw sun on minimap
            Pol ((Planet(0).X+Map_X)*Map_Scale, (Planet(0).Y+Map_Y)*Map_Scale)
            If Rpol < Map_Radius then circle(Map_X_Mid+(Planet(0).X+Map_X)*Map_Scale, Map_Y_Mid+(Planet(0).Y+Map_Y)*Map_Scale), 2, Rgb(42, 255, 42),,,1,f
            
            ''  draw ships on minimap
            For i = 0 to Ubound(Ship)
                If Ship(i).State = 1 Then
                    Pol ((Ship(i).X+Map_X)*Map_Scale, (Ship(i).Y+Map_Y)*Map_Scale)
                    If Rpol < Map_Radius then Circle(Map_X_Mid+(Ship(i).X+Map_X)*Map_Scale, Map_Y_Mid+(Ship(i).Y+Map_Y)*Map_Scale), 1, Rgb(24, 144, 24),,,1
                End If
            Next 
            
            ''  draw stations on minimap
            For i = 0 to Ubound(Station)
                If Station(i).State = 1 Then
                    Pol ((Station(i).X+Map_X)*Map_Scale, (Station(i).Y+Map_Y)*Map_Scale)
                    If Rpol < Map_Radius then Circle(Map_X_Mid+(Station(i).X+Map_X)*Map_Scale, Map_Y_Mid+(Station(i).Y+Map_Y)*Map_Scale), 1, Rgb(24, 144, 24),,,1,f
                End If
            Next
                
            ''  draw minimap foreground
            circle (Map_X_Mid, Map_Y_Mid), Map_Radius, Rgb(8, 48, 8),,,1
            
        Else
            
            Mapstate$ ="Minimap: Off"
            
        End If
        
        ''  print fps
        Color Rgb(16, 96, 16)
        Locate 1, 15: Print using "       screen update rate: ######"; screen_rate
        Locate 2, 15: Print using " screen updates pr second: ######"; FPS
        Locate 3, 15: Print using "  program loops pr second: ######"; LPS
        Locate 4, 15: Print using "   loops pr screen update: ######"; LPS/FPS
        Locate 5, 15: Print using "        var screen_update: ###.####"; screen_update
    
        If Ship(0).State = 0 and Wait_Time1+1.4 < Timer Then
            Color Rgb(32, 192, 32)
            Locate 23, 52: Print "       You've died!         "
            Color Rgb(16, 96, 16)
            Locate 24, 52: Print "press r-shift to play again "
            Locate 25, 52: Print "press Return to restart game"
        End If
        
        '' Menu/Data-window
        If Data_State <> 0 then
            If Data_State = 1 Then
                Color Rgb(8, 48, 8)', Rgb(2, 12, 2)
                locate 93, 47: Print Compassstate$
                locate 94, 47: Print Mapstate$
                If Map_State <> 0 Then
                    Locate 95, 47: Print using "  Scale: 1:###.#"; 1/Map_Scale
                End If 
                If Ship(0).Fuel_Mass < 10 Then 
                    Color Rgb(96, 16, 16)
                End If
                locate 93, 73: Print using "      Fuel: ####.## t"; Ship(0).Fuel_Mass: Color Rgb(8, 48, 8)
                locate 94, 73: Print using "   Payload: ####.## t"; Ship(0).Payload_Mass
                locate 95, 73: Print using "Total Mass: ####.## t"; Ship(0).Mass+Ship(0).Payload_Mass
                
                Locate 93, 99: Print using "      Speed: ####.## km/sec"; 10*sqr(Ship(0).Xvec^2+Ship(0).Yvec^2)
                If Ship(0).Shield_Strength < 5 Then
                    Color Rgb(96, 16, 16)
                End If
                Locate 94, 99: Print using "     Shield: ####.## Gw"; Ship(0).Shield_Strength: Color Rgb(8, 48, 8)
                If Station(0).Shield_Strength < 20 Then
                    Color Rgb(96, 16, 16)
                End If
                Locate 95, 99: Print using "Base shield: ####.## Gw"; Station(0).Shield_Strength: Color Rgb(8, 48, 8)
                'Color 0
            Else
                Color Rgb(8, 48, 8)', Rgb(2, 12, 2)
                locate 93, 47: Print using "  Speed: ####.## km/sec"; 10*sqr(Ship(0).Xvec^2+Ship(0).Yvec^2)
                If Ship(0).Shield_Strength < 5 Then
                    Color Rgb(96, 16, 16)
                End If
                locate 94, 47: Print using " Shield: ####.## Gw"; Ship(0).Shield_Strength: Color Rgb(8, 48, 8)
                If Ship(0).Fuel_Mass < 10 Then 
                    Color Rgb(96, 16, 16)
                End If
                locate 95, 47: Print using "   Fuel: ####.## t"; Ship(0).Fuel_Mass: Color Rgb(8, 48, 8)
            End If
        End If
        
    End If

Loop Until Multikey(1)

end





