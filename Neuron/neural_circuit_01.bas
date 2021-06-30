''*******************************************************************************
''
''
''
''
''*******************************************************************************


'' Includes
#Include Once "fbgfx.bi"
#Include Once "../Math/Vec2.bi"


'' Global constants
Const As Single  dt                 = 1.0 / 60.0       ''  timestep
Const As Single  inv_dt             = 1.0 / dt         ''  inverse timestep
Const As Single  pi                 = 4.0 * Atn( 1.0 ) ''  pi
Const As Integer screen_wid         = 1000             ''  screen width
Const As Integer screen_hgt         = 800              ''  screen height
Const As Integer pick_distance      = 128^2            ''  mouse pick up distance
Const As Integer max_cennections    = 8192             ''  Axons
Const As Integer max_neurons        = 4096             ''  angular Dendrites


''	Types
Type NeuronType
	
	Declare Constructor()
	
	As Boolean FireState
	
	As Single Value
	As Single ReceivedSignal
	As Single FireThreshold
	As Single FireSignal
	
	As Vec2 Position
	
End Type

Type ConnectionType
	
	Declare Constructor()
	
	As Single Value
	As Single InverseStrength
	
	As NeuronType Ptr Transmitter
	As NeuronType Ptr Receiver
	
End Type

Type SimulationType
	
	Declare Constructor()
	Declare Destructor()

	Declare Sub Demo1()
	
	Declare Sub CreateScreen( ByVal Wid As Integer, ByVal Hgt As Integer )
	
	Declare Function CreateConnection() As ConnectionType Ptr
	Declare Function CreateNeuron() As NeuronType Ptr
	
	Declare Sub CleaConnections()
	Declare Sub ClearNeurons()
	Declare Sub ClearWarmstart()
	
	Declare Sub UpdateInput()
	Declare Sub UpdateScreen()
	
	Declare Sub RunSimulation()

	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	Declare Sub ComputeReusableData()
	Declare Sub ComputeNewState()
	
	As fb.EVENT e
	
	As String DemoText
	
	As Integer iterations
	As Integer warmstart
	As Integer numConnections
	As Integer numNeurons
	
	As Single cStiffness
	As Single cDamping
	As Single cWarmstart
	
	As Vec2 position
	As Vec2 position_prev
	As Vec2 velocity
	
	As Integer button
	As Integer button_prev
	
	As NeuronType Ptr picked
	As NeuronType Ptr nearest
	
	As ConnectionType Ptr ConnectionLo
	As ConnectionType Ptr ConnectionHi
	
	As NeuronType Ptr NeuronLo
	As NeuronType Ptr NeuronHi
	
	As ConnectionType Connection ( 1 To max_Connections )
	As NeuronType     Neuron     ( 1 To max_Neurons )

End Type


''
Constructor NeuronType()
	
	FireState = FALSE
	
	Value          = 0.0
	ReceivedSignal = 0.0
	FireThreshold  = 0.0
	FireSignal     = 0.0
	
	Position       = Vec2( 0.0, 0.0 )
	
End Constructor

Constructor ConnectionType()

	Value           = 0.0
	InverseStrength = 0.0
	
	Transmitter = 0
	Receiver    = 0
	
End Constructor

Constructor SimulationType()

End Constructor

Destructor SimulationType()

End Destructor

