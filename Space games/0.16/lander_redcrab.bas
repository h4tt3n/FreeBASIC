
' LANDER by redcrab version 1.1.2
' FreeBASIC code to be compile with FBC v 0.17  http://www.freebasic.net
' 2007 redcrab@infonie.fr http://csgp.suret.net

#include "fbgfx.bi"
#Define PI 3.141592654
#Define G_WIDTH 640
#Define G_HEIGHT 480
#Define KW (G_WIDTH/320)
#Define KH (G_HEIGHT/240)

Dim Shared landerPoint(1 To 6) As Double => {0,PI/4,PI/2,3/4*PI,PI,3/2*PI}
Dim Shared landerSegment(1 To 12) As Integer => {1,2,2,6,6,4,4,5,5,3,3,1} 
Dim Shared thrustsegment(1 To 4) As Integer=>{4,3,2,3}

Type TP_Polar2D
        radius As Double
        angle As Double
End Type

Type TP_Vertex2D
        x As Double
        y As Double
End Type

Type TinyPattern
        plot(0 To 17) As TP_Polar2D
        plotxy(0 To 17) As TP_Vertex2D
        size As Double
        angle As Double
        alphabet(0 To 255) As String
        Declare Constructor()
        Declare Sub scaleRot(psize As Double,angle As Double)
        Declare Sub DrawScript(Byref s As String, xc As Integer,yc As Integer,colour As Integer)
        Declare Sub DrawText(Byref s As String, xc As Integer,yc As Integer,colour As Integer)
End Type


Sub TinyPattern.scaleRot(psize As Double,pangle As Double)
        Dim i As Integer
        For i = 0 To 17
                plotxy(i).x = psize*Cos(pangle+plot(i).angle)*plot(i).radius
                plotxy(i).y = psize*Sin(pangle+plot(i).angle)*plot(i).radius
        Next
        this.size = psize
        this.angle = pangle
End Sub

Sub TinyPattern.DrawScript(Byref s As String, xc As Integer,yc As Integer, colour As Integer)
        Dim i As Integer
        Dim ss As String
        Dim c As String
        Dim a As Integer
        Dim As Double x,y,xo,yo
        
        ss = Ucase(" "+s)
        Dim idx As Integer
        For i = 1 To Len(ss)
                c = Mid(ss,i,1)
                If c= " " Then
                        xo=99999 : yo=99999
                Else
                        a = Asc(c)
                        If a>=65 And a<(65+18) Then
                                a-=65
                                x = plotxy(a).x+xc
                                y = plotxy(a).y+yc
                                If xo = 99999 Then 
                                        xo = x : yo = y
                                Endif
                                Line(xo,yo)-(x,y),colour
                                xo = x : yo = y
                        Endif
                Endif
        Next i
End Sub

Sub TinyPattern.DrawText(Byref s As String, xc As Integer,yc As Integer,colour As Integer)
        Dim i As Integer
        Dim a As Integer
        Dim c As Integer
        Dim As Double dx,dy
        c = Len(s)/2
        dx = (2*this.size+1)*Cos(this.angle)
        dy = (2*this.size+1)*Sin(this.angle)
        For i = 1 To Len(s)
                a = Asc(Mid(s,i,1))
                this.DrawScript(alphabet(a),xc+dx*(i-1-c),yc+dy*(i-1-c),colour)
        Next
End Sub



