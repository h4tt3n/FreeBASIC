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
''  Game include file containing all includes.
''    
''******************************************************************************


''
#Ifndef __GRAVEYARD_ORBIT_BI__
#Define __GRAVEYARD_ORBIT_BI__


'' Game IO 
#Include "../../GameIO/GameIO.bi"

'' Physics engine
#Include "../../SquishyPlanet/SquishyPlanet_v0.7.0/SquishyPlanet.bi"

''
#Include "goConstants.bi"

''
#Include "goRoxel.bi"

''
#Include "goPlanet.bi"

''
#Include "goRocket.bi"

'' Macro for creating dynamic array types at compile time
'' (This creates the types but does not instantiate them)
DynamicArrayType( RoxelContainer, Roxel )
DynamicArrayType( PlanetContainer, Planet )
DynamicArrayType( RocketContainer, Rocket )

'' 
#Include "goGame.bi"

''
#Include "goCreate.bi"

''
#Include "goPuzzles.bi"


''
#EndIf __GRAVEYARD_ORBIT_BI__
