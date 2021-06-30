''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 1, october 2018
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  Global constants, enums, bitflags etc.
''
''*******************************************************************************

'' Constants
Const As Single  DT            = 1.0 / 60.0       ''  timestep
Const As Single  INV_DT        = 1.0 / DT         ''  inv timestep
Const As Single  C_GRAVITY     = 10.0           ''  gravity
Const As Single  C_DENSITY     = 0.02             ''  ball C_DENSITY
Const As Single  PI            = 4.0 * Atn( 1.0 ) ''  pi
Const As Single  TWO_PI        = 2.0 * PI         ''  radians in circle
Const As Single  FLOAT_MAX     = 1.0E38           ''  highest single float number ~ infinite

''
Const As Integer screen_wid    = 1200             ''  screen wiDTh
Const As Integer screen_hgt    = 800              ''  screen height
Const As Integer pick_distance = 128^2            ''  mouse pick up distance

'' Number of objects in memory
Const As Integer MAX_LINEAR_STATES         = 4096 ''  
Const As Integer MAX_ROXELS                = 4096 ''  
Const As Integer MAX_ROXELS_IN_BODY        = 1024 ''  
Const As Integer MAX_LINEAR_STATES_IN_BODY = 1024 ''
Const As Integer MAX_FIXED_SPRINGS_IN_BODY = 1024 ''
Const As Integer MAX_ROXEL_BODYS           = 128  ''  
Const As Integer MAX_SOFT_BODYS            = 128  ''   
Const As Integer MAX_LINEAR_SPRINGS        = 4096 ''
Const As Integer MAX_ANGULAR_SPRINGS       = 4096 ''
Const As Integer MAX_BOXES                 = 4096 ''
Const As Integer MAX_WHEELS                = 4096 ''
Const As Integer MAX_REVOLUTE_JOINTS       = 128 ''
Const As Integer MAX_DISTANCE_JOINTS       = 128 ''
Const As Integer MAX_ANGULAR_JOINTS        = 128 ''
Const As Integer MAX_SLIDE_JOINTS          = 128 ''
'Const As Integer MAX_FIXED_SPRINGS         = 4096 ''  

'' Coefficient default values
Const As Single DEFAULT_LINEAR_STIFFNESS = 0.2
Const As Single DEFAULT_LINEAR_DAMPING   = 1.0
Const As Single DEFAULT_LINEAR_WARMSTART = 0.5

Const As Single DEFAULT_ANGULAR_STIFFNESS = 0.2
Const As Single DEFAULT_ANGULAR_DAMPING   = 1.0
Const As Single DEFAULT_ANGULAR_WARMSTART = 0.5

Const As Single DEFAULT_JOINT_STIFFNESS = 0.5
Const As Single DEFAULT_JOINT_DAMPING   = 1.0
Const As Single DEFAULT_JOINT_WARMSTART = 0.5

Const As Single DEFAULT_DYNAMIC_FRICTION = 0.2
Const As Single DEFAULT_STATIC_FRICTION  = 1.0

Const As Single DEFAULT_COLLISION_STIFFNESS = 0.5
Const As Single DEFAULT_COLLISION_DAMPING   = 0.5

Const As Single DEFAULT_DENSITY = 1.0

''
Const As Single STATIC_FRICTION_VELOCITY  = 0.0001
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

'' Bit flags
Const As UInteger IS_ALIVE            = 2^0        '' True = active,  False = inactive
Const As UInteger IS_DYNAMIC          = 2^1        '' True = dynamic, False = static / kinematic
Const As UInteger IS_AWAKE            = 2^2        '' True = awake, False = asleep
Const As UInteger IS_VISIBLE          = 2^3        '' True = visible, False = invisible
Const As UInteger IS_CONTROLLABLE     = 2^4        '' Movement can be controlled by player
Const As UInteger IS_EXPENSIVE        = 2^5        '' Uses CPU-expensive functions
Const As UInteger IS_COLLIDABLE       = 2^6        '' Collides with other objects
Const As UInteger IS_PRESSURIZED      = 2^7        '' Body uses area-preserving pressure
Const As UInteger IS_RIGID            = 2^8        '' True = rigid body, False = soft / pressurized body
Const As UInteger IS_ANGULAR          = 2^9        '' 
Const As UInteger IS_11               = 2^10       '' 
Const As UInteger IS_12               = 2^11       '' 
Const As UInteger IS_13               = 2^12       '' 
Const As UInteger IS_14               = 2^13       '' 
Const As UInteger IS_15               = 2^14       '' 
Const As UInteger IS_16               = 2^15       '' 

