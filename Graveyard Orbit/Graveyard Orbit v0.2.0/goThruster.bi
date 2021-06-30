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
#Ifndef __GO_THRUSTER_BI__
#Define __GO_THRUSTER_BI__


''
Type Thruster Extends RigidBody
	
	Public:
	
	''
	Declare Constructor()
	
	Declare Constructor( ByRef T As Thruster )
	
	Declare Constructor( ByVal _mass             As Single, _
	                     ByVal _position         As Vec2, _
	                     ByVal _exhaust_velocity As Single, _
	                     ByVal _fuel_flow_rate   As Single )
	
	''
	Declare Destructor()
	
	''
	Declare Operator Let( ByRef T As Thruster )
	
	''
	Declare Sub AddImpulse( ByVal i As Vec2 )
	
	'' Apply
	Declare Sub ApplyThrust ( ByVal _thrust_impulse  As Single )
	
	'' Compute
	Declare Sub ComputeExhaustVelocity()
	Declare Sub ComputeFuelFlowRate()
	Declare Sub ComputeThrustForce()
	
	'' Get
	Declare Const Function GetExhaustVelocity() As Single
	Declare Const Function GetFuelFlowRate()    As Single
	Declare Const Function GetThrustForce()     As Single
	
	'' Set
	Declare Sub SetExhaustVelocity ( ByVal e As Single )
	Declare Sub SetFuelFlowRate    ( ByVal f As Single )
	Declare Sub SetThrustForce     ( ByVal t As Single )
	
	'' Reset
	Declare Virtual Sub ResetAll() Override
	
	Protected:
	
	As Single DeltaV_           '' ( m/s ) 'property
	As Single ExhaustVelocity_  '' Effective exhaust velocity, m/s
	As Single FuelFlowRate_     '' Propellant flow rate, kg/s
	As Single ThrustForce_      '' Engine thrust force, n
	
End Type


''
Constructor Thruster()
	
	ResetAll()
	
End Constructor

Constructor Thruster( ByRef T As Thruster )
	
	ResetAll()
	
	This = T
	
End Constructor

Constructor Thruster( ByVal _mass             As Single, _
	                   ByVal _position         As Vec2, _
	                   ByVal _exhaust_velocity As Single, _
	                   ByVal _fuel_flow_rate   As Single )
	
	''
	ResetAll()
	
	''
	Mass_             = _mass
	Position_         = _position
	ExhaustVelocity_  = _exhaust_velocity
	FuelFlowRate_     = _fuel_flow_rate
	
	ComputeInverseMass()
	
	RaiseFlag( IS_ALIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
End Constructor


''
Destructor Thruster()

End Destructor


''
Operator Thruster.Let( ByRef T As Thruster )
	
	If ( Not @This = @T ) Then
		
		Cast( AngularState, This ) = T
		
		DeltaV_          = T.DeltaV_
		ExhaustVelocity_ = T.ExhaustVelocity_
		FuelFlowRate_    = T.FuelFlowRate_
		ThrustForce_     = T.ThrustForce_
		
	End If
	
End Operator


'' Add
Sub Thruster.AddImpulse( ByVal i As Vec2 )
	
	Base.AddImpulse( i )
	
End Sub


''
Sub Thruster.ApplyThrust ( ByVal _thrust_impulse  As Single )
	
	''
	AddImpulse( _thrust_impulse * AngleVector_  ) 
	
End Sub


'' Compute
Sub Thruster.ComputeExhaustVelocity()
	
	ExhaustVelocity_ = ThrustForce_ / FuelFlowRate_
	
End Sub

Sub Thruster.ComputeFuelFlowRate()
	
	FuelFlowRate_ = ThrustForce_ / ExhaustVelocity_
	
End Sub

Sub Thruster.ComputeThrustForce()
	
	ThrustForce_ = ExhaustVelocity_ * FuelFlowRate_
	
End Sub


'' Get
Function Thruster.GetExhaustVelocity() As Single
	
	Return ExhaustVelocity_
	
End Function

Function Thruster.GetFuelFlowRate() As Single
	
	Return FuelFlowRate_
	
End Function

Function Thruster.GetThrustForce() As Single
	
	Return ThrustForce_
	
End Function


'' Set
Sub Thruster.SetExhaustVelocity( ByVal e As Single )
	
	ExhaustVelocity_ = e
	
End Sub

Sub Thruster.SetFuelFlowRate( ByVal f As Single )
	
	FuelFlowRate_ = f
	
End Sub

Sub Thruster.SetThrustForce( ByVal t As Single )
	
	ThrustForce_ = t
	
End Sub


'' Reset
Sub Thruster.ResetAll()
	
	Base.ResetAll()
	
	DeltaV_          = 0.0
	ExhaustVelocity_ = 0.0
	FuelFlowRate_    = 0.0
	ThrustForce_     = 0.0
	
End Sub

#EndIf __GO_THRUSTER_BI__
