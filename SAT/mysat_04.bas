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
Const As Integ 	NumIterations						= 4													''	number of physics iterations
Const As Integ 	Numboxes			 					= 2												''	number of rigid bodies
Const As float 	g_acc     							= 00												''	gravitational acceleration
Const As Integ 	scrn_wid  							= 900													''	screen width
Const As Integ 	scrn_hgt  							= 600													''	screen height
Const As float 	rest_fps      					= 60     						''  ideal framerate
Const As float 	timestep        				= 1/rest_fps 									''  timestep per program loop
Const As float 	dt            					= timestep/NumIterations			''  timestep per physics iteration
Const As float 	inv_dt            			= 1/dt												''  inverse timestep 
Const As float 	inv_dt2     						= inv_dt*inv_dt   						''  inverse timestep squared
Const As float 	pickdist								= 64													''	

''
Type Vertex_Type
  As vec2f Init_Psn, Psn
End Type

Type box_Type
  As integ Num_vertices
  As UInteger col
  As vec2f frc, acc, vel, Psn, Ang
  As Float angle, Mass, InverseMass, Trq, Ang_Vel, Ang_Acc
  As Float Hgt, Wid, I, InverseI, Stiffnes, Damping, DynamicFriction, StaticFriction
  As vertex_Type Ptr vertex
End Type

''	
Dim Shared As box_type Ptr box
Dim Shared As Integ FPS, FPS_Counter
Dim Shared As double FPS_Timer, t0, Sleep_Time
Dim Shared As vec2i m, mo
Dim Shared As Integ mb, mbo, picked, pickedtype

Declare Sub BoxBoxConstraint(ByRef A As Box_type, ByRef B As Box_type)
Declare Sub BoxPointConstraint(ByRef A As Box_type, ByRef P As vec2f)

Declare Sub Mouse()
Declare Sub Integrate()
Declare Sub Render()
Declare Sub Pause()

Declare Function ClosestPointOnLine(ByVal p0 As vec2f, ByVal p1 As vec2f, ByVal x As vec2f) As vec2f

Declare Function ProjectVertexOnAxis(ByVal vertex As vec2f, ByVal axis As vec2f) As float

Declare Function BoxCollision(ByRef b0 As box_type, ByRef b1 As box_type) As Integer
Declare Function ProjectionsSeparated(ByVal minA As float, ByVal maxA As float, ByVal minB As float, ByVal maxB As float) As float
Declare Sub ComputeMinMax()

''	
box = Callocate(Numboxes*SizeOf(box_type))

''  set startup condition

Randomize timer

For A As integ = 0 To Numboxes-1
	
  With box[A]
	.Num_vertices = 4
	.col = RGB(64+Rnd*192, 64+Rnd*192, 64+Rnd*192)
	.Hgt = 64' + Rnd*32
	.Wid = 128' + Rnd*64
	.Mass = .Hgt*.Wid
	.InverseMass = 1/.Mass
	.I = (.Mass*(.Hgt*.Hgt + .Wid*.Wid)) / 12
	.InverseI = 1/.I
	
	'.ang_vel = (Rnd-Rnd) * 2
	
	.psn.x = 200 + Rnd *400
	.psn.y = 200 + Rnd *200
	
	.Angle = Rnd*2*pi
	.Ang = vec2f(Cos(.angle), Sin(.angle)) 
	
	.vertex = Callocate(.Num_vertices*SizeOf(vertex_type))
	
	.vertex[0].init_psn = vec2f(-0.5*.wid, -0.5*.hgt)
	.vertex[1].init_psn = vec2f( 0.5*.wid, -0.5*.hgt)
	.vertex[2].init_psn = vec2f( 0.5*.wid,  0.5*.hgt)
	.vertex[3].init_psn = vec2f(-0.5*.wid,  0.5*.hgt)
	
	For B As integ = 0 To .Num_Vertices-1
	.Vertex[B].Psn = vec2f(.Ang.dot(.Vertex[B].init_psn), .Ang.perpdot(.Vertex[B].init_psn))
	Next
    
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
	  
	  'BoxPointConstraint(box[0], vec2f(450, 250))
	  
	  'For i2 As Integ = 0 To NumBoxes-2
	  '	BoxBoxConstraint(Box[i2], Box[i2+1])
	 ' Next
	  
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

