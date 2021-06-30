''*******************************************************************************
''
''   Squishy2D Newtonian Gravitational Interaction Class
''   Written in FreeBASIC 1.05
''   Version 0.2.0, May 2016, Michael "h4tt3n" Nissen
''
''   Particle -> Rotate -> LineSegment -> NewtonGravity
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
	
	'' Get
	Declare Const Function Impulse() As Vec2
	
	''	Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	Protected:
	
	''	Variables
	'As Vec2 Force_
	As Vec2 Impulse_
	
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
	ComputeStateVectors()
	ComputeLengths()
	
	RaiseFlag( IS_ACTIVE Or IS_DYNAMIC Or IS_VISIBLE )
	
End Constructor


'' Operators
Operator NewtonGravity.Let( ByRef N As NewtonGravity )
	
	If ( @This <> @N ) Then
		
		Impulse_ = N.Impulse_
		
		Cast( LineSegment, This ) = N
		
	EndIf
	
End Operator


'' Compute
Sub NewtonGravity.ApplyImpulse()
	
	Impulse_ = G * ( ParticleA->Mass * ParticleB->Mass ) / ( Length_ * Length_ ) * DT * AngleVector_
	
	ParticleA->AddImpulse(  Impulse_ * ParticleA->InverseMass )
	ParticleB->AddImpulse( -Impulse_ * ParticleB->InverseMass )
	
End Sub


'' Get
Function NewtonGravity.Impulse() As Vec2
	
	Return Impulse_
	
End Function


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
