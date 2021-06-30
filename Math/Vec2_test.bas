

#Include "vec2.bi"


Dim As Integer wid = 800
Dim As Integer hgt = 600
Dim As Integer top = hgt
Dim As Integer lft = 0
Dim As Integer btm = 0
Dim As Integer rgt = wid

ScreenRes( wid, hgt, 16, 2 )
Window ( lft, top )-( rgt, btm )
View ( lft, top )-( rgt, btm )
ScreenSet( 1, 0 )

Dim As vec2   n = Vec2( 0.0, 100.0 )
Dim As vec2   ncw
Dim As vec2   nccw
Dim As Single a = 0.0
Dim As Single acw
Dim As Single accw
Dim As Single da = 0.001 * 8 * Atn(1.0)
Dim As Vec2   dv = Vec2( Cos(da), Sin(da) )
Dim As Vec2   o = Vec2( 700, 100 )


Do
	
	Cls
	
	Line(o.x, o.y)-(o.x + n.x, o.y + n.y), RGB( 255, 255, 0 )
	Line(o.x, o.y)-(o.x + ncw.x, o.y + ncw.y), RGB( 0, 255, 0 )
	Line(o.x, o.y)-(o.x + nccw.x, o.y + nccw.y), RGB( 255, 0, 0 )
	
	'n = n.rotateCCW( da )
	n = n.rotateCW( dv )
	
	ncw  = n.perpcw()
	nccw = n.perpccw()
	
	Circle(o.x, o.y), 100, rgb( 0, 255, 0 ),,,1
	
	ScreenCopy()
	
	Sleep 10, 1
	
	
Loop Until MultiKey(1)

