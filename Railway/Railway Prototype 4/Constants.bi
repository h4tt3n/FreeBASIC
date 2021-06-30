''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 4, september 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  Global constants, enums, bitflags etc.
''
''*******************************************************************************

'' Constants
Const As Single  DT            = 1.0 / 60.0       ''  timestep
Const As Single  INV_DT        = 1.0 / DT         ''  inv timestep
Const As Single  C_GRAVITY     = -10.0           ''  gravity
Const As Single  C_DENSITY     = 0.02             ''  ball C_DENSITY
Const As Single  PI            = 4.0 * Atn( 1.0 ) ''  pi
Const As Single  TWO_PI        = 2.0 * PI         ''  radians in circle
Const As Single  FLOAT_MAX     = 1.0E38           ''  highest single float number ~ infinite

'' Screen
Const As Integer  SCREEN_WIDTH     =   1000               '' width  (0 = autodetect)
Const As Integer  SCREEN_HEIGHT    =   700               '' height (0 = autodetect)
Const As Integer  SCREEN_BIT_DEPTH =    32               '' bit depth
Const As ULong    SCREEN_FLAGS     =     0               '' bit depth

'' Camera
'Const As Single   CAMERA_ZOOM_MAX     =   100.0               ''
'Const As Single   CAMERA_ZOOM_MIN     =     1.0            ''
'Const As Single   CAMERA_ZOOM_RATE    =     0.08             ''
'Const As Single   CAMERA_SCROLL_RATE  =     0.08             ''

''
Const As Integer pick_distance = 128^2            ''  mouse pick up distance

'' Number of objects in memory
Const As Integer MAX_LINEAR_STATES         = 1024 ''  
Const As Integer MAX_ROXELS                = 1024 ''  
Const As Integer MAX_ROXELS_IN_BODY        = 512 ''  
Const As Integer MAX_LINEAR_STATES_IN_BODY = 512 ''
Const As Integer MAX_FIXED_SPRINGS_IN_BODY = 512 ''
Const As Integer MAX_SOFT_BODYS            = 128  ''   
Const As Integer MAX_LINEAR_SPRINGS        = 1024 ''
Const As Integer MAX_ANGULAR_SPRINGS       = 1024 ''
Const As Integer MAX_BOXES                 = 1024 ''
Const As Integer MAX_WHEELS                = 1024 ''
Const As Integer MAX_REVOLUTE_CONSTRAINTS  = 128 ''
Const As Integer MAX_DISTANCE_CONSTRAINTS  = 128 ''
Const As Integer MAX_ANGULAR_CONSTRAINTS   = 128 ''
Const As Integer MAX_SLIDE_CONSTRAINTS     = 128 ''
Const As Integer MAX_GEAR_CONSTRAINTS      = 128 ''
Const As Integer MAX_WINCH_CONSTRAINTS     = 128
'Const As Integer MAX_FIXED_SPRINGS         = 4096 ''  

'' Coefficient default values

'' Springs (between particles)
Const As Single DEFAULT_LINEAR_SPRING_STIFFNESS = 0.2
Const As Single DEFAULT_LINEAR_SPRING_DAMPING   = 1.0
Const As Single DEFAULT_LINEAR_SPRING_WARMSTART = 0.5

Const As Single DEFAULT_ANGULAR_SPRING_STIFFNESS = 0.5
Const As Single DEFAULT_ANGULAR_SPRING_DAMPING   = 1.0
Const As Single DEFAULT_ANGULAR_SPRING_WARMSTART = 0.5

'' Constraints (between rigid bodies)
Const As Single DEFAULT_ANGULAR_CONSTRAINT_STIFFNESS = 0.2
Const As Single DEFAULT_ANGULAR_CONSTRAINT_DAMPING   = 1.0
Const As Single DEFAULT_ANGULAR_CONSTRAINT_WARMSTART = 0.5

Const As Single DEFAULT_DISTANCE_CONSTRAINT_STIFFNESS = 0.5
Const As Single DEFAULT_DISTANCE_CONSTRAINT_DAMPING   = 1.0
Const As Single DEFAULT_DISTANCE_CONSTRAINT_WARMSTART = 0.5

