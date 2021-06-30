
''	includes
#include once "fbgfx.bi"
#include once "vec2f.bi"

''	integration constants
const as integer	Simulation_Fps    			= 60         						''  ideal framerate
const as integer	PhysicsSteps						= 4											''	physics iterations per game loop
const as single		Timestep								= 1/Simulation_Fps			''	timestep per game loop
const as single		Dt											= TimeStep/PhysicsSteps	''	timestep per physics iteration
const	as single		HalfDt									= 0.5*Dt								''	half timestep

''	math constants
const	as single		Pi											=	4*atn(1)							''	pi (better not change ^^)
const as single		TwoPi										= 2*pi									''	two pi
const as single		Rad2Deg 								= 180/pi								''	radians to degrees
const as single		Deg2Rad									= Pi/180								''	degrees to radians

''	screen constants
const as integer 	ScreenWidth							= 800										''	screen width
const as integer 	ScreenHeight						= 600										''	screen height
const as integer 	ScreenBitDepth					= 32										''	screen bit depth
const as uinteger ScreenForegroundColor		= rgb(0, 0, 0)					''	foreground color
const as uinteger ScreenBackgroundColor		= rgb(160, 160, 192)		''	background color

''	camera constants
const as single 	CameraZoomMax						= 1.00									''
const as single 	CameraZoomMin						= 0.10									''
const as single 	CameraZoomRate					= 1.01									''
const as single 	CameraScrollRate				= 4.00									''

''	game constants
const as integer	Num_Players							= 2											''

''	define types
type Screen_Type
	as vec2f center
	as integer wid, hgt, depth, pages, flags, rate
end type

type Camera_Type
	as vec2f Psn
	as single Zoom, ScrollRate, ZoomRate
end type

type Game_Controls_Type
	as integer EscapeValue
	as byte 	 EscapeState
	as integer ScrollUpValue, ScrollDownValue, ScrollLeftValue, ScrollRightValue, ZoomInValue, ZoomOutValue
	as byte 	 ScrollUpState, ScrollDownState, ScrollLeftState, ScrollRightState, ZoomInState, ZoomOutState
end type

type Vehicle_Controls_Type
	as integer LeftValue, RightValue, UpValue, DownValue, FireValue
	as byte 	 LeftState, RightState, UpState, DownState, FireState
end type

type Linear_Physics_Type
	as single Mass, InvMass
	as vec2f Frc, Acc, Vel, Psn
end type

type Angular_Physics_Type
	as single Inertia, InvInertia, Momentum
	as single Trq, Acc, Vel, Psn, Sin_Psn, Cos_Psn
end type

type Center_Of_Mass_Type
	as single Dst_Sqa, Dst_Sca
	as vec2f Dst, Dst_Hat
end type

type Graphics_Type
	as vec2f Psn
end type

type Rigid_Body_Vertex_Type
	as vec2f Init_Psn
	as Graphics_Type Gra
	as Linear_Physics_Type Lin
end type

type Rigid_Body_Face_Type
	as Rigid_Body_Vertex_Type ptr Vertex_A, Vertex_B
end type

type Rigid_Polygon_Type
	as integer Num_Vertices
	as Graphics_Type Gra
	as Linear_Physics_Type Lin
	as Angular_Physics_Type Ang
	as Rigid_Body_Vertex_Type ptr Vertex
	as Rigid_Body_Face_Type ptr Face
end type

type Rigid_Circle_Type
	as single Radius
	as Graphics_Type Gra
	as Linear_Physics_Type Lin
	as Angular_Physics_Type Ang
end type

type Player_Type
	as Vehicle_Controls_Type Controls
end type


