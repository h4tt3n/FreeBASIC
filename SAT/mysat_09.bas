''****************************************************************************************
''
''  separating axis theorem collision detection, Mike "h4tt3n", march 2012
''  test # 09 , rectangle collision detection
''
''
''  To-do:
''
''  make it work first - worry about speed optimizations later!
''  write point-box SAT function
''  write point-box SAT function with MTV / MTD
''  de-oop to test for possible speed gain
''  optimize by precomputing constant box - self projection values
''
''  press "esc" to quit
''  
''  Reference:
''  http://www.geometrictools.com/Documentation/MethodOfSeparatingAxes.pdf
''  http://www.metanetsoftware.com/technique/tutorialA.html
''  http://content.gpwiki.org/index.php/VB:Tutorials:Building_A_Physics_Engine:Basic_Intersection_Detection
''  http://www.sevenson.com.au/actionscript/sat/
''  http://www.codeproject.com/Articles/15573/2D-Polygon-Collision-Detection
''
''****************************************************************************************

''  
#Include Once "vec2_07.bi"
#Include Once "fbgfx.bi"

''  
Const As float  pi                      = 4*Atn(1)                                      ''  pi
Const As Integ  Numboxes                = 200                                               ''  number of rigid bodies
Const As float  rest_fps                = 60                            ''  ideal framerate
Const As Double timestep                = 1/rest_fps                                    ''  timestep per program loop
Const As float  pickdist                = 128                                                   ''  

''
Type VertexType
  As vec2f Init_Psn, Psn
End Type

Type ProjectionType
    As float tMin
    As Float tMax
    As Vec2f pMin
    As Vec2f pMax
End Type

Type BoxType
	
	
	'Declare function ComputeProjection(ByRef A0 As vec2f, ByRef A1 As vec2f) As ProjectionType
	
  As UInteger col
  As vec2f Psn, Ang
  As Float Hgt, Wid, angle
   As integ Num_vertices
  As VertexType Ptr vertex
End Type



''  
Dim Shared As BoxType Ptr box
Dim Shared As Integ FPS, FPS_Counter
Dim Shared As Double FPS_Timer, t0, Sleep_Time
Dim Shared As vec2i m, mo
Dim Shared As Integ mb, mbo, picked, scrn_wid, scrn_hgt

Declare Sub Mouse()
Declare Sub Render()
Declare Sub Pause()
Declare Function ProjectionsSeparated(ByRef P1 As ProjectionType, ByRef P2 As ProjectionType) As Integer 

'Declare Sub ComputeMinMax(ByRef Box As BoxType, ByRef A0 As vec2f, ByRef A1 As vec2f, ByRef Min As float, ByRef Max As float)
'
'Declare Function ComputeProjection(ByRef Box As BoxType, ByRef A0 As vec2f, ByRef A1 As vec2f) As ProjectionType
Declare Sub ComputeProjection(ByRef Box As BoxType, ByRef A0 As vec2f, ByRef A1 As vec2f, ByRef Projection As ProjectionType)

Declare Function BoxBoxSAT(ByRef BoxA As BoxType, ByRef BoxB As BoxType) As Integer

''  
box  = new BoxType[Numboxes]

''  set startup condition
ScreenInfo scrn_wid, scrn_hgt
ScreenRes  scrn_wid, scrn_hgt, 32,, fb.GFX_ALPHA_PRIMITIVES Or fb.GFX_FULLSCREEN
WindowTitle "Rigid body dynamics with SAT collision # 09"
'Color RGB(0, 0, 0), RGB(192, 192, 255)
Color RGB(0, 0, 0), RGB(192, 192, 255)

Randomize timer

For A As integ = 0 To Numboxes-1
    
  With box[A]
    .Num_vertices = 4
    .col = RGB(255, 255, 255)
    .Hgt = 16' + Rnd * 16
    .Wid = 32' + Rnd * 64
    
    .psn.x = 50 + Rnd * (scrn_wid - 100)
    .psn.y = 50 + Rnd * (scrn_hgt - 100)
    
    .Angle = Rnd*2*pi
    .Ang = vec2f(Cos(.angle), Sin(.angle)) 
    
    .vertex = New VertexType[.Num_vertices]
    
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
    
    Mouse()
    
    For i2 As Integ = 0 To NumBoxes-2
        For i3 As Integ = i2+1 To NumBoxes-1
            BoxBoxSAT(Box[i2], Box[i3])
        next
    Next
    
    Render()
    
    Pause()
  
Loop Until MultiKey(1)

For A As integ = 0 To Numboxes-1
  With box[A]
        Delete[] .vertex
  End With
Next

Delete[] box

End

''----------------------------------------------------------------------------''


