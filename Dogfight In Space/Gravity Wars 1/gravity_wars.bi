Const Pi = 3.1415926535897932, _ 
toxpi = 2*pi, _
radtodeg = toxpi/360, _
degtorad = 360/toxpi, _
Gravity = 6.673e-11

dim as integer _
i, i2, i3, R, G, B, _
P1, P2 = 1, _
Map_X, Map_Y, _
Map_Val0 = 2, _ 
Map_Val1 = 1, _ 
Map_Val2 = 0, _ 
Map_State = 2, _
Compass_X, _
Compass_Y, _
Compass_Val0 = 1, _
Compass_Val1 = 2, _
Compass_Val2 = 0, _
Compass_State = 1, _
Pause_Val0 = 0, _
Pause_Val1 = 1, _
Pause_State = 0, _
Data_Val0 = 1, _
Data_Val1 = 2, _
Data_Val2 = 0, _
Data_State = 1, _
Payload_Val0 = 0, _
Payload_Val1 = 1, _
Payload_State = 0, _
Pay_Num, _
Shield_Val0 = 0, _
Shield_Val1 = 1, _
Grid_Val0 = 1, _
Grid_Val1 = 0, _
Grid_State = 1, _
Grid_Num, _
Grid_Dist = 667

Dim As Double _ 
MidX, _ 
MidY, _
Distance, _ 
MinDist, _
Gforce, _
Map_Scale, _
Map_Scale_Start, _
Map_Scale_Old, _
Map_Scale_Old2, _
Map_X_Scale, _  '' some variables used to prevent repetitive calculations
Map_Y_Scale, _
Map_Xrec, _
Map_Yrec, _
Wait_Time0, _
Wait_Time1, _
Wait_Time2, _
Wait_Time3, _
Wait_Time4, _
Wait_Time5, _
Wait_Time6, _
Grid_Radius, _
Grid_45, _
Grid_67, _
Grid_22, _
Grid_1, _
Grid_2

Dim as string _
Mapstate, _
Compassstate

dim shared as integer Xrec, Yrec
dim shared as double Tpol, Rpol

''  define function that calculates rectangular coordinates from polar coordinates (in degrees)
function Rec (Byval Rpol as double, Byval Tpol as double) 
    Xrec = cos(Tpol*radtodeg)*Rpol
    Yrec = sin(Tpol*radtodeg)*Rpol
end function 

''  define function that calculates polar coordinates from rectangular coordinates (in degrees)
function Pol (byval Xrec as double, byval Yrec as double) 
    Rpol=sqr(Xrec^2+Yrec^2) 
    Tpol=(atn(Yrec/Xrec))/radtodeg
    if Xrec<0 and Yrec>0 then Tpol = Tpol + 180
    if Xrec<0 and Yrec<=0 then Tpol = Tpol - 180
end function

''  define ellipse subroutine
Sub ellipse (ByVal cX As Single, ByVal cY As Single, ByVal Wid As Single, ByVal Hgt As Single, ByVal angle As Single, byval col as integer) 

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
    DeltaTheta = toxpi / 360
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

''  define subroutine that draws ship
Sub Drawship (Byval Ship_X as Double, Byval Ship_Y as double, Byval Ship_Angle as Double, Byval Ship_Col as integer) 

    dim head as double = 0
    dim tail as double = 180
    dim size as double = 8
    dim oldx as double
    dim oldy as double
    
    Rec (size, tail-Ship_Angle)
    oldx=Xrec: oldy=Yrec
    Rec (2*size, head-Ship_Angle)
    
    Color Ship_Col
    line (Ship_X+oldx, Ship_Y+oldy)-(Ship_X+Xrec, Ship_Y+Yrec)
    Circle (Ship_X+OldX, Ship_Y+OldY), size, Ship_Col,,,,f
    Circle (Ship_X+Xrec, Ship_Y+Yrec), (5/8)*Size, Ship_Col,,,,f
    
End Sub