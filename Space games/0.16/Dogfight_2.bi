Const _
Pi = 4*atn(1), _ 
TwoPi = pi*2, _
ThrqPi = pi*1.5, _
HalfPi = pi*0.5, _
radtodeg = 360/TwoPi, _     ''multiply w. this to convert radians to degrees
degtorad = TwoPi/360        ''vice versa

Dim Shared as Ubyte _       ''0 to 255
R, G, B, _
Page, _
Sleep_Millisecs, _
Border

Dim Shared As Ushort _      ''0 to 65365
i, i2, i3, i4, _
Menu_wid, Menu_Hgt, _
Loop_Rate, _
FPS, FPS_Counter, _
LPS, LPS_counter, _
Total_LPS, Total_Loop_Counter, _
Grid_Num, _
Grid_Dist

Dim Shared as Uinteger _    ''0 to 4294967295
Scrn_Wid, _
Scrn_Hgt, _
Scrn_X_Mid, _
Scrn_Y_Mid, _
Scrn_Rate, _
Grid_Color

Dim Shared As Single _ 
Direction, _
Speed, _
semimajor, _
periapsis, _
apoapsis, _
Distance, _ 
Radius, _
MinDist, _
Dist_Sqared, _
Xdist, Ydist, _
Xdist2, Ydist2, _
Xpos, Ypos, _
Xpos2, Ypos2, _
Gforce, _
Wait_Rate, _
Grid_Radius, _
Theta, _
Col

Dim Shared as Double _
last_Scrn_Update, _
Last_Program_Loop, _
Total_Loop_Timer, _
FPS_timer, LPS_Timer, _
Scrn_Update, loop_update

Type Scrn
    X as Ushort
    Y as Ushort
    Wid As Ushort
    Hgt as Ushort
    X_Mid as Single
    Y_Mid as Single
    Angle as Single
    Style as Ubyte
    Cos_Ang as Single
    Sin_Ang as Single
    Content as Ubyte Ptr
End Type

'Type Meter
'End Type

Type Menu
    X as Ushort
    Y as Ushort
    Wid As Ushort
    Hgt as Ushort
    Col(1 to 3) as Integer
    Content as Ubyte Ptr
End Type

Type Radar
    State as Ubyte
    X as Ushort
    Y as Ushort
    Wid As Ushort
    Hgt as Ushort
    X_Mid as Single
    Y_Mid as Single
    Object_X  as Single
    Object_Y as Single
    Zoom as Single
    Zoom_Old as Single
    Zoom_Min as Single
    Zoom_Max as Single
    zoom_speed as Single
    Alpha as Ubyte
    Col(1 to 3) as Integer
    Content as Ubyte Ptr
    Content_Border as Ubyte Ptr
End Type

Type Compass
    X as Integer
    Y as Integer
    Radius as Integer
    State as Integer
    Content as Ubyte Ptr
End Type

Type Controls
    lft as Ubyte
    rgt as Ubyte
    fwd as Ubyte
    gun as Ubyte
    pck as Ubyte
    Scrn_Style as Ubyte
    Radar_State as Ubyte
    Radar_zoom_in as Ubyte
    Radar_zoom_out as Ubyte
    Radar_Alpha_Plus as Ubyte
    Radar_Alpha_Minus as Ubyte
End Type

Type Particle
    State as Ubyte
    Mass as Single
    Speed as Single
    Direction as Single
    Life_Time as Ushort
    Life_TimeLeft as Ushort
    X As Single
    Y As Single 
    XVec As Single 
    YVec As Single
    R As Ubyte
    G As Ubyte
    B As Ubyte
End Type

Type Shield
    X As Single
    Y As Single
    State as Ubyte
    Radius as Single
    Strength as Single
    Damping as Single
    R As Ubyte 
    G As Ubyte
    B As Ubyte
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

Type Dock
    State as Ubyte
    Host as Ushort
    HitPoints as Ushort
    Mass as Single
    Fuel_Mass as Single
    Fuel_Max as Single
    Radius as Single
    Spawn_Angle as Single
    Spawn_Distance as Single
    Speed as Single
    Angle as Single
    Thrust_Force as Single
    Move_Direction as Single
    X As Single
    Y As Single 
    XVec As Single 
    YVec As Single
    X_tr as Single
    Y_tr as Single
    X_tl as Single
    Y_tl as Single
    X_br as Single
    Y_br as Single
    X_bl as Single
    Y_bl as Single
    Explosion_state as Ubyte
    Explosion_trigger as Ushort
    Explosion_strength as Ushort
    Beacon as Beacon
    Shield as Shield
    Burst(1 to 160) as Particle
    Particle(1 to 600) as Particle
    Sprite as Ubyte Ptr
End Type

