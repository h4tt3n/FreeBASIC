    ''**********************************************************************************
    ''**********************************************************************************
    ''   Polygon to Polygon collision detection using the
    ''   SAT (Separating Axis Theorem)
    ''  MTV version:
    ''         Version that calculates the slide vector(MTV)
    ''         Useful for rigid body dynamics
    ''
    ''   Relminator (Richard Eric M. Lope BSN RN)
    ''   http://rel.betterwebber.com
    ''   
    ''  Optimizations not implemented:
    ''  1. If you just wanna check intersections no need to normalize the normals
    ''  2. For regular polys (equiangular and equilateral), you can reduce the
    ''      tests by 1/2 as there are 1/2 edges to check (parallel lines)
    ''      ie: square and rectangles
    ''
    ''   Thanks to:
    ''   Metanetsoftware.com guys for the nice tute
    ''   Codezealot.org (William) for another nice tute
    ''   
    ''   License:
    ''   Use or abuse the code in whatever way you want as long as
    ''   it does not hurt others (people or otherwise)
    ''
    ''**********************************************************************************
    ''**********************************************************************************


    #include "fbgfx.bi"

    const as integer SCR_WID = 640
    const as integer SCR_HEI = 480
    const as integer BPP = 8

    const as integer false = 0
    const as integer true = not false

    const PI as single= 3.141593

    ''redim can't be used on types aaaaaaahhhhh!!!!!
    ''so I need this.
    const MAX_VERTEX = 256   



    ''**********************************************************************************
    ''
    ''   minimalist 2d vector stuff
    ''
    ''**********************************************************************************

    type vector2d
        x       as single
        y       as single
    end type

    operator * (byref lhs as vector2d, byval scale as single) as vector2d
       
       operator = Type(lhs.x * scale, lhs.y * scale)
       
    end operator

    ''**********************************************************************************
    ''
    ''   returns  scalar (projection of a to b)
    ''
    ''**********************************************************************************
    function dot(byval a as vector2d,byval  b as vector2d) as Single
       return (a.x*b.x + a.y*b.y )
    end function

    ''**********************************************************************************
    ''
    ''   makes the vector length = 1
    ''
    ''**********************************************************************************
    sub normalize (byref v as vector2d)
        dim leng as single
        leng = sqr(v.x * v.x + v.y * v.y )
        v.x = v.x / leng
        v.y = v.y / leng
    end sub

    ''**********************************************************************************
    ''
    ''   returns a perpendicular vector(normal) of a line segment
    ''
    ''**********************************************************************************
    function get_2dnormal ( byval x1 as single, byval y1 as single,_
                            byval x2 as single, byval y2 as single,_
                            byval s as integer) as vector2d
       
        dim normal as vector2d
        if s then
            normal.x = -(y2-y1)  'negate to get the other normal
            normal.y =  (x2-x1)  'erase negatio here if you want the other
                                        'normal
        else
            normal.x =  (y2-y1)  'negate to get the other normal
            normal.y = -(x2-x1) 'erase negatio here if you want the other
                                        'normal
        end if
        normalize (normal)
        return normal
       
    end function

    ''**********************************************************************************
    ''
    ''   calculates the midpoint of a line segment
    ''
    ''**********************************************************************************
    function midpoint  ( byval x1 as single, byval y1 as single,_
                         byval x2 as single, byval y2 as single) as vector2d

       dim p as vector2d
       p.x = (x2+x1)/2
       p.y = (y1+y2)/2
       
        return p
       
    end function




    ''**********************************************************************************
    ''
    ''   min, max overlap stuff
    ''
    ''**********************************************************************************

    type Tprojection
       min         as single
       max         as single
    end type

    function get_interval_distance(byref a as Tprojection, byref b as Tprojection) as Single
       
       if (a.min < b.min) then
          return (b.min - a.max)
       else
          return (a.min - b.max)
       end if
       
    end Function


    ''**********************************************************************************
    ''
    ''   polygon
    ''
    ''**********************************************************************************

    type Tpolygon
       
       declare sub create(byval _numverts as integer, byval radius as single)
       declare sub create(v() as vector2d)
       declare sub draw_poly(byval col as integer)
       declare sub move_to(byval _x as single, byval _y as single)
       declare function project(byval axis as vector2d) as Tprojection
       
       numverts         as integer      '' number of vertices
       x               as single      '' center of poly for MTV
       y               as single      '' center of poly for MTV
       verts(MAX_VERTEX)   as vector2d      '' local absolute verts
       verts_2(MAX_VERTEX)   as vector2d      '' screen coordinates fo verts
       normals(MAX_VERTEX)   as vector2d      '' axis to test
       colors(MAX_VERTEX)    as integer      '' funky line colors
       
    end type


    ''**********************************************************************************
    ''
    ''   meat of the SAT algo
    ''  projects each vertex of the poly to
    ''   the axis and gets the min and max 1d values
    ''
    ''**********************************************************************************
    function Tpolygon.project(byval _axis as vector2d) as Tprojection

       dim as Tprojection proj
       dim as single min, max
       dim as single p
       
       '' get initial projection on first vertex
       '' and set min and max values to initial projection value
       p = dot(verts_2(0), _axis)
       min = p
       max = p
       
       '' loop through all the verts of the poly
       '' and find out if new projections of vertex
       '' is the new min or max as we need only the
       '' min and max points to test for 1d intesection
       for i as integer = 1 to numverts-1
       	

          p = dot(verts_2(i), _axis)
          If (p < min) then min = p
          If (p > max) then max = p
       next i

       '' copy and return
       proj.min = min
       proj.max = max
       
       return proj
          
    end function


    ''**********************************************************************************
    ''
    ''   makes a stupid regular(equilateral and equiangular) poly
    ''
    ''**********************************************************************************
    sub Tpolygon.create(byval _numverts as integer, byval radius as single)


       numverts = _numverts
       
       
       '' verts
       for i as integer = 0 to numverts - 1
          dim as single angle = (360/numverts) * i *PI/180
          verts(i).x = cos(angle) * radius
          verts(i).y = sin(angle) * radius
          colors(i) = 1+int(rnd*15)      
       next i

       '' normals
       
       for i as integer = 0 to numverts - 1

          dim as integer j = (i+1) mod numverts
          dim as single x1 = verts(i).x
          dim as single y1 = verts(i).y
          dim as single x2 = verts(j).x
          dim as single y2 = verts(j).y
          normals(i) = get_2dnormal(x1, y1, x2, y2, 0)
           
       next i
       
    end sub


    ''**********************************************************************************
    ''
    ''   makes a poly out of vertices v()
    ''  just make sure that the poly is convex
    ''
    ''**********************************************************************************
    sub Tpolygon.create(v() as vector2d)


       numverts = ubound(v)
       
       
       '' verts
       for i as integer = 0 to numverts - 1
          verts(i) = v(i)
          colors(i) = 1+int(rnd*15)      
       next i

       '' normals
       
       for i as integer = 0 to numverts - 1

          dim as integer j = (i+1) mod numverts
          dim as single x1 = verts(i).x
          dim as single y1 = verts(i).y
          dim as single x2 = verts(j).x
          dim as single y2 = verts(j).y
          normals(i) = get_2dnormal(x1, y1, x2, y2, 0)
           
       next i
       
    end sub

    ''**********************************************************************************
    ''
    ''   renders the poly
    ''
    ''**********************************************************************************
    sub Tpolygon.draw_poly(byval col as integer)
       
       for i as integer = 0 to numverts - 1
          dim as integer j = (i+1) mod numverts
          dim as integer x1 = x + verts(i).x
          dim as integer y1 = y + verts(i).y
          dim as integer x2 = x + verts(j).x
          dim as integer y2 = y + verts(j).y
          line (x1,y1)-(x2,y2),colors(i)
          draw string (x1,y1), str(i)
          
          '' normals
          dim as vector2d mp = midpoint(x1,y1,x2,y2)
          line (mp.x, mp.y)-(mp.x+normals(i).x*20, mp.y+normals(i).y*20), colors(i)
          
       next i
       
    end sub

    ''**********************************************************************************
    ''
    ''   translates the poly
    ''
    ''**********************************************************************************
    sub Tpolygon.move_to(byval _x as single, byval _y as single)
       
       x = _x
       y = _y
       
       for i as integer = 0 to numverts - 1
          verts_2(i).x = x + verts(i).x
          verts_2(i).y = y + verts(i).y
       next i
       
    end sub
       

    ''**********************************************************************************
    ''
    ''   checks whether poly1 and poly2 collides using SAT
    ''  use this if you just need to do simple intersection test
    ''
    ''**********************************************************************************
    function poly_collide(byref p1 as Tpolygon, byref p2 as Tpolygon) as integer
       
       dim as Tprojection proj1, proj2
       dim as vector2d axis
       dim as single d1, d2
       
       '' project all the verts of the poly to each axis (normal)
       '' of the poly we are testing and find out if the projections
       '' overlap (ie: length if proj1 and proj2 are intersecting).
       '' if they are intersecting, there is an axis (line perpendicular
       '' to the axis tested or the "edge" of the poly where the normal connects)
       '' that separates the two polygons so we do an early out from the function.
       
       
       '' polygon1
       for i as integer = 0 to p1.numverts - 1
          
          axis = p1.normals(i)
          proj1 = p1.project(axis)
          proj2 = p2.project(axis)
          d1 = (proj1.min - proj2.max)
           d2 = (proj2.min - proj1.max)
           if ((d1 > 0) or (d2 > 0)) then  '' there's a separatng axis so get out early
               return  false
           end if

       next i
       
       '' polygon2
       for i as integer = 0 to p2.numverts - 1
          
          axis = p2.normals(i)
          proj1 = p1.project(axis)
          proj2 = p2.project(axis)
          d1 = (proj1.min - proj2.max)
           d2 = (proj2.min - proj1.max)
           if ((d1 > 0) or (d2 > 0)) then   '' there's a separatng axis so get out early
               return  false
           end if

       next i
       
       
       '' no separating axis found so p1 and p2 are colliding
       return true
       
    end function


    ''**********************************************************************************
    ''
    ''   checks whether poly1 and poly2 collides using SAT + MTV
    ''  use this if you want real physics
    ''
    ''  velocity is the velocity of polygon 1
    ''  add a simple time value and you have a swept test
    '' 
    ''**********************************************************************************
    function poly_collide_MTV(byref p1 as Tpolygon, byref p2 as Tpolygon, byref mtv as vector2d, byref velocity as vector2d) as integer
       
       dim as Tprojection proj1, proj2
       dim as vector2d axis
       dim as single d1, d2
       dim as single magnitude, overlap
       dim as single interval_distance
       
       '' project all the verts of the poly to each axis (normal)
       '' of the poly we are testing and find out if the projections
       '' overlap (ie: length if proj1 and proj2 are intersecting).
       '' if they are intersecting, there is an axis (line perpendicular
       '' to the axis tested or the "edge" of the poly where the normal connects)
       '' that separates the two polygons so we do an early out from the function.
       
       
       '' polygon1
       
       magnitude = 9999999   '' uber large numbah
       
       
       for i as integer = 0 to p1.numverts - 1
          
          axis = p1.normals(i)            '' get axis to test
          proj1 = p1.project(axis)         '' project vertices
          proj2 = p2.project(axis)
          
           '' get 1-d interval distance
           interval_distance = get_interval_distance(proj1, proj2)
           if (interval_distance > 0) then   '' Since there's no overlap, there's a separating axis so get out early
              return false
           endif
          
           '' project velocity of polygon 1 to axis
           dim as single v_proj = dot(axis, velocity)
          
           '' get the projection of polygon a during movement
          if (v_proj < 0) then      '' left
             proj1.min += v_proj
          else                  '' right
             proj1.max += v_proj
          endif

          '' get new interval distance
          '' ie. (p1 + velocity) vs (non-moving p2)
          interval_distance = get_interval_distance(proj1, proj2)
           
            '' get the absolute value of the overlap
           overlap = abs(interval_distance)
          
           '' overlap is less than last overlap
           '' so get the MTV
           '' MTV = axis
           '' magnitude = minimum overlap
           if (overlap < magnitude) then
              magnitude = overlap
              mtv.x = axis.x
              mtv.y = axis.y
              
              '' vertex to edge and edge to edge check
              '' project distance of p1 to p2 onto axis
              '' if it's on the left, do nothing as
              '' we are using the left-hand normals
              '' negate translation vector if projection is on the right side
              dim as vector2d vd = type(p1.x - p2.x, p1.y - p2.y)
              if ( dot(vd, axis) > 0 ) then
                 mtv.x = -axis.x
                 mtv.y = -axis.y
              endif
           endif
          

       next i
       
       '' polygon2
       for i as integer = 0 to p2.numverts - 1
          
          axis = p2.normals(i)
          proj1 = p1.project(axis)
          proj2 = p2.project(axis)

           '' get 1-d interval distance
           interval_distance = get_interval_distance(proj1, proj2)
           if (interval_distance > 0) then   '' Since there's no overlap, there's a separating axis so get out early
              return false
           endif
          
           '' project velocity of polygon 1 to axis
           dim as single v_proj = dot(axis, velocity)
          
           '' get the projection of polygon a during movement
          if (v_proj < 0) then      '' left
             proj1.min += v_proj
          else                  '' right
             proj1.max += v_proj
          endif

          '' get new interval distance
          '' ie. (p1 + velocity) vs (non-moving p2)
          interval_distance = get_interval_distance(proj1, proj2)
           
            '' get the absolute value of the overlap
           overlap = abs(interval_distance)
          
           '' overlap is less than last overlap
           '' so get the MTV
           '' MTV = axis
           '' magnitude = minimum overlap
           if (overlap < magnitude) then
              magnitude = overlap
              mtv.x = axis.x
              mtv.y = axis.y
              
              '' vertex to edge and edge to edge check
              '' project distance of p1 to p2 onto axis
              '' if it's on the left, do nothing as
              '' we are using the left-hand normals
              '' negate translation vector if projection is on the right side
              dim as vector2d vd = type(p1.x - p2.x, p1.y - p2.y)
              if ( dot(vd, axis) > 0 ) then
                 mtv.x = -axis.x
                 mtv.y = -axis.y
              endif
           endif
          

       next i
       

       '' if we get to this point, the polygons are intersecting so
       '' scale the normalized MTV with the minimum magnitude
       mtv.x *= magnitude
       mtv.y *= magnitude
          
       '' no separating axis found so p1 and p2 are colliding
       return true
       
    end function

    ''**********************************************************************************
    ''
    ''  MAIN
    ''
    ''**********************************************************************************
    randomize timer

    dim as Tpolygon poly1,poly2
    dim as vector2d verts(0 to 6)


    '' set up vertex of poly1

    verts(6) = type(100 ,100)
    verts(5) = type(130 ,-10)
    verts(4) = type(-90 ,-50)
    verts(3) = type(-120,-10)
    verts(2) = type(-130  ,30)
    verts(1) = type(-60  ,120)
    verts(0) = type(90  ,110)

    poly1.create(verts())

    '' create a regular triangle for poly 2
    poly2.create(3, 50)


    poly1.move_to(320,200)

    dim as single speed = 1
    dim as vector2d d



    dim as single px = 100, py = 200
    dim as vector2d mtv


    screenres SCR_WID,SCR_HEI,BPP,2

    screenset 1, 0
    do
       
          d.x = 0
          d.y = 0
       
       mtv.x = 0
       mtv.y = 0
          
          if multikey(fb.SC_LEFT)     then d.x = d.x - speed
        if multikey(fb.SC_RIGHT)    then d.x = d.x + speed
        if multikey(fb.SC_UP)       then d.y = d.y - speed
        if multikey(fb.SC_DOWN)    then d.y = d.y + speed

       
       
       dim as integer c = poly_collide_MTV(poly1, poly2, mtv, d)
       
        if c then   '' correct position with MTV
           px += ( d.x + mtv.x)
          py += ( d.y + mtv.y)   
        else
           px += (d.x)
          py += (d.y)   
        endif
       
        poly2.move_to(px,py)
       
       
       
        screenlock
        Line (0, 0)-(SCR_WID, SCR_HEI), 0, BF
       
        poly1.draw_poly(15)
        poly2.draw_poly(12)
       
       
        locate 1,1
        print "SAT based Collision Detection"
        print "Relminator (Richard Eric M. Lope)"
        print
        print "Use arrow keys to move shape."
        print ""
        print "collision: ";c
        print ""
        locate 10,1
        print "MTV.x = ";
        print using "##.#####";mtv.x
        locate 11,1
        print "MTV.y = ";
        print using "##.#####";mtv.y
       
       
        screenunlock
        sleep 4,1
       
        ScreenCopy
    Loop While not multikey(FB.SC_ESCAPE)

