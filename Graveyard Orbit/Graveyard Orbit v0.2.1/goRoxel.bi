''******************************************************************************
''    
''  Graveyard Orbit - A 2D space physics puzzle game
''
''  Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''  Version 0.2.1, June 2018
''  
''  Author:
''  Michael "h4tt3n" Schmidt Nissen, michaelschmidtnissen@gmail.com
''    
''  Description:
''  The name "Roxel" is a portmanteau of "Rock" and "Pixel", and it is the basic
''  building block in the world of Graveyard Orbit. In addition to the properties
''  inherited from LinearState, it is able to carry information about density, 
''  radius, area (2D volume), pressure, temperature, material type, and colour.
''
''  LinearState -> Roxel
''
''******************************************************************************


''
#Ifndef __GO_ROXEL_BI__
#Define __GO_ROXEL_BI__


''
Type Roxel Extends LinearState
	
	Public:
	
	''
	Declare Constructor()
	
	Declare Constructor( ByRef R As Roxel )
	
	Declare Constructor( ByVal _mass              As Single, _
	                     ByVal _radius            As Single, _
	                     ByVal _background_colour As UInteger, _
	                     ByVal _foreground_colour As UInteger )
	
	''
	Declare Destructor()
	
	''
	Declare Operator Let( ByRef R As Roxel )
	
	'' Add
	
	'' Compute
	Declare Sub ComputeDensity()
	Declare Sub ComputeRadius()
	
	'' Get
	Declare Const Function GetBackGroundColour() As UInteger
	Declare Const Function GetForeGroundColour() As UInteger
	Declare Const Function GetDensity() As Single
	Declare Const Function GetPressure() As Single
	Declare Const Function GetRadius() As Single
	Declare Const Function GetTemperature() As Single
	
	'' Set
	Declare Sub SetBackGroundColour ( ByVal C As UInteger )
	Declare Sub SetForeGroundColour ( ByVal C As UInteger )
	Declare Sub SetDensity          ( ByVal t As Single )
	Declare Sub SetPressure         ( ByVal p As Single )
	Declare Sub SetRadius           ( ByVal r As Single )
	Declare Sub SetTemperature      ( ByVal t As Single )
	
	'' Reset
	Declare Virtual Sub ResetAll() Override 
	
	Protected:
	
	''
	As UInteger EdgeColor_
	As UInteger CoreColor_
	As UInteger BodyColor_
	
	''
	As Single Density_     '' Kg / m^3
	As Single Pressure_    '' Pascal, Pa
	As Single Radius_      '' m^2
	As Single Temperature_ '' Kelvin, K
	
End Type


''
Constructor Roxel()
	
	ResetAll()
	
End Constructor

Constructor Roxel( ByRef R As Roxel )
	
	ResetAll()
	
	This = R
	
End Constructor

Constructor Roxel( ByVal _mass              As Single, _
	                ByVal _radius            As Single, _
	                ByVal _background_colour As UInteger, _
	                ByVal _foreground_colour As UInteger )
	
	''
	ResetAll()
	
	''
	Mass_      = _mass
	Radius_    = _radius
	EdgeColor_ = _background_colour
	CoreColor_ = _foreground_colour
	
	''
	ComputeDensity()
	ComputeInverseMass()
	
	''
	RaiseFlag( IS_ALIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
End Constructor


''
Destructor Roxel()
	
End Destructor


''
Operator Roxel.Let( ByRef R As Roxel )
	
	If ( Not @This = @R ) Then
		
		Cast( LinearState, This ) = R
		
		EdgeColor_ = R.EdgeColor_
		CoreColor_ = R.CoreColor_
		Density_          = R.Density_
		Pressure_         = R.Pressure_
		Radius_           = R.Radius_
		Temperature_      = R.Temperature_
		
	End If
	
End Operator


'' Compute
Sub Roxel.ComputeDensity()
	
	'' 
	
	Density_ = ( Radius_ * Radius_ * PI ) / Mass_
	
End Sub

Sub Roxel.ComputeRadius()
	
	''
	
	Radius_ = Sqr( ( Mass_ / Density_ ) / PI )
	
End Sub


'' Get
Function Roxel.GetBackGroundColour() As UInteger
	
	Return EdgeColor_
	
End Function

Function Roxel.GetForeGroundColour() As UInteger
	
	Return CoreColor_
	
End Function

Function Roxel.GetDensity() As Single
	
	Return Density_
	
End Function

Function Roxel.GetPressure() As Single
	
	Return Pressure_
	
End Function


Function Roxel.GetRadius() As Single
	
	Return Radius_
	
End Function

Function Roxel.GetTemperature() As Single
	
	Return Temperature_
	
End Function


'' Set
Sub Roxel.SetBackGroundColour( ByVal C As UInteger )
	
	EdgeColor_ = C
	
End Sub

Sub Roxel.SetForeGroundColour( ByVal C As UInteger )
	
	CoreColor_ = C
	
End Sub

Sub Roxel.SetDensity( ByVal d As Single )
	
	Density_ = d
	
End Sub

Sub Roxel.SetPressure( ByVal p As Single )
	
	Pressure_ = p
	
End Sub

Sub Roxel.SetRadius( ByVal r As Single )
	
	Radius_ = r
	
End Sub

Sub Roxel.SetTemperature( ByVal t As Single )
	
	Temperature_ = t
	
End Sub


'' Reset
Sub Roxel.ResetAll()
	
	''
	Base.ResetAll()

	''
	EdgeColor_ = 0
	CoreColor_ = 0
	
	''
	Density_     = 0.0
	Pressure_    = 0.0
	Radius_      = 0.0
	Temperature_ = 0.0
	
End Sub


#EndIf __GO_ROXEL_BI__
