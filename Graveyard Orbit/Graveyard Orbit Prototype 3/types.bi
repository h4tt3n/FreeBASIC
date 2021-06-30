''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 3, April 2017
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''******************************************************************************* 


''******************************************************************************* 
''
''******************************************************************************* 
Type LinearStateType Extends Object
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Virtual Sub AddImpulse( ByVal i As Vec2 )
	
	As Vec2 position
	As Vec2 velocity
	As Vec2 impulse
	
	As Single mass
	As Single inverse_mass
  	
End Type

Constructor LinearStateType()
	
	position = Vec2( 0.0, 0.0 )
	velocity = Vec2( 0.0, 0.0 )
	impulse  = Vec2( 0.0, 0.0 )
	
	mass         = 0.0
	inverse_mass = 0.0
	
End Constructor

Destructor LinearStateType()

End Destructor

Sub LinearStateType.AddImpulse( ByVal i As Vec2 )
	
	impulse += i
	
End Sub

DynamicArrayType( LinearStateArray, LinearStateType )


''******************************************************************************* 
''
''*******************************************************************************
Type AngularStateType Extends Object
	
	Declare Constructor()
	Declare Destructor()
	
	As Vec2 direction_vector
	As Vec2 velocity_vector
	
	'As Single direction
	As Single velocity
	As Single impulse
	As Single inertia
	As Single inverse_inertia
	
End Type

Constructor AngularStateType()
	
	direction_vector = Vec2( 1.0, 0.0 )
	velocity_vector  = Vec2( 1.0, 0.0 )
	
	'direction        = 0.0
	velocity         = 0.0
	impulse          = 0.0
	inertia          = 0.0
	inverse_inertia  = 0.0
	
End Constructor

Destructor AngularStateType()

End Destructor

'DynamicArrayType( AngularStateArray, AngularStateType )


''******************************************************************************* 
''
''*******************************************************************************
Type LinearLinkType Extends LinearStateType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub AddImpulse( ByVal i As Vec2 )
	
	As Vec2 delta_position_vector
	As Vec2 delta_velocity_vector
	
	As Vec2 unit_vector

	As Single delta_position
	As Single delta_velocity
	
	As Single reduced_mass
	
	As Vec2   Linear_prev
	As Single Angular_prev
	
	As LinearStateType Ptr a
	As LinearStateType Ptr b
	
End Type

Constructor LinearLinkType()
	
	delta_position_vector = Vec2( 1.0, 0.0 )
	delta_velocity_vector = Vec2( 1.0, 0.0 )
	
	unit_vector = Vec2( 0.0, 0.0 )
	
	delta_position = 0.0
	delta_velocity = 0.0
	
	reduced_mass   = 0.0
	
	a = 0
	b = 0
	
End Constructor

Destructor LinearLinkType()

End Destructor

Sub LinearLinkType.AddImpulse( ByVal i As Vec2 )
	
	Base.AddImpulse( i )
	
	a->AddImpulse( i )
	b->AddImpulse( i )
	
End Sub


''******************************************************************************* 
''
''*******************************************************************************
Type AngularLinkType Extends AngularStateType
	
	Declare Constructor()
	Declare Destructor()
	
	As Vec2 delta_direction_vector
	As Vec2 delta_velocity_vector

	As Single delta_direction
	As Single delta_velocity
	As Single reduced_inertia
	
	As AngularStateType Ptr a
	As AngularStateType Ptr b
	
End Type

Constructor AngularLinkType()
	
	delta_direction_vector = Vec2( 1.0, 0.0 )
	delta_velocity_vector  = Vec2( 1.0, 0.0 )

	delta_direction = 0.0
	delta_velocity  = 0.0
	reduced_inertia = 0.0
	
	a = 0
	b = 0
	
End Constructor

Destructor AngularLinkType()

End Destructor

''******************************************************************************* 
''
''*******************************************************************************
Type RoxelType
	
	Declare Constructor()
	Declare Destructor()
	
	As LinearStateType LinearState
	
	As Single radius
	
	As UInteger colour
	
End Type

Constructor RoxelType()
	
	radius = 0.0
	
	colour = 0
	
End Constructor

Destructor RoxelType()

End Destructor

DynamicArrayType( RoxelArray, RoxelType )


