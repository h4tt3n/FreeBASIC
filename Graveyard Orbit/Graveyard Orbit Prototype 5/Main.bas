''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 5, june 2018
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

''
DynamicArrayType( LinearStateArray, LinearStateType )
DynamicArrayType( RoxelArray, RoxelType )
DynamicArrayType( GravityArray, GravityType )
DynamicArrayType( OrbitArray, OrbitType )
DynamicArrayType( LinearSpringArray, LinearSpringType )
DynamicArrayType( FixedSpringArray, FixedSpringType )
DynamicArrayType( AngularSpringArray, AngularSpringType )

''
#Include "RoxelBody.bi"
#Include "ShapeBody.bi"
#Include "SoftBody.bi"

''
DynamicArrayType( RoxelBodyArray, RoxelBodyType )
DynamicArrayType( ShapeBodyArray, ShapeBodyType )
DynamicArrayType( SoftBodyArray, SoftBodyType )

''
#Include "Game.bi"
#Include "create.bi"
#Include "puzzles.bi"

''	Create instance and run game
Scope

	Static As GameType ThisGame

End Scope

