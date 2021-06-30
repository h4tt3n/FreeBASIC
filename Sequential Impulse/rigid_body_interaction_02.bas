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
Const As Integer 	NumIterations				= 10														''	number of physics iterations
Const As Integer 	NumBalls 					= 8										''	nunber of balls
Const As Integer 	Numboxes			 			= 8														''	nunber of rigid bodies
Const As Integer 	NumWalls	 					= 4														''	number of walls (don't change)
Const As Single 	g_acc     					= 20												''	gravitational acceleration
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
'Declare Sub BallBallConstraint(ByRef A As ball_type, ByRef B As ball_type)
Declare Sub BallPointConstraint(ByRef A As ball_type, ByRef P As Vec2)
Declare Sub Mouse()
Declare Sub Integrate()
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
'    .PerpCCW = (.Psn(1)-.Psn(2)).unit
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
    .Mass = 10.0 '+ A * 10.0
    .InverseMass = 1/.Mass
    If A = 0 Then .InverseMass = 0
    .Density = 0.0001
    .Radius = ((.Mass/.Density)/((4/3)*pi))^(1/3)
    .RadiusSquared = .Radius*.Radius
    .I = 0.5*.Mass*.RadiusSquared 
    .InverseI = 1/.I
   	.psn.x = 450 + A * 2 * .Radius
   	.psn.y = 100
   	'.psn.y = 100 + .Radius + A * 2 * .Radius + (Rnd-Rnd)*100
    '.ang = 0.5*pi
    .ang = 0'1.5*pi'Rnd*2*pi
    If A = 0 Then .ang_Vel = 10
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
    .Wid = 40
    .Mass = 10
    .InverseMass = IIf( A = 0 Or A = Numboxes-1, 0, 1/.Mass )
		.I = (.Mass*(.Hgt^2 + .Wid^2)) / 12
		.InverseI = 1/.I
		.psn.x = 200 + A * 2 * .wid
   	.psn.y = 100' + A * 2 * .Hgt
		.ang = 0'Rnd * 2 * pi
    .ang_Vel = 0'(Rnd-Rnd)*10
    If A = 0 Then .ang_Vel = 10
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
	  
	  For i2 As Integer = 0 To NumBalls-2
	  	
	 		'BallBallConstraint(Ball[i2], Ball[i2+1])
	 		BallBallConstraint(Box[i2], Box[i2+1])
	 		
	  Next
	  
	  Mouse()
	  
	  Integrate()
	  
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
  
	Dim As Vec2 Distance = A.Psn-closest_point
	
  Dim As Vec2 NormalVector = Distance.unit
  
	Dim As Single Distance_ = Distance.dot(NormalVector)
  
  Dim As Vec2 TangentVector = NormalVector.PerpCCW
  
  Dim As Single Intersection = Distance_-A.Radius
  
  Dim As Vec2 CP = A.Radius * -NormalVector
  
	Dim As Vec2 Velocity = A.vel+A.ang_vel*CP.PerpCCW
	
  Dim As Single NormalVelocity = Velocity.Dot(NormalVector)
  Dim As Single TangentVelocity = Velocity.Dot(TangentVector)
  
  Dim As Single FrictionCoefficient = IIf(Abs(TangentVelocity) < StaticFrictionVelocity, (A.StaticFriction+W.StaticFriction)*0.5, (A.DynamicFriction+W.DynamicFriction)*0.5)
  
  Dim As Single Stiffnes = (A.Stiffnes+W.Stiffnes)*0.5
  Dim As Single Damping = (A.Damping+W.Damping)*0.5
  
  Dim As Single NormalForce = -(Stiffnes*inv_dt2 * Intersection + Damping*inv_dt * NormalVelocity) / A.InverseMass
	
  Dim As Single TangentForce = -(FrictionCoefficient/dt * TangentVelocity) / (A.InverseMass + A.radiussquared*A.InverseI)
  
  Dim As Vec2 Force = NormalForce*NormalVector+TangentForce*TangentVector 
  
  A.Frc += Force
  A.Trq += Force.PerpDot(CP)
  
  A.col = IIf(Abs(TangentVelocity) < StaticFrictionVelocity, RGB(255, 64, 64), RGB(64, 255, 64))
	
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
	
	Dim As Vec2 Distance = A.Psn-B.psn
	
  Dim As Vec2 NormalVector = Distance.unit
  
	Dim As Single Distance_ = Distance.dot(NormalVector)
  
  Dim As Vec2 TangentVector = NormalVector.PerpCCW
  
  Dim As Single Radius = A.Radius + B.Radius
  
  Dim As Single Intersection = Distance_-Radius
  
	Dim As Vec2 r1 = A.Radius * -NormalVector
	Dim As Vec2 r2 = B.Radius *  NormalVector
	
	Dim As Vec2 VelocityA = A.vel + A.ang_vel * r1.PerpCCW
	Dim As Vec2 VelocityB = B.vel + B.ang_vel * r2.PerpCCW
	
	Dim As Vec2 Velocity = VelocityA - VelocityB
	
	Dim As Single NormalVelocity = Velocity.Dot(NormalVector)
	Dim As Single TangentVelocity = Velocity.Dot(TangentVector)
	
	Dim As Single FrictionCoefficient = IIf(Abs(TangentVelocity) < StaticFrictionVelocity, (A.StaticFriction + B.StaticFriction)*0.5, (A.DynamicFriction + B.DynamicFriction)*0.5)
  
  Dim As Single Stiffnes = (A.Stiffnes + B.Stiffnes)*0.5
  Dim As Single Damping = (A.Damping + B.Damping)*0.5
  
  Dim As Single IA = r1.Dot(r1)
  Dim As Single IB = r2.Dot(r2)
  
  Dim As Single NormalForce = -(Stiffnes*inv_dt2 * Intersection + Damping*inv_dt * NormalVelocity) / _
  	(A.InverseMass + B.InverseMass)
  
  Dim As Single TangentForce = -(FrictionCoefficient/dt * TangentVelocity) / _
  	(A.inversemass + B.inversemass + A.radiussquared*A.InverseI + B.radiussquared*B.InverseI)
  
  Dim As Vec2 Force = NormalForce*NormalVector + TangentForce*TangentVector
  
  A.Frc += Force
  A.Trq += Force.PerpDot(r1)
  
  B.Frc -= Force
  B.Trq -= Force.PerpDot(r2)
  
End Sub


'Sub BallBallConstraint(ByRef A As ball_type, ByRef B As ball_type)
'	
'	Dim As vec2 normal1 = Vec2( A.cos_ang, A.sin_Ang )
'	Dim As vec2 normal2 = Vec2( B.cos_ang, B.sin_Ang )
'	
'	Dim As Vec2 r1 = A.Psn + normal1 * A.radius
'	Dim As Vec2 r2 = B.Psn - normal2 * B.radius
'	
'	Line(A.Psn.x, A.Psn.y)-(r1.x, r1.y), RGB(0,0,0)
'	Line(B.Psn.x, B.Psn.y)-(r2.x, r2.y), RGB(0,0,0)
'	
'	Dim As Vec2 Distance = r2 - r1
'  	Dim As Vec2 Normal  = Distance.unit
'  	Dim As Vec2 Tangent = Normal.Perp
'
'	''
'	Dim As Single rn1 = Dot(r1, normal)
'	Dim As Single rn2 = Dot(r2, normal)
'	Dim As Single kNormal = a.inverseMass + b.inverseMass + _
'	                        a.inverseI * (Dot(r1, r1) - rn1 * rn1) + _
'	                        b.inverseI * (Dot(r2, r2) - rn2 * rn2)
'	
'	Dim As Single massNormal = 1.0f / kNormal
'	
'	''
'	Dim As Single rt1 = Dot(r1, tangent)
'	Dim As Single rt2 = Dot(r2, tangent)
'	Dim As Single kTangent = a.inverseMass + b.inverseMass + _
'	                         a.inverseI * (Dot(r1, r1) - rt1 * rt1) + _
'	                         b.inverseI * (Dot(r2, r2) - rt2 * rt2)
'	                         
'	Dim As Single massTangent = 1.0f / kTangent
'	
'	Dim As Single NormalForce = -( 0.001 * inv_dt2 * distance.dot(normal) ) * ( massNormal + massTangent )
'  
'   Dim As Single TangentForce '= -(FrictionCoefficient/dt * TangentVelocity) * massTangent
'  
'  Dim As Vec2 Force = NormalForce*Normal '+ TangentForce*Tangent
'  
'  A.Frc += Force
'  A.Trq += Force.PerpDot(r1)
'  
'  B.Frc -= Force
'  B.Trq -= Force.PerpDot(r2)
'	
'End Sub

Sub BallBallConstraint(ByRef A As box_Type, ByRef B As box_Type)
	
	Dim As Vec2 r1, r2
	
	'r1 = Vec2( A.cos_ang, A.sin_ang ).rotateccw( Vec2(  A.wid,  A.hgt ) )
	'r2 = Vec2( B.cos_ang, B.sin_ang ).rotateccw( Vec2( -B.wid, -B.hgt ) )
	
	r1 = Vec2( A.cos_ang, A.Sin_Ang ).rotateCCW( Vec2(  40.0, 0.0 ) )
	r2 = Vec2( B.cos_ang, B.Sin_Ang ).rotateCCW( Vec2( -40.0, 0.0 ) )
	
	'r1 = -A.Radius * Vec2( -A.cos_ang, A.Sin_Ang )
	'r2 =  B.Radius * Vec2( -B.cos_ang, B.Sin_Ang )
	
	'Line(A.Psn.x, A.Psn.y)-(A.Psn.x + r1.x, A.Psn.y + r1.y), RGB(0,0,0)
	'Line(B.Psn.x, B.Psn.y)-(B.Psn.x + r2.x, B.Psn.y + r2.y), RGB(0,0,0)
	
	Dim As Vec2 Distance = (A.Psn + r1) - (B.Psn + r2)
	
  Dim As Vec2 NormalVector = Distance.unit
  Dim As Vec2 TangentVector = NormalVector.PerpCCW
  
	Dim As Single NormalDistance  = Distance.dot(NormalVector)
	Dim As Single TangentDistance = Distance.dot(TangentVector)
	
	Dim As Single rn1 = r1.dot(NormalVector)
	Dim As Single rn2 = r2.dot(NormalVector)
	
	Dim As Single rt1 = r1.dot(TangentVector)
	Dim As Single rt2 = r2.dot(TangentVector)
	
	Dim As Vec2 VelocityA = A.vel + A.ang_vel * r1.PerpCCW
	Dim As Vec2 VelocityB = B.vel + B.ang_vel * r2.PerpCCW
	
	Dim As Vec2 Velocity = VelocityA - VelocityB
	
	Dim As Single NormalVelocity  = Velocity.Dot(NormalVector)
	Dim As Single TangentVelocity = Velocity.Dot(TangentVector)
	
  Dim As Single Stiffnes = 0.25
  Dim As Single Damping  = 0.75
  
  Dim As Single IA = r1.PerpDot( NormalVector )
  Dim As Single IB = r2.PerpDot( NormalVector )
  
  
  'Dim As Mat22 K1
  'K1.C1.x = A.InverseMass + B.Inversemass : K1.C2.x = 0.0
  'K1.C1.y = 0.0                           : K1.C2.y = A.InverseMass + B.Inversemass
  '
  'Dim As Mat22 K2
  'K2.C1.x =  A.InverseI * r1.y * r1.y : K2.C2.x = -A.InverseI * r1.x * r1.y
  'K2.C1.y = -A.InverseI * r1.x * r1.y : K2.C2.y =  A.InverseI * r1.x * r1.x
  '
  'Dim As Mat22 K3
  'K3.C1.x =  B.InverseI * r2.y * r2.y : K3.C2.x = -B.InverseI * r2.x * r2.y
  'K3.C1.y = -B.InverseI * r2.x * r2.y : K3.C2.y =  B.InverseI * r2.x * r2.x 
  '
  'Dim As Mat22 K = K1 + K2 + K3
  '
  'Dim As Mat22 M = K.inverse()
  '
  'Dim As Single NormalMass = 1.0 / ( A.InverseMass + B.Inversemass +_
  '                                   A.InverseI * ( r1.dot(r1) - rn1 * rn1) +_
  '                                   B.inverseI * ( r2.dot(r2) - rn2 * rn2) )
  '
  'Dim As Single TangentMass = 1.0 / ( A.InverseMass + B.Inversemass +_
  '                                    A.InverseI * ( r1.dot(r1) - rt1 * rt1) +_
  '                                    B.inverseI * ( r2.dot(r2) - rt2 * rt2) )
  
  'body1->invI * (Dot(r1, r1) - rn1 * rn1) + body2->invI * (Dot(r2, r2) - rn2 * rn2)
  'body1->invI * (Dot(r1, r1) - rt1 * rt1) + body2->invI * (Dot(r2, r2) - rt2 * rt2)
  
  ''
  Dim As Vec2 Force = ( -( Stiffnes * inv_dt2 * NormalDistance + Damping * inv_dt * NormalVelocity ) /_ 
  	                       (A.InverseMass + B.Inversemass + A.InverseI*IA*IA + B.InverseI*IB*IB ) ) * NormalVector
  
  'Dim As Single NormalForce = -( Stiffnes * inv_dt2 * NormalDistance + Damping * inv_dt * NormalVelocity ) * NormalMass
  
  'Dim As Single TangentForce = -( Stiffnes * inv_dt2 * TangentDistance + Damping * inv_dt * TangentVelocity ) * TangentMass
  
  'Dim As Vec2 Force = NormalForce * NormalVector + TangentForce * TangentVector
  
  'Dim As Vec2 Force = - ( Distance * inv_dt2 * Stiffnes + Velocity * inv_dt * Damping ) * M

  
  A.Frc += Force
  A.Trq += Force.PerpDot( -r1 )
  
  B.Frc -= Force
  B.Trq -= Force.PerpDot( -r2 )
  
  'Locate 4, 4: Print M.c1.x ; M.c1.y ; M.c2.x ; M.c2.y
  
End Sub

Sub BallPointConstraint(ByRef A As ball_type, ByRef P As Vec2)
		
	Dim As Vec2 Distance = A.Psn  - P
	
  Dim As Vec2 NormalVector = Distance.unit
  
	Dim As Single Distance_ = Distance.dot(NormalVector) - A.Radius
	
  Dim As Vec2 TangentVector = NormalVector.PerpCCW
  
  Dim As Vec2 CP = -A.Radius * NormalVector
	
	Dim As Vec2 Velocity = A.vel + A.ang_vel * CP.PerpCCW
	
	Dim As Single NormalVelocity  = Velocity.Dot(NormalVector)
	Dim As Single TangentVelocity = Velocity.Dot(TangentVector)
	
  Dim As Single Stiffnes = 1.0
  Dim As Single Damping  = 1.0
  Dim As Single TangentDamping  = 0.0
  
  'Dim As Single IA = CP.Dot(TangentVector)
  
  Dim As Single NormalForce = -(Stiffnes*inv_dt2 * Distance_ + Damping*inv_dt * NormalVelocity) / _
  	(A.inversemass)
  
  Dim As Single TangentForce = -(TangentDamping*inv_dt * TangentVelocity) / _
  	(A.RadiusSquared*A.InverseI)
  
  'Dim As Vec2 Force = NormalForce*NormalVector + TangentForce*TangentVector
  
  A.Frc += NormalForce*NormalVector
  A.Trq += TangentForce*TangentVector.PerpDot(CP)
  
End Sub

'Sub BallPointConstraint(ByRef A As ball_type, ByRef P As Vec2)
'	
'	Dim As Vec2 CP
'	
'	CP.x = -A.Radius * A.cos_ang
'	CP.y = -A.Radius * A.sin_ang
'		
'	Dim As Vec2 Distance = (A.Psn + CP) - P
'	
'  Dim As Vec2 NormalVector = Distance.unit
'  
'	Dim As Single Distance_ = Distance.dot(NormalVector)
'  Dim As Vec2 TangentVector = NormalVector.Perp
'	
'	Dim As Vec2 Velocity = A.vel + A.ang_vel * CP.Perp
'	
'	Dim As Single NormalVelocity  = Velocity.Dot(NormalVector)
'	Dim As Single TangentVelocity = Velocity.Dot(TangentVector)
'	
'  Dim As Single Stiffnes = 0.001
'  Dim As Single Damping  = 0.5
'  
'  Dim As Single IA = CP.PerpDot(NormalVector)
'  
'  Dim As Vec2 Force = (-(Stiffnes*inv_dt2 * Distance_ + Damping*inv_dt * NormalVelocity) / _
'  	(A.inversemass + IA*IA*A.InverseI)) * NormalVector
'  
'  A.Frc += Force
'  A.Trq += Force.PerpDot(CP)
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

Sub Integrate()
  
  For A As Integer = 0 To NumBalls-1
    With ball[A]
    	
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
      
      'End if
      
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

 Cls
 
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
		
		Dim As Vec2 vertex1 = .psn + Vec2( .cos_ang, .sin_ang ).rotateCCW( Vec2(  .wid,  .hgt ) )
		Dim As Vec2 vertex2 = .psn + Vec2( .cos_ang, .sin_ang ).rotateCCW( Vec2(  .wid, -.hgt ) )
		Dim As Vec2 vertex3 = .psn + Vec2( .cos_ang, .sin_ang ).rotateCCW( Vec2( -.wid, -.hgt ) )
		Dim As Vec2 vertex4 = .psn + Vec2( .cos_ang, .sin_ang ).rotateCCW( Vec2( -.wid,  .hgt ) )
		
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
 
  ScreenCopy()
  
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