Constructor TinyPattern()
        Dim i As Double
        Dim j As Integer
        Dim k As Integer
        Dim As Integer x,y
        j = 0
        this.plot(j)= Type<TP_Polar2D>(0,0)
        j+=1
        For i = 0 To 2* PI-PI/4 Step PI/4
                this.plot(j) = Type<TP_Polar2D>(1,i)
                this.plot(j+8) = Type<TP_Polar2D>(Sqr(2)/2,i)
                j + = 1
        Next
        scaleRot(4,0)
        ' sign
        this.alphabet(Asc("+")) = "PL NJ" :        this.alphabet(Asc("-")) = "NJ" :        this.alphabet(Asc("*")) = "OK MQ NJ"
        this.alphabet(Asc("/")) = "IE" :        this.alphabet(Asc(":")) = "PP LL" :        this.alphabet(Asc("!")) = "PA LL"
        this.alphabet(Asc("#")) = "JJ KK LL MM NN OO PP QQ AA" : this.alphabet(Asc(".")) = "LL" :        this.alphabet(Asc(",")) = "LD"
        this.alphabet(Asc("'")) = "HP" :        this.alphabet(Asc("(")) = "HGED" :        this.alphabet(Asc(")")) = "HICD"
        ' Digit
        this.alphabet(Asc("0")) = "EIHGEDCI" 
        this.alphabet(Asc("1")) = "GHL"
        this.alphabet(Asc("2")) = "GHIEC"
        this.alphabet(Asc("3")) = "GHIACDE"
        this.alphabet(Asc("4")) = "LHNJ"
        this.alphabet(Asc("5")) = "IGNJCDE"
        this.alphabet(Asc("6")) = "IHGEDCJN"
        this.alphabet(Asc("7")) = "GIL"
        this.alphabet(Asc("8")) = "NGHICDENJ"
        this.alphabet(Asc("9")) = "JNGHICDE"
        ' Alphabet Upercase
        this.alphabet(Asc("A")) = "ENOPQJC NJ"
        this.alphabet(Asc("B")) = "EGPQAKLE NA"
        this.alphabet(Asc("C")) = "KLMNOPQ"
        this.alphabet(Asc("D")) = "EGPQJKLE"
        this.alphabet(Asc("E")) = "IGEC NA"
        this.alphabet(Asc("F")) = "IGE NA"
        this.alphabet(Asc("G")) = "AJKLMNOPQ"
        this.alphabet(Asc("H")) = "GE IC NJ"
        this.alphabet(Asc("I")) = "PL"
        this.alphabet(Asc("J")) = "QKLM"
        this.alphabet(Asc("K")) = "GE NP NC"
        this.alphabet(Asc("L")) = "GEC"
        this.alphabet(Asc("M")) = "EGAIC"
        this.alphabet(Asc("N")) = "EGCI"
        this.alphabet(Asc("O")) = "JKLMNOPQJ"
        this.alphabet(Asc("P")) = "EGPQAN"
        this.alphabet(Asc("Q")) = "AKLMNOPQJK"
        this.alphabet(Asc("R")) = "EGPQAN AC"
        this.alphabet(Asc("S")) = "QPOKLM"
        this.alphabet(Asc("T")) = "PL GI"
        this.alphabet(Asc("U")) = "GNMLKJI"
        this.alphabet(Asc("V")) = "GLI"
        this.alphabet(Asc("W")) = "GEACI"
        this.alphabet(Asc("X")) = "GC EI"
        this.alphabet(Asc("Y")) = "GAI AL"
        this.alphabet(Asc("Z")) = "GIEC"
        'Alphabet lower case
        this.alphabet(Asc("a")) = "ENOPQJC NJ"
        this.alphabet(Asc("b")) = "EGPQAKLE NA"
        this.alphabet(Asc("c")) = "KLMNOPQ"
        this.alphabet(Asc("d")) = "EGPQJKLE"
        this.alphabet(Asc("e")) = "IGEC NA"
        this.alphabet(Asc("f")) = "IGE NA"
        this.alphabet(Asc("g")) = "AJKLMNOPQ"
        this.alphabet(Asc("h")) = "GE IC NJ"
        this.alphabet(Asc("i")) = "PL"
        this.alphabet(Asc("j")) = "QKLM"
        this.alphabet(Asc("k")) = "GE NP NC"
        this.alphabet(Asc("l")) = "GEC"
        this.alphabet(Asc("m")) = "EGAIC"
        this.alphabet(Asc("n")) = "EGCI"
        this.alphabet(Asc("o")) = "JKLMNOPQJ"
        this.alphabet(Asc("p")) = "EGPQAN"
        this.alphabet(Asc("q")) = "AKLMNOPQJK"
        this.alphabet(Asc("r")) = "EGPQAN AC"
        this.alphabet(Asc("s")) = "QPOKLM"
        this.alphabet(Asc("t")) = "PL GI"
        this.alphabet(Asc("u")) = "GNMLKJI"
        this.alphabet(Asc("v")) = "GLI"
        this.alphabet(Asc("w")) = "GEACI"
        this.alphabet(Asc("x")) = "GC EI"
        this.alphabet(Asc("y")) = "GAI AL"
        this.alphabet(Asc("z")) = "GIEC"

End Constructor

Dim Shared text As TinyPattern 
Dim Shared text2 As TinyPattern 
Dim Shared smalltxt As TinyPattern 
Dim Shared bigtxt As TinyPattern 

