''*********************************************************************************
''
''   Squishy2D Body Class
''   Written in FreeBASIC 1.05
''   version 0.2.0, May 2016, Michael "h4tt3n" Nissen
''
''   This is the inherited base type of all soft body types.
''   It holds a list of the particles assigned to it and
''   takes care of overall, body-level rotation and translation.
''
''   Particle -> Rotate -> Body
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
	Declare Sub ApplyImpulse ( ByVal i As Vec2, ByVal r As Vec2 )
	
	'' Add
	Declare Sub AddAngle           ( ByVal a As Single )
	Declare Sub AddAngleVector     ( ByVal a As Vec2 )
	Declare Sub AddAngularImpulse  ( ByVal a As Single )
	Declare Sub AddAngularVelocity ( ByVal a As Single )
	Declare Sub AddImpulse         ( ByVal i As Vec2 )
	Declare Sub AddVelocity        ( ByVal v As Vec2 )
	Declare Sub AddPosition        ( ByVal p As Vec2 )
	
	'' Add / Remove object
	Declare Virtual Function AddObject    ( ByVal p As Object Ptr ) As Boolean
	Declare Virtual Function RemoveObject ( ByVal p As Object Ptr ) As Boolean
	
	'' Compute
	Declare Sub ComputeAngularVelocity()
	Declare Sub ComputeInertia()
	Declare Sub ComputeInverseInertia()
	Declare Sub ComputeMass()
	Declare Sub ComputeInverseMass()
	Declare Sub ComputeStateVectors()
	
	'' Get
	'Declare Const Function Particles() As ParticlePtrArray Ptr
	Declare Const Function Position() As Vec2
	
	'' Reset
	Declare Sub ResetAll()
	Declare Sub ResetVariables()
	
	'' Set
	Declare Sub Position ( ByVal p As Vec2 )
	Declare Sub Velocity ( ByVal v As Vec2 )
	
	'Protected:
	
	As ParticlePtrArray Particles_
	
End Type


'' Constructors
Constructor Body()
	
	Base()
	
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
	
	If ( @This <> @b ) Then
		
		Angle_           = b.Angle_
		AngleVector_     = b.AngleVector_
		AngularImpulse_  = b.AngularImpulse_
		AngularVelocity_ = b.AngularVelocity_
		Inertia_         = b.Inertia_
		InverseInertia_  = b.InverseInertia_
		Particles_       = b.Particles_
		
		Cast( Rotate, This ) = b
		
	EndIf
		
End Operator


'' Add
Sub Body.AddAngle( ByVal a As Single )
	
	Dim As Vec2 delta_angle = AngleToUnit( a )
	
	Angle_ += a
	
	AngleVector_ = delta_angle.Rotate( AngleVector_ )
	
	For I as Particle Ptr Ptr = Particles_.p_front To Particles_.p_back
		
		Dim As Particle Ptr P = *I
		
		Dim As Vec2 LocalPosition = Position_ - P->Position
			
		Dim As Vec2 NewPosition = delta_angle.Rotate( LocalPosition )
			
		P->Position( Position_ - NewPosition )
		
	Next
	
End Sub

Sub Body.AddAngleVector( ByVal a As Vec2 )
	
	AngleVector_ = a.Rotate( AngleVector_ )
	
	Angle_ = UnitToAngle( AngleVector_ )
	
	For I as Particle Ptr Ptr = Particles_.p_front To Particles_.p_back
		
		Dim As Particle Ptr P = *I
		
		If Not P->GetFlag( IS_DYNAMIC ) Then
			
			Dim As Vec2 LocalPosition = Position_ - P->Position
			
			Dim As Vec2 NewPosition = a.Rotate( LocalPosition )
			
			P->Position( Position_ - NewPosition )
		
		EndIf
		
	Next
	
End Sub

Sub Body.AddAngularImpulse( ByVal a As Single )
	
	For I as Particle Ptr Ptr = Particles_.p_front To Particles_.p_back
		
		Dim As Particle Ptr P = *I
		
		Dim As Vec2 LocalPosition = Position_ - P->Position
		
		Dim As Vec2 LocalImpulse = LocalPosition.PerpDot( a )
		
		P->AddImpulse( LocalImpulse )
		
	Next
	
End Sub

Sub Body.AddAngularVelocity ( ByVal a As Single )
	
	For I as Particle Ptr Ptr = Particles_.p_front To Particles_.p_back
		
		Dim As Particle Ptr P = *I
		
		Dim As Vec2 LocalPosition = Position_ - P->Position
		
		Dim As Vec2 LocalVelocity = LocalPosition.PerpDot( a )
		
		P->AddVelocity( LocalVelocity )
		
	Next
	
End Sub

