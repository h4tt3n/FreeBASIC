''*******************************************************************************
''   
''   FreeBASIC 2D Floating Point Vector Library
''   Written in FreeBASIC 1.05
''   Version 1.3.0, November 2016, Michael "h4tt3n" Nissen
''   
''   Function syntax:
''   
''   (Return Type) (Name) (Argument Type (, ...)) (Description)
''   
''   Vector  Absolute         ( Vector )          Absolute value
''   Vector  AngleToUnit      ( Scalar )          unit vector from angle scalar
''   Vector  Component        ( Vector, Vector )  Vector Component
''   Scalar  Dot              ( Vector, Vector )  Dot product
''   Vector  Dot              ( Vector, Scalar )  Dot product 
''   Vector  Dot              ( Scalar, Vector )  Dot product
''   Vector  Perp             ( Vector )          Right hand perpendicular
''   Vector  Unit             ( Vector )          Unit Vector
''   Scalar  Length           ( Vector )          Length
''   Scalar  LengthSquared    ( Vector )          Length squared
''   Scalar  PerpDot          ( Vector, Vector )  Perp dot product (2d cross)
''   Vector  PerpDot          ( Vector, Scalar )  Perp dot product (2d cross)
''   Vector  PerpDot          ( Scalar, Vector )  Perp dot product (2d cross)
''   Vector  Project          ( Vector, Vector )  Vector Projection
''   Vector  RandomizeSquare  ( Scalar )          Randomize in range +/- value
''   Vector  RandomizeCircle  ( Scalar )          Randomize in range +/- value
''   Vector  Rotate           ( Vector )          Rotate
''   Scalar  UnitToAngle      ( Vector )          angle scalar from unit vector
''   
''   Library supports both member and non-member function useage:
''   
''   A.function(B) <-> function(A, B)
''   
''*******************************************************************************


''
#Ifndef __VEC2_BI__
#Define __VEC2_BI__


''  Vec2 Vector class
Type Vec2
	
	Public:
	
	''  Vec2 constructor declarations
	Declare Constructor ()
	Declare Constructor ( ByRef v As Const Vec2 )
	Declare Constructor ( ByVal x As Const Single, ByVal y As Const Single )
	
	'' Vec2 destructor
	Declare Destructor()
	
	''  Vec2 assignment operator (=)
	Declare Operator Let ( ByRef B As Const Vec2 )
	
	''	Vec2 compound arithmetic member operator declarations
	Declare Operator +=  ( ByRef B As Const Vec2   )
	Declare Operator -=  ( ByRef B As Const Vec2   )
	Declare Operator *=  ( ByRef B As Const Vec2   )
	Declare Operator *=  ( ByVal B As Const Single )
	Declare Operator /=  ( ByVal B As Const Single )
	
	''  Vec2 member function declarations
	Declare Const Function Absolute        () As Vec2
	
	Declare Const Function PerpCW          () As Vec2
	Declare Const Function PerpCCW         () As Vec2
	
	Declare Const Function Unit            () As Vec2
	Declare Const Function Length          () As Single
	Declare Const Function LengthSquared   () As Single
	
	Declare Const Function Dot             ( ByRef B As Const Vec2   ) As Single
	Declare Const Function Dot             ( ByVal B As Const Single ) As Vec2
	
	Declare Const Function PerpDot         ( ByRef B As Const Vec2   ) As Single
	Declare Const Function PerpDot         ( ByVal B As Const Single ) As Vec2
	
	Declare Const Function Project         ( ByRef B As Const Vec2   ) As Vec2
	Declare Const Function Component       ( ByRef B As Const Vec2   ) As Vec2
	
	Declare Const Function RandomizeCircle ( ByVal B As Const Single ) As Vec2
	Declare Const Function RandomizeSquare ( ByVal B As Const Single ) As Vec2
	
	Declare Const Function RotateCW        ( ByRef B As Const Vec2   ) As Vec2
	Declare Const Function RotateCCW       ( ByRef B As Const Vec2   ) As Vec2
	
	Declare Const Function RotateCW        ( ByRef B As Const Single ) As Vec2
	Declare Const Function RotateCCW       ( ByRef B As Const Single ) As Vec2
	
	''  Vec2 variables
	As Single x, y
	
End Type

