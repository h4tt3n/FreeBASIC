''******************************************************************************
''
''   SquishyPlanet - A 2D soft body and space physics library for games
''   Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''   Version 0.7.0, December 2016
''
''   Author:
''   Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''   Class inheritance map:
''
''                                                |-> FixedSpring
''                                                |-> LinearSpring
''                                |-> LinearLink -|
''                                |               |-> NewtonGravity
''   LinearState -> AngularState -|               |-> KeplerOrbit
''                                |
''   AngularSpring                |-> Body -|-> SpringBody
''                                          |-> RigidBody
''                                          |-> ShapeBody
''
''
''   Todo list now:
''
''   - Split external and internal impulses
''   - Implement shape matching body
''   - Fix and clean up s2KeplerOrbit
''   - Kinematic particles included in Body moved like vertices in rigid body.
''
''
''   Todo classes:
''
''   - s2Collision with friction between any two AngularState anchor points
''   - s2RigidConstraint between any two AngularState anchor points
''   - s2AngularOscillator Class for kinematic angular springs.
''   - s2LinearOscillator Class for kinematic linear springs.
''
''
''   Bugs:
''
''   - Error in Angular springs; they are very weak and unstable. 
''   - Getter for body LinearStateArray causes crash.
''   - World let operator causes crash.
''
''
''******************************************************************************


''
#Ifndef __SQUISHY_PLANET_BI__
#Define __SQUISHY_PLANET_BI__


''
#Include Once "../../Math/Vec2.bi"

#Include Once "../../Math/Mat22.bi"

''
#Include "s2Containers.bi"

''
#Include "s2Constants.bi"

''
#Include "s2LinearState.bi"

''
#Include "s2AngularState.bi"

''
#Include "s2AngularSpring.bi"

''
#Include "s2LinearLink.bi"

''
#Include "s2FixedSpring.bi"

''
#Include "s2LinearSpring.bi"

''
#Include "s2NewtonGravity.bi"

''
#Include "../../Graphics/FastEllipse.bi"

''
#Include "s2KeplerOrbit.bi"

''
DynamicArrayType( AnyPtrArray, Any Ptr )
DynamicArrayType( LinearStatePtrArray, LinearState Ptr )
DynamicArrayType( AngularStatePtrArray, AngularState Ptr )
DynamicArrayType( AngularSpringPtrArray, AngularSpring Ptr )
DynamicArrayType( FixedSpringPtrArray, FixedSpring Ptr )
DynamicArrayType( LinearSpringPtrArray, LinearSpring Ptr )

''
#Include "s2Body.bi"

''
#Include "s2RigidBody.bi"

''
#Include "s2SoftBody.bi"

''
#Include "s2ShapeBody.bi"

''
#Include "s2Cell.bi"

''
DynamicArrayType( AngularSpringArray, AngularSpring )
DynamicArrayType( BodyArray, Body )
DynamicArrayType( CellArray, Cell )
DynamicArrayType( FixedSpringArray, FixedSpring )
DynamicArrayType( KeplerOrbitArray, KeplerOrbit )
DynamicArrayType( LinearLinkArray, LinearLink )
DynamicArrayType( LinearSpringArray, LinearSpring )
DynamicArrayType( NewtonGravityArray, NewtonGravity )
DynamicArrayType( LinearStateArray, LinearState )
DynamicArrayType( AngularStateArray, AngularState )
DynamicArrayType( SoftBodyArray, SoftBody )
DynamicArrayType( RigidBodyArray, RigidBody )
DynamicArrayType( ShapeBodyArray, ShapeBody )

''
#Include "s2Grid.bi"

''
#Include "s2World.bi"

''
#Include "s2Create.bi"


#EndIf ''__SQUISHY_PLANET_BI__