type Game_Type
	
	declare constructor
	declare destructor
	
	as Screen_Type Scrn
	as Camera_Type Camera
	as Game_Controls_Type Controls
	as Linear_Physics_Type ptr ptr Linear_Physics_Object
	as Angular_Physics_Type ptr ptr Angular_Physics_Object
	as Player_Type ptr Player
	
	as integer Num_Linear_Physics_Objects , Num_Angular_Physics_Objects
	
	as double FPS_Timer, t0
	as integer FPS, FPS_Counter, Sleep_Time
	
	declare sub RunSimulation()
	declare sub CreateScreen( _
  	ScreenWidth as integer = 0, ScreenHeight as integer = 0, Scrn_Depth as integer = 0, _
  	Scrn_Pages as integer = 0, Scrn_Flags as integer = 0,  Scrn_Rate as integer = 0)
  
  declare sub GetFramerate()
  declare sub UpdateCamera()
  declare sub UpdateScreen()
  declare sub CollisionDetection()
	declare sub GetInput()
	declare sub GetData()
	declare sub SetForce()
	declare sub SetAcceleration()
	declare sub SetPosition()
	declare sub SetHalfVelocity()
	declare sub Integrate()
	declare sub PauseSimulation()
	
end type

''	run program
scope:  dim as Game_Type Simulation: end scope

''	constructors & destructors
constructor Game_Type
	
	CreateScreen(ScreenWidth, ScreenHeight, ScreenBitDepth)
	
'	CreateSpaceship()
	
	with Controls
		.EscapeValue 			= fb.SC_ESCAPE
		.ScrollUpValue 		= fb.SC_UP
		.ScrollDownValue	= fb.SC_DOWN
		.ScrollLeftValue	= fb.SC_LEFT
		.ScrollRightValue	= fb.SC_RIGHT
		.ZoomInValue			= fb.SC_PERIOD
		.ZoomOutValue			= fb.SC_COMMA
	end with
	
	Camera.Zoom = 1
	Camera.Psn = Scrn.Center
	
	Fps_Timer = timer
	
	RunSimulation()
	
end constructor

destructor Game_Type
	
	'DeleteSpaceship()
	
	end
	
end destructor

''	subs & functions
sub Game_Type.runsimulation()

	do
		GetInput()
		Integrate()
		GetFramerate()
		UpdateCamera()
		UpdateScreen()
		PauseSimulation()
	loop until Controls.EscapeState
	
end sub


sub Game_Type.createscreen( _
  ScreenWidth as integer 	= 0,   ScreenHeight as integer = 0, Scrn_Depth as integer = 0, _
  Scrn_Pages as integer = 0, Scrn_Flags as integer = 0, Scrn_Rate as integer 	= 0)
	
	with Scrn
		
		.Wid   = ScreenWidth
		.Hgt   = ScreenHeight
		.Depth = Scrn_Depth
		.Pages = Scrn_Pages
		.Flags = Scrn_Flags
		.Rate  = Scrn_Rate
		
		if .Wid = 0 or .Hgt = 0 then
			screeninfo .Wid, .Hgt
			.Flags or= fb.GFX_FULLSCREEN
		end if
		if .Depth = 0 then screeninfo ,, .Depth
		.Center = vec2f(.wid\2, .hgt\2)
		screenres .Wid, .Hgt, .Depth, .Pages, .Flags, .Rate
		color ScreenForegroundColor, ScreenBackgroundColor
		if .Flags and fb.GFX_FULLSCREEN then setmouse ,,0
		
	end with
	
end sub

sub Game_Type.getframerate()
	
	if timer <= Fps_Timer then
    Fps_Counter += 1
	else
    Fps = Fps_Counter
    Fps_Counter = 1
    Fps_Timer += 1
	end if
	
end sub

