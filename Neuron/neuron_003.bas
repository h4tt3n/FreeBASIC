'******************************************************************************'
'		Neuron soup simulation v. 0.02, september 2009
'		Made by Michael "h4tt3n" Nissen, micha3l_niss3n@yahoo.dk
'		Single signal spreading to entire network causing self-sustaining noise.
'******************************************************************************'

#include once "vec2f.bi"

const as byte false = 0
const as byte true  = not false

const as single pi = 4*atn(1)
const as single halfpi = 0.5*pi

dim shared as integer bpp, pitch, w, h

screeninfo w, h
screenres w, h, 32,,1

type neurontype
	as vec2f psn
	as single value						= 0
	as byte   firestate				= false
	as single firethreshold 	= 100
	as single firesignalmag 	= 60
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
	
	as integer maxnumneurons			= 100
	as integer maxnumconnections	= 512'320
	as integer numneurons					= 100
	as integer numconnections			= 512'320
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
	runsimulation()
end constructor

destructor braintype
	deletebrain()
	end
end destructor

sub neurontype.drawneuron()
	'pset(psn.x, psn.y), rgb(0, value, 0)
	'sptr[psn.x * bpp + psn.y * pitch] = rgb(0, value, 0)
	circle(psn.x, psn.y), 5, rgb(0, value, 0),,,1, f
	circle(psn.x, psn.y), 5, rgb(64, 64, 64),,,1
end sub

sub connectiontype.drawconnection()
	
	Dim As UInteger col = transmitter->value
	
	line(transmitter->psn.x, transmitter->psn.y)-(receiver->psn.x, receiver->psn.y), rgb(col, 32, 32)
end sub

sub braintype.createbrain()
	
	''randomize timer
	
	if maxnumneurons then 
		neuron = new neurontype[maxnumneurons]
		for i as integer = 0 to numneurons-1
			'dim as single ang = rnd*2*pi
			'dim as single dst = 100 + (rnd * 150^halfpi )^(1/halfpi)
			'neuron[i].psn = vec2f(w\2 + dst*cos(ang), h\2 + dst*sin(ang))
			'neuron[i].psn = vec2f(50 + (Rnd*w)-200, 50 + (Rnd*h)-200 )
			neuron[i].psn = vec2f( 50 + Rnd * 1300, 50 + Rnd * 800 )
			neuron[i].value = 8 + rnd*96
			neuron[i].firethreshold = 96+rnd*32 ''32+rnd*32
			neuron[i].firesignalmag = 32+rnd*24 ''32+rnd*24
		next
	end if
	
	neuron[0].value = 255
	'neuron[1].value = 255
	'neuron[2].value = 255
	
	if maxnumconnections then 
		
		connection = new connectiontype[maxnumconnections]
		
		for i as integer = 0 to numconnections-1
			
			dim as integer j, n = int(rnd*numneurons-1)
			
			connection[i].transmitter = @neuron[n]
			
			do
				
				j = int(rnd*numneurons-1)
				if j <> n then
					dim as single dist = distancesquared(neuron[n].psn, neuron[j].psn)
					if dist < 200^2 then connection[i].receiver = @neuron[j]: exit do
				end if
			
			loop
			
		next
	end if
	
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
				.firestate = true
				.value = 8 + rnd*32
			else
				.firestate = false
			end If
			.value *= 0.85
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
			if .transmitter->firestate = true then .receiver->value += .transmitter->firesignalmag
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
		
		sleep 10, 1
		
	loop until multikey(1)
	
end sub