''******************************************************************************
''    
''   Squishy2D Global Constants
''   Written in FreeBASIC 1.05
''   version 0.2.0, May 2016, Michael "h4tt3n" Nissen
''    
''******************************************************************************


''
#Ifndef __S2_GLOBAL_CONSTANTS_BI__
#Define __S2_GLOBAL_CONSTANTS_BI__


'' Time
Const As Single   DT                  = 1.0 / 60.0       '' timestep per loop
Const As Single   DT_SQD              = DT * DT          '' timestep squared
Const As Single   INV_DT              = 1.0 / DT         '' inverse timestep
Const As Single   INV_DT_SQD          = 1.0 / DT_SQD     '' inverse timestep squared


'' Physics
Const As Integer  NUM_ITERATIONS      = 8                '' number of impulse iterations   [1, 10]
Const As Single   C_ANGULAR_STIFFNESS = 0.0              '' angular stiffness coefficient
Const As Single   C_ANGULAR_DAMPING   = 0.0              '' angular damping coefficient
Const As Single   C_ANGULAR_WARMSTART = 0.0              '' angular warm starting coefficient      [0, 1]
Const As Single   C_FIXED_STIFFNESS   = 0.5              '' fixed-angle stiffness coefficient
Const As Single   C_FIXED_DAMPING     = 0.5              '' fixed-angle damping coefficient
Const As Single   C_FIXED_WARMSTART   = 0.5              '' fixed-angle warm starting coefficient
Const As Single   C_LINEAR_STIFFNESS  = 0.5              '' linear stiffness coefficient
Const As Single   C_LINEAR_DAMPING    = 0.5              '' linear damping coefficient
Const As Single   C_LINEAR_WARMSTART  = 0.5              '' linear warm starting coefficient      [0, 1]


'' Objects
Const As Integer  MAX_ANGULAR_SPRINGS = 8192                ''
Const As Integer  MAX_BODYS           = 128                ''
Const As Integer  MAX_FIXED_SPRINGS   = 256                ''
Const As Integer  MAX_KEPLER_ORBITS   = 128                ''
Const As Integer  MAX_LINEAR_SPRINGS  = 8192                ''
Const As Integer  MAX_LINE_SEGMENTS   = 256                ''
Const As Integer  MAX_NEWTON_GRAVITYS = 256                ''
Const As Integer  MAX_PARTICLES       = 8192              ''
Const As Integer  MAX_PRESSURE_BODYS  = 128                ''
Const As Integer  MAX_ROTATES         = 128                ''
Const As Integer  MAX_SPRING_BODYS    = 128                ''


'' Grid / Cells
Const As Integer CELL_DIAMETER        = 32                          ''
Const As Integer MAX_NUM_CELLS        = 1000000                          ''
Const As Integer MAX_PARTICLES_CELL   = 32                          ''
Const As Integer NUM_CELLS_X          = 1000                        ''
Const As Integer NUM_CELLS_Y          = 1000                        ''
Const As Integer NUM_CELLS            = NUM_CELLS_X * NUM_CELLS_Y   ''


'' Math / Science
Const As Single   PI                  = 4.0 * Atn( 1.0 )  '' pi
Const As Single   TWO_PI              = 2.0 * PI          '' two pi
Const As Single   G                   = 1.0E2             '' gravitational constant


'' Flags
Const As Integer IS_ACTIVE            = 1               '' True = active,  False = inactive
Const As Integer IS_DYNAMIC           = 2               '' True = dynamic, False = static / locked
Const As Integer IS_VISIBLE           = 4               '' True = visible, False = invisible
Const As Integer IS_EXPENSIVE         = 8               '' 
Const As Integer IS_MOTOR             = 16              '' 



#EndIf ''__S2_GLOBAL_CONSTANTS_BI__
