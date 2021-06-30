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
''  This file contains all types of celestial bodies, including stars, 
''  Roxels, moons, asteroids, comets etc.
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
	
	'' Compute
	Declare Sub ComputeDensity()
	Declare Sub ComputeRadius()
	
	'' Get
	Declare Const Function GetBackGroundColour() As UInteger
	Declare Const Function GetForeGroundColour() As UInteger
	Declare Const Function GetDensity() As Single
	Declare Const Function GetRadius() As Single
	Declare Const Function GetTag() As String
	
	'' Set
	Declare Sub SetBackGroundColour( ByVal C As UInteger )
	Declare Sub SetForeGroundColour( ByVal C As UInteger )
	Declare Sub SetRadius( ByVal r As Single )
	Declare Sub SetDensity( ByVal r As Single )
	Declare Sub SetTag( ByVal i As String )
	
	'' Reset
	Declare Sub ResetAll()
	
	Protected:
	
	''
	As String Tag_
	
	''
	As UInteger BackGroundColour_
	As UInteger ForeGroundColour_
	
	''
	As Single Density_
	As Single Radius_
	
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
	Mass_             = _mass
	Radius_           = _radius
	BackGroundColour_ = _background_colour
	ForeGroundColour_ = _foreground_colour
	
	''
	ComputeDensity()
	ComputeInverseMass()
	
	''
	RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
End Constructor


''
Destructor Roxel()
	
End Destructor


''
Operator Roxel.Let( ByRef R As Roxel )
	
	If ( Not @This = @R ) Then
		
		Cast( LinearState, This ) = R
		
		BackGroundColour_ = R.BackGroundColour_
		ForeGroundColour_ = R.ForeGroundColour_
		Tag_              = R.Tag_
		Density_          = R.Density_
		Radius_           = R.Radius_
		
	End If
	
End Operator


'' Compute
Sub Roxel.ComputeDensity()
	
	Density_ = ( Radius_ * Radius_ * PI ) / Mass_
	
End Sub

Sub Roxel.ComputeRadius()
	
	Radius_ = Sqr( ( Mass_ / Density_ ) / PI )
	
End Sub

'' Get
Function Roxel.GetBackGroundColour() As UInteger
	
	Return BackGroundColour_
	
End Function

Function Roxel.GetForeGroundColour() As UInteger
	
	Return ForeGroundColour_
	
End Function

Function Roxel.GetDensity() As Single
	
	Return Density_
	
End Function

Function Roxel.GetRadius() As Single
	
	Return Radius_
	
End Function

Function Roxel.GetTag() As String
	
	Return Tag_
	
End Function


'' Set
Sub Roxel.SetBackGroundColour( ByVal C As UInteger )
	
	BackGroundColour_ = C
	
End Sub

Sub Roxel.SetForeGroundColour( ByVal C As UInteger )
	
	ForeGroundColour_ = C
	
End Sub

Sub Roxel.SetDensity( ByVal d As Single )
	
	Density_ = d
	
End Sub

Sub Roxel.SetRadius( ByVal r As Single )
	
	Radius_ = r
	
End Sub

Sub Roxel.SetTag( ByVal i As String )
	
	Tag_ = i
	
End Sub


'' Reset
Sub Roxel.ResetAll()
	
	''
	Base.ResetAll()

	''
	BackGroundColour_ = 0
	ForeGroundColour_ = 0
	
	''
	Tag_ = ""
	
	''
	Density_ = 0.0
	Radius_  = 0.0
	
End Sub


#EndIf __GO_ROXEL_BI__
