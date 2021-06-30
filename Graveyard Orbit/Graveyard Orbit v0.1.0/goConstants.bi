''******************************************************************************
''    
''  Graveyard Orbit - A 2D space physics puzzle game
''
''  Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''  Version 0.1.0, October 31. 2016
''  
''  Author:
''  Michael "h4tt3n" Schmidt Nissen, michaelschmidtnissen@gmail.com
''    
''******************************************************************************


''
#Ifndef __GO_CONSTANTS_BI__
#Define __GO_CONSTANTS_BI__


'' Number of Objects
Const As Integer  MAX_ENGINES =   128                ''
Const As Integer  MAX_PLANETS =  1024                ''
Const As Integer  MAX_ROCKETS =    32                ''
Const As Integer  MAX_ROXELS  =  4096               ''


'' Screen
Const As Integer  SCREEN_WIDTH        =   1200               '' width  (0 = autodetect)
Const As Integer  SCREEN_HEIGHT       =   800               '' height (0 = autodetect)
Const As Integer  SCREEN_BIT_DEPTH    =    16                '' bit depth
Const As UInteger SCREEN_FLAGS        =    0'fb.GFX_FULLSCREEN                '' bit depth


'' Camera
'Const As Single   CAMERA_ZOOM_MAX     =   100.0               ''
'Const As Single   CAMERA_ZOOM_MIN     =     1.0            ''
'Const As Single   CAMERA_ZOOM_RATE    =     0.08             ''
'Const As Single   CAMERA_SCROLL_RATE  =     0.08             ''

'' Planet
Const As Single PLANET_DENSITY = 1000.0

'' Rocket
Const As Single ROCKET_THRUST_IMPULSE = 1.0
Const As Single ROCKET_DELTA_ANGLE    = 0.006

'' Girder truss types
Enum GIRDER_TYPES
	
	S_TRUSS = 1
	Z_TRUSS
	V_TRUSS
	X_TRUSS
	K_TRUSS
	O_TRUSS
	W_TRUSS
	
End Enum


#EndIf __GO_CONSTANTS_BI__