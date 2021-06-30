''***************************************************************************
''  Translate base type (linear motion)
''***************************************************************************

Type PointMassType
  
  Public:
  
  ''	compute
  
  ''	get
  Declare Function getMass         () As Float
  Declare Function getInverseMass  () As Float
  Declare Function getForce        () As Vec2f
  Declare Function getAcceleration () As Vec2f
  Declare Function getVelocity     () As Vec2f
  Declare Function getPosition     () As Vec2f
  
  ''	set
  Declare Sub setMass         ( ByVal mass         As Float )          
  Declare Sub setInverseMass  ( ByVal inversemass  As Float )  
  Declare Sub setForce        ( ByVal force        As vec2f )         
  Declare Sub setAcceleration ( ByVal acceleration As vec2f )    
  Declare Sub setVelocity     ( ByVal velocity     As vec2f )       
  Declare Sub setPosition     ( ByVal position     As vec2f )    
  
  Protected:
  ''Private:
  
  As float mass_
  As float inverseMass_
  As vec2f force_
  As vec2f acceleration_
  As vec2f velocity_
  As vec2f position_
  
End Type


Function PointMassType.getMass() As Float
	Return mass_
End Function

Function PointMassType.getInverseMass() As Float
	Return inverseMass_
End Function

Function PointMassType.getForce() As Vec2f
	Return force_
End Function

Function PointMassType.getAcceleration() As Vec2f
	Return acceleration_
End Function

Function PointMassType.getVelocity() As Vec2f
	Return velocity_
End Function

Function PointMassType.getPosition() As Vec2f
	Return position_
End Function

Sub PointMassType.setMass( ByVal mass As Float )
	mass_ = mass
End Sub

Sub PointMassType.setInverseMass( ByVal inversemass As Float )  
	inverseMass_ = inverseMass
End Sub

Sub PointMassType.setForce( ByVal force As vec2f )
	force_ = force
End Sub

Sub PointMassType.setAcceleration( ByVal acceleration As vec2f )   
	acceleration_ = acceleration
End Sub

Sub PointMassType.setVelocity( ByVal velocity As vec2f )
	velocity_ = velocity
End Sub

Sub PointMassType.setPosition( ByVal position As vec2f )
	position_ = position
End Sub