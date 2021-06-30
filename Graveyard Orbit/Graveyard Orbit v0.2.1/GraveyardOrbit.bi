''******************************************************************************
''    
''  Graveyard Orbit - A 2D space physics puzzle game
''
''  Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''  Version 0.2.1, June 2018
''  
''  Author:
''  Michael "h4tt3n" Schmidt Nissen, michaelschmidtnissen@gmail.com
''
''  Description:
''  All files used in the game are included here and *only* here. 
''  
''    
''******************************************************************************


''
#Ifndef __GRAVEYARD_ORBIT_BI__
#Define __GRAVEYARD_ORBIT_BI__

''
#Pragma Once

'' Game IO 
#Include "../../GameIO/GameIO.bi"

'' Physics engine
#Include "../../SquishyPlanet/SquishyPlanet_v0.8.1/SquishyPlanet.bi"

''
#Include "goConstants.bi"

''
#Include "goRoxel.bi"

''
#Include "goPlanet.bi"

''
#Include "goThruster.bi"

''
#Include "goRocket.bi"

''
DynamicArrayType( ThrusterPtrContainer, Thruster Ptr )

''
#Include "goSpaceShip.bi"

''
#Include "goPlayer.bi"

'' Macro for creating dynamic array types at compile time
'' (This creates the types but does not instantiate them)
DynamicArrayType( RoxelContainer, Roxel )
DynamicArrayType( PlanetContainer, Planet )
DynamicArrayType( RocketContainer, Rocket )
DynamicArrayType( SpaceShipContainer, SpaceShip )
DynamicArrayType( ThrusterContainer, Thruster )

'' 
#Include "goGame.bi"

''
#Include "goCreate.bi"

''
#Include "goPuzzles.bi"


#EndIf __GRAVEYARD_ORBIT_BI__
