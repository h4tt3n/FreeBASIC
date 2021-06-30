''****************************************************************************************
''
''	separating axis theorem collision detection, Mike "h4tt3n", february 2012
''	test # 02, rectangle collision detection
''
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

''	
#Include Once "vec2_07.bi"
#Include Once "fbgfx.bi"

''	
Const As float 	pi        							= 4*Atn(1)										''	pi
Const As Integ 	Numboxes			 					= 200												''	number of rigid bodies
Const As float 	g_acc     							= 00												''	gravitational acceleration
Const As float 	rest_fps      					= 60     						''  ideal framerate
Const As Double 	timestep        				= 1/rest_fps 									''  timestep per program loop
Const As Double 	dt            					= timestep
Const As float 	pickdist								= 64													''	

''
Type VertexType
  As vec2f Init_Psn, Psn
End Type

Type BoxType
  As integ Num_vertices
  As UInteger col
  As vec2f frc, acc, vel, Psn, Ang
  As Float angle, Mass, InverseMass, Trq, Ang_Vel, Ang_Acc
  As Float Hgt, Wid, I, InverseI, Stiffnes, Damping, DynamicFriction, StaticFriction
  As VertexType Ptr vertex
End Type

''	
Dim Shared As BoxType Ptr box
Dim Shared As Integ FPS, FPS_Counter
Dim Shared As double FPS_Timer, t0, Sleep_Time
Dim Shared As vec2i m, mo
Dim Shared As Integ mb, mbo, picked, pickedtype, scrn_wid, scrn_hgt

Declare Sub Mouse()
Declare Sub Integrate()
Declare Sub Render()
Declare Sub Pause()

Declare Function ClosestPointOnLine(ByVal p0 As vec2f, ByVal p1 As vec2f, ByVal x As vec2f) As vec2f

Declare Function ProjectVertexOnAxis(ByVal vertex As vec2f, ByVal axis As vec2f) As float

Declare Function BoxCollision(ByRef A As BoxType, ByRef B As BoxType) As Integer
Declare Function ProjectionsSeparated(ByVal minA As float, ByVal maxA As float, ByVal minB As float, ByVal maxB As float) As float

Declare Function mouseInBox(ByVal M As vec2i, ByVal B As BoxTYpe) As Integer
''	
box = Callocate(Numboxes*SizeOf(BoxType))

''  set startup condition
ScreenInfo scrn_wid, scrn_hgt
ScreenRes  scrn_wid, scrn_hgt, 32,, fb.GFX_ALPHA_PRIMITIVES Or fb.GFX_FULLSCREEN
WindowTitle "Rigid body dynamics with SAT collision # 09"
Color RGB(0, 0, 0), RGB(192, 192, 255)

Randomize timer

For A As integ = 0 To Numboxes-1
	
  With box[A]
  	.col = RGB(0, 0, 0)
	.Num_vertices = 4
	.Hgt = 16' + Rnd * 16
	.Wid = 32' + Rnd * 64
	.Mass = .Hgt*.Wid
	.InverseMass = 1/.Mass
	.I = (.Mass*(.Hgt*.Hgt + .Wid*.Wid)) / 12
	.InverseI = 1/.I
	
	.ang_vel = (Rnd-Rnd) * 2
	
	.psn.x = 50 + Rnd * (scrn_wid - 100)
	.psn.y = 50 + Rnd * (scrn_hgt - 100)
	
	.Angle = Rnd*2*pi
	.Ang = vec2f(Cos(.angle), Sin(.angle)) 
	
	.vertex = Callocate(.Num_vertices*SizeOf(VertexType))
	
	.vertex[0].init_psn = vec2f(-0.5*.wid, -0.5*.hgt)
	.vertex[1].init_psn = vec2f( 0.5*.wid, -0.5*.hgt)
	.vertex[2].init_psn = vec2f( 0.5*.wid,  0.5*.hgt)
	.vertex[3].init_psn = vec2f(-0.5*.wid,  0.5*.hgt)
	
	For B As integ = 0 To .Num_Vertices-1
	.Vertex[B].Psn = vec2f(.Ang.dot(.Vertex[B].init_psn), .Ang.perpdot(.Vertex[B].init_psn))
	Next
    
  End With
  
