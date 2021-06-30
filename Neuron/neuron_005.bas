''******************************************************************************'
''		
''    Neuron soup simulation v. 0.02, september 2009
''		Made by Michael "h4tt3n" Nissen, micha3l_niss3n@yahoo.dk
''		Single signal spreading to entire network causing self-sustaining noise.
''
''******************************************************************************'


''   Includes
#Include Once "fbgfx.bi"
#include once "../math/vec2.bi"


''
const as single  pi              = 4*atn(1)
const as single  halfpi          = 0.5*pi
Const as integer num_connections = 1
Const as integer num_neurons     = 2
Const as Single  neuron_dist     = 32
Const As Integer screen_wid      = 1000             ''  screen width
Const As Integer screen_hgt      = 800              ''  screen height


''
Type NeuronType
	
	Declare constructor
	declare Destructor
	
	as vec2    position
	as single  value
	As single  firethreshold
	as single  firesignalmag
	As UShort  connections
	as boolean firestate
	
	As Integer connection( num_connections )
	
end Type

Type SimulationType
	
	Declare Constructor()
	Declare Destructor()
	
	declare sub createbrain()
	declare sub deletebrain()
	declare sub updateneuron()
	declare sub updateconnection()
	declare sub drawbrain()
	declare sub runsimulation()
	
	declare sub drawneurons()
	
	Declare Sub CreateScreen( ByVal Wid As Integer, ByVal Hgt As Integer )
	
	as NeuronType neuron( num_neurons )
	
end Type


''
Scope
	
	Dim As SimulationType Simulation
	
End Scope


''
Constructor neurontype

	position      = Vec2( 0.0, 0.0 )
	value         = 0.0
	firethreshold = 0.0
	firesignalmag = 0.0
	connections   = 0
	firestate     = FALSE
	
End Constructor

Destructor neurontype

End Destructor

constructor SimulationType

	createbrain()
	createscreen( screen_wid, screen_hgt ) 
	runsimulation()
	
end Constructor

destructor SimulationType
	
end Destructor

sub SimulationType.createbrain()
	
	Randomize Timer
	
	'' create neurons
	for i as integer = 0 to num_neurons-1
		
		neuron(i).position      = vec2( Rnd * screen_wid, Rnd * screen_hgt )
		neuron(i).value         = 64 + Rnd * 64'8 + rnd*96
		neuron(i).firethreshold = 128''+rnd*32 ''32+rnd*32
		neuron(i).firesignalmag = 64 + Rnd * 64 ''32+rnd*24
		neuron(i).connections   = 0
		neuron(i).firestate     = FALSE
		
	Next
	
	'' create connections
	'for j As integer = 0 to num_neurons-1
	'	
	'	For i as integer = 0 to num_neurons-1
	'		
	'		If ( i = j ) Then Continue For 
	'		
	'		If ( neuron(i).connections >= num_connections-1 ) Then Continue For, for
	'			
	'		Dim As vec2 vec_dst = neuron(j).position - neuron(i).position
	'		
	'		Dim As Single dist = Sqr(vec_dst.x*vec_dst.x+vec_dst.y*vec_dst.y)
	'		'Dim As Single dist = Length( neuron(j).position - neuron(i).position )
	'		
	'		If ( dist > neuron_dist ) Then Continue For 
	'			
	'		neuron(i).connection( neuron(i).connections ) = j
	'			
	'		neuron(i).connections += 1
	'		
	'	Next
	'	
	'Next
	
	neuron(0).connection( neuron(0).connections ) = 1
	
	neuron(0).connections += 1
	
	
end Sub

sub SimulationType.updateneuron()
	
	for i as integer = 0 to num_neurons-1
		
		with neuron(i)
			
			if .value >= .firethreshold then 
				
				.firestate = TRUE
				.value = 0.0''8 + rnd*32
				
			Else
				
				.firestate = FALSE
				
			end If
			
			''.value *= 0.99
			
		end with
	Next
	
end Sub

sub SimulationType.updateconnection()
	
	For i as integer = 0 to num_neurons-1
		
		with neuron(i)
			
			For j as integer = 0 to .connections-1
				
				If .firestate = TRUE then 
					
					neuron(j).value += .firesignalmag
					
				EndIf
				
			Next
		
		end With
			
	Next
	
end sub

sub SimulationType.drawbrain()
	
	ScreenLock
	
		Cls
		
		''
		For i as integer = 0 to num_neurons-1
		
			with neuron(i)
				
				For j as integer = 0 to .connections-1
					
					Dim As UByte col = IIf( .FireState = TRUE, 255, 64 )
					
					Line( .position.x, .position.y )-( neuron(j).position.x, neuron(j).position.y ), RGB( col, col, col )
					
				Next
			
			end With
				
		Next
		
		''
		for i as integer = 0 to num_neurons-1
			
			with neuron(i)
				
				Circle( .position.x, .position.y ), 5, rgb(64, 64, 64),,,1, f
				circle( .position.x, .position.y ), 3, rgb(0, .value, 0),,,1, f
				
				Draw String ( .position.x + 8, .position.y + 8 ), Str(i), RGBA(255, 255, 255, 255)
				
			End With
			
		Next
		
	ScreenUnLock
	
end Sub

sub SimulationType.RunSimulation()
	
	do
		
		'updateneuron()
		'updateconnection()
		drawbrain()
		
		sleep 10, 1
		
	loop until multikey(1)
	
end Sub

Sub SimulationType.CreateScreen( ByVal Wid As Integer, ByVal Hgt As Integer )
   
   'ScreenControl( fb.SET_GL_2D_MODE, fb.OGL_2D_MANUAL_SYNC  )
   'ScreenControl( fb.SET_GL_SCALE, 0 )
   
   ScreenRes Wid, Hgt, 32, 1, fb.GFX_ALPHA_PRIMITIVES
   'ScreenRes( Wid, Hgt, 32, 2, fb.GFX_OPENGL )
   
   ''ScreenSet( 0, 1 )
   
   WindowTitle ""
   
   Color RGB( 255, 160, 160 ), RGB( 0, 0, 0 )
   
End Sub