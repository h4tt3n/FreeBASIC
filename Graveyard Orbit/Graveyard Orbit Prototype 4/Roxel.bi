''******************************************************************************* 
'' Roxel (rock + pixel) base physical component
''*******************************************************************************

Type RoxelType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub ComputeNewState()
	
	As LinearStateType LinearState
	
	As Single radius
	
	As UInteger colour
	
End Type

Constructor RoxelType()
	
	radius = 0.0
	
	colour = 0
	
End Constructor

Destructor RoxelType()

End Destructor

Sub RoxelType.ComputeNewState()
	
	If ( LinearState.inv_mass > 0.0 ) Then
		
		LinearState.velocity += LinearState.impulse
		LinearState.position += LinearState.velocity * DT 
		
	End If
	
End Sub
