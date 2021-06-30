Declare sub Rec (Byval Rpol as Single, Byval Tpol as Single) 
Declare sub Pol (byval Xrec as Single, byval Yrec as Single)
Declare sub DegSub (byval deg1 as Single, byval deg2 as Single)
Declare sub DegAdd (byval deg1 as Single, byval deg2 as Single)

Const _
Pi = 4*atn(1), _ 
toxpi = 2*pi, _
halfpi = pi/2, _
radtodeg = toxpi/360, _
degtorad = 360/toxpi, _
Spec_Grav = 6.6742e-11

Dim Shared As Ubyte _
R, G, B

dim Shared as Ushort _
i, i2, i3, i4, _
P2, P1 = 1, _
Menu_wid, Menu_Hgt, _
Border, _
FPS, FPS_Counter, _
LPS, LPS_counter, _
Loop_Counter, _
Grid_Num, _
Grid_Dist, _
Screen_X_Mid, Screen_Y_Mid

Dim Shared As Uinteger _
Screen_X, Screen_Y, Screen_Rate, _
Grid_Color

Dim Shared As Single _ 
col, _
Theta, _
Turn_Rate, _
Distance, _ 
Dist_Sqared, _
Force, _
Speed, _
Direction, _
Xdist, Ydist, _
Xdist2, Ydist2, _
Xpos, Ypos, _
Xpos2, Ypos2, _
X_Center, Y_Center, _
MinDist, _
Gforce, _
G_imass, G_i2mass, _
Grid_Radius, _
Shockwave_strength, _
Shield_Strength, _
Wait_Rate, _
Wait_Time(9)

Dim Shared as Double _
Dou_var, _
screen_update, _
loop_update, _
last_screen_update, _
FPS_timer, _
LPS_Timer, _
Loop_Rate, _
Last_Program_Loop

dim shared as integer Xrec, Yrec
dim shared as Single Tpol, Rpol
Dim Shared as Single Deg

Type Col
    R as Ubyte
    G as Ubyte
    B as Ubyte
End Type

Type Player
    Num_Ships as Ubyte
    Points as Ushort
    Wins as Ushort
    Losses as Ushort
End Type

Type Scrn
    X as Integer
    Y as Integer
    Wid As Integer
    Hgt as Integer
    Zoom as Single
    Angle as Single
    Cos_Ang as Single
    Sin_Ang as Single
    Screen_X_Mid as Single
    Screen_Y_Mid as Single
    Content as Ubyte Ptr
End Type

Type Radar
    X as Integer
    Y as Integer
    Radius as Integer
    Scale as Single
    State as Integer
    Content as Any Ptr
    Content_Border as Ubyte Ptr
End Type

Type Compass
    X as Integer
    Y as Integer
    Radius as Integer
    State as Integer
    Content as Ubyte Ptr
End Type

Type Beacon
    X As Single
    Y As Single 
    Radius As Single 
    State as Ubyte
    Trigger_time as Ushort
    FadeIn_Time as Ushort
    FadeIn_TimeLeft as Ushort
    FadeOut_Time as Ushort
    FadeOut_TimeLeft as Ushort
    On_Time as Ushort
    On_Timeleft as Ushort
    Off_Time as Ushort
    Off_Timeleft as Ushort
    R As Ubyte
    G As Ubyte
    B As Ubyte
End Type

Type Particle
    State as Ubyte
    'Direction as Single
    'Speed as Single
    Time as Ushort
    TimeLeft as Ushort
    X As Single
    Y As Single 
    XVec As Single 
    YVec As Single
    R As Ubyte
    G As Ubyte
    B As Ubyte
End Type

Type Planet
    X As Single
    Y As Single 
    Xold As Single
    Yold As Single 
    XVec As Single 
    YVec As Single 
    Mass As Single 
    Grav_Param as Single
    Density As Single
    Radius As Single 
    Orbit_Radius As Single
    Angle as Single 
    State as integer
    R As Integer 
    G As Integer 
    B As Integer
    Sprite as Ushort Ptr
End Type 

Type Debris
    X As Single
    Y As Single 
    XVec As Single 
    YVec As Single 
    Mass As Single
    Density As Single
    Radius As Single 
    Orbit_Radius As Single
    Angle as Single 
    State as integer
    Particle(100) as Particle
    Explosion_state as Integer
    Explosion_trigger as Integer
    R As Integer 
    G As Integer 
    B As Integer 
    Sprite as Ubyte Ptr
End Type 

Type Emerald
    X As Single
    Y As Single 
    XVec As Single 
    YVec As Single 
    Mass As Single 
    Density As Single
    Radius As Single 
    Orbit_Radius As Single
    Angle as Single 
    State as integer
    Particle(500) as Particle
    Explosion_state as Integer
    Explosion_trigger as Integer
    R As Integer 
    G As Integer 
    B As Integer 
    Sprite as Ubyte Ptr
End Type 

Type Burst
    State as Ubyte
    Mass as Single
    Direction as Single
    Speed as Single
    Time as Ushort
    TimeLeft as Ushort
    X As Single
    Y As Single 
    XVec As Single 
    YVec As Single
    R As Ubyte
    G As Ubyte
    B As Ubyte
End Type

Type Projectile
    State as Ubyte
    Mass as Single
    Direction as Single
    Speed as Single
    Time as Ushort
    TimeLeft as Ushort
    X As Single
    Y As Single 
    XVec As Single 
    YVec As Single
    R As Ubyte
    G As Ubyte
    B As Ubyte
End Type

