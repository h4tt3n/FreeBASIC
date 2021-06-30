''******************************************************************************* 
'' Linear motion / translation base component
''******************************************************************************* 

Type LinearStateType Extends Object
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Virtual Sub AddImpulse( ByVal i As Vec2 )
	
	Declare Sub ComputeNewState()
	
	As Vec2 position
	As Vec2 velocity
	As Vec2 impulse
	
	As Single mass
	As Single inv_mass
  	
End Type

Constructor LinearStateType()
	
	position = Vec2( 0.0, 0.0 )
	velocity = Vec2( 0.0, 0.0 )
	impulse  = Vec2( 0.0, 0.0 )
	
	mass     = 0.0
	inv_mass = 0.0
	
End Constructor

Destructor LinearStateType()
	
End Destructor

Sub LinearStateType.AddImpulse( ByVal i As Vec2 )
	
	impulse += i
	
End Sub

Sub LinearStateType.ComputeNewState()
	
	If ( inv_mass > 0.0 ) Then
		
		velocity += impulse
		position += velocity * DT 
		
	End If
	
End Sub
