''*******************************************************************************
''     
''   Freebasic 2d floating point and integer vector library
''   version 0.9.0, january 2013, Michael "h4tt3n" Nissen, jernmager@yahoo.dk
''   Integer vectors have been added for screen and mouse operations.   
''   
''   function syntax:
''   
''   (return type) (function name) (argument type (, ...) (description))
''     
''   Floating point vector function list:
''   
''   vector  absolute           (vector)                  absolute value
''   vector  normal             (vector)                  normal vector
''   vector  rightnormal        (vector)                  right hand normal vector
''   vector  leftnormal         (vector)                  left hand normal vector
''   vector  normalized         (vector)                  normalized vector
''   scalar  magnitude          (vector)                  magnitude
''   scalar  magnitudeSquared   (vector)                  magnitude squared
''   scalar  dot                (vector, vector)          dot product
''   scalar  perpdot            (vector, vector)          "2D cross product"
''   vector  project            (vector, vector)          vector projection
''   vector  component          (vector, vector)          vector component
''   vector  randomizeSquare    (scalar)                  randomise in range +/- value
''   vector  randomizeCircle    (scalar)                  randomise in range +/- value
''   vector  lerp               (vector, vector, scalar)  linear interpolation
''   vector  rotate             (vector, vector)          rotates vector 
''   vector  rotate             (vector, scalar)          rotates vector 
''   
''   Integer vector function list:
''   
''   
''   function useage, member and non-member style:
''   
''   vector_a.function( vector_b ),  function( vector_a, vector_b )
''   
''   
''*******************************************************************************

'#Include Once "constants.bi"


''	Type forward declarations
Type Vec2fFwd As Vec2f
Type Vec2iFwd As Vec2i
Type FloatFwd As Float



''  Vec2f vector class
Type Vec2f
  
  Public:
  
  ''  Vec2f constructor declarations
  Declare Constructor ()
  Declare Constructor (ByVal x As Float = 0.0, ByVal y As Float = 0.0)
  Declare Constructor (ByRef vec As Vec2fFwd)
  Declare Constructor (ByRef vec As Vec2iFwd)
  
  ''  Vec2f compound arithmetic member operator declarations
  Declare Operator +=  (ByRef rhs As Vec2fFwd)
  Declare Operator -=  (ByRef rhs As Vec2fFwd)
  Declare Operator *=  (ByRef rhs As Vec2fFwd)
  Declare Operator *=  (ByRef rhs As FloatFwd)
  Declare Operator /=  (ByRef rhs As FloatFwd)
  Declare Operator Let (ByRef rhs As Vec2fFwd)
  
  ''  Vec2f member function declarations
  Declare Function absolute() As Vec2f
  Declare Function normal() As Vec2f
  Declare Function rightnormal() As Vec2f
  Declare Function leftnormal() As Vec2f
  Declare Function normalized() As Vec2f
  Declare Function magnitude() As Float
  Declare Function magnitudeSquared() As Float
  Declare Function dot(ByRef rhs As Vec2f) As Float
  Declare Function perpdot(ByRef rhs As Vec2f) As Float
  Declare Function cross(ByRef rhs As Vec2f) As Float
  Declare Function project(ByRef rhs As Vec2f) As Vec2f
  Declare Function component(ByRef rhs As Vec2f) As Vec2f
  Declare Function randomizeCircle(ByVal rhs As Float) As Vec2f
  Declare Function randomizeSquare(ByVal rhs As Float) As Vec2f
  Declare Function lerp(ByRef rhs As Vec2f, ByVal i As Float) As Vec2f
  Declare Function rotate(ByRef rhs As Vec2f) As Vec2f
  Declare Function rotate(ByRef rhs As Float) As Vec2f
  
  ''  Vec2f variables
  As FloatFwd x, y
  
  Private:
  
End Type


''  Vec2i Integer vector class
Type Vec2i
  
  Public:
  
  ''  Vec2i constructor declarations
  Declare Constructor ()
  Declare Constructor (ByVal x As Integer, ByVal y As Integer)
  Declare Constructor (ByRef vec As Vec2i)
  Declare Constructor (ByRef vec As Vec2f)
  
  ''  Vec2i compound arithmetic member operator declarations
  Declare Operator += (ByRef rhs As Vec2i)
  Declare Operator -= (ByRef rhs As Vec2i)
  Declare Operator *= (ByRef rhs As Vec2i)
  Declare Operator *= (ByVal rhs As Integer)
  Declare Operator \= (ByVal rhs As Integer)
  Declare Operator Let (ByRef rhs As Vec2i)
  
  ''  Vec2i member function declarations
  
  ''  Vec2i variables
  As Integer x, y
  
  Private:
  
