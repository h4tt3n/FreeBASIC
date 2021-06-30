''	http://www.freebasic.net/forum/viewtopic.php?t=16038&highlight=sat

''**********************************************************************************
''**********************************************************************************
''        Polygon to Polygon collision detection using the
''        SAT (Separating Axis Theorem)
''  MTV version:
''         Version that calculates the slide vector(MTV)
''         Useful for rigid body dynamics
''
''        Relminator (Richard Eric M. Lope BSN RN)
''        http://rel.betterwebber.com
''       
''  Optimizations not implemented:
''  1. If you just wanna check intersections no need to normalize the normals
''  2. For regular polys (equiangular and equilateral), you can reduce the
''                tests by 1/2 as there are 1/2 edges to check (parallel lines)
''      ie: square and rectangles
''
''        Thanks to:
''        Metanetsoftware.com guys for the nice tute
''        Codezealot.org (William) for another nice tute
''       
''        License:
''        Use or abuse the code in whatever way you want as long as
''        it does not hurt others (people or otherwise)
''
''**********************************************************************************
''**********************************************************************************


#include "fbgfx.bi"

Const As Integer SCR_WID = 640
Const As Integer SCR_HEI = 480
Const As Integer BPP = 8

Const As Integer false = 0
Const As Integer true = Not false

Const PI As Single= 3.141593

''redim can't be used on types aaaaaaahhhhh!!!!!
''so I need this.
Const MAX_VERTEX = 256   



''**********************************************************************************
''
''        minimalist 2d vector stuff
''
''**********************************************************************************

Type vector2d
    x       As Single
    y       As Single
End Type

Operator * (Byref lhs As vector2d, Byval scale As Single) As vector2d
       
        Operator = Type(lhs.x * scale, lhs.y * scale)
       
End Operator

''**********************************************************************************
''
''        returns  scalar (projection of a to b)
''
''**********************************************************************************
Function dot(Byval a As vector2d,Byval  b As vector2d) As Single
   Return (a.x*b.x + a.y*b.y )
End Function

''**********************************************************************************
''
''        makes the vector length = 1
''
''**********************************************************************************
Sub normalize (Byref v As vector2d)
    Dim leng As Single
    leng = Sqr(v.x * v.x + v.y * v.y )
    v.x = v.x / leng
    v.y = v.y / leng
End Sub

''**********************************************************************************
''
''        returns a perpendicular vector(normal) of a line segment
''
''**********************************************************************************
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

''**********************************************************************************
''
''        calculates the midpoint of a line segment
''
''**********************************************************************************
Function midpoint  ( Byval x1 As Single, Byval y1 As Single,_
                     Byval x2 As Single, Byval y2 As Single) As vector2d

        Dim p As vector2d
        p.x = (x2+x1)/2
        p.y = (y1+y2)/2
   
    Return p
   
End Function




''**********************************************************************************
''
''        min, max overlap stuff
''
''**********************************************************************************

Type Tprojection
        min                        As Single
        max                        As Single
End Type


''**********************************************************************************
''
''        polygon
''
''**********************************************************************************

Type Tpolygon
       
        Declare Sub create(Byval _numverts As Integer, Byval radius As Single)
        Declare Sub create(v() As vector2d)
        Declare Sub draw_poly(Byval col As Integer)
        Declare Sub move_to(Byval _x As Single, Byval _y As Single)
        Declare Function project(Byval axis As vector2d) As Tprojection
       
        numverts                        As Integer                '' number of vertices
        x                                        As Single                '' center of poly for MTV
        y                                        As Single                '' center of poly for MTV
        verts(MAX_VERTEX)        As vector2d                '' local absolute verts
        verts_2(MAX_VERTEX)        As vector2d                '' screen coordinates fo verts
        normals(MAX_VERTEX)        As vector2d                '' axis to test
        colors(MAX_VERTEX)         As Integer                '' funky line colors
       
End Type


''**********************************************************************************
''
''        meat of the SAT algo
''  projects each vertex of the poly to
''        the axis and gets the min and max 1d values
''
''**********************************************************************************
Function Tpolygon.project(Byval _axis As vector2d) As Tprojection

        Dim As Tprojection proj
        Dim As Single min, max
        Dim As Single p
       
        '' get initial projection on first vertex
        '' and set min and max values to initial projection value
        p = dot(verts_2(0), _axis)
        min = p
        max = p
       
        '' loop through all the verts of the poly
        '' and find out if new projections of vertex
        '' is the new min or max as we need only the
        '' min and max points to test for 1d intesection
        For i As Integer = 1 To numverts-1
                p = dot(verts_2(i), _axis)
                If (p < min) Then min = p
                If (p > max) Then max = p
        Next i

        '' copy and return
        proj.min = min
        proj.max = max
       
        Return proj
               
End Function