Next

t0 = Timer

Do
	
	Render()
	
	Pause()
	
	For i2 As Integ = 0 To NumBoxes-2
		For i3 As Integ = i2+1 To NumBoxes-1
			BoxCollision(Box[i2], Box[i3])
		next
	Next
	
	
	Mouse()
	
	'Integrate()
  
Loop Until MultiKey(1)

For A As integ = 0 To Numboxes-1
  With box[A]
		DeAllocate(.vertex)
  End With
Next

DeAllocate(box)

End

''----------------------------------------------------------------------------''

Sub Mouse()
	
	'' update mouse state
	mo = m:	mbo = mb: GetMouse m.x, m.y,, mb
	
	If mb = 1 Then
		If Picked = -1 Then
			Dim As Float tempdist = pickdist*pickdist
			For i As Integ = 0 To Numboxes-1
				Dim As Float dx 		= m.x-box[i].Psn.x	:	If Abs(dx) > pickdist Then Continue For
				Dim As Float dy 		= m.y-box[i].Psn.y	:	If Abs(dy) > pickdist Then Continue For
				Dim As Float dsqrd = dx*dx+dy*dy	: If dsqrd 	> tempdist Then Continue For
				tempdist = dsqrd
				picked = i
				pickedtype = 2
			Next
		End If
	Else
		picked = -1
		pickedtype = -1
	End If
	
	'' move picked-up control point
	If picked <> -1 And pickedtype = 2 Then
		With box[picked]
			.psn += (m - mo)
			.vel.x = (m.x - mo.x)/dt
			.vel.y = (m.y - mo.y)/dt
			.vel = vec2f(0, 0)
			.frc = vec2f(0, 0)
			'.ang_vel = 0
			'.trq = 0
		End With
	EndIf
	
End Sub

Sub Integrate()
  
  For A As integ = 0 To NumBoxes-1
    With box[A]
      
			''	linear
    	.Acc = .Frc*.InverseMass' + vec2f(0, g_acc)
    	
      .vel += .acc*dt
      .Psn += .vel*dt
      
      ''	angular
			.Ang_Acc = .Trq*.InverseI
      .ang_vel += .Ang_Acc*dt
      .Angle += .ang_vel*dt
      
    	.Ang = vec2f(Cos(.angle), Sin(.angle))
      
      For B As integ = 0 To .Num_Vertices-1
      	.Vertex[B].Psn = vec2f(.ang.dot(.Vertex[B].init_psn), .ang.perpdot(.Vertex[B].init_psn))
      Next
      
      ''reset force and torque
      .frc = vec2f(0, 0)
    	.Trq = 0
    	
    	.vel += vec2f(0, g_acc) * dt
    	
    End With
  Next
  
End Sub

Sub Render()
  
  ScreenLock
  
    Cls
    
    For A As integ = 0 To NumBoxes-1
    	With box[A]
    		
    		For B As integ = 0 To .Num_Vertices-1
    			
    			Dim As integ C = (B+1) Mod .Num_Vertices
    			
    			Dim As vec2f pnt1 = .psn + .vertex[B].psn
    			Dim As vec2f pnt2 = .psn + .vertex[C].psn
    			
    			Line(pnt1.x, pnt1.y)-(pnt2.x, pnt2.y), .Col
    			
    			'Draw String (.psn.x, .psn.y), Str(A), RGB(255, 255, 255)
    			
    		Next
    		
    		.col = RGB(0, 0, 0)
    		
    	End With
    Next
    
    Locate 2, (scrn_wid\8)-4: Print Using "###"; fps
    Locate 3, (scrn_wid\8)-4: Print Using "###"; Sleep_Time
    
  ScreenUnLock
  
End Sub

