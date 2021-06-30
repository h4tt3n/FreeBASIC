'******************************************************************************'
'
'  Michael "h4tt3n" Nissen's damped spring tutorial, nov 2011
'
'	Description:
'  
'  Damped angular spring simulation. This update includes automatic calculation 
'  of highest allowable spring stiffnes and damping coefficients, a physically 
'  correct calculation of angular spring force, and angular damping.
'
'  Controls:
'  
'  -Press up / down arrows to change spring rest lengths
'  -Press left / right arrows to change spring rest angles
'  -Press comma / period to rotate body
'  -Press esc to quit
'  
'  Todo-list:
'
'  -add mouse interaction
'  -verlet integration version
'  -impulse version
'	-translate to c++
'
'
'******************************************************************************'

'' include 2d vector library
#Include Once "vec2_07.bi"
 
'' define constants. Play around with these and see what happens!
Const As float Pi                = 4*Atn(1)       '' pi (better not change ^^)
Const As float TwoPi             = 2*pi         '' two pi
Const As integ Scrn_Wid          = 800          '' screen width
Const As integ Scrn_Hgt          = 600          '' screen height
const As integ Rest_Fps          = 60               ''  ideal framerate
Const As integ PhysicsSteps      = 1             '' number of physics iterations per game loop
Const As float Timestep          = 1/Rest_Fps      '' timestep per game loop
Const As float Dt                = TimeStep/PhysicsSteps '' timestep / physics iteration
Const As float DtSqrd            = Dt*Dt
Const As float invDt             = 1/Dt 
Const As float invDtSqrd         = 1/DtSqrd 
Const As integ NumMasses         = 8           '' number of particles in body
Const As float Mass_Min          = 1           '' smallest possible particle mass
Const As float Mass_Max          = 4           '' biggest possible particle mass
Const As float Linear_Stiffnes   = 0.5          '' linear spring stiffnes
Const As float Linear_Damping    = 0.25         '' linear spring damping
Const As float Angular_Stiffnes  = 0.0          '' angular spring stiffnes
Const As float Angular_damping   = 0.0         '' angular spring damping
Const As float Delta_Angle       = (1/NumMasses)*Timestep*TwoPi '' spring angle step
Const As float Delta_Length      = 1.01         '' spring length step
Const As float fr                = 0.25         '' 
Const As float Gravity           = 0'3200         '' 
Const As float RotationTorque    = 10         '' 

'' define types
Type PointMassType
 As float Mass   '' particle mass
 As float Density  '' density
 As float Radius  '' radius
 As vec2f Frc   '' force vector
 As vec2f Vel   '' velocity vector
 As vec2f Psn   '' position vector
 As vec2f ComDist  '' distance to soft body center of mass vector 
End Type

Type LinearSpringType
 As PointMassType Ptr PointMassA  '' point mass 1 pointer
 As PointMassType Ptr PointMassB  '' point mass 2 pointer
 As float Mass                    '' spring total mass
 As float Length                  '' spring length scalar
 As float RestLength              '' spring rest length scalar
 As float Stiffnes                '' spring stiffnes
 As float Damping                 '' spring damping
 As float AngularVelocity         '' angular velocity
 As float AngularMomentum         '' angular momentum
 As float MomentOfInertia         '' moment of inertia
 As vec2f Vel                     '' velocity vector
 As vec2f Lng                     '' spring length vector
 As vec2f NormalizedLng           '' normalized length vector
 As vec2f Com_Psn                 '' center of mass position vector
 As vec2f Com_Vel                 '' center of mass velocity vector
End Type

Type AngularSpringType
 As LinearSpringType Ptr LinearSpringA  '' linear spring 1 pointer
 As LinearSpringType Ptr LinearSpringB  '' linear spring 2 pointer
 As vec2f Ang              '' angle vector (contains sine and cosine angle)
 As vec2f RestAng            '' rest angle vector (contains sine and cosine angle)
 As float RestAngle           '' spring rest angle
 As float Stiffnes            '' spring stiffnes
 As float Damping            '' spring damping
End Type

