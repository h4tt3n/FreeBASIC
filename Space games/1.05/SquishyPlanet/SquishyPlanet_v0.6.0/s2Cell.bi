''******************************************************************************
''
''   SquishyPlanet2D Cell Class
''   Written in FreeBASIC 1.05
''   version 0.1.0, October 2016, Michael "h4tt3n" Nissen
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
	
	'' Get
	Declare Const Function NumParticles() As Integer
	
	'' Reset
	Declare Sub ResetAll()
	
	'' Set
	Declare Sub NumParticles( ByVal n As Integer )
	
	'Private:
	
	As Integer numParticles_
	
	As AnyPtrArray Cells_
	'As AnyPtrArray Particles_
	
	'As CellPtrArray     Cells_
	As ParticlePtrArray Particles_
	
End Type


'' Constructors
Constructor Cell()
	
	ResetAll()
	
	Cells_.Reserve( 4 )
	Particles_.Reserve( MAX_PARTICLES_CELL )
	
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
	
	If ( @This <> @c ) Then
		
		numParticles_ = c.numParticles_
		
		Cells_     = c.Cells_
		Particles_ = c.Particles_
		
	EndIf
	
End Operator


'' Get
Function Cell.NumParticles() As Integer
	
	Return numParticles_
	
End Function


'' Reset
Sub Cell.ResetAll()
	
	numParticles_ = 0
	
	Cells_.Clear()
	Particles_.Clear()
	
End Sub


'' Set
Sub Cell.NumParticles( ByVal n As Integer )
	
	numParticles_ = n
	
End Sub


#EndIf ''__S2_CELL_BI__