''******************************************************************************* 
''
''*******************************************************************************
Type GravityType
	
	Declare Constructor()
	Declare Destructor()
	
	As LinearLinkType LinearLink
  	
End Type

Constructor GravityType()
	
End Constructor

Destructor GravityType()

End Destructor

DynamicArrayType( GravityArray, GravityType )


''******************************************************************************* 
''
''*******************************************************************************
Type FixedConstraintType
	
	Declare Constructor()
	Declare Destructor()
	
	As LinearLinkType LinearLink
	
	As Vec2 rest_distance
	As Vec2 rest_impulse
	As Vec2 accumulated_impulse
	
End Type

Constructor FixedConstraintType()
	
	rest_distance       = Vec2( 0.0, 0.0 )
	rest_impulse        = Vec2( 0.0, 0.0 )
	accumulated_impulse = Vec2( 0.0, 0.0 )
	
End Constructor

Destructor FixedConstraintType()

End Destructor

DynamicArrayType( FixedConstraintArray, FixedConstraintType )


''******************************************************************************* 
''
''*******************************************************************************
Type LinearSpringType
	
	Declare Constructor()
	Declare Destructor()
	
	As LinearLinkType   LinearLink
	As AngularStateType AngularState
	
	As Single rest_distance
	As Single rest_impulse
	
	As Vec2 accumulated_impulse
	
End Type

Constructor LinearSpringType()

	rest_distance = 0.0
	rest_impulse  = 0.0
	
	accumulated_impulse = Vec2( 0.0, 0.0 )
	
End Constructor

Destructor LinearSpringType

End Destructor

DynamicArrayType( LinearSpringArray, LinearSpringType )


''******************************************************************************* 
''
''*******************************************************************************
Type AngularConstraintType
	
	Declare Constructor()
	Declare Destructor()
	
	As AngularLinkType AngularLink
	
	As Vec2 rest_delta_direction
	
	As Single rest_impulse
	As Single accumulated_impulse
	
End Type

Constructor AngularConstraintType()
	
	rest_delta_direction = Vec2( 1.0, 0.0 )
	
	rest_impulse        = 0.0
	accumulated_impulse = 0.0
	
End Constructor

Destructor AngularConstraintType

End Destructor

DynamicArrayType( AngularConstraintArray, AngularConstraintType )


''******************************************************************************* 
''
''*******************************************************************************
Type RigidBodyType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub computeData()
	
	As LinearStateType  LinearState
	As AngularStateType AngularState
	
	As Vec2 Linear_prev
	
	As Single Angular_prev
	
	As RoxelArray Roxels
  	
End Type

Constructor RigidBodyType()
	
	Linear_prev = Vec2( 0.0, 0.0 )
	
	Angular_prev = 0.0
	
	Roxels.Reserve( MAX_ROXELS_IN_BODY )
	
End Constructor

Destructor RigidBodyType()
	
	Roxels.Destroy()
	
End Destructor

DynamicArrayType( RigidBodyArray, RigidBodyType )


''******************************************************************************* 
''
''*******************************************************************************
Type SoftBodyType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub computeData()
	
	As LinearStateType  LinearState
	As AngularStateType AngularState
	
	As Vec2 Linear_prev
	
	As Single Angular_prev
	
	As LinearStateArray LinearStates
  	
End Type

Constructor SoftBodyType()
	
	Linear_prev = Vec2( 0.0, 0.0 )
	
	Angular_prev = 0.0
	
	LinearStates.Reserve( MAX_ROXELS_IN_BODY )
	
End Constructor

Destructor SoftBodyType()
	
	LinearStates.Destroy()
	
End Destructor

DynamicArrayType( SoftBodyArray, SoftBodyType )

''******************************************************************************* 
''
''*******************************************************************************
Type RocketType
	
	Declare Constructor()
	Declare Destructor()
	
	'Declare Sub ApplyDeltaV        ( ByVal _delta_v   As Single )
	'Declare Sub ApplyFuelMass      ( ByVal _fuel_mass As Single )
	Declare Sub ApplyThrustImpulse( ByVal _throttle  As Single )
	
	'Declare Sub ComputeDeltaV()
	'Declare Sub ComputeFuelMass()
	
	As LinearStateType  LinearState
	As AngularStateType Angular
	
	As Single DeltaV_            '' (m/s)
	As Single FuelMass_          '' (kg)
	As Single DryMass_           '' (kg)
	As Single ExhaustVelocity_   '' (m/s)
	As Single FuelFlowRate_      '' (dm/dt) 
	
