''******************************************************************************
''    
''  Graveyard Orbit - A 2D space physics puzzle game
''
''  Prototype #1
''
''  Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''  Version 0.1.0, October 31. 2016
''  
''  Author:
''  Michael "h4tt3n" Schmidt Nissen, michaelschmidtnissen@gmail.com
''    
''  Description:
''  
''
''******************************************************************************


''
#Ifndef __GO_ENGINE_BI__
#Define __GO_ENGINE_BI__


''
Type Engine Extends Rotate
	
	Public:
	
	''
	Declare Constructor()
	Declare Constructor( ByRef T As Engine )
	
	''
	Declare Destructor()
	
	''
	Declare Operator Let( ByRef T As Engine )
	
	''
	Declare Sub Burn( ByVal _strength As Single ) '' range [ -1.0 - +1.0 ]
	
	'' Compute
	Declare Sub ComputeExhaustVelocity()
	Declare Sub ComputeFuelFlowRate()
	Declare Sub ComputeThrustForce()
	
	'' Get
	Declare Sub ExhaustVelocity() As Single
	Declare Sub FuelFlowRate()    As Single
	Declare Sub ThrustForce()     As Single
	
	'' Set
	Declare Function ExhaustVelocity ( ByVal e As Single )
	Declare Function FuelFlowRate    ( ByVal f As Single )
	Declare Function ThrustForce     ( ByVal t As Single )
	
	'' Reset
	Declare Sub ResetAll()	
	
	Protected:
	
	As Single ExhaustVelocity_  '' Effective exhaust velocity, m/s
	As Single FuelFlowRate_     '' Propellant flow rate, kg/s
	'As Single SpecificImpulse_  ''Specific impulse, s
	As Single ThrustForce_      '' Engine thrust force, n
	
	As String Name_
	
End Type


''
Constructor Engine()
	
End Constructor

Constructor Engine( ByRef T As Engine )
	
	This = T
	
End Constructor


''
Destructor Engine()

End Destructor


''
Operator Engine.Let( ByRef T As Engine )
	
End Operator


''
Sub Engine.Burn( ByVal _strength As Single )
	
	AddForce( _strength * ThrustForce_ * AngleVector )
	
End Sub


'' Compute
Sub Engine.ComputeExhaustVelocity()
	
	ExhaustVelocity_ = ThrustForce_ / FuelFlowRate_
	
End Sub

Sub Engine.ComputeFuelFlowRate()
	
	FuelFlowRate_ = ThrustForce_ / ExhaustVelocity_
	
End Sub

Sub Engine.ComputeThrustForce()
	
	ThrustForce_ = ExhaustVelocity_ * FuelFlowRate_
	
End Sub


'' Get
Sub Engine.ExhaustVelocity() As Single
	
	Return ExhaustVelocity_
	
End Sub

Sub Engine.FuelFlowRate() As Single
	
	Return FuelFlowRate_
	
End Sub

Sub Engine.ThrustForce() As Single
	
	Return ThrustForce_
	
End Sub


'' Set
Function Engine.ExhaustVelocity( ByVal e As Single )
	
	ExhaustVelocity_ = e
	
End Function

Function Engine.FuelFlowRate( ByVal f As Single )
	
	FuelFlowRate_ = f
	
End Function

Function Engine.ThrustForce( ByVal t As Single )
	
	ThrustForce_ = t
	
End Function


'' Reset


#EndIf ''__GO_ENGINE_BI__
