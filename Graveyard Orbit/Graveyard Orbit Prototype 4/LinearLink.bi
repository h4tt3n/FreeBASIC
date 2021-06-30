''******************************************************************************* 
'' 
''*******************************************************************************

Type LinearLinkType Extends LinearStateType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Virtual Sub AddImpulse( ByVal i As Vec2 ) Override
	
	'As Vec2 delta_position_vector
	'As Vec2 delta_velocity_vector
	
	As Vec2 unit_vector

	'As Single delta_position
	'As Single delta_velocity
	
	As Single reduced_mass
	
	As LinearStateType Ptr a
	As LinearStateType Ptr b
	
End Type

Constructor LinearLinkType()
	
	'delta_position_vector = Vec2( 1.0, 0.0 )
	'delta_velocity_vector = Vec2( 1.0, 0.0 )
	
	unit_vector = Vec2( 0.0, 0.0 )
	
	'delta_position = 0.0
	'delta_velocity = 0.0
	
	reduced_mass = 0.0
	
	a = 0
	b = 0
	
End Constructor

Destructor LinearLinkType()

End Destructor

Sub LinearLinkType.AddImpulse( ByVal i As Vec2 )
	
	Base.AddImpulse( i )
	
	a->AddImpulse( i )
	b->AddImpulse( i )
	
End Sub
