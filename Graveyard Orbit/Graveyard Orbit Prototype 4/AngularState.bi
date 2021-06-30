''******************************************************************************* 
'' Angular motion / rotation base component
''*******************************************************************************

Type AngularStateType Extends Object
	
	Declare Constructor()
	Declare Destructor()
	
	'As Vec2 direction_vector
	'As Vec2 velocity_vector
	
	As Mat22 direction_matrix
	As Mat22 velocity_matrix
	
	As Single direction
	As Single velocity
	As Single impulse
	As Single inertia
	As Single inv_inertia
	
End Type

Constructor AngularStateType()
	
	'direction_vector = Vec2( 1.0, 0.0 )
	'velocity_vector  = Vec2( 1.0, 0.0 )
	
	direction_matrix.makeIdentity()
	velocity_matrix.makeIdentity()
	
	direction   = 0.0
	velocity    = 0.0
	impulse     = 0.0
	inertia     = 0.0
	inv_inertia = 0.0
	
End Constructor

Destructor AngularStateType()

End Destructor
