''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 2, December 2016
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  Warning: Looking at the following code may cause permanent eye damage!
''
''  
''******************************************************************************* 

''
Type LinearStateType Extends Object
	
	Declare Constructor()
	Declare Destructor()
	
	As Vec2 position
	As Vec2 velocity
	As Vec2 impulse
	
	As Single mass
	As Single inverse_mass
  	
End Type

DynamicArrayType( LinearStateArray, LinearStateType )

''
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

DynamicArrayType( AngularStateArray, AngularStateType )

''
Type ThermoDynamicsType
	
	'Declare Constructor()
	'Declare Destructor()
	
	As Single   area
	As Single   density
	As Single   pressure
	As Single   temperature
	
End Type

''
Type LinearLinkType Extends LinearStateType
	
	Declare Constructor()
	Declare Destructor()
	
	As Vec2 delta_position_vector
	As Vec2 delta_velocity_vector
	As Vec2 unit_vector

	As Single delta_position
	As Single delta_velocity
	
	As Single reduced_mass
	
	As LinearStateType Ptr a
	As LinearStateType Ptr b
	
End Type

''
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

''
Type RoxelType
	
	Declare Constructor()
	Declare Destructor()
	
	As LinearStateType Linear
	
	As Single   radius
	As UInteger colour
	
End Type

DynamicArrayType( RoxelArray, RoxelType )

''
Type GravityType
	
	Declare Constructor()
	Declare Destructor()
	
	As LinearLinkType Linear
  	
End Type

DynamicArrayType( GravityArray, GravityType )

''
Type FixedConstraintType
	
	Declare Constructor()
	Declare Destructor()
	
	As LinearLinkType Linear
	
	As Vec2 rest_distance
	As Vec2 rest_impulse
	
	As Vec2 accumulated_impulse
	
End Type

DynamicArrayType( FixedConstraintArray, FixedConstraintType )

''
Type LL_ConstraintType
	
	Declare Constructor()
	Declare Destructor()
	
	As AngularStateType Angular
	
	As LinearLinkType Linear
	
	As Single rest_distance
	As Single rest_impulse
	
	As Vec2 accumulated_impulse
	
End Type

DynamicArrayType( LL_ConstraintArray, LL_ConstraintType )

''
Type AngularConstraintType
	
	Declare Constructor()
	Declare Destructor()
	
	As AngularLinkType Angular
	
	As Vec2 rest_delta_direction
	
	As Single  rest_impulse
	
	As Single  accumulated_impulse
	
End Type

DynamicArrayType( AngularConstraintArray, AngularConstraintType )

''
Type RigidBodyType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub computeData()
	
	As LinearStateType  Linear
	As AngularStateType Angular
	
	As Vec2   Linear_prev
	As Single Angular_prev
	
	As RoxelArray Roxels
  	
End Type

DynamicArrayType( RigidBodyArray, RigidBodyType )

''
Type RocketType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub ApplyThrustImpulse( ByVal _throttle  As Single )
	
	As LinearStateType  Linear
	As AngularStateType Angular
	
	As Single DeltaV_            '' (m/s)
	As Single FuelMass_          '' (kg)
	As Single DryMass_           '' (kg)
	As Single ExhaustVelocity_   '' (m/s)
	As Single FuelFlowRate_      '' (dm/dt) 
	
End Type

DynamicArrayType( RocketTypeArray, RocketType )

''
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
	
	Declare Sub ClearWarmstart()
	Declare Sub UpdateInput()
	Declare Sub UpdateScreen()
	Declare Sub RunGame()
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	Declare Sub ComputeData()
	Declare Sub ComputeNewState()
	Declare Sub DistributeImpulses()
	
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
	As AngularStateArray      angularstates
	As RoxelArray             roxels
	As GravityArray           gravitys
	As FixedConstraintArray   FixedConstraints
	As LL_ConstraintArray     ll_constraints
	As AngularConstraintArray angularconstraints
	As RigidBodyArray         rigidbodys
	
End Type

''	Constructors
Constructor LinearStateType()
	
	mass         = 0.0
	inverse_mass = 0.0
	position     = Vec2( 0.0, 0.0 )
	velocity     = Vec2( 0.0, 0.0 )
	impulse      = Vec2( 0.0, 0.0 )
	
End Constructor

