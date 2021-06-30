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


#Ifndef __GO_ROCKET_BI__
#Define __GO_ROCKET_BI__


''
Type Rocket Extends AngularState
	
	Public:
	
	''
	Declare Constructor()
	
	Declare Constructor( ByRef R As Rocket )
	
	Declare Constructor( ByVal _dry_mass         As Single, _
	                     ByVal _exhaust_velocity As Single, _
	                     ByVal _fuel_flow_Rate   As Single, _
	                     ByVal _position         As Vec2 )
	
	''
	Declare Destructor()
	
	''
	Declare Operator Let( ByRef R As Rocket )
	
	'' Add
	Declare Sub AddImpulse( ByVal i As Vec2 ) Override
	
	'' Apply
	Declare Sub ApplyDeltaV   ( ByVal _delta_v   As Single )
	Declare Sub ApplyFuelMass ( ByVal _fuel_mass As Single )
	Declare Sub ApplyThrust   ( ByVal _throttle  As Single )
	
	'' Compute
	Declare Sub ComputeDeltaV()
	Declare Sub ComputeFuelMass()
	
	'' Get
	Declare Const Function GetDeltaV()          As Single
	Declare Const Function GetDryMass()         As Single
	Declare Const Function GetFuelMass()        As Single
	Declare Const Function GetExhaustVelocity() As Single
	Declare Const Function GetFuelFlowRate()    As Single
	
	'' Set
	Declare Sub SetDeltaV          ( ByVal d As Single )
	Declare Sub SetDryMass         ( ByVal d As Single )
	Declare Sub SetFuelMass        ( ByVal f As Single )
	Declare Sub SetExhaustVelocity ( ByVal e As Single )
	Declare Sub SetFuelFlowRate    ( ByVal f As Single )
	
	'' Reset
	Declare Virtual Sub ResetAll() Override
	
	As LinearSpring Ptr Grapple_
	
	Protected:
	
	As Single DeltaV_            '' ( m/s ) 'property
	As Single FuelMass_          '' ( kg )
	As Single DryMass_           '' ( kg )
	As Single ExhaustVelocity_   '' ( m/s )
	As Single FuelFlowRate_      '' ( kg/s )
	
End Type


''
Constructor Rocket()
	
	'Base()
	
	ResetAll()
	
End Constructor

Constructor Rocket( ByRef R As Rocket )
	
	'Base()
	
	ResetAll()
	
	This = R
	
End Constructor

Constructor Rocket( ByVal _dry_mass         As Single, _
	                 ByVal _exhaust_velocity As Single, _
	                 ByVal _fuel_flow_Rate   As Single, _
	                 ByVal _position         As Vec2 )
	
	ResetAll()
	
	DryMass_         = _dry_mass
	ExhaustVelocity_ = _exhaust_velocity
	FuelFlowRate_    = _fuel_flow_Rate
	Position_        = _position
	
	FuelMass_ = 0.0
	
	Mass_ = DryMass_
	'Mass( _dry_mass )
	
	ComputeInverseMass()
	
	RaiseFlag( IS_ALIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
End Constructor


''
Destructor Rocket()
	
	ResetAll()
	
End Destructor


''
Operator Rocket.Let( ByRef R As Rocket )
	
	If ( Not @This = @R ) Then
		
		Cast( AngularState, This ) = R
		
		Grapple_         = R.Grapple_
		
		DeltaV_          = R.DeltaV_
		FuelMass_        = R.FuelMass_
		DryMass_         = R.DryMass_
		ExhaustVelocity_ = R.ExhaustVelocity_
		FuelFlowRate_    = R.FuelFlowRate_
		
	End If
	
End Operator


'' Add
Sub Rocket.AddImpulse( ByVal i As Vec2 )
	
	Base.AddImpulse( i )
	
End Sub


'' Apply
Sub Rocket.ApplyDeltaV( ByVal _delta_v As Single )
	
	DeltaV_ = _delta_v
	
	ComputeFuelMass()
	
	Mass_ = DryMass_ + FuelMass_
	'Mass( Mass + FuelMass_ )
	
	ComputeInverseMass()
	
End Sub

Sub Rocket.ApplyFuelMass( ByVal _fuel_mass As Single )
	
	FuelMass_ = _fuel_mass
	
	Mass_ += FuelMass_
	
	ComputeDeltaV()
	
	Mass_ = DryMass_ + FuelMass_
	
	ComputeInverseMass()
	
End Sub

Sub Rocket.ApplyThrust( ByVal _throttle As Single )
	
	''
	Dim As Single needed_fuel = Abs( _throttle ) * FuelFlowRate_ * DT
	
	Dim As Single burned_fuel = IIf( FuelMass_ < needed_fuel , FuelMass_ , needed_fuel )
	
	Dim As Single thrust_impulse = burned_fuel * ExhaustVelocity_ * InverseMass_
	
	SetFuelMass( FuelMass_ - burned_fuel )
	
	SetMass( DryMass_ + FuelMass_ )
	
	ComputeInverseMass()
	
	ComputeDeltaV()
	
	AddImpulse( thrust_impulse * AngleVector_ * Sgn( _throttle ) ) 
	
End Sub


'' Compute
Sub Rocket.ComputeDeltaV()
	
	'' The Tsiolkovsky rocket equation.
	''
	'' dv = ve * Ln( m0 / m1 )
	''
	'' This function computes the maximum possible delta v
	'' with regard to engine effective exhaust velocity,
	'' and the ships fuel mass and "dry" mass.
	
	DeltaV_ = ExhaustVelocity_ * Log( ( DryMass_ + FuelMass_ ) / DryMass_ )
	
End Sub

Sub Rocket.ComputeFuelMass()
	
	'' The "reverse" Tsiolkovsky rocket equation.
	''
	'' m0 - m1 = m1 * e^( dv / ve - 1 )
	''
	'' This function computes the fuel mass required to
	'' reach a given delta v, for a given ship "dry" 
	'' mass and engine effective exhaust velocity.
	
	FuelMass_ = DryMass_ * Exp( DeltaV_ / ExhaustVelocity_ - 1.0 )
	
End Sub


'' Get
Function Rocket.GetDeltaV() As Single
	
	Return DeltaV_
	
End Function

Function Rocket.GetDryMass() As Single
	
	Return DryMass_
	
End Function

Function Rocket.GetFuelMass() As Single
	
	Return FuelMass_
	
End Function

Function Rocket.GetExhaustVelocity() As Single
	
	Return ExhaustVelocity_
	
End Function

Function Rocket.GetFuelFlowRate() As Single
	
	Return FuelFlowRate_
	
End Function


'' Set
Sub Rocket.SetDeltaV( ByVal d As Single )
	
	DeltaV_ = d
	
End Sub

Sub Rocket.SetDryMass( ByVal d As Single )
	
	DryMass_ = d
	
End Sub

Sub Rocket.SetFuelMass( ByVal f As Single )
	
	FuelMass_ = f
	
End Sub

Sub Rocket.SetExhaustVelocity( ByVal e As Single )
	
	ExhaustVelocity_ = e
	
End Sub

Sub Rocket.SetFuelFlowRate( ByVal f As Single )
	
	FuelFlowRate_ = f
	
End Sub


'' Reset
Sub Rocket.ResetAll()
	
	Base.ResetAll()
	
	Grapple_       = 0
	
	DeltaV_          = 0.0
	DryMass_         = 0.0
	ExhaustVelocity_ = 0.0
	FuelFlowRate_    = 0.0
	FuelMass_        = 0.0
	
End Sub


#EndIf __GO_ROCKET_BI__