End Type


''  Vec2f unary arithmetic non-member operator declarations
Declare Operator - (ByRef rhs As Vec2fFwd) As Vec2fFwd


''  Vec2f binary arithmetic non-member operator declarations
Declare Operator + (ByRef lhs As Vec2fFwd, ByRef rhs As Vec2fFwd) As Vec2fFwd
Declare Operator - (ByRef lhs As Vec2fFwd, ByRef rhs As Vec2fFwd) As Vec2fFwd
Declare Operator * (ByVal lhs As FloatFwd, ByRef rhs As Vec2fFwd) As Vec2fFwd
Declare Operator * (ByRef lhs As Vec2fFwd, ByVal rhs As FloatFwd) As Vec2fFwd
Declare Operator * (ByRef lhs As Vec2fFwd, ByVal rhs As Vec2fFwd) As Vec2fFwd
Declare Operator / (ByRef lhs As Vec2fFwd, ByVal rhs As FloatFwd) As Vec2fFwd


''  Vec2f binary relational non-member operator declarations
Declare Operator =  (ByRef lhs As Vec2fFwd, ByVal rhs As Vec2fFwd) As Integer
Declare Operator <> (ByRef lhs As Vec2fFwd, ByVal rhs As Vec2fFwd) As Integer


''  Vec2f non-member function declarations
Declare Function absolute         (ByRef lhs As Vec2fFwd) As Vec2fFwd
Declare Function normal           (ByRef lhs As Vec2fFwd) As Vec2fFwd
Declare Function rightnormal      (ByRef lhs As Vec2fFwd) As Vec2fFwd
Declare Function leftnormal       (ByRef lhs As Vec2fFwd) As Vec2fFwd
Declare Function normalized       (ByRef lhs As Vec2fFwd) As Vec2fFwd
Declare Function magnitude        (ByRef lhs As Vec2fFwd) As FloatFwd
Declare Function magnitudeSquared (ByRef lhs As Vec2fFwd) As FloatFwd
Declare Function dot              (ByVal lhs As Vec2fFwd, ByRef rhs As Vec2fFwd) As FloatFwd
Declare Function cross            (ByVal lhs As Vec2fFwd, ByRef rhs As Vec2fFwd) As FloatFwd
Declare Function project          (ByVal lhs As Vec2fFwd, ByRef rhs As Vec2fFwd) As Vec2fFwd
Declare Function component        (ByVal lhs As Vec2fFwd, ByRef rhs As Vec2fFwd) As Vec2fFwd
Declare Function randomizeSquare  (ByVal lhs As FloatFwd) As Vec2fFwd
Declare Function lerp             (ByVal lhs As Vec2fFwd, ByRef rhs As Vec2fFwd, ByVal i As FloatFwd) As Vec2fFwd
Declare Function rotate           (ByVal lhs As Vec2fFwd, ByRef rhs As Vec2fFwd) As Vec2fFwd


''  Vec2f constructors
Constructor Vec2fFwd()

  This.x = 0.0
  This.y = 0.0
  
End Constructor

Constructor Vec2fFwd(ByVal x As FloatFwd, ByVal y As FloatFwd)

  This.x = x
  This.y = y
  
End Constructor

Constructor Vec2fFwd(ByRef vec As Vec2fFwd)
	
	This = vec
  
End Constructor

Constructor Vec2fFwd(ByRef vec As Vec2iFwd )
	
  This.x = Cast( FloatFwd, vec.x )
  This.y = Cast( FloatFwd, vec.y )
  
End Constructor


''  Vec2f compound arithmetic member operators
Operator Vec2fFwd.+= (ByRef rhs As Vec2fFwd)
	
	This.x += rhs.x
	This.y += rhs.y
	
End Operator

Operator Vec2fFwd.-= (ByRef rhs As Vec2fFwd)
	
	This.x -= rhs.x
	This.y -= rhs.y
	
End Operator

Operator Vec2fFwd.*= (ByRef rhs As Vec2fFwd)
	
	This.x *= rhs.x
	This.y *= rhs.y
	
End Operator

Operator Vec2fFwd.*= (ByRef rhs As FloatFwd)
	
	This.x *= rhs
	This.y *= rhs
	
End Operator