Type Ship
    State as Ubyte
    Hitpoints as Ushort
    Mass As Single 
    Fuel_Mass as Single
    Fuel_Max as Single
    Radius As Single 
    Spawn_Angle as Single
    Spawn_Distance as Single
    Angle as Single
    Turn_Rate as Single
    Thrust_Force as Single
    Payload_state as Ubyte
    Payload_num as Ushort
    Tractor_Force as Single
    Tractor_MinDist as Single
    Tractor_Damping as Single
    Explosion_state as Ubyte
    Explosion_trigger as Ushort
    Explosion_strength as Ushort
    X As Single
    Y As Single 
    XVec As Single 
    YVec As Single
    X_dn as Single
    Y_dn as Single
    X_up as Single
    Y_up as Single
    Shield as Shield
    Burst(1 to 80) as Particle
    Particle(1 to 300) as Particle
    Projectile(1 to 20) as Particle
    Col as Uinteger
    Sprite as Ubyte Ptr
End Type

Type Plr
    Active as Ubyte
    Num_ships as Ubyte
    Num_Wins as Ushort
    Num_losses as Ushort
    Num_Draws as Ushort
    Col as Integer
    Scrn as Scrn
    Menu as Menu
    Radar as Radar
    Controls as Controls
    Dock as Dock
    Ship(1 to 5) as Ship
    Wait_Time(9) as Single
End Type

Type Planet
    State as Ubyte
    Host as Ushort
    Mass As Single 
    Radius As Single 
    Spawn_Angle as Single
    Spawn_Distance as Single
    X As Single
    Y As Single 
    XVec As Single 
    YVec As Single 
    R As Ubyte
    G As Ubyte
    B As Ubyte
    Sprite as Ushort Ptr
End Type

Type Emerald
    State as Ubyte
    Host as Ushort
    Mass As Single 
    Radius As Single
    Spawn_Angle as Single
    Spawn_Distance as Single
    Explosion_State as Ubyte
    Explosion_trigger as Ushort
    Explosion_strength as Ushort
    X As Single
    Y As Single 
    XVec As Single 
    YVec As Single 
    R As Ubyte 
    G As Ubyte
    B As Ubyte
    Particle(1 to 400) as Particle
    Sprite as Ushort Ptr
End Type 

Type Asteroid
    State as Ubyte
    Host as Ushort
    Mass As Single 
    Radius As Single
    Spawn_Angle as Single
    Spawn_Distance as Single
    Explosion_State as Ubyte
    Explosion_trigger as Ushort
    Explosion_strength as Ushort
    X As Single
    Y As Single 
    XVec As Single 
    YVec As Single 
    R As Ubyte
    G As Ubyte
    B As Ubyte
    Particle(1 to 200) as Particle
    Sprite as Ushort Ptr
End Type 

Type Ellipse
    num_lines as Ushort
    Radius as Ushort
    Col as Integer
    X(360) as Single 
    Y(360) as Single 
End Type

Type Radian
    X1 as Single 
    Y1 as Single 
    X2 as Single 
    Y2 as Single 
End Type

dim shared as Integer Xrec, Yrec
dim shared as Single Tpol, Rpol
Dim Shared as Single Deg

''  define function that calculates rectangular coordinates from polar coordinates
function Rec (Byval Rpol as Single, Byval Tpol as Single) 
    Xrec = cos(Tpol)*Rpol
    Yrec = sin(Tpol)*Rpol
end function 

''  define function that calculates polar coordinates from rectangular coordinates
function Pol (byval Xrec as Single, byval Yrec as Single) 
    Rpol=sqr(Xrec^2+Yrec^2) 
    Tpol=atn(Yrec/Xrec)
    if Xrec<0 Then
        If Yrec>0 then 
            Tpol += pi
        Else 
            Tpol -= pi
        End If
    End If
end function

function DegSub (byval deg1 as Single, byval deg2 as Single)
    Deg = deg1 - deg2
    If Deg < 0 Then Deg += Twopi
    If Deg >= Twopi Then Deg -= Twopi
End Function

function DegAdd (byval deg1 as Single, byval deg2 as Single)
    Deg = deg1 + deg2
    If Deg < 0 Then Deg += Twopi
    If Deg >= Twopi Then Deg -= Twopi
End Function

Sub Draw_Ellipse (Byval Buffer as Ubyte Ptr, ByVal cX As Single, ByVal cY As Single, ByVal Wid As Single, _
    ByVal Hgt As Single, ByVal angle As Single, byval col as integer, num_lines as Integer) 
    
    Dim as Single _ 
    SinAngle, CosAngle, Theta, DeltaTheta, _
    X, Y, rX, rY

    SinAngle = Sin(Angle) 
    CosAngle = Cos(Angle)
    DeltaTheta = Twopi/num_lines
    Theta = 0 
    X = Wid * Cos(Theta) 
    Y = Hgt * Sin(Theta) 
    rX = cX + X * CosAngle + Y * SinAngle 
    rY = cY - X * SinAngle + Y * CosAngle 
    Pset buffer, (rX, rY), col
    
    Do While Theta < Twopi 
        Theta += DeltaTheta 
        X = Wid * Cos(Theta) 
        Y = Hgt * Sin(Theta) 
        rX = cX + X * CosAngle + Y * SinAngle 
        rY = cY - X * SinAngle + Y * CosAngle
        Line buffer, -(rX, rY), col
    Loop 
    
End Sub