''**********************************************************************************
''
''        makes a stupid regular(equilateral and equiangular) poly
''
''**********************************************************************************
Sub Tpolygon.create(Byval _numverts As Integer, Byval radius As Single)


        numverts = _numverts
       
       
        '' verts
        For i As Integer = 0 To numverts - 1
                Dim As Single angle = (360/numverts) * i *PI/180
                verts(i).x = Cos(angle) * radius
                verts(i).y = Sin(angle) * radius
                colors(i) = 1+Int(Rnd*15)               
        Next i

        '' normals
       
        For i As Integer = 0 To numverts - 1

                Dim As Integer j = (i+1) Mod numverts
                Dim As Single x1 = verts(i).x
                Dim As Single y1 = verts(i).y
                Dim As Single x2 = verts(j).x
                Dim As Single y2 = verts(j).y
                normals(i) = get_2dnormal(x1, y1, x2, y2, 0)
           
        Next i
       
End Sub


''**********************************************************************************
''
''        makes a poly out of vertices v()
''  just make sure that the poly is convex
''
''**********************************************************************************
Sub Tpolygon.create(v() As vector2d)


        numverts = Ubound(v)
       
       
        '' verts
        For i As Integer = 0 To numverts - 1
                verts(i) = v(i)
                colors(i) = 1+Int(Rnd*15)               
        Next i

        '' normals
       
        For i As Integer = 0 To numverts - 1

                Dim As Integer j = (i+1) Mod numverts
                Dim As Single x1 = verts(i).x
                Dim As Single y1 = verts(i).y
                Dim As Single x2 = verts(j).x
                Dim As Single y2 = verts(j).y
                normals(i) = get_2dnormal(x1, y1, x2, y2, 0)
           
        Next i
       
End Sub

''**********************************************************************************
''
''        renders the poly
''
''**********************************************************************************
Sub Tpolygon.draw_poly(Byval col As Integer)
       
        For i As Integer = 0 To numverts - 1
                Dim As Integer j = (i+1) Mod numverts
                Dim As Integer x1 = x + verts(i).x
                Dim As Integer y1 = y + verts(i).y
                Dim As Integer x2 = x + verts(j).x
                Dim As Integer y2 = y + verts(j).y
                Line (x1,y1)-(x2,y2),colors(i)
                Draw String (x1,y1), Str(i)
               
                '' normals
                Dim As vector2d mp = midpoint(x1,y1,x2,y2)
                Line (mp.x, mp.y)-(mp.x+normals(i).x*20, mp.y+normals(i).y*20), colors(i)
               
        Next i
       
End Sub

''**********************************************************************************
''
''        translates the poly
''
''**********************************************************************************
Sub Tpolygon.move_to(Byval _x As Single, Byval _y As Single)
       
        x = _x
        y = _y
       
        For i As Integer = 0 To numverts - 1
                verts_2(i).x = x + verts(i).x
                verts_2(i).y = y + verts(i).y
        Next i
       
End Sub
       

''**********************************************************************************
''
''        checks whether poly1 and poly2 collides using SAT
''  use this if you just need to do simple intersection test
''
''**********************************************************************************
Function poly_collide(Byref p1 As Tpolygon, Byref p2 As Tpolygon) As Integer
       
        Dim As Tprojection proj1, proj2
        Dim As vector2d axis
        Dim As Single d1, d2
       
        '' project all the verts of the poly to each axis (normal)
        '' of the poly we are testing and find out if the projections
        '' overlap (ie: length if proj1 and proj2 are intersecting).
        '' if they are intersecting, there is an axis (line perpendicular
        '' to the axis tested or the "edge" of the poly where the normal connects)
        '' that separates the two polygons so we do an early out from the function.
       
       
        '' polygon1
        For i As Integer = 0 To p1.numverts - 1
               
                axis = p1.normals(i)
                proj1 = p1.project(axis)
                proj2 = p2.project(axis)
                d1 = (proj1.min - proj2.max)
            d2 = (proj2.min - proj1.max)
            If ((d1 > 0) Or (d2 > 0)) Then  '' there's a separatng axis so get out early
                Return  false
            End If

        Next i
       
        '' polygon2
        For i As Integer = 0 To p2.numverts - 1
               
                axis = p2.normals(i)
                proj1 = p1.project(axis)
                proj2 = p2.project(axis)
                d1 = (proj1.min - proj2.max)
            d2 = (proj2.min - proj1.max)
            If ((d1 > 0) Or (d2 > 0)) Then   '' there's a separatng axis so get out early
                Return  false
            End If

        Next i
       
       
        '' no separating axis found so p1 and p2 are colliding
        Return true
       
End Function


