''***************************************************************************
''  
''   Fluid2D, an iterative Smoothed Particle Hydrodynamics (SPH) library
''   Written in FreeBASIC 1.07 and fbedit 1.0.7.6c
''   Version 0.1.0, January 2020, Michael "h4tt3n" Schmidt Nissen
''  
''***************************************************************************


''
#Ifndef __F2_FLUID__
#Define __F2_FLUID__


''
Type f2Fluid
	
	Public:
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub ComputeRestImpulse()
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	
	Private:
	
	As Single kGlobalPressure_
	As Single kLocalDamping_
	As Single kLocalPressure_
	As Single particleDiameter_
	As Single particleDiameterSquared_
	As Single particleMass_
	As Single particleRadius_
	As Single restDistance_
	As Single restDistanceSquared_
	As Single restDensity_
	
	As ParticleArray     particles_
	As ParticlePairArray particlePairs_
	
End Type


''
Constructor f2Fluid()
	
	particles_.clear()
	particlePairs_.clear()
	
End Constructor

Destructor f2Fluid()
	
	particles_.destroy()
	particlePairs_.destroy()
	
End Destructor


''
Sub f2Fluid.ComputeRestImpulse()
	
End Sub

Sub f2Fluid.ApplyCorrectiveImpulse()
	
End Sub

Sub f2Fluid.ApplyWarmStart()
	
End Sub


''
#EndIf __F2_FLUID__