Type SoftBodyType
 As float Mass              '' soft body total mass
 As float Linear_Velocity        '' linear velocity
 As float Linear_Momentum        '' linear momentum
 As float AngularVelocity        '' angular velocity
 As float AngularMomentum        '' angular momentum
 As float MomentOfInertia        '' moment of inertia
 As vec2f Com_Psn            '' center of mass position vector
 As vec2f Com_Vel            '' center of mass velocity vector
 As integ NumPointMasses         '' number of point masses
 As integ NumLinearSprings        '' number of linear springs
 As integ NumAngularSprings       '' number of angular springs
 As PointMassType Ptr PointMass     '' particle pointer
 As LinearSpringType Ptr LinearSpring  '' linear spring pointer
 As AngularSpringType Ptr AngularSpring '' angular spring pointer
 
 Declare Sub GetCenterOfMass()
 Declare Sub GetAngularMomentum()
 Declare Sub GetMomentOfInertia()
 
End Type

Type SimulationType
 
 Declare Constructor()
 Declare Destructor()
 
 As float FPS_Timer, Next_Frame
 As integ FPS, FPS_Counter, Frame
 
 As integ Num_Soft_Bodies
 
 As SoftBodyType Ptr Body
 
 Declare Sub RunSimulation()
 Declare Sub RenderSimulation()
 Declare Sub GetInput()
 Declare Sub GetData()
 Declare Sub SetForce()
 Declare Sub SetPosition()
 Declare Sub SetVelocity()
 Declare Sub Integrate()
 Declare Sub PauseSimulation()
 Declare Sub GetFramerate()
 Declare Sub drawCoilSpring(ByVal p0 As vec2f, ByVal p1 As vec2f, ByVal radius As float, ByVal numCoils As float) 
 
End Type

'' run simulation
Scope: Dim As SimulationType Simulation: End Scope

Constructor SimulationType
 
 '' initiate soft body
 Randomize
 
 Num_Soft_Bodies = 1
 
 If Num_Soft_Bodies > 0 Then
  
  Body = New SoftBodyType[Num_Soft_Bodies]
  
  For i As integ = 0 To Num_Soft_Bodies-1
   With Body[i]
    
    .NumPointMasses   = NumMasses
    .NumLinearSprings  = .NumPointMasses-1
    .NumAngularSprings = .NumLinearSprings-1
   
    .PointMass   = New PointMassType[.NumPointMasses]
    .LinearSpring  = New LinearSpringType[.NumLinearSprings]
    .AngularSpring  = New AngularSpringType[.NumAngularSprings]
   
    '' initiate particles
    For j As integ = 0 To .NumPointMasses-1
     Dim As float Angle = (j/.NumPointMasses-1)*TwoPi
     Dim As float Distance = 100
     With .PointMass[j]
      .Mass = Mass_Min+Rnd*(Mass_Max-Mass_Min)
      .Density = 0.004
      .Radius = ((.Mass/.Density)/((4/3)*Pi))^(1/3)
      .Psn.X = Scrn_Wid\2 + Cos(Angle)*Distance
      .Psn.Y = Scrn_Hgt\2 + Sin(Angle)*Distance
      .Psn += randomise(10) '' <--- uncomment to apply random mass positions
     End With
    Next
    
    '' initiate linear springs
    For j As integ = 0 To .NumLinearSprings-1
     With .LinearSpring[j]
      .Stiffnes = Linear_Stiffnes
      .Damping = Linear_Damping
      .PointMassA = @Body[i].PointMass[j]
      .PointMassB = @Body[i].PointMass[j+1]
      .Lng = .PointMassA->Psn - .PointMassB->Psn
      .Length = .Lng.magnitude
      .RestLength = .Length
      .NormalizedLng = .Lng/.Length
      .Mass = .PointMassA->Mass + .PointMassB->Mass
     End With
    Next
    
    '' initiate angular springs
    For j As integ = 0 To .NumAngularSprings-1
     With .AngularSpring[j]
      .Stiffnes = Angular_Stiffnes
      .LinearSpringA = @Body[i].LinearSpring[j]
      .LinearSpringB = @Body[i].LinearSpring[j+1]
      .RestAng.x = .LinearSpringA->NormalizedLng.dot(.LinearSpringB->NormalizedLng)
      .RestAng.y = .LinearSpringA->NormalizedLng.dotnormal(.LinearSpringB->NormalizedLng)
      .RestAngle = ATan2(.RestAng.y, .RestAng.x)
     End With
    Next
    
    '' get soft body total mass
    For j As integ = 0 To .NumPointMasses-1
     .Mass += .PointMass[j].Mass
    Next
    
   End With
  Next
  
  ScreenRes Scrn_Wid, Scrn_Hgt, 32
  Color RGB(0, 0, 0), RGB(192, 192, 255)
  WindowTitle"Damped angular spring"
  
  Fps_Timer = Timer
  
  RunSimulation()
  
 EndIf
 