End

''----------------------------------------------------------------------------''

Sub BoxBoxConstraint(ByRef A As box_type, ByRef B As box_type)
	
	Dim As vec2f ContactPoint_A, ContactPoint_B
	
	ContactPoint_A =  A.Vertex[0].Psn
	
	ContactPoint_B = B.Vertex[2].Psn
	
	Dim As vec2f Distance_Vector = (A.Psn + ContactPoint_A) - (B.Psn + ContactPoint_B)
	
  Dim As vec2f NormalVector = Distance_Vector.normalised
  Dim As vec2f TangentVector = NormalVector.Normal
  
	Dim As Float Distance_ = Distance_Vector.dot(NormalVector)
	
	Dim As vec2f ContactPointVelocity_A = A.vel + A.ang_vel * ContactPoint_A.Normal
	Dim As vec2f ContactPointVelocity_B = B.vel + B.ang_vel * ContactPoint_B.Normal
	
	Dim As vec2f ContactPointVelocity = ContactPointVelocity_a - ContactPointVelocity_b
	
	Dim As Float ContactPointVelocityNormal = ContactPointVelocity.Dot(NormalVector)
	Dim As Float ContactPointVelocityTangent = ContactPointVelocity.Dot(TangentVector)
	
  Dim As Float Stiffnes = 0.5
  Dim As Float Damping  = 0.25
  
  Dim As float IA = ContactPoint_A.Dot(TangentVector)
  Dim As float IB = ContactPoint_B.Dot(TangentVector)
  
  Dim As float NormalForce = -(Stiffnes*inv_dt2 * Distance_ + Damping*inv_dt * ContactPointVelocityNormal) /_ 
  	(A.InverseMass + B.Inversemass + A.InverseI*IA*IA	+ B.InverseI*IB*IB )
  
  Dim As float TangentForce = -(Damping*inv_dt * ContactPointVelocityTangent) / _
  	(A.InverseMass + B.Inversemass + A.InverseI*ContactPoint_A.MagnitudeSquared	+ B.InverseI*ContactPoint_B.MagnitudeSquared )
  
  Dim As Vec2f Force = NormalForce*NormalVector + TangentForce*TangentVector
  
  A.Frc += Force
  A.Trq += Force.perpdot(ContactPoint_A)
  
  B.Frc -= Force
  B.Trq -= Force.perpdot(ContactPoint_B)
  
End Sub

Sub BoxPointConstraint(ByRef A As box_type, ByRef P As vec2f)
	
	Dim As vec2f ContactPoint = A.Vertex[2].Psn
		
	Dim As vec2f Distance_Vector = (A.Psn + ContactPoint) - P
	
  Dim As vec2f NormalVector = Distance_Vector.normalised
  Dim As vec2f TangentVector = NormalVector.Normal
  
	Dim As Float Distance_ = Distance_Vector.dot(NormalVector)
	
	Dim As vec2f ContactPointVelocity = A.vel + A.ang_vel * ContactPoint.Normal
	
	Dim As Float ContactPointVelocityNormal  = ContactPointVelocity.Dot(NormalVector)
	Dim As Float ContactPointVelocityTangent = ContactPointVelocity.Dot(TangentVector)
	
  Dim As Float Stiffnes = 0.5
  Dim As Float Damping	= 0.25
  
  Dim As float IA = ContactPoint.Dot(TangentVector)
  
  Dim As float NormalForce = -(Stiffnes*inv_dt2 * Distance_ + Damping*inv_dt * ContactPointVelocityNormal) / _
  	(A.inversemass + IA*IA*A.InverseI)
  
  Dim As float TangentForce = -(Damping*inv_dt * ContactPointVelocityTangent) / _
  	(A.inversemass + ContactPoint.MagnitudeSquared*A.InverseI)
  
  Dim As Vec2f Force = NormalForce*NormalVector + TangentForce*TangentVector
  
  A.Frc += Force
  A.Trq += Force.perpdot(ContactPoint)
  
