Declare function Rec ( Rpol as Single,  Tpol as Single) as Integer
Declare function Pol ( Xrec as Single,  Yrec as Single) as Integer
Declare function DegSub ( deg1 as Single,  deg2 as Single) as Integer
Declare function DegAdd ( deg1 as Single,  deg2 as Single) as Integer
Declare Function Gravity ( Body1_Type as String,  Body1_Number as Integer,  _
Body2_Type as String,  Body2_Number as Integer) as Integer

Const Pi = 4*atn(1), _ 
toxpi = 2*pi, _
radtodeg = toxpi/360, _
degtorad = 360/toxpi, _
Spec_Grav = 6.673e-11

dim Shared as integer _
i, i2, i3, i4, R, G, B, _
P2, P1 = 1, _
Menu_wid, Menu_Hgt, _
Border, _
Screen_X, Screen_Y, Screen_Rate, _
FPS, FPS_Counter, _
LPS, LPS_counter, _
Loop_Counter, _
Total_LPS, Total_loop_Counter, _
Max_Loops, _
Grid_Num, _
Grid_Dist, _
Screen_X_Mid, Screen_Y_Mid, _
Grid_Color

Dim Shared As Single _ 
dist, chk, dist1, dist2, _
col, _
Theta, _
Turn_Rate, _
Distance, _ 
Dist_sqared, _
Force, _
Speed, _
Direction, _
Xdist, Ydist, _
Xpos, Ypos, _
Xpos2, Ypos2, _
X_Center, Y_Center, _
MinDist, _
G_imass, G_i2mass, _
Grid_Radius, _
Shockwave_strength, _
Shield_Strength, _
Wait_Rate, _
Wait_Time(9)

Dim Shared as Single _
FPS_timer, _
LPS_Timer, _
Total_loop_Timer, _
screen_update, _
Last_screen_update, _
Loop_Update, _
Loop_Rate, _
Last_Program_Loop


dim shared as integer Xrec, Yrec
dim shared as Single Tpol, Rpol
Dim Shared as Single Deg


Type Col
    R as Single
    G as Single
    B as Single
End Type

Type Player
    Num_Ships as Integer
    Points as Integer
    Wins as Integer
    Losses as Integer
End Type

Type Scrn
    X as Integer
    Y as Integer
    Wid As Integer
    Hgt as Integer
    Zoom as Single
    Screen_X_Mid as Single
    Screen_Y_Mid as Single
    Content as Any Ptr
End Type

Type Radar
    X as Integer
    Y as Integer
    Radius as Integer
    Scale as Single
    State as Integer
End Type

Type Compass
    X as Integer
    Y as Integer
    Radius as Integer
    State as Integer
End Type

Type Beacon
    X As Single
    Y As Single 
    Radius As Single 
    State as integer
    Trigger_time as Single
    FadeIn_Time as Integer
    FadeIn_TimeLeft as Integer
    FadeOut_Time as Integer
    FadeOut_TimeLeft as Integer
    On_Time as Integer
    On_Timeleft as Integer
    Off_Time as Integer
    Off_Timeleft as Integer
    R As Integer 
    G As Integer 
    B As Integer 
End Type

Type Particle
    X As Single
    Y As Single 
    Direction as Single
    Speed as Single
    XVec As Single 
    YVec As Single
    State as integer
    Time as Single
    TimeLeft as Single
    R As Integer 
    G As Integer 
    B As Integer
End Type

Type Planet
    X As Single
    Y As Single 
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
End Type 

Type Debris
    X As Single
    Y As Single 
    XVec As Single 
    YVec As Single 
    Mass As Single
    Grav_Param as Single
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
End Type 

Type Emerald
    X As Single
    Y As Single 
    XVec As Single 
    YVec As Single 
    Mass As Single 
    Grav_Param as Single
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
End Type 

Type Comet_Debris
    X As Single
    Y As Single 
    XVec As Single 
    YVec As Single 
    Direction as Single
    Speed as Single
    Mass As Single
    Grav_Param as Single
    Density As Single
    Radius As Single 
    Time as Single
    TimeLeft as Single
    State as integer
    R As Integer 
    G As Integer 
    B As Integer 
End Type

Type Comet
    X As Single
    Y As Single 
    XVec As Single 
    YVec As Single 
    Mass As Single
    Grav_Param as Single
    Density As Single
    Radius As Single 
    Orbit_Radius As Single
    Angle as Single 
    State as integer
    Particle(1000) as Particle
    Comet_Debris(200) as Comet_Debris
    R As Integer 
    G As Integer 
    B As Integer 
End Type

