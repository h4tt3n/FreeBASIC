''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 7, february 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  Controls:
''  
''  Puzzles     :  numerical keys
''  Exit demo   :  Escape key
''
'' Todo:
''
'' -Rigid body class
'' -Thruster class
'' -Ship class
'' -Ship auto-pilot
'' -Collision detection & response. AABB, grid, SAT + MTV
'' -Use SDL2 library
''
'' Bugs:
''
''
''******************************************************************************* 

#Pragma Once

'' Includes
#Include "fbgfx.bi"

''
#Include "../../Math/Vec2.bi"
#Include "../../Math/Mat22.bi"

''
#Include "Containers.bi"
#Include "Constants.bi"
#Include "LinearState.bi"
#Include "AngularState.bi"
#Include "LinearLink.bi"
#Include "Gravity.bi"
#Include "Orbit.bi"
#Include "LinearSpring.bi"
#Include "FixedSpring.bi"
#Include "AngularSpring.bi"
#Include "Roxel.bi"
#Include "RoxelRoxelCR.bi"

''
DynamicArrayType( LinearStateArray, LinearStateType )
DynamicArrayType( RoxelArray, RoxelType )
DynamicArrayType( GravityArray, GravityType )
DynamicArrayType( OrbitArray, OrbitType )
DynamicArrayType( LinearSpringArray, LinearSpringType )
DynamicArrayType( FixedSpringArray, FixedSpringType )
DynamicArrayType( AngularSpringArray, AngularSpringType )

''
#Include "Game.bi"
#Include "Create.bi"
#Include "Puzzles.bi"

''	Create instance and run game
Scope

	Static As GameType ThisGame

End Scope

