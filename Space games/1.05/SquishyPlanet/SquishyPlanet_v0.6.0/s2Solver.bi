''******************************************************************************
''
''   SquishyPlanet2D Solver Class
''   Written in FreeBASIC 1.05
''   version 0.1.0, November 2016, Michael "h4tt3n" Nissen
''
''
''******************************************************************************


''
#Ifndef __S2_SOLVER_BI__
#Define __S2_SOLVER_BI__


''
Type Solver Extends Object
	
	Public:
	
	Declare Abstract Sub Solve( Array As Particle Ptr )
	
End Type

''
Type ImpulseSolver Extends Solver
	
	Declare Sub Solve( Array As Particle Ptr )
	
End Type

''
Type 1stOrderSolver Extends Solver
	
	Public:
	
	Declare Sub Solve( Array As Particle Ptr )
	
End Type

''
Type 4thOrderSolver Extends Solver
	
	Public:
	
	Declare Sub Solve( Array As Particle Ptr )
	
	Private:
	
	Const As Double b  = 2.0^(1/3)
	Const As Double a  = 2.0-b
	Const As Double x0 = -b/a
	Const As Double x1 = 1.0/a
	
	As Double d4(2) => { x1, x0, x1 }
	As Double c4(3) => { x1/2.0, (x0+x1)/2.0, (x0+x1)/2.0, x1/2.0 }
	
End Type

''
Type 6thOrderSolver Extends Solver
	
	Public:
	
	Declare Sub Solve( BodyArray As Body Ptr)
	
	Private:
	
	Const As Double w1 = -0.117767998417887E1
	const As Double w2 = 0.235573213359357E0
	const As Double w3 = 0.784513610477560E0
	const As Double w0 = (1.0-2.0*(w1+w2+w3))
	As Double d6(6) => { w3, w2, w1, w0, w1, w2, w3 }
	As Double c6(7) => { w3/2.0, (w3+w2)/2.0, (w2+w1)/2.0, (w1+w0)/2.0, _
	                    (w1+w0)/2.0, (w2+w1)/2.0, (w3+w2)/2.0, w3/2.0 }
	
End Type


''
Sub ImpulseSolver.Solve( BodyArray As Body Ptr, ForceFunc As Force Ptr )
	
	ForceFunc->Force( BodyArray )
	
	For i As Integer = 0 To NUM_BODYS-1
		
		BodyArray[i].Velocity += BodyArray[i].Impulse / BodyArray[i].Mass
		'BodyArray[i].Position += BodyArray[i].Velocity * DT
		
	Next
	
End Sub

Sub 1stOrderSolver.Solve( BodyArray As Body Ptr, ForceFunc As Force Ptr )
	
	ForceFunc->Force( BodyArray )
	
	For i As Integer = 0 To NUM_BODYS-1
		
		BodyArray[i].Velocity += ( BodyArray[i].Force / BodyArray[i].Mass ) * DT
		BodyArray[i].Position += BodyArray[i].Velocity * DT
		
	Next
	
End Sub

Sub 4thOrderSolver.Solve( BodyArray As Body Ptr, ForceFunc As Force Ptr )
	
	For i As Integer = 0 To 2
		
		For j As Integer = 0 To NUM_BODYS-1
			BodyArray[j].Position += DT * c4(i) * BodyArray[j].Velocity
		Next
		
		ForceFunc->Force( BodyArray )
		
		For j As Integer = 0 To NUM_BODYS-1
			BodyArray[j].Velocity += DT * d4(i) * ( BodyArray[j].Force / BodyArray[j].Mass )
		Next
		
	Next
	
	For j As Integer = 0 To NUM_BODYS-1
		BodyArray[j].Position += DT * c4(3) * BodyArray[j].Velocity
	Next
	
End Sub

Sub 6thOrderSolver.Solve( BodyArray As Body Ptr, ForceFunc As Force Ptr )
	
	For i As Integer = 0 To 6
		
		For j As Integer = 0 To NUM_BODYS-1
			BodyArray[j].Position += DT * c6(i) * BodyArray[j].Velocity
		Next
		
		ForceFunc->Force( BodyArray )
		
		For j As Integer = 0 To NUM_BODYS-1
			BodyArray[j].Velocity += DT * d6(i) * ( BodyArray[j].Force / BodyArray[j].Mass )
		Next
		
	Next
	
	For j As Integer = 0 To NUM_BODYS-1
		BodyArray[j].Position += DT * c6(7) * BodyArray[j].Velocity
	Next
	
End Sub

#EndIf ''__S2_SOLVER_BI__