''                             GRAVITY WARS 
''                                  by
''                           Michael S. Nissen
''                
''                        v. 1.00 - December 2005
''                        micha3l_niss3n@yahoo.dk

Option Explicit 

Restart:

#Include "Gravity_Wars.bi"

Randomize Timer

Dim Particle(400) as Particle

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

Dim Projectile(30) as Projectile

For i = 0 to Ubound(Projectile)
    With Projectile(i)
        .Speed = 6
        .State = 0
        .Time = 250
        .R = 255
        .G = 255
        .B = 255
    End With
Next

Dim Burst(50) as Burst

For i = 0 to Ubound(Burst)
    With Burst(i)
        .Speed = 0.5+Rnd*7.5
        .State = 0
        .Time = 40
        .R = 255
        .G = 255
        .B = 255
    End With
Next

Dim Body(1000) As Body

''  The sun
With Body(0) 
    .X = MidX 
    .Y = MidY 
    .Mass = 20000
    .Radius = 48
    .State = 1
End With 

''  Planet 1
With Body(1)
    .Orbit_Radius = 10000
    .Angle = Rnd*(Pi*2)
    .X = MidX-.Orbit_Radius*Sin(.Angle) 
    .Y = MidY-.Orbit_Radius*Cos(.Angle) 
    .Mass = 2000
    .Radius = ((.mass/(4/3)*pi)^(1/3))/750
    .XVec = sqr((Body(0).Mass)/(.Orbit_Radius))*Cos(.Angle)
    .YVec = sqr((Body(0).Mass)/(.Orbit_Radius))*Sin(-.Angle)
    .State = 1
    .R = 32
    .G = 16
    .B = 64
End With 

''  Planet 2
With Body(2)
    .Orbit_Radius = 6800
    .Angle = Rnd*(Pi*2)
    .X = MidX-.Orbit_Radius*Sin(.Angle) 
    .Y = MidY-.Orbit_Radius*Cos(.Angle) 
    .Mass = 100
    .Radius = ((.mass/(4/3)*pi)^(1/3))/750
    .XVec = -sqr((Body(0).Mass)/(.Orbit_Radius))*Cos(.Angle)
    .YVec = -sqr((Body(0).Mass)/(.Orbit_Radius))*Sin(-.Angle)
    .State = 1
    .R = 32
    .G = 32
    .B = 32
End With 

'' Planet 1's ring
'For i = 3 To 250 
'    With Body(i) 
'        .Angle = Rnd*(Pi*2) 
'        .Orbit_Radius = 1000+Rnd*200
'        .Mass = 5+Rnd*195
'        .X = Body(1).X-.Orbit_Radius*Sin(.Angle) 
'        .Y = Body(1).Y-.Orbit_Radius*Cos(.Angle) 
'        .Radius = ((.mass/(4/3)*pi)^(1/3))*0.5
'        .XVec = Body(1).Xvec+sqr((Gravity*Body(1).Mass)/.Orbit_Radius)*Cos(.Angle) 
'        .YVec = Body(1).Yvec+sqr((Gravity*Body(1).Mass)/.Orbit_Radius)*Sin(-.Angle) 
'        .State = 1
'        .R = 192+(32-Rnd*32)
'        .G = 192+(32-Rnd*32)
'        .B = 128+(32-Rnd*32)
'    End With 
'Next 

'' Common Asteroids
If Ubound(Body)>=3 Then 
    For i = 3 To 800
        With Body(i) 
            .Angle = Rnd*(2*Pi)
            .Orbit_Radius = 4000+Rnd*1000
            .X = MidX-.Orbit_Radius*Sin(.Angle) 
            .Y = MidY-.Orbit_Radius*Cos(.Angle) 
            .Mass = 10
            .Radius = 6'((.mass/(4/3)*pi)^(1/3))*0.5
            .XVec = sqr(((Body(0).Mass))/(.Orbit_Radius))*Cos(.Angle)
            .YVec = sqr(((Body(0).Mass))/(.Orbit_Radius))*Sin(-.Angle)
            If Int(Rnd*8) = 0 Then 
                .XVec =- .XVec 
                .YVec =- .YVec 
            End If
            .State = 1
            .R = 64+(rnd*32-rnd*32)
            .G = .R+(rnd*16-Rnd*16)
            .B = .R+(rnd*16-Rnd*16)
        End With 
    Next 
End If 

'' Emerald Asteroids
If Ubound(Body)>=801 Then 
    For i = 801 To Ubound(Body)
        With Body(i) 
            .Angle = Rnd*(2*Pi)
            .Orbit_Radius = 150+Rnd*1050
            .X = Body(1).X-.Orbit_Radius*Sin(.Angle) 
            .Y = Body(1).Y-.Orbit_Radius*Cos(.Angle) 
            .Mass = 1
            .Radius = 5'((.mass/(4/3)*pi)^(1/3))*0.5
            .XVec = Body(1).Xvec-sqr(((Body(1).Mass))/(.Orbit_Radius))*Cos(.Angle)
            .YVec = Body(1).Yvec-sqr(((Body(1).Mass))/(.Orbit_Radius))*Sin(-.Angle)
            'If Int(Rnd*8) = 0 Then 
            '    .XVec =- .XVec 
            '    .YVec =- .YVec 
            'End If
            .State = 1
            .R = 160+(rnd*56-rnd*56)
            .G = 56+(rnd*12-rnd*12)
            .B = 160+(rnd*56-rnd*56)
        End With 
    Next 
End If 

Dim Station(0) As Station

