''******************************************************************************
''    
''  Graveyard Orbit - A 2D space physics puzzle game
''
''  Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''  Version 0.1.0, October 31. 2016
''  
''  Author:
''  Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''    
''  Description:
''  
''
''******************************************************************************


''
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
	
	''
	Declare Sub Render()
	
	'' Apply
	Declare Sub ApplyDeltaV        ( ByVal _delta_v   As Single )
	Declare Sub ApplyFuelMass      ( ByVal _fuel_mass As Single )
	'Declare Sub ApplyThrustForce   ( ByVal _throttle  As Single )
	Declare Sub ApplyThrustImpulse ( ByVal _throttle  As Single )
	
	'' Compute
	Declare Sub ComputeDeltaV()
	Declare Sub ComputeFuelMass()
	
	'' Get
	Declare Const Function DeltaV()          As Single
	Declare Const Function DryMass()         As Single
	Declare Const Function FuelMass()        As Single
	Declare Const Function ExhaustVelocity() As Single
	Declare Const Function FuelFlowRate()    As Single
	'Declare Const Function Tag()              As String
	
	'' Set
	Declare Sub DeltaV          ( ByVal d As Single )
	Declare Sub DryMass         ( ByVal d As Single )
	Declare Sub FuelMass        ( ByVal f As Single )
	Declare Sub ExhaustVelocity ( ByVal e As Single )
	Declare Sub FuelFlowRate    ( ByVal f As Single )
	'Declare Sub Tag              ( ByVal i As String )
	
	'' Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	Protected:
	
	As Single DeltaV_            '' (m/s)
	As Single FuelMass_          '' (kg)
	As Single DryMass_           '' (kg)
	As Single ExhaustVelocity_   '' (m/s)
	As Single FuelFlowRate_      '' (dm/dt) 
	
	As Boolean GRAPPLE_STATE     ''
	
	As String Tag_
	
	'As PtrContainer Engines_
	
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
	
	RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
End Constructor


''
Destructor Rocket()
	
	'Engines_.Clear()
	
End Destructor


''
Operator Rocket.Let( ByRef R As Rocket )
	
	If ( @This <> @R ) Then
		
		DeltaV_          = R.DeltaV_
		FuelMass_        = R.FuelMass_
		DryMass_         = R.DryMass_
		ExhaustVelocity_ = R.ExhaustVelocity_
		FuelFlowRate_    = R.FuelFlowRate_
		'Tag_              = R.Tag_
		
		Cast( AngularState, This ) = R
		
	End If
	
End Operator


''
Sub Rocket.Render()
	

	
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

'Sub Rocket.ApplyThrustForce( ByVal _throttle As Single )
'	
'	''
'	Dim As Single needed_fuel = Abs( _throttle ) * FuelFlowRate_ * DT
'	
'	Dim As Single burned_fuel = IIf( FuelMass_ < needed_fuel , FuelMass_ , needed_fuel )
'	
'	Dim As Single thrust_force = burned_fuel * ExhaustVelocity_ * INV_DT
'	
'	AddForce( thrust_force * AngleVector * Sgn( _throttle ) ) 
'	
'	FuelMass( FuelMass_ - burned_fuel )
'	
'	Mass( DryMass_ + FuelMass_ )
'	
'	ComputeInverseMass()
'	
'	'ComputeDeltaV()
'	
'End Sub

Sub Rocket.ApplyThrustImpulse( ByVal _throttle As Single )
	
	''
	Dim As Single needed_fuel = Abs( _throttle ) * FuelFlowRate_ * DT
	
	Dim As Single burned_fuel = IIf( FuelMass_ < needed_fuel , FuelMass_ , needed_fuel )
	
	Dim As Single thrust_impulse = burned_fuel * ExhaustVelocity_ * InverseMass_
	
	AddImpulse( thrust_impulse * AngleVector_ * Sgn( _throttle ) ) 
	
	FuelMass( FuelMass_ - burned_fuel )
	
	Mass_ = DryMass_ + FuelMass_
	
	ComputeInverseMass()
	
	'ComputeDeltaV()
	
End Sub


'' Compute
Sub Rocket.ComputeDeltaV()
	
	'' The Tsiolkovsky rocket equation.
	''
	'' dv = ve * Ln( m0 / m1 )
	''
	'' This function computes the maximum possible delta v
	'' with regard to engine effective exhaust velocity,
	'' and the ships initial mass and "dry" mass.
	
	DeltaV_ = ExhaustVelocity_ * Log( ( FuelMass_ + DryMass_ ) / DryMass_ )
	
End Sub

Sub Rocket.ComputeFuelMass()
	
	'' The "inverse" Tsiolkovsky rocket equation.
	''
	'' m0 - m1 = m1 * e^( dv / ve - 1 )
	''
	'' This function computes the minimum fuel mass required
	'' to reach the given delta v, with regard to ship "dry" 
	'' mass and engine effective exhaust velocity.
	
	
	FuelMass_ = DryMass_ * ( Exp( DeltaV_ / ExhaustVelocity_ ) - 1.0 )
	
End Sub


'' Get
Function Rocket.DeltaV() As Single
	
	Return DeltaV_
	
End Function

Function Rocket.DryMass() As Single
	
	Return DryMass_
	
End Function

Function Rocket.FuelMass() As Single
	
	Return FuelMass_
	
End Function

Function Rocket.ExhaustVelocity() As Single
	
	Return ExhaustVelocity_
	
End Function

Function Rocket.FuelFlowRate() As Single
	
	Return FuelFlowRate_
	
End Function

'Function Rocket.Tag() As String
'	
'	Return Tag_
'	
'End Function


'' Set
Sub Rocket.DeltaV( ByVal d As Single )
	
	DeltaV_ = d
	
End Sub

Sub Rocket.DryMass( ByVal d As Single )
	
	DryMass_ = d
	
End Sub

Sub Rocket.FuelMass( ByVal f As Single )
	
	FuelMass_ = f
	
End Sub

Sub Rocket.ExhaustVelocity( ByVal e As Single )
	
	ExhaustVelocity_ = e
	
End Sub

Sub Rocket.FuelFlowRate( ByVal f As Single )
	
	FuelFlowRate_ = f
	
End Sub

'Sub Rocket.Tag( ByVal i As String )
'	
'	Tag_ = i
'	
'End Sub


'' Reset
Sub Rocket.ResetAll()
	
	ResetVariables()
	
	Base.ResetAll()
	
End Sub

Sub Rocket.ResetVariables()
	
	DeltaV_          = 0.0
	DryMass_         = 0.0
	FuelMass_        = 0.0
	ExhaustVelocity_ = 0.0
	FuelFlowRate_    = 0.0
	'Tag_              = ""
	
	Base.ResetVariables()
	
End Sub


#EndIf __GO_ROCKET_BI__
