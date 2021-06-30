'******************************************************************************'
'		Neuron soup simulation v. 0.01, september 2009
'		Made by Michael "h4tt3n" Nissen, micha3l_niss3n@yahoo.dk
'		Signal travelling in a circular setup of neurons and connections.
'******************************************************************************'

#include once "vec2f.bi"

const as single pi = 4*atn(1)

type neurontype
	as vec2f psn
	as single value						= 0
	as single firestate				= 0
	as single firethreshold 	= 10
	as single firesignalmag 	= 255
	declare sub drawneuron()
end type

type connectiontype
	as neurontype ptr transmitter
	as neurontype ptr receiver
	declare sub drawconnection()
end type

type braintype
	
	declare constructor
	declare destructor
	
	as integer maxnumneurons			= 512
	as integer maxnumconnections	= 512
	as integer numneurons					= 64
	As integer numconnections			= 64
	as neurontype ptr neuron
	as connectiontype ptr connection
	
	declare sub createbrain()
	declare sub deletebrain()
	declare sub createneuron()
	declare sub deleteneuron()
	declare sub updateneuron()
	declare sub createconnection()
	declare sub deleteconnection()
	declare sub updateconnection()
	declare sub drawbrain()
	declare sub runsimulation()
	
end type

dim as braintype brain

constructor braintype
	createbrain()
	screenres 800, 600, 32
	runsimulation()
end constructor

destructor braintype
	deletebrain()
	end
end destructor

sub neurontype.drawneuron()
	circle(psn.x, psn.y), 5, rgb(0, value, 0),,,1, f
	circle(psn.x, psn.y), 5, rgb(64, 64, 64),,,1
end sub

sub connectiontype.drawconnection()
	line(transmitter->psn.x, transmitter->psn.y)-(receiver->psn.x, receiver->psn.y), rgb(255, 32, 32)
end sub

sub braintype.createbrain()
	
	randomize timer
	
	if maxnumneurons then 
		neuron = new neurontype[maxnumneurons]
		for i as integer = 0 to numneurons-1
			dim as single ang = 2*pi*(i/numneurons)
			neuron[i].psn = vec2f(400 + cos(ang)*200, 300 + sin(ang)*200)
		next
	end if
	
	if maxnumconnections then 
		connection = new connectiontype[maxnumconnections]
		for i as integer = 0 to numconnections-1
			dim as integer j = (i+1) mod numconnections
			connection[i].transmitter = @neuron[i]
			connection[i].receiver 		= @neuron[j]
		next
	end if
	
	neuron[0].value = 255
	
end sub

sub braintype.deletebrain()
	if maxnumneurons then delete[] neuron
	if maxnumconnections then delete[] connection
end sub

sub braintype.createneuron()
	
end sub

sub braintype.deleteneuron()
	
end sub

sub braintype.updateneuron()
	for i as integer = 0 to numneurons-1
		with neuron[i]
			if .value >= .firethreshold then 
				.firestate = 1
				.value = 0
			else
				.firestate = 0
			end if
		end with
	next
end sub

sub braintype.createconnection()
	
end sub

sub braintype.deleteconnection()
	
end sub

sub braintype.updateconnection()
	for i as integer = 0 to numconnections-1
		with connection[i]
			if .transmitter->firestate then .receiver->value += .transmitter->firesignalmag
		end with
	next
end sub

sub braintype.drawbrain()
	screenlock
		cls
		for i as integer = 0 to numconnections-1
			connection[i].drawconnection()
		next
		for i as integer = 0 to numneurons-1
			neuron[i].drawneuron()
		next
	screenunlock
end sub

sub braintype.runsimulation()
	
	do
		
		updateneuron()
		updateconnection()
		drawbrain()
		
		sleep 8, 1
		
	loop until multikey(1)
	
end sub