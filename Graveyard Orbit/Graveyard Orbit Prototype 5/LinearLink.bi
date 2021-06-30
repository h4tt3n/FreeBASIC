''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 5, june 2018
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''******************************************************************************* 

Type LinearLinkType Extends LinearStateType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Virtual Sub AddImpulse( ByVal i As Vec2 ) Override
	
	Declare Sub ComputeData()
	Declare Sub ComputeReducedMass()
	
	As Vec2 unit_vector
	
	As Single reduced_mass
	
	As LinearStateType Ptr a
	As LinearStateType Ptr b
	
End Type

Constructor LinearLinkType()
	
	unit_vector = Vec2( 0.0, 0.0 )
	
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

Sub LinearLinkType.ComputeData()
	
	'' state vectors
	If ( a->inv_mass = 0.0 ) Then
		
		position = a->position
		velocity = Vec2( 0.0, 0.0 )
		
	ElseIf ( b->inv_mass = 0.0 ) Then
		
		position = b->position
		velocity = Vec2( 0.0, 0.0 )
		
	Else
		
		position = ( a->position * a->mass + b->position * b->mass ) * inv_mass
		velocity = ( a->velocity * a->mass + b->velocity * b->mass ) * inv_mass
		
	End If
	
End Sub

Sub LinearLinkType.ComputeReducedMass()
 	
 	reduced_mass = IIf( ( a->inv_mass + b->inv_mass ) > 0.0 , 1.0 / ( a->inv_mass + b->inv_mass ) , 0.0 )
 	
End Sub