''**********************************************************************************
''
''        checks whether poly1 and poly2 collides using SAT + MTV
''  use this if you want real physics
''
''**********************************************************************************
Function poly_collide_MTV(Byref p1 As Tpolygon, Byref p2 As Tpolygon, Byref mtv As vector2d) As Integer
       
        Dim As Tprojection proj1, proj2
        Dim As vector2d axis
        Dim As Single d1, d2
        Dim As Single magnitude, overlap
       
        '' project all the verts of the poly to each axis (normal)
        '' of the poly we are testing and find out if the projections
        '' overlap (ie: length if proj1 and proj2 are intersecting).
        '' if they are intersecting, there is an axis (line perpendicular
        '' to the axis tested or the "edge" of the poly where the normal connects)
        '' that separates the two polygons so we do an early out from the function.
       
       
        '' polygon1
       
        magnitude = &hFFFFFFFF
       
        For i As Integer = 0 To p1.numverts - 1
               
                axis = p1.normals(i)
                proj1 = p1.project(axis)
                proj2 = p2.project(axis)
                d1 = (proj1.min - proj2.max)
            	d2 = (proj2.min - proj1.max)
            If ((d1 > 0) Or (d2 > 0)) Then  '' there's a separating axis so get out early
                    '' get MTV (Minimum Translation Vector)
                    If(d1 < d2) Then
                            overlap = d1
                    Else
                            overlap = d2
                    Endif
           
                    If (overlap < magnitude) Then
                            magnitude = overlap
                            Dim As vector2d vd = Type(p1.x - p2.x, p1.y - p2.y)
                            If (dot(vd, axis) < 0) Then
                                    mtv = Type(-axis.x, -axis.y)
                            Else
                                    mtv = Type(axis.x, axis.y)
                            Endif
                    End If
                   
                Return  false
            End If

        Next i
       
        '' polygon2
        For i As Integer = 0 To p2.numverts - 1
               
                axis = p2.normals(i)
                proj1 = p1.project(axis)
                proj2 = p2.project(axis)
                d1 = (proj1.min - proj2.max)
            d2 = (proj2.min - proj1.max)
            If ((d1 > 0) Or (d2 > 0)) Then   '' there's a separating axis so get out early
                    '' get MTV (Minimum Translation Vector)
                    If(d1 < d2) Then
                            overlap = d1
                    Else
                            overlap = d2
                    Endif
           
                    If (overlap < magnitude) Then
                            magnitude = overlap
                            Dim As vector2d vd= Type(p1.x - p2.x, p1.y - p2.y)
                            If (dot(vd, axis) < 0) Then
                                    mtv = Type(-axis.x, -axis.y)
                            Else
                                    mtv = Type(axis.x, axis.y)
                            Endif
                    End If

                Return  false
            End If

        Next i
       
       
        '' no separating axis found so p1 and p2 are colliding
        Return true
       
End Function

''**********************************************************************************
''
''  MAIN
''
''**********************************************************************************
Randomize Timer

Dim As Tpolygon poly1,poly2
Dim As vector2d verts(0 To 6)


'' set up vertex of poly1

verts(6) = Type(100 ,100)
verts(5) = Type(130 ,-10)
verts(4) = Type(-90 ,-50)
verts(3) = Type(-120,-10)
verts(2) = Type(-130  ,30)
verts(1) = Type(-60  ,120)
verts(0) = Type(90  ,110)

poly1.create(verts())

'' create a regular triangle for poly 2
poly2.create(3, 50)


poly1.move_to(320,200)

Dim As Single speed = 1
Dim As vector2d d



Dim As Single px = 100, py = 200
Dim As vector2d mtv

screenres SCR_WID,SCR_HEI,BPP,2

screenset 1, 0
Do
   
           d.x = 0
           d.y = 0
       
       
          
           If multikey(fb.SC_LEFT)          Then d.x = d.x - speed
    If multikey(fb.SC_RIGHT)         Then d.x = d.x + speed
    If multikey(fb.SC_UP)                 Then d.y = d.y - speed
    If multikey(fb.SC_DOWN)         Then d.y = d.y + speed
 
        
        
         Dim As Integer c = poly_collide_MTV(poly1, poly2, mtv)
   
    If c Then        '' correct position with MTV
            '' should be...
            '' px += (d.x - mtv.x)
            '' py += (d.y - mtv.y)
            '' but I'm lazy to make a proper
            '' vector-based movement
           
            px += (-mtv.x)
            py += (-mtv.y)
    Else
            px += (d.x)
                 py += (d.y)       
    Endif
   
    poly2.move_to(px,py)
   
   
   
    screenlock
    Line (0, 0)-(SCR_WID, SCR_HEI), 0, BF
   
    poly1.draw_poly(15)
    poly2.draw_poly(12)
   
   
    Locate 1,1
    Print "SAT based Collision Detection"
    Print "Relminator (Richard Eric M. Lope)"
    Print
    Print "Use arrow keys to move shape."
    Print ""
    Print "collision: ";c
    Print ""
    Locate 10,1
    Print "MTV.x = ";
    Print Using "##.#####";mtv.x
    Locate 11,1
    Print "MTV.y = ";
    Print Using "##.#####";mtv.y
   
   
    screenunlock
    Sleep 4,1
   
    ScreenCopy
Loop While Not multikey(FB.SC_ESCAPE)

 