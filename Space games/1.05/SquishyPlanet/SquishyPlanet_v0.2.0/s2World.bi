''******************************************************************************
''    
''   Squishy2D World Class
''   Written in FreeBASIC 1.04
''   version 0.1.0, November 2015, Michael "h4tt3n" Nissen
''
''****************************************************************************** 


''
#Ifndef __S2_WORLD_BI__
#Define __S2_WORLD_BI__


''
Type World
	
	Public:
	
	'' Constructors
	Declare Constructor()
	Declare Constructor( ByRef w As World )
	
	'' Destructor
	Declare Destructor()
	
	'' Operators
	Declare Operator Let( ByRef w As World )
	
	'' Apply
	Declare Sub ApplyImpulses()
	Declare Sub ApplyWarmStart()
	
	'' Create
	
	''
	Declare Sub ComputeData()
	Declare Sub Solve()
	
	'Private:
	
	'' Variables
	
	'' Object arrays ( All physical objects are stored here )
	As AngularSpringArray  AngularSprings_
	As AnguliteSpringArray AnguliteSprings_
	As RotateArray         Rotates_
	As FixedSpringArray    FixedSprings_
	As LineSegmentArray    LineSegments_
	As LinearSpringArray   LinearSprings_
	As ParticleArray       Particles_
	As BodyArray           Bodys_
	As SpringBodyArray     SpringBodys_
	As PressureBodyArray   PressureBodys_
	
End Type


''
Constructor World()
	
	'AngularSprings_.Reserve ( MAX_ANGULAR_SPRINGS )
	'Rotates_.Reserve        ( MAX_ROTATES )
	'FixedSprings_.Reserve   ( MAX_FIXED_SPRINGS )
	'LineSegments_.Reserve   ( MAX_LINE_SEGMENTS )
	'LinearSprings_.Reserve  ( MAX_LINEAR_SPRINGS )
	'Particles_.Reserve      ( MAX_PARTICLES )
	'Bodys_.Reserve          ( MAX_BODYS )
	
End Constructor

Constructor World( ByRef w As World )
	
	This = w
	
End Constructor


''
Destructor World()
	
	AngularSprings_.Clear()
	AnguliteSprings_.Clear()
	Rotates_.Clear()
	FixedSprings_.Clear()
	LineSegments_.Clear()
	LinearSprings_.Clear()
	Particles_.Clear()
	Bodys_.Clear()
	SpringBodys_.Clear()
	PressureBodys_.Clear()
	
End Destructor


''
Operator World.Let( ByRef w As World )
	
	AngularSprings_  = w.AngularSprings_
	AnguliteSprings_ = w.AnguliteSprings_
	Rotates_         = w.Rotates_
	FixedSprings_    = w.FixedSprings_
	LineSegments_    = w.LineSegments_
	LinearSprings_   = w.LinearSprings_
	Particles_       = w.Particles_
	Bodys_           = w.Bodys_
	SpringBodys_     = w.SpringBodys_
	PressureBodys_   = w.PressureBodys_
	
End Operator


'' Apply
Sub World.ApplyImpulses()
	
	''	split up into internal and external impulses. 
	'' (1) external (2) concentrate (3) internal (4) disperse 
	
	For I As Integer = 1 To NUM_ITERATIONS
		
		''
		'For F As FixedSpring Ptr = FixedSprings_.Front To FixedSprings_.Back
		'
		'	F->applyCorrectiveImpulse()
		'	 
		'Next
		
		'If ( LinearSprings_.size > 0 ) Then 
			
		For L As LinearSpring Ptr = LinearSprings_.Front To LinearSprings_.Back
			
			L->applyCorrectiveImpulse()
			
		Next
		
		For I as AnguliteSpring Ptr = AnguliteSprings_.Front To AnguliteSprings_.Back
			
			I->applyCorrectiveImpulse()
			
		Next
			
		'End If
		
		''
		'For L As LinearSpring Ptr = LinearSprings_.Front To LinearSprings_.Back
		'	
		'	'L->ApplyImpulseConcentration()
		'	L->ApplyImpulseDispersion()
		'	
		'Next
		'
		'For L As Body Ptr = Bodys_.Front To Bodys_.Back
		'	
	 	'	L->ApplyImpulseConcentration(1.0)
		'	L->ApplyImpulseDispersion()
		'	
		'Next
		
		'For L As PressureBody Ptr = PressureBodys_.Front To PressureBodys_.Back
			
			'L->ApplyImpulseConcentration(1.0)
			'L->ApplyImpulseDispersion()
			
		'Next
		
	Next
	
	For i As Integer = 1 To 8
		
		For L As LinearSpring Ptr = LinearSprings_.Front To LinearSprings_.Back
			
			L->ApplyImpulseDispersion()
			
		Next
		
	Next
	
	'For L As PressureBody Ptr = PressureBodys_.Front To PressureBodys_.Back
	'	
	'	L->ComputePressureImpulse()
	'	L->ApplyImpulseDispersion()
	'	
	'Next
	