Sub Pause()
  
  If Timer < fps_timer Then
    fps_counter += 1
  Else
    fps = fps_counter
    fps_counter = 1
    fps_timer = Timer+1
  End If
 	
	Sleep_Time = ((timestep-(Timer-t0))*1000) - 1
  
	If Sleep_Time < 0    Then Sleep_Time = 0
	If Sleep_Time > 1000 Then Sleep_Time = 1000
  
	Sleep Sleep_Time, 1
	
	Do While timestep > (Timer-t0): Loop
	
	t0 = Timer
  
End Sub

''	functions
Function mouseInBox(ByVal M As vec2i, ByVal B As BoxType) As Integer
	Return 0
End Function

Function ClosestPointOnLine(ByVal p0 As vec2f, ByVal p1 As vec2f, ByVal x As vec2f) As vec2f
	
  ''
  
  Dim As Vec2f ab = (p1 - p0)
  Dim As Vec2f ap = (x  - p0)
  Dim As float t = ap.dot(ab) / ab.dot(ab)
  Return p0 + t * ab
	
  'Return p0 + (x - p0).project((p1 - p0))
	
End Function

Function ProjectVertexOnAxis(ByVal vertex As vec2f, ByVal axis As vec2f) As float
	
	Return vertex.dot(axis.normal())
	
End Function

Function ProjectionsSeparated(ByVal minA As float, ByVal maxA As float, ByVal minB As float, ByVal maxB As float) As float 
	
	return (minA > maxB) Or (minB > maxA)
	
End Function

Function BoxCollision(ByRef A As BoxType, ByRef B As BoxType) As Integer
	
	Dim As float minA, maxA, minB, maxB
	
	'' box A
	For i As Integer = 0 To 1'A.Num_vertices-1
		
		Dim As Integer j = (i+1)' Mod A.Num_vertices
		
		Dim As vec2f axis = (A.vertex[j].psn - A.vertex[i].psn).normal
		
		MinA = (A.Psn + A.vertex[0].psn).dot(axis)
		MaxA = MinA
		
		''	project box A on axis - get min max values
		For k As Integer = 1 To A.Num_vertices-1
			
			Dim As float projection = (A.Psn + A.vertex[k].psn).dot(axis)

			If maxA < projection Then maxA = projection
			If minA > projection Then minA = projection
			
		Next
		
		MinB = (B.Psn + B.vertex[0].psn).dot(axis)
		MaxB = MinB
		
		''	project box B on axis - get min max values
		For k As Integer = 1 To B.Num_vertices-1
			
			Dim As float projection = (B.Psn + B.vertex[k].psn).dot(axis)
			
			If maxB < projection Then maxB = projection
			If minB > projection Then minB = projection
			
		Next
		
		If (minA > maxB) Or (minB > maxA) Then Return 0
		
	Next
	
	'' box B
	For i As Integer = 0 To 1'B.Num_vertices-1
		
		Dim As Integer j = (i+1)' Mod B.Num_vertices
		
		Dim As vec2f axis = (B.vertex[j].psn - B.vertex[i].psn).normal
		
		MinA = (A.Psn + A.vertex[0].psn).dot(axis)
		MaxA = MinA
		
		''	project box A on axis - get min max values
		For k As Integer = 1 To A.Num_vertices-1
			
			Dim As float projection = (A.Psn + A.vertex[k].psn).dot(axis)
	
			If maxA < projection Then maxA = projection
			If minA > projection Then minA = projection
			
		Next
		
		MinB = (B.Psn + B.vertex[0].psn).dot(axis)
		MaxB = MinB
		
		''	project box B on axis - get min max values
		For k As Integer = 1 To B.Num_vertices-1
			
			Dim As float projection = (B.Psn + B.vertex[k].psn).dot(axis)
			
			If maxB < projection Then maxB = projection
			If minB > projection Then minB = projection
			
		Next
		
		If (minA > maxB) Or (minB > maxA) Then Return 0
		
	Next
	
	A.col = RGB(255, 0, 0)
	B.col = RGB(255, 0, 0)
	
	Return -1
	
End Function
