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
Const As Single  DT                  = 1.0 / 60.0       '' time-step per loop
Const As Single  DT_SQD              = DT * DT          '' time-step squared
Const As Single  INV_DT              = 1.0 / DT         '' inverse time-step
Const As Single  INV_DT_SQD          = 1.0 / DT_SQD     '' inverse time-step squared


'' Physics
Const As Integer NUM_ITERATIONS      = 10               '' number of impulse iterations   [1, 10]

Const As Single  C_ANGULAR_STIFFNESS = 0.5              '' angular stiffness coefficient
Const As Single  C_ANGULAR_DAMPING   = 0.5              '' angular damping coefficient
Const As Single  C_ANGULAR_WARMSTART = 0.0              '' angular warm starting coefficient      [0, 1]
Const As Single  C_LINEAR_STIFFNESS  = 0.5              '' linear stiffness coefficient
Const As Single  C_LINEAR_DAMPING    = 0.5              '' linear damping coefficient
Const As Single  C_LINEAR_WARMSTART  = 0.0              '' linear warm starting coefficient      [0, 1]
Const As Single  C_FIXED_STIFFNESS   = 0.5              '' fixed-angle stiffness coefficient
Const As Single  C_FIXED_DAMPING     = 0.5              '' fixed-angle damping coefficient
Const As Single  C_FIXED_WARMSTART   = 0.0              '' fixed-angle warm starting coefficient


'' Objects
Const As Integer MAX_ANGULAR_SPRINGS = 128                ''
Const As Integer MAX_BODYS           = 128                ''
Const As Integer MAX_FIXED_SPRINGS   = 256                ''
Const As Integer MAX_KEPLER_ORBITS   = 64                ''
Const As Integer MAX_LINEAR_SPRINGS  = 256                ''
Const As Integer MAX_LINE_SEGMENTS   = 256                ''
Const As Integer MAX_NEWTON_GRAVITYS = 256                ''
Const As Integer MAX_PARTICLES       = 512                ''
Const As Integer MAX_PRESSURE_BODYS  = 64                ''
Const As Integer MAX_ROTATES         = 128                ''
Const As Integer MAX_SPRING_BODYS    = 64                ''


'' Screen
Const As Integer SCREEN_WIDTH        = 800              '' width  (0 = autodetect)
Const As Integer SCREEN_HEIGHT       = 0                '' height (0 = autodetect)
Const As Integer SCREEN_BIT_DEPTH    = 32               '' bit depth


'' Camera
Const As Single  CAMERA_ZOOM_MAX     = 1.0              ''
Const As Single  CAMERA_ZOOM_MIN     = 0.0001           ''
Const As Single  CAMERA_ZOOM_RATE    = 0.125            ''
Const As Single  CAMERA_SCROLL_RATE  = 0.125            ''


'' Math
Const As Single  PI                  = 4.0 * Atn( 1.0 ) '' pi
Const As Single  TWO_PI              = 2.0 * PI         '' two pi
Const As Single  E                   = Exp( 1.0 )       '' e


'' Scientific
Const As Single  C                   = 299792458.0      '' speed of light
Const As Single  G                   = 1.0E5             '' gravitational constant


#EndIf ''__R2_GLOBAL_CONSTANTS_BI__