Constructor AngularStateType()
	
	'direction        = 0.0
	direction_vector = Vec2( 1.0, 0.0 )
	velocity         = 0.0
	velocity_vector  = Vec2( 1.0, 0.0 )
	impulse          = 0.0
	inertia          = 0.0
	inverse_inertia  = 0.0
	
End Constructor

Constructor LinearLinkType()
	
	delta_position_vector = Vec2( 1.0, 0.0 )
	delta_velocity_vector = Vec2( 1.0, 0.0 )
	unit_vector = Vec2( 1.0, 0.0 )
	delta_position = 0.0
	delta_velocity = 0.0
	reduced_mass = 0.0
	a = 0
	b = 0
	
End Constructor

Constructor AngularLinkType()

End Constructor

Constructor RoxelType()
	
	Linear.position     = Vec2( 0.0, 0.0 )
	Linear.velocity     = Vec2( 0.0, 0.0 )
	Linear.impulse      = Vec2( 0.0, 0.0 )
	Linear.mass         = 0.0
	Linear.inverse_mass = 0.0
	
	radius = 0.0
	colour = 0
	
End Constructor

Constructor RigidBodyType()
	
	Linear.position     = Vec2( 0.0, 0.0 )
	Linear.velocity     = Vec2( 0.0, 0.0 )
	Linear.impulse      = Vec2( 0.0, 0.0 )
	Linear.mass         = 0.0
	Linear.inverse_mass = 0.0
	
	'Angular.direction        = 0.0
	Angular.direction_vector = Vec2( 1.0, 0.0 )
	Angular.velocity         = 0.0
	Angular.impulse          = 0.0
	Angular.inertia          = 0.0
	Angular.inverse_inertia  = 0.0
	
	Roxels.Reserve( MAX_ROXELS_IN_BODY )
	
End Constructor

Constructor GravityType()
	
	Linear.a = 0
	Linear.b = 0
	Linear.unit_vector = Vec2( 0.0, 0.0 )
	
End Constructor

Constructor FixedConstraintType()

End Constructor

Constructor LL_ConstraintType()
	
	Linear.position = Vec2( 0.0, 0.0 )
	Linear.velocity = Vec2( 0.0, 0.0 )
	Linear.unit_vector = Vec2( 0.0, 0.0 )
	Linear.reduced_mass = 0.0
	
	rest_distance = 0.0
	rest_impulse = 0.0
	accumulated_impulse = Vec2( 0.0, 0.0 )
	
End Constructor

Constructor AngularConstraintType()
	
	rest_impulse         = 0.0
	accumulated_impulse  = 0.0
	rest_delta_direction = Vec2( 1.0, 0.0 )
	
End Constructor

Constructor RocketType()
	
	
End Constructor

Constructor GameType()
	
	''
	LinearStates.Reserve( MAX_LINEAR_STATES )
	AngularStates.Reserve( MAX_ANGULAR_STATES )
	Gravitys.Reserve( MAX_GRAVITYS )
	Roxels.Reserve( MAX_ROXELS )
	LL_Constraints.Reserve( MAX_LL_CONSTRAINTS )
	FixedConstraints.Reserve( MAX_FIXED_CONSTRAINTS )
	angularconstraints.Reserve( MAX_ANGULAR_CONSTRAINTS )
	Rigidbodys.Reserve( MAX_RIGID_BODYS )
	
	''
	LinearStates.Clear()
	AngularStates.Clear()
	Roxels.Clear()
	Rigidbodys.Clear()
	Gravitys.Clear()
	LL_Constraints.Clear()
	angularconstraints.Clear()
	
	Puzzle1()
	
	CreateScreen( screen_wid, screen_hgt )
	
	RunGame()
	
End Constructor

''
Destructor LinearStateType()

End Destructor

Destructor AngularStateType()

End Destructor

Destructor LinearLinkType()

End Destructor

Destructor AngularLinkType()

End Destructor

Destructor RoxelType()

End Destructor

Destructor RigidBodyType()
	
	Roxels.Destroy()
	
End Destructor

Destructor GravityType()

End Destructor

Destructor FixedConstraintType()

End Destructor

Destructor LL_ConstraintType

End Destructor

Destructor AngularConstraintType

End Destructor

Destructor RocketType()
	
End Destructor

Destructor GameType()
	
	LinearStates.Destroy()
	AngularStates.Destroy()
	Gravitys.Destroy()
	Roxels.Destroy()
	FixedConstraints.Destroy()
	LL_Constraints.Destroy()
	angularconstraints.Destroy()
	rigidbodys.Destroy()
	
End Destructor
