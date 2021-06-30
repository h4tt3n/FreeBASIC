''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 3, september 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''******************************************************************************* 

Type LinearLinkType Extends LinearStateType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Virtual Sub AddImpulse( ByVal i As Vec2 ) Override
	
	Declare Sub ComputeAngularVelocity()
	Declare Sub ComputeInvInertia()
	Declare Sub ComputeReducedMass()
	Declare Sub ComputeStateVectors()
	Declare Sub ComputeUnitVector()
	
	Declare Sub ComputeData()
	
	Declare Virtual Sub SetPosition( ByVal p As Vec2 ) Override
	
	As Vec2 unit_vector
	
	As Single reduced_mass
	As Single inv_inertia
	As Single angular_velocity
	
	As Single collision_damping
	As Single collision_STIFFNESS
	As Single collision_warmstart
	
	As Single dynamic_friction
	As Single static_friction
	
	As LinearStateType Ptr a
	As LinearStateType Ptr b
	
End Type

Constructor LinearLinkType()
	
	Base()
	
	unit_vector  = Vec2( 0.0, 0.0 )
	
	reduced_mass     = 0.0
	inv_inertia      = 0.0
	angular_velocity = 0.0
	
	a = 0
	b = 0
	
End Constructor

Destructor LinearLinkType()

End Destructor

Sub LinearLinkType.AddImpulse( ByVal i As Vec2 )
	
	Base.AddImpulse( i )
	
	a->AddImpulse( i * reduced_mass * a->inv_mass )
	b->AddImpulse( i * reduced_mass * b->inv_mass  )
	
End Sub

Sub LinearLinkType.ComputeAngularVelocity()
	
	Dim As Vec2 distance = b->position - a->position
	Dim As Vec2 velocity = b->velocity - a->velocity
	
	angular_velocity = distance.PerpDot( velocity * reduced_mass ) * inv_inertia
	
End Sub

Sub LinearLinkType.ComputeInvInertia()
	
	Dim As Vec2 distance = b->position - a->position
	
	Dim As Single inertia = distance.dot( distance ) * reduced_mass
		
	inv_inertia = IIf( inertia > 0.0 , 1.0 / inertia, 0.0 )
	
End Sub

Sub LinearLinkType.ComputeReducedMass()
 	
 	'reduced_mass = IIf( ( a->inv_mass + b->inv_mass ) > 0.0 , 1.0 / ( a->inv_mass + b->inv_mass ) , 0.0 )
 	
 	If ( ( a->inv_mass > 0.0 ) And ( b->inv_mass > 0.0) ) Then
 		
 		reduced_mass = 1.0 / ( a->inv_mass + b->inv_mass )
 		
 	ElseIf ( ( a->inv_mass = 0.0 ) And ( b->inv_mass > 0.0 ) ) Then
 		
 		reduced_mass = b->inv_mass
 		
 	ElseIf ( ( a->inv_mass > 0.0 ) And ( b->inv_mass = 0.0 ) ) Then 
 		
 		reduced_mass = a->inv_mass
 	
 	ElseIf ( ( a->inv_mass = 0.0 ) And ( b->inv_mass = 0.0 ) ) Then 
 		
 		'' undefined
 		
 	EndIf
 	
End Sub

Sub LinearLinkType.ComputeStateVectors()
	
	'' state vectors
	If ( a->inv_mass = 0.0 ) Then
		
		position = a->position
		velocity = Vec2( 0.0, 0.0 )
		
	ElseIf ( b->inv_mass = 0.0 ) Then
		
		position = b->position
		velocity = Vec2( 0.0, 0.0 )
		
	Else
		
		'position = ( a->position * a->mass + b->position * b->mass ) * inv_mass
		'velocity = ( a->velocity * a->mass + b->velocity * b->mass ) * inv_mass
		
		position = ( a->position * b->inv_mass + b->position * a->inv_mass ) * reduced_mass
		velocity = ( a->velocity * b->inv_mass + b->velocity * a->inv_mass ) * reduced_mass
		
	End If
	
End Sub

Sub LinearLinkType.ComputeUnitVector()
	
	unit_vector = ( b->position - a->position ).unit()
	
End Sub

Sub LinearLinkType.ComputeData()
	
	ComputeStateVectors()
	ComputeUnitVector()
	ComputeInvInertia()
	ComputeAngularVelocity()
	
End Sub

Sub LinearLinkType.SetPosition( ByVal p As Vec2 )
	
	Dim As Vec2 delta_postion = p - Position
	
	Base.SetPosition( p )
	
	a->SetPosition( a->Position + delta_postion )
	b->SetPosition( b->Position + delta_postion )
		
End Sub
