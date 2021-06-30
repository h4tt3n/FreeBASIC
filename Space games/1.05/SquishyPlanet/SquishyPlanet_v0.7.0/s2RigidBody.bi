''*********************************************************************************
''
''   SquishyPlanet - A 2D soft body and space physics library for games
''   Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''   Version 0.7.0, December 2016
''
''   Author:
''   Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''   Description:
''   LinearState -> AngularState -> Body -> RigidBody
''
''*********************************************************************************


''
#Ifndef __S2_RIGID_BODY_BI__
#Define __S2_RIGID_BODY_BI__


'' 
Type RigidBody Extends Body
	
	Public:
	
	Declare Constructor()
	Declare Constructor( ByRef r As RigidBody )
	
	Declare Destructor()
	 
	Declare Operator Let( ByRef r As RigidBody )
	
	'' Add
	'Declare Sub AddAngle           ( ByVal a As Single )
	'Declare Sub AddAngleVector     ( ByVal a As Vec2 )
	'Declare Sub AddAngularImpulse  ( ByVal a As Single )
	'Declare Sub AddAngularVelocity ( ByVal a As Single )
	'Declare Sub AddImpulse         ( ByVal i As Vec2 )
	'Declare Sub AddVelocity        ( ByVal v As Vec2 )
	'Declare Sub AddPosition        ( ByVal p As Vec2 )
	
	'' Compute
	Declare Sub ComputeNewState()
	
	'' Get
	
	'' Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	Protected:
	
	As Single Dummy
	
End Type


'' Constructors
Constructor RigidBody()
	
	ResetAll()
	
End Constructor

Constructor RigidBody( ByRef r As RigidBody )
	
	ResetAll()
	
	This = r
	
End Constructor


'' Destructor
Destructor RigidBody()
	
	ResetAll()
	
End Destructor

 
'' Operators
Operator RigidBody.Let( ByRef r As RigidBody )
	
	If ( @This <> @r ) Then
		
		Cast( Body, This ) = r
		
	EndIf
	
End Operator


'' Add
'Sub RigidBody.AddAngle( ByVal a As Single )
'	
'End Sub
'
'Sub RigidBody.AddAngleVector( ByVal a As Vec2 )
'	
'End Sub
'
'Sub RigidBody.AddAngularImpulse( ByVal a As Single )
'	
'End Sub
'
'Sub RigidBody.AddAngularVelocity( ByVal a As Single )
'	
'End Sub

'Sub RigidBody.AddImpulse( ByVal i As Vec2 )
'	
'End Sub
'
'Sub RigidBody.AddVelocity( ByVal v As Vec2 )
'	
'	Velocity_ += v
'	
'End Sub
'
'Sub RigidBody.AddPosition( ByVal p As Vec2 )
'	
'End Sub


'' Compute
Sub RigidBody.ComputeNewState()
	
	'' Global Linear
	Velocity_ += Impulse_
	'This.SetVelocity( This.getVelocity() + This.getImpulse() )
	
	Dim As Vec2 delta_position = Velocity_ * DT
	'Dim As Vec2 delta_position = getVelocity() * DT
	
	'Position_ += delta_position
	
	'' Global Angular
	'If ( AngularImpulse_ <> 0.0 ) Then
		
		AngularVelocity_ += AngularImpulse_
		
		AngularVelocityVector_ = Vec2( Cos( AngularVelocity_ * DT ), _
		                               Sin( AngularVelocity_ * DT ) )
	
	'EndIf
	
	Angle_ += AngularVelocity_ * DT
	AngleVector_ = AngleVector_.RotateCCW( AngularVelocityVector_ )
	
	'' Particles
	If ( Not LinearStates_.Empty ) Then 
		
		For I As LinearState Ptr Ptr = LinearStates_.p_front To LinearStates_.p_back
			
			Dim As LinearState Ptr P = *I
			
			'' Local Linear
			'P->Position_ += delta_position
			
			'' Local Angular
			Dim As vec2 local_position = P->Position_ - Position_
			
			P->Position_ = Position_ + local_position.RotateCCW( AngularVelocityVector_ )
			P->Velocity_ = Velocity_ + local_position.PerpDot( AngularVelocity_ )
			
			'' Reset
			P->Impulse_ = Vec2( 0.0, 0.0 )
			
		Next
		
	End If
	
	AngularImpulse_= 0.0
	Impulse_ = Vec2( 0.0, 0.0 )
	
	PrevAngularImpulse_ = 0.0
	PrevLinearImpulse_ = Vec2( 0.0, 0.0 )
	
End Sub


'' Get


'' Reset
Sub RigidBody.ResetAll()
	
	Base.ResetAll()
	
End Sub

Sub RigidBody.ResetVariables()
	
	Base.ResetVariables()
	
End Sub


''
#EndIf '' __S2_RIGID_BODY_BI__
