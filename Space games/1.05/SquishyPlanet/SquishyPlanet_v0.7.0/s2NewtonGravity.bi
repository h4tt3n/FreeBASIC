''*******************************************************************************
''
''   SquishyPlanet - A 2D soft body and space physics library for games
''   Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''   Version 0.7.0, December 2016
''
''   Author:
''   Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''   Description:
''   Newtonian inverse distance squared gravitational interaction.
''
''   LinearState -> AngularState -> LinearLink -> NewtonGravity
''
''*******************************************************************************


''
#Ifndef __S2_NEWTON_GRAVITY_BI__
#Define __S2_NEWTON_GRAVITY_BI__


''
Type NewtonGravity Extends LinearLink
	
	Public:
	
	'' Constructors
	Declare Constructor()
	
	Declare Constructor( ByRef N As NewtonGravity )
	
	Declare Constructor( ByVal A As LinearState Ptr, _
	                     ByVal B As LinearState Ptr )
	
	'' Destructor
	Declare Destructor()
	
	''	Operators
	Declare Operator Let( ByRef N As NewtonGravity )
	
	'' Apply
	Declare Sub ApplyImpulse()
	
	'' Get
	
	''	Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	Protected:
	
End Type


'' Constructors
Constructor NewtonGravity()
	
	ResetAll()
	
End Constructor

Constructor NewtonGravity( ByRef N As NewtonGravity )
	
	ResetAll()
	
	This = N
	
End Constructor

Constructor NewtonGravity( ByVal A As LinearState Ptr, _
	                        ByVal B As LinearState Ptr )
	
	'Base( A, B )
	
	ResetAll()
	
	If ( A <> B ) Then
		
		SetParticleA( A )
		SetParticleB( B )
		
	Else
		
		SetParticleA( 0 )
		SetParticleB( 0 )
		
	End If
	
	ComputeMass()
	ComputestateVectors()
	ComputeLengths()
	
	RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
End Constructor


'' Destructor
Destructor NewtonGravity()

End Destructor


'' Operators
Operator NewtonGravity.Let( ByRef N As NewtonGravity )
	
	If ( @This <> @N ) Then
		
		Impulse_ = N.Impulse_
		
		Cast( LinearLink, This ) = N
		
	EndIf
	
End Operator


'' Compute
Sub NewtonGravity.ApplyImpulse()
	
	Impulse_ = G * ( GetParticleA->GetMass * GetParticleB->GetMass ) / ( Length_ * Length_ ) * DT * AngleVector_
	
	GetParticleA->AddImpulse(  Impulse_ * GetParticleA->GetInverseMass )
	GetParticleB->AddImpulse( -Impulse_ * GetParticleB->GetInverseMass )
	
End Sub


'' Get


''	Reset
Sub NewtonGravity.ResetAll()
	
	ResetVariables()
	
	Base.ResetAll()
	
End Sub

Sub NewtonGravity.ResetVariables()
	
	Impulse_ = Vec2( 0.0, 0.0 )
	
	Base.ResetVariables()
	
End Sub


#EndIf ''__S2_NEWTON_GRAVITY_BI__
