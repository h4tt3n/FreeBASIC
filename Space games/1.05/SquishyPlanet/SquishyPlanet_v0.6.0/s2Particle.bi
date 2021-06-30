''******************************************************************************
''
''   Squishy2D Particle Class
''   Written in FreeBASIC 1.05
''   version 0.2.0, May 2016, Michael "h4tt3n" Nissen
''
''   This is the inherited base type of all physical objects. It takes care 
''   of linear motion. It is the only object that does this, all other objects 
''   inherit their linear motion properties from this class. 
''   All forces are interacting between two particles, which means that they can 
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
#Ifndef __S2_PARTICLE_BI__
#Define __S2_PARTICLE_BI__


''
Type Particle Extends Object
	
	Public:
	
	'' Constructors
	Declare Constructor()
	
	Declare Constructor( ByRef p As Particle )
	
	Declare Constructor( ByVal _mass As Single )
	
	Declare Constructor( ByVal _mass     As Single, _
	                     ByVal _position As Vec2 )
	
	Declare Constructor( ByVal _mass     As Single, _
	                     ByVal _radius   As Single, _
	                     ByVal _position As Vec2 )
	
	'' Operators
	Declare Operator Let( ByRef p As Particle )
	
	'' Add
	Declare Virtual Sub AddImpulse  ( ByVal i As Vec2 )
	'Declare Virtual Sub AddForce    ( ByVal f As Vec2 )
	Declare Virtual Sub AddPosition ( ByVal p As Vec2 )
	Declare Virtual Sub AddVelocity ( ByVal v As Vec2 )
	
	'' Compute
	Declare Sub ComputeInverseMass()
	Declare Sub ComputeRadius()
	
	'' Get
	Declare Const Function InverseMass() As Single
	Declare Const Function Mass()        As Single
	Declare Const Function Radius()      As Single
	
	Declare Const Virtual Function Impulse()  As Vec2
	'Declare Const Virtual Function Force()    As Vec2
	Declare Const Virtual Function Position() As Vec2
	Declare Const Virtual Function Velocity() As Vec2
	
	Declare Const Function GetFlag( ByVal flag As integer ) As Integer
	
	'' Reset
	Declare Sub ResetAll()
	
	'' Set
	Declare Sub Mass        ( ByVal m As Single )
	Declare Sub InverseMass ( ByVal i As Single )
	Declare Sub Radius      ( ByVal r As Single )
	
	Declare Virtual Sub Impulse  ( ByVal i As Vec2 )
	'Declare Virtual Sub Force    ( ByVal f As Vec2 )
	Declare Virtual Sub Position ( ByVal p As Vec2 )
	Declare Virtual Sub Velocity ( ByVal v As Vec2 )
	
	Declare Sub LowerFlag( ByVal Flag As Integer )
	Declare Sub RaiseFlag( ByVal Flag As Integer )
	Declare Sub ToggleFlag( ByVal Flag As Integer )
	
 	Protected:
	
	As UInteger Flags_
	
	''
	As Single Mass_
	As Single InverseMass_
	As Single Radius_
	
	''
	As Vec2 Impulse_
	'As Vec2 Force_
	As Vec2 Velocity_
	As Vec2 Position_
	
End Type


'' Constructors
Constructor Particle
	
	ResetAll()
	
End Constructor

Constructor Particle( ByRef p As Particle )
	
	ResetAll()
	
	This = p
	
End Constructor

Constructor Particle( ByVal _mass As Single )
	
	ResetAll()
	
	Mass_ = _mass
	
	ComputeInverseMass()
	ComputeRadius()
	
	RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
End Constructor

Constructor Particle( ByVal _mass As Single, _
                      ByVal _position As Vec2 )
	
	ResetAll()
	
	Mass_     = _mass
	Position_ = _position
	
	ComputeInverseMass()
	ComputeRadius()
	
	RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
End Constructor

