''***************************************************************************
''  
''  FreeBASIC 2d spring physics library
''  version 0.3.0 beta, october 2014
''	 Michael "h4tt3n" Nissen, jernmager@yahoo.dk 
''  
''***************************************************************************



''***************************************************************************
''  Type forward declarations (for pointers)
''***************************************************************************

Type PointMassTypeFwd            As PointMassType
Type RotateTypeFwd               As RotateType
Type ParticleTypeFwd             As ParticleType
Type LinearSpringTypeFwd         As LinearSpringType
Type FixedAngleSpringTypeFwd     As FixedAngleSpringType
Type AngularSpringTypeFwd        As AngularSpringType



''***************************************************************************
''  Includes
''***************************************************************************

''
#Include Once "Vector2.bi"
#Include Once "GlobalConstants.bi"

''
#Include Once "LineSegment.bi"
#Include Once "Rotate.bi"
#Include Once "PointMass.bi"


''
#Include Once "AngularSpring.bi"
#Include Once "FixedAngleSpring.bi"
#Include Once "LinearSpring.bi"
#Include Once "World.bi"
