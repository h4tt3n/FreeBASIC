''*******************************************************************************
''
''   Squishy2D Newtonian Gravitational Interaction Class
''   Written in FreeBASIC 1.05
''   Version 0.2.0, May 2016, Michael "h4tt3n" Nissen
''
''   Particle -> Rotate -> LineSegment -> NewtonGravity -> KeplerOrbit
''                                        
''
''*******************************************************************************


''
#Ifndef __S2_NEWTON_GRAVITY_BI__
#Define __S2_NEWTON_GRAVITY_BI__


''
Type NewtonGravity Extends LineSegment
	
	Public:
	
	'' Constructors
	Declare Constructor()
	
	Declare Constructor( ByRef N As NewtonGravity )
	
	Declare Constructor( ByVal A As Particle Ptr, _
	                     ByVal B As Particle Ptr )
	
	''	Operators
	Declare Operator Let( ByRef N As NewtonGravity )
	
	'' Apply
	Declare Sub ApplyImpulse()
	
	'' Compute
	Declare Sub ComputeGravParam()
	
	'' Get
	Declare Function Impulse   () As Vec2
	Declare Function GravParam () As Single
	
	''	Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	Protected:
	
	''	Variables
	As Vec2   Impulse_
	As Single GravParam_
	
End Type


'' Constructors
Constructor NewtonGravity()
	
	ResetAll()
	
End Constructor

Constructor NewtonGravity( ByRef N As NewtonGravity )
	
	ResetAll()
	
	This = N
	
End Constructor

Constructor NewtonGravity( ByVal A As Particle Ptr, _
	                        ByVal B As Particle Ptr )
	
	'Base( A, B )
	
	ResetAll()
	
	If ( A <> B ) Then
		
		ParticleA( A )
		ParticleB( B )
		
	Else
		
		ParticleA( 0 )
		ParticleB( 0 )
		
	End If
	
	ComputeMass()
	ComputeGravParam()
	
End Constructor


'' Operators
Operator NewtonGravity.Let( ByRef N As NewtonGravity )
	
	If ( @This <> @N ) Then
		
		Impulse_   = N.Impulse_
		GravParam_ = N.GravParam_
		
		Cast( LineSegment, This ) = N
		
	EndIf
	
End Operator


'' Compute
Sub NewtonGravity.ApplyImpulse()
	
	Impulse_ = G * ( ParticleA->Mass * ParticleB->Mass ) / ( Length_ * Length_ ) * DT * AngleVector_
	
	ParticleA->AddImpulse(  Impulse_ * ParticleA->InverseMass )
	ParticleB->AddImpulse( -Impulse_ * ParticleB->InverseMass )
	
End Sub

Sub NewtonGravity.ComputeGravParam()
	
	GravParam_ = G * Mass
	
End Sub


'' Get
Function NewtonGravity.Impulse() As Vec2
	
	Return Impulse_
	
End Function

Function NewtonGravity.GravParam() As Single
	
	Return GravParam_
	
End Function


''	Reset
Sub NewtonGravity.ResetAll()
	
	ResetVariables()
	
	Base.ResetAll()
	
End Sub

Sub NewtonGravity.ResetVariables()
	
	Impulse_   = Vec2( 0.0, 0.0 )
	GravParam_ = 0.0
	
	Base.ResetVariables()
	
End Sub


#EndIf ''__S2_NEWTON_GRAVITY_BI__