''  Vec2 unary arithmetic non-member operator declarations
Declare Operator - ( ByRef B As Const Vec2 ) As Vec2

''  Vec2 binary arithmetic non-member operator declarations
Declare Operator + ( ByRef A As Const Vec2  , ByRef B As Const Vec2   ) As Vec2
Declare Operator - ( ByRef A As Const Vec2  , ByRef B As Const Vec2   ) As Vec2
Declare Operator * ( ByVal A As Const Single, ByRef B As Const Vec2   ) As Vec2
Declare Operator * ( ByRef A As Const Vec2  , ByVal B As Const Single ) As Vec2
Declare Operator * ( ByRef A As Const Vec2  , ByRef B As Const Vec2   ) As Vec2
Declare Operator / ( ByRef A As Const Vec2  , ByVal B As Const Single ) As Vec2

''  Vec2 binary relational non-member operator declarations
Declare Operator =  ( ByRef A As Const Vec2, ByVal B As Const Vec2 ) As Integer
Declare Operator <> ( ByRef A As Const Vec2, ByVal B As Const Vec2 ) As Integer
Declare Operator <  ( ByRef A As Const Vec2, ByVal B As Const Vec2 ) As Integer
Declare Operator >  ( ByRef A As Const Vec2, ByVal B As Const Vec2 ) As Integer

''  Vec2 non-member function declarations
Declare Function Absolute OverLoad ( ByRef A As Const Vec2 ) As Vec2
Declare Function Unit              ( ByRef A As Const Vec2 ) As Vec2
Declare Function Length            ( ByRef A As Const Vec2 ) As Single
Declare Function LengthSquared     ( ByRef A As Const Vec2 ) As Single
Declare Function Dot      Overload ( ByRef A As Const Vec2  , ByRef B As Const Vec2   ) As Single
Declare Function Dot               ( ByRef A As Const Vec2  , ByVal B As Const Single ) As Vec2
Declare Function Dot               ( ByVal A As Const Single, ByRef B As Const Vec2   ) As Vec2
Declare Function PerpDot  OverLoad ( ByRef A As Const Vec2  , ByRef B As Const Vec2   ) As Single
Declare Function PerpDot           ( ByRef A As Const Vec2  , ByVal B As Const Single ) As Vec2
Declare Function PerpDot           ( ByVal A As Const Single, ByRef B As Const Vec2   ) As Vec2
Declare Function Project           ( ByRef A As Const Vec2  , ByRef B As Const Vec2   ) As Vec2
Declare Function Component         ( ByRef A As Const Vec2  , ByRef B As Const Vec2   ) As Vec2
Declare Function RandomizeCircle   ( ByRef A As Const Vec2  , ByVal B As Const Single ) As Vec2
Declare Function RandomizeSquare   ( ByRef A As Const Vec2  , ByVal B As Const Single ) As Vec2

Declare Function RotateCW  OverLoad ( ByRef A As Const Vec2, ByVal B As Const Single ) As Vec2
Declare Function RotateCCW OverLoad ( ByRef A As Const Vec2, ByVal B As Const Single ) As Vec2

Declare Function AngleToUnit       ( ByVal A As Const Single ) As Vec2
Declare Function UnitToAngle       ( ByRef A As Const Vec2 ) As Single


''  Vec2 constructors
Constructor Vec2()

  This.x = 0.0 : This.y = 0.0
  
End Constructor

Constructor Vec2( ByRef v As Const Vec2 )
	
	This = v
  
End Constructor

Constructor Vec2( ByVal x As Const Single, ByVal y As Const Single )

  This.x = x : This.y = y
  
End Constructor


'' Destructor
Destructor Vec2()

End Destructor


''
Operator Vec2.Let ( ByRef B As Const Vec2 )
	
	If ( @This <> @B ) Then
		
		This.x = B.x : This.y = B.y
		
	EndIf
	
End Operator


''  Vec2 compound arithmetic member operators
Operator Vec2.+= ( ByRef B As Const Vec2 )
	
	This.x += B.x : This.y += B.y
	
End Operator

Operator Vec2.-= ( ByRef B As Const Vec2 )
	
	This.x -= B.x : This.y -= B.y
	
End Operator

Operator Vec2.*= ( ByRef B As Const Vec2 )
	
	This.x *= B.x : This.y *= B.y
	
