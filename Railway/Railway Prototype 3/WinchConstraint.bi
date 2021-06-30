''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 3, september 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  Winch constraint class
''
''
''*******************************************************************************

Type WinchConstraintType
	
	Declare Constructor()
	
	Declare Constructor( ByVal rope_ As DistanceConstraintType Ptr, _
	                     ByVal drum_ As AngularStateType Ptr )
	
	Declare Destructor()
	
	Declare Sub ComputeRestImpulse()
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	
	As Single c_stiffness
	As Single c_damping
	As Single c_warmstart
	
	As Single accumulated_impulse
	As Single drum_radius
	As Single max_rope_length
	
	As DistanceConstraintType Ptr Rope
	As AngularStateType Ptr Drum
	
End Type


''
Constructor WinchConstraintType()
	
End Constructor

Constructor WinchConstraintType( ByVal rope_ As DistanceConstraintType Ptr, _
	                              ByVal drum_ As AngularStateType Ptr )
	
End Constructor

Destructor WinchConstraintType()
	
End Destructor


''
Sub WinchConstraintType.ComputeRestImpulse()
	
End Sub

Sub WinchConstraintType.ApplyCorrectiveImpulse()
	
End Sub

Sub WinchConstraintType.ApplyWarmStart()
	
End Sub
