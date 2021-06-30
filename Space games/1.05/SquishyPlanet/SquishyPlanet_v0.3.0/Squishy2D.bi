''******************************************************************************
''
''   Squishy2D, A soft body physics library for games
''   Written in FreeBASIC 1.04
''   Version 0.3.0, December 2015, Michael "h4tt3n" Nissen
''
''   Inheritance map:
''
''                                       /-> LinearSpring
''   AngularSpring       /-> LineSegment
''                      /                \-> FixedSpring
''   Particle -> Rotate 
''                      \-> Body -> SpringBody -> PressureBody
''
''
''   Todo list:
''
''   - ApplyImpulse function that takes position and impulse vector as argument
''
''
''******************************************************************************


''
#Ifndef __SQUISHY2D_BI__
#Define __SQUISHY2D_BI__


'' 
#Include "../../Math/Vector2.bi"

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