End Constructor

Destructor SimulationType
 
 '' deallocate memory
 If Num_Soft_Bodies Then
  For i As integ = 0 To Num_Soft_Bodies-1
   With Body[i]
    Delete[] .PointMass
    Delete[] .LinearSpring
    Delete[] .AngularSpring
   End With
  Next
  Delete[] Body
 EndIf
 
 End
 
End Destructor

Sub SimulationType.RunSimulation()
 
 '' main program loop
 Do
  GetInput()
  Integrate()
  RenderSimulation()
  GetFramerate()
  PauseSimulation()
 Loop Until MultiKey(1)
 
End Sub

Sub SimulationType.RenderSimulation()
 
 '' render simulation to screen
  ScreenLock
    
    Cls 
    
    Frame += 1
    
    ''  print data
    Locate  2, (scrn_wid\8)-10: Print Using "Fps:   ###"; Fps
    Locate  4, (scrn_wid\8)-12: Print Using "Frame: #####"; Frame
    
    With Body[0]
     Locate  2, 2:   print using "             Mass: ########.####"; .mass
     locate  3, 2:   print using "Moment of inertia: ########.####"; .MomentOfInertia
     locate  5, 2:   print using "  Linear momentum: ########.####"; .Linear_momentum
     locate  6, 2:   print using " Angular momentum: ########.####"; .AngularMomentum
     Locate  8, 2:   print using "  Linear velocity: ########.####"; .linear_velocity
     locate  9, 2:   print using " Angular velocity: ########.####"; .AngularVelocity
     
    End With
    
  For i As integ = 0 To Num_Soft_Bodies-1
   With Body[i]
    
    '' draw soft body center of mass
    Circle(.Com_Psn.X, .Com_Psn.Y), 6, RGB(0, 0, 0),,, 1
     
      ''  draw springs
      For j As integ = 0 To .NumLinearSprings-1
        With .LinearSpring[j]
          Line (.PointMassA->Psn.X, .PointMassA->Psn.Y)-(.PointMassB->Psn.X, .PointMassB->Psn.Y), RGB(32, 128, 32)
          '' draw spring center of mass
          Circle(.Com_Psn.X, .Com_Psn.Y), 4, RGB(0, 0, 0),,, 1
        End With
      Next
      
      ''  draw masses
    For j As integ = 0 To .NumPointMasses-1
     With .PointMass[j]
          Circle(.Psn.X, .Psn.Y), .Radius, RGB(0, 0, 0),,, 1, F
          Circle(.Psn.X, .Psn.Y), .Radius-1, RGB(255, 64, 64),,, 1, F
     End With
    Next
  
   End With
  Next
   
  ScreenUnLock
 
End Sub

Sub SimulationType.GetInput()
 
 ''  up arrow  ->  increase spring length
  If Multikey(&h48) Then
  For i As integ = 0 To Num_Soft_Bodies-1
   With Body[i]
      For j As integ = 0 To .NumLinearSprings-1
        With .LinearSpring[j]
          .RestLength *= Delta_Length
        End With
      Next
   End With
  Next
  End If
  
  ''  down arrow  -> decrease spring length
  If Multikey(&h50) Then
  For i As integ = 0 To Num_Soft_Bodies-1
   With Body[i]
      For j As integ = 0 To .NumLinearSprings-1
        With .LinearSpring[j]
          .RestLength /= Delta_Length
        End With
      Next
   End With
  Next
  End If
  
  ''  left arrow  ->  decrease angular spring angle
  If Multikey(&h4b) Then
  For i As integ = 0 To Num_Soft_Bodies-1
   With Body[i]
      For j As integ = 0 To .NumAngularSprings-1
        With .AngularSpring[j]
          .RestAngle -= Delta_Angle
          If .RestAngle < -Pi Then .RestAngle += TwoPi
          If .RestAngle >  Pi Then .RestAngle -= TwoPi
          .RestAng = vec2f(Cos(.RestAngle), sin(.RestAngle))
        End With
      Next
   End With
  Next
  End If
  
  ''  Right arrow  ->  increase angular spring angle
  If Multikey(&h4d) Then
  For i As integ = 0 To Num_Soft_Bodies-1
   With Body[i]
      For j As integ = 0 To .NumAngularSprings-1
        With .AngularSpring[j]
          .RestAngle += Delta_Angle
          If .RestAngle < -Pi Then .RestAngle += TwoPi
          If .RestAngle >  Pi Then .RestAngle -= TwoPi
          .RestAng = vec2f(Cos(.RestAngle), sin(.RestAngle))
        End With
      Next
   End With
  Next
  End If
  
  ''  comma ->  rotate left
  If Multikey(&h33) Then
  For i As integ = 0 To Num_Soft_Bodies-1
   With Body[i]
      For j As integ = 0 To .NumPointMasses-1
        With .PointMass[j]
          .Frc += .ComDist.normal * RotationTorque * .Mass
        End With
      Next
   End With
  Next
  End If
  
  ''  period ->  rotate right
  If Multikey(&h34) Then
  For i As integ = 0 To Num_Soft_Bodies-1
   With Body[i]
      For j As integ = 0 To .NumPointMasses-1
        With .PointMass[j]
          .Frc -= .ComDist.normal * RotationTorque * .Mass
        End With
      Next
   End With
  Next
  End If

