''      Grid tester for Gravity-Wars

Option Explicit

#include Grid_Tester.bi

''  Detect screen settings and apply them to the game
Screeninfo screen_x, screen_y
screenres screen_x, screen_y, 16, 2, 1

Screen_X_Mid = 0.5 * Screen_X
Screen_Y_Mid = 0.5 * Screen_Y

Grid_Dist = 15
Grid_Num = ((0.5*Screen_Y)/Grid_Dist)

Dim Ellipse(Grid_Num) as Ellipse

For i = 0 to Ubound(Ellipse)
    With Ellipse(i)
        .X = Screen_X_Mid
        .Y = Screen_Y_Mid
        .Hgt = i*Grid_Dist
        .Wid = .Hgt
        .Ang = 0
        .Col = RGB(6, 36, 6)
        .num_lines = toxpi/360'((2*.Hgt*pi)/30))
    End With
Next

Dim Radian(96) as Radian

For i = 0 to 2
    With Radian(i)
        .X1 = Screen_X_Mid-(Cos(60*i*radtodeg)*Grid_Dist*Grid_Num)
        .Y1 = Screen_Y_Mid-(Sin(60*i*radtodeg)*Grid_Dist*Grid_Num)
        .X2 = Screen_X_Mid+(Cos(60*i*radtodeg)*Grid_Dist*Grid_Num)
        .Y2 = Screen_Y_Mid+(Sin(60*i*radtodeg)*Grid_Dist*Grid_Num)
    End With
Next
For i = 3 to 8
    With Radian(i)
        .X1 = Screen_X_Mid-(Cos(((60*i)+30)*radtodeg)*Grid_Dist*Grid_Num)
        .Y1 = Screen_Y_Mid-(Sin(((60*i)+30)*radtodeg)*Grid_Dist*Grid_Num)
        .X2 = Screen_X_Mid-(Cos(((60*i)+30)*radtodeg)*(Grid_Dist*2))
        .Y2 = Screen_Y_Mid-(Sin(((60*i)+30)*radtodeg)*(Grid_Dist*2))
    End With
Next
For i = 9 to 21
    With Radian(i)
        .X1 = Screen_X_Mid-(Cos(((30*i)+15)*radtodeg)*Grid_Dist*Grid_Num)
        .Y1 = Screen_Y_Mid-(Sin(((30*i)+15)*radtodeg)*Grid_Dist*Grid_Num)
        .X2 = Screen_X_Mid-(Cos(((30*i)+15)*radtodeg)*(Grid_Dist*4))
        .Y2 = Screen_Y_Mid-(Sin(((30*i)+15)*radtodeg)*(Grid_Dist*4))
    End With
Next
For i = 22 to 46
    With Radian(i)
        .X1 = Screen_X_Mid-(Cos(((15*i)+7.5)*radtodeg)*Grid_Dist*Grid_Num)
        .Y1 = Screen_Y_Mid-(Sin(((15*i)+7.5)*radtodeg)*Grid_Dist*Grid_Num)
        .X2 = Screen_X_Mid-(Cos(((15*i)+7.5)*radtodeg)*(Grid_Dist*8))
        .Y2 = Screen_Y_Mid-(Sin(((15*i)+7.5)*radtodeg)*(Grid_Dist*8))
    End With
Next
For i = 47 to 95
    With Radian(i)
        .X1 = Screen_X_Mid-(Cos(((7.5*i)+3.75)*radtodeg)*Grid_Dist*Grid_Num)
        .Y1 = Screen_Y_Mid-(Sin(((7.5*i)+3.75)*radtodeg)*Grid_Dist*Grid_Num)
        .X2 = Screen_X_Mid-(Cos(((7.5*i)+3.75)*radtodeg)*(Grid_Dist*16))
        .Y2 = Screen_Y_Mid-(Sin(((7.5*i)+3.75)*radtodeg)*(Grid_Dist*16))
    End With
Next

Setmouse ,,0

Do 
    
    screenset page, page xor 1 
    page xor= 1 
    cls
    
    ''  calculate frames per second
    If Timer < FPS_timer + 1 Then
        FPS_Counter += 1
    Else
        FPS = FPS_Counter
        FPS_Counter = 0
        FPS_Timer = Timer
    End If
    
    For i = 0 to Grid_Num
        DrawEllipse(Ellipse(i).X, Ellipse(i).Y, Ellipse(i).Hgt, Ellipse(i).Wid, 0, Ellipse(i).Col, Ellipse(i).num_lines)
    Next
    
    For i = 0 To Ubound(Radian)
        Line(Radian(i).X1, Radian(i).Y1)-(Radian(i).X2, Radian(i).Y2), RGB(6, 36, 6)
    Next
    
    ''  print fps
    Color Rgb(16, 96, 16)
    Locate 0, 0
    Print using " ### fps"; FPS
    
Loop until Multikey(1)

End
