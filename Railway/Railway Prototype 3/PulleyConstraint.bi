''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 3, september 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  Pulley Constraint class
''
''
''*******************************************************************************

Type PulleyConstraintType
	
	Declare Constructor()
	
	Declare Destructor()
	
	As Single c_stiffness
	As Single c_damping
	As Single c_warmstart
	
	As Single pulley_ratio
	
	As LinearLinkType Ptr Rope_a
	As LinearLinkType Ptr Rope_b
	
End Type

Constructor PulleyConstraintType()

End Constructor

Destructor PulleyConstraintType()

End Destructor