Operator Vec2fFwd./= (ByRef rhs As FloatFwd)
	
	This.x /= rhs
	This.y /= rhs 
	
End Operator

Operator Vec2fFwd.Let (ByRef rhs As Vec2fFwd)
	
	This.x = rhs.x
	This.y = rhs.y
	
End Operator


''  Vec2f member functions
Function Vec2fFwd.absolute() As Vec2fFwd
	
	Return Vec2fFwd ( Abs (This.x), Abs (This.y) )
	
End Function

Function Vec2fFwd.normal() As Vec2fFwd
	
	Return Vec2fFwd ( This.y, -This.x )
	
End Function 

Function Vec2fFwd.rightnormal() As Vec2fFwd
	
	Return This.normal()
	
End Function 

Function Vec2fFwd.leftnormal() As Vec2fFwd
	
	Return -This.normal()
	
End Function

Function Vec2fFwd.normalized() As Vec2fFwd
	
	Return IIf( This = Vec2fFwd(0.0, 0.0) , Vec2fFwd(0.0, 0.0) , This / This.magnitude() )
	
End Function

Function Vec2fFwd.magnitude() As FloatFwd
	
	Return Sqr ( This.magnitudeSquared() )
	
End Function

Function Vec2fFwd.magnitudeSquared() As FloatFwd
	
	Return This.dot( This )
	
End Function

Function Vec2fFwd.dot(ByRef rhs As Vec2fFwd) As FloatFwd
	
	Return ( This.x * rhs.x + This.y * rhs.y )
	
End Function

Function Vec2fFwd.perpdot(ByRef rhs As Vec2fFwd) As FloatFwd
	
	Return This.dot( rhs.normal() )
	
End Function

Function Vec2fFwd.cross(ByRef rhs As Vec2fFwd) As FloatFwd
	
	Return This.dot( rhs.normal() )
	
End Function

Function Vec2fFwd.project(ByRef rhs As Vec2fFwd) As Vec2fFwd
	
	Return ( This.dot( rhs ) / This.magnitudeSquared ) * This
	
End Function

Function Vec2fFwd.component(ByRef rhs As Vec2fFwd) As Vec2fFwd
	
	Return ( This.dot( rhs ) / rhs.magnitudeSquared ) * rhs
	
End Function

Function Vec2fFwd.randomizeCircle(ByVal rhs As FloatFwd) As Vec2fFwd
	
	Dim As FloatFwd angle    = Rnd() * TWO_PI
	Dim As FloatFwd distance = Sqr( Rnd() * rhs * rhs )
	
	Return Vec2fFwd( Cos( angle ) * distance, Sin( angle ) * distance )
	
End Function

Function Vec2fFwd.randomizeSquare(ByVal rhs As FloatFwd) As Vec2fFwd
	
	Return Vec2fFwd( ( Rnd - Rnd ) * rhs, ( Rnd - Rnd ) * rhs )
	
End Function

Function Vec2fFwd.lerp(ByRef rhs As Vec2fFwd, ByVal i As FloatFwd) As Vec2fFwd
	
	Return This + ( rhs - This ) * i
	
End Function

Function Vec2fFwd.rotate(ByRef rhs As Vec2fFwd) As Vec2fFwd
	
	Return Vec2fFwd( rhs.dot( This ), rhs.perpdot( This ) )
	
End Function


''  Vec2f unary arithmetic non-member operators
Operator - (ByRef rhs As Vec2fFwd) As Vec2fFwd
	
	Return Vec2fFwd( -rhs.x, -rhs.y )
	
End Operator


''  Vec2f binary arithmetic non-member operators
Operator + (ByRef lhs As Vec2fFwd, ByRef rhs As Vec2fFwd) As Vec2fFwd
	
	Return Vec2fFwd( lhs.x + rhs.x, lhs.y + rhs.y )
	
End Operator

Operator - (ByRef lhs As Vec2fFwd, ByRef rhs As Vec2fFwd) As Vec2fFwd
	
	Return Vec2fFwd( lhs.x - rhs.x, lhs.y - rhs.y )
	
End Operator

Operator * (ByVal lhs As FloatFwd, ByRef rhs As Vec2fFwd) As Vec2fFwd
	
	Return Vec2fFwd( lhs * rhs.x, lhs * rhs.y)
	
End Operator

Operator * (ByRef lhs As Vec2fFwd, ByVal rhs As FloatFwd) As Vec2fFwd
	
	Return Vec2fFwd( lhs.x * rhs, lhs.y * rhs)
	
End Operator