Sub Mouse()
    
    '' update mouse state
    mo = m: mbo = mb: GetMouse m.x, m.y,, mb
    
    If mb = 1 Then
        If Picked = -1 Then
            Dim As Float tempdist = pickdist*pickdist
            For i As Integ = 0 To Numboxes-1
                Dim As Float dx         = m.x-box[i].Psn.x  :   If Abs(dx) > pickdist Then Continue For
                Dim As Float dy         = m.y-box[i].Psn.y  :   If Abs(dy) > pickdist Then Continue For
                Dim As Float dsqrd = dx*dx+dy*dy                :   If dsqrd   > tempdist Then Continue For
                tempdist = dsqrd
                picked = i
            Next
        End If
    Else
        picked = -1
    End If
    
    If picked <> -1 Then
        With box[picked]
            .psn += (m - mo)
        End With
    EndIf
    
End Sub

Sub Render()
  
  ScreenLock
  
    Cls
    
    For A As integ = 0 To NumBoxes-1
        With box[A]
            
            'Draw String (.psn.x, .psn.y), Str(A), RGB(0, 0, 0)
            
            For B As integ = 0 To .Num_Vertices-1
                
                Dim As integ C = (B+1) Mod .Num_Vertices
                
                Dim As vec2f pnt1 = .psn + .vertex[B].psn
                Dim As vec2f pnt2 = .psn + .vertex[C].psn
                
                Line(pnt1.x, pnt1.y)-(pnt2.x, pnt2.y), .col
                
            Next
            
            'Paint(.psn.x, .psn.y), .col
            
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
    
    Sleep_Time = ( ( timestep - (Timer-t0) ) * 1000) - 1
  
    If Sleep_Time < 0    Then Sleep_Time = 0
    If Sleep_Time > 1000 Then Sleep_Time = 1000
  
    Sleep Sleep_Time, 1
    
    Do While timestep > (Timer-t0): Loop
    
    t0 = Timer
  
End Sub

''  functions
Function ProjectionsSeparated(ByRef P1 As ProjectionType, ByRef P2 As ProjectionType) As Integer 
	
	return (P1.tmin > P2.tmax) Or (P2.tmin > P1.tmax)
	
End Function

Sub ComputeMinMax(ByRef Box As BoxType, ByRef A0 As vec2f, ByRef A1 As vec2f, ByRef Min As float, ByRef Max As float)
    
    Dim As vec2f A = (A1 - A0).normal                           '' axis
    Dim As vec2f B = (Box.Psn + Box.vertex[0].psn) - A0
    Dim As float t = B.dot(A)' / A.dot(A)
    'Dim As Vec2f p = A0 + t * A
    
    Min = t
    Max = t
    
    'Print 0, t, B.dot(A), A.dot(A)
    'Line(Box.Psn.x + Box.vertex[0].psn.x, Box.Psn.y + Box.vertex[0].psn.y)-(p.x, p.y), RGBA(255, 255, 255, 32)
    'Circle(p.x, p.y), 2, RGBA(255, 32, 32, 255),,, 1, F
    
    For i As Integer = 1 To Box.Num_vertices-1
        
        B = (Box.Psn + Box.vertex[i].psn) - A0
        t = B.dot(A)' / A.dot(A)
        'p = A0 + t * A
        
        If Min > t Then Min = t
        If Max < t Then Max = t
        
        'Print i, t, B.dot(A), A.dot(A)
        'Line(Box.Psn.x + Box.vertex[i].psn.x, Box.Psn.y + Box.vertex[i].psn.y)-(p.x, p.y), RGBA(255, 255, 255, 32)
        'Circle(p.x, p.y), 2, RGBA(255, 32, 32, 255),,, 1, F
        
    Next
    
    'Print min, max

End Sub

'Function Boxtype.ComputeProjection(ByRef A0 As vec2f, ByRef A1 As vec2f) As ProjectionType
'    
'    Dim As vec2f A = (A1 - A0).normal
'    Dim As vec2f B = Psn + vertex[0].psn - A0
'    Dim As float t = B.dot(A)
'    
'    Dim As ProjectionType Projection
'    
'    Projection.tMin = t
'    Projection.tMax = t
'    
'    For i As Integer = 1 To Num_vertices-1
'        
'        B = Psn + vertex[i].psn - A0
'        t = B.dot(A)
'        
'        If Projection.tMin > t Then Projection.tMin = t
'        If Projection.tMax < t Then Projection.tMax = t
'        
'    Next
'    
'    ''  only needed if collision is detected
'    
'    'Projection.tMin = Projection.tMin / A.dot(A)
'    'Projection.tMax = Projection.tMax / A.dot(A)
'    '
'    'Projection.pMin = A0 + Projection.tMin * A
'    'Projection.pMax = A0 + Projection.tMax * A
'    
'    Return Projection
'
'End Function

