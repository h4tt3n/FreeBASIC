''***************************************************************************
''  Rotate base type (angular motion)
''***************************************************************************

Type RotateType
  
  Public:
  
  ''	compute
  
  ''  get
  Declare Function getN                      () As Vec2f
  Declare Function getMomentOfInertia        () As Float
  Declare Function getInverseMomentOfInertia () As Float
  Declare Function getTorque                 () As Float
  Declare Function getAngularAcceleration    () As Float
  Declare Function getAngularVelocity        () As Float
  Declare Function getAngle                  () As Float
  
  ''  set
  Declare Sub setN                      ( ByVal n As Vec2f )                      
  Declare Sub setMomentOfInertia        ( ByVal momentofinertia As Float )        
  Declare Sub setInverseMomentOfInertia ( ByVal inversemomentofinertia As Float ) 
  Declare Sub setTorque                 ( ByVal torque As Float )                 
  Declare Sub setAngularAcceleration    ( ByVal angularacceleration As Float )    
  Declare Sub setAngularVelocity        ( ByVal angularvelocity As Float )        
  Declare Sub setAngle                  ( ByVal angle As Float )                  
  
  Protected:
  ''Private:
  
  As Vec2f n_
  As Float momentOfInertia_
  As Float inverseMomentOfInertia_
  As Float torque_
  As Float angularAcceleration_
  As FLoat angularVelocity_
  As Float angle_
  
End Type



Function RotateType.getN() As Vec2f
	Return n_
End Function

Function RotateType.getMomentOfInertia() As Float
	Return momentOfInertia_
End Function

Function RotateType.getInverseMomentOfInertia() As Float
	Return inverseMomentOfInertia_
End Function

Function RotateType.getTorque() As Float
	Return torque_
End Function

Function RotateType.getAngularAcceleration() As Float
	Return angularAcceleration_
End Function

Function RotateType.getAngularVelocity() As Float
	Return angularVelocity_
End Function

Function RotateType.getAngle() As Float
	Return angle_
End Function

Sub RotateType.setN( ByVal n As Vec2f )
	n_ = n
End Sub

Sub RotateType.setMomentOfInertia( ByVal momentofinertia As Float )
	momentOfInertia_ = momentofinertia
End Sub

Sub RotateType.setInverseMomentOfInertia( ByVal inversemomentofinertia As Float )
	inverseMomentOfInertia_ = inversemomentofinertia
End Sub

Sub RotateType.setTorque( ByVal torque As Float )
	torque_ = torque
End Sub

Sub RotateType.setAngularAcceleration( ByVal angularacceleration As Float )
	angularAcceleration_ = angularacceleration
End Sub

Sub RotateType.setAngularVelocity( ByVal angularvelocity As Float )
	angularVelocity_ = angularvelocity
End Sub

Sub RotateType.setAngle( ByVal angle As Float )
	angle_ = angle
End Sub
