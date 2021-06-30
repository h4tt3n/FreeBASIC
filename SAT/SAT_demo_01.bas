''	http://www.freebasic.net/forum/viewtopic.php?t=16038&highlight=sat

''Angle between vectors using the dot product formula
''relsoft 2k8

Const PI As Single= 3.141593


Type vector2d
    x       As Single
    y       As Single
End Type


Function dot(Byval a As vector2d,Byval  b As vector2d) As Single
   Return (a.x*b.x + a.y*b.y )
End Function

Sub normalize (Byref v As vector2d)
    Dim leng As Single
    leng = Sqr(v.x * v.x + v.y * v.y )
    v.x = v.x / leng
    v.y = v.y / leng
End Sub

   
Function get_2dnormal ( Byval x1 As Single, Byval y1 As Single,_
                        Byval x2 As Single, Byval y2 As Single,_
                        Byval s As Integer) As vector2d
   
    Dim normal As vector2d
    If s Then
        normal.x = -(y2-y1)  'negate to get the other normal
        normal.y =  (x2-x1)  'erase negatio here if you want the other
                                    'normal
    Else
        normal.x =  (y2-y1)  'negate to get the other normal
        normal.y = -(x2-x1) 'erase negatio here if you want the other
                                    'normal
    End If
    normalize (normal)
    Return normal
   
End Function

Function midpoint  ( Byval x1 As Single, Byval y1 As Single,_
                     Byval x2 As Single, Byval y2 As Single) As vector2d

        Dim p As vector2d
        p.x = (x2+x1)/2
        p.y = (y1+y2)/2
   
    Return p
   
End Function

Function rad2deg(Byval rad As Single) As Single
    Return rad*180/PI
End Function

Dim pnt1 As vector2d     '1st point of line
Dim pnt2 As vector2d     '2nd point of line

pnt1.x = 200
pnt1.y = 200

pnt2.x = 539
pnt2.y = 400

Dim As vector2d p,d,v

p.x = pnt2.x - pnt1.x
p.y = pnt2.y - pnt1.y
normalize(p)


Screen 18,32,2,0

screenset 1, 0

Do
   
    Dim As Integer x, y, buttons
    GETMOUSE x, y,, buttons
   
    d.x = x
    d.y = y
   
    v.x = d.x - pnt1.x
    v.y = d.y - pnt1.y
   
    Dim dot_projection As Single
   
    dot_projection = dot(v,p)
   
   
       
    Line(0,0)-(639,479),0,bf
   
   
   
    Circle(d.x,d.y),5,rgb(255,255,255)
   
    Circle(pnt1.x,pnt1.y),5,rgb(255,255,255)
    Circle(pnt2.x,pnt2.y),5,rgb(0,255,255)
   
   
    '' vector representation
    '' vector to project
    Line(pnt1.x,pnt1.y)-(d.x,d.y),rgb(255,255,0)
    '' vector from the 2 original points
    Line(pnt1.x,pnt1.y)-(pnt2.x,pnt2.y),rgb(0,255,0)
   
   
    '' draw projection
    Dim nv As vector2d
    Dim n_proj As vector2d
   
   
    nv.x = p.x
    nv.y = p.y
    normalize(nv)
   
    n_proj.x = nv.x*dot_projection
    n_proj.y = nv.y*dot_projection
   
    Line(pnt1.x,pnt1.y)-(pnt1.x + n_proj.x,pnt1.y + n_proj.y),rgb(255,0,0)
    Circle(pnt1.x + n_proj.x,pnt1.y + n_proj.y),5,rgb(0,0,255)
   
    '' draw the perpendicular
    Line(d.x,d.y)-(pnt1.x + n_proj.x,pnt1.y + n_proj.y),rgb(255,0,255),,12345
   
   
   
   
    Dim As Single mags = Sqr(v.x^2 + v.y^2)*Sqr(p.x^2 + p.y^2)
    Locate 1,1
    Print "Interactive dot product"
    Print "relsoft 2k8"
    Print
    Print "angle between the two vectors:";rad2deg(acos(dot_projection/mags))
    Print "length of projection(dot product) of v onto p:";dot_projection
    Print "sign of the dot product:"; Sgn(dot_projection)
   

    screensync
    Sleep 1
    screencopy
   
           
Loop Until inkey<>""


End

 