End Sub


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
    			
    			Line(pnt1.x, pnt1.y)-(pnt2.x, pnt2.y), RGB(0, 0, 0)
    			
    			Draw String (.psn.x, .psn.y), Str(A), RGB(255, 255, 255)
    			
    			'Circle(pnt1.x, pnt1.y), 2.5, RGB(0, 0, 128),,,1,f
    			
    		Next
    		
    	End With
    Next
    
    Locate 2, (scrn_wid\8)-4: Print Using "###"; fps
    Locate 3, (scrn_wid\8)-4: Print Using "###"; Sleep_Time
    
    Dim As Integer collide = BoxCollision(Box[0], Box[1])
    
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
 	
	Sleep_Time = (timestep-(Timer-t0))*1000 - 1
  
	If Sleep_Time < 1 Then Sleep_Time = 1
	If Sleep_Time > 1000 Then Sleep_Time = 1000
  
	Sleep Sleep_Time, 1
	
	Do While timestep > (Timer-t0): Loop
	
	t0 = Timer
  
End Sub

''	functions
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

Function BoxCollision(ByRef A As box_type, ByRef B As box_type) As Integer
	
	Dim As float minA, maxA, minB, maxB
	
	'' box A
	For i As Integer = 0 To 1'A.Num_vertices-1
		
		Dim As Integer j = (i+1) Mod A.Num_vertices
		
		Dim As vec2f axis = (A.vertex[j].psn - A.vertex[i].psn).normal
		
		minA = 1000000: maxA = -10000000
		
		''	project box A on axis - get min max values
		For k As Integer = 0 To A.Num_vertices-1
			
			'Dim As float projection = ProjectVertexOnAxis(A.Psn + A.vertex[k].psn, axis)
			Dim As float projection = (A.Psn + A.vertex[k].psn).dot(axis)
			
			'Print projection
			
			If maxA < projection Then maxA = projection
			If minA > projection Then minA = projection
			
		Next
		
		minB = 10000000: maxB = -10000000
		
		''	project box B on axis - get min max values
		For k As Integer = 0 To B.Num_vertices-1
			
			'Dim As float projection = ProjectVertexOnAxis(B.Psn + B.vertex[k].psn, axis)
			Dim As float projection = (B.Psn + B.vertex[k].psn).dot(axis)
			
			Print projection
			
			If maxB < projection Then maxB = projection
			If minB > projection Then minB = projection
			
		Next
		
		If (minA > maxB) Or (minB > maxA) Then Return 0
		
	Next
	
	'' box B
	For i As Integer = 0 To 1'B.Num_vertices-1
		
		Dim As Integer j = (i+1) Mod B.Num_vertices
		
		Dim As vec2f axis = (B.vertex[j].psn - B.vertex[i].psn).normal
		
		minB = 10000000: maxB = -10000000
		
		''	project box B on axis - get min max values
		For k As Integer = 0 To B.Num_vertices-1
			
			'Dim As float projection = ProjectVertexOnAxis(A.Psn + A.vertex[k].psn, axis)
			Dim As float projection = (A.Psn + A.vertex[k].psn).dot(axis)
			
			'Print projection
			
			If maxB < projection Then maxB = projection
			If minB > projection Then minB = projection
			
		Next
		
		minA = 1000000: maxA = -10000000
		
		''	project box B on axis - get min max values
		For k As Integer = 0 To A.Num_vertices-1
			
			'Dim As float projection = ProjectVertexOnAxis(B.Psn + B.vertex[k].psn, axis)
			Dim As float projection = (B.Psn + B.vertex[k].psn).dot(axis)
			
			Print projection
			
			If maxA < projection Then maxA = projection
			If minA > projection Then minA = projection
			
		Next
		
		If (minA > maxB) Or (minB > maxA) Then Return 0
		
	Next
	
	Return -1
	
End Function
