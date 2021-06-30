'*******************************************************************************
'
'   FreeBasic 2D floating point Vector Library
'   version 0.4b - march 2009
'   Michael "h4tt3n" Nissen, jernmager@yahoo.dk
'   
'   Function syntax: 
'   
'   function name (argument type (, ...)) return type
'
'   randomise (scalar) vector                 - random number in the range +/- value
'   randomise (scalar, scalar) vector         - random number in the range +/- for each value 
'   absolute (vector) vector                 	- absolute value of vector
'   sign (vector) vector                			- Sign of vector. Returns -1, 0, or 1
'   magnitude (vector) scalar                 - vector magnitude from origin (0, 0)
'   magnitudesquared (vector) scalar          - vector magnitude from origin (0, 0) squared
'   distance (vector, vector) Scalar         	- distance between two vectors
'   distancesquared (vector, vector) Scalar		- distance between two vectors squared
'   normalised (vector) vector                - unit vector / normalised vector / "hat" vector
'   dot (vector, vector) scalar         			- scalar product / inner product / "dot" product
'   normal (vector) vector                 		- perpendicular / tangential / normal vector
'   normalisednormal (vector) vector          - unit normal vector
'   dotnormal (vector, vector) scalar					- dot product of vector normal
'   
'
'*******************************************************************************


'*******************************************************************************
'   TYPES, CONSTRUCTOR DECLARATIONS, LOCAL OPERATOR DECLARATIONS
'*******************************************************************************

''  Miscellaneous scalar variable types
type float 		as single
type sca_bte	As byte

''  2D floating point vector type
type vec2f

	''	variables
  as float x, y
  
  ''  Constructor declarations
  declare constructor ()
  declare constructor (byval X as float = 0.0f, byval Y as float = 0.0f)
  
  ''  Assignment operator declarations
  declare operator += (byval s1 as float)
  declare operator += (byref v1 as vec2f) 
  declare operator -= (byval s1 as float)
  declare operator -= (byref v1 as vec2f) 
  declare operator *= (byval s1 as float)
  declare operator /= (byval s1 as float)
  declare operator \= (byval s1 as float)
  declare operator let (byval s1 as float)
  
  ''  Member Function declarations
  declare function magnitude() as float
  declare function magnitudesquared() as float
  declare function normalised() as vec2f
  declare function normal() as vec2f
  declare function normalisednormal() as vec2f
  declare function dot(byref v1 as vec2f) as float
  declare function dotnormal(byref v1 as vec2f) as float
  
end type


'*******************************************************************************
'   GLOBAL 2D FLOATING POINT VECTOR OPERATOR DECLARATIONS
'******************************************************************************* 

''  Unary operators
declare operator - (byref v1 as vec2f) as vec2f

''  Binary operators
declare operator + (byref v1 as vec2f, byref v2 as vec2f) as vec2f
declare operator - (byref v1 as vec2f, byref v2 as vec2f) as vec2f
declare operator * (byref v1 as vec2f, byval s1 as float) as vec2f
declare operator * (byval s1 as float, byref v1 as vec2f) as vec2f
declare operator * (byref v1 as vec2f, byref v2 as vec2f) as vec2f
declare operator / (byref v1 as vec2f, byval s1 as float) as vec2f
declare operator \ (byref v1 as vec2f, byval s1 as float) as vec2f

''  Relational operators
declare operator = (byref v1 as vec2f, byref v2 as vec2f) as Sca_Bte
declare operator <> (byref v1 as vec2f, byref v2 as vec2f) as Sca_Bte


'*******************************************************************************
'   2D FLOATING POINT VECTOR FUNCTION DECLARATIONS
'******************************************************************************* 

declare function randomise overload (s1 as float) as vec2f
declare function randomise (s1 as float, s2 as float) as vec2f
declare function absolute (v1 as vec2f) as vec2f
declare function sign (v1 as vec2f) as vec2f
declare function magnitude (v1 as vec2f) as float
declare function magnitudesquared (v1 as vec2f) as float
declare function distance (v1 as vec2f, v2 as vec2f) as float
declare function distancesquared (v1 as vec2f, v2 as vec2f) as float
declare function normalised (v1 as vec2f) as vec2f
declare function normal (v1 as vec2f) as vec2f
declare function normalisednormal (v1 as vec2f) as vec2f
declare function dot (v1 as vec2f, v2 as vec2f) as float
declare function dotnormal (v1 as vec2f, v2 as vec2f) as float


'*******************************************************************************
'   2D FLOATING POINT VECTOR CONSTRUCTORS
'*******************************************************************************

constructor vec2f (byval x as float, byval y as float)
  this.x = x
  this.y = y
end constructor

'*******************************************************************************
'   2D FLOATING POINT VECTOR LOCAL OPERATORS
'*******************************************************************************

