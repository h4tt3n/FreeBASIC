''***************************************************************************
''
''   Squishy2D Point Mass Class
''   Written in FreeBASIC 1.04
''   version 0.1.0, October 2015, Michael "h4tt3n" Nissen
''
''   This is the inherited base type of all physical objects with mass.
''
''***************************************************************************


''
#Ifndef __S2_POINT_MASS_BI__
#Define __S2_POINT_MASS_BI__


''
Type PointMass Extends Object
  
  Public:
  
  '' Constructors
  Declare Constructor()
  Declare Constructor( ByRef P As PointMass )
  Declare Constructor( ByVal mass As Single )
  Declare Constructor( ByVal mass As Single, ByVal position As Vec2 )
  
  '' Operators
  Declare Operator Let( ByRef P As PointMass )
  
  '' Compute
  
  '' Add
  Declare Sub AddForce   ( ByVal force   As Vec2 )
  Declare Sub AddImpulse ( ByVal impulse As Vec2 )
  
  '' Get
  Declare Const Function GetMass        () As Single
  Declare Const Function GetInverseMass () As Single
  Declare Const Function GetForce       () As Vec2
  Declare Const Function GetImpulse     () As Vec2
  Declare Const Function GetVelocity    () As Vec2
  Declare Const Function GetPosition    () As Vec2
  
  '' Reset
  Declare Sub ResetAll()
  
  '' Set
  Declare Sub SetMass        ( ByVal mass        As Single )
  Declare Sub SetInverseMass ( ByVal inversemass As Single )
  Declare Sub SetForce       ( ByVal force       As Vec2 )
  Declare Sub SetImpulse     ( ByVal impulse     As Vec2 )
  Declare Sub SetVelocity    ( ByVal velocity    As Vec2 )
  Declare Sub SetPosition    ( ByVal position    As Vec2 )
  
  Protected:
  
  ''
  As Boolean IsAlive
  As Boolean IsDynamic
  As Boolean IsKinematic
  As Boolean IsStatic
  
  ''
  As Single Mass_
  As Single InverseMass_
  As Vec2   Force_
  As Vec2   Impulse_
  As Vec2   Velocity_
  As Vec2   Position_
  
End Type


'' Constructors
Constructor PointMass
	
	ResetAll()
	
End Constructor

Constructor PointMass( ByRef P As PointMass )
	
	ResetAll()
	
	This = P
	
End Constructor

Constructor PointMass( ByVal mass As Single )
	
	ResetAll()
	
	Mass_ = mass
	
End Constructor

Constructor PointMass( ByVal mass As Single, ByVal position As Vec2 )
	
	ResetAll()
	
	Mass_     = mass
	Position_ = position
	
End Constructor


'' Operators
Operator PointMass.Let( ByRef P As PointMass )

	Mass_        = P.Mass_
	InverseMass_ = P.InverseMass_
	Force_       = P.Force_
	Impulse_     = P.Impulse_
	Velocity_    = P.Velocity_
	Position_    = P.Position_

End Operator


'' Add
Sub PointMass.AddForce ( ByVal force As Vec2 )
	
	Force_ += force
	
End Sub

Sub PointMass.AddImpulse ( ByVal impulse As Vec2 )
	
	Impulse_ += impulse
	
End Sub


'' Get
Function PointMass.getMass() As Single
	
	Return Mass_
	
End Function

Function PointMass.getInverseMass() As Single
	
	Return InverseMass_
	
End Function

Function PointMass.getForce() As Vec2
	
	Return Force_
	
End Function

Function PointMass.getImpulse() As Vec2
	
	Return Impulse_
	
End Function

Function PointMass.getVelocity() As Vec2
	
	Return Velocity_
	
End Function

Function PointMass.getPosition() As Vec2
	
	Return Position_
	
End Function


'' Reset
Sub PointMass.ResetAll()
	
	Mass_        = 0.0
	InverseMass_ = 0.0
	Force_       = Vec2( 0.0, 0.0 )
	Impulse_     = Vec2( 0.0, 0.0 )
	Velocity_    = Vec2( 0.0, 0.0 )
	Position_    = Vec2( 0.0, 0.0 )
	
End Sub


'' Set
Sub PointMass.setMass( ByVal mass As Single )
	
	Mass_ = mass
	
End Sub

Sub PointMass.setInverseMass( ByVal inversemass As Single )  
	
	InverseMass_ = inverseMass
	
End Sub

Sub PointMass.setForce( ByVal force As Vec2 )
	
	Force_ = force
	
End Sub

Sub PointMass.setImpulse( ByVal impulse As Vec2 )
	
	Impulse_ = impulse
	
End Sub

Sub PointMass.setVelocity( ByVal velocity As Vec2 )
	
	Velocity_ = velocity
	
End Sub

Sub PointMass.setPosition( ByVal position As Vec2 )
	
	Position_ = position
	
End Sub


#EndIf ''__S2_POINT_MASS_BI__
