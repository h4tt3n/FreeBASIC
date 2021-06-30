''*********************************************************************************
''
''   Squishy2D Body Class
''   Written in FreeBASIC 1.04
''   version 0.1.0, November 2015, Michael "h4tt3n" Nissen
''
''   This is the inherited base type of all soft body types.
''   It holds a list of the particles assigned to it and
''   takes care of overall, body-level rotation and translation.
''
''
''*********************************************************************************


''
#Ifndef __S2_BODY_BI__
#Define __S2_BODY_BI__


''
Type Body Extends Rotate
	
	Public:
	
	'' Constructors
	Declare Constructor()
	Declare Constructor( ByRef b As Body )
	
	'' Destructor
	Declare Destructor()
	 
	'' Operators
	Declare Operator Let( ByRef b As Body )
	
	'' Apply
	Declare Sub ApplyImpulse ( ByVal r As Vec2, ByVal i As Vec2 )
	Declare Sub ApplyImpulseConcentration ( ByVal c As Single )
	Declare Sub ApplyImpulseDispersion()
	
	'' Compute
	Declare Sub ComputeAngularVelocity()
	Declare Sub ComputeInertia()
	Declare Sub ComputeInverseInertia()
	Declare Sub ComputeMass()
	Declare Sub ComputeInverseMass()
	Declare Sub ComputeStateVectors()
	
	'' Get
	Declare Const Function Particles () As ParticlePtrArray
	
	'' Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	'Protected:
	
	''	Array of Particle pointers
	As ParticlePtrArray Particles_
	
End Type


'' Constructors
Constructor Body()
	
	ResetAll()
	
End Constructor
	
Constructor Body( ByRef b As Body )
	
	ResetAll()
	
	This = b
	
End Constructor


'' Destructor
Destructor Body()
	
	ResetAll()
	
End Destructor


'' Operators
Operator Body.Let( ByRef b As Body )
	
	ResetAll()
	
	Angle_           = b.Angle_
	AngleVector_     = b.AngleVector_
	AngularImpulse_  = b.AngularImpulse_
	AngularVelocity_ = b.AngularVelocity_
	Inertia_         = b.Inertia_
	InverseInertia_  = b.InverseInertia_
	Particles_       = b.Particles_
	
	Cast( Rotate, This ) = b
		
End Operator


'' Apply
Sub Body.ApplyImpulse( ByVal r As Vec2, ByVal i As Vec2 )
	
	''
	
	Impulse_ += i
	
	Dim As Vec2 LocalPosition = Position_ - r
	
	AngularImpulse_ -= LocalPosition.PerpDot( r )
	
End Sub

Sub Body.ApplyImpulseConcentration( ByVal c As Single )
	
	'' This function sums up all the local particle impulses and 
	'' applies them as one global linear and angular impulse to the 
	'' soft body. It does the opposite of ApplyImpulseDispersion.
	'' Conserves energy and momentum. Computation is CPU cheap.
	
	For I as Particle Ptr Ptr = Particles_.Front To Particles_.Back
		
		Dim As Particle Ptr P = *I
		
		''  Compute global force from local forces
		Dim As Vec2 LocalImpulse = P->Impulse * P->Mass * c
		
		Impulse_ += LocalImpulse * InverseMass_ '* c
		
		''  Compute global torque from local forces
		Dim As Vec2 LocalPosition = Position_ - P->Position
		
		Dim As Single LocalAngularImpulse = LocalPosition.PerpDot( LocalImpulse ) 
		
		AngularImpulse_ -= LocalAngularImpulse * InverseInertia_'* c
		
		'' reset local
		P->Impulse( P->Impulse * ( 1.0 - c ) )
		
	Next
	
End Sub

Sub Body.ApplyImpulseDispersion()
	
	''	This function splits up the global soft body linear and 
	'' angular impulse and applies it to all the local particles.
	'' It does the opposite of ApplyImpulseConcentration.
	'' Conserves energy and momentum. Computation is CPU cheap.
	
	For I as Particle Ptr Ptr = Particles_.Front To Particles_.Back
		
		Dim As Particle Ptr P = *I
		
		''  Compute local impulse from global linear impulse
		P->addImpulse( Impulse_ ) 
		
		''  Compute local impulse from global angular impulse
		Dim As Vec2 LocalPosition = Position_ - P->Position
		
		Dim As Vec2 LocalImpulse = LocalPosition.PerpDot( AngularImpulse_ )
		
		P->addImpulse( LocalImpulse )
		
	Next
	
	'' Reset global
	AngularImpulse_ = 0.0 
	Impulse_        = Vec2( 0.0, 0.0 )
	
End Sub


''	Compute
Sub Body.computeAngularVelocity()
	
	'' This function computes the global soft body angular velocity.
	'' The angular momentum of each particle is summed up and
	'' divided by the global moment of inertia.
	
	AngularVelocity_ = 0.0
	
	For I as Particle Ptr Ptr = Particles_.Front To Particles_.Back
		
		Dim As Particle Ptr P = *I
		
		Dim As Vec2 LocalPosition = Position_ - P->Position
		Dim As Vec2 LocalVelocity = Velocity_ - P->Velocity
		
		AngularVelocity_ += LocalPosition.PerpDot( LocalVelocity * P->Mass )
		
	Next
	
	AngularVelocity_ *= InverseInertia_
	
End Sub

Sub Body.computeInertia()
	
	Inertia_ = 0.0
	
	For I as Particle Ptr Ptr = Particles_.Front To Particles_.Back
		
		Dim As Particle Ptr P = *I
		
		Dim As Vec2 LocalPosition = Position_ - P->Position
		
		Inertia_ += LocalPosition.LengthSquared() * P->Mass
		
	Next
	
	ComputeInverseInertia()
	
End Sub

Sub Body.computeInverseInertia()
	
	InverseInertia_ = IIf ( Inertia_ > 0.0 , 1.0 / Inertia_ , 0.0 )
	
End Sub

Sub Body.computeMass()
	
	Mass_ = 0.0
	
	For I as Particle Ptr Ptr = Particles_.Front To Particles_.Back
		
		Dim As Particle Ptr P = *I
		
		Mass_ += P->Mass
		
	Next
	
	ComputeInverseMass()
	
End Sub

Sub Body.computeInverseMass()
	
	InverseMass_ = IIf( Mass_ > 0.0 , 1.0 / Mass_ , 0.0 )
	
End Sub

Sub Body.computeStateVectors()
	
	Position_ = Vec2( 0.0, 0.0 )
	Velocity_ = Vec2( 0.0, 0.0 )
	
	For I as Particle Ptr Ptr = Particles_.Front To Particles_.Back
		
		Dim As Particle Ptr P = *I
		
		Position_ += P->Position * P->Mass
		Velocity_ += P->Velocity * P->Mass
		
	Next
	
	Position_ *= InverseMass_
	Velocity_ *= InverseMass_
	
End Sub


'' Get
Function Body.Particles () As ParticlePtrArray
	
	Return Particles_
	
End Function


'' Reset
Sub Body.ResetAll()
	
	ResetVariables()
	
	Particles_.Clear()
	
	Base.ResetAll()
	
End Sub

Sub Body.ResetVariables()
	
	Base.ResetAll()
	
End Sub


#EndIf ''__S2_BODY_BI__