Type Rocket
    X As Single
    Y As Single 
    XVec As Single 
    YVec As Single 
    Mass As Single 
    Radius As Single 
    Warmup_time as Single
    Warmup_timeLeft as Single
    Point_Direction as Single
    Move_Direction as Single
    Target as Integer
    Speed as Single
    R As Integer 
    G As Integer 
    B As Integer 
    Burst(50) as Burst
    Particle(300) as Particle
    State as integer
    Explosion_state as Integer
    Explosion_trigger as Integer
    Sprite as Ushort Ptr
End Type

Type Mine
    X As Single
    Y As Single 
    XVec As Single 
    YVec As Single 
    Mass As Single 
    Radius As Single 
    Trigger as Integer
    Warmup_time as Single
    Warmup_timeLeft as Single
    Countdown_time as Single
    Countdown_timeLeft as Single
    'Orbit_Radius As Single
    State as integer
    Beacon as Beacon
    Particle(300) as Particle
    Explosion_state as Integer
    Explosion_trigger as Integer
    R As Integer 
    G As Integer 
    B As Integer 
    Sprite as Ushort Ptr
End Type

Type Ship
    Hitpoints as Integer
    X As Single
    Y As Single 
    Xold As Single
    Yold As Single 
    XVec As Single 
    YVec As Single 
    Mass As Single 
    Fuel_Mass as Single
    Radius As Single 
    Direction as Single
    Orbit_Radius As Single
    Angle as Single 
    Xburst as Single
    Yburst as Single
    Xgun as Single
    Ygun as Single
    Xl3ft as Single
    Yl3ft as Single
    Xrght as Single
    Yrght as Single
    lft as integer
    rgt as integer
    fwd as Integer
    gun as integer
    pck as Integer
    zoom_in as Integer
    zoom_out as Integer
    R As Integer 
    G As Integer 
    B As Integer 
    Burst(80) as Burst
    Projectile(23) as Projectile
    Rocket(5) as Rocket
    Mine(11) as Mine
    Particle(300) as Particle
    State as integer
    Shield_State as Integer
    Shield_Radius as Single
    Explosion_state as Integer
    Explosion_trigger as Integer
    Payload_state as Integer
    Payload_mass as Single
    Payload_num as Integer
    Gun_Type as Integer
    Sprite as Ushort Ptr
End Type

Type Ellipse
    num_lines as Integer
    X(360) as Single 
    Y(360) as Single 
    Wid as Integer
    Col as Integer
End Type

Type Radian
    X1 as Single 
    Y1 as Single 
    X2 as Single 
    Y2 as Single 
End Type

Type Draw_Trajectory
    Xpos as Single
    Ypos as Single
    State as Integer
    GM as Double
    Host as Integer
    Distance as Double
    Distance_Old as Double
    Speed as Double
    Theta as Double
    Semimajor_Axis as Double
    Semiminor_Axis as Double
    Eccentricity as Double
    Foci_Dist as Double
    True_anomaly as Double
    Spec_Orbital_Energy as Double
    Periapsis as Double
    Apoapsis as Double
    Orbit_Angle as Double
    Reference_Angle As Double
    Reference_Angle_Old As Double
End Type

''  define sub that calculates rectangular coordinates from polar coordinates (in degrees)
sub Rec (Byval Rpol as Single, Byval Tpol as Single) 
    Xrec = cos(Tpol*radtodeg)*Rpol
    Yrec = sin(Tpol*radtodeg)*Rpol
end sub 

''  define sub that calculates polar coordinates from rectangular coordinates (in degrees)
sub Pol (byval Xrec as Single, byval Yrec as Single) 
    Rpol=sqr(Xrec^2+Yrec^2) 
    Tpol=(atn(Yrec/Xrec))/radtodeg
    if Xrec<0 Then
        If Yrec>0 then 
            Tpol += 180
        Else 
            Tpol -= 180
        End If
    End If
end sub

'sub DegSub (byval deg1 as Single, byval deg2 as Single)
'    Deg = deg1 - deg2
'    If Deg < 0 Then Deg += 360
'    If Deg >= 360 Then Deg -= 360
'End sub
'
'sub DegAdd (byval deg1 as Single, byval deg2 as Single)
'    Deg = deg1 + deg2
'    If Deg < 0 Then Deg += 360
'    If Deg >= 360 Then Deg -= 360
'End sub

Sub Draw_Ellipse (Byval Buffer as Any Ptr = 0, ByVal cX As Single, ByVal cY As Single, ByVal Wid As Single, _
    ByVal Hgt As Single, ByVal angle As Single, byval col as integer, num_lines as Integer) 
    
    Dim as Single _ 
    SinAngle, CosAngle, Theta, DeltaTheta, _
    X, Y, rX, rY

    SinAngle = Sin(Angle) 
    CosAngle = Cos(Angle)
    DeltaTheta = ToxPi/num_lines
    Theta = 0 
    X = Wid * Cos(Theta) 
    Y = Hgt * Sin(Theta) 
    rX = cX + X * CosAngle + Y * SinAngle 
    rY = cY - X * SinAngle + Y * CosAngle 
    Pset buffer, (rX, rY), col
    
    Do While Theta < ToxPi 
        Theta += DeltaTheta 
        X = Wid * Cos(Theta) 
        Y = Hgt * Sin(Theta) 
        rX = cX + X * CosAngle + Y * SinAngle 
        rY = cY - X * SinAngle + Y * CosAngle
        Line buffer, -(rX, rY), col
    Loop 
    
End Sub