smalltxt.scaleRot(3*KW,0)
bigtxt.scaleRot(5*KW,0)
text.scaleRot(4*KW,0)
text2.scaleRot(4*KW,0)

Enum game_status
        GS_START=0
        GS_INTRO
        GS_RUN
        GS_PAUSE
        GS_CRASHED
        GS_LANDED
        GS_FINISH
End Enum

Enum player_action
   PA_NOTHING = 0
   PA_LEFT
   PA_RIGHT
   PA_THRUST
   PA_QUIT
   PA_PAUSE
End Enum

Enum lander_status
        LS_NORMAL = 0
        LS_THRUST
        LS_CRASH
End Enum


Type Vertex2D
        x As Double
        y As Double
End Type

Type Lander
        location As Vertex2D
        Speed As vertex2D
        fuel As Double
        angle As Double
        size As Double
        status As lander_status
        crash_tic As Integer
        tic As Integer
        Declare Constructor()
        Declare Constructor(x As Double, y As Double)
        Declare Sub init()
        Declare Sub drawing()
End Type

Sub lander.init()
        this.location.x = 160
        this.location.y = 230
        this.fuel = 100
        this.angle = 0
        this.size = 7
        this.status = LS_NORMAL
        this.crash_tic = 0
        this.tic = 0
End Sub

Constructor lander()
        this.init
End Constructor

Constructor lander(x As Double , y As Double)
   this.init
        this.location.x = x
        this.location.y = y
End Constructor

Sub lander.drawing()
        Dim As Integer lb,ub,i,x1,y1,x2,y2
        Dim As Double xx1,yy1,xx2,yy2,xxi,yyi,xx
        Static tic As Integer
        
        tic+=1
        Select Case this.status
                Case LS_NORMAL,LS_THRUST
                        crash_tic = 0
                        lb = Lbound(landersegment)
                        ub = Ubound(landersegment)-1
                        For i = lb To ub Step 2
                                x1 = Int((this.size*Cos(this.angle+landerpoint(landersegment(i)))+this.location.x)*KW)
                                y1 = Int((this.size*Sin(this.angle+landerpoint(landersegment(i)))+240-this.location.y)*KH)
                                x2 = Int((this.size*Cos(this.angle+landerpoint(landersegment(i+1)))+this.location.x)*KW)
                                y2 = Int((this.size*Sin(this.angle+landerpoint(landersegment(i+1)))+240-this.location.y)*KH)
                                Line (x1,y1)-(x2,y2),10
                        Next i
                Case LS_CRASH        
                        crash_tic +=1
                        If crash_tic < 60 Then
                                lb = Lbound(landersegment)
                                ub = Ubound(landersegment)-1
                                For i = lb To ub Step 2
                                        xx1 = this.size*Cos(this.angle+landerpoint(landersegment(i)))
                                        yy1 = this.size*Sin(this.angle+landerpoint(landersegment(i)))
                                        xx2 = this.size*Cos(this.angle+landerpoint(landersegment(i+1)))
                                        yy2 = this.size*Sin(this.angle+landerpoint(landersegment(i+1)))
                                        xxi = (xx2 + xx1 ) / 2.0 : yyi = (yy2 + yy1 ) / 2.0
                                        xxi = xxi * (1 + crash_tic / 15.0)-xxi :         yyi = yyi * (1 + crash_tic / 15.0)-yyi
                                        xx1 -= xxi : yy1 -= yyi 
                                        xx2 -= xxi : yy2 -= yyi
                                        x1 = Int((xx1+this.location.x)*KW) :        y1 = Int((yy1+240-this.location.y)*KH)
                                        x2 = Int((xx2+this.location.x)*KW) :         y2 = Int((yy2+240-this.location.y)*KH)
                                Line (x1,y1)-(x2,y2),10
                                Next i
                        End If
                        
        End Select
        If this.status = LS_THRUST And (tic Mod 20) <  this.fuel/5 And this.fuel>0 Then
                lb = Lbound(thrustsegment)
                ub = Ubound(thrustsegment)-1
                For i = lb To ub Step 2
                        x1 = Int(this.size*Cos(this.angle+landerpoint(thrustsegment(i)))+this.location.x)
                        y1 = Int(this.size*Sin(this.angle+landerpoint(thrustsegment(i)))+240-this.location.y)
                        x2 = Int(2*this.size*Cos(this.angle+landerpoint(thrustsegment(i+1)))+this.location.x)
                        y2 = Int(2*this.size*Sin(this.angle+landerpoint(thrustsegment(i+1)))+240-this.location.y)
                        Line (x1*KW,y1*KH)-(x2*KW,y2*KH),10
                Next i                
        Endif
