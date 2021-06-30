''******************************************************************************
''
''   SquishyPlanet - A 2D soft body and space physics library for games
''   Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''   Version 0.7.0, December 2016
''
''   Author:
''   Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''   Description:
''   For Broadphase collision detection
''
''******************************************************************************


''
#Ifndef __S2_GRID_BI__
#Define __S2_GRID_BI__


''
Type Grid
	
	Public:
	
	'' Constructors
	Declare Constructor()
	
	Declare Constructor( ByRef G As Grid )
	
	Declare Constructor( ByVal _celldiameter As Integer, _
	 	                  ByVal _gridwidth    As Integer, _
	 	                  ByVal _gridheight   As Integer )
	
	'' Destructor
	Declare Destructor()
	
	'' Operators
	Declare Operator Let( ByRef G As Grid )
	
	'' Compute
	Declare Sub ComputeCellPtrs()
	
	'' Get
	Declare Const Function CellDiameter        () As Integer
	Declare Const Function InvCellDiameter     () As Single
	Declare Const Function NumCells            () As Integer
	Declare Const Function NumCellsX           () As Integer
	Declare Const Function NumCellsY           () As Integer
	Declare Const Function NumParticlesPerCell () As Integer
	
	'' Reset
	Declare Sub resetAll()
	Declare Sub resetCells()
	
	'' Set
	Declare Sub CellDiameter        ( ByVal c As Integer )
	Declare Sub NumCells            ( ByVal n As Integer )
	Declare Sub NumCellsX           ( ByVal n As Integer )
	Declare Sub NumCellsY           ( ByVal n As Integer )
	Declare Sub NumParticlesPerCell ( ByVal n As Integer )
	
	'Private:
	
	As Integer  cellDiameter_
	As Single   invCellDiameter_
	As Integer  numCells_
	As Integer  numCellsX_
	As Integer  numCellsY_
	As Integer  numParticlesPerCell_
	
	As CellArray Cells_
	
End Type


''
Constructor Grid()
	
	resetAll()
	
	Cells_.Reserve( MAX_NUM_CELLS )
	
End Constructor

Constructor Grid( ByRef g As Grid )
	
	resetAll()
	
	This = g
	
End Constructor

Constructor Grid( ByVal _celldiameter As Integer, _
	 	            ByVal _grid_x       As Integer, _
	 	            ByVal _grid_y       As Integer )

	resetAll()
	
	cellDiameter_    = _celldiameter
	invCellDiameter_ = 1.0 / cellDiameter_
	
	numCellsX_ = Cast( Integer, _grid_x / _celldiameter )
	numCellsY_ = Cast( Integer, _grid_y / _celldiameter )
	
	numCells_ = numCellsX_ * numCellsY_
	
	numParticlesPerCell_ = MAX_PARTICLES_CELL
	
	Cells_.Reserve( MAX_NUM_CELLS )
	
End Constructor


'' Destructor
Destructor Grid()
	
	resetAll()
	
End Destructor


'' Operators
Operator Grid.Let( ByRef g As Grid )
	
	If ( @This <> @g ) Then
		
		cellDiameter_        = g.cellDiameter_
		invcellDiameter_     = g.invcellDiameter_
		numCells_            = g.numCells_
		numCellsX_           = g.numCellsX_
		numCellsY_           = g.numCellsY_
		numParticlesPerCell_ = g.numParticlesPerCell_
		
		Cells_ = g.Cells_
		
	EndIf
	
End Operator


'' Compute
Sub Grid.ComputeCellPtrs()
	
	
	
End Sub


'' Get
Function Grid.CellDiameter() As Integer
	
	Return cellDiameter_
	
End Function

Function Grid.InvCellDiameter() As Single
	
	Return invCellDiameter_
	
End Function

Function Grid.NumCells() As Integer
	
	Return numCells_
	
End Function

Function Grid.NumCellsX() As Integer
	
	Return numCellsX_
	
End Function

Function Grid.NumCellsY() As Integer
	
	Return numCellsY_
	
End Function

Function Grid.NumParticlesPerCell() As Integer
	
	Return numParticlesPerCell_
	
End Function


'' Reset
Sub Grid.resetAll()
	
	cellDiameter_        = 0
	invCellDiameter_     = 0.0
	numCells_            = 0
	numCellsX_           = 0
	numCellsY_           = 0
	numParticlesPerCell_ = 0
	
	Cells_.Destroy()
	
End Sub

Sub Grid.resetCells()
	
End Sub


'' Set
Sub Grid.CellDiameter( ByVal c As Integer )
	
	cellDiameter_ = c
	
End Sub

Sub Grid.NumCells( ByVal n As Integer )
	
	numCells_ = n
	
End Sub

Sub Grid.NumCellsX( ByVal n As Integer )
	
	numCellsX_ = n
	
End Sub

Sub Grid.NumCellsY( ByVal n As Integer )
	
	numCellsY_ = n
	
End Sub

Sub Grid.NumParticlesPerCell( ByVal n As Integer )
	
	numParticlesPerCell_ = n
	
End Sub



#EndIf __S2_GRID_BI__