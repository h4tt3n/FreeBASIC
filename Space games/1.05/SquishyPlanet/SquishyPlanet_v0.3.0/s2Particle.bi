''******************************************************************************
''
''   Squishy2D Particle Class
''   Written in FreeBASIC 1.04
''   version 0.1.0, October 2015, Michael "h4tt3n" Nissen
''
''   This is the inherited base type of all physical objects. It is basically
''   a particle class that takes care of linear motion.
''   It is the only object that does this, all other objects inherit their 
''   linear motion properties from this class.
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
	
	'' Operators
	Declare Operator Let( ByRef p As Particle )
	
	'' Add
	Declare Sub AddImpulse  ( ByVal i As Vec2 )
	Declare Sub AddVelocity ( ByVal v As Vec2 )
	Declare Sub AddPosition ( ByVal p As Vec2 )
	
	'' Get
	Declare Const Function Impulse     () As Vec2
	Declare Const Function InverseMass () As Single
	Declare Const Function Mass        () As Single
	Declare Const Function Position    () As Vec2
	Declare Const Function Radius      () As Single
	Declare Const Function Velocity    () As Vec2
	
	'' Reset
	Declare Sub ResetAll()
	
	'' Set
	Declare Sub Mass        ( ByVal m As Single )
	Declare Sub InverseMass ( ByVal i As Single )
	Declare Sub Radius      ( ByVal r As Single )
	Declare Sub Impulse     ( ByVal i As Vec2 )
	Declare Sub Velocity    ( ByVal v As Vec2 )
	Declare Sub Position    ( ByVal p As Vec2 )
	
	Protected:
	
	''
	'As Boolean IsAlive_     '' Alive and kicking
	'As Boolean IsDynamic_   '' Dynamic movement, responds to interaction
	'As Boolean IsKinematic_ '' Kinematic movement, does not respond to interaction
	'As Boolean IsStatic_    '' Interactis with surroundings, but is fixed in place
	
	''
	As Single Mass_
	As Single InverseMass_
	As Single Radius_
	As Vec2   Impulse_
	As Vec2   Velocity_
	As Vec2   Position_
	
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
	
	Mass_        = _mass
	InverseMass_ = 1.0 / Mass_
	
End Constructor

Constructor Particle( ByVal _mass As Single, ByVal _position As Vec2 )
	
	ResetAll()
	
	Mass_        = _mass
	Position_    = _position
	InverseMass_ = 1.0 / Mass_
	
End Constructor


'' Operators
Operator Particle.Let( ByRef p As Particle )

	Mass_        = p.Mass_
	InverseMass_ = p.InverseMass_
	Radius_      = p.Radius_
	Impulse_     = p.Impulse_
	Velocity_    = p.Velocity_
	Position_    = p.Position_

End Operator


'' Add
Sub Particle.AddImpulse ( ByVal i As Vec2 )
	
	Impulse_ += i
	
End Sub

Sub Particle.AddPosition ( ByVal p As Vec2 )
	
	Position_ += p
	
End Sub

Sub Particle.AddVelocity ( ByVal v As Vec2 )
	
	Velocity_ += v
	
End Sub


'' 
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

Function Particle.Velocity() As Vec2
	
	Return Velocity_
	
End Function

Function Particle.Position() As Vec2
	
	Return Position_
	
End Function


'' Reset
Sub Particle.ResetAll()
	
	Mass_        = 0.0
	InverseMass_ = 0.0
	Radius_      = 0.0
	Impulse_     = Vec2( 0.0, 0.0 )
	Velocity_    = Vec2( 0.0, 0.0 )
	Position_    = Vec2( 0.0, 0.0 )
	
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

Sub Particle.Velocity( ByVal v As Vec2 )
	
	Velocity_ = v
	
End Sub

Sub Particle.Position( ByVal p As Vec2 )
	
	Position_ = p
	
End Sub


#EndIf ''__S2_PARTICLE_BI__
