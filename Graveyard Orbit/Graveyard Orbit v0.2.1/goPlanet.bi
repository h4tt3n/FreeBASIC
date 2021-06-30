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
''
''******************************************************************************


''
#Ifndef __GO_PLANET_BI__
#Define __GO_PLANET_BI__


''
Type Planet Extends AngularState
	
	Public:
	
	''
	Declare Constructor()
	
	Declare Constructor( ByRef P As Planet )
	
	Declare Constructor( ByVal _mass    As Single,_
	                     ByVal _radius  As Single = 0.0,_
	                     ByVal _density As Single = 0.0 )
	
	''
	Declare Destructor()
	
	''
	Declare Operator Let( ByRef P As Planet )
	
	'' Compute
	Declare Sub ComputeDensity()
	Declare Sub ComputeRadius()
	
	'' Get
	Declare Const Function GetColour() As UInteger
	Declare Const Function GetRadius() As Single
	Declare Const Function GetTag()    As String
	
	'' Set
	Declare Sub SetColour( ByVal C As UInteger )
	Declare Sub SetRadius( ByVal r As Single )
	Declare Sub SetTag   ( ByVal i As String )
	
	'' Reset
	Declare Virtual Sub ResetAll() Override
	
	Protected:
	
	As UInteger Colour_
	As String   Tag_
	As Single   Density_
	As Single   Radius_
	
End Type


''
Constructor Planet()
	
	ResetAll()
	
End Constructor

Constructor Planet( ByRef P As Planet )
	
	ResetAll()
	
	This = P
	
End Constructor

Constructor Planet( ByVal _mass    As Single,_
	                 ByVal _radius  As Single = 0.0,_
	                 ByVal _density As Single = 0.0 )
	
	ResetAll()
	
	Mass_    = _mass
	Radius_  = _radius
	Density_ = _density
	
	If ( _radius = 0.0 ) Then ComputeRadius()
	
	If ( _density = 0.0 ) Then ComputeDensity()

	ComputeInverseMass()
	
	RaiseFlag( IS_ALIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
End Constructor


''
Destructor Planet()
	
End Destructor


''
Operator Planet.Let( ByRef P As Planet )
	
	If ( Not @This = @P ) Then
		
		Cast( AngularState, This ) = P
		
		Colour_  = P.Colour_
		Tag_     = P.Tag_
		Density_ = p.Density_
		Radius_  = p.Radius_
		
	End If
	
End Operator


'' Compute
Sub Planet.ComputeDensity()
	
	Density_ = ( Radius_ * Radius_ * PI ) / Mass_
	
End Sub

Sub Planet.ComputeRadius()
	
	Radius_ = Sqr( ( Mass_ / Density_ ) / PI )
	
End Sub


'' Get
Function Planet.GetColour() As UInteger
	
	Return Colour_
	
End Function

Function Planet.GetRadius() As Single
	
	Return Radius_
	
End Function

Function Planet.GetTag() As String
	
	Return Tag_
	
End Function


'' Set
Sub Planet.SetColour( ByVal C As UInteger )
	
	Colour_ = C
	
End Sub

Sub Planet.SetRadius( ByVal r As Single )
	
	Radius_ = r
	
End Sub

Sub Planet.SetTag( ByVal i As String )
	
	Tag_ = i
	
End Sub


'' Reset
Sub Planet.ResetAll()
	
	Base.ResetAll()
	
	Colour_  = 0
	Tag_     = ""
	Density_ = 0.0
	Radius_  = 0.0
	
End Sub



#EndIf __GO_PLANET_BI__