End Sub


Type Landscape
        altitude(0 To 319) As Double
        padLocation As Vertex2D
        gravity As Double
        Declare Constructor()
        Declare Sub init()
        Declare Sub init(Byval Glevel As Integer)
End Type

Constructor Landscape
        this.init()
End Constructor

Sub Landscape.init()
        this.init(0)
End Sub

Sub Landscape.init(Byval Glevel As Integer)
        Dim As Integer i,j,k,lb,cnt,ub,level 
        Dim As Double cur,prev,slope,delta
        this.gravity = 0.005*(Glevel/10+1)
        level = Glevel Mod 10
        lb = Lbound(this.altitude)
        ub = Ubound(this.altitude)
        prev = Rnd*220+20
        For i = lb To ub 
                this.altitude(i) = prev
        Next i 
        For j = 1 To 6
                slope = Rnd*(level+1)*50/j-((level+1)*50/2/j)
                cnt = 0
                For i =  lb To ub 
                        cur = this.altitude(i) + slope*cnt
                        this.altitude(i) = cur
                        cnt += 1
                        If cnt > 320/(2^j) Then
                                slope = Rnd*(level+1)*50/j-((level+1)*50/2/j)
                                cnt = 0
                                If i < ub Then
                                        delta = cur - this.altitude(i+1)
                                Else
                                        delta = 0
                                Endif
                                For k = i+1 To ub
                                        this.altitude(k)+= delta
                                Next
                        Endif
                Next i
        Next j
        delta = 0
        For i = lb To ub 
                delta += this.altitude(i)
        Next
        delta = (delta / ub-lb+1)/((level+1)*10)
        For i = lb To ub 
                this.altitude(i)/=delta
                this.altitude(i)+= 10
                If this.altitude(i) < 20 Then this.altitude(i)= 20
                If this.altitude(i) > 220 Then this.altitude(i)= 220
        Next
        
        
        this.padlocation.x= Rnd * 300 +10
        this.padlocation.y = (this.altitude(Int(this.padlocation.x)-10) + this.altitude(Int(this.padlocation.x)+10))/2
        lb = Int(this.padlocation.x)-10
        ub = Int(this.padlocation.x)+10
        For i = lb To ub
                this.altitude(i) = this.padlocation.y 
        Next
        
End Sub


Type game
        tic As Integer
        tic2 As Integer
        life As Integer
        safeland As Integer
        ship As lander
        scene As landscape
        playerAct As player_action
        status As game_status
        Declare Constructor ()
        Declare Destructor()
        Declare Sub init()
        Declare Sub initgfx()
        Declare Sub drawGame()
        Declare Sub initLevel(level As Integer)
        Declare Sub MainLoop()
End Type

Constructor game()
        this.initGfx
        this.init
End Constructor

Sub game.init()
        
        this.safeland = 0
        this.life = 3
        this.status=GS_INTRO
        this.initLevel(0)
        this.tic = 0        
        this.tic2 = 0        
End Sub

Destructor game()
        Screen 0
        Print "Thanks to play with Lander by redcrab"
        Sleep 3000
End Destructor