End Sub

Sub SimulationType.GetData()
 
 '' get soft body data
 For i As integ = 0 To Num_Soft_Bodies-1
  With Body[i]
   
   .GetCenterOfMass()
   
   '' get particle distance to soft body center of mass
   For j As integ = 0 To .NumPointMasses-1
     With .PointMass[j]
       .ComDist = .Psn-Body[i].Com_Psn
     End With
   Next
   
   '' get various linear spring data
   For j As integ = 0 To .NumLinearSprings-1
    With .LinearSpring[j]
     .Vel = .PointMassA->Vel - .PointMassB->Vel
     .Lng = .PointMassA->Psn - .PointMassB->Psn
     .Length = magnitude(.Lng)
     If .Length > 0 Then
      .NormalizedLng = .Lng/.Length
     Else
      .NormalizedLng = vec2f(0, 0)
     End If
        .Com_Psn = (.PointMassA->Mass*.PointMassA->Psn+.PointMassB->Mass*.PointMassB->Psn)/.Mass
        .Com_Vel = (.PointMassA->Mass*.PointMassA->Vel+.PointMassB->Mass*.PointMassB->Vel)/.Mass
        
        '' get angular momentum, moment of inertia, and angular velocity
      .AngularVelocity = 0.0
      .MomentOfInertia = 0.0
      
      Dim As vec2f ComDist = .Com_Psn-.PointMassA->Psn
      Dim As vec2f Com_Vel = .Com_Vel-.PointMassA->Vel
      
       .AngularVelocity += ComDist.dotnormal(Com_Vel) * .PointMassA->Mass
       .MomentOfInertia += ComDist.magnitudesquared *.PointMassA->Mass
        
       ComDist = .Com_Psn-.PointMassB->Psn
       Com_Vel = .Com_Vel-.PointMassB->Vel
        
       .AngularVelocity += ComDist.dotnormal(Com_Vel) * .PointMassB->Mass
       .MomentOfInertia += ComDist.magnitudesquared*.PointMassB->Mass
     
      .AngularVelocity /= .MomentOfInertia
        
    End With
   Next
  
   '' get angular spring angle
   For j As integ = 0 To .NumAngularSprings-1
    With .AngularSpring[j]
     .ang.x = .LinearSpringA->NormalizedLng.dot(.LinearSpringB->NormalizedLng)
     .ang.y = .LinearSpringA->NormalizedLng.dotnormal(.LinearSpringB->NormalizedLng)
    End With
   Next
   
   '' get linear velocity and linear momentum
   .Linear_velocity = .Com_Vel.magnitude
    .Linear_momentum = .Linear_velocity*.Mass
    
    '' get angular momentum, moment of inertia, and angular velocity
    .AngularMomentum = 0.0
    .MomentOfInertia = 0.0
    For j As integ = 0 To .NumPointMasses-1
     With .PointMass[j]
        Body[i].AngularMomentum += .ComDist.dotnormal(.Mass*.Vel)
        Body[i].MomentOfInertia += .ComDist.magnitudesquared*.Mass
     End With
    next
    .AngularVelocity = .AngularMomentum/.MomentOfInertia
   
  End With
 Next
 
End Sub

