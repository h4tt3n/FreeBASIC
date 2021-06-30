'' The program shows how changing the view coordinates mapping for the current viewport changes the size of a figure drawn on the screen.
'' The effect is one of zooming in and out:
''   - As the viewport coordinates get smaller, the figure appears larger on the screen, until parts of it are finally clipped because they lie outside the window.
''   - As the viewport coordinates get larger, the figure appears smaller on the screen.

Declare Sub Zoom (ByVal X As Single)
Dim As Single X = 500, Xdelta = 0.1

'ScreenRes 800, 600, 32
Screen 21

Do
  Do While X < 525 And X > 50
    X += Xdelta                      '' Change window size.
    Zoom(X)
    If Inkey <> "" Then Exit Do, Do  '' Stop if key pressed.
    Sleep 1, 1
  Loop
  X -= Xdelta
  Xdelta *= -1                       '' Reverse size change.
Loop

Sub Zoom (ByVal X As Single)
  Window (-X,-X)-(X,X)               '' Define new window.
  ScreenLock
  Cls
  Circle (0,0), 60, 11,,,, F   '' Draw ellipse with x-radius 60.
  ScreenUnlock
End Sub