sub Game_Type.updatecamera()
	
	Camera.ScrollRate = CameraScrollRate/Camera.Zoom
	
	with Controls
		if .ScrollUpState 	 then Camera.Psn.Y -= Camera.ScrollRate
		if .ScrollDownState  then Camera.Psn.Y += Camera.ScrollRate
		if .ScrollLeftState  then Camera.Psn.X -= Camera.ScrollRate
		if .ScrollRightState then Camera.Psn.X += Camera.ScrollRate
		if .ZoomInState 		 then Camera.Zoom  *= CameraZoomRate
		if .ZoomOutState 		 then Camera.Zoom  /= CameraZoomRate
	end with
	
	''	clamp zoom
	if Camera.Zoom > CameraZoomMax then Camera.Zoom = CameraZoomMax
	if Camera.Zoom < CameraZoomMin then Camera.Zoom = CameraZoomMin
	
end sub

sub Game_Type.updatescreen()
	
	screenlock
		
		cls
		
		locate 2, 2: print using "###"; Fps
		
	screenunlock
	
end sub

sub Game_Type.getinput()

	''	get keyboard and/or mouse input

	''	game controls
	with Controls
		.EscapeState 			= multikey(.EscapeValue)
		.ScrollUpState		= multikey(.ScrollUpValue)
		.ScrollDownState	= multikey(.ScrollDownValue)
		.ScrollLeftState	= multikey(.ScrollLeftValue)
		.ScrollRightState	= multikey(.ScrollRightValue)
		.ZoomInState			= multikey(.ZoomInValue)
		.ZoomOutState			= multikey(.ZoomOutValue)
	end with
	
	''	player vehicle controls
	for i as integer = 0 to Num_Players-1
		with Player[i].Controls
			.LeftState  = multikey(.LeftValue)
			.RightState = multikey(.RightValue)
			.UpState		= multikey(.UpValue)
			.DownState 	= multikey(.DownValue)
			.FireState	= multikey(.FireValue)
		end with
	next

end sub

sub Game_Type.getdata()
	
end sub

sub Game_Type.setforce()
	
end sub

sub Game_Type.collisiondetection()
	
end sub

sub Game_Type.setacceleration()
	
	GetData()
	SetForce()
	CollisionDetection()
	
	for i as integer = 0 to Num_Linear_Physics_Objects-1
		with Linear_Physics_Object[i]->Lin
			.Acc = .Frc*.InvMass
		end with
	next
	
	for i as integer = 0 to Num_Angular_Physics_Objects-1
		with Angular_Physics_Object[i]->Ang
			.Acc = .Trq*.InvInertia
		end with
	next
	
end sub

sub Game_Type.setposition()
	
	for i as integer = 0 to Num_Linear_Physics_Objects-1
		with Linear_Physics_Object[i]->Lin
			.Psn += .Vel*Dt + .Acc*Dt*HalfDt
		end with
	next
		
	for i as integer = 0 to Num_Angular_Physics_Objects-1
		with Angular_Physics_Object[i]->Ang
			.Psn += .Vel*Dt + .Acc*Dt*HalfDt
    	.Cos_Psn = cos(.Psn)
    	.Sin_Psn = sin(.Psn)
    end with
	next

end sub

sub Game_Type.sethalfvelocity()
	
	for i as integer = 0 to Num_Linear_Physics_Objects-1
		with Linear_Physics_Object[i]->Lin
			.Vel += .Acc*HalfDt
		end with
	next

	for i as integer = 0 to Num_Angular_Physics_Objects-1
		with Angular_Physics_Object[i]->Ang
			.Vel += .Acc*HalfDt
		end with
	next
	
end sub

sub Game_Type.integrate()
	
	''	velocity verlet integration
	for i as integer = 1 to PhysicsSteps
		SetPosition()
		SetHalfVelocity()
		SetAcceleration()
		SetHalfVelocity()
	next
	
end sub

sub Game_Type.pausesimulation()
	
	''	calculate sleep time
	Sleep_Time = (Timestep-timer-t0)*1000
	
	''	clamp sleep time
	if Sleep_Time < 0  then Sleep_Time = 0
	if Sleep_Time > 32 then Sleep_Time = 32
	
	''	sleep
	sleep Sleep_Time, 1
	
	''	fine tune framerate
  do: loop while timer-t0 < Timestep
  t0 = timer
	
end sub