''  Player 1's Base
With Station(0)
    .Orbit_Radius = 2400
    .Angle = Rnd*(Pi*2)
    .X = MidX-.Orbit_Radius*Sin(.Angle) 
    .Y = MidY-.Orbit_Radius*Cos(.Angle) 
    .Mass = 200
    .Radius = 50
    .XVec = sqr((Body(0).Mass)/(.Orbit_Radius))*Cos(.Angle)
    .YVec = sqr((Body(0).Mass)/(.Orbit_Radius))*Sin(-.Angle)
    .Shield_Minsize = 160
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
    .Orbit_Radius = 100
    .X = Station(0).X-.Orbit_Radius*Sin(.Angle)
    .Y = Station(0).Y-.Orbit_Radius*Cos(.Angle) 
    .Fuel_Mass = 15
    .Mass = 50 + .Fuel_Mass
    .Payload_Mass = 0
    .Direction = Rnd*(toxpi)
    .Radius = 16
    .XVec = Station(0).Xvec-sqr((Station(0).Mass)/.Orbit_Radius)*Cos(.Angle)
    .YVec = Station(0).Yvec-sqr((Station(0).Mass)/.Orbit_Radius)*Sin(-.Angle)
    .Shield_Minsize = 20
    .Shield_Strength = 0
    .Shield_State = 0
    .State = 1
    .R = 112
    .G = 96
    .B = 96
End With 

''  Detect screen settings and apply them to the game
Screeninfo screen_x, screen_y, screen_bpp
screenres screen_x, screen_y, screen_bpp, 2, 1

Screen_X_Mid = 0.5 * Screen_X
Screen_Y_Mid = 0.5 * Screen_Y

MidX = Screen_X_Mid
MidY = Screen_Y_Mid

Map_X_Mid = 128
Map_Y_Mid = Screen_Y - 129

Compass_X_Mid = 300
Compass_Y_Mid = Screen_Y - 49

''  calculate reasonable grid size and scale values for minimap
For i = 0 to Ubound(Body)
    If Body(i).Orbit_Radius > i2 then i2 = Body(i).Orbit_Radius
Next
For i = 0 to Ubound(Station)
    If Station(i).Orbit_Radius > i2 then i2 = Station(i).Orbit_Radius
Next

Grid_Dist = screen_y
Grid_Num = int(i2/Grid_Dist)
Grid_Num += int(Grid_Num/4)
Grid_Radius = Grid_Num*Grid_Dist
Grid_2 = -1*(1/Grid_Num)
Grid_3 = -4*(1/Grid_Num)
Grid_4 = -7*(1/Grid_Num)

Grid_45.0 = Cos(45*Radtodeg)*Grid_Radius

Grid_67.5 = Cos(67.5*Radtodeg)*Grid_Radius
Grid_22.5 = Cos(22.5*Radtodeg)*Grid_Radius

Grid_11.25 = Cos(11.25*Radtodeg)*Grid_Radius
Grid_33.75 = Cos(33.75*Radtodeg)*Grid_Radius
Grid_56.25 = Cos(56.25*Radtodeg)*Grid_Radius
Grid_78.75 = Cos(78.75*Radtodeg)*Grid_Radius

Map_Scale = (128/Grid_Radius)
Map_Scale_Start = Map_Scale
Map_Scale_Old2 = Map_Scale
Map_Scale_Old = 2*Map_Scale

Setmouse ,,0