End Type

Constructor RocketType()
	
	DeltaV_          = 0.0
	FuelMass_        = 0.0
	DryMass_         = 0.0
	ExhaustVelocity_ = 0.0
	FuelFlowRate_    = 0.0
	
End Constructor

Destructor RocketType()
	
End Destructor

DynamicArrayType( RocketTypeArray, RocketType )


''******************************************************************************* 
''
''*******************************************************************************
Type GameType
	
	Declare Constructor()
	Declare Destructor()

	Declare Sub Puzzle1()
	Declare Sub Puzzle2()
	Declare Sub Puzzle3()
	Declare Sub Puzzle4()
	Declare Sub Puzzle5()
	Declare Sub Puzzle6()
	Declare Sub Puzzle7()
	Declare Sub Puzzle8()
	
	Declare Sub CreateScreen( ByVal Wid As Integer, _
	                          ByVal Hgt As Integer )
	
	Declare Function CreatePlanet( ByVal _position As Vec2, _
	                               ByVal _angle    As Single, _
	                               ByVal _width    As Integer, _
	                               ByVal _length   As Integer, _ 
	                               ByVal _roxels   As Integer ) As RigidBodyType Ptr
	
	Declare Function CreateRocket( ByVal _position As Vec2 ) As RocketType Ptr
	
	Declare Sub CreateRope( ByVal _linear1    As LinearStateType Ptr, _
	                        ByVal _linear2    As LinearStateType Ptr, _
	                        ByVal _unitlength As Single )
	
	Declare Sub CreateGirder( ByVal _position As Vec2, _
	                          ByVal _angle    As Vec2, _
	                          ByVal _width    As Integer, _
	                          ByVal _length   As Integer, _
	                          ByVal _unit     As Integer, _
	                          ByVal _type     As integer )
	
	Declare Sub ClearImpulses()
	Declare Sub ClearWarmstart()
	Declare Sub UpdateInput()
	Declare Sub UpdateScreen()
	Declare Sub RunGame()
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	Declare Sub ComputeData()
	Declare Sub ComputeNewState()
	Declare Sub DistributeImpulses()
	Declare Sub ClearAllArrays()
	
	As fb.EVENT e
	
	As String PuzzleText
	
	As Integer iterations
	As Integer warmstart
	
	As Single cStiffness
	As Single cDamping
	As Single cWarmstart
	
	As Single cAstiffness
	As Single cAdamping
	As Single cAwarmstart
	
	As Vec2 position
	As Vec2 position_prev
	As Vec2 velocity
	
	As Integer button
	As Integer button_prev
	
	As LinearStateType Ptr picked
	As LinearStateType Ptr nearest
	
	As LinearStateArray       linearstates
	'As AngularStateArray      angularstates
	As RoxelArray             roxels
	As GravityArray           gravitys
	As FixedConstraintArray   FixedConstraints
	As LinearSpringArray      LinearSprings
	As AngularConstraintArray angularconstraints
	As RigidBodyArray         rigidbodys
	As SoftBodyArray          softbodys
	
End Type

Constructor GameType()
	
	''
	LinearStates.Reserve( MAX_LINEAR_STATES )
	'AngularStates.Reserve( MAX_ANGULAR_STATES )
	Gravitys.Reserve( MAX_GRAVITYS )
	Roxels.Reserve( MAX_ROXELS )
	LinearSprings.Reserve( MAX_LINEAR_SPRINGS )
	FixedConstraints.Reserve( MAX_FIXED_CONSTRAINTS )
	angularconstraints.Reserve( MAX_ANGULAR_CONSTRAINTS )
	Rigidbodys.Reserve( MAX_RIGID_BODYS )
	
	ClearAllArrays()
	
	Puzzle1()
	
	CreateScreen( screen_wid, screen_hgt )
	
	RunGame()
	
End Constructor

Destructor GameType()
	
	LinearStates.Destroy()
	'AngularStates.Destroy()
	Gravitys.Destroy()
	Roxels.Destroy()
	FixedConstraints.Destroy()
	LinearSprings.Destroy()
	angularconstraints.Destroy()
	rigidbodys.Destroy()
	
End Destructor
