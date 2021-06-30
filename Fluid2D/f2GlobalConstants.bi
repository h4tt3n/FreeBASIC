''***************************************************************************
''  
''   Fluid2D, an iterative Smoothed Particle Hydrodynamics (SPH) library
''   Written in FreeBASIC 1.07 and fbedit 1.0.7.6c
''   Version 0.1.0, January 2020, Michael "h4tt3n" Schmidt Nissen
''  
''***************************************************************************


''
#Ifndef __F2_GLOBAL_CONSTANTS__
#Define __F2_GLOBAL_CONSTANTS__


'' Simulation
Const As Single DT                     = 1.0 / 60.0                              ''
Const As Single INV_DT                 = 1.0 / DT                                ''
Const As Single PI                     = 4.0 * Atn( 1.0 )                        ''
Const As Single G                      = 10.0                                    ''
Const As UShort NUM_ITERATIONS         = 8                                       ''

'' Particle
Const As Single PARTICLE_RADIUS        = 15.0                                    ''
Const As Single PARTICLE_DIAMETER      = PARTICLE_RADIUS * 2.0                   ''

'' Fluid
Const As Single K_LOCAL_PRESSURE       = 0.0004                                  ''
Const As Single K_GLOBAL_PRESSURE      = 0.04	                                 ''
Const As Single K_LOCAL_DAMPING        = 0.4	                                    ''
Const As Single MIN_REACT_DISTANCE     = 4.0                                     '' Min particle interaction distance
Const As Single REST_DENSITY           = 1.0                                     ''

'' Grid
Const As UShort CELL_DIAMETER          = CUShort( 1.0 * PARTICLE_DIAMETER ) ''
Const As UShort MAX_PARTICLES_PER_CELL = 32     
Const As UShort MAX_PAIRS_LOCAL        = 8                                       '' max number of neighbors per particles                                  
Const As UShort NUM_CELLS_X            = 100
Const As UShort NUM_CELLS_Y            = 100
Const As ULong  NUM_CELLS              = NUM_CELLS_X * NUM_CELLS_Y              
Const As ULong  NUM_CELL_PAIRS         = NUM_CELLS * 5 - NUM_CELLS_X             '' ?


''
#EndIf __F2_GLOBAL_CONSTANTS__