Sub Body.AddImpulse( ByVal impulse As Vec2 )
	
	For I as Particle Ptr Ptr = Particles_.p_front To Particles_.p_back
		
		Dim As Particle Ptr PP = *I
		
		PP->AddImpulse( impulse )
		
	Next
	
End Sub

Sub Body.AddPosition( ByVal p As Vec2 )
	
	For I as Particle Ptr Ptr = Particles_.p_front To Particles_.p_back
		
		Dim As Particle Ptr PP = *I
		
		PP->AddPosition( p )
		
	Next
	
	computeStateVectors()
	
End Sub

Sub Body.AddVelocity( ByVal v As Vec2 )
	
	For I as Particle Ptr Ptr = Particles_.p_front To Particles_.p_back
		
		Dim As Particle Ptr PP = *I
		
		PP->AddVelocity( v )
		
	Next
	
	computeStateVectors()
	
End Sub


'' Add / Remove
Function Body.AddObject( ByVal o As Object Ptr ) As Boolean
	
	'If ( *o Is Particle ) Then 
		
		Dim As Particle Ptr P = Cast( Particle Ptr, o )
		
		Dim As Particle Ptr PP = Particles_.push_back( P )
		
		ComputeMass()
		ComputeStateVectors()
		ComputeInertia()
		ComputeAngularVelocity()
		
		'PP->LowerFlag( IS_DYNAMIC )
		
		Return TRUE
		
	'EndIf
	
	'Return FALSE
	
End Function

Function Body.RemoveObject( ByVal o As Object Ptr ) As Boolean
	
	'If ( *o Is Particle ) Then 
		
		Dim As Particle Ptr P = Cast( Particle Ptr, o )
		
		Particles_.Remove( P ) 
		
		ComputeMass()
		ComputeStateVectors()
		ComputeInertia()
		ComputeAngularVelocity()
		
		'P->RaiseFlag( IS_DYNAMIC )
		
		Return TRUE
		
	'EndIf
	
	'Return FALSE
	
End Function


'' Apply
Sub Body.ApplyImpulse( ByVal i As Vec2, ByVal r As Vec2 )
	
	AddImpulse( i * InverseMass )
	
	Dim As Single LocalAngularImpulse = r.PerpDot( i )
	
	AddAngularImpulse( LocalAngularImpulse * InverseInertia )
	
End Sub


''	Compute
Sub Body.computeAngularVelocity()
	
	'' This function computes the global soft body angular velocity.
	'' The angular momentum of each particle is summed up and
	'' divided by the global moment of inertia.
	
	AngularVelocity_ = 0.0
	
	For I as Particle Ptr Ptr = Particles_.p_front To Particles_.p_back
		
		Dim As Particle Ptr P = *I
		
		Dim As Vec2 LocalPosition = Position_ - P->Position
		Dim As Vec2 LocalVelocity = Velocity_ - P->Velocity
		
		AngularVelocity_ += LocalPosition.PerpDot( LocalVelocity * P->Mass )
		
	Next
	
	AngularVelocity_ *= InverseInertia_
	
End Sub

Sub Body.computeInertia()
	
	'' This function computes the global soft body moment of inertia,
	'' which is the rotational equivalent to inertial mass.
	
	Inertia_ = 0.0
	
	For I as Particle Ptr Ptr = Particles_.p_front To Particles_.p_back
		
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
	
	For I as Particle Ptr Ptr = Particles_.p_front To Particles_.p_back
		
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
	
	For I as Particle Ptr Ptr = Particles_.p_front To Particles_.p_back
		
		Dim As Particle Ptr P = *I
		
		Position_ += P->Position * P->Mass
		Velocity_ += P->Velocity * P->Mass
		
	Next
	
	Position_ *= InverseMass_
	Velocity_ *= InverseMass_
	
End Sub


'' Get
'Function Body.Particles() As ParticlePtrArray Ptr
	
	'' won't compile / causes crash!
	
'	Dim As ParticlePtrArray Ptr P = ( This.Particles_ )
	
'	Return P
	
'End Function

Function Body.Position() As Vec2
	
	Return Position_
	
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


'' Set
Sub Body.Position( ByVal p As Vec2 )
	
	For I as Particle Ptr Ptr = Particles_.p_front To Particles_.p_back
		
		Dim As Particle Ptr PP = *I
		
		PP->AddPosition( p - Position_ )
		
	Next
	
	computeStateVectors()
	
End Sub

Sub Body.Velocity( ByVal v As Vec2 )
	
	For I as Particle Ptr Ptr = Particles_.p_front To Particles_.p_back
		
		Dim As Particle Ptr PP = *I
		
		PP->AddVelocity( v - Velocity_ )
		
	Next
	
	computeStateVectors()
	
End Sub



#EndIf ''__S2_BODY_BI__