Const As Single DEFAULT_GEAR_CONSTRAINT_STIFFNESS = 0.5
Const As Single DEFAULT_GEAR_CONSTRAINT_DAMPING   = 1.0
Const As Single DEFAULT_GEAR_CONSTRAINT_WARMSTART = 0.5

Const As Single DEFAULT_REVOLUTE_CONSTRAINT_STIFFNESS = 0.5
Const As Single DEFAULT_REVOLUTE_CONSTRAINT_DAMPING   = 1.0
Const As Single DEFAULT_REVOLUTE_CONSTRAINT_WARMSTART = 0.5

Const As Single DEFAULT_SLIDE_CONSTRAINT_STIFFNESS = 0.2
Const As Single DEFAULT_SLIDE_CONSTRAINT_DAMPING   = 1.0
Const As Single DEFAULT_SLIDE_CONSTRAINT_WARMSTART = 0.5

''
Const As Single DEFAULT_DYNAMIC_FRICTION = 0.1
Const As Single DEFAULT_ROLLING_FRICTION = 0.9
Const As Single DEFAULT_STATIC_FRICTION  = 1.0

Const As Single DEFAULT_COLLISION_STIFFNESS = 0.2
Const As Single DEFAULT_COLLISION_DAMPING   = 0.5
Const As Single DEFAULT_COLLISION_WARMSTART = 0.5

Const As Single DEFAULT_DENSITY = 1.0

''
Const As Single STATIC_FRICTION_VELOCITY  = 0.1
Const As Single MIN_ANGULAR_IMPULSE = 0.0001

'' Enums
Enum GIRDER_TYPES
	
	S_TRUSS = 0
	Z_TRUSS
	V_TRUSS
	X_TRUSS
	K_TRUSS
	O_TRUSS
	W_TRUSS
	
End Enum

Enum TREE_TYPES
	
	SCOTS_PINE = 0
	NORWAY_SPRUCE
	
End Enum

'' Bit flags ( 16 flags in USHORT, 32 flags in ULONG, 64 flags in ULONGINT )
Const As ULong IS_ALIVE            = 2^0        '' True = active,  False = inactive
Const As ULong IS_DYNAMIC          = 2^1        '' True = dynamic, False = static / kinematic
Const As ULong IS_AWAKE            = 2^2        '' True = awake, False = asleep
Const As ULong IS_VISIBLE          = 2^3        '' True = visible, False = invisible
Const As ULong IS_CONTROLLABLE     = 2^4        '' Movement can be controlled by player
Const As ULong IS_EXPENSIVE        = 2^5        '' Uses CPU-expensive functions
Const As ULong IS_COLLIDABLE       = 2^6        '' Collides with other objects
Const As ULong IS_PRESSURIZED      = 2^7        '' Body uses area-preserving pressure
Const As ULong IS_RIGID            = 2^8        '' True = rigid body, False = soft / pressurized body
Const As ULong IS_ANGULAR          = 2^9        '' 
Const As ULong IS_11               = 2^10       '' 
Const As ULong IS_12               = 2^11       '' 
Const As ULong IS_13               = 2^12       '' 
Const As ULong IS_14               = 2^13       '' 
Const As ULong IS_15               = 2^14       '' 
Const As ULong IS_16               = 2^15       '' 
Const As ULong IS_17               = 2^16       '' 
Const As ULong IS_18               = 2^17       '' 
Const As ULong IS_19               = 2^18       '' 
Const As ULong IS_20               = 2^19       '' 
Const As ULong IS_21               = 2^20       '' 
Const As ULong IS_22               = 2^21       '' 
Const As ULong IS_23               = 2^22       '' 
Const As ULong IS_24               = 2^23       '' 
Const As ULong IS_25               = 2^24       '' 
Const As ULong IS_26               = 2^25       '' 
Const As ULong IS_27               = 2^26       '' 
Const As ULong IS_28               = 2^27       '' 
Const As ULong IS_29               = 2^28       '' 
Const As ULong IS_30               = 2^29       '' 
Const As ULong IS_31               = 2^30       '' 
Const As ULong IS_32               = 2^31       '' 


