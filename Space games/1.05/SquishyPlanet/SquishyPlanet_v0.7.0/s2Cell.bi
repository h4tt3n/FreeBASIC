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
''
''
''******************************************************************************


''
#Ifndef __S2_CELL_BI__
#Define __S2_CELL_BI__


''
Type Cell
	
	Public:
	
	'' Constructors
	Declare Constructor()
	Declare Constructor( ByRef c As Cell )
	
	'' Destructor
	Declare Destructor()
	
	'' Operators
	Declare Operator Let( ByRef c As Cell )
	
	'' Reset
	Declare Sub ResetAll()
	
	'Private:
	
	As AnyPtrArray Cells_
	'As AnyPtrArray LinearStates_
	
	'As CellPtrArray     Cells_
	As LinearStatePtrArray LinearStates_
	
End Type


'' Constructors
Constructor Cell()
	
	ResetAll()
	
	Cells_.Reserve( 4 )
	LinearStates_.Reserve( MAX_PARTICLES_CELL )
	
End Constructor

Constructor Cell( ByRef c As Cell )
	
	ResetAll()
	
	This = c
	
End Constructor


'' Destructor
Destructor Cell()
	
	ResetAll()
	
End Destructor


'' Operators
Operator Cell.Let( ByRef c As Cell )
	
	If ( Not @This = @c ) Then
		
		Cells_        = c.Cells_
		LinearStates_ = c.LinearStates_
		
	EndIf
	
End Operator


'' Reset
Sub Cell.ResetAll()
	
	Cells_.Destroy()
	LinearStates_.Destroy()
	
End Sub


#EndIf ''__S2_CELL_BI__