End Sub

Sub World.ApplyWarmStart()
	
	'For F As FixedSpring Ptr = FixedSprings_.Front To FixedSprings_.Back
	'	
	'	F->ApplyWarmStart()
	'	 
	'Next
	
	For L As LinearSpring Ptr = LinearSprings_.Front To LinearSprings_.Back
		
		L->ApplyWarmStart()
		 
	Next
	
	For I as AnguliteSpring Ptr = AnguliteSprings_.Front To AnguliteSprings_.Back
		
		I->ApplyWarmStart()
		
	Next
	
End Sub


'' Create


''
Sub World.computeData()
	
	''	In this function all the necessary data is Computed, such as
	'' spring lengths, unit vectors, soft body state vectors and so on.
	'' No impulses are applied.
	
	For I as LinearSpring Ptr = LinearSprings_.Front To LinearSprings_.Back
		
		I->ComputeStateVectors()
		I->ComputeInertia()
		I->ComputeAngularVelocity()
		I->ComputeLengths()
		I->ComputeRestImpulse()
		
	Next
	
	'For I as FixedSpring Ptr = FixedSprings_.Front To FixedSprings_.Back
	''	
	''	I->ComputeLengthVector()
	''	I->ComputeRestImpulse()
	''	
	'Next
	
	'For I as Rotate Ptr = Rotates_.Front To Rotates_.Back
	'	
	'	
	'	
	'Next
	
	'For I as Body Ptr = Bodys_.Front To Bodys_.Back
	'	
	'	I->ComputeStateVectors()
	'	I->ComputeInertia()
	'	I->ComputeAngularVelocity()
	'	
	'Next
	
	'For I as SpringBody Ptr = SpringBodys_.Front To SpringBodys_.Back
	'	
	'	'I->ComputeStateVectors()
	'	'I->ComputeInertia()
	'	'I->ComputeAngularVelocity()
	'	
	'Next
	
	'For I as PressureBody Ptr = PressureBodys_.Front To PressureBodys_.Back
	'	
	'	I->ComputeStateVectors()
	'	I->ComputeInertia()
	'	I->ComputeAngularVelocity()
	'	I->ComputeArea()
	'	
	'Next
	
	'For I as AngularSpring Ptr = AngularSprings_.Front To AngularSprings_.Back
	'	
	'	'I->ComputeAngle()
	'	'I->ComputeAngleVector()
	'	'I->ComputeAngularVelocity()
	'	'I->ComputeReducedInertia()
	'	
	'Next
	
	For I as AnguliteSpring Ptr = AnguliteSprings_.Front To AnguliteSprings_.Back
		
		I->ComputeAngleVector()
		I->ComputeReducedInertia()
		I->ComputeRestImpulse()
		
	Next
	
End Sub

Sub World.Solve()
	
	For I As Particle Ptr = Particles_.front To Particles_.back
		
		I->AddVelocity( I->Impulse )
		I->AddPosition( I->Velocity * DT )
		
		I->Impulse( Vec2( 0.0, 0.0 ) )
		
	Next
	
End Sub


#EndIf ''__S2_WORLD_BI__
