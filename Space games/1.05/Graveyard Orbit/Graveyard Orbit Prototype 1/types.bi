''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 1, November 2016
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  Warning: Looking at the following code may cause permanent eye damage!
''
''  
''******************************************************************************* 

''
Type LinearStateType
	
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
Type AngularStateType
	
	Declare Constructor()
	Declare Destructor()
	
	As Vec2 direction_vector
	As Vec2 velocity_vector
	
	As Single direction
	As Single velocity
	As Single impulse
	
	As Single inertia
	As Single inverse_inertia
	
End Type

DynamicArrayType( AngularStateArray, AngularStateType )

'''
'Type ThermoDynamicsType
'	
'	'Declare Constructor()
'	'Declare Destructor()
'	
'	As Single   area
'	As Single   density
'	As Single   pressure
'	As Single   temperature
'	
'End Type
'
'''
'Type LinearLinkType
'	
'	Declare Constructor()
'	Declare Destructor()
'	
'	As Vec2 delta_position_vector
'	As Vec2 delta_velocity_vector
'
'	As Single delta_position
'	As Single delta_velocity
'	As Single reduced_mass
'	
'	As LinearStateType Ptr linear_a
'	As LinearStateType Ptr linear_b
'	
'End Type
'
'''
'Type AngularLinkType
'	
'	Declare Constructor()
'	Declare Destructor()
'	
'	As Vec2 delta_direction_vector
'	As Vec2 delta_velocity_vector
'
'	As Single delta_direction
'	As Single delta_velocity
'	As Single reduced_inertia
'	
'	As AngularStateType Ptr angular_a
'	As AngularStateType Ptr angular_b
'	
'End Type

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
Type RigidBodyType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Function AddRoxel( ByVal R As RoxelType Ptr ) As Boolean
	
	Declare Sub computeData()
	
	As LinearStateType  Linear
	As AngularStateType Angular
	
	As Vec2   Linear_prev
	As Single Angular_prev
	
	As RoxelArray Roxels
  	
End Type

DynamicArrayType( RigidBodyArray, RigidBodyType )

''
Type GravityType
	
	Declare Constructor()
	Declare Destructor()
	
	As Vec2 unit
	
	As LinearStateType Ptr particle_a
	As LinearStateType Ptr particle_b
  	
End Type

DynamicArrayType( GravityArray, GravityType )

''
Type FixedConstraintType
	
	Declare Constructor()
	Declare Destructor()
	
	As LinearStateType Linear
	
	As Single reduced_mass
	As Single rest_impulse
	
	As Vec2 rest_distance
	As Vec2 accumulated_impulse
	
	As LinearStateType Ptr particle_a
	As LinearStateType Ptr particle_b
  
End Type

DynamicArrayType( FixedConstraintArray, FixedConstraintType )

''
Type LL_ConstraintType
	
	Declare Constructor()
	Declare Destructor()
	
	As LinearStateType Linear
	
	'As Vec2 position
	'As Vec2 velocity
	
	As Vec2 local_position_a
	As Vec2 local_position_b
	
	As Vec2 local_velocity_a
	As Vec2 local_velocity_b
	
	As Single reduced_mass
	As Single rest_distance
	As Single rest_impulse
	As Single inertia
	As Single inverse_inertia
	As Single angular_velocity
	
	As Vec2 accumulated_impulse
	As Vec2 unit
	
	As LinearStateType Ptr particle_a
	As LinearStateType Ptr particle_b
  
End Type

DynamicArrayType( LL_ConstraintArray, LL_ConstraintType )

''
Type LA_ConstraintType
	
	Declare Constructor()
	Declare Destructor()
	
	As Single reduced_mass
	As Single rest_distance
	As Single rest_impulse
	
	As Vec2 accumulated_impulse
	As Vec2 unit
	As Vec2 anchor
	
	As LinearStateType  Ptr l
	As AngularStateType Ptr a
	
End Type

DynamicArrayType( LA_ConstraintArray, LA_ConstraintType )

Type AA_ConstraintType
	
	Declare Constructor()
	Declare Destructor()
	
	As Vec2 anchor1
	As Vec2 anchor2 
	
	As AngularStateType Ptr a1
	As AngularStateType Ptr a2
	
End Type

''
Type AngularConstraintType
	
	Declare Constructor()
	Declare Destructor()
	
	As Single  reduced_inertia
	As Single  rest_impulse
	As Single  accumulated_impulse
	
	As Vec2 direction
	As Vec2 rest_direction
	
	As LL_ConstraintType Ptr spring_a
	As LL_ConstraintType Ptr spring_b
  
End Type

DynamicArrayType( AngularConstraintArray, AngularConstraintType )

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
	As RigidBodyArray         rigidbodys
	As GravityArray           gravitys
	As FixedConstraintArray   FixedConstraints
	As LL_ConstraintArray     ll_constraints
	As AngularConstraintArray angularconstraints
	
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
	
	direction        = 0.0
	direction_vector = Vec2( 1.0, 0.0 )
	velocity         = 0.0
	velocity_vector  = Vec2( 1.0, 0.0 )
	impulse          = 0.0
	inertia          = 0.0
	inverse_inertia  = 0.0
	
End Constructor

'Constructor LinearLinkType()
'
'End Constructor
'
'Constructor AngularLinkType()
'
'End Constructor

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
	
	Angular.direction        = 0.0
	Angular.direction_vector = Vec2( 1.0, 0.0 )
	Angular.velocity         = 0.0
	Angular.impulse          = 0.0
	Angular.inertia          = 0.0
	Angular.inverse_inertia  = 0.0
	
	Roxels.Reserve( MAX_ROXELS_IN_BODY )
	
End Constructor

Constructor GravityType()
	
	particle_a = 0
	particle_b = 0
	unit       = Vec2( 0.0, 0.0 )
	
End Constructor

Constructor FixedConstraintType()

End Constructor

Constructor LL_ConstraintType()
	
	Linear.position  = Vec2( 0.0, 0.0 )
	Linear.velocity  = Vec2( 0.0, 0.0 )
	local_position_a = Vec2( 0.0, 0.0 )
	local_position_b = Vec2( 0.0, 0.0 )
	local_velocity_a = Vec2( 0.0, 0.0 )
	local_velocity_b = Vec2( 0.0, 0.0 )
	
	reduced_mass     = 0.0
	rest_distance    = 0.0
	rest_impulse     = 0.0
	inertia          = 0.0
	inverse_inertia  = 0.0
	angular_velocity = 0.0
	
	accumulated_impulse = Vec2( 0.0, 0.0 )
	unit = Vec2( 0.0, 0.0 )
	
	particle_a = 0
	particle_b = 0
	
End Constructor

Constructor LA_ConstraintType()
	
	
End Constructor

Constructor AngularConstraintType()
	
	spring_a            = 0
	spring_b            = 0
	reduced_inertia     = 0.0
	rest_impulse        = 0.0
	accumulated_impulse = 0.0
	direction           = Vec2( 1.0, 0.0 )
	rest_direction      = Vec2( 1.0, 0.0 )
	
End Constructor

Constructor RocketType()
	
	
End Constructor

Constructor GameType()
	
	''
	LinearStates.Reserve( MAX_LINEAR_STATES )
	Gravitys.Reserve( MAX_GRAVITYS )
	Roxels.Reserve( MAX_ROXELS )
	Rigidbodys.Reserve( MAX_RIGID_BODYS )
	LL_Constraints.Reserve( MAX_LL_CONSTRAINTS )
	FixedConstraints.Reserve( MAX_FIXED_CONSTRAINTS )
	angularconstraints.Reserve( MAX_ANGULAR_CONSTRAINTS )
	
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

'Destructor LinearLinkType()
'
'End Destructor
'
'Destructor AngularLinkType()
'
'End Destructor

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

Destructor LA_ConstraintType

End Destructor

Destructor AngularConstraintType

End Destructor

Destructor RocketType()
	
End Destructor

Destructor GameType()
	
	LinearStates.Destroy()
	Gravitys.Destroy()
	Roxels.Destroy()
	rigidbodys.Destroy()
	FixedConstraints.Destroy()
	LL_Constraints.Destroy()
	angularconstraints.Destroy()
	
End Destructor
