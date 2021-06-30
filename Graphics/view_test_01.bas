
Screen 12

'ScreenRes 800, 600, 32

Dim ip As Any Ptr
Dim As Integer x, y

'simple sprite
ip = ImageCreate(64,64)
For y = 0 To 63
  For x = 0 To 63
    PSet ip, (x, y), (x\4) Xor (y\4)
  Next x
Next y

'viewport with blue border
Line (215,135)-(425,345), 1, bf
View ( 100, 100 )-( 800, 600 )

'move sprite around the viewport
Do

  x = 100*Sin(Timer*2.0)+50
  y = 100*Sin(Timer*2.7)+50
  
  ScreenSync
  ScreenLock
  
  'clear viewport and put image
  Cls 1
  Put (x, y), ip, PSet
    
  ScreenUnlock

Loop While Inkey = ""

ImageDestroy(ip)