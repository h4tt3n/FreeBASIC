''      Grid tester for Gravity-Wars

Const Pi = 3.1415926535897932, _ 
toxpi = 2*pi, _
radtodeg = toxpi/360, _
degtorad = 360/toxpi

Dim as Integer _
i, i2, _
P2, P1, _
screen_x, _
screen_y, _
screen_x_Mid, _
screen_y_Mid, _
Grid_Dist, _
Grid_Num, _
FPS_Counter, _
Page

Dim as Single _
FPS_timer, _
FPS

Type Ellipse
    X as Integer
    Y as Integer
    Wid as Integer
    Hgt as Integer
    Ang as Single
    Col as Integer
    num_lines as Single
End Type

Type Radian
    X1 as Integer
    Y1 as Integer
    X2 as Integer
    Y2 as Integer
End Type

''  define ellipse subroutine
Sub DrawEllipse (ByVal cX As Single, ByVal cY As Single, ByVal Wid As Single, ByVal Hgt As Single, ByVal angle As Single, byval col as integer, num_lines as Single) 

    Dim SinAngle As Single 
    Dim CosAngle As Single 
    Dim Theta As Single 
    Dim DeltaTheta As Single 
    Dim X As Single 
    Dim Y As Single 
    Dim rX As Single
    Dim rY As Single 
    Dim CurrentX As Single 
    Dim CurrentY As Single

    Angle = Angle * radtodeg
    SinAngle = Sin(Angle) 
    CosAngle = Cos(Angle) 
    Theta = 0 
    DeltaTheta = num_lines
    X = Wid * Cos(Theta) 
    Y = Hgt * Sin(Theta) 
    rX = cX + X * CosAngle + Y * SinAngle 
    rY = cY - X * SinAngle + Y * CosAngle 
    CurrentX = rX 
    CurrentY = rY 
    Pset(CurrentX, CurrentY), col
    
    Do While Theta < toxpi 
        Theta = Theta + DeltaTheta 
        X = Wid * Cos(Theta) 
        Y = Hgt * Sin(Theta) 
        rX = cX + X * CosAngle + Y * SinAngle 
        rY = cY - X * SinAngle + Y * CosAngle
        Line -(rX, rY), col
    Loop 
    
End Sub 