End Operator

Operator Vec2.*= ( ByVal B As Const Single )
	
	This.x *= B : This.y *= B
	
End Operator

Operator Vec2./= ( ByVal B As Const Single )
		
	This.x /= B : This.y /= B 
	
End Operator


''  Vec2 member functions
Function Vec2.Absolute() As Vec2
	
	Return Vec2( Abs( This.x ), Abs( This.y ) )
	
End Function

Function Vec2.PerpCW() As Vec2
	
	Return Vec2( This.y, -This.x )
	
End Function

Function Vec2.PerpCCW() As Vec2
	
	Return Vec2( -This.y, This.x )
	
End Function 

Function Vec2.Unit() As Vec2
	
	Return IIf( This <> Vec2(0.0, 0.0) , Vec2( This / This.Length() ) , Vec2(0.0, 0.0) )
	
End Function

Function Vec2.Length() As Single
	
	Dim As Single length_squared = This.LengthSquared()
	Return Sqr( length_squared )
	
	'Return Sqr( This.LengthSquared() )
	
End Function

Function Vec2.LengthSquared() As Single
	
	'Return This.Dot( This )
	Return ( This.x * This.x + This.y * This.y )
	
End Function

Function Vec2.Dot( ByVal B As Const Single  ) As Vec2
	
	Return Vec2( This.x * B, This.y * B )
	
End Function

Function Vec2.Dot( ByRef B As Const Vec2 ) As Single
	
	Return ( This.x * B.x + This.y * B.y )
	
End Function

Function Vec2.PerpDot( ByVal B As Const Single  ) As Vec2
	
	Return Vec2( -This.y * B, This.x * B )
	
End Function

Function Vec2.PerpDot( ByRef B As Const Vec2 ) As Single
	
	Return ( -This.y * B.x + This.x * B.y )
	'Return ( This.Dot( B.Perp() ) )
	
End Function

Function Vec2.Project( ByRef B As Const Vec2 ) As Vec2
	
	Return ( B.Dot( This ) / This.Dot( This ) ) * This
	
End Function

Function Vec2.Component( ByRef B As Const Vec2 ) As Vec2
	
	Return ( This.Dot( B ) / B.Dot( B ) ) * B
	
End Function

Function Vec2.RandomizeCircle( ByVal B As Const Single ) As Vec2
	
	Dim As Single a = Rnd() * 8.0 * Atn( 1.0 )
	Dim As Single r = Sqr( Rnd() * B * B )
	
	Return Vec2( Cos( a ), Sin( a ) ) * r 
	
End Function

Function Vec2.RandomizeSquare( ByVal B As Const Single ) As Vec2
	
	Return Vec2( ( Rnd() - Rnd() ) * B, ( Rnd() - Rnd() ) * B )
	
End Function

Function Vec2.RotateCW( ByRef B As Const Vec2 ) As Vec2
	
	Return Vec2( B.Dot( This ), B.PerpDot( This ) )
	
End Function

Function Vec2.RotateCCW( ByRef B As Const Vec2 ) As Vec2
	
	Dim As vec2 v = Vec2( B.x, -B.y )
	
	Return Vec2( v.Dot( This ), v.PerpDot( This ) )
	
	'Return Vec2( B.x * This.x - B.y * This.y , B.y * This.x + B.x * This.y )
	
	''perpccw = -y, x
	
End Function

Function Vec2.RotateCW( ByRef B As Const Single ) As Vec2
	
	Dim As Vec2 v = Vec2( Cos( B ), Sin( B ) )
	
	Return This.RotateCW( v )
	
End Function

Function Vec2.RotateCCW( ByRef B As Const Single ) As Vec2
	
	Dim As Vec2 v = Vec2( Cos( B ), Sin( B ) )
	
	Return This.RotateCCW( v )
	
End Function


''  Vec2 unary arithmetic non-member operators
Operator - ( ByRef B As Const Vec2 ) As Vec2
	
	Return Vec2( -B.x, -B.y )
	
End Operator


''  Vec2 binary arithmetic non-member operators
Operator + ( ByRef A As Const Vec2, ByRef B As Const Vec2 ) As Vec2
	
	Return Vec2( A.x + B.x, A.y + B.y )
	
End Operator

