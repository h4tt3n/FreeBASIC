''***************************************************************************
''  
''   Fluid2D, an iterative Smoothed Particle Hydrodynamics (SPH) library
''   Written in FreeBASIC 1.07 and fbedit 1.0.7.6c
''   Version 0.1.0, January 2020, Michael "h4tt3n" Schmidt Nissen
''  
''***************************************************************************


''
#Ifndef __F2_CELL_PAIR__
#Define __F2_CELL_PAIR__


''
Type f2CellPair
	
	Public:
	
	Declare Constructor()
	Declare Constructor( ByVal a As f2Cell Ptr, ByVal b As f2Cell Ptr )
	
	''Private:
	
	As f2Cell Ptr cellA_
	As f2Cell Ptr cellB_
	
End Type


''
Constructor f2CellPair()
	
	cellA_ = 0
	cellB_ = 0
	
End Constructor

Constructor f2CellPair( ByVal a As f2Cell Ptr, ByVal b As f2Cell Ptr )
	
	cellA_ = a
	cellB_ = b
	
End Constructor


''
#EndIf __F2_CELL_PAIR__