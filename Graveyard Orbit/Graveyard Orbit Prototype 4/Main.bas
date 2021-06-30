''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 4, july 2017
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  Controls:
''  
''  Puzzles                    :  F1 - F6
''  Inc. / dec. iterations     :  I + up / down
''  Inc. / dec. stiffness      :  S + up / down
''  Inc. / dec. damping        :  D + up / down
''  Inc. / dec. warmstart      :  W + up / down
''  Warmstart on / off         :  Space bar
''  Exit demo                  :  Escape key
''
'' Todo:
''
'' 
''
''******************************************************************************* 


''   Global constants
Const As Single  DT            = 1.0 / 60.0       ''  timestep
Const As Single  INV_DT        = 1.0 / DT         ''  inv timestep
Const As Single  C_GRAVITY     = 1.0e-002         ''  gravity
Const As Single  C_DENSITY     = 0.02             ''  ball C_DENSITY
Const As Single  PI            = 4.0 * Atn( 1.0 ) ''  pi
Const As Single  TWO_PI        = 2.0 * PI         ''  radians in circle
Const As Integer screen_wid    = 1100             ''  screen wiDTh
Const As Integer screen_hgt    = 700              ''  screen height
Const As Integer pick_distance = 128^2            ''  mouse pick up distance

Const As Integer MAX_LINEAR_STATES         = 4096 '' 
'Const As Integer MAX_ANGULAR_STATES        = 2048 ''  
Const As Integer MAX_ROXELS                = 4096 ''  
Const As Integer MAX_ROXELS_IN_BODY        = 1024 ''  
Const As Integer MAX_LINEAR_STATES_IN_BODY = 1024 ''
Const As Integer MAX_FIXED_SPRINGS_IN_BODY = 1024 ''
Const As Integer MAX_ROXEL_BODYS           = 128  ''  
Const As Integer MAX_SHAPE_BODYS           = 128  ''  
Const As Integer MAX_GRAVITYS              = 2048 ''  
Const As Integer MAX_ORBITS                = 128  ''  
Const As Integer MAX_LINEAR_SPRINGS        = 4096 ''  
'Const As Integer MAX_FIXED_SPRINGS         = 4096 ''  

Const As Single MIN_ANGULAR_IMPULSE       = 1.0e-003

Enum GIRDER_TYPES
	
	S_TRUSS = 0
	Z_TRUSS
	V_TRUSS
	X_TRUSS
	K_TRUSS
	O_TRUSS
	W_TRUSS
	
End Enum

#Pragma Once

'' Includes
#Include "fbgfx.bi"

#Include "../../Math/Vec2.bi"
#Include "../../Math/Mat22.bi"

#Include "Containers.bi"

#Include "LinearState.bi"
#Include "AngularState.bi"
#Include "LinearLink.bi"

#Include "Gravity.bi"
#Include "Orbit.bi"
#Include "LinearSpring.bi"
#Include "FixedSpring.bi"

#Include "Roxel.bi"

DynamicArrayType( LinearStateArray, LinearStateType )
DynamicArrayType( RoxelArray, RoxelType )
DynamicArrayType( GravityArray, GravityType )
DynamicArrayType( OrbitArray, OrbitType )
DynamicArrayType( LinearSpringArray, LinearSpringType )
DynamicArrayType( FixedSpringArray, FixedSpringType )

#Include "RoxelBody.bi"
#Include "ShapeBody.bi"

DynamicArrayType( RoxelBodyArray, RoxelBodyType )
DynamicArrayType( ShapeBodyArray, ShapeBodyType )

#Include "Game.bi"

#Include "create.bi"
#Include "puzzles.bi"

''	Create instance and run game
Scope

	Static As GameType ThisGame

End Scope

