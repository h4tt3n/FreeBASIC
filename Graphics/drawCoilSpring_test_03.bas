''	coil spring drawing routine
''	Test # 03 - October 2012
''  Michael "h4tt3n" Nissen

#Include "../../Math/vec2_07.bi"

Const As float   pi             = 4.0 * Atn(1.0)
Const As Integer SCREEN_WIDTH   = 800
Const As Integer SCREEN_HEIGHT  = 600
Const As Integer BORDER				  = 32

Declare Sub drawCoilSpring(ByVal p0 As vec2f, ByVal p1 As vec2f, ByVal radius As float, ByVal numCoils As float, ByVal col As uinteger)  

Dim As vec2f point1 = vec2f(BORDER, BORDER)
Dim As vec2f point2 = vec2f(SCREEN_WIDTH - BORDER, BORDER)
Dim As vec2f point3 = vec2f(SCREEN_WIDTH - BORDER, SCREEN_HEIGHT - BORDER)
Dim As vec2f point4 = vec2f(BORDER, SCREEN_HEIGHT - BORDER)
Dim As vec2f point5
Dim As Integer mx
Dim As Integer my

ScreenRes SCREEN_WIDTH, SCREEN_HEIGHT, 32
Color RGB(0, 0, 0), RGB(0, 0, 0)

Do
  
  GetMouse mx, my
  
  point5 = vec2f(CSng(mx), CSng(my))
  
  ScreenLock
    
    Cls
    
    drawCoilSpring(point5, point1,  8, 32, RGB(255, 255, 0))
    drawCoilSpring(point5, point2, 16, 16, RGB(255, 0, 0))
    drawCoilSpring(point5, point3, 32,  8, RGB(0, 255, 0))
    drawCoilSpring(point5, point4, 64,  4, RGB(0, 0, 255))
    
  ScreenUnLock
  
  Sleep 1, 1
  
Loop Until MultiKey(1)


''
Sub drawCoilSpring(ByVal p0 As vec2f, ByVal p1 As vec2f, ByVal radius As float, ByVal numCoils As float, ByVal col As UInteger) 
  
  ''  very fast coil spring drawing function
  
  ''  these constants decide the graphic quality of the coil spring
  Dim As   Float    vertexLength  = 8    ''  approx. vertex length in pixels
  Const As Integer  maxVertices   = 128  ''  maximum number of vertices per coil
  Const As Integer  minVertices   = 16    ''  minimum number of vertices per coil
  Dim As float      radiusSquared = radius * radius
  
  ''  number of faces in ellipse
  Dim As float numVertices     = ( 2.0 * pi * radius ) / vertexLength 
  
  ''  clamp number of faces
  If numVertices > maxVertices Then numVertices = maxVertices
  If numVertices < minVertices Then numVertices = minVertices
  
  ''  keep number of faces divisible by 4
  numVertices -= numVertices mod 4
  
  ''	re-define vertex length
  vertexlength =  ( 2.0 * pi * radius ) / numVertices 
  
  ''  compute variables
  Dim As vec2f   springN     = (p1 - p0).normalised()
  Dim As Integer numSteps    = cint( numVertices * ( numCoils + 0.5 ) )
  Dim As vec2f   coilLength  = (p1 - p0) - 2.0 * radius * springN
  Dim As vec2f   stepSize    = coilLength / numSteps
  Dim As Float   Theta       = (2.0 * pi) / numVertices
  
  'Dim As float cosTheta      = ( 2 * radiusSquared - vertexLength ^ 2 ) / ( 2 * radiusSquared )
  'Dim As vec2f   ThetaN      = vec2f(cosTheta, Sin(theta))
  
  Dim As vec2f   ThetaN      = vec2f(Cos(Theta), Sin(theta))
  Dim As vec2f   angle       = -springN 
  Dim As vec2f   pnt         = p0
  Dim As vec2f   position    = p0 - Radius * angle
  
  ''  draw coil spring
  PSet(pnt.x, pnt.y), col
  
  For i As Integer = 1 To numSteps
    
    ''	move center position one step ahead
    position += stepSize
    
    ''  increase angle by Theta
    Angle = rotate(angle, ThetaN)

    ''  get next point from new position and angle
    pnt = position + Radius * angle
    
    ''	draw a line to new point
    Line -(pnt.x, pnt.y), col
    'PSet(pnt.x, pnt.y), col
    
  Next
  
End Sub
