Option Explicit

Const Pi = 3.1415926535897932, _ 
toxpi = 2*pi, _
radtodeg = toxpi/360, _
degtorad = 360/toxpi

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

Screen 20, 32, 1, 1

Drawship (512, 384, 42, rgb(128, 128, 128))

Do
    
Loop until Inkey$ <> ""

End