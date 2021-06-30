''****************************************************************************************
''
''	separating axis theorem collision detection, Mike "h4tt3n", february 2012
''	test # 02, vector projection
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
Declare Function ProjectOnLine(ByVal p0 As vec2f, ByVal p1 As vec2f, ByVal x As vec2f) As vec2f
Declare Function ProjectOnPerpLine(ByVal p0 As vec2f, ByVal p1 As vec2f, ByVal x As vec2f) As vec2f
Declare Function PerpProject(ByVal p0 As vec2f, ByVal p1 As vec2f, ByVal x As vec2f) As float
Declare Function IsPointOnLine(ByVal p0 As vec2f, ByVal p1 As vec2f, ByVal x As vec2f) As float

''	constants
Const As Float 	pi						= 4*Atn(1)			''	pi
Const As Integ 	screenwid			= 800						''	screen width
Const As Integ 	screenhgt			= 600						''	screen height
Const As Integ 	NumPoints			= 4						''	number of control points
Const As Integ 	NumSegments			= 2						''	number of control points
Const As Integ 	border				= 100						''	
Const As Float 	pickdist				= 64						''	mouse pick distance

Type PointType
	As vec2f position
End Type

Type LineSegmentType
	As PointType Ptr point1
	As PointType Ptr point2
	As UByte R
	As UByte G
	As UByte B
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
	.R = 255
	.G = 32
	.B = 255
End With

With s(2)
	.point1 = @p(3)
	.point2 = @p(4)
	.R = 32
	.G = 255
	.B = 255
End With

'With s(3)
'	.point1 = @p(5)
'	.point2 = @p(6)
'	.R = 255
'	.G = 255
'	.B = 64
'End With

''	initiate screen
ScreenRes screenwid, screenhgt, 32,, fb.GFX_ALPHA_PRIMITIVES
WindowTitle "separating axis theorem test # 02"

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
			
	   	Line (s(i).point1->position.x, s(i).point1->position.y)-(s(i).point2->position.x, s(i).point2->position.y), RGBA(s(i).R, s(i).G, s(i).B, 255)
	   	
		Next
		
		''	project line segments onto each other
		For i As Integ = 1 To NumSegments
			
			For j As Integ = 1 To NumSegments
				
				If i = j Then Continue for
			
				Dim As vec2f proj1 = ProjectOnPerpLine(s(i).point1->position, s(i).point2->position, s(j).point1->position)
				Dim As vec2f proj2 = ProjectOnPerpLine(s(i).point1->position, s(i).point2->position, s(j).point2->position)
			
				Line (proj1.x, proj1.y)-(proj2.x, proj2.y), RGBA(s(j).R, s(j).G, s(j).B, 128)
				
				Line (proj1.x, proj1.y)-(s(j).point1->position.x, s(j).point1->position.y), RGBA(255, 255, 255, 64)
				Line (proj2.x, proj2.y)-(s(j).point2->position.x, s(j).point2->position.y), RGBA(255, 255, 255, 64)
				
			Next
			
		Next
			
		'' draw control points
		For i As Integ = 1 To NumPoints
			
			Circle (p(i).position.x, p(i).position.y), 2.5, RGBA(255, 255, 255, 255),,, 1, f
			Draw String (p(i).position.x+8, p(i).position.y+8), "P" + Str(i), RGBA(255, 255, 255, 255)
			
		Next
		
		'' print stuff
		Locate 2, 2: If Not picked = -1 Then Print "Picked: P" & picked Else Print "Picked: None"
		
		Dim As Integer P2on1_1 = Sgn(PerpProject(s(1).point1->position, s(1).point2->position, s(2).point1->position))
		Dim As Integer P2on1_2 = Sgn(PerpProject(s(1).point1->position, s(1).point2->position, s(2).point2->position))
		Dim As Integer P1on2_1 = Sgn(PerpProject(s(2).point1->position, s(2).point2->position, s(1).point1->position))
		Dim As Integer P1on2_2 = Sgn(PerpProject(s(2).point1->position, s(2).point2->position, s(1).point2->position))
		
		Locate 4, 2: If (p2on1_1 = p2on1_2) Or (p1on2_1 = p1on2_2) Then Print "No collision!": Else Print "Collision!"
		
	ScreenUnLock
	
	Sleep 4, 1
	
Loop Until MultiKey(1)

''	functions
Function ProjectOnLine(ByVal p0 As vec2f, ByVal p1 As vec2f, ByVal x As vec2f) As vec2f
	
  'Dim As Vec2f ab = (p1 - p0)
  'Dim As Vec2f ap = (x  - p0)
  'Dim As float t  = ap.dot(ab) / ab.dot(ab)
  'Return p0 + ab * t
	
  Return p0 + (x - p0).project(p1 - p0)
	
End Function

Function ProjectOnPerpLine(ByVal p0 As vec2f, ByVal p1 As vec2f, ByVal x As vec2f) As vec2f
	
  Dim As Vec2f ab = (p1 - p0).normal()
  Dim As Vec2f ap = (x  - p0)
  Dim As float t = ap.dot(ab) / ab.dot(ab)
  Return p0 + t * ab
	
  'Return p0 + (x - p0).project((p1 - p0).normal())
	
End Function

Function IsPointOnLine (ByVal p0 As vec2f, ByVal p1 As vec2f, ByVal x As vec2f) As float
	
	Dim As Vec2f ab = (p1 - p0)
  	Dim As Vec2f ap = (x  - p0)
  	Dim As float t  = ap.dot(ab) / ab.dot(ab)
	
	If (t > 0 And t < 1) Then Return t Else Return 0
	
End Function

Function PerpProject(ByVal p0 As vec2f, ByVal p1 As vec2f, ByVal x As vec2f) As float
	
  'Dim As Vec2f ab = (p1 - p0).normal()  '' possible separating axis
  'Dim As Vec2f ap = (x  - p0)           '' vector to be projected on axis
  'Return ap.dot(ab)
  
  Return (x - p0).dot((p1 - p0).normal())
	
End Function