Do 
    
    Screenset P2, P1 
    Swap P2, P1 
    Cls
    
    ''  calculate frames per second
    If Timer < FPS_timer + 1 Then
        FPS_Counter += 1
    Else
        FPS = FPS_Counter
        FPS_Counter = 0
        FPS_Timer = Timer
    End If
    
    ''  Spaceship controls
    If Ship(0).State = 1 Then
        
        ''  toggle ship turn left/right
        If multikey (75) then 
            Ship(0).Direction += 6: If Ship(0).Direction >= 360 then Ship(0).Direction -= 360
            Rec (8, 180-Ship(0).Direction)
            Ship(0).Xtrac = Xrec
            Ship(0).Ytrac = Yrec
        End If
        If multikey (77) then 
            Ship(0).Direction -= 6: If Ship(0).Direction < 0 then Ship(0).Direction += 360
            Rec (8, 180-Ship(0).Direction)
            Ship(0).Xtrac = Xrec
            Ship(0).Ytrac = Yrec
        End If
        
        ''  toggle ship thrust
        If multikey (72) then
            If Ship(0).Fuel_Mass >= 0.01 then
                Ship(0).Xvec += 30*(Cos(Ship(0).Direction*Radtodeg)/Ship(0).Mass)
                Ship(0).Yvec += 30*(Sin(-Ship(0).Direction*Radtodeg)/Ship(0).Mass)
                Ship(0).Fuel_Mass -= 0.01
                Ship(0).Mass -= 0.01
                For i = 0 to Ubound(Burst)
                    If Burst(i).State = 0 Then
                        Burst(i).Direction = Ship(0).Direction+(Rnd*6-Rnd*6)
                        Burst(i).XVec = (Burst(i).Speed*Cos(Burst(i).Direction*Radtodeg))-Ship(0).Xvec
                        Burst(i).YVec = (Burst(i).Speed*Sin(-Burst(i).Direction*Radtodeg))-Ship(0).Yvec
                        Burst(i).X = Ship(0).X
                        Burst(i).Y = Ship(0).Y
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
            For i = Ubound(Body) to 2 step -1
                If Body(i).State = 1 Then
                    Distance = sqr(((Body(i).Y-Ship(0).Y)^2) + ((Body(i).X-Ship(0).X)^2))
                    If Distance <= 70 and Payload_State = 0 and Timer > Wait_Time0 then
                        swap Payload_Val0, Payload_Val1
                        Payload_State = Payload_Val0
                        Pay_Num = i
                        Ship(0).Payload_Mass = Body(i).Mass
                    End If
                End If
            Next
            Wait_Time0 = Timer + 0.1
        End If
        
        ''  toggle shield and shock-wave (temporary)
        If Multikey(83) Then
            If Ship(0).Fuel_Mass >= 0.5 and Wait_Time1 < Timer Then
                Ship(0).Shield_Strength += 1
                Ship(0).Shock_Strength += 175
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
        
        ''  update shield strength and shock-wave strength
        If Ship(0).Shield_State = 1 Then
            Ship(0).Shield_Strength -= 0.01
            Ship(0).Shock_Strength -= 0.35
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
    
    ''  calculate gravitational influence
    ''  set i = 0 to Ubound(Body) to make all bodies influence each other (slows down program!)
    For i = 0 To 2           '' from 0 to # of bodies w. influential Mass
        For i2 = i+1 To Ubound(Body)    '' from 1 to # of bodies in system
            If Body(i).State = 1 and Body(i2).State = 1 Then
                Distance = sqr(((Body(i).Y-Body(i2).Y)^2) + ((Body(i).X-Body(i2).X)^2))
                MinDist = Body(i).Radius+Body(i2).Radius
                    If Distance < MinDist then
                        Distance = MinDist'Body(i2).State = 0
                        If Payload_State = 1 and i2 = Pay_Num Then 
                            Payload_State = 0
                            Ship(0).Payload_Mass = 0
                            swap Payload_Val0, Payload_Val1
                        End If
                    End If
                Gforce = ((Body(i).Mass*Body(i2).Mass)/(Distance^2))
                Body(i).Xvec -= ((Body(i).X-Body(i2).X)/Distance)*(Gforce/Body(i).Mass)
                Body(i).Yvec -= ((Body(i).Y-Body(i2).Y)/Distance)*(Gforce/Body(i).Mass) 
                Body(i2).Xvec -= ((Body(i2).X-Body(i).X)/Distance)*(Gforce/Body(i2).Mass)
                Body(i2).Yvec -= ((Body(i2).Y-Body(i).Y)/Distance)*(Gforce/Body(i2).Mass)
            End If
        Next
        For i2 = 0 To Ubound(Ship)  '' from 0 to # of ships
            If Body(i).State = 1 and Ship(i2).State = 1 Then
                Distance = sqr(((Body(i).Y-Ship(i2).Y)^2) + ((Body(i).X-Ship(i2).X)^2))
                Gforce = ((Body(i).Mass*Ship(i2).Mass)/(Distance^2))
                Ship(i2).Xvec -= ((Ship(i2).X-Body(i).X)/Distance)*(Gforce/Ship(i2).Mass)
                Ship(i2).Yvec -= ((Ship(i2).Y-Body(i).Y)/Distance)*(Gforce/Ship(i2).Mass)
                Body(i).Xvec -= ((Body(i).X-Ship(i2).X)/Distance)*(Gforce/Body(i).Mass)
                Body(i).Yvec -= ((Body(i).Y-Ship(i2).Y)/Distance)*(Gforce/Body(i).Mass)
            End If
        Next
        For i2 = 0 To Ubound(Station)  '' from 0 to # of stations
            If Body(i).State = 1 and Station(i2).State = 1 Then
                Distance = sqr(((Body(i).Y-Station(i2).Y)^2) + ((Body(i).X-Station(i2).X)^2))
                Gforce = ((Body(i).Mass*Station(i2).Mass)/(Distance^2))
                Station(i2).Xvec -= ((Station(i2).X-Body(i).X)/Distance)*(Gforce/Station(i2).Mass)
                Station(i2).Yvec -= ((Station(i2).Y-Body(i).Y)/Distance)*(Gforce/Station(i2).Mass)
                Body(i).Xvec -= ((Body(i).X-Station(i2).X)/Distance)*(Gforce/Body(i).Mass)
                Body(i).Yvec -= ((Body(i).Y-Station(i2).Y)/Distance)*(Gforce/Body(i).Mass)
            End If
        Next
    Next
    For i = 0 to Ubound(Station)
        For i2 = i+1 To Ubound(Body)    '' from 1 to # of bodies in system
            If Station(i).State = 1 and Body(i2).State = 1 Then
                Distance = sqr(((Station(i).Y-Body(i2).Y)^2) + ((Station(i).X-Body(i2).X)^2))
                MinDist = Station(i).Radius+Body(i2).Radius
                    If Distance < MinDist then
                        Body(i2).State = 0
                        If Payload_State = 1 and i2 = Pay_Num Then 
                            Payload_State = 0
                            Ship(0).Payload_Mass = 0
                            swap Payload_Val0, Payload_Val1
                        End If
                    End If
                Gforce = ((Station(i).Mass*Body(i2).Mass)/(Distance^2))
                Station(i).Xvec -= ((Station(i).X-Body(i2).X)/Distance)*(Gforce/Station(i).Mass)
                Station(i).Yvec -= ((Station(i).Y-Body(i2).Y)/Distance)*(Gforce/Station(i).Mass) 
                Body(i2).Xvec -= ((Body(i2).X-Station(i).X)/Distance)*(Gforce/Body(i2).Mass)
                Body(i2).Yvec -= ((Body(i2).Y-Station(i).Y)/Distance)*(Gforce/Body(i2).Mass)
            End If
        Next
        For i2 = 0 To Ubound(Ship)  '' from 0 to # of ships
            If Station(i).State = 1 and Ship(i2).State = 1 Then
                Distance = sqr(((Station(i).Y-Ship(i2).Y)^2) + ((Station(i).X-Ship(i2).X)^2))
                MinDist = Station(i).Radius+Ship(i2).Radius
                    If Distance < MinDist then
                        Distance = MinDist
                    End If
                Gforce = ((Station(i).Mass*Ship(i2).Mass)/(Distance^2))
                Ship(i2).Xvec -= ((Ship(i2).X-Station(i).X)/Distance)*(Gforce/Ship(i2).Mass)
                Ship(i2).Yvec -= ((Ship(i2).Y-Station(i).Y)/Distance)*(Gforce/Ship(i2).Mass)
                Station(i).Xvec -= ((Station(i).X-Ship(i2).X)/Distance)*(Gforce/Station(i).Mass)
                Station(i).Yvec -= ((Station(i).Y-Ship(i2).Y)/Distance)*(Gforce/Station(i).Mass)
            End If
        Next
    Next
    
    ''  stage 1 collision detection
    For i = 0 To Ubound(Body)
        For i2 = 0 To Ubound(Ship)
            If Body(i).State = 1 and Ship(i2).State = 1 Then
                Distance = sqr(((Body(i).Y-Ship(i2).Y)^2) + ((Body(i).X-Ship(i2).X)^2))
                MinDist = Body(i).Radius+Ship(i2).Radius
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
            Ship(i).Shock_Strength += Ship(i).Fuel_Mass*350
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
        Distance = sqr((((Ship(0).Y+Ship(0).Ytrac)-Body(Pay_Num).Y)^2) + (((Ship(0).Xtrac+Ship(0).X)-Body(Pay_Num).X)^2))
        Ship(0).Xvec -= (((Ship(0).Xtrac+Ship(0).X)-Body(Pay_Num).X)/Distance)*((Distance-70)/Ship(0).Mass)
        Ship(0).Yvec -= (((Ship(0).Y+Ship(0).Ytrac)-Body(Pay_Num).Y)/Distance)*((Distance-70)/Ship(0).Mass)
        Body(Pay_Num).Xvec -= ((Body(Pay_Num).X-(Ship(0).Xtrac+Ship(0).X))/Distance)*(((Distance-70))/Body(Pay_Num).Mass)
        Body(Pay_Num).Yvec -= ((Body(Pay_Num).Y-(Ship(0).Y+Ship(0).Ytrac))/Distance)*(((Distance-70))/Body(Pay_Num).Mass)
    End If
    
    ''  calculate planet asteroid deflection shield
    For i = 0 to Ubound(Station)
        For i2 = 0 to Ubound(Body)
            If Body(i2).State = 1 Then
                Distance = sqr(((Body(i2).Y-Station(i).Y)^2) + ((Body(i2).X-Station(i).X)^2))
                If Distance <= 160+Body(i2).Radius Then
                    If i2 > 800 and i2 <> Pay_Num Then 
                        Station(i).Shield_Strength += Body(i2).Mass/10
                        Body(i2).State = 0
                    Else
                        If Station(i).Shield_State = 1 Then
                            Body(i2).Xvec += (500*((Body(i2).X-Station(i).X)/Distance))/Body(i2).Mass
                            Body(i2).Yvec += (500*((Body(i2).Y-Station(i).Y)/Distance))/Body(i2).Mass
                            Station(i).Xvec += (500*((Station(i).X-Body(i2).X)/Distance))/Station(i).Mass
                            Station(i).Yvec += (500*((Station(i).Y-Body(i2).Y)/Distance))/Station(i).Mass
                        End If
                    End If
                End If
            End If
        Next
        Station(i).Shield_Strength -= 0.01
        If Station(i).Shield_Strength <= 0 Then 
            Station(i).Shield_Strength = 0
            Station(i).Shield_State = 0
        End If
    Next

    ''  calculate ship asteroid deflection shield
    For i = 0 to Ubound(Ship)
        If Ship(i).Shield_State = 1 Then
             For i2 = 0 to Ubound(Body)
                If Body(i2).State = 1 Then
                    Distance = sqr(((Body(i2).Y-Ship(i).Y)^2) + ((Body(i2).X-Ship(i).X)^2))
                    If Distance < Ship(i).Shield_Minsize+2+sqr(Ship(i).Shield_Strength/pi)+Body(i2).Radius Then
                        Body(i2).Xvec += (500*((Body(i2).X-Ship(i).X)/Distance))/Body(i2).Mass
                        Body(i2).Yvec += (500*((Body(i2).Y-Ship(i).Y)/Distance))/Body(i2).Mass
                        Ship(i).Xvec += (500*((Ship(i).X-Body(i2).X)/Distance))/Ship(i).Mass
                        Ship(i).Yvec += (500*((Ship(i).Y-Body(i2).Y)/Distance))/Ship(i).Mass
                    End If
                End If
            Next
        End If
    Next
    
    ''  calculate shock-wave's asteroid deflection
    For i = 0 to Ubound(Ship)
        If Ship(i).Shock_State = 1 Then
            For i2 = 0 to Ubound(Body)
                If Body(i2).State = 1 Then
                    Distance = sqr(((Body(i2).Y-Ship(i).Y)^2) + ((Body(i2).X-Ship(i).X)^2))
                    Body(i2).Xvec += Ship(i).Shock_Strength*((Body(i2).X-Ship(i).X)/Distance)*(((Body(i2).Radius^2*pi)/Distance^2)/Body(i2).Mass)
                    Body(i2).Yvec += Ship(i).Shock_Strength*((Body(i2).Y-Ship(i).Y)/Distance)*(((Body(i2).Radius^2*pi)/Distance^2)/Body(i2).Mass)
                End If
            Next
        End If
    Next
    
    '' calculate when picked up emerald asteroid is delivered at home-planet
        If Payload_State = 1 and Pay_Num >= 851 Then
            Distance = sqr(((Body(Pay_Num).X-Station(0).X)^2) + ((Body(Pay_Num).Y-Station(0).Y)^2))
            If Distance-Body(Pay_Num).Radius <= 160 Then 
                swap Payload_Val0, Payload_Val1
                Body(Pay_Num).State = 0
                Payload_State = Payload_Val0
                Ship(0).Payload_Mass = 0
                Ship(0).Fuel_Mass += Body(Pay_Num).Mass/10 
                If Ship(0).Fuel_Mass > 500 Then Ship(0).Fuel_Mass = 500
                Ship(0).Mass += Body(Pay_Num).Mass/10 
                Station(0).Shield_Strength += Body(Pay_Num).Mass/10
            End If
        End If
    
    ''  center screen on ship x-y coordinates
    MidX = Screen_X_Mid-(Ship(0).X+Ship(0).Xvec)
    MidY = Screen_Y_Mid-(Ship(0).Y+Ship(0).Yvec)
    
    ''  draw grid
    If Grid_State = 1 Then
        for i = 1 to Grid_Num
            Ellipse (Body(0).X+MidX, Body(0).Y+MidY, i*Grid_Dist, i*Grid_Dist, 0, RGB(4, 24, 4))
        Next
        ''  vertical and horizontal lines
        line (Body(0).X+MidX-Grid_Radius, Body(0).Y+MidY)-(Body(0).X+MidX+Grid_Radius, Body(0).Y+MidY), RGB(4, 24, 4)
        line (Body(0).X+MidX, Body(0).Y+MidY-Grid_Radius)-(Body(0).X+MidX, Body(0).Y+MidY+Grid_Radius), RGB(4, 24, 4)
        ''  45 deg. tilted lines
        Line (Body(0).X+MidX-(Grid_45.0*Grid_2), Body(0).Y+MidY-(Grid_45.0*Grid_2))-(Body(0).X+MidX+Grid_45.0, Body(0).Y+MidY+Grid_45.0), RGB(4, 24, 4)
        Line (Body(0).X+MidX-Grid_45.0, Body(0).Y+MidY-Grid_45.0)-(Body(0).X+MidX+(Grid_45.0*Grid_2), Body(0).Y+MidY+(Grid_45.0*Grid_2)), RGB(4, 24, 4)
        Line (Body(0).X+MidX-Grid_45.0, Body(0).Y+MidY+Grid_45.0)-(Body(0).X+MidX+(Grid_45.0*Grid_2), Body(0).Y+MidY-(Grid_45.0*Grid_2)), RGB(4, 24, 4)
        Line (Body(0).X+MidX-(Grid_45.0*Grid_2), Body(0).Y+MidY+(Grid_45.0*Grid_2))-(Body(0).X+MidX+Grid_45.0, Body(0).Y+MidY-Grid_45.0), RGB(4, 24, 4)
        
        Line (Body(0).X+MidX+(Grid_67.5*Grid_3), Body(0).Y+MidY+(Grid_22.5*Grid_3))-(Body(0).X+MidX-Grid_67.5, Body(0).Y+MidY-Grid_22.5), RGB(4, 24, 4)
        Line (Body(0).X+MidX+Grid_67.5, Body(0).Y+MidY+Grid_22.5)-(Body(0).X+MidX-(Grid_67.5*Grid_3), Body(0).Y+MidY-(Grid_22.5*Grid_3)), RGB(4, 24, 4)
        Line (Body(0).X+MidX-(Grid_67.5*Grid_3), Body(0).Y+MidY+(Grid_22.5*Grid_3))-(Body(0).X+MidX+Grid_67.5, Body(0).Y+MidY-Grid_22.5), RGB(4, 24, 4)
        Line (Body(0).X+MidX-Grid_67.5, Body(0).Y+MidY+Grid_22.5)-(Body(0).X+MidX+(Grid_67.5*Grid_3), Body(0).Y+MidY-(Grid_22.5*Grid_3)), RGB(4, 24, 4)
        Line (Body(0).X+MidX+(Grid_22.5*Grid_3), Body(0).Y+MidY+(Grid_67.5*Grid_3))-(Body(0).X+MidX-Grid_22.5, Body(0).Y+MidY-Grid_67.5), RGB(4, 24, 4)
        Line (Body(0).X+MidX+Grid_22.5, Body(0).Y+MidY+Grid_67.5)-(Body(0).X+MidX-(Grid_22.5*Grid_3), Body(0).Y+MidY-(Grid_67.5*Grid_3)), RGB(4, 24, 4)
        Line (Body(0).X+MidX-Grid_22.5, Body(0).Y+MidY+Grid_67.5)-(Body(0).X+MidX+(Grid_22.5*Grid_3), Body(0).Y+MidY-(Grid_67.5*Grid_3)), RGB(4, 24, 4)
        Line (Body(0).X+MidX-(Grid_22.5*Grid_3), Body(0).Y+MidY+(Grid_67.5*Grid_3))-(Body(0).X+MidX+Grid_22.5, Body(0).Y+MidY-Grid_67.5), RGB(4, 24, 4)
        
        Line (Body(0).X+MidX+(Grid_78.75*Grid_4), Body(0).Y+MidY+(Grid_11.25*Grid_4))-(Body(0).X+MidX-Grid_78.75, Body(0).Y+MidY-Grid_11.25), RGB(4, 24, 4)
        Line (Body(0).X+MidX+Grid_78.75, Body(0).Y+MidY+Grid_11.25)-(Body(0).X+MidX-(Grid_78.75*Grid_4), Body(0).Y+MidY-(Grid_11.25*Grid_4)), RGB(4, 24, 4)
        Line (Body(0).X+MidX-(Grid_78.75*Grid_4), Body(0).Y+MidY+(Grid_11.25*Grid_4))-(Body(0).X+MidX+Grid_78.75, Body(0).Y+MidY-Grid_11.25), RGB(4, 24, 4)
        Line (Body(0).X+MidX-Grid_78.75, Body(0).Y+MidY+Grid_11.25)-(Body(0).X+MidX+(Grid_78.75*Grid_4), Body(0).Y+MidY-(Grid_11.25*Grid_4)), RGB(4, 24, 4)
        Line (Body(0).X+MidX+(Grid_11.25*Grid_4), Body(0).Y+MidY+(Grid_78.75*Grid_4))-(Body(0).X+MidX-Grid_11.25, Body(0).Y+MidY-Grid_78.75), RGB(4, 24, 4)
        Line (Body(0).X+MidX+Grid_11.25, Body(0).Y+MidY+Grid_78.75)-(Body(0).X+MidX-(Grid_11.25*Grid_4), Body(0).Y+MidY-(Grid_78.75*Grid_4)), RGB(4, 24, 4)
        Line (Body(0).X+MidX-Grid_11.25, Body(0).Y+MidY+Grid_78.75)-(Body(0).X+MidX+(Grid_11.25*Grid_4), Body(0).Y+MidY-(Grid_78.75*Grid_4)), RGB(4, 24, 4)
        Line (Body(0).X+MidX-(Grid_11.25*Grid_4), Body(0).Y+MidY+(Grid_78.75*Grid_4))-(Body(0).X+MidX+Grid_11.25, Body(0).Y+MidY-Grid_78.75), RGB(4, 24, 4)
        
        Line (Body(0).X+MidX+(Grid_56.25*Grid_4), Body(0).Y+MidY+(Grid_33.75*Grid_4))-(Body(0).X+MidX-Grid_56.25, Body(0).Y+MidY-Grid_33.75), RGB(4, 24, 4)
        Line (Body(0).X+MidX+Grid_56.25, Body(0).Y+MidY+Grid_33.75)-(Body(0).X+MidX-(Grid_56.25*Grid_4), Body(0).Y+MidY-(Grid_33.75*Grid_4)), RGB(4, 24, 4)
        Line (Body(0).X+MidX-(Grid_56.25*Grid_4), Body(0).Y+MidY+(Grid_33.75*Grid_4))-(Body(0).X+MidX+Grid_56.25, Body(0).Y+MidY-Grid_33.75), RGB(4, 24, 4)
        Line (Body(0).X+MidX-Grid_56.25, Body(0).Y+MidY+Grid_33.75)-(Body(0).X+MidX+(Grid_56.25*Grid_4), Body(0).Y+MidY-(Grid_33.75*Grid_4)), RGB(4, 24, 4)
        Line (Body(0).X+MidX+(Grid_33.75*Grid_4), Body(0).Y+MidY+(Grid_56.25*Grid_4))-(Body(0).X+MidX-Grid_33.75, Body(0).Y+MidY-Grid_56.25), RGB(4, 24, 4)
        Line (Body(0).X+MidX+Grid_33.75, Body(0).Y+MidY+Grid_56.25)-(Body(0).X+MidX-(Grid_33.75*Grid_4), Body(0).Y+MidY-(Grid_56.25*Grid_4)), RGB(4, 24, 4)
        Line (Body(0).X+MidX-Grid_33.75, Body(0).Y+MidY+Grid_56.25)-(Body(0).X+MidX+(Grid_33.75*Grid_4), Body(0).Y+MidY-(Grid_56.25*Grid_4)), RGB(4, 24, 4)
        Line (Body(0).X+MidX-(Grid_33.75*Grid_4), Body(0).Y+MidY+(Grid_56.25*Grid_4))-(Body(0).X+MidX+Grid_33.75, Body(0).Y+MidY-Grid_56.25), RGB(4, 24, 4)
    End If
    
    ''  draw tractor-beam between ship and picked up asteroid
    If Payload_State = 1 then
        Line (Ship(0).XTrac+Ship(0).X+Ship(0).Xvec+MidX, Ship(0).YTrac+Ship(0).Y+Ship(0).Yvec+MidY)-(Body(Pay_Num).X+Body(Pay_Num).Xvec+MidX, Body(Pay_Num).Y+Body(Pay_Num).Yvec+MidY), Rgb(96, 96, 144)
    End If
    
    ''  draw Planet shield
    For i = 0 to Ubound(Station)
        If Station(i).State = 1 and Station(i).Shield_State = 1 Then
            Circle (Station(i).X+MidX+(-Rnd*1.5+Rnd*1.5), Station(i).Y+MidY+(-Rnd*1.5+Rnd*1.5)), 157,  Rgb(64, 64, 96),,,1
            Circle (Station(i).X+MidX+(-Rnd*1.5+Rnd*1.5), Station(i).Y+MidY+(-Rnd*1.5+Rnd*1.5)), 160,  Rgb(96, 96, 144),,,1
        Else
            Circle (Station(i).X+MidX, Station(i).Y+MidY), 160,  Rgb(64, 16, 16),,,1
        End If
    Next
    
    ''  draw sun
    ''  uncomment next two lines to make sun react on gravitiational influence
    ''  keep them commented to keep sun fixed in centre of map
    'Body(0).X += Body(0).XVec
    'Body(0).Y += Body(0).YVec
    Circle (Body(0).X+MidX, Body(0).Y+MidY), 48, Rgb(255, 104, 0),,,1,f
    Circle (Body(0).X+MidX, Body(0).Y+MidY), 46, Rgb(255, 240, 160),,,1,f
    Circle (Body(0).X+MidX, Body(0).Y+MidY), 42, Rgb(255, 255, 240),,,1,f
    Circle (Body(0).X+MidX, Body(0).Y+MidY), 34, Rgb(255, 255, 255),,,1,f
    
    '' draw celestial bodies
    For i = 1 To Ubound(Body)
        If Body(i).State = 1 Then
            Body(i).X+=Body(i).XVec 
            Body(i).Y+=Body(i).YVec
            R = Body(i).R 
            G = Body(i).G 
            B = Body(i).B 
            Circle(Body(i).X+MidX, Body(i).Y+MidY), Body(i).Radius, Rgb(R,G,B),,,1,F
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
    
    ''  Calculate and draw projectiles
    For i = 0 to Ubound(Projectile)
        If Projectile(i).State = 1 Then
            If Projectile(i).TimeLeft >= 1 Then
                Projectile(i).TimeLeft -= 1
                Projectile(i).X -= Projectile(i).Xvec
                Projectile(i).Y -= Projectile(i).Yvec
                If Point(Projectile(i).X, Projectile(i).Y) = 123567 Then 
                    Projectile(i).State = 0
                Else
                    R = Projectile(i).R*(Projectile(i).TimeLeft/Projectile(i).Time)
                    G = Projectile(i).G*(Projectile(i).TimeLeft/Projectile(i).Time)
                    B = Projectile(i).B*(Projectile(i).TimeLeft/Projectile(i).Time)
                    Pset(Projectile(i).X+MidX, Projectile(i).Y+MidY), RGB(R, G, B)
                End If
            Else
                Projectile(i).State = 0
            End If
        End If
    Next
    
    ''  calculate and draw burst
    For i = 0 to Ubound(burst)
        If Burst(i).State = 1 Then
            If Burst(i).TimeLeft >= 1 Then
                Burst(i).TimeLeft -= 1
                Burst(i).X -= Burst(i).Xvec
                Burst(i).Y -= Burst(i).Yvec
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
            Ship(i).X+=Ship(i).XVec
            Ship(i).Y+=Ship(i).YVec 
            R = Ship(i).R 
            G = Ship(i).G 
            B = Ship(i).B 
            Drawship (Ship(i).X+MidX, Ship(i).Y+MidY, Ship(i).Direction, Rgb(R,G,B))
        End If
    Next
    
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
    
    ''  draw ship shield
    For i = 0 to Ubound(Ship)
        If Ship(i).Shield_State = 1 Then
            Circle (Ship(i).X+MidX+(-Rnd*1+Rnd*1), Ship(i).Y+MidY+(-Rnd*1+Rnd*1)), Ship(i).Shield_Minsize+sqr(Ship(i).Shield_Strength/pi),  Rgb(64, 64, 96),,,1
            Circle (Ship(i).X+MidX+(-Rnd*1+Rnd*1), Ship(i).Y+MidY+(-Rnd*1+Rnd*1)), Ship(i).Shield_Minsize+2+sqr(Ship(i).Shield_Strength/pi),  Rgb(96, 96, 144),,,1
        End If
    Next
    
    ''  decide wether minimap is on or off
    If Map_State <> 0 then 
        
        '' what to do if minimap is on...
        If Map_State = 1 then
            ''  change minimap scale using "," and "."
            If multikey (51) then 
                Map_Scale = Map_Scale - (Map_Scale*(1/40))
                If Map_Scale < 1/5000 then Map_Scale = 1/5000
                Map_Scale_Old = Map_Scale
            End If
            If multikey (52) then 
                Map_Scale = Map_Scale + (Map_Scale*(1/40))
                If Map_Scale > 1/5 then Map_Scale = 1/5
                Map_Scale_Old = Map_Scale
            End If
            ''  if map_state is 1 then center minimap on tracked body
            Map_X = -(Ship(0).X)
            Map_Y = -(Ship(0).Y)
            Mapstate$ = "Minimap: Center on ship"
            Map_Scale = Map_Scale_Old
        Else 
            ''  change minimap scale using "," and "."
            If multikey (51) then 
                Map_Scale = Map_Scale - (Map_Scale*(1/40))
                If Map_Scale < 1/5000 then Map_Scale = 1/5000
                Map_Scale_Old2 = Map_Scale
            End If
            If multikey (52) then 
                Map_Scale = Map_Scale + (Map_Scale*(1/40))
                If Map_Scale > Map_Scale_Start then Map_Scale = Map_Scale_Start
                Map_Scale_Old2 = Map_Scale
            End If
            ''  if map_state is 2 then center minimap on sun
            Map_X = -(Body(0).X)
            Map_Y = -(Body(0).Y)
            Mapstate$ = "Minimap: Center on sun"
            Map_Scale = Map_Scale_Old2
        End If
        
        ''  draw minimap background
        circle (Map_X_Mid, Map_Y_Mid), 128, rgb(2, 12, 2),,,1,f
        
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
            if Rpol < 128 then pset (Map_X_Mid+Xrec, Map_Y_Mid+Yrec), Rgb(8, 48, 8)
            Pol (Map_Xrec+i, Map_Yrec-abs(Screen_Y_Mid*Map_Scale)+Map_Y_Scale)
            Rec (Rpol, Tpol)
            if Rpol < 128 then pset (Map_X_Mid+Xrec, Map_Y_Mid+Yrec), Rgb(8, 48, 8)
        next
        for i = -(Screen_Y_Mid*Map_Scale)+Map_Y_Scale to (Screen_Y_Mid*Map_Scale)+Map_Y_Scale step 2
            Pol (Map_Xrec-abs(Screen_X_Mid*Map_Scale)+Map_X_Scale, Map_Yrec+i)
            Rec (Rpol, Tpol)
            if Rpol < 128 then pset (Map_X_Mid+Xrec, Map_Y_Mid+Yrec), Rgb(8, 48, 8)
            Pol (Map_Xrec+abs(Screen_X_Mid*Map_Scale)+Map_X_Scale, Map_Yrec+i)
            Rec (Rpol, Tpol)
            if Rpol < 128 then pset (Map_X_Mid+Xrec, Map_Y_Mid+Yrec), Rgb(8, 48, 8)
        next
        
        ''  draw asteroids on minimap
        For i = 3 to 800
            If Body(i).State = 1 Then
                Pol ((Body(i).X+Map_X)*Map_Scale, (Body(i).Y+Map_Y)*Map_Scale)
                If Rpol <= 127 then Pset(Map_X_Mid+(Body(i).X+Map_X)*Map_Scale, Map_Y_Mid+(Body(i).Y+Map_Y)*Map_Scale), Rgb(24, 144, 24)
            End If
        Next 
        
        ''  draw emerald asteroids on minimap
        For i = 801 to Ubound(body)
            If Body(i).State = 1 Then
                Pol ((Body(i).X+Map_X)*Map_Scale, (Body(i).Y+Map_Y)*Map_Scale)
                If Rpol <= 127 then Pset(Map_X_Mid+(Body(i).X+Map_X)*Map_Scale, Map_Y_Mid+(Body(i).Y+Map_Y)*Map_Scale), Rgb(192, 32, 32)
            End IF
       Next 
       
       ''   draw projectiles on minimap
       For i = 0 to Ubound(Projectile)
            If Projectile(i).State = 1 Then
                Pol ((Projectile(i).X+Map_X)*Map_Scale, (Projectile(i).Y+Map_Y)*Map_Scale)
                If Rpol <= 127 then Pset(Map_X_Mid+(Projectile(i).X+Map_X)*Map_Scale, Map_Y_Mid+(Projectile(i).Y+Map_Y)*Map_Scale), Rgb(255, 255, 96)
            End If
        Next
        
        ''  draw large bodies on minimap
        For i = 1 To 2
            If Body(i).State = 1 Then
                Pol ((Body(i).X+Map_X)*Map_Scale, (Body(i).Y+Map_Y)*Map_Scale)
                If Rpol <= 127 then circle(Map_X_Mid+(Body(i).X+Map_X)*Map_Scale, Map_Y_Mid+(Body(i).Y+Map_Y)*Map_Scale), 1, Rgb(32, 192, 32),,,1,f
            End iF
        Next 
        
        ''  draw sun on minimap
        Pol ((Body(0).X+Map_X)*Map_Scale, (Body(0).Y+Map_Y)*Map_Scale)
        If Rpol <= 127 then circle(Map_X_Mid+(Body(0).X+Map_X)*Map_Scale, Map_Y_Mid+(Body(0).Y+Map_Y)*Map_Scale), 2, Rgb(42, 255, 42),,,1,f
        
        ''  draw ships on minimap
        For i = 0 to Ubound(Ship)
            If Ship(i).State = 1 Then
                Pol ((Ship(i).X+Map_X)*Map_Scale, (Ship(i).Y+Map_Y)*Map_Scale)
                If Rpol <= 127 then Circle(Map_X_Mid+(Ship(i).X+Map_X)*Map_Scale, Map_Y_Mid+(Ship(i).Y+Map_Y)*Map_Scale), 1, Rgb(24, 144, 24),,,1
            End If
        Next 
        
        For i = 0 to Ubound(Station)
            If Station(i).State = 1 Then
                Pol ((Station(i).X+Map_X)*Map_Scale, (Station(i).Y+Map_Y)*Map_Scale)
                If Rpol <= 127 then Circle(Map_X_Mid+(Station(i).X+Map_X)*Map_Scale, Map_Y_Mid+(Station(i).Y+Map_Y)*Map_Scale), 1, Rgb(24, 144, 24),,,1,f
            End If
        Next
            
        ''  draw minimap foreground
        circle (Map_X_Mid, Map_Y_Mid), 128, Rgb(8, 48, 8),,,1
        
    Else
        
        Mapstate$ ="Minimap: Off"
        
    End If
    
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
        circle (Compass_X_Mid, Compass_Y_Mid), 47, RGB(2, 12, 2),,,1,f
        
        ''  needle pointing towards enemy planet/emerald field/whatever...
        Pol ((Compass_X-Screen_X_Mid)-(Body(1).X-Ship(0).X), (Compass_Y-Screen_Y_Mid)-(Body(1).Y-Ship(0).y))
        Rec (47, Tpol+180)
        line (Compass_X_Mid, Compass_Y_Mid)-(Compass_X_Mid+Xrec, Compass_Y_Mid+Yrec), Rgb(128, 24, 24)
        
        ''  needle pointing towards home planet
        Pol ((Compass_X-Screen_X_Mid)-(Station(0).X-Ship(0).X), (Compass_Y-Screen_Y_Mid)-(Station(0).Y-Ship(0).Y))
        rec (47, Tpol+180)
        line(Compass_X_Mid, Compass_Y_Mid)-(Compass_X_Mid+Xrec, Compass_Y_Mid+Yrec), Rgb(16, 96, 16)
        
        ''  needle pointing towards the sun
        Pol ((Compass_X-Screen_X_Mid)-(Body(0).X-Ship(0).X), (Compass_Y-Screen_Y_Mid)-(Body(0).Y-Ship(0).Y))
        rec (47, Tpol+180)
        line (Compass_X_Mid, Compass_Y_Mid)-(Compass_X_Mid+Xrec, Compass_Y_Mid+Yrec), Rgb(32, 192, 32)
        
        ''  draw compass foreground
        circle (Compass_X_Mid, Compass_Y_Mid), 48, RGB(8, 48, 8),,,1
        circle (Compass_X_Mid, Compass_Y_Mid), 10, RGB(8, 48, 8),,,1,f
        
    Else
        
        Compassstate$ = "Compass: Off"
    
    End If
    
    ''  print fps
    Color Rgb(16, 96, 16)
    Print using " FPS: ###.#"; FPS

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
                Locate 95, 47: Print using "  Scale: 1:#.#"; 1/Map_Scale
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

Loop Until Multikey(1)

end





