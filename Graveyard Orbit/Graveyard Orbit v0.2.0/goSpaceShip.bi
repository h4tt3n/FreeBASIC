''******************************************************************************
''    
''  Graveyard Orbit - A 2D space physics puzzle game
''
''  Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''  Version 0.2.0, May 1. 2017
''  
''  Author:
''  Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''    
''  Description:
''  
''
''******************************************************************************


#Ifndef __GO_SPACESHIP_BI__
#Define __GO_SPACESHIP_BI__


''
Type SpaceShip Extends RigidBody
	
	Public:
	
	''
	Declare Constructor()
	
	''
	Declare Destructor()
	
	''
	Declare Operator Let( ByRef S As SpaceShip )
	
	'' Add
	
	'' Apply
	Declare Sub ApplyThrust( ByVal _throttle As Single )
	Declare Sub ApplyImpulse( ByVal _impulse As Single )
	
	'' Compute
	Declare Sub ComputeDeltaV()
	Declare Sub ComputeFuelMass()
	
	'' Get
	Declare Const Function GetDeltaV()   As Single
	Declare Const Function GetDryMass()  As Single
	Declare Const Function GetFuelMass() As Single
	
	'' Reset
	Declare Virtual Sub ResetAll() Override
	
	'' Set
	Declare Sub SetDryMass  ( ByVal d As Single )
	Declare Sub SetFuelMass ( ByVal f As Single )
	
	''
	As ThrusterPtrContainer Thrusters_
	
	Protected:
	
	As Single DeltaV_            '' ( m/s )
	As Single FuelMass_          '' ( kg )
	As Single DryMass_           '' ( kg )
	
End Type


''
Constructor SpaceShip()
	
	Thrusters_.Reserve( MAX_ENGINES_IN_SPACE_SHIP )
	
End Constructor


''
Destructor SpaceShip()
	
	Thrusters_.Destroy()
	
End Destructor


''
Operator SpaceShip.Let( ByRef S As SpaceShip )
	
	If ( Not @This = @S ) Then
		
		Cast( Body, This ) = S
		
		DeltaV_   = S.DeltaV_
		FuelMass_ = S.FuelMass_
		DryMass_  = S.DryMass_
		
		Thrusters_  = S.Thrusters_
		
	End If
	
End Operator


'' Apply
Sub SpaceShip.ApplyThrust( ByVal _throttle As Single )
	
	If ( Not Thrusters_.Empty ) Then
		
		For TP As Thruster Ptr = Thrusters_.p_front To Thrusters_.p_back
			
			TP->ApplyThrust( _throttle )
			
		Next
		
	EndIf
	
End Sub

Sub SpaceShip.ApplyImpulse( ByVal _impulse As Single )
	
	
	
End Sub


'' Get
Function SpaceShip.GetDeltaV() As Single
	
	Return DeltaV_
	
End Function

Function SpaceShip.GetDryMass() As Single
	
	Return DryMass_
	
End Function

Function SpaceShip.GetFuelMass() As Single
	
	Return FuelMass_
	
End Function


'' Compute
Sub SpaceShip.ComputeDeltaV()
	
	'' The Tsiolkovsky rocket equation.
	''
	'' dv = ve * Ln( m0 / m1 )
	''
	'' This function computes the maximum possible delta v
	'' with regard to engine effective exhaust velocity,
	'' and the ships fuel mass and "dry" mass.
	
	Dim As Single exhaust_velocity = 0.0
	Dim As Single thrust = 0.0
	Dim As Single fuel_flow_rate = 0.0
	
	If ( Not Thrusters_.Empty ) Then
		
		For TP As Thruster Ptr = Thrusters_.p_front To Thrusters_.p_back
			
			thrust += TP->GetExhaustVelocity() * TP->GetFuelFlowRate()
			
			fuel_flow_rate += TP->GetFuelFlowRate()
			
		Next
		
	EndIf
	
	exhaust_velocity = thrust / fuel_flow_rate
	
	DeltaV_ = exhaust_velocity * Log( ( DryMass_ + FuelMass_ ) / DryMass_ )
	
End Sub

Sub SpaceShip.ComputeFuelMass()
	
	'' The "reverse" Tsiolkovsky rocket equation.
	''
	'' m0 - m1 = m1 * e^( dv / ve - 1 )
	''
	'' This function computes the fuel mass required to
	'' reach a given delta v, for a given ship "dry" 
	'' mass and engine effective exhaust velocity.
	
	'FuelMass_ = DryMass_ * Exp( DeltaV_ / ExhaustVelocity_ - 1.0 )
	
End Sub


'' Reset
Sub SpaceShip.ResetAll()
	
	Base.ResetAll()
	
	Thrusters_.Destroy()
	
End Sub


'' Set
Sub SpaceShip.SetDryMass( ByVal d As Single )
	
	DryMass_ = d
	
End Sub

Sub SpaceShip.SetFuelMass( ByVal f As Single )
	
	FuelMass_ = f
	
End Sub


#EndIf __GO_SPACESHIP_BI__