operator vec2f.+= (byval s1 as float)
  this.x += s1
  this.y += s1
end operator

operator vec2f.+= (byref v1 as vec2f)
  this.x += v1.x
  this.y += v1.y
end operator

operator vec2f.-= (byval s1 as float)
  this.x -= s1
  this.y -= s1
end operator

operator vec2f.-= (byref v1 as vec2f)
  this.x -= v1.x
  this.y -= v1.y
end operator

operator vec2f.*= (byval s1 as float)
  this.x *= s1
  this.y *= s1
end operator

operator vec2f./= (byval s1 as float)
  this.x /= s1
  this.y /= s1
end operator

operator vec2f.\= (byval s1 as float)
  this.x \= s1
  this.y \= s1
end operator

operator vec2f.Let (byval s1 as float)
  this.x = s1
  this.y = s1
end operator


'*******************************************************************************
'   2D FLOATING POINT VECTOR FUNCTIONS
'*******************************************************************************

function vec2f.magnitude() as float
  return sqr(magnitudesquared)
end function

function vec2f.magnitudesquared() as float
  return dot(This)
end function

function vec2f.normal() as vec2f
  return vec2f(this.y, -this.x)
end function

function vec2f.normalised() as vec2f
	return This/magnitude
end function

function vec2f.normalisednormal() as vec2f
	return normal/magnitude
end function

function vec2f.dot(byref v1 as vec2f) as float
	return this.x*v1.x+this.y*v1.y
end function

function vec2f.dotnormal(byref v1 as vec2f) as float
	return dot(v1.normal)
end function


'*******************************************************************************
'   2D FLOATING POINT VECTOR GLOBAL OPERATORS
'*******************************************************************************

''  Unary operators
operator - (byref v1 as vec2f) as vec2f
  return vec2f(-v1.x, -v1.y)
end operator


''  Binary operators
operator - (byref v1 as vec2f, byref v2 as vec2f) as vec2f
  return vec2f(v1.x-v2.x, v1.y-v2.y)
end operator

operator + (byref v1 as vec2f, byref v2 as vec2f) as vec2f
  return vec2f(v1.x+v2.x, v1.y+v2.y)
end operator

operator * (byref v1 as vec2f, byval s1 as float) as vec2f
  return vec2f(v1.x*s1, v1.y*s1)
end operator

operator * (byval s1 as float, byref v1 as vec2f) as vec2f
  return vec2f(s1*v1.x, s1*v1.y)
end operator

operator * (byref v1 as vec2f, byref v2 as vec2f) as vec2f
  return vec2f(v1.x*v2.x, v1.y*v2.y)
end operator

operator / (byref v1 as vec2f, byval s1 as float) as vec2f
  return vec2f(v1.x/s1, v1.y/s1)
end operator

operator \ (byref v1 as vec2f, byval s1 as float) as vec2f
  return vec2f(v1.x\s1, v1.y\s1)
end operator


''  Relational operators
operator = (byref v1 as vec2f, byref v2 as vec2f) as Sca_Bte
  return (v1.x = v2.x) and (v1.y = v2.y)
end operator

operator <> (byref v1 as vec2f, byref v2 as vec2f) as Sca_Bte
  return (v1.x <> v2.x) or (v1.y <> v2.y)
end operator


'*******************************************************************************
'   2D FLOATING POINT VECTOR FUNCTIONS
'*******************************************************************************

function randomise (s1 as float) as vec2f
  return vec2f((rnd-rnd)*s1, (rnd-rnd)*s1)
end function

function randomise (s1 as float, s2 as float) as vec2f
  return vec2f((rnd-rnd)*s1, (rnd-rnd)*s2)
end function

function absolute (v1 as vec2f) as vec2f
  return vec2f(abs(v1.x), abs(v1.y))
end function

function sign (v1 as vec2f) as vec2f
  return vec2f(sgn(v1.x), sgn(v1.y))
end function

function magnitude (v1 as vec2f) as float
  return sqr(magnitudesquared(v1))
end function

function magnitudesquared (v1 as vec2f) as float
  return dot(v1, v1)
end function

function distance (v1 as vec2f, v2 as vec2f) as float
  return magnitude(v2-v1)
end function

function distancesquared (v1 as vec2f, v2 as vec2f) as float
  return magnitudesquared(v2-v1)
end function

function normalised (v1 as vec2f) as vec2f
  return v1/magnitude(v1)
end function

function normal (v1 as vec2f) as vec2f
  return vec2f(v1.y, -v1.x)
end function

function normalisednormal (v1 as vec2f) as vec2f
  return normalisednormal(v1)
end function

function dot (v1 as vec2f, v2 as vec2f) as float
  return v1.dot(v2)
end function

function dotnormal (v1 as vec2f, v2 as vec2f) as float
  return v1.dotnormal(v2)
end function
