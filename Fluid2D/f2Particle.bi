''***************************************************************************
''  
''   Fluid2D, an iterative Smoothed Particle Hydrodynamics (SPH) library
''   Written in FreeBASIC 1.07 and fbedit 1.0.7.6c
''   Version 0.1.0, January 2020, Michael "h4tt3n" Schmidt Nissen
''  
''***************************************************************************


''
#Ifndef __F2_PARTICLE__
#Define __F2_PARTICLE__


''
Type f2Particle
	
	Public:
	
	Declare Constructor()
	
	Private:
	
	As Vec2 impulse_
	As Vec2 position_
	As Vec2 velocity_
	
	As Single localDensity_
	
End Type


''
Constructor f2Particle()
	
	impulse_  = Vec2( 0.0, 0.0 )
	position_ = Vec2( 0.0, 0.0 )
	velocity_ = Vec2( 0.0, 0.0 )
	
	localDensity_ = 0.0
	
End Constructor


''
#EndIf __F2_PARTICLE__