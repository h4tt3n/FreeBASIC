''***************************************************************************
''  
''   Fluid2D, a sequential Smoothed Particle Hydrodynamics (SPH) library
''   Written in FreeBASIC 1.07 and FbEdit 1.0.7.6c
''   Version 0.1.0, January 2020, Michael "h4tt3n" Schmidt Nissen
''  
''***************************************************************************


''
#Ifndef __F2_FLUID_2D__
#Define __F2_FLUID_2D__

#Pragma Once

''
#Include "fbgfx.bi"

''
#Include "../Math/Vec2.bi"
#Include "f2DynamicArray.bi"

'' 
#Include "f2GlobalConstants.bi"

''
#Include "f2Particle.bi"
#Include "f2ParticlePair.bi"

''
DynamicArrayType( ParticleArray, f2Particle )
DynamicArrayType( ParticlePairArray, f2ParticlePair )

#Include "f2Fluid.bi"

''
DynamicArrayType( ParticlePtrArray, f2Particle Ptr )

#Include "f2Cell.bi"
#Include "f2CellPair.bi"

''
DynamicArrayType( CellArray, f2Cell )
DynamicArrayType( CellPairArray, f2CellPair )

#Include "f2Grid.bi"


''
#EndIf __F2_FLUID_2D__