Sub ComputeProjection(ByRef Box As BoxType, ByRef A0 As vec2f, ByRef A1 As vec2f, ByRef Projection As ProjectionType)
    
    Dim As vec2f A = (A1 - A0).normal
    Dim As vec2f B = Box.Psn + Box.vertex[0].psn - A0
    Dim As float t = B.dot(A)
    
    'Dim As ProjectionType Projection
    
    Projection.tMin = t
    Projection.tMax = t
    
    For i As Integer = 1 To Box.Num_vertices-1
        
        B = Box.Psn + Box.vertex[i].psn - A0
        t = B.dot(A)
        
        If Projection.tMin > t Then Projection.tMin = t
        If Projection.tMax < t Then Projection.tMax = t
        
    Next
    
    ''  only needed if collision is detected
    
    'Projection.tMin = Projection.tMin / A.dot(A)
    'Projection.tMax = Projection.tMax / A.dot(A)
    '
    'Projection.pMin = A0 + Projection.tMin * A
    'Projection.pMax = A0 + Projection.tMax * A
    
    'Return Projection

End Sub

Function BoxBoxSAT(ByRef BoxA As BoxType, ByRef BoxB As BoxType) As Integer
    
    'Dim As float minA, maxA, minB, maxB
    Dim As ProjectionType ProjA1, ProjA2, ProjB1, ProjB2
    
    For i As Integer = 0 To 1'BoxA.Num_vertices - 1
                
        Dim As vec2f A0 = BoxA.Psn + BoxA.vertex[i].psn
        Dim As vec2f A1 = BoxA.Psn + BoxA.vertex[i+1].psn
        
        'ComputeMinMax(BoxA, BoxA.Psn + BoxA.vertex[j].psn, BoxA.Psn + BoxA.vertex[i].psn, MinA, MaxA)
        'ProjA1 = ComputeProjection(BoxA, BoxA.Psn + BoxA.vertex[j].psn, BoxA.Psn + BoxA.vertex[i].psn)
        ComputeProjection(BoxA, A0, A1, ProjA1)
        'ProjA1 = BoxA.ComputeProjection(BoxA.Psn + BoxA.vertex[j].psn, BoxA.Psn + BoxA.vertex[i].psn)
        
        'ComputeMinMax(BoxB, BoxA.Psn + BoxA.vertex[j].psn, BoxA.Psn + BoxA.vertex[i].psn, MinB, MaxB)
        'ProjA2 = BoxB.ComputeProjection(BoxA.Psn + BoxA.vertex[j].psn, BoxA.Psn + BoxA.vertex[i].psn)
         ComputeProjection(BoxB, A0, A1, ProjA2)
        
        'Line(ProjA1.pMin.x, ProjA1.pMin.y)-(ProjA1.pMax.x, ProjA1.pMax.y), RGBA(0, 255, 0, 128)
        'Line(ProjA2.pMin.x, ProjA2.pMin.y)-(ProjA2.pMax.x, ProjA2.pMax.y), RGBA(0, 255, 0, 128)
        
        'If (minA > maxB) Or (minB > maxA) Then Return 0
        'If (ProjA1.tMin > ProjA2.tMax) Or (ProjA2.tMin > ProjA1.tMax) Then Return 0
        If ProjectionsSeparated(ProjA1, ProjA2) Then Return 0
        
    Next
    
    For i As Integer = 0 To 1'BoxB.Num_vertices - 1
        
        Dim As vec2f A0 = BoxB.Psn + BoxB.vertex[i].psn
        Dim As vec2f A1 = BoxB.Psn + BoxB.vertex[i+1].psn
        
        'ComputeMinMax(BoxA, BoxB.Psn + BoxB.vertex[j].psn, BoxB.Psn + BoxB.vertex[i].psn, MinA, MaxA)
        'ProjB1 = BoxA.ComputeProjection(BoxB.Psn + BoxB.vertex[j].psn, BoxB.Psn + BoxB.vertex[i].psn)
         ComputeProjection(BoxA, A0, A1, ProjB1)
        
        'ComputeMinMax(BoxB, BoxB.Psn + BoxB.vertex[j].psn, BoxB.Psn + BoxB.vertex[i].psn, MinB, MaxB)
         ComputeProjection(BoxB, A0, A1, ProjB2)
        
        'Line(ProjB1.pMin.x, ProjB1.pMin.y)-(ProjB1.pMax.x, ProjB1.pMax.y), RGBA(0, 255, 0, 128)
        'Line(ProjB2.pMin.x, ProjB2.pMin.y)-(ProjB2.pMax.x, ProjB2.pMax.y), RGBA(0, 255, 0, 128)

        'If (ProjB1.tMin > ProjB2.tMax) Or (ProjB2.tMin > ProjB1.tMax) Then Return 0
        If ProjectionsSeparated(ProjB1, ProjB2) Then Return 0
        
    Next
    
    BoxA.col = RGB(255, 0, 0)
    BoxB.col = RGB(255, 0, 0)
    
    Return -1
    
End Function
