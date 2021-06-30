 

Function Regulate(Byval MyFps As Long,Byref fps As Long) As Long
    Static As Double timervalue,_lastsleeptime,t3,frames
    frames+=1
    If (Timer-t3)>=1 Then t3=Timer:fps=frames:frames=0
    Var sleeptime=_lastsleeptime+((1/myfps)-Timer+timervalue)*1000
    If sleeptime<1 Then sleeptime=1
    _lastsleeptime=sleeptime
    timervalue=Timer
    Return sleeptime
End Function

'identical pendulums
Sub Pendulum1(x As Long,y As Long,angle As Double,length As Long,col As Ulong,Byref p As Single)
    Static As Double t
    Static As boolean flag
     dim as single minx=x-length*sin(30*.0174532925199433)+.5
     dim as single maxx=x+length*sin(30*.0174532925199433)-.5
    angle=angle*.0174532925199433 
    Var x2=x+length*Cos(angle)
    If x2>maxx Then flag=true
    If x2<minx Then 
        If flag=true Then p=Timer-t:t=Timer
        flag=false
    End If
    Var y2=y-length*Sin(angle)
    Line(x,y)-(x2,y2),col
    Circle(x2,y2),50,col,,,,f 
End Sub

Sub Pendulum2(x As Long,y As Long,angle As Double,length As Long,col As Ulong,Byref p As Single)
    Static As Double t
    Static As boolean flag
    dim as single minx=x-length*sin(30*.0174532925199433)+.5
    dim as single maxx=x+length*sin(30*.0174532925199433)-.5
    angle=angle*.0174532925199433 
    Var x2=x+length*Cos(angle)
    If x2>maxx Then flag=true
    If x2<minx Then 
        If flag=true Then p=Timer-t:t=Timer
        flag=false
    End If
    Var y2=y-length*Sin(angle)
    Line(x,y)-(x2,y2),col
    Circle(x2,y2),50,col,,,,f 
End Sub


#define map(a,b,x,c,d) ((d)-(c))*((x)-(a))/((b)-(a))+(c)

#macro display

ang1+=delta   'delta =.0006*refreshrate (arbitary speed)     'fps depentent pendulum
ang2+=refreshrate*delta /requiredframerate                   'fps independent pendulum
Screenlock
Cls
'draw pendulums
Pendulum1(300,20,30*Sin(ang1)-90,400,Rgb(0,200,0),p1)    'period varies with fps
Pendulum2(700,20,30*Sin(ang2)-90,400,Rgb(0,100,200),p2)  'period constant

Draw String(350,700),"Move red circle to alter the framerate",Rgb(200,200,200)
Draw String(50,20),"Monitor refresh rate = " &refreshrate
Draw String(50,50), "Requested Framerate "&requiredframerate
Draw String(450,500),"fps independent Period = " &p2,Rgb(0,100,200)
Draw String(050,500),"fps dependent Period = " &p1,Rgb(0,200,000)
Draw String(50,70),"Actual    Framerate "&fps
draw string(50,120),"Right click mouse to reset fps to monitor refresh rate"
draw string(50,150),"Please wait for a few swings to calculate the periods",rgb(100,100,100)
'slider circle and box
draw string(280,650),"34"
draw string(710,650),"156"
Line(300,650)-(700,680),Rgb(0,100,255),bf
Circle(circx,665),12,Rgb(200,0,0),,,,f
Screenunlock
Sleep regulate(requiredframerate,fps)'fps regulator
#endmacro

#macro mouse
Dim As Long x=mx,y=my,ddx,ddy
While mb = 1
    Display
    Getmouse mx,my,,mb
    If mx<>x Or my<>y  Then
        ddx = mx - x
        ddy = my - y
        x = mx
        y = my
        circx=x+ddx
        If circx<312 Then circx=312
        If circx>688 Then circx=688
        requiredframerate=map(300,700,circx,30,160)  
    End If
Wend
#endmacro

#define incircle(cx,cy,radius,x,y) (cx-x)*(cx-x) +(cy-y)*(cy-y)<= radius*radius

Screen 20,32
Const circy=665 'y position of slider circle
Dim As Long mx,my,mb,circx
Dim As integer refreshrate
Screeninfo ,,,,,refreshrate
Dim As Long fps=refreshrate
Dim As Long requiredframerate=refreshrate 
circx=map(30,160,requiredframerate,300,700)  'first position of red circle
Dim As Single ang1,ang2                      'angular input for each pendulum
Dim As Single p1,p2                          'periods for each pendulum

dim as single delta=.0006*refreshrate       'chosen speed increment (arbitary)

Do
    Getmouse mx,my,,mb
    If mb=2 Then requiredframerate=refreshrate:circx=map(30,160,requiredframerate,300,700) 'reset
    display
    If incircle(circx,circy,10,mx,my) And mb=1 Then: mouse:End If                          'slider
Loop Until Len(Inkey)
sleep

 