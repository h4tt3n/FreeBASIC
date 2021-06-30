Sub Drawship (Byval Ship_X as Double, Byval Ship_Y as double, Byval Ship_Angle as Double, Byval Ship_Col as integer) 

    dim head as double = 0
    dim tail as double = 180
    dim size as double = 12
    dim oldx as double
    dim oldy as double
    
    Rec (size, tail-Ship_Angle)
    oldx=Xrec: oldy=Yrec
    Rec (size, head-Ship_Angle)
    
    Color Ship_Col
    line (Ship_X+oldx, Ship_Y+oldy)-(Ship_X+Xrec, Ship_Y+Yrec)
    Circle (Ship_X+OldX, Ship_Y+OldY), 6, Ship_Col,,,,f
    Circle (Ship_X+Xrec, Ship_Y+Yrec), 5, Ship_Col,,,,f
    
End Sub

Sub Drawship (Byval Ship_X as Double, Byval Ship_Y as double, Byval Ship_Angle as Double, Byval Ship_Col as integer)

    dim head as double = 0
    dim rght as double = 228
    dim tail as double = 180
    dim l3ft as double = 132
    dim size as double = 16
    dim oldx as double
    dim oldy as double
    
    Color Ship_Col
    Rec (size, head-Ship_Angle)
    oldx=Xrec: oldy=Yrec
    Rec (size, rght-Ship_Angle)
    Line(Ship_X+oldx, Ship_Y+oldy)-(Ship_X+Xrec, Ship_Y+Yrec)
    Rec (size*0.48, tail-Ship_Angle)
    Line -(Ship_X+Xrec, Ship_Y+Yrec)
    Rec (size, l3ft-Ship_Angle)
    Line -(Ship_X+Xrec, Ship_Y+Yrec)
    Line -(Ship_X+oldx, Ship_Y+oldy)
    Paint (Ship_X, Ship_Y), Ship_Col
    
End Sub



    '' draw Anti-gravity shock wave
    If AntiG_State = 1 Then
        Shockwave += 30': If Shockwave >= 300 then Shockwave = 0:AntiG_State = 0
        Circle (512, 384), Shockwave, Rgb(128, 128, 255)
    Else Shockwave = 0
End If


''  toggle asteroid deflection using space bar
    If Multikey(83) and Ship(0).Fuel_Mass >= 10 and Ship(0).Shock_State = 0 Then
        Ship(0).Shock_Area += 750
        Ship(0).Fuel_Mass -= 0.5
        Ship(0).Mass -= 0.5
        Wait_Time4 = Timer + 0.5
        Circle (Ship(0).X+MidX, Ship(0).Y+MidY), sqr(Ship(0).Shock_Area/pi), Rgb(48, 48, 72)
    End If
    If Multikey(83) = 0 and Ship(0).Shock_Area > 0 Then
        Ship(0).Shock_State = 1
    End If
    If Wait_Time4 < Timer and Ship(0).Shock_State = 1 then
        Ship(0).Shock_Area = 0
        Ship(0).Shock_State = 0
    End If
    
    
    ''  calculate and draw asteroid deflection
    If Ship(0).Shock_State = 1 Then
        For i = 3 to Ubound(Body)
            Distance = sqr(((Body(i).Y-Ship(0).Y)^2) + ((Body(i).X-Ship(0).X)^2))
            If Distance < Sqr(Ship(0).Shock_Area/Pi) Then
                Body(i).Xvec += ((Body(i).X-Ship(0).X)/Distance)*(20/Body(i).Mass)
                Body(i).Yvec += ((Body(i).Y-Ship(0).Y)/Distance)*(20/Body(i).Mass)
                Ship(0).Xvec += ((Ship(0).X-Body(i).X)/Distance)*(20/Ship(0).Mass)
                Ship(0).Yvec += ((Ship(0).Y-Body(i).Y)/Distance)*(20/Ship(0).Mass)
                Line (Ship(0).X+MidX, Ship(0).Y+MidY)-(Body(i).X+Body(i).XVec+MidX, Body(i).Y+Body(i).YVec+MidY), Rgb(96, 96, 144)
            End If
        Next
    End If
    
    
            ''  toggle shield / shock-wave
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
        
        ''  update shield stuff
        If Ship(0).Shield_State = 1 Then
            Ship(0).Shield_Strength -= 0.01
            Ship(0).Shock_Strength -= 1.75
            If Ship(0).Shield_Strength <= 0 Then 
                Ship(0).Shield_State = 0
                Ship(0).Shield_Strength = 0
            End If
        End If
        If Wait_Time1 < Timer and Ship(0).Shock_State = 1 then
        Ship(0).Shock_Strength = 0
        Ship(0).Shock_State = 0
        End If
    
    
    
        ''  temporary asteroid-asteroid collision detection (Slows down program quite a lot!)
'    for i = 3 to Ubound(Body)
'       For i2 = i+1 to Ubound(Body)
'            Distance = sqr(((Body(i).Y-Body(i2).Y)^2) + ((Body(i).X-Body(i2).X)^2))
'            MinDist = Body(i).Radius+Body(i2).Radius
'            If Distance < MinDist Then
'                Body(i).Xvec += (200*((Body(i).X-Body(i2).X)/Distance))/Body(i).Mass
'                Body(i).Yvec += (200*((Body(i).Y-Body(i2).Y)/Distance))/Body(i).Mass
'                Body(i2).Xvec += (200*((Body(i2).X-Body(i).X)/Distance))/Body(i2).Mass
'                Body(i2).Yvec += (200*((Body(i2).Y-Body(i).Y)/Distance))/Body(i2).Mass
'            End If
'        Next
'    Next
    

    
    
    
    
 
    
    
    
    
            


