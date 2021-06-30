''******************************************************************************
''
''   SquishyPlanet - A 2D soft body and space physics library for games
''   Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''   Version 0.7.0, December 2016
''
''   Author:
''   Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''   Description:
''   This is the inherited base type of all physical objects. It takes care 
''   of linear motion. It is the only object that does this, all other objects 
''   inherit their linear motion properties from this class. 
''   All forces are interacting between two LinearStates, which means they can 
''   interact betweeen any two physical objects.
''
''   When Dynamic:
''
''   Position and velocity is updated by solver.
''
''   When Kinematic:
''
''   Position and velocity is updated by parent body.
''   Inmpulses applied to particle is transferred to parent body.
''
''******************************************************************************


''
#Ifndef __S2_LINEAR_STATE_BI__
#Define __S2_LINEAR_STATE_BI__


''
Type LinearState Extends Object
	
	Public:
	
	'' Constructors
	Declare Constructor()
	
	Declare Constructor( ByRef p As LinearState )
	
	Declare Constructor( ByVal _mass As Single )
	
	Declare Constructor( ByVal _mass     As Single, _
	                     ByVal _position As Vec2 )
	
	'' Destructor
	Declare Destructor()
	
	'' Operators
	Declare Operator Let( ByRef p As LinearState )
	
	'' Add
	Declare Virtual Sub AddImpulse  ( ByVal i As Vec2 )
	'Declare Virtual Sub AddForce    ( ByVal f As Vec2 )
	Declare Virtual Sub AddPosition ( ByVal p As Vec2 )
	Declare Virtual Sub AddVelocity ( ByVal v As Vec2 )
	
	'' Compute
	Declare Sub ComputeInverseMass()
	Declare Sub ComputeNewState()
	
	'' Get
	Declare Const Function GetInverseMass() As Single
	Declare Const Function GetMass()        As Single
	Declare Const Function GetImpulse()  As Vec2
	'Declare Const Function GetForce()    As Vec2
	Declare Const Function GetPosition() As Vec2
	Declare Const Function GetVelocity() As Vec2
	Declare Const Function GetFlag( ByVal flag As integer ) As Integer
	
	'' Reset
	Declare Sub ResetAll()
	
	'' Set
	Declare Sub SetMass        ( ByVal m As Single )
	Declare Sub SetInverseMass ( ByVal i As Single )
	
	Declare Virtual Sub SetImpulse  ( ByVal i As Vec2 )
	'Declare Virtual Sub SetForce    ( ByVal f As Vec2 )
	Declare Virtual Sub SetPosition ( ByVal p As Vec2 )
	Declare Virtual Sub SetVelocity ( ByVal v As Vec2 )
	
	''
	Declare Sub LowerFlag( ByVal Flag As Integer )
	Declare Sub RaiseFlag( ByVal Flag As Integer )
	Declare Sub ToggleFlag( ByVal Flag As Integer )
	
 	Protected:
	
	As Vec2 Impulse_
	'As Vec2 Force_
	As Vec2 Velocity_
	As Vec2 Position_
	
	As UInteger Flags_
	
	As Single Mass_
	As Single InverseMass_
	
End Type


'' Constructors
Constructor LinearState
	
	ResetAll()
	
End Constructor

Constructor LinearState( ByRef p As LinearState )
	
	ResetAll()
	
	This = p
	
End Constructor

Constructor LinearState( ByVal _mass As Single )
	
	ResetAll()
	
	Mass_ = _mass
	
	ComputeInverseMass()
	
	RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
End Constructor

Constructor LinearState( ByVal _mass As Single, _
                         ByVal _position As Vec2 )
	
	ResetAll()
	
	Mass_     = _mass
	Position_ = _position
	
	ComputeInverseMass()
	
	RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
End Constructor


'' Destructor
Destructor LinearState()

End Destructor


'' Operators
Operator LinearState.Let( ByRef p As LinearState )
	
	If ( @This <> @p ) Then
		
		Flags_       = p.Flags_
		Mass_        = p.Mass_
		InverseMass_ = p.InverseMass_
		Impulse_     = p.Impulse_
		'Force_       = p.Force_
		Velocity_    = p.Velocity_
		Position_    = p.Position_
		
	EndIf
	
End Operator


'' Add
Sub LinearState.AddImpulse( ByVal i As Vec2 )
	
	Impulse_ += i
	
End Sub

'Sub LinearState.AddForce( ByVal f As Vec2 )
'	
'	Force_ += f
'	
'End Sub

Sub LinearState.AddPosition( ByVal p As Vec2 )
	
	Position_ += p
	
End Sub

Sub LinearState.AddVelocity( ByVal v As Vec2 )
	
	Velocity_ += v
	
End Sub


'' Compute
Sub LinearState.ComputeInverseMass()
	
	InverseMass_ = IIf( Mass_ > 0.0 , 1.0 / Mass_ , 0.0 )
	
End Sub

Sub LinearState.ComputeNewState()
	
	AddVelocity( GetImpulse )
	AddPosition( GetVelocity * DT )
	
	SetImpulse( Vec2( 0.0, 0.0 ) )
	
End Sub


'' Get
Function LinearState.GetMass() As Single
	
	Return Mass_
	
End Function

Function LinearState.GetInverseMass() As Single
	
	Return InverseMass_
	
End Function

Function LinearState.GetImpulse() As Vec2
	
	Return Impulse_
	
End Function

'Function LinearState.GetForce() As Vec2
'	
'	Return Force_
'	
'End Function

Function LinearState.GetVelocity() As Vec2
	
	Return Velocity_
	
End Function

Function LinearState.GetPosition() As Vec2
	
	Return Position_
	
End Function

Function LinearState.GetFlag( ByVal flag As integer ) As Integer
	
	Return ( Flags_ And flag )
	
End Function


'' Reset
Sub LinearState.ResetAll()
	
	Mass_        = 0.0
	InverseMass_ = 0.0
	
	Impulse_     = Vec2( 0.0, 0.0 )
	'Force_       = Vec2( 0.0, 0.0 )
	Velocity_    = Vec2( 0.0, 0.0 )
	Position_    = Vec2( 0.0, 0.0 )
	
	Flags_       = 0
	
End Sub


'' Set
Sub LinearState.SetMass( ByVal m As Single )
	
	Mass_ = m
	
End Sub

Sub LinearState.SetInverseMass( ByVal i As Single )  
	
	InverseMass_ = i
	
End Sub

Sub LinearState.SetImpulse( ByVal i As Vec2 )
	
	Impulse_ = i
	
End Sub

'Sub LinearState.SetForce( ByVal f As Vec2 )
'	
'	Force_ = f
'	
'End Sub

Sub LinearState.SetVelocity( ByVal v As Vec2 )
	
	Velocity_ = v
	
End Sub

Sub LinearState.SetPosition( ByVal p As Vec2 )
	
	Position_ = p
	
End Sub

Sub LinearState.LowerFlag( ByVal flag As Integer )
	
	Flags_ And= Not flag
	
End Sub

Sub LinearState.RaiseFlag( ByVal flag As Integer )
	
	Flags_ Or= flag
	
End Sub

Sub LinearState.ToggleFlag( ByVal flag As Integer )
	
	Flags_ Xor= flag
	
End Sub


#EndIf ''__S2_LINEAR_STATE_BI__
