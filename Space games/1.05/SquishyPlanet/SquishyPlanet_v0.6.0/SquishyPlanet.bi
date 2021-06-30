''******************************************************************************
''
''   SquishyPlanet - A 2D soft body and space physics library for games
''   Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''   Version 0.6.0, October 2016
''
''   Author:
''   Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''   Class inheritance map:
''
''                                        |-> FixedSpring
''                                        |-> LinearSpring
''                       |-> LineSegment -|
''                       |                |-> NewtonGravity
''   Particle -> Rotate -|                |-> KeplerOrbit
''                       |
''   AngularSpring       |-> Body -> SpringBody -> PressureBody
''
''
''   Todo list now:
''
''   - Merge / split Particle functions in World Class
''   - Add / Remove function is MemPtrArray 
''   - ComputeAll() function that calls all compute functions in a class and its parents.
''   - Flags; moving/static, visible/invisible, dynamic/kinematic.
''   - Kinematic particles included in Body moved like vertices in rigid body.
''   - Implement similar naming conventions as in Erin's Box2D.
''   - Compute subs changed into functions that take parameters and return value.
''
''
''   Todo list later:
''
''   - OpenGL graphichs with GLFW; write GLFW3 bindings for FreeBASIC.
''   - s2AngularOscillator Class for kinematic angular springs.
''   - s2LinearOscillator Class for kinematic linear springs.
''
''
''   Bugs:
''
''   - Error in Angular springs; they are very weak and unstable. 
''   - Pressue bodys need a good pressure algorithm.
''   - Getter for body particlearray causes crash.
''   - World let operator causes crash.
''
''
''******************************************************************************


''
#Ifndef __SQUISHY2D_BI__
#Define __SQUISHY2D_BI__


''
#Include Once "../../Math/Matrix22.bi"

#Include Once "../../Math/Vector2.bi"

''
#Include "../../Graphics/FastEllipse.bi"

''
#Include "s2GlobalConstants.bi"

''
#Include "s2Particle.bi"

''
#Include "s2Rotate.bi"

''
#Include "s2AngularSpring.bi"

''
#Include "s2LineSegment.bi"

''
#Include "s2FixedSpring.bi"

''
#Include "s2LinearSpring.bi"

''
#Include "s2NewtonGravity.bi"

''
#Include "s2KeplerOrbit.bi"

''
#Include "s2MemPtrArrays.bi"

DynamicArrayType( AnyPtrArray, Any Ptr )
DynamicArrayType( AngularSpringPtrArray, AngularSpring Ptr )
DynamicArrayType( FixedSpringPtrArray, FixedSpring Ptr )
DynamicArrayType( LinearSpringPtrArray, LinearSpring Ptr )
DynamicArrayType( ParticlePtrArray, Particle Ptr )

''
#Include "s2Body.bi"

''
#Include "s2SpringBody.bi"

''
#Include "s2PressureBody.bi"

''
#Include "s2Cell.bi"

''
#Include "s2MemArrays.bi"

''
#Include "s2Grid.bi"

''
#Include "s2World.bi"



#EndIf ''__SQUISHY2D_BI__