Sub SimulationType.SetForce()
 
 For i As integ = 0 To Num_Soft_Bodies-1
  With Body[i]
   
   '' reset acceleration vector
   'For j As integ = 0 To .NumPointMasses-1
   ' With .PointMass[j]
   '  .Acc = vec2f(0, Gravity)
   ' End With
   'Next
   
   '' set damped linear spring force
   For j As integ = 0 To .NumLinearSprings-1
    With .LinearSpring[j]
     
     '' delta position
     Dim As float Delta_Psn = .Length-.RestLength
     
     '' delta velocity
     'Dim As float Delta_Vel = dot(.Vel, .NormalizedLng)
     Dim As float Delta_Vel = .Vel.dot(.NormalizedLng)
     
     '' scalar spring force
     Dim As float Force = -(.Stiffnes*invDtSqrd * Delta_Psn + .Damping*invDt * Delta_Vel ) /_
      (1/.PointMassA->Mass+1/.PointMassB->Mass)
     
     '' convert force to acceleration and apply to masses
     .PointMassA->Frc += Force*.NormalizedLng
     .PointMassB->Frc -= Force*.NormalizedLng
     
    End With
   Next
  
   '' set damped angular spring force
   For j As integ = 0 To .NumAngularSprings-1
    With .AngularSpring[j]
     
     '' delta angle
     Dim As float Cos_Angle = .RestAng.dot(.Ang)
     Dim As float Sin_Angle = .RestAng.dotnormal(.Ang)
     'Dim As float Angle = ATan2(Sin_Angle, Cos_Angle)
     
     '' delta angular velocity
     Dim As float Angular_Vel = .LinearSpringB->AngularVelocity-.LinearSpringA->AngularVelocity
     
     '' calculate spring torque (based on angle)
     'Dim As float Torque  = -( Angular_Stiffnes * invDtSqrd * Angle + Angular_Damping * invDt * Angular_Vel) /_
     ' ( 1.0/.LinearSpringA->MomentOfInertia + 1.0/.LinearSpringB->MomentOfInertia )
     
     '' calculate spring torque (based on sine angle. Less efficient but faster.)
     Dim As float Torque  = -( Angular_Stiffnes * invDtSqrd * Sin_Angle + Angular_Damping * invDt * Angular_Vel) /_
      (1/.LinearSpringA->MomentOfInertia+1/.LinearSpringB->MomentOfInertia)
     
     '' convert torque to force and apply to masses
     Dim As vec2f ComDist = .LinearSpringA->Com_Psn - .LinearSpringA->PointMassA->Psn
     .LinearSpringA->PointMassA->Frc -= Torque / .LinearSpringA->MomentOfInertia * ComDist.normal * .LinearSpringA->PointMassA->Mass
     
     ComDist = .LinearSpringA->Com_Psn - .LinearSpringA->PointMassB->Psn
     .LinearSpringA->PointMassB->Frc -= Torque / .LinearSpringA->MomentOfInertia * ComDist.normal * .LinearSpringA->PointMassB->Mass
     
     ComDist = .LinearSpringB->Com_Psn - .LinearSpringB->PointMassA->Psn
     .LinearSpringB->PointMassA->Frc += Torque / .LinearSpringB->MomentOfInertia * ComDist.normal * .LinearSpringB->PointMassA->Mass
     
     ComDist = .LinearSpringB->Com_Psn - .LinearSpringB->PointMassB->Psn
     .LinearSpringB->PointMassB->Frc += Torque / .LinearSpringB->MomentOfInertia * ComDist.normal * .LinearSpringB->PointMassB->Mass
     
    End With
   Next
   
  End With
 Next
 
End Sub

Sub SimulationType.SetPosition()
 
 '' set new position
 For i As integ = 0 To Num_Soft_Bodies-1
  With Body[i]
   For j As integ = 0 To .NumPointMasses-1
    With .PointMass[j]
     .Psn += .Vel*Dt
    End With
   Next
  End With
 Next
 
End Sub

Sub SimulationType.SetVelocity()
 
 '' set new velocity
 For i As integ = 0 To Num_Soft_Bodies-1
  With Body[i]
   For j As integ = 0 To .NumPointMasses-1
    With .PointMass[j]
     .Vel += (.Frc/.Mass)*dt
     .Frc = vec2f(0, Gravity * .Mass)
    End With
   Next
  End With
 Next
 
End Sub