Operator * (ByRef lhs As Vec2fFwd, ByVal rhs As Vec2fFwd) As Vec2fFwd
	
	Return Vec2fFwd( lhs.x * rhs.x, lhs.y * rhs.y )
	
End Operator

Operator / (ByRef lhs As Vec2fFwd, ByVal rhs As FloatFwd) As Vec2fFwd
	
	Return Vec2fFwd( lhs.x / rhs, lhs.y / rhs )
	
End Operator


''  Vec2f binary relational non-member operators
Operator = (ByRef lhs As Vec2fFwd, ByVal rhs As Vec2fFwd) As Integer
	
	Return ( lhs.x = rhs.x ) And ( lhs.y = rhs.y )
	
End Operator

Operator <> (ByRef lhs As Vec2fFwd, ByVal rhs As Vec2fFwd) As Integer
	
	Return ( lhs.x <> rhs.x ) Or ( lhs.y <> rhs.y )
	
End Operator


''  Vec2f non-member functions
Function absolute (ByRef lhs As Vec2fFwd) As Vec2fFwd
	
	Return lhs.absolute()
	
End Function

Function normal (ByRef lhs As Vec2fFwd) As Vec2fFwd
	
	Return lhs.normal()
	
End Function

Function rightnormal (ByRef lhs As Vec2fFwd) As Vec2fFwd
	
	Return lhs.rightnormal()
	
End Function

Function leftnormal (ByRef lhs As Vec2fFwd) As Vec2fFwd
	
	Return lhs.leftnormal()
	
End Function

Function normalized (ByRef lhs As Vec2fFwd) As Vec2fFwd
	
	Return lhs.normalized()
	
End Function

Function magnitude (ByRef lhs As Vec2fFwd) As FloatFwd
	
	Return lhs.magnitude()
	
End Function

Function magnitudeSquared (ByRef lhs As Vec2fFwd) As FloatFwd
	
	Return lhs.magnitudeSquared()
	
End Function

Function dot (ByVal lhs As Vec2fFwd, ByRef rhs As Vec2fFwd) As FloatFwd
	
	Return lhs.dot(rhs)
	
End Function

Function cross (ByVal lhs As Vec2fFwd, ByRef rhs As Vec2fFwd) As FloatFwd
	
	Return lhs.cross(rhs)
	
End Function

Function project (ByVal lhs As Vec2fFwd, ByRef rhs As Vec2fFwd) As Vec2fFwd
	
	Return lhs.project(rhs)
	
End Function

Function component(ByVal lhs As Vec2fFwd, ByRef rhs As Vec2fFwd) As Vec2fFwd
	
	Return lhs.component(rhs)
	
End Function

Function randomizeSquare(ByVal lhs As FloatFwd) As Vec2fFwd
	
	Return Vec2fFwd( ( Rnd - Rnd ) * lhs, ( Rnd - Rnd) * lhs ) '' <--- ?!?
	'Return This.randomise(lhs)
	
End Function

Function lerp(ByVal lhs As Vec2fFwd, ByRef rhs As Vec2fFwd, ByVal i As FloatFwd) As Vec2fFwd
	
	Return lhs.lerp( rhs, i )
	
End Function

Function rotate(ByVal lhs As Vec2fFwd, ByRef rhs As Vec2fFwd) As Vec2fFwd
	
	Return lhs.rotate(rhs)
	
End Function


''  Vec2i unary arithmetic non-member operator declarations
Declare Operator - (ByRef rhs As Vec2iFwd) As  Vec2iFwd


''  Vec2i binary arithmetic non-member operator declarations
Declare Operator + (ByRef lhs As Vec2iFwd, ByRef rhs As Vec2iFwd) As Vec2iFwd
Declare Operator - (ByRef lhs As Vec2iFwd, ByRef rhs As Vec2iFwd) As Vec2iFwd
Declare Operator * (ByVal lhs As FloatFwd, ByRef rhs As Vec2iFwd) As Vec2iFwd
Declare Operator * (ByRef lhs As Vec2iFwd, ByVal rhs As FloatFwd) As Vec2iFwd
Declare Operator \ (ByRef lhs As Vec2iFwd, ByVal rhs As FloatFwd) As Vec2iFwd


''  Vec2i non-member function declarations



''  Vec2i constructors
Constructor Vec2iFwd()
	
	This.x = 0
	This.y = 0
	
End Constructor

Constructor Vec2iFwd(ByVal x As Integer, ByVal y As Integer)
	
	This.x = x
	This.y = y
	
