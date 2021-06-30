''******************************************************************************
''    
''  Graveyard Orbit - A 2D space physics puzzle game
''
''  Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''  Version 0.2.0, May 1. 2017
''  
''  Author:
''  Michael "h4tt3n" Schmidt Nissen, michaelschmidtnissen@gmail.com
''
''  Description:
''  Game main file.
''    
''******************************************************************************


'' Include the library
#Include "GraveyardOrbit.bi"


'' Create a Game instance
Scope
	
	Dim As Game ThisGame
	
	ThisGame.RunGameLoop()
	
End Scope
