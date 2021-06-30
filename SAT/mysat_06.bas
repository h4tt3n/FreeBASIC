''****************************************************************************************
''
''	separating axis theorem collision detection, Mike "h4tt3n", february 2012
''	test # 06, rectangle collision detection
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
Const As float 	pi        				= 4*Atn(1)										''	pi
Const As Integ 	NumIterations			= 1													''	number of physics iterations
Const As Integ 	Numboxes			 		= 2												''	number of rigid bodies
Const As Integ 	NumBalls			 		= 0												''	number of rigid bodies
Const As float 	g_acc     				= 00												''	gravitational acceleration
Const As Integ 	scrn_wid  				= 900													''	screen width
Const As Integ 	scrn_hgt  				= 600													''	screen height
Const As float 	rest_fps      			= 60     						''  ideal framerate
Const As float 	timestep        		= 1/rest_fps 									''  timestep per program loop
Const As float 	dt            			= timestep/NumIterations			''  timestep per physics iteration
Const As float 	inv_dt            	= 1/dt												''  inverse timestep 
Const As float 	inv_dt2     			= inv_dt*inv_dt   						''  inverse timestep squared
Const As float 	pickdist					= 128													''	

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

Type BallType
	As UInteger col
	As vec2f frc, acc, vel, Psn, Ang
	As Float angle, Mass, InverseMass, Trq, Ang_Vel, Ang_Acc
	As Float Radius, I, InverseI, Stiffnes, Damping, DynamicFriction, StaticFriction
End Type

''	
Dim Shared As BoxType Ptr box
Dim Shared As BallType Ptr Ball
Dim Shared As Integ FPS, FPS_Counter
Dim Shared As Float FPS_Timer, t0, Sleep_Time
Dim Shared As vec2i m, mo
Dim Shared As Integ mb, mbo, picked, pickedtype

Declare Sub Mouse()
Declare Sub Integrate()
Declare Sub Render()
Declare Sub Pause()

Declare Function BoxBoxSAT(ByRef BoxA As BoxType, ByRef BoxB As BoxType) As Integer
Declare Function BoxBallSAT(ByRef Box As BoxType, ByRef Ball As BallType) As Integer
Declare Function BoxPointSAT(ByRef B As BoxType, ByRef P As Vec2f) As Integer

Declare Sub ComputeMinMax OVERLOAD(ByRef Box As BoxType, ByVal Axis As vec2f, ByRef Min As float, ByRef max As float)
Declare Sub ComputeMinMax(ByRef Box As BoxType, ByVal A0 As vec2f, ByVal A1 As vec2f, ByRef Min As float, ByRef Max As float)
Declare Sub SATBoxInterval(ByRef Box As BoxType, ByVal Axis As vec2f, ByRef Min As float, ByRef Max As float)
Declare Function ClosestPointOnLine(ByVal p0 As vec2f, ByVal p1 As vec2f, ByVal x As vec2f) As vec2f

''	
box  = Callocate(Numboxes*SizeOf(BoxType))
ball = Callocate(Numballs*SizeOf(BallType))

''  set startup condition

Randomize timer

For A As integ = 0 To Numboxes-1
	
  With box[A]
	.Num_vertices = 4
	.col = RGB(64+Rnd*192, 64+Rnd*192, 64+Rnd*192)
	.Hgt = 32 + Rnd*32
	.Wid = 128 + Rnd*128
	.Mass = .Hgt*.Wid
	.InverseMass = 1/.Mass
	.I = (.Mass*(.Hgt*.Hgt + .Wid*.Wid)) / 12
	.InverseI = 1/.I
	
	.ang_vel = (Rnd-Rnd) * 0.5
	
	.psn.x = 100 + Rnd * (scrn_wid - 200)
	.psn.y = 100 + Rnd * (scrn_hgt - 200)
	
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

For A As integ = 0 To NumBalls-1
	
	With Ball[A]
		
		.Radius = 64
		.Mass = .Radius
		.InverseMass = 1/.Mass
		
		.psn.x = 100 + Rnd * (scrn_wid - 200)
		.psn.y = 100 + Rnd * (scrn_hgt - 200)
		
		.Angle = Rnd*2*pi
		.Ang = vec2f(Cos(.angle), Sin(.angle)) 
		
	End With
	
Next



''----------------------------------------------------------------------------''

ScreenRes scrn_wid, scrn_hgt, 32,, fb.GFX_ALPHA_PRIMITIVES
WindowTitle "Rigid body dynamics with SAT collision # 01"
Color RGB(0, 0, 0), RGB(192, 192, 244)

t0 = Timer

