''******************************************************************************
''    
''   SquishyPlanet - A 2D soft body and space physics library for games
''   Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''   Version 0.7.0, December 2016
''
''   Author:
''   Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''   Description:
''    
''******************************************************************************


''
#Ifndef __S2_CONSTANTS_BI__
#Define __S2_CONSTANTS_BI__

''
#Define NULL 0

'' Time
Const As Single   DT                  = 1.0 / 60.0       '' timestep per loop
Const As Single   DT_SQD              = DT * DT          '' timestep squared
Const As Single   INV_DT              = 1.0 / DT         '' inverse timestep
Const As Single   INV_DT_SQD          = 1.0 / DT_SQD     '' inverse timestep squared


'' Physics
Const As Integer  NUM_ITERATIONS      = 4                '' number of impulse iterations   [1, 10]
Const As Single   C_ANGULAR_STIFFNESS = 0.0              '' angular stiffness coefficient
Const As Single   C_ANGULAR_DAMPING   = 0.0              '' angular damping coefficient
Const As Single   C_ANGULAR_WARMSTART = 0.0              '' angular warm starting coefficient      [0, 1]
Const As Single   C_FIXED_STIFFNESS   = 0.001              '' fixed-angle stiffness coefficient
Const As Single   C_FIXED_DAMPING     = 0.01              '' fixed-angle damping coefficient
Const As Single   C_FIXED_WARMSTART   = 0.0              '' fixed-angle warm starting coefficient
Const As Single   C_LINEAR_STIFFNESS  = 0.5              '' linear stiffness coefficient
Const As Single   C_LINEAR_DAMPING    = 0.5              '' linear damping coefficient
Const As Single   C_LINEAR_WARMSTART  = 0.5              '' linear warm starting coefficient      [0, 1]


'' Objects
Const As Integer  MAX_ANGULAR_SPRINGS = 8192                ''
Const As Integer  MAX_BODYS           = 128                ''
Const As Integer  MAX_FIXED_SPRINGS   = 256                ''
Const As Integer  MAX_KEPLER_ORBITS   = 128                ''
Const As Integer  MAX_LINEAR_SPRINGS  = 8192                ''
Const As Integer  MAX_LINEAR_LINKS    = 1024                ''
Const As Integer  MAX_NEWTON_GRAVITYS = 1024                ''
Const As Integer  MAX_LINEAR_STATES   = 8192              ''
Const As Integer  MAX_ANGULAR_STATES  = 128                ''
Const As Integer  MAX_SOFT_BODYS      = 128                ''
Const As Integer  MAX_RIGID_BODYS     = 128                ''
Const As Integer  MAX_SHAPE_BODYS     = 128                ''


'' Grid / Cells
Const As Integer CELL_DIAMETER        = 32                          ''
Const As Integer MAX_NUM_CELLS        = 1000                          ''
Const As Integer MAX_PARTICLES_CELL   = 32                          ''
Const As Integer NUM_CELLS_X          = 10                        ''
Const As Integer NUM_CELLS_Y          = 10                        ''
Const As Integer NUM_CELLS            = NUM_CELLS_X * NUM_CELLS_Y   ''


'' Math / Science
Const As Single   PI                  = 4.0 * Atn( 1.0 )  '' pi
Const As Single   TWO_PI              = 2.0 * PI          '' two pi
Const As Single   G                   = 1.0E-1             '' gravitational constant
Const As Integer  CW                  = -1
Const As Integer  CCW                 = 1
Const As Integer  RIGHT_HAND          = -1
Const As Integer  LEFT_HAND           = 1


'' Bitflags
Const As UInteger IS_ACTIVE            = 1               '' True = active,  False = inactive
Const As UInteger IS_DYNAMIC           = 2               '' True = dynamic, False = static / locked
Const As UInteger IS_VISIBLE           = 4               '' True = visible, False = invisible
Const As UInteger IS_CONTROLLABLE      = 8               '' 
Const As UInteger IS_EXPENSIVE         = 16               '' 
Const As UInteger IS_COLLIDABLE        = 32              '' 


'' Version
Const As Integer VERSION_MAJOR        = 0
Const As Integer VERSION_MINOR        = 7
Const As Integer VERSION_REV          = 0


#EndIf ''__S2_CONSTANTS_BI__
