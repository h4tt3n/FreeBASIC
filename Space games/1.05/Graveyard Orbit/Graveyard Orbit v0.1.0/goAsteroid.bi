''******************************************************************************
''    
''  Graveyard Orbit - A 2D space physics puzzle game
''
''  Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''  Version 0.1.0, October 31. 2016
''  
''  Author:
''  Michael "h4tt3n" Schmidt Nissen, michaelschmidtnissen@gmail.com
''    
''  Description:
''  This file contains all types of celestial bodies, including stars, 
''  planets, moons, asteroids, comets etc.
''
''******************************************************************************


#Ifndef __GO_ASTEROID_BI__
#Define __GO_ASTEROID_BI__


Type Asteroid Extends RigidBody
	
	Public:
	
	Declare Constructor()
	
	Declare Destructor()
	
	Private:
	
End Type


''
Constructor Asteroid()
	
End Constructor


''
Destructor Asteroid()
	
End Destructor


#EndIf __GO_ASTEROID_BI__
