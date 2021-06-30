''*******************************************************************************
''    
''    Freebasic library of commonly used math, physics, and game constants 
''    version 0.01b, february 2013
''    Michael "h4tt3n" Nissen, jernmager@yahoo.dk
''    
''*******************************************************************************



''***************************************************************************
''  Screen & camera constants
''***************************************************************************

Const As Integer SCREEN_WIDTH  = 800
Const As Integer SCREEN_HEIGHT = 600



''***************************************************************************
''  Simulation & timestep constants
''***************************************************************************

Const As Integer NUM_ITERATIONS     = 10
Const As Double  TIMESTEP           = 1.0 / 60.0
Const As Double  DT                 = TIMESTEP / NUM_ITERATIONS
Const As Double  DT_SQUARED         = DT * DT
Const As Double  INVERSE_DT         = 1.0 / DT
Const As Double  INVERSE_DT_SQUARED = 1.0 / DT_SQUARED



''***************************************************************************
''	Mathematical constants
''***************************************************************************

Const As Double  PI          = 4.0 * Atn ( 1.0 )    ''	pi (radians in half circle)
Const As Double  TWO_PI      = 2.0 * PI             ''	two pi (radians in full circle)
Const As Double  HALF_PI     = 0.5 * PI             ''	half pi (radians in quadrant)
Const As Double  E           = Exp ( 1.0 )          '' e

Const As Byte    FALSE       = 0                    '' Boolean false
Const As Byte    TRUE        = Not FALSE            '' Boolean true



''***************************************************************************
''  Scientific constants
''***************************************************************************

Const As Double  C = 299792458.0          '' Speed of light
Const As Double  G = 6.67384 * 10 ^ -11   '' Gravitational constant