Sub game.drawGame()
        Dim As Integer i,lb,ub
        Dim aLife As lander
        Dim speed As Integer
        Cls
        lb = Lbound(this.scene.altitude)
        ub = Ubound(this.scene.altitude)
        With this.scene
        For i = lb To ub-1
                Line(i*KW,(240-Int(.altitude(i)))*KH)-((i+1)*KW,(240-Int(.altitude(i+1)))*KH),10
        Next
        End With 
        Line(Int(this.scene.padlocation.x-10)*KW,(240-Int(this.scene.padlocation.y))*KH)-(Int(this.scene.padlocation.x+10)*KW,(245-Int(this.scene.padlocation.y))*KH),10,bf
        this.ship.drawing
        Color 10,0
        text.DrawText("         Score "+Str( this.safeland),0,234*KH,10)
        aLife.size = 5
        aLife.location.y = 6
        For i = 1 To this.life
                aLife.location.x = 88+(i-1)*12
                aLife.angle = this.tic*PI/180
                aLife.drawing
        Next i
        text.DrawText("      Fuel",120*KW,234*KH,10)
        Line (161*KW,232*KH)-((161+this.ship.fuel)*KW,239*KH),10,BF
        Line (161*KW,232*KH)-(261*KW,239*KH),10,B
        If this.ship.speed.y < 0 Then
                speed  = Int((this.ship.speed.x^2+this.ship.speed.y^2)*1000)
                If speed > 100 Then speed = 100
                Line(265*KW,231*KH)-((265+speed/2)*KW,239*KH),10,bf
        Endif
        Line(265*KW,231*KH)-((265+60/2)*KW,239*KH),10,B
        Line(265*KW,231*KH)-((265+50)*KW,239*KH),10,B
        
        If this.status=GS_START Then
                If this.tic2 < 200 Then
                   text.DrawText("Press Any Key to start",G_WIDTH/2,120*KH*(this.tic2-10)/190, 10)
                Else
                   text.DrawText("Press Any Key to start",G_WIDTH/2,120*KH, 10)
                End If
                
        Endif
        If this.status=GS_INTRO Then
                If this.tic2 <= 200 Then
                        bigtxt.scaleRot(this.tic2/200*5*KW,0)
                Endif
                bigtxt.DrawText("LANDER by redcrab v 1.1.2",G_WIDTH/2,95*KH,10)
                If this.tic2 >=200 Then
                        text.DrawText("Left   : Turn left " ,G_WIDTH/2,(105+9)*KH,10)  
                        text.DrawText("Right  : Turn right",G_WIDTH/2,(105+18)*KH, 10)
                        text.DrawText("Up     : Thrust    "  ,G_WIDTH/2,(105+27)*KH, 10)
                        text.DrawText("Space  : Pause     ",G_WIDTH/2,(105+36)*KH, 10)
                        text.DrawText("Escape : Quit      ",G_WIDTH/2,(105+45)*KH, 10)
                        text.DrawText("Press Any Key to start",G_WIDTH/2,(110+54)*KH, 10)
                Endif
        Endif
        If this.status=GS_PAUSE And this.tic Mod 60 < 30 Then
                bigtxt.DrawText ("Pause" ,G_WIDTH/2,120*KH,10)
        Endif
        If this.status=GS_CRASHED Then
                If this.tic2 Mod 4 = 0 And this.tic2 < 200 Then text2.scaleRot(5*KW+Rnd*2,Rnd*0.2-0.1)
                text2.DrawText ("CRASH!" ,G_WIDTH/2,120*KH,10)
        Endif
        If this.status=GS_FINISH Then
                If this.tic2 < 200 Then
                        text2.scalerot(5*KW*this.tic2/60,0)
                Endif
                text2.DrawText ("GAME OVER" ,G_WIDTH/2,120*KH,10)
        Endif
        If this.status=GS_LANDED Then
                If this.tic2 <= 180 Then
                        text2.scalerot(5*KW*this.tic2/60,this.tic2*1.0/90*PI)
                End If
                text2.DrawText ("    LANDED!" ,G_WIDTH/2,120*KH,10)
        Endif
        screensync
        Flip
End Sub

Sub game.initLevel(level As Integer)
        this.playeract = PA_NOTHING
        this.ship.init
   this.scene.init(level)
End Sub

