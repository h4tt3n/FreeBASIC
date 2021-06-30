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
	
	Declare Constructor( ByVal _mass     As Single, _
	                     ByVal _density  As Single )
	
	''
	Declare Destructor()
	
	''
	Declare Operator Let( ByRef R As Roxel )
	
	'' Compute
	
	'' Get
	Declare Const Function GetColour() As UInteger
	Declare Const Function GetRadius() As Single
	Declare Const Function GetTag()    As String
	
	'' Set
	Declare Sub SetColour( ByVal C As UInteger )
	Declare Sub SetRadius( ByVal r As Single )
	Declare Sub SetTag    ( ByVal i As String )
	
	'' Reset
	Declare Sub ResetAll()
	
	Protected:
	
	As UInteger Colour_
	As String   Tag_
	As Single   Density_
	As Single   Radius_
	
End Type


''
Constructor Roxel()
	
	ResetAll()
	
End Constructor

Constructor Roxel( ByRef R As Roxel )
	
	ResetAll()
	
	This = R
	
End Constructor

Constructor Roxel( ByVal _mass    As Single, _
                   ByVal _density As Single )
	
	ResetAll()
	
	Mass_    = _mass
	Density_ = _density
	Radius_  = Sqr( ( Mass_ / Density_ ) / PI )
	
	ComputeInverseMass()
	
	RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
End Constructor


''
Destructor Roxel()
	
End Destructor


''
Operator Roxel.Let( ByRef R As Roxel )
	
	If ( @This <> @R ) Then
		
		Cast( LinearState, This ) = R
		
		Colour_  = R.Colour_
		Tag_     = R.Tag_
		Density_ = R.Density_
		Radius_  = R.Radius_
		
	End If
	
End Operator


'' Compute


'' Get
Function Roxel.GetColour() As UInteger
	
	Return Colour_
	
End Function

Function Roxel.GetRadius() As Single
	
	Return Radius_
	
End Function

Function Roxel.GetTag() As String
	
	Return Tag_
	
End Function


'' Set
Sub Roxel.SetColour( ByVal C As UInteger )
	
	Colour_ = C
	
End Sub

Sub Roxel.SetRadius( ByVal r As Single )
	
	Radius_ = r
	
End Sub

Sub Roxel.SetTag( ByVal i As String )
	
	Tag_ = i
	
End Sub


'' Reset
Sub Roxel.ResetAll()
	
	Base.ResetAll()
	
	Colour_  = 0
	Tag_     = ""
	Density_ = 0.0
	Radius_  = 0.0
	
End Sub



#EndIf __GO_ROXEL_BI__
