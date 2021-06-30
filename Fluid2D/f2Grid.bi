''***************************************************************************
''  
''   Fluid2D, an iterative Smoothed Particle Hydrodynamics (SPH) library
''   Written in FreeBASIC 1.07 and fbedit 1.0.7.6c
''   Version 0.1.0, January 2020, Michael "h4tt3n" Schmidt Nissen
''  
''***************************************************************************


''
#Ifndef __F2_GRID__
#Define __F2_GRID__


''
Type f2Grid
	
	Public:
	
	Declare Constructor()
	
	Declare Constructor( ByVal celldiameter As UShort, _
	 	                  ByVal gridwidth    As ULong, _
	 	                  ByVal gridheight   As Ulong )
	
	Declare Destructor()
	
	Declare Sub computeCellPairs()
	
	Private:
	
	As Single invCellHeight_
	As Single invCellWidth_
	 
	As UShort numCellsX_
	As UShort numCellsY_
	
	As UByte cellHeight_
	As UByte cellWidth_
	As UByte numParticlesPerCell_
	
	As CellArray     cells_
	As CellPairArray cellPairs_
	
End Type


''
Constructor f2Grid()
	
	cells_.clear()
	cellPairs_.clear()
	
End Constructor

Constructor f2Grid( ByVal celldiameter As UShort, _
	 	              ByVal gridwidth    As ULong, _
	 	              ByVal gridheight   As Ulong )
	
	numCellsX_           = Cast ( ULong, gridwidth  / celldiameter )
	numCellsY_           = Cast ( ULong, gridheight / celldiameter )

	cellWidth_           = Cast ( ULong, gridwidth  / numCellsX_ )
	cellHeight_          = Cast ( ULong, gridheight / numCellsY_ ) 

	invCellWidth_        = 1.0 / cellWidth_	
	invCellHeight_       = 1.0 / cellHeight_
	
	numParticlesPerCell_ = MAX_PARTICLES_PER_CELL
	
	cells_.clear()
	cellPairs_.clear()
	
End Constructor

Destructor f2Grid()
	
	cells_.destroy()
	cellPairs_.destroy()
	
End Destructor

Sub f2Grid.computeCellPairs()

	'For x As UShort = 0 To numCellsX_
	'
	'	For y As UShort = 0 To numCellsY_
	'	
	'		''  cell(x, y) -> cell(x + 1, y)
	'		If x < numCellsX_ Then
	'		
	'			cellPairs[ numCellPairs_ ]->cellA_ = @cells[ x ]
	'			cellPairs( numCellPairs_ ).cellB_ = @cells( x + 1, y )
	'		
	'		EndIf
	'	
	'		''  cell(x, y) -> cell(x, y + 1)
	'		If y < numCellsY_ Then
	'		
	'			cellPairs( numCellPairs_ ).cellA_ = @cells( x, y )
	'			cellPairs( numCellPairs_ ).cellB_ = @cells( x, y + 1 )					
	'		
	'		EndIf
	'	
	'		''  cell(x, y) -> cell(x + 1, y + 1)
	'		If ( x < numCellsX_ ) And ( y < numCellsY_ ) Then
	'		
	'			cellPairs( numCellPairs_ ).cellA_ = @cells( x, y )
	'			cellPairs( numCellPairs_ ).cellB_ = @cells( x + 1, y + 1 )					
	'		
	'		EndIf
	'	
	'		''  cell(x, y) -> cell(x - 1, y + 1)
	'		If ( x > 0 ) And ( y < numCellsY_ ) Then
	'		
	'			cellPairs( numCellPairs_ ).cellA_ = @cells( x, y )
	'			cellPairs( numCellPairs_ ).cellB_ = @cells( x - 1, y + 1 )		
	'		
	'		EndIf
	'	
	'	Next
	'
	'Next

End Sub


''
#EndIf __F2_GRID__
