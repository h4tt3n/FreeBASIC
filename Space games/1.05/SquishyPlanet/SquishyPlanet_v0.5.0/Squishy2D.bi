''******************************************************************************
''
''   SquishyPlanet, A 2D soft body and space physics library for games
''   Written in FreeBASIC 1.05
''   Version 0.5.0, May 2016, Michael "h4tt3n" Nissen
''
''   Inheritance map:
''
''                                        |-> FixedSpring
''                                        |-> LinearSpring
''   AngularSpring       |-> LineSegment -
''                       |                |-> NewtonGravity -> KeplerOrbit
''   Particle -> Rotate -
''                       |-> Body -> SpringBody -> PressureBody
''
''
''   Todo list:
''
''   - body set position sub affects particles
''   - ApplyImpulse function that takes position and impulse vector as argument
''
''
''   Bugs:
''
''   - Angular springs doesn't work
''   - Pressue bodys doesn't work
''   - Getter for body particles causes crash
''
''
''******************************************************************************


''
#Ifndef __SQUISHY2D_BI__
#Define __SQUISHY2D_BI__

''
#Include "../../Graphics/FastEllipse.bi"

''
#Include "../../Math/Matrix22.bi"

''
#Include "s2GlobalConstants.bi"

''
#Include "s2Particle.bi"

''
#Include "s2Rotate.bi"

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
#Include "s2AngularSpring.bi"

''
#Include "s2MemPtrArrays.bi"

''
#Include "s2Body.bi"

''
#Include "s2SpringBody.bi"

''
#Include "s2PressureBody.bi"

''
#Include "s2MemArrays.bi"

''
#Include "s2World.bi"


#EndIf ''__SQUISHY2D_BI__
