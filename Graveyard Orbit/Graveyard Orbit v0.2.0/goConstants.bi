''******************************************************************************
''    
''  Graveyard Orbit - A 2D space physics puzzle game
''
''  Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''  Version 0.2.0, May 1. 2017
''  
''  Author:
''  Michael "h4tt3n" Schmidt Nissen, michaelschmidtnissen@gmail.com
''    
''******************************************************************************


''
#Ifndef __GO_CONSTANTS_BI__
#Define __GO_CONSTANTS_BI__


'' Number of Objects
Const As Integer  MAX_PLANETS      =  1024                ''
Const As Integer  MAX_ROCKETS      =    32                ''
Const As Integer  MAX_ROXELS       =  8192               ''
Const As Integer  MAX_SPACE_SHIPS  =    32               ''
Const As Integer  MAX_THRUSTERS    =   128               ''

'' Screen
Const As Integer  SCREEN_WIDTH     =   1000               '' width  (0 = autodetect)
Const As Integer  SCREEN_HEIGHT    =   700               '' height (0 = autodetect)
Const As Integer  SCREEN_BIT_DEPTH =    32               '' bit depth
Const As UInteger SCREEN_FLAGS     =     0               '' bit depth

'' Camera
'Const As Single   CAMERA_ZOOM_MAX     =   100.0               ''
'Const As Single   CAMERA_ZOOM_MIN     =     1.0            ''
'Const As Single   CAMERA_ZOOM_RATE    =     0.08             ''
'Const As Single   CAMERA_SCROLL_RATE  =     0.08             ''

'' Planet
Const As Single PLANET_DENSITY = 1000.0

'' Rocket
Const As Single  ROCKET_EXHAUST_VELOCITY   = 10000.0
Const As Single  ROCKET_FUEL_FLOW_RATE     = 0.1
Const As Single  ROCKET_THRUST             = 1.0
Const As Single  ROCKET_DELTA_ANGLE        = 0.002
Const As Integer MAX_ENGINES_IN_SPACE_SHIP = 8

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

'' 
Enum PLANT_TYPES
	
	PLANT_01 = 1
	PLANT_02
	PLANT_03
	PLANT_04
	PLANT_05
	PLANT_06
	
End Enum

''
Enum MATERIAL_TYPES
	
	ROCK        = 1
	METAL
	EMERALD
	MATERIAL_04
	MATERIAL_05
	MATERIAL_06
	
End Enum


#EndIf __GO_CONSTANTS_BI__
