''****************************************************************************************
''
''	force based rigid body hinge constraint
''	Version 0.1 - november 2016
''
''****************************************************************************************


''	
#Include Once "../Math/vec2.bi"
#Include Once "../Math/Mat22.bi"
#Include Once "fbgfx.bi"


''	
Const As Single 	pi        					= 4*Atn(1)										''	pi
Const As Integer 	NumIterations				= 1														''	number of physics iterations
Const As Integer 	NumBalls 					= 16										''	nunber of balls
Const As Integer 	Numboxes			 			= 3														''	nunber of rigid bodies
Const As Integer 	NumWalls	 					= 4														''	number of walls (don't change)
Const As Single 	g_acc     					= 10												''	gravitational acceleration
Const As Integer 	scrn_wid  					= 900													''	screen width
Const As Integer 	scrn_hgt  					= 600													''	screen height
Const As Single 	rest_fps      				= 60              						''  ideal framerate
Const As Single 	timestep        			= 1/rest_fps 									''  timestep per program loop
Const As Single 	dt            				= timestep/NumIterations			''  timestep per physics iteration
Const As Single 	inv_dt            		= 1/dt												''  inverse timestep
Const As Single 	inv_dt2     				= inv_dt*inv_dt   						''  inverse timestep squared
Const As Single 	StaticFrictionVelocity	= 2														''	static friction threshold velocity
Const As Single 	pickdist						= 64													''	


''
Type Vertex_Type
  As Single Mass, Distance_to_center
  As Vec2 Init_Psn, Psn, Frc
End Type

Type box_Type
  As Integer Num_vertices
  As UInteger col
  As Vec2 frc, acc, vel, Psn
  As Single sin_ang, cos_ang, ang, Mass, InverseMass, Trq, Ang_Vel, Ang_Acc
  As Single Hgt, Wid, I, InverseI, Stiffnes, Damping, DynamicFriction, StaticFriction
  As vertex_Type Ptr vertex
End Type

Type ball_type
  As UInteger col
  As Vec2 frc, acc, vel, Psn
  As Single sin_ang, cos_ang, ang, Mass, InverseMass, Trq, Ang_Vel, Ang_Acc
  As Single Density, Radius, RadiusSquared, I, InverseI, Stiffnes, Damping, DynamicFriction, StaticFriction
End Type

Type wall_type
  As UInteger col
  As Vec2 Psn(1 To 2)
  As Single Stiffnes, Damping, DynamicFriction, StaticFriction
End Type

Type Contact_Info
	As Vec2 DistanceVector
	As Single DistanceSquared
	As Single Radius
End Type

''	
Dim Shared As ball_type Ptr ball
Dim Shared As wall_type Ptr wall
Dim Shared As box_type Ptr box
Dim Shared As Integer FPS, FPS_Counter
Dim Shared As double FPS_Timer, t0, Sleep_Time
Dim Shared As Integer mx, my, mox, moy
Dim Shared As Integer mb, mbo, picked

''	
Declare Sub BallWallCollisionDetection()
Declare Sub BallWallCollisionResponse(ByRef A As ball_type, ByRef W As wall_type)
Declare Sub BallBallCollisionDetection()
Declare Sub BallBallCollisionResponse(ByRef A As ball_type, ByRef B As ball_type)
Declare Sub BallBallConstraint(ByRef A As box_Type, ByRef B As box_Type)
Declare Sub BallPointConstraint(ByRef A As ball_type, ByRef P As Vec2)
Declare Sub Mouse()
Declare Sub Integerrate()
Declare Sub Render()
Declare Sub Pause()

Declare Function ClosestPointOnLine(a1 As Vec2, a2 As Vec2, p1 As Vec2) As Vec2

''	
ball = Callocate(NumBalls*SizeOf(ball_type))
wall = Callocate(NumWalls*SizeOf(wall_type))
box = Callocate(Numboxes*SizeOf(box_type))

''  set startup condition
With wall[0]: .Psn(1) = Vec2(10, 10)										:	.Psn(2) = Vec2(scrn_wid-11, 10)							:	End With
With wall[1]: .Psn(1) = Vec2(scrn_wid-11, 10)					: .Psn(2) = Vec2(scrn_wid-11, scrn_hgt-11)	:	End With
With wall[2]: .Psn(1) = Vec2(scrn_wid-11, scrn_hgt-11)	:	.Psn(2) = Vec2(10, scrn_hgt-11)			:	End With
With wall[3]: .Psn(1) = Vec2(10, scrn_hgt-11)					:	.Psn(2) = Vec2(10, 10)				:	End With


For A As Integer = 0 To NumWalls-1
  With wall[A]
  	.Stiffnes = 0.25
    .Damping  = 0.25
    .DynamicFriction = 0.5
    .StaticFriction = 0.5
    .Col = RGBA(0, 0, 0, 255)
'    .Perp = (.Psn(1)-.Psn(2)).unit
  End With
Next

Randomize Timer

For A As Integer = 0 To NumBalls-1
  With ball[A]
    .Stiffnes = 0.1
    .Damping  = 0.1
  	.DynamicFriction = 0.5
    .StaticFriction = 0.5
    .col = RGB(64+Rnd*192, 64+Rnd*192, 64+Rnd*192)
    '.Mass = NumBalls-A'(2 + (Rnd*8^(1/3))^3)
    .Mass = 10 + (Rnd*90^(1/2))^2
    .InverseMass = 1/.Mass
    If A = 0 Then .InverseMass = 0
    .Density = 0.001
    .Radius = ((.Mass/.Density)/((4/3)*pi))^(1/3)
    .RadiusSquared = .Radius*.Radius
    .I = 0.5*.Mass*.RadiusSquared 
    .InverseI = 1/.I
   	.psn.x = 450
   	.psn.y = 500 - A * 2 * .Radius
   	'.psn.y = 100 + .Radius + A * 2 * .Radius + (Rnd-Rnd)*100
    '.ang = 0.5*pi
    .ang = 0'.5*pi'Rnd*2*pi
    '.ang_Vel = (Rnd-Rnd)*50
    '.Vel.x = (Rnd-Rnd)*500
    .cos_ang = Cos(.ang)
    .sin_ang = Sin(.ang)
  End With
Next

For A As Integer = 0 To Numboxes-1
  With box[A]
		.Num_vertices = 3
		.Stiffnes = 0.5
    .Damping  = 0.01
  	.DynamicFriction = 0.5
    .StaticFriction = 0.8
    .col = RGB(64+Rnd*192, 64+Rnd*192, 64+Rnd*192)
    .Hgt = 5
    .Wid = 20
    .Mass = 100
    .InverseMass = IIf( A = 0 , 0, 1/.Mass )
		.I = (.Mass*(.Hgt^2 + .Wid^2)) / 12
		.InverseI = 1/.I
		.psn.x = 450 + A * 2 * .wid
   	.psn.y = 100 + A * 2 * .Hgt
		.ang = 0'Rnd * 2 * pi
    .ang_Vel = 0'(Rnd-Rnd)*10
    .cos_ang = Cos(.ang)
    .sin_ang = Sin(.ang)
  End With
Next


''----------------------------------------------------------------------------''

ScreenRes( scrn_wid, scrn_hgt, 32, 2, fb.GFX_ALPHA_PRIMITIVES )
ScreenSet( 1, 0 )
WindowTitle "force based 2d ball-ball and ball-line segment collision with friction"
Color RGB(0, 0, 0), RGB(192, 192, 244)

t0 = Timer

Do
	
	Cls
	
  Render()
  
  Pause()
  
  For i As Integer = 1 To NumIterations
  	
	  'BallWallCollisionDetection()
	  'BallBallCollisionDetection()
	  
	 ' BallPointConstraint(ball[0], Vec2(450, 100))
	  
	  For i2 As Integer = 0 To NumBoxes-2
	  	
	 		BallBallConstraint(Box[i2], Box[i2+1])
	 		
	  Next
	  
	  Mouse()
	  
	  Integerrate()
	  
  Next
  
  ScreenCopy()
  
Loop Until MultiKey(1)

DeAllocate(ball)
DeAllocate(wall)
DeAllocate(box)

End

''----------------------------------------------------------------------------''

Sub BallWallCollisionDetection()
  
  For A As Integer = 0 To NumWalls-1
    For B As Integer = 0 To NumBalls-1
    	
      Dim As Vec2 ClosestPoint = ClosestPointOnLine(wall[A].Psn(1), wall[A].Psn(2), ball[B].Psn)
      
      Dim As Vec2 DistanceVector = ball[B].Psn - ClosestPoint
      
'      If Absolute(DistanceVector) > ball[B].Radius Then Continue For
      
      Dim As Single Distance_Squared = DistanceVector.LengthSquared
      
      If Distance_Squared > ball[B].RadiusSquared Then Continue For
      
      BallWallCollisionResponse(ball[B], wall[A])
      
    Next
  Next
  
End Sub

Sub BallWallCollisionResponse(ByRef A As ball_type, ByRef W As wall_type)
  
  Dim As Vec2 closest_point = ClosestPointOnLine(W.Psn(1), W.Psn(2), A.Psn)
  
	Dim As Vec2 Distance_Vector = A.Psn-closest_point
	
  Dim As Vec2 NormalVector = Distance_Vector.unit
  
	Dim As Single Distance_ = Distance_Vector.dot(NormalVector)
  
  Dim As Vec2 TangentVector = NormalVector.PerpCW
  
  Dim As Single Intersection = Distance_-A.Radius
  
  Dim As Vec2 ContactPoint = A.Radius * -NormalVector
  
	Dim As Vec2 ContactPointVelocity = A.vel+A.ang_vel*ContactPoint.PerpCW
	
  Dim As Single ContactPointVelocityNormal = ContactPointVelocity.Dot(NormalVector)
  Dim As Single ContactPointVelocityTangent = ContactPointVelocity.Dot(TangentVector)
  
  Dim As Single FrictionCoefficient = IIf(Abs(ContactPointVelocityTangent) < StaticFrictionVelocity, (A.StaticFriction+W.StaticFriction)*0.5, (A.DynamicFriction+W.DynamicFriction)*0.5)
  
  Dim As Single Stiffnes = (A.Stiffnes+W.Stiffnes)*0.5
  Dim As Single Damping = (A.Damping+W.Damping)*0.5
  
  Dim As Single NormalForce = -(Stiffnes*inv_dt2 * Intersection + Damping*inv_dt * ContactPointVelocityNormal) / A.InverseMass
	
  Dim As Single TangentForce = -(FrictionCoefficient/dt * ContactPointVelocityTangent) / (A.InverseMass + A.radiussquared*A.InverseI)
  
  Dim As Vec2 Force = NormalForce*NormalVector+TangentForce*TangentVector 
  
  A.Frc += Force
  A.Trq += Force.PerpDot(ContactPoint)
  
  A.col = IIf(Abs(ContactPointVelocityTangent) < StaticFrictionVelocity, RGB(255, 64, 64), RGB(64, 255, 64))
	
End Sub

Sub BallBallCollisionDetection()
  
  For A As Integer = 0 To NumBalls-2
    For B As Integer = A+1 To NumBalls-1
    	
      Dim As Vec2 DistanceVector = ball[A].Psn-ball[B].Psn
      Dim As Single Radius = ball[A].Radius+ball[B].Radius
      
'      If Absolute(DistanceVector) > Radius Then Continue For
      
      Dim As Single Distance_Squared = DistanceVector.LengthSquared
      Dim As Single RadiusSquared = Radius*Radius
      
      If Distance_Squared > RadiusSquared Then Continue For
      
      BallBallCollisionResponse(ball[A], ball[B])
	    
    Next
  Next
  
End Sub

Sub BallBallCollisionResponse(ByRef A As ball_type, ByRef B As ball_type)
	
	Dim As Vec2 Distance_Vector = A.Psn-B.psn
	
  Dim As Vec2 NormalVector = Distance_Vector.unit
  
	Dim As Single Distance_ = Distance_Vector.dot(NormalVector)
  
  Dim As Vec2 TangentVector = NormalVector.PerpCW
  
  Dim As Single Radius = A.Radius + B.Radius
  
  Dim As Single Intersection = Distance_-Radius
  
	Dim As Vec2 ContactPoint_A = A.Radius * -NormalVector
	Dim As Vec2 ContactPoint_B = B.Radius *  NormalVector
	
	Dim As Vec2 ContactPointVelocity_A = A.vel + A.ang_vel * ContactPoint_A.PerpCW
	Dim As Vec2 ContactPointVelocity_B = B.vel + B.ang_vel * ContactPoint_B.PerpCW
	
	Dim As Vec2 ContactPointVelocity = ContactPointVelocity_a - ContactPointVelocity_b
	
	Dim As Single ContactPointVelocityNormal = ContactPointVelocity.Dot(NormalVector)
	Dim As Single ContactPointVelocityTangent = ContactPointVelocity.Dot(TangentVector)
	
	Dim As Single FrictionCoefficient = IIf(Abs(ContactPointVelocityTangent) < StaticFrictionVelocity, (A.StaticFriction + B.StaticFriction)*0.5, (A.DynamicFriction + B.DynamicFriction)*0.5)
  
  Dim As Single Stiffnes = (A.Stiffnes + B.Stiffnes)*0.5
  Dim As Single Damping = (A.Damping + B.Damping)*0.5
  
  Dim As Single IA = ContactPoint_A.Dot(ContactPoint_A)
  Dim As Single IB = ContactPoint_B.Dot(ContactPoint_B)
  
  Dim As Single NormalForce = -(Stiffnes*inv_dt2 * Intersection + Damping*inv_dt * ContactPointVelocityNormal) / _
  	(A.InverseMass + B.InverseMass)
  
  Dim As Single TangentForce = -(FrictionCoefficient/dt * ContactPointVelocityTangent) / _
  	(A.inversemass + B.inversemass + A.radiussquared*A.InverseI + B.radiussquared*B.InverseI)
  
  Dim As Vec2 Force = NormalForce*NormalVector + TangentForce*TangentVector
  
  A.Frc += Force
  A.Trq += Force.PerpDot(ContactPoint_A)
  
  B.Frc -= Force
  B.Trq -= Force.PerpDot(ContactPoint_B)
  
End Sub

'Sub BallBallConstraint(ByRef A As ball_type, ByRef B As ball_type)
'	
'	Dim As Vec2 Distance_Vector = A.Psn - B.Psn
'	
'  Dim As Vec2 NormalVector = Distance_Vector.unit
'  Dim As Vec2 TangentVector = NormalVector.PerpCW
'  
'  Dim As Single Displacement = Distance_Vector.dot(NormalVector) - (A.Radius + B.Radius)
'	
'	Dim As Vec2 ContactPoint_A = -A.Radius * NormalVector
'	Dim As Vec2 ContactPoint_B =  B.Radius * NormalVector
'
'	
'	Dim As Vec2 ContactPointVelocity_A = A.vel + A.ang_vel * ContactPoint_A.PerpCW
'	Dim As Vec2 ContactPointVelocity_B = B.vel + B.ang_vel * ContactPoint_B.PerpCW
'	
'	Dim As Vec2 ContactPointVelocity = ContactPointVelocity_a - ContactPointVelocity_b
'	
'	Dim As Single ContactPointVelocityNormal = ContactPointVelocity.Dot(NormalVector)
'	Dim As Single ContactPointVelocityTangent = ContactPointVelocity.Dot(TangentVector)
'	
'  Dim As Single Stiffnes = 1
'  Dim As Single Damping  = 0.5
'  Dim As Single TangentDamping  = 0.5
'  
'  'Dim As Single IA = ContactPoint_A.Dot(TangentVector)
'  'Dim As Single IB = ContactPoint_B.Dot(TangentVector)
'  
'  Dim As Single NormalForce = -(Stiffnes*inv_dt2 * Displacement + Damping*inv_dt * ContactPointVelocityNormal) /_ 
'  	(A.InverseMass + B.Inversemass)
' 
'  
'  Dim As Single TangentForce = -(TangentDamping*inv_dt * ContactPointVelocityTangent) / _
'  	(A.RadiusSquared*A.InverseI + B.RadiusSquared*B.InverseI)
'  
'  'Dim As Vec2 Force = NormalForce*NormalVector + TangentForce*TangentVector
'  
'  A.Frc += NormalForce*NormalVector
'  A.Trq += TangentForce*TangentVector.PerpDot(ContactPoint_A)
'  
'  B.Frc -= NormalForce*NormalVector
'  B.Trq -= TangentForce*TangentVector.PerpDot(ContactPoint_B)
'  
'End Sub

Sub BallBallConstraint(ByRef A As box_Type, ByRef B As box_Type)
	
	Dim As Vec2 ContactPoint_A, ContactPoint_B
	
	ContactPoint_A = Vec2( A.cos_ang, A.sin_ang ).rotateCW( Vec2(  A.wid,  A.hgt ) )
	ContactPoint_B = Vec2( B.cos_ang, B.sin_ang ).rotateCW( Vec2( -B.wid, -B.hgt ) )
	
	'ContactPoint_A = -A.Radius * Vec2( -A.cos_ang, A.Sin_Ang )
	'ContactPoint_B =  B.Radius * Vec2( -B.cos_ang, B.Sin_Ang )
	
	Dim As Vec2 ra = ContactPoint_A
	Dim As Vec2 rb = ContactPoint_B
	
	Dim As Vec2 Distance_Vector = (A.Psn + ContactPoint_A) - (B.Psn + ContactPoint_B)
	
  Dim As Vec2 NormalVector = Distance_Vector.unit
  Dim As Vec2 TangentVector = NormalVector.PerpCW
  
	Dim As Single Distance_ = Distance_Vector.dot(NormalVector)
	
	Dim As Vec2 ContactPointVelocity_A = A.vel + A.ang_vel * ContactPoint_A.PerpCW
	Dim As Vec2 ContactPointVelocity_B = B.vel + B.ang_vel * ContactPoint_B.PerpCW
	
	Dim As Vec2 ContactPointVelocity = ContactPointVelocity_a - ContactPointVelocity_b
	
	Dim As Single ContactPointVelocityNormal = ContactPointVelocity.Dot(NormalVector)
	
  Dim As Single Stiffnes = 0.9
  Dim As Single Damping  = 0.5
  
  Dim As Single IA = ContactPoint_A.PerpDot( NormalVector )
  Dim As Single IB = ContactPoint_B.PerpDot( NormalVector )
  
  
  Dim As Mat22 K1
  K1.C1.x = A.InverseMass + B.Inversemass : K1.C2.x = 0.0
  K1.C1.y = 0.0                           : K1.C2.y = A.InverseMass + B.Inversemass
  
  Dim As Mat22 K2
  K2.C1.x =  A.InverseI * ra.y * ra.y : K2.C2.x = -A.InverseI * ra.x * ra.y
  K2.C1.y = -A.InverseI * ra.x * ra.y : K2.C2.y =  A.InverseI * ra.x * ra.x
  
  Dim As Mat22 K3
  K3.C1.x =  B.InverseI * rb.y * rb.y : K3.C2.x = -B.InverseI * rb.x * rb.y
  K3.C1.y = -B.InverseI * rb.x * rb.y : K3.C2.y =  B.InverseI * rb.x * rb.x 
  
  Dim As Mat22 K = K1 + K2 + K3
  
  Dim As Mat22 M = K.inverse()
  
 ' Dim As Vec2 Force = ( -( Stiffnes * inv_dt2 * Distance_ + Damping * inv_dt * ContactPointVelocityNormal ) /_ 
  '	                 (A.InverseMass + B.Inversemass + A.InverseI*IA*IA	+ B.InverseI*IB*IB ) ) * NormalVector
  
 	'Dim As Vec2 Force = -( Stiffnes * inv_dt2 * Distance_ + Damping * inv_dt * ContactPointVelocityNormal ) *_
   '                     1.0 / ( A.InverseMass + B.Inversemass + A.InverseI*IA*IA + B.InverseI*IB*IB )  * NormalVector
  
  Dim As Vec2 Force = - ( Distance_Vector * inv_dt2 * Stiffnes + ContactPointVelocity * inv_dt * Damping ) * M
  
  A.Frc += Force
  A.Trq += Force.PerpDot( ContactPoint_A )
  
  B.Frc -= Force
  B.Trq -= Force.PerpDot( ContactPoint_B )
  
  Locate 4, 4: Print M.c1.x ; M.c1.y ; M.c2.x ; M.c2.y
  
End Sub

Sub BallPointConstraint(ByRef A As ball_type, ByRef P As Vec2)
		
	Dim As Vec2 Distance_Vector = A.Psn  - P
	
  Dim As Vec2 NormalVector = Distance_Vector.unit
  
	Dim As Single Distance_ = Distance_Vector.dot(NormalVector) - A.Radius
	
  Dim As Vec2 TangentVector = NormalVector.PerpCW
  
  Dim As Vec2 ContactPoint = -A.Radius * NormalVector
	
	Dim As Vec2 ContactPointVelocity = A.vel + A.ang_vel * ContactPoint.PerpCW
	
	Dim As Single ContactPointVelocityNormal  = ContactPointVelocity.Dot(NormalVector)
	Dim As Single ContactPointVelocityTangent = ContactPointVelocity.Dot(TangentVector)
	
  Dim As Single Stiffnes = 1.0
  Dim As Single Damping  = 1.0
  Dim As Single TangentDamping  = 0.0
  
  'Dim As Single IA = ContactPoint.Dot(TangentVector)
  
  Dim As Single NormalForce = -(Stiffnes*inv_dt2 * Distance_ + Damping*inv_dt * ContactPointVelocityNormal) / _
  	(A.inversemass)
  
  Dim As Single TangentForce = -(TangentDamping*inv_dt * ContactPointVelocityTangent) / _
  	(A.RadiusSquared*A.InverseI)
  
  'Dim As Vec2 Force = NormalForce*NormalVector + TangentForce*TangentVector
  
  A.Frc += NormalForce*NormalVector
  A.Trq += TangentForce*TangentVector.PerpDot(ContactPoint)
  
End Sub

'Sub BallPointConstraint(ByRef A As ball_type, ByRef P As Vec2)
'	
'	Dim As Vec2 ContactPoint
'	
'	ContactPoint.x = -A.Radius * A.cos_ang
'	ContactPoint.y = -A.Radius * A.sin_ang
'		
'	Dim As Vec2 Distance_Vector = (A.Psn + ContactPoint) - P
'	
'  Dim As Vec2 NormalVector = Distance_Vector.unit
'  
'	Dim As Single Distance_ = Distance_Vector.dot(NormalVector)
'  Dim As Vec2 TangentVector = NormalVector.PerpCW
'	
'	Dim As Vec2 ContactPointVelocity = A.vel + A.ang_vel * ContactPoint.PerpCW
'	
'	Dim As Single ContactPointVelocityNormal  = ContactPointVelocity.Dot(NormalVector)
'	Dim As Single ContactPointVelocityTangent = ContactPointVelocity.Dot(TangentVector)
'	
'  Dim As Single Stiffnes = 0.001
'  Dim As Single Damping  = 0.5
'  
'  Dim As Single IA = ContactPoint.PerpDot(NormalVector)
'  
'  Dim As Vec2 Force = (-(Stiffnes*inv_dt2 * Distance_ + Damping*inv_dt * ContactPointVelocityNormal) / _
'  	(A.inversemass + IA*IA*A.InverseI)) * NormalVector
'  
'  A.Frc += Force
'  A.Trq += Force.PerpDot(ContactPoint)
'  
'End Sub

Sub Mouse()
	
	'' update mouse state
	mox = mx: moy = my :	mbo = mb: GetMouse (Cast(Integer, mx),Cast( Integer, my),, mb)
	
	'' on left mouse, pick up nearest control point
	If mb = 1 Then
		If Picked = -1 Then
			Dim As Single tempdist = pickdist*pickdist
			For i As Integer = 0 To Numballs-1
				Dim As Single dx 		= mx-ball[i].Psn.x	:	If Abs(dx) > pickdist Then Continue For
				Dim As Single dy 		= my-ball[i].Psn.y	:	If Abs(dy) > pickdist Then Continue For
				Dim As Single dsqrd = dx*dx+dy*dy	: If dsqrd 	> tempdist Then Continue For
				tempdist = dsqrd
				picked = i
			Next
		End If
	Else
		picked = -1
	End If
	
	'' move picked-up control point
	If Not picked = -1 Then
		With ball[picked]
			.psn.x += (mx - mox)
			.psn.y += (my - moy)
			.vel.x = (mx - mox)/dt
			.vel.y = (my - moy)/dt
			.vel = Vec2(0, 0)
			.frc = Vec2(0, 0)
			.ang_vel = 0
			.trq = 0
		End With
	EndIf
	
End Sub

Sub Integerrate()
  
  For A As Integer = 0 To NumBalls-1
    With ball[A]
    	
    	If a <> picked Then
    		
    	''	linear
    	.Acc = (.Frc + Vec2(0, g_acc)) *.InverseMass
    	
    	.frc = Vec2(0, 0)
    	
      .vel += .acc*dt 
      .Psn += .vel*dt
      
      '.vel *= 0.999
      
      ''	angular
      .Ang_Acc = .Trq*.InverseI
      .Trq = 0
      .ang_vel += .Ang_Acc*dt
      
      '.ang_Vel *= 0.999
      
      .ang += .ang_vel*dt
      
      .cos_ang = Cos(.ang)
      .sin_ang = Sin(.ang)
      
      End if
      
    End With
  Next
  
  For A As Integer = 0 To NumBoxes-1
    With box[A]
    	
    	'If a <> picked Then
    	
    	If  .inversemass <> 0 Then 
	    	
	    	''	linear
	    	.Acc = .Frc *.InverseMass
	      .vel += .acc*dt + Vec2(0, g_acc) * 1/NumIterations
	      .Psn += .vel*dt
	      
    	End If
    	.frc = Vec2(0, 0)
	     
	    If  .InverseI <> 0 Then
	    	
	      ''	angular
	      .Ang_Acc = .Trq*.InverseI
	      .ang_vel += .Ang_Acc*dt
	      .ang += .ang_vel*dt
	      
	      .cos_ang = Cos(.ang)
	      .sin_ang = Sin(.ang)
	      
	    EndIf
	    .Trq = 0
      
    End With
  Next
  
End Sub

Sub Render()

 'Cls
 
 For A As Integer = 0 To NumBalls-1
   With ball[A]
   	
     Circle (.Psn.x, .Psn.y), .Radius, RGB(0, 0, 0),,,1, f
     Circle (.Psn.x, .Psn.y), .Radius-2, .col,,,1, f

     Circle (.Psn.x-.cos_ang*.Radius*0.52, .Psn.y+.sin_ang*.Radius*0.52), .Radius*0.3, RGBA(0, 0, 0, 48),,,1, f
     
     'Circle (.Psn.x+.sin_ang*.Radius*0.52, .Psn.y-.cos_ang*.Radius*0.52), .Radius*0.3, RGBA(0, 0, 0, 48),,,1, f
     'Circle (.Psn.x-.sin_ang*.Radius*0.52, .Psn.y+.cos_ang*.Radius*0.52), .Radius*0.3, RGBA(0, 0, 0, 48),,,1, f
     Draw String (.Psn.x-8, .Psn.y-8), Str(A), RGBA(0, 0, 0, 128)
     
     'Line(.Psn.x, .Psn.y)-(.Psn.x+.frc.x*0.01, .Psn.y+.frc.y*0.01), RGBA(0, 0, 0, 255)
     
     'Pset(450, 100), RGB(0, 0, 0)
     
     .col = RGB(255, 255, 64)
     
   End With
 Next
 
  For A As Integer = 0 To NumBoxes-1
   With Box[A]
		
		Dim As Vec2 vertex1 = .psn + Vec2( .cos_ang, .sin_ang ).rotateCW( Vec2(  .wid,  .hgt ) )
		Dim As Vec2 vertex2 = .psn + Vec2( .cos_ang, .sin_ang ).rotateCW( Vec2(  .wid, -.hgt ) )
		Dim As Vec2 vertex3 = .psn + Vec2( .cos_ang, .sin_ang ).rotateCW( Vec2( -.wid, -.hgt ) )
		Dim As Vec2 vertex4 = .psn + Vec2( .cos_ang, .sin_ang ).rotateCW( Vec2( -.wid,  .hgt ) )
		
		Line( vertex1.x, vertex1.y )-( vertex2.x, vertex2.y )
		Line( vertex2.x, vertex2.y )-( vertex3.x, vertex3.y )
		Line( vertex3.x, vertex3.y )-( vertex4.x, vertex4.y )
		Line( vertex4.x, vertex4.y )-( vertex1.x, vertex1.y )
		
   End With
 Next
 
 For A As Integer = 0 To NumWalls-1
   With wall[A]
     Line(.Psn(1).x, .Psn(1).y)-(.Psn(2).x, .Psn(2).y), .col
     Draw String ((.Psn(1).x+.Psn(2).x)*0.5, (.Psn(1).y+.Psn(2).y)*0.5), Str(A), RGBA(0, 0, 0, 192)
   End With
 Next
 
 Locate 3, (scrn_wid\8)-4: Print Using "###"; fps
 Locate 4, (scrn_wid\8)-4: Print Using "###"; Sleep_Time
 
  'ScreenCopy()
  
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
  
	If Sleep_Time < 0  Then Sleep_Time = 0
	'If Sleep_Time > 32 Then Sleep_Time = 32
  
	Sleep Sleep_Time, 1
	'Sleep 2, 1
	
	Do While timestep > (Timer-t0): Loop
	
	t0 = Timer
  
End Sub

Function ClosestPointOnLine(a1 As Vec2, a2 As Vec2, p1 As Vec2) As Vec2
  Dim As Vec2 ab = a2-a1
  'Dim As Single t  = (p1-a1).Dot(ab)/ab.LengthSquared
  Dim As Single t  = (p1-a1).Dot(ab)/(ab).Dot(ab)
  If t < 0 Then t = 0
  If t > 1 Then t = 1
  Return a1+ab*t
End Function
