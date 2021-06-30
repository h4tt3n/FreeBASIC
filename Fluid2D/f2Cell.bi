''***************************************************************************
''  
''   Fluid2D, an iterative Smoothed Particle Hydrodynamics (SPH) library
''   Written in FreeBASIC 1.07 and fbedit 1.0.7.6c
''   Version 0.1.0, January 2020, Michael "h4tt3n" Schmidt Nissen
''  
''***************************************************************************


''
#Ifndef __F2_CELL__
#Define __F2_CELL__


''
Type f2Cell
	
	Public:
	
	Declare Constructor()
	Declare Destructor()
	
	Private:
	
	As ParticlePtrArray particlePtrs_
	
End Type


''
Constructor f2Cell()
	
	particlePtrs_.clear()
	
End Constructor

Destructor f2Cell()
	
	particlePtrs_.destroy()
	
End Destructor

''
#EndIf __F2_CELL__