Operator - ( ByRef A As Const Vec2, ByRef B As Const Vec2 ) As Vec2
	
	Return Vec2( A.x - B.x, A.y - B.y )
	
End Operator

Operator * ( ByVal A As Const Single, ByRef B As Const Vec2 ) As Vec2
	
	Return Vec2( A * B.x, A * B.y)
	
End Operator

Operator * ( ByRef A As Const Vec2, ByVal B As Const Single ) As Vec2
	
	Return Vec2( A.x * B, A.y * B)
	
End Operator

Operator * ( ByRef A As Const Vec2, ByRef B As Const Vec2 ) As Vec2
	
	Return Vec2( A.x * B.x, A.y * B.y )
	
End Operator

Operator / ( ByRef A As Const Vec2, ByVal B As Const Single ) As Vec2
	
	Return Vec2( A.x / B, A.y / B )
	
End Operator


''  Vec2 binary relational non-member operators
Operator = ( ByRef A As Const Vec2, ByVal B As Const Vec2 ) As Integer
	
	Return ( A.x = B.x ) And ( A.y = B.y )
	
End Operator

Operator <> ( ByRef A As Const Vec2, ByVal B As Const Vec2 ) As Integer
	
	Return ( A.x <> B.x ) Or ( A.y <> B.y )
	
End Operator

Operator < ( ByRef A As Const Vec2, ByVal B As Const Vec2 ) As Integer
	
	Return ( A.x < B.x ) And ( A.y < B.y )
	
End Operator

Operator > ( ByRef A As Const Vec2, ByVal B As Const Vec2 ) As Integer
	
	Return ( A.x > B.x ) And ( A.y > B.y )
	
End Operator


''  Vec2 non-member functions
Function Absolute( ByRef A As Const Vec2 ) As Vec2
	
	Return A.Absolute()
	
End Function

Function Unit( ByRef A As Const Vec2 ) As Vec2
	
	Return A.Unit()
	
End Function

Function Length( ByRef A As Const Vec2 ) As Single
	
	Return A.Length()
	
End Function

Function LengthSquared( ByRef A As Const Vec2 ) As Single
	
	Return A.LengthSquared()
	
End Function

Function Dot( ByRef A As Const Vec2, ByRef B As Const Vec2 ) As Single
	
	Return A.Dot( B )
	
End Function

Function Dot( ByRef A As Const Vec2, ByVal B As Const Single ) As Vec2
	
	Return A.Dot( B )
	
End Function

Function Dot( ByVal A As Const Single, ByRef B As Const Vec2 ) As Vec2
	
	Return B.Dot( -A )
	
End Function

Function PerpDot( ByRef A As Const Vec2, ByRef B As Const Vec2 ) As Single
	
	Return A.PerpDot( B )
	
End Function

Function PerpDot( ByRef A As Const Vec2, ByVal B As Const Single ) As Vec2
	
	Return A.PerpDot( B )
	
End Function

Function PerpDot( ByVal A As Const Single, ByRef B As Const Vec2 ) As Vec2
	
	Return B.PerpDot( -A )
	
End Function

Function Project( ByRef A As Const Vec2, ByRef B As Const Vec2 ) As Vec2
	
	Return A.Project( B )
	
End Function

Function Component( ByRef A As Const Vec2, ByRef B As Const Vec2 ) As Vec2
	
	Return A.Component( B )
	
End Function

Function RandomizeCircle( ByRef A As Const Vec2, ByVal B As Const Single ) As Vec2
	
	Return A.RandomizeCircle( B )
	
End Function

Function RandomizeSquare( ByRef A As Const Vec2, ByVal B As Const Single ) As Vec2
	
	Return A.RandomizeSquare( B )
	
End Function

Function RotateCW( ByRef A As Const Vec2, ByVal B As Const Single ) As Vec2
	
	Return A.RotateCW( B )
	
End Function

Function RotateCCW( ByRef A As Const Vec2, ByVal B As Const Single ) As Vec2
	
	Return A.RotateCCW( B )
	
End Function

Function AngleToUnit( ByVal A As Const Single ) As Vec2
	
	Return Vec2( Cos( A ), Sin( A ) )
	
End Function

Function UnitToAngle( ByRef A As Const Vec2 ) As Single
	
	Return ATan2( A.y, A.x )
	
End Function


#EndIf ''__VEC2_BI__
