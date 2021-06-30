''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 1, october 2018
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  Controls:
''  
''  Puzzles     :  numerical keys 0-9
''  Exit demo   :  Escape key
''
'' Todo:
''
'' -Collision detection & response. AABB, grid, SAT + MTV
'' -Use SDL2 library
''
'' Bugs:
'' 
'' 
''
''******************************************************************************* 

#Pragma Once

'' Includes

'' SDL2 library
#Include "SDL2/SDL.bi"

''
#Include "fbgfx.bi"

'' Math
#Include "../../Math/Vec2.bi"
#Include "../../Math/Mat22.bi"

''
#Include "SDL2_tools.bi"
#Include "Containers.bi"
#Include "Constants.bi"

'' Base physics classes
#Include "LinearState.bi"
#Include "AngularState.bi"
#Include "LinearLink.bi"

DynamicArrayType( LinearStateArray, LinearStateType )

'' Rigid joints
#Include "RevoluteJoint.bi"
#Include "DistanceJoint.bi"
#Include "AngularJoint.bi"
#Include "SlideJoint.bi"

DynamicArrayType( RevoluteJointArray, RevoluteJointType )
DynamicArrayType( DistanceJointArray, DistanceJointType )
DynamicArrayType( AngularJointArray, AngularJointType )
DynamicArrayType( SlideJointArray, SlideJointType )

'' 
#Include "Roxel.bi"
#Include "LinearSpring.bi"
#Include "FixedSpring.bi"
#Include "AngularSpring.bi"

DynamicArrayType( RoxelArray, RoxelType )
DynamicArrayType( LinearSpringArray, LinearSpringType )
DynamicArrayType( FixedSpringArray, FixedSpringType )
DynamicArrayType( AngularSpringArray, AngularSpringType )

'' Game physics objects
#Include "Box.bi"
#Include "Wheel.bi"
#Include "SoftBody.bi"

DynamicArrayType( BoxArray, BoxType )
DynamicArrayType( WheelArray, WheelType )
DynamicArrayType( SoftBodyArray, SoftBodyType )

''
#Include "Game.bi"
#Include "Collision.bi"
#Include "Create.bi"
#Include "Puzzles.bi"

''	Create instance and run game
Scope

	Static As GameType ThisGame

End Scope

