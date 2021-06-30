''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 7, february 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  Roxel - Roxel collision response
''
''*******************************************************************************

Type AABBType
	
	Declare Constructor()
	Declare Destructor()
	
	As Vec2 TopLft
	As Vec2 BtmRgt
	
End Type

Constructor AABBType
	
	TopLft = Vec2( 0.0, 0.0 )
	BtmRgt = Vec2( 0.0, 0.0 )
	
End Constructor

Destructor AABBType
	
End Destructor
