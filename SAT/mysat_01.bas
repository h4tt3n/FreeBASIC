''****************************************************************************************
''
''	separating axis theorem collision detection, Mike "h4tt3n", february 2012
''	test # 01, vector projection
''
''	pick up control points and move them around with the mouse
''	press "esc" to quit
''	
''	Reference:
''	http://www.geometrictools.com/Documentation/MethodOfSeparatingAxes.pdf
''	http://www.metanetsoftware.com/technique/tutorialA.html
''	http://content.gpwiki.org/index.php/VB:Tutorials:Building_A_Physics_Engine:Basic_Intersection_Detection
''	http://www.sevenson.com.au/actionscript/sat/
''	http://www.codeproject.com/Articles/15573/2D-Polygon-Collision-Detection
''
''****************************************************************************************

''	includes
#Include "fbgfx.bi"
#Include "vec2_07.bi"

''	function declarations
Declare Function ClosestPointOnLine(ByVal p0 As vec2f, ByVal p1 As vec2f, ByVal x As vec2f) As vec2f
Declare Function ClosestPointOnPerpLine(ByVal p0 As vec2f, ByVal p1 As vec2f, ByVal x As vec2f) As vec2f
Declare Function IsPointOnLine(ByVal p0 As vec2f, ByVal p1 As vec2f, ByVal x As vec2f) As float

''	constants
Const As Float 	pi						= 4*Atn(1)			''	pi
Const As Integ 	screenwid			= 600						''	screen width
Const As Integ 	screenhgt			= 600						''	screen height
Const As Integ 	NumPoints			= 4						''	number of control points
Const As Integ 	NumSegments			= 2						''	number of control points
Const As Integ 	border				= 150						''	
Const As Float 	pickdist				= 64						''	mouse pick distance

Type PointType
	As vec2f position
End Type

Type LineSegmentType
	As PointType Ptr point1
	As PointType Ptr point2
End Type

''	dim variables
Dim As vec2i 	m, mo
Dim As Integ 	mb, mbo, picked

Dim As PointType p(1 To NumPoints)
Dim As LineSegmentType s(1 To NumSegments)

Randomize()

'' place control points
For i As Integ = 1 To NumPoints
	P(i).position.x = border + Rnd * (screenwid - 2 * border)
	P(i).position.y = border + Rnd * (screenHgt - 2 * border)
Next

With s(1)
	.point1 = @p(1)
	.point2 = @p(2)
End With

With s(2)
	.point1 = @p(3)
	.point2 = @p(4)
End With


''	initiate screen
ScreenRes screenwid, screenhgt, 32,, fb.GFX_ALPHA_PRIMITIVES
WindowTitle "separating axis theorem test # 01"

''	main loop
Do
	
	'' update mouse state
	mo = m:	mbo = mb: GetMouse m.x, m.y,, mb
	
	'' on left mouse, pick up nearest control point
	If mb = 1 Then
		If Picked = -1 Then
			Dim As Float tempdist = pickdist*pickdist
			For i As Integ = 1 To NumPoints
				Dim As Float dx 		= m.x-p(i).position.x	:	If Abs(dx) > pickdist Then Continue For
				Dim As Float dy 		= m.y-p(i).position.y	:	If Abs(dy) > pickdist Then Continue For
				Dim As Float dsqrd   = dx*dx+dy*dy				:  If dsqrd   > tempdist Then Continue For
				tempdist = dsqrd
				picked = i
			Next
		End If
	Else
		picked = -1
	End If
	
	'' move picked-up control point
	If Not picked = -1 Then
		p(picked).position += (m - mo)
	EndIf
	
	'' draw to screen
	ScreenLock
		
		Cls
		
		'' draw line segments
		For i As Integ = 1 To NumSegments
	   	Line (s(i).point1->position.x, s(i).point1->position.y)-(s(i).point2->position.x, s(i).point2->position.y), RGBA(255, 255, 255, 255)
		Next
		
		''	draw projections
		Dim As vec2f proj1on2a = ClosestPointOnPerpLine(s(1).point1->position, s(1).point2->position, s(2).point1->position)
		Dim As vec2f proj1on2b = ClosestPointOnPerpLine(s(1).point1->position, s(1).point2->position, s(2).point2->position)
		
		''
		Dim As vec2f proj2on1a = ClosestPointOnPerpLine(s(2).point1->position, s(2).point2->position, s(1).point1->position)
		Dim As vec2f proj2on1b = ClosestPointOnPerpLine(s(2).point1->position, s(2).point2->position, s(1).point2->position)
		
		''
		Line (proj1on2a.x, proj1on2a.y)-(proj1on2b.x, proj1on2b.y), RGBA(255, 30, 255, 192)
		Line (proj2on1a.x, proj2on1a.y)-(proj2on1b.x, proj2on1b.y), RGBA(0, 255, 0, 192)
		
		''
		Line (proj1on2a.x, proj1on2a.y)-(s(2).point1->position.x, s(2).point1->position.y), RGBA(255, 255, 255, 32)
		Line (proj1on2b.x, proj1on2b.y)-(s(2).point2->position.x, s(2).point2->position.y), RGBA(255, 255, 255, 32)
		
		''
		Line (proj2on1a.x, proj2on1a.y)-(s(1).point1->position.x, s(1).point1->position.y), RGBA(255, 255, 255, 32)
		Line (proj2on1b.x, proj2on1b.y)-(s(1).point2->position.x, s(1).point2->position.y), RGBA(255, 255, 255, 32)

			
		'' draw control points
		For i As Integ = 1 To NumPoints
			
			Circle (p(i).position.x, p(i).position.y), 2.5, RGBA(255, 255, 255, 255),,, 1, f
			Draw String (p(i).position.x+8, p(i).position.y+8), "P" + Str(i), RGBA(255, 255, 255, 255)
			
		Next
		
		'' print stuff
		Locate 2, 2: If Not picked = -1 Then Print "Picked: P" & picked Else Print "Picked: None"
		
	ScreenUnLock
	
	Sleep 12, 1
	
Loop Until MultiKey(1)

''	functions
Function ClosestPointOnLine(ByVal p0 As vec2f, ByVal p1 As vec2f, ByVal x As vec2f) As vec2f
	
  Dim As Vec2f ab = (p1 - p0)
  Dim As Vec2f ap = ( x - p0)
  Dim As float t = ap.dot(ab) / ab.dot(ab)
  Return p0 + ab * t
	
  'Return p0+(x-p0).project(p1-p0)
	
End Function

Function ClosestPointOnPerpLine(ByVal p0 As vec2f, ByVal p1 As vec2f, ByVal x As vec2f) As vec2f
	
  'Dim As Vec2f ab = (p1 - p0).normal()
  'Dim As Vec2f ap = ( x - p0)
  'Dim As float t = ap.dot(ab) / ab.dot(ab)
  'Return p0 + ab * t
	
  Return p0+(x-p0).project((p1-p0).normal())
	
End Function

Function IsPointOnLine(ByVal p0 As vec2f, ByVal p1 As vec2f, ByVal x As vec2f) As float
	
	Dim As Vec2f ab = (p1-p0)
  	Dim As Vec2f ap = (x-p0)
  	Dim As float t  = ap.dot(ab) / ab.dot(ab)
	
	If (t > 0 And t < 1) Then Return t Else Return 0
	
End Function
