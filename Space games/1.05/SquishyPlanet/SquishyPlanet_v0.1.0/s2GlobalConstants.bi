''*******************************************************************************
''    
''   Squishy2D Global Constants
''   Written in FreeBASIC 1.04
''   version 0.1.0, October 2015, Michael "h4tt3n" Nissen
''    
''*******************************************************************************


''
#Ifndef __S2_GLOBAL_CONSTANTS_BI__
#Define __S2_GLOBAL_CONSTANTS_BI__


'' Time
Const As Single  DT                  = 1.0 / 60.0       ''
Const As Single  DT_SQUARED          = DT * DT          ''
Const As Single  INVERSE_DT          = 1.0 / DT         ''
Const As Single  INVERSE_DT_SQUARED  = 1.0 / DT_SQUARED ''


'' Physics
Const As Integer NUM_ITERATIONS      = 4                ''  number of velocity iterations  [1, 10]
Const As Single  COEFF_CORRECTIVE    = 0.5              ''  corrective impulse coefficient  [0, 1]
Const As Single  COEFF_WARMSTART     = 0.5              ''  warm starting coefficient       [0, 1]


'' Objects
Const As Integer MAX_ANGULAR_SPRINGS = 512
Const As Integer MAX_BODYS           = 512
Const As Integer MAX_FIXED_ANGLE_SPRINGS = 1024
Const As Integer MAX_LINEAR_SPRINGS  = 1024
Const As Integer MAX_LINE_SEGMENTS   = 2048
Const As Integer MAX_POINT_MASSES    = 2048


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
Const As Single  G                   = 1.0              '' gravitational constant


#EndIf ''__R2_GLOBAL_CONSTANTS_BI__