Constructor Particle( ByVal _mass As Single, _
                      ByVal _radius As Single, _
                      ByVal _position As Vec2 )
	
	ResetAll()
	
	Mass_     = _mass
	Position_ = _position
	Radius_   = _radius
	
	ComputeInverseMass()
	
	RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
End Constructor


'' Operators
Operator Particle.Let( ByRef p As Particle )
	
	If ( @This <> @p ) Then
		
		Flags_       = p.Flags_
		Mass_        = p.Mass_
		InverseMass_ = p.InverseMass_
		Radius_      = p.Radius_
		Impulse_     = p.Impulse_
		'Force_       = p.Force_
		Velocity_    = p.Velocity_
		Position_    = p.Position_
		
		'Cast( Object, This ) = p
		
	EndIf
	
End Operator


'' Add
Sub Particle.AddImpulse( ByVal i As Vec2 )
	
	Impulse_ += i
	
End Sub

'Sub Particle.AddForce( ByVal f As Vec2 )
'	
'	Force_ += f
'	
'End Sub

Sub Particle.AddPosition( ByVal p As Vec2 )
	
	Position_ += p
	
End Sub

Sub Particle.AddVelocity( ByVal v As Vec2 )
	
	Velocity_ += v
	
End Sub


'' Compute
Sub Particle.ComputeInverseMass()
	
	InverseMass_ = IIf( Mass_ > 0.0 , 1.0 / Mass_ , 0.0 )
	
End Sub

Sub Particle.ComputeRadius()
	
	'' temporary hack
	
	Dim As Single area = Mass_ * 50.0
	
	Radius_ = Sqr( area / PI )
	
End Sub


'' Get
Function Particle.Mass() As Single
	
	Return Mass_
	
End Function

Function Particle.InverseMass() As Single
	
	Return InverseMass_
	
End Function

Function Particle.Radius() As Single
	
	Return Radius_
	
End Function

Function Particle.Impulse() As Vec2
	
	Return Impulse_
	
End Function

'Function Particle.Force() As Vec2
'	
'	Return Force_
'	
'End Function

Function Particle.Velocity() As Vec2
	
	Return Velocity_
	
End Function

Function Particle.Position() As Vec2
	
	Return Position_
	
End Function

Function Particle.GetFlag( ByVal flag As integer ) As Integer
	
	Return ( Flags_ And flag )
	
End Function


'' Reset
Sub Particle.ResetAll()
	
	Mass_        = 0.0
	InverseMass_ = 0.0
	Radius_      = 0.0
	
	Impulse_     = Vec2( 0.0, 0.0 )
	'Force_       = Vec2( 0.0, 0.0 )
	Velocity_    = Vec2( 0.0, 0.0 )
	Position_    = Vec2( 0.0, 0.0 )
	
	Flags_       = 0
	
End Sub


'' Set
Sub Particle.Mass( ByVal m As Single )
	
	Mass_ = m
	
End Sub

Sub Particle.InverseMass( ByVal i As Single )  
	
	InverseMass_ = i
	
End Sub

Sub Particle.Radius( ByVal r As Single )
	
	Radius_ = r
	
End Sub

Sub Particle.Impulse( ByVal i As Vec2 )
	
	Impulse_ = i
	
End Sub

'Sub Particle.Force( ByVal f As Vec2 )
'	
'	Force_ = f
'	
'End Sub

Sub Particle.Velocity( ByVal v As Vec2 )
	
	Velocity_ = v
	
End Sub

Sub Particle.Position( ByVal p As Vec2 )
	
	Position_ = p
	
End Sub

Sub Particle.LowerFlag( ByVal flag As Integer )
	
	Flags_ And= Not flag
	
End Sub

Sub Particle.RaiseFlag( ByVal flag As Integer )
	
	Flags_ Or= flag
	
End Sub

Sub Particle.ToggleFlag( ByVal flag As Integer )
	
	Flags_ Xor= flag
	
End Sub


#EndIf ''__S2_PARTICLE_BI__
