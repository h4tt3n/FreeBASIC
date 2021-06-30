''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 4, september 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  Pulley Constraint class
''
''
''*******************************************************************************

Type PulleyConstraintType
	
	Declare Constructor()
	
	Declare Constructor( ByVal rope_1 As DistanceConstraintType Ptr, _
	                     ByVal rope_2 As DistanceConstraintType Ptr )
	
	Declare Destructor()
	
	Declare Sub ComputeRestImpulse()
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	
	As Single c_stiffness
	As Single c_damping
	As Single c_warmstart
	
	As Single pulley_ratio
	As Single rest_distance
	
	As DistanceConstraintType Ptr Rope_a
	As DistanceConstraintType Ptr Rope_b
	
End Type

Constructor PulleyConstraintType()

End Constructor

Constructor PulleyConstraintType( ByVal rope_1 As DistanceConstraintType Ptr, _
	                               ByVal rope_2 As DistanceConstraintType Ptr )
	
	Rope_a = rope_1
	Rope_b = rope_2
	
	rest_distance = rope_A->rest_distance + rope_b->rest_distance
	
End Constructor

Destructor PulleyConstraintType()

End Destructor

Sub PulleyConstraintType.ComputeRestImpulse()
	
End Sub

Sub PulleyConstraintType.ApplyCorrectiveImpulse()
	
End Sub

Sub PulleyConstraintType.ApplyWarmStart()
	
End Sub
