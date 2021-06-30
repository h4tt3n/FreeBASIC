''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 3, september 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  Controls:
''  
''  Puzzles    :  numerical keys 0-9
''  Scroll     :  Arrow keys, WASD
''  Zoom       :  Q/E, comma/period
''  Iterations :  I and +/-
''  Exit       :  Escape key
''
'' Todo:
''
''		Anchor point class ( Vec2() position, angularstate ptr )
'' 	Grid based Collision detection
''    AABB Collision detection
''    Rigid body SAT
''    Collision response with friction
'' 	Use SDL2 library
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

'' Game 
#Include "../../GameIO/GameIO.bi"

''
#Include "SDL2_tools.bi"
#Include "Containers.bi"
#Include "Constants.bi"

'' Base physics classes
#Include "LinearState.bi"
#Include "AngularState.bi"
#Include "LinearLink.bi"

DynamicArrayType( LinearStateArray, LinearStateType )

'' Rigid constraints
#Include "RevoluteConstraint.bi"
#Include "DistanceConstraint.bi"
#Include "AngularConstraint.bi"
#Include "SlideConstraint.bi"
#Include "GearConstraint.bi"
#Include "WinchConstraint.bi"

DynamicArrayType( RevoluteConstraintArray, RevoluteConstraintType )
DynamicArrayType( DistanceConstraintArray, DistanceConstraintType )
DynamicArrayType( AngularConstraintArray, AngularConstraintType )
DynamicArrayType( SlideConstraintArray, SlideConstraintType )
DynamicArrayType( GearConstraintArray, GearConstraintType )
DynamicArrayType( WinchConstraintArray, WinchConstraintType )

'' Damped springs
#Include "LinearSpring.bi"
#Include "FixedSpring.bi"
#Include "AngularSpring.bi"

DynamicArrayType( LinearSpringArray, LinearSpringType )
DynamicArrayType( FixedSpringArray, FixedSpringType )
DynamicArrayType( AngularSpringArray, AngularSpringType )

'' Physics objects
#Include "Roxel.bi"
#Include "Box.bi"
#Include "Wheel.bi"
#Include "SoftBody.bi"

DynamicArrayType( RoxelArray, RoxelType )
DynamicArrayType( BoxArray, BoxType )
DynamicArrayType( WheelArray, WheelType )
DynamicArrayType( SoftBodyArray, SoftBodyType )

#Include "WheelWheelCollisionResponse.bi"

'' Game related
#Include "Game.bi"
#Include "Collision.bi"
#Include "Create.bi"
#Include "Puzzles.bi"

''	Create instance and run game
Scope

	Static As GameType ThisGame

End Scope