Sub SimulationType.Integrate()
 
 '' iterative velocity verlet algorithm
 '' increase physicssteps to increase stability
 For i As integ = 1 To PhysicsSteps
  
  GetData()
  SetForce()
  SetVelocity()
  SetPosition()
  
  '' keep particles inside screen
  For i As integ = 0 To Num_Soft_Bodies-1
   With Body[i]
    For j As integ = 0 To .NumPointMasses-1
     With .PointMass[j]
      If .psn.x > Scrn_Wid-1 - .Radius Then .psn.x = Scrn_Wid-1 - .Radius: .vel.x = -.vel.x: .vel *= fr: End If
      If .psn.x < .Radius Then .psn.x = .Radius: .vel.x = -.vel.x:  .vel *= fr: End If
      If .psn.y > Scrn_Hgt-1 - .Radius Then .psn.y = Scrn_Hgt-1 - .Radius: .vel.y = -.vel.y: .vel *= fr: End If
      If .psn.y < .Radius Then .psn.y = .Radius: .vel.y = -.vel.y:  .vel *= fr: End If
     End With
    Next
   End With
  Next
  
 Next
 
End Sub

Sub SimulationType.GetFramerate()
 
 If Timer < Fps_Timer Then
    Fps_Counter += 1
 Else
    Fps = Fps_Counter
    Fps_Counter = 1
    Fps_Timer += 1
 End If
 
End Sub

Sub SimulationType.PauseSimulation()
 
 Dim As integ Sleep_Time = (Next_Frame-Timer)*1000
 
 '' clamp sleep time
 If Sleep_Time < 1  Then Sleep_Time = 1
 If Sleep_Time > 1000 Then Sleep_Time = 1000
 
 Sleep Sleep_Time, 1
 'Sleep 500, 1
 
   Do: Loop While Timer < Next_Frame
  
 	Next_Frame = Timer + Timestep
 
End Sub

Sub SoftBodyType.GetCenterOfMass()
 
 '' get soft body center of mass position and velocity
 With This
  
  .Com_Psn = vec2f(0, 0)
  .Com_Vel = vec2f(0, 0)
  For j As integ = 0 To .NumPointMasses-1
   .Com_Psn += .PointMass[j].Psn*.PointMass[j].Mass
   .Com_Vel += .PointMass[j].Vel*.PointMass[j].Mass
  Next
  .Com_Psn /= .Mass
  .Com_Vel /= .Mass
  
 End With
 
End Sub

Sub SoftBodyType.GetAngularMomentum()
 
End Sub

Sub SoftBodyType.GetMomentOfInertia()
 
End Sub

''
Sub SimulationType.drawCoilSpring(ByVal p0 As vec2f, ByVal p1 As vec2f, ByVal radius As float, ByVal numCoils As float) 
  
  ''  very fast coil spring drawing function
  
  ''  these constants decide the graphic quality of the coil spring
  Const As Integer  vertexLength = 8                ''  desired face coilLength in pixels
  Const As Integer  maxVertices   = 2048              ''  maximum number of faces per coil
  Const As Integer  minVertices   = 16               ''  minimum number of faces per coil
  Const As uinteger colour       = RGB(32, 255, 32) ''  coil colour
  
  ''  number of faces in ellipse
  Dim As Integer numVertices     = cint( ( 2.0 * pi * radius ) / vertexLength )
  
  ''  clamp number of faces
  If numVertices > maxVertices Then numVertices = maxVertices
  If numVertices < minVertices Then numVertices = minVertices
  
  ''  keep number of faces divisible by 4
  numVertices -= numVertices mod 4
  
  ''
  Dim As vec2f   springN    = (p1 - p0).normalised()
  Dim As Integer numSteps = cint(numVertices * ( numCoils + 0.5 ) )
  Dim As Float   coilLength   = ( p1 - p0 ).magnitude - 2.0 * radius 
  Dim As float   stepSize = coilLength / numSteps
  Dim As Float   Theta    = (2.0 * pi) / numVertices
  Dim As vec2f   ThetaN   = vec2f(Cos(Theta), Sin(theta))
  Dim As vec2f   angle		= -springN 
  Dim As vec2f   pnt      = p0
  Dim As vec2f   position = p0 - Radius * angle
  
  ''  draw ellipse
  PSet(pnt.x, pnt.y), colour
  
  For i As Integer = 1 To numSteps
  	
  	position += stepSize * springN
    
    ''  increase angle by Theta
    Angle = rotate(angle, ThetaN)

    ''	
    pnt = position + Radius * angle
    
    Line -(pnt.x, pnt.y), colour
    'PSet(pnt.x, pnt.y), colour
    
  Next
  
End Sub