Type Burst
    X As Single
    Y As Single 
    Direction as Single
    Speed as Single
    XVec As Single 
    YVec As Single
    State as integer
    Time as Single
    TimeLeft as Single
    R As Integer 
    G As Integer 
    B As Integer
End Type

Type Projectile
    X As Single
    Y As Single 
    Direction as Single
    Speed as Single
    XVec As Single 
    YVec As Single
    Mass as Single
    Grav_Param as Single
    State as integer
    Time as Single
    TimeLeft as Single
    R As Integer 
    G As Integer 
    B As Integer
End Type

Type Rocket
    X As Single
    Y As Single 
    XVec As Single 
    YVec As Single 
    Mass As Single 
    Grav_Param as Single
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
End Type

Type Mine
    X As Single
    Y As Single 
    XVec As Single 
    YVec As Single 
    Mass As Single 
    Grav_Param as Single
    Radius As Single 
    Trigger as Integer
    Warmup_time as Single
    Warmup_timeLeft as Single
    Countdown_time as Single
    Countdown_timeLeft as Single
    Orbit_Radius As Single
    State as integer
    Beacon as Beacon
    Particle(300) as Particle
    Explosion_state as Integer
    Explosion_trigger as Integer
    R As Integer 
    G As Integer 
    B As Integer 
End Type

Type Ship
    X As Single
    Y As Single 
    XVec As Single 
    YVec As Single 
    Mass As Single 
    Grav_Param as Single
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
    Burst(50) as Burst
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
End Type

Type Node
    Type as Integer
    X As Single
    Y As Single 
    XVec As Single 
    YVec As Single 
    Mass As Single 
    Grav_Param as Single
    Radius As Single 
    Point_Direction as Single
    Move_Direction as Single
    Orbit_Radius As Single
    Speed as Single
    Angle as Single 
    Xburst_up as Single
    Yburst_up as Single
    Xburst_dn as Single
    Yburst_dn as Single
    Xburst_lf as Single
    Yburst_lf as Single
    Xburst_rg as Single
    Yburst_rg as Single
    R As Integer 
    G As Integer 
    B As Integer 
    Burst(100) as Burst
    Particle(400) as Particle
    Beacon as Beacon
    State as integer
    Explosion_state as Integer
    Explosion_trigger as Integer
End Type

Type Seed
    X As Single
    Y As Single 
    Direction as Single
    Xvec As Single
    Yvec As Single 
    Radius As Single
    Mass As Single
    Grav_Param as Single
    State as Integer
    Host as Integer
    Sleep_time as Integer
    Sleep_timeleft as Integer
End Type

Type Stem
    Xtop As Single
    Ytop As Single
    XtopVec As Single 
    YtopVec As Single 
    Height as Single
    State as Integer
    Num_Seed as Integer
    Sleep_timeleft as Integer
    Growth_Time as Integer
    Growth_TimeLeft as Integer
    Particle(20) as Particle
    Explosion_State as Integer
    Bud_Radius as Single
    Stem_Col as Col
    Stem_Birth_Col as Col
    Stem_Death_Col as Col
    Bud_Col as Col
    Bud_Birth_Col as Col
    Bud_Death_Col as Col
End Type

Type Shrub
    Xroot As Single
    Yroot As Single 
    Radius As Single
    State as Integer
    Host as Integer
    Num_Stem as Integer
    Growth_Rate as Single
    Total_Num_Stem as Integer
    Total_Num_Stem_Left as Integer
    Stem(8) as Stem
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

''  define function that calculates rectangular coordinates from polar coordinates (in degrees)
function Rec ( Rpol as Single,  Tpol as Single) as Integer
    Xrec = cos(Tpol*radtodeg)*Rpol
    Yrec = sin(Tpol*radtodeg)*Rpol
end function 

''  define function that calculates polar coordinates from rectangular coordinates (in degrees)
function Pol ( Xrec as Single,  Yrec as Single) as Integer
    Rpol=sqr(Xrec^2+Yrec^2) 
    Tpol=(atn(Yrec/Xrec))/radtodeg
    if Xrec<0 and Yrec>0 then Tpol += 180
    if Xrec<0 and Yrec<=0 then Tpol -= 180
end function

function DegSub ( deg1 as Single,  deg2 as Single) as Integer
    Deg = deg1 - deg2
    If Deg < 0 Then Deg += 360
    If Deg >= 360 Then Deg -= 360
End Function

function DegAdd ( deg1 as Single,  deg2 as Single) as Integer
    Deg = deg1 + deg2
    If Deg < 0 Then Deg += 360
    If Deg >= 360 Then Deg -= 360
End Function

