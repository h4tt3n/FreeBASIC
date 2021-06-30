''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 7, february 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  Global constants, enums, flags etc.
''
''*******************************************************************************

'' Constants
Const As Single  DT            = 1.0 / 60.0       ''  timestep
Const As Single  INV_DT        = 1.0 / DT         ''  inv timestep
Const As Single  C_GRAVITY     = 10000.0         ''  gravity
Const As Single  C_DENSITY     = 0.02             ''  ball C_DENSITY
Const As Single  PI            = 4.0 * Atn( 1.0 ) ''  pi
Const As Single  TWO_PI        = 2.0 * PI         ''  radians in circle
Const As Integer screen_wid    = 1200             ''  screen wiDTh
Const As Integer screen_hgt    = 900              ''  screen height
Const As Integer pick_distance = 128^2            ''  mouse pick up distance

'' Number of objects in memory
Const As Integer MAX_LINEAR_STATES         = 4096 ''  
Const As Integer MAX_ROXELS                = 4096 ''  
Const As Integer MAX_ROXELS_IN_BODY        = 1024 ''  
Const As Integer MAX_LINEAR_STATES_IN_BODY = 1024 ''
Const As Integer MAX_FIXED_SPRINGS_IN_BODY = 1024 ''
Const As Integer MAX_ROXEL_BODYS           = 128  ''  
Const As Integer MAX_SHAPE_BODYS           = 128  ''  
Const As Integer MAX_SOFT_BODYS            = 128  ''  
Const As Integer MAX_GRAVITYS              = 2048 ''  
Const As Integer MAX_ORBITS                = 128  ''  
Const As Integer MAX_LINEAR_SPRINGS        = 4096 ''
Const As Integer MAX_ANGULAR_SPRINGS       = 4096 ''
'Const As Integer MAX_FIXED_SPRINGS         = 4096 ''  

'' Coefficients
Const As Single DEFAULT_LINEAR_STIFFNESS  = 0.2
Const As Single DEFAULT_LINEAR_DAMPING    = 1.0
Const As Single DEFAULT_LINEAR_WARMSTART  = 0.5
Const As Single DEFAULT_ANGULAR_STIFFNESS = 0.2
Const As Single DEFAULT_ANGULAR_DAMPING   = 1.0
Const As Single DEFAULT_ANGULAR_WARMSTART = 0.5

''
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

Enum MATERIAL_TYPES
	
	STONE = 0
	METAL
	WATER
	
End Enum

Enum TREE_TYPES
	
	SCOTS_PINE = 0
	NORWAY_SPRUCE
	
End Enum

'' Flags