End Constructor

Constructor Vec2iFwd(ByRef vec As Vec2iFwd)
	
	This.x = vec.x
	This.y = vec.y
	
End Constructor

Constructor Vec2iFwd(ByRef vec As Vec2fFwd)
	
	This.x = Cast( Integer, vec.x )
	This.y = Cast( Integer, vec.y )
	
End Constructor


''  Vec2i compound arithmetic member operators
Operator Vec2iFwd.+= (ByRef rhs As  Vec2iFwd)
	
	This.x += rhs.x
	This.y += rhs.y
	
End Operator

Operator Vec2iFwd.-= (ByRef rhs As  Vec2iFwd)
	
	This.x -= rhs.x
	This.y -= rhs.y
	
End Operator

Operator Vec2iFwd.*= (ByRef rhs As  Vec2iFwd)
	
	This.x *= rhs.x
	This.y *= rhs.y
	
End Operator

Operator Vec2iFwd.*= (ByVal rhs As  Integer)
	
	This.x *= rhs
	This.y *= rhs
	
End Operator

Operator Vec2iFwd.\= (ByVal rhs As  Integer)
	
	This.x \= rhs
	This.y \= rhs
	
End Operator

Operator Vec2iFwd.let (ByRef rhs As  Vec2iFwd)
	
	This.x = rhs.x
	This.y = rhs.y
	
End Operator


''  Vec2i member functions



''  Vec2i unary arithmetic non-member operators
Operator - (ByRef rhs As Vec2iFwd) As Vec2iFwd
	
	Return Vec2iFwd( -rhs.x, -rhs.y )
	
End Operator


''  Vec2i binary arithmetic non-member operators
Operator + (ByRef lhs As Vec2iFwd, ByRef rhs As Vec2iFwd) As Vec2iFwd
	
	Return Vec2iFwd( lhs.x + rhs.x, lhs.y + rhs.y )
	
End Operator

Operator - (ByRef lhs As Vec2iFwd, ByRef rhs As Vec2iFwd) As Vec2iFwd
	
	Return Vec2iFwd( lhs.x - rhs.x, lhs.y - rhs.y )
	
End Operator

Operator * (ByVal lhs As Integer, ByRef rhs As Vec2iFwd) As Vec2iFwd
	
	Return Vec2iFwd( lhs * rhs.x, lhs * rhs.y )
	
End Operator

Operator * (ByRef lhs As Vec2iFwd, ByVal rhs As Integer) As Vec2iFwd
	
	Return Vec2iFwd( lhs.x * rhs, lhs.y * rhs )
	
End Operator

Operator \ (ByRef lhs As Vec2iFwd, ByVal rhs As Integer) As Vec2iFwd
	
	Return Vec2iFwd( lhs.x \ rhs, lhs.y \ rhs )
	
End Operator


''  Vec2i non-member functions



''  shared binary arithmetic non-member operator declarations
Declare Operator + (ByRef lhs As Vec2fFwd, ByRef rhs As Vec2iFwd) As Vec2fFwd
Declare Operator + (ByRef lhs As Vec2iFwd, ByRef rhs As Vec2fFwd) As Vec2fFwd
Declare Operator - (ByRef lhs As Vec2fFwd, ByRef rhs As Vec2iFwd) As Vec2fFwd
Declare Operator - (ByRef lhs As Vec2iFwd, ByRef rhs As Vec2fFwd) As Vec2fFwd


''  shared non-member function declarations



''  shared binary arithmetic non-member operators
Operator + (ByRef lhs As Vec2fFwd, ByRef rhs As Vec2iFwd) As Vec2fFwd
	
	Return Vec2fFwd( lhs.x + rhs.x, lhs.y + rhs.y )
	
End Operator

Operator + (ByRef lhs As Vec2iFwd, ByRef rhs As Vec2fFwd) As Vec2fFwd
	
	Return Vec2fFwd( lhs.x + rhs.x, lhs.y + rhs.y )
	
End Operator

Operator - (ByRef lhs As Vec2fFwd, ByRef rhs As Vec2iFwd) As Vec2fFwd
	
	Return Vec2fFwd( lhs.x - rhs.x, lhs.y - rhs.y )
	
End Operator

Operator - (ByRef lhs As Vec2iFwd, ByRef rhs As Vec2fFwd) As Vec2fFwd
	
	Return Vec2fFwd( lhs.x - rhs.x, lhs.y - rhs.y )
	
End Operator


''  shared non-member functions