Sub game.MainLoop()
        Dim st As String
        Dim speed As Integer
        Dim angle As Integer
        Do
                this.tic +=1
                this.tic2 +=1
                st = Inkey
                ' Player action
                this.playeract = PA_NOTHING

                If MultiKey(FB.SC_LEFT) Then this.playeract = PA_LEFT
                If MultiKey(FB.SC_RIGHT) Then this.playeract = PA_RIGHT
                If MultiKey(FB.SC_UP) Then this.playeract = PA_THRUST
                If Multikey(FB.SC_SPACE) Then this.playeract = PA_PAUSE
                If MultiKey(FB.SC_ESCAPE) Then this.playeract = PA_QUIT
                
                If st="-" Then this.ship.status = LS_CRASH
                If st="+" Then this.ship.status = LS_NORMAL
                If st="*" Then this.ship.fuel = 100
                
                ' Process player action
                If this.status = GS_START And this.tic > 30 Then
                        If st <> "" Then
                                this.status = GS_RUN
                                this.tic = 0
                        End If
                Endif

                If this.status=GS_INTRO And this.tic > 30 Then
                        If st <> "" Then 
                                this.status = GS_RUN
                                this.tic = 0
                        Endif
                Endif

                If this.status=GS_LANDED And this.tic > 120 Then
                        If st <> "" Then         
                                this.status = GS_START
                                this.initLevel(this.safeland)
                                this.tic = 0
                                this.tic2 = 0
                        End If
                Endif
                
                If this.status=GS_CRASHED And this.tic > 120 Then
                        If st <> "" Then         
                                this.status = GS_START
                                this.ship.init
                                this.tic = 0
                                this.tic2 = 0
                        End If
                Endif
                
                If this.status=GS_FINISH And this.tic > 120 Then
                        If st <> "" Then         
                                this.init()
                                this.tic = 0
                                this.tic2 = 0
                        End If
                Endif
                
                If this.status = GS_PAUSE And this.tic > 60 Then
                        If this.playeract = PA_PAUSE Then
                                this.status = GS_RUN
                                While inkey<> "" : Sleep 1,1 :Wend
                                Sleep 100,1
                                this.playeract = PA_NOTHING
                        End If
                End If

                If this.status = GS_RUN Then
                        If this.playeract = PA_PAUSE Then
                                Sleep 100,1
                                st = Inkey
                                this.status = GS_PAUSE
                                this.playeract = PA_NOTHING
                                this.tic = 0
                        End If
                        If this.playeract = PA_THRUST Then
                                this.ship.status = LS_THRUST
                                
                        Else
                                If this.ship.status <> LS_CRASH Then 
                                        this.ship.status = LS_NORMAL
                                Endif
                        Endif
                        If this.playeract = PA_LEFT And this.ship.fuel> 0 Then this.ship.angle -= PI/100
                        If this.playeract = PA_RIGHT And this.ship.fuel> 0 Then this.ship.angle += PI/100
                        If this.playeract = PA_THRUST And this.ship.fuel>0 Then 
                                this.ship.speed.x += Sin(this.ship.angle) * 0.03
                                this.ship.speed.y += Cos(this.ship.angle) * 0.03
                                If this.tic Mod 2 = 0 Then this.ship.fuel -= 1
                        End If
                        this.ship.speed.y-=this.scene.gravity
                        this.ship.location.x += this.ship.speed.x
                        this.ship.location.y += this.ship.speed.y
                        If this.ship.location.x < 0 Then this.ship.location.x = 319
                        If this.ship.location.x >= 320 Then this.ship.location.x = 0
                        If this.ship.location.y<0 Then 
                                this.ship.speed.y = 0                
                                this.ship.location.y=0
                        End If
                        If this.ship.location.y>240 Then
                                this.ship.speed.y = 0
                                this.ship.location.y=240
                        End If
                        If  this.ship.location.y <= this.scene.altitude(Int(this.ship.location.x))+this.ship.size*0.80 Then
                                this.ship.location.y = this.scene.altitude(Int(this.ship.location.x))+this.ship.size*0.80
                                If this.ship.speed.y <0 Then
                                        speed = Int((this.ship.speed.x^2+this.ship.speed.y^2)*1000)
                                        angle = Int(Abs(this.ship.angle/(PI/180)))
                                        If speed <=60 And angle <10 And this.scene.padlocation.x-10 < this.ship.location.x And this.scene.padlocation.x+10 > this.ship.location.x  Then
                                                this.status = GS_LANDED
                                                this.safeland+=1
                                                
                                        Else
                                                this.status = GS_CRASHED
                                                this.ship.status = LS_CRASH
                                                If this.life = 0 Then
                                                        this.status = GS_FINISH
                                                Else
                                                        this.life-=1
                                                End If
                                        Endif
                                        this.tic = 0
                                        this.tic2 = 0
                                Endif
                                this.ship.speed.x = 0 
                                this.ship.speed.y = 0 
                        Endif
                End If
                
                Sleep 1,1
                this.drawGame
        Loop While MultiKey(FB.SC_ESCAPE)=0
End Sub

Sub game.initgfx()
        Screenres G_WIDTH,G_HEIGHT,8,2,FB.GFX_FULLSCREEN
        ScreenSet 0,1
        Cls
End Sub

Randomize Timer
Dim Shared agame As game
SetMouse ,,0
agame.MainLoop
Sleep
 