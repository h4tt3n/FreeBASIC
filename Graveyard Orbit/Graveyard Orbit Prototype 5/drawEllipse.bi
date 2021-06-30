
'''
'#Include Once "../../Math/Vector2.bi"

Const As Single PI     = 4.0 * Atn( 1.0 )
Const As Single TWO_PI = 2.0 * PI


Declare Sub FastEllipse ( ByVal Position as Vec2, _
	                       ByVal SemiAxes As Vec2, _
	                       ByVal Angle    As Vec2, _
	                       ByVal colour   As UInteger )

''
sub FastEllipse ( ByVal Position as Vec2, _
	               ByVal SemiAxes As Vec2, _
	               ByVal Angle    As Vec2, _
	               ByVal Colour   As UInteger )
	
	''	these constants define the graphical quality of the circle
	const as Single  verticelength = 16
	const as Integer minvertices   = 16
	const as Integer maxvertices   = 256
	
	''	approx. ellipse circumference ( Hudson's method )
	dim as single h = ( ( SemiAxes.x - SemiAxes.y ) * ( SemiAxes.x - SemiAxes.y ) ) / _
	                  ( ( SemiAxes.x + SemiAxes.y ) * ( SemiAxes.x + SemiAxes.y ) )
	
	dim as single circumference = 0.25 * PI * ( SemiAxes.x + SemiAxes.y ) * _
	                             ( 3.0 * ( 1.0 + h / 4.0 ) + 1.0 / ( 1.0 - h / 4.0 ) )
	
	''	number of vertices
	dim as integer numvertices =  Abs( circumference / verticelength )
	
	'numvertices -= numvertices mod 4
	
	If ( numvertices < minvertices ) Then numvertices = minvertices
	if ( numvertices > maxvertices ) Then numvertices = maxvertices

	Dim As Vec2 Theta = Vec2( cos( TWO_PI / numvertices ), _
	                          Sin( TWO_PI / numvertices ) )
	
	Dim As Vec2 Coords( NumVertices )
	Dim As Vec2 EllipseCoords( NumVertices )
	
	Coords(0) = Theta.RotateCCW( Vec2( 1.0, 0.0 ) )
	
	EllipseCoords(0) = Position + ( Coords(0) * SemiAxes ).RotateCCW( Angle )
	
	for i as integer = 1 to numvertices-1
		
		Coords(i) = Theta.RotateCCW( Coords(i-1) )
		
		EllipseCoords(i) = Position + ( Coords(i) * SemiAxes ).RotateCCW( Angle )
		
	Next
	
	'For i as integer = 0 to numvertices-1
	'	
	'	EllipseCoords(i) = Position + ( Coords(i) * SemiAxes ).Rotate( Angle )
	'	
	'Next
	
	''	draw ellipse
	for i as integer = 0 to numvertices-1
		
		Dim as integer j = (i + 1) mod numvertices
		
		Line( EllipseCoords(i).x, EllipseCoords(i).y )-( EllipseCoords(j).x, EllipseCoords(j).y ), Colour
		'PSet( EllipseCoords(i).x, EllipseCoords(i).y ), Colour
		
	Next
	
end Sub
