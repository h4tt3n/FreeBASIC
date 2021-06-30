''***************************************************************************
''  
''   Fluid2D, an iterative Smoothed Particle Hydrodynamics (SPH) library
''   Written in FreeBASIC 1.07 and fbedit 1.0.7.6c
''   Version 0.1.0, January 2020, Michael "h4tt3n" Schmidt Nissen
''  
''***************************************************************************


''
#Ifndef __F2_PARTICLE_PAIR__
#Define __F2_PARTICLE_PAIR__


''
Type f2ParticlePair
	
	Public:
	
	Declare Constructor()
	
	Private:
	
	As Vec2 nOverDistance_
	
	As Single density_
	As Single restImpulse_
	
	As f2Particle Ptr particleA_
	As f2Particle Ptr particleB_
	
End Type


''
Constructor f2ParticlePair()
	
	nOverDistance_ = Vec2( 0.0, 0.0 )
	
	density_     = 0.0
	restImpulse_ = 0.0
	
	particleA_ = 0
	particleB_ = 0
	
End Constructor


''
#EndIf __F2_PARTICLE_PAIR__