Do
	
  Render()
  
  Pause()
  
  For i As Integ = 1 To NumIterations
	  
	 'For i2 As Integ = 0 To NumBoxes-2
	 '	For i3 As Integ = i2+1 To NumBoxes-1
	 ' 		BoxBoxSAT(Box[i2], Box[i3])
		  'next
	 'Next
	 ' 
	  Mouse()
	  
	  Integrate()
	  
  Next
  
Loop Until MultiKey(1)

For A As integ = 0 To Numboxes-1
  With box[A]
		DeAllocate(.vertex)
  End With
Next

DeAllocate(box)
DeAllocate(ball)

End

''----------------------------------------------------------------------------''


Sub Mouse()
	
	'' update mouse state
	mo = m:	mbo = mb: GetMouse m.x, m.y,, mb
	
	If mb = 1 Then
		If Picked = -1 Then
			Dim As Float tempdist = pickdist*pickdist
			For i As Integ = 0 To Numballs-1
				Dim As Float dx 		= m.x-ball[i].Psn.x	:	If Abs(dx) > pickdist Then Continue For
				Dim As Float dy 		= m.y-ball[i].Psn.y	:	If Abs(dy) > pickdist Then Continue For
				Dim As Float dsqrd = dx*dx+dy*dy	: If dsqrd 	> tempdist Then Continue For
				tempdist = dsqrd
				picked = i
				pickedtype = 1
			Next
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
	If picked <> -1 And pickedtype = 1 Then
		With ball[picked]
			.psn += (m - mo)
			.vel.x = (m.x - mo.x)/dt
			.vel.y = (m.y - mo.y)/dt
			.vel = vec2f(0, 0)
			.frc = vec2f(0, 0)
			'.ang_vel = 0
			'.trq = 0
		End With
	EndIf
	
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
    		
    		'Draw String (.psn.x, .psn.y), Str(A)', RGB(255, 255, 255)
    		
    		For B As integ = 0 To .Num_Vertices-1
    			
    			Dim As integ C = (B+1) Mod .Num_Vertices
    			
    			Dim As vec2f pnt1 = .psn + .vertex[B].psn
    			Dim As vec2f pnt2 = .psn + .vertex[C].psn
    			
    			Line(pnt1.x, pnt1.y)-(pnt2.x, pnt2.y), RGB(0, 0, 0)
    			
    			'Draw String (pnt1.x, pnt1.y), Str(B)
    			
    		Next
    		
    	End With
    Next
    
   For A As integ = 0 To NumBalls-1
		
		With Ball[A]
			
			Circle(.psn.x, .psn.y), .radius,,,, 1
			
		End With
		
   Next
    
    Locate 2, (scrn_wid\8)-4: Print Using "###"; fps
    Locate 3, (scrn_wid\8)-4: Print Using "###"; Sleep_Time
    
    Dim As Integer collide = BoxBoxSAT(Box[0], Box[1])
    'Dim As Integer collide = BoxBallSAT(Box[0], Ball[0])
    
    Locate 2, 2: If collide = 0 Then Print "no collision" Else If collide = -1 Then Print "Collision!"
	
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
  
	If Sleep_Time < 0 Then Sleep_Time = 0
	If Sleep_Time > 1000 Then Sleep_Time = 1000
  
	Sleep Sleep_Time, 1
	
	Do While timestep > (Timer-t0): Loop
	
	t0 = Timer
  
End Sub

''	functions
Function ClosestPointOnLine(ByVal p0 As vec2f, ByVal p1 As vec2f, ByVal x As vec2f) As vec2f
	
  Dim As Vec2f ab = (p1 - p0)
  Dim As Vec2f ap = (x  - p0)
  Dim As float t = ap.dot(ab) / ab.dot(ab)
  Return p0 + t * ab
	
  'Return p0 + (x - p0).project((p1 - p0))
	
End Function

Sub ComputeMinMax(ByRef Box As BoxType, ByVal A0 As vec2f, ByVal A1 As vec2f, ByRef Min As float, ByRef Max As float)
	
	Dim As vec2f A = (A1 - A0).normal 							'' axis
	Dim As vec2f B = (Box.Psn + Box.vertex[0].psn) - A0
	Dim As float t = B.dot(A) / A.dot(A)
	Dim As Vec2f p = A0 + t * A
	Dim As float Projection = p.dot(A)
	
	Min = Projection
	Max = Projection
	
	Line(Box.Psn.x + Box.vertex[0].psn.x, Box.Psn.y + Box.vertex[0].psn.y)-(p.x, p.y), RGB(128, 128, 128)
	Circle(p.x, p.y), 2, RGB(255, 0, 0),,, 1, F
	
	For i As Integer = 1 To Box.Num_vertices-1
		
		B = (Box.Psn + Box.vertex[i].psn) - A0
		t = B.dot(A) / A.dot(A)
		p = A0 + t * A
		Projection = p.dot(A)
		
		If Max < projection Then Max = projection
		If Min > projection Then Min = projection
		
		Line(Box.Psn.x + Box.vertex[i].psn.x, Box.Psn.y + Box.vertex[i].psn.y)-(p.x, p.y), RGB(128, 128, 128)
		Circle(p.x, p.y), 2, RGB(255, 0, 0),,, 1, F
		
	Next i
	
	'Print min, max

