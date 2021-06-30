''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 7, february 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
'' Linear motion / translation base component
''
''******************************************************************************* 

Type LinearStateType Extends Object
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Virtual Sub AddImpulse( ByVal i As Vec2 )
	
	Declare Sub ComputeInvMass()
	Declare Sub ComputeNewState()
	
	Declare Virtual Sub SetPosition( ByVal p As Vec2 )
	
	As Vec2 position
	As Vec2 velocity
	As Vec2 impulse
	
	As Single mass
	As Single inv_mass
	
	As UInteger flags
  	
End Type

Constructor LinearStateType()
	
	position = Vec2( 0.0, 0.0 )
	velocity = Vec2( 0.0, 0.0 )
	impulse  = Vec2( 0.0, 0.0 )
	
	mass     = 0.0
	inv_mass = 0.0
	
	flags = 0
	
End Constructor

Destructor LinearStateType()
	
End Destructor

Sub LinearStateType.AddImpulse( ByVal i As Vec2 )
	
	impulse += i
	
End Sub

Sub LinearStateType.ComputeInvMass()
 	
	inv_mass = IIf( mass > 0.0 , 1.0 / mass , 0.0 )
 	
End Sub

Sub LinearStateType.ComputeNewState()
	
	velocity += impulse
	position += velocity * DT 
	
End Sub

Sub LinearStateType.SetPosition( ByVal p As Vec2 )
	
	position = p
	
End Sub