''***************************************************************************
''
''   Squishy2D, A Soft Body Physics Library For Games
''   Written in FreeBASIC 1.04
''   version 0.3.0, November 2015, Michael "h4tt3n" Nissen
''
''
''
''
''
''
''
''
''
''
''
''
''***************************************************************************


''
#Ifndef __SQUISHY2D_BI__
#Define __SQUISHY2D_BI__


'' 
#Include "../../Math/Vector2.bi"


'' Constants and memory
#Include "s2GlobalConstants.bi"

'' Simple objects
#Include "s2PointMass.bi"
#Include "s2LineSegment.bi"
#Include "s2FixedAngleSpring.bi"
#Include "s2LinearSpring.bi"

'' Complex Objects

#Include "s2PointerArrays.bi"

#Include "s2Body.bi"

#Include "s2AngularSpring.bi"

#Include "s2Memory.bi"

'' World
#Include "s2World.bi"


#EndIf ''__SQUISHY2D_BI__