End Sub

Sub ComputeMinMax(ByRef Box As BoxType, ByVal Axis As vec2f, ByRef Min As float, ByRef Max As float)
	
	Min = (Box.Psn + Box.vertex[0].psn).dot(Axis)
	Max = Min
	
	For i As Integer = 1 To Box.Num_vertices-1
		
		Dim As float projection = (Box.Psn + Box.vertex[i].psn).dot(Axis)
		
		If Max < projection Then Max = projection
		If Min > projection Then Min = projection
		
	Next i
	
	'Print min, max

End Sub


'// calculate the projected interval of a box onto an axis
'void SATBoxInterval(Vector axis, Vector C, Vector R, Vector A[2], float& min, float& max)
'{'
    'float p = C * axis;'
    'float e = R.x * fabs(A[0] * axis) + R.y * fabs(A[1] * axis);
'    min = p - e;
'    max = p + e;
'}

Sub SATBoxInterval(ByRef Box As BoxType, ByVal Axis As vec2f, ByRef Min As float, ByRef Max As float)
	
	Dim As float p = Box.Psn.dot(Axis)
	Dim As vec2f r = Box.Ang
	Dim As vec2f a0 = Box.Vertex[1].psn - Box.Vertex[0].psn
	Dim As vec2f a1 = Box.Vertex[2].psn - Box.Vertex[1].psn
	
	Dim As float e = r.X * Abs(a0.dot(Axis)) + r.y * Abs(a1.dot(Axis))
	min = p - e
	max = p + e
	
End Sub

Function BoxBoxSAT(ByRef BoxA As BoxType, ByRef BoxB As BoxType) As Integer
	
	Dim As float minA, maxA, minB, maxB
	
	For i As Integer = 0 To 1'BoxA.Num_vertices - 1
		
		Dim As Integer j = (i + 1)' Mod BoxA.Num_vertices
		
		'Dim As vec2f Axis = (BoxA.vertex[j].psn - BoxA.vertex[i].psn).normal
		
		'ComputeMinMax(BoxA, Axis, MinA, MaxA)
		'SATBoxInterval(BoxA, Axis, MinA, MaxA)
		ComputeMinMax(BoxA, BoxA.Psn + BoxA.vertex[j].psn, BoxA.Psn + BoxA.vertex[i].psn, MinA, MaxA)

		
		'ComputeMinMax(BoxB, Axis, MinB, MaxB)
		'SATBoxInterval(BoxB, Axis, MinB, MaxB)
		ComputeMinMax(BoxB, BoxA.Psn + BoxA.vertex[j].psn, BoxA.Psn + BoxA.vertex[i].psn, MinB, MaxB)
		
		If (minA > maxB) Or (minB > maxA) Then Return 0
		
	Next
	
	For i As Integer = 0 To 1'BoxB.Num_vertices - 1
		
		Dim As Integer j = (i + 1)' Mod BoxB.Num_vertices
		
		'Dim As vec2f Axis = (BoxB.vertex[j].psn - BoxB.vertex[i].psn).normal
		
		'ComputeMinMax(BoxA, Axis, MinA, MaxA)
		'SATBoxInterval(BoxA, Axis, MinA, MaxA)
		ComputeMinMax(BoxA, BoxB.Psn + BoxB.vertex[j].psn, BoxB.Psn + BoxB.vertex[i].psn, MinA, MaxA)
		
		'ComputeMinMax(BoxB, Axis, MinB, MaxB)
		'SATBoxInterval(BoxB, Axis, MinB, MaxB)
		ComputeMinMax(BoxB, BoxB.Psn + BoxB.vertex[j].psn, BoxB.Psn + BoxB.vertex[i].psn, MinB, MaxB)
		
		If (minA > maxB) Or (minB > maxA) Then Return 0
		
	Next
	
	Return -1
	
End Function

Function BoxBallSAT(ByRef Box As BoxType, ByRef Ball As BallType) As Integer
	
	Return -1
	
End Function
