''      triangular spaceship

option explicit

dim ships as integer =1000

dim Rd (ships) as integer
dim Gr (ships)as integer
dim Bl (ships) as integer
dim i as integer
dim Xmus as integer
dim Ymus as integer
dim knap as integer

dim Xc (ships) as double
dim Yc (ships) as double

dim shared x as double
dim shared y as double
dim shared r as double
dim shared theta as double
dim shared as integer P1, P2 = 1

const PI = 3.14159265358979
const radtodeg = PI/180

function Rek (byval r as double, byval theta as double) 
    x = cos(theta*radtodeg)*r 
    y = sin(theta*radtodeg)*r 
end function 

function Pol (byval x as double, byval y as double) 
    r=sqr(x^2+y^2) 
    theta=(atn(y/x))/radtodeg
    if x<0 and y>0 then theta = theta + 180
    if x<0 and y<=0 then theta = theta - 180
end function

Sub Drawship (Byval X as Double, Byval Y as double, Byval Angle as Double, Byval Col as integer) 
    
    dim tip as double = 0
    dim noz as double = 180
    dim siz as double = 15
    dim oldx as double
    dim oldy as double
    
    color col
    Rek (siz, noz-theta)
    oldx=x: oldy=y
    Rek (siz, tip-theta)
    line (Xc(i)+oldx, Yc(i)+oldy)-(Xc(i)+x, Yc(i)+y)
    Circle (Xc(i)+OldX, Yc(i)+OldY), 8, col,,,,f
    Circle (Xc(i)+X, Yc(i)+Y), 6, col,,,,f
    
End Sub

randomize timer

for i = 0 to ubound(Xc)
    
    Xc(i)= rnd()*1024
    Yc(i)= rnd()*768
    Rd(i)=rnd()*255
    Gr(i)=rnd()*255
    Bl(i)=rnd()*255
    
next
        
screen 20, 32, 2, 1

do
    
    screenset P2, P1
    swap P2, P1
    cls
    
    getmouse Xmus, Ymus,,knap
    
for i = 0 to ubound(Xc)
    
   Pol (-Xc(i)+Xmus, Yc(i)-Ymus)
    
next
    
loop while inkey$=""

end

