'*******************************************************************************
'
'   FreeBasic 2D Vector Library
'   version 0.3b - september 2008
'   Michael "h4tt3n" Nissen, jernmager@yahoo.dk
'   
'   This library allows you to use most operators directly on 2d vectors 
'   in combination with scalars. It supports both floating point and integer 2D 
'   vectors, since the latter is often used for mouse and screen operations. 
'   The following operators are supported:
'   
'   
'   Unary operators:
'   
'   -   (negation)
'   
'   
'   Binary operators:
'   
'   +   (add)
'   -   (subtract)
'   *   (multiplicate)
'   /   (divide)
'   \   (integer divide)
'   
'   
'   Assignment operators:
'    
'   =   (assign (let))
'   +=  (add and assign)
'   -=  (subtract and assign)
'   *=  (multiplicate and assign)
'   /=  (divide and assign)
'   \=  (integer divide and assign)
'
'
'   Relational operators:
'
'   =   (equal)
'   <>  (not equal)
'   
'   
'   In addition, this vector library comes with a large number of 2d vector re- 
'   lated functions, which are described in the following.
'   
'
'   Function syntax: 
'   
'   function name (argument type [, ...]) return type
'   
'   
'   2d functions:
'
'   Vec_Set (scalar, scalar) vector                     - set vector values
'   Vec_Rnd (scalar) vector                             - random number in the range +/- value
'   Vec_Rnd (scalar, scalar) vector                     - random number in the range +/- for each value 
'   Vec_Abs (vector) vector                             - absolute value of vector
'   Vec_Sgn (vector) vector                             - Sign of vector. Returns -1, 0, or 1
'   Vec_Mag (vector) scalar                             - vector magnitude from origin (0, 0)
'   Vec_Mag_Sqa (vector) scalar                         - vector magnitude from origin (0, 0) squared
'   Vec_Mag_Cub (vector) scalar                         - vector magnitude from origin (0, 0) cubed
'   Vec_Dst (vector, vector) Scalar                     - distance between two vectors
'   Vec_Dst_Sqa (vector, vector) Scalar                 - distance between two vectors squared
'   Vec_Dst_Cub (vector, vector) Scalar                 - distance between two vectors cubed
'   Vec_Hat (vector) vector                             - unit vector / normalized vector / "hat" vector
'   Vec_Dot (vector, vector) scalar                     - scalar product / inner product / "dot" product
'	  Vec_Crs (vector, vector, vector) scalar				 		  - 2d cross product, returns a scalar
'   Vec_Ang (vector, vector) scalar                     - angle between vectors in radians
'   Vec_Cos_Ang (vector, vector) scalar                 - cosine of angle between vectors in radians
'   Vec_Sin_Ang (vector, vector) scalar                 - sine of angle between vectors in radians
'   Vec_Pro (vector, vector) scalar                     - scalar projection of vector 1 onto vector 2
'   Vec_Com (vector, vector) vector                     - vector component of vector 1 in vector 2's direction
'   Vec_Rot (vector, cos[angle], sin[angle]) vector     - rotate vector around origin (0, 0)
'   Vec_Nor (vector) vector                             - perpendicular / tangential / normal vector
'   Vec_Nor_Lft (vector) vector                         - normal vector pointing to the left, same as Vec_Nor
'   Vec_Nor_Rgt (vector) vector                         - normal vector pointing to the right, same as -Vec_Nor
'   Vec_Nor_Hat (vector) vector                         - unit normal vector
'   Vec_Nor_Dot (vector, vector) scalar                 - dot product of vector normal
'   Vec_Nor_Pro (vector, vector) scalar                 - scalar projection of vector 1 on vector 2 normal
'   Vec_Nor_Com (vector, vector) vector                 - vector component of vector 1 in vector 2's normal direction
'   Vec_Int_Boo (vector, vector, vector, vector) scalar - line section intersection, returns boolean
'   Vec_Int_Pos (vector, vector, vector, vector) vector - line section intersection, returns intersection vector
'   Vec_Pnt_Lin (vector, vector, vector) vector         - closest point on line section
'   Vec_Pnt_Pln (vector, vector, vector) vector         - closest point on line / plane
'   Vec_Pnt_Tri (vector, vector, vector, vector) scalar - check if point is inside triangle, returns boolean
'   Vec_Pnt_Lft (vector, vector, vector) scalar		  	  - check if point is to the left of line section
'   
'
'*******************************************************************************


'*******************************************************************************
'   TYPES, CONSTRUCTOR DECLARATIONS, LOCAL OPERATOR DECLARATIONS
'*******************************************************************************

''  Miscellaneous scalar variable types
type Sca_Bte as byte
type Sca_Ubt as ubyte
type Sca_Shr as short
type Sca_Ush as ushort
type Sca_Int as integer
type Sca_Uin as uinteger
type Sca_Lng as long
type Sca_Uln as ulong
type Sca_Lgi as longint
type Sca_Ulg as ulongint
type Sca_Flt as single
type Sca_Dbl as double

''  2D integer vector type (for mouse and screen operations)
type Vec_2DI
  as Sca_Int X, Y
  declare constructor (byval X as Sca_Int, byval Y as Sca_Int)
  declare constructor (byval s1 as Sca_Int = 0)
  
  ''  Assignment operators
  declare operator += (byval s1 as Sca_Int)
  declare operator += (byref v1 as Vec_2DI) 
  declare operator -= (byval s1 as Sca_Int)
  declare operator -= (byref v1 as Vec_2DI) 
  declare operator *= (byval s1 as Sca_Int)
  declare operator /= (byval s1 as Sca_Int)
  declare operator \= (byval s1 as Sca_Int)
  declare operator let (byval s1 as Sca_Int)
  
end type

''  2D floating point vector type
type Vec_2DF
  as Sca_Flt X, Y
  
  ''  Constructor declarations
  declare constructor (byval X as Sca_Flt, byval Y as Sca_Flt)
  declare constructor (byval s1 as Sca_Flt = 0.0)
  
  ''  Assignment operator declarations
  declare operator += (byval s1 as Sca_Flt)
  declare operator += (byref v1 as Vec_2DF) 
  declare operator -= (byval s1 as Sca_Flt)
  declare operator -= (byref v1 as Vec_2DF) 
  declare operator *= (byval s1 as Sca_Flt)
  declare operator /= (byval s1 as Sca_Flt)
  declare operator \= (byval s1 as Sca_Flt)
  declare operator let (byval s1 as Sca_Flt)
  
  ''  Function declarations
  declare function Magnitude() as Sca_Flt
  declare function MagnitudeSquared() as Sca_Flt
  declare function Normalized() as Vec_2DF
  declare function Normal() as Vec_2DF
  declare function NormalizedNormal() as Vec_2DF
  declare function Dot(byref v1 as Vec_2DF) as Sca_Flt
  declare function DotNormal(byref v1 as Vec_2DF) as Sca_Flt
  
end type


'*******************************************************************************
'   GLOBAL 2D INTEGER VECTOR OPERATOR DECLARATIONS
'******************************************************************************* 

''  Unary operators
declare operator - (byref v1 as Vec_2DI) as Vec_2DI

''  Binary operators
declare operator + (byref v1 as Vec_2DI, byref v2 as Vec_2DI) as Vec_2DI
declare operator - (byref v1 as Vec_2DI, byref v2 as Vec_2DI) as Vec_2DI
declare operator * (byref v1 as Vec_2DI, byval s1 as Sca_Int) as Vec_2DI
declare operator * (byval s1 as Sca_Int, byref v1 as Vec_2DI) as Vec_2DI
declare operator / (byref v1 as Vec_2DI, byval s1 as Sca_Int) as Vec_2DI
declare operator \ (byref v1 as Vec_2DI, byval s1 as Sca_Int) as Vec_2DI

''  Relational operators
declare operator = (byref v1 as Vec_2DI, byref v2 as Vec_2DI) as Sca_Bte
declare operator <> (byref v1 as Vec_2DI, byref v2 as Vec_2DI) as Sca_Bte


'*******************************************************************************
'   GLOBAL 2D FLOATING POINT VECTOR OPERATOR DECLARATIONS
'******************************************************************************* 

''  Unary operators
declare operator - (byref v1 as Vec_2DF) as Vec_2DF

''  Binary operators
declare operator + (byref v1 as Vec_2DF, byref v2 as Vec_2DF) as Vec_2DF
declare operator - (byref v1 as Vec_2DF, byref v2 as Vec_2DF) as Vec_2DF
declare operator * (byref v1 as Vec_2DF, byval s1 as Sca_Flt) as Vec_2DF
declare operator * (byval s1 as Sca_Flt, byref v1 as Vec_2DF) as Vec_2DF
declare operator * (byref v1 as Vec_2DF, byref v2 as Vec_2DF) as Vec_2DF
declare operator / (byref v1 as Vec_2DF, byval s1 as Sca_Flt) as Vec_2DF
declare operator \ (byref v1 as Vec_2DF, byval s1 as Sca_Flt) as Vec_2DF

''  Relational operators
declare operator = (byref v1 as Vec_2DF, byref v2 as Vec_2DF) as Sca_Bte
declare operator <> (byref v1 as Vec_2DF, byref v2 as Vec_2DF) as Sca_Bte


'*******************************************************************************
'   2D FLOATING POINT VECTOR FUNCTION DECLARATIONS
'******************************************************************************* 

declare function vec_set (s1 as Sca_Flt, s2 as Sca_Flt) as Vec_2DF
declare function vec_rnd overload (s1 as Sca_Flt) as Vec_2DF
declare function vec_rnd (s1 as Sca_Flt, s2 as Sca_Flt) as Vec_2DF
declare function vec_abs (v1 as Vec_2DF) as Vec_2DF
declare function vec_sgn (v1 as Vec_2DF) as Vec_2DF
declare function vec_mag (v1 as Vec_2DF) as Sca_Flt
declare function vec_mag_sqa (v1 as Vec_2DF) as Sca_Flt
declare function vec_mag_cub (v1 as Vec_2DF) as Sca_Flt
declare function vec_dst (v1 as Vec_2DF, v2 as Vec_2DF) as Sca_Flt
declare function vec_dst_sqa (v1 as Vec_2DF, v2 as Vec_2DF) as Sca_Flt
declare function vec_dst_cub (v1 as Vec_2DF, v2 as Vec_2DF) as Sca_Flt
declare function vec_hat (v1 as Vec_2DF) as Vec_2DF
declare function vec_nor (v1 as Vec_2DF) as Vec_2DF
declare function vec_nor_lft (v1 as Vec_2DF) as Vec_2DF
declare function vec_nor_rgt (v1 as Vec_2DF) as Vec_2DF
declare function vec_nor_hat (v1 as Vec_2DF) as Vec_2DF
declare function vec_dot (v1 as Vec_2DF, v2 as Vec_2DF) as Sca_Flt
declare function vec_nor_dot (v1 as Vec_2DF, v2 as Vec_2DF) as Sca_Flt
declare function vec_crs (v1 as Vec_2DF, v2 as Vec_2DF, v3 as Vec_2DF) as Sca_Flt
declare function vec_ang (v1 as Vec_2DF, v2 as Vec_2DF) as Sca_Flt
declare function vec_cos_ang (v1 as Vec_2DF, v2 as Vec_2DF) as Sca_Flt
declare function vec_sin_ang (v1 as Vec_2DF, v2 as Vec_2DF) as Sca_Flt
declare function vec_pro (v1 as Vec_2DF, v2 as Vec_2DF) as Sca_Flt
declare function vec_com (v1 as Vec_2DF, v2 as Vec_2DF) as Vec_2DF
declare function vec_nor_pro (v1 as Vec_2DF, v2 as Vec_2DF) as Sca_Flt
declare function vec_nor_com (v1 as Vec_2DF, v2 as Vec_2DF) as Vec_2DF
declare function vec_rot (v1 as Vec_2DF, Cos_Ang as Sca_Flt, Sin_Ang as Sca_Flt) as Vec_2DF
declare function vec_int_boo (a1 as Vec_2DF, a2 as Vec_2DF, b1 as Vec_2DF, b2 as Vec_2DF) as Sca_Bte
declare function vec_int_pos (a1 as Vec_2DF, a2 as Vec_2DF, b1 as Vec_2DF, b2 as Vec_2DF) as Vec_2DF
declare function vec_pnt_lin (a1 as Vec_2DF, a2 as Vec_2DF, p1 as Vec_2DF) as Vec_2DF
declare function vec_pnt_pln (a1 as Vec_2DF, a2 as Vec_2DF, p1 as Vec_2DF) as Vec_2DF
declare function vec_pnt_tri (a1 as Vec_2DF, a2 as Vec_2DF, a3 as Vec_2DF, p1 as Vec_2DF) as Sca_Bte
declare function vec_pnt_lft (p0 as Vec_2DF, p1 as Vec_2DF, p2 as Vec_2DF) as Sca_Bte


'*******************************************************************************
'   2D INTEGER VECTOR CONSTRUCTORS
'*******************************************************************************

constructor Vec_2DI (byval x as Sca_Int, byval y as Sca_Int)
  this.x = x
  this.y = y
end constructor

constructor Vec_2DI (byval s1 as Sca_Int)
  this.x = s1
  this.y = s1
end constructor


'*******************************************************************************
'   2D INTEGER VECTOR LOCAL OPERATORS
'*******************************************************************************

operator Vec_2DI.+= (byval s1 as Sca_Int)
  this.x += s1
  this.y += s1
end operator

operator Vec_2DI.+= (byref v1 as Vec_2DI)
  this.x += v1.x
  this.y += v1.y
end operator

operator Vec_2DI.-= (byval s1 as Sca_Int)
  this.x -= s1
  this.y -= s1
end operator

operator Vec_2DI.-= (byref v1 as Vec_2DI)
  this.x -= v1.x
  this.y -= v1.y
end operator

operator Vec_2DI.*= (byval s1 as Sca_Int)
  this.x *= s1
  this.y *= s1
end operator

operator Vec_2DI./= (byval s1 as Sca_Int)
  this.x /= s1
  this.y /= s1
end operator

operator Vec_2DI.\= (byval s1 as Sca_Int)
  this.x \= s1
  this.y \= s1
end operator

operator Vec_2DI.Let (byval s1 as Sca_Int)
  this.x = s1
  this.y = s1
end operator


'*******************************************************************************
'   2D FLOATING POINT VECTOR CONSTRUCTORS
'*******************************************************************************

constructor Vec_2DF (byval x as Sca_Flt, byval y as Sca_Flt)
  this.x = x
  this.y = y
end constructor

constructor Vec_2DF (byval s1 as Sca_Flt)
  this.x = s1
  this.y = s1
end constructor


'*******************************************************************************
'   2D FLOATING POINT VECTOR LOCAL OPERATORS
'*******************************************************************************

operator Vec_2DF.+= (byval s1 as Sca_Flt)
  this.x += s1
  this.y += s1
end operator

operator Vec_2DF.+= (byref v1 as Vec_2DF)
  this.x += v1.x
  this.y += v1.y
end operator

operator Vec_2DF.-= (byval s1 as Sca_Flt)
  this.x -= s1
  this.y -= s1
end operator

operator Vec_2DF.-= (byref v1 as Vec_2DF)
  this.x -= v1.x
  this.y -= v1.y
end operator

operator Vec_2DF.*= (byval s1 as Sca_Flt)
  this.x *= s1
  this.y *= s1
end operator

operator Vec_2DF./= (byval s1 as Sca_Flt)
  this.x /= s1
  this.y /= s1
end operator

operator Vec_2DF.\= (byval s1 as Sca_Flt)
  this.x \= s1
  this.y \= s1
end operator

operator Vec_2DF.Let (byval s1 as Sca_Flt)
  this.x = s1
  this.y = s1
end operator


'*******************************************************************************
'   2D FLOATING POINT VECTOR FUNCTIONS
'*******************************************************************************

function vec_2df.magnitude() as Sca_Flt
  return sqr(MagnitudeSquared)
end function

function vec_2df.magnitudesquared() as Sca_Flt
  return Dot(This)
end function

function vec_2df.normal() as Vec_2DF
  return Vec_2DF(this.y, -this.x)
end function

function vec_2df.normalized() as Vec_2DF
	return This/Magnitude
end function

function vec_2df.normalizednormal() as Vec_2DF
	return Normal/Magnitude
end function

function vec_2df.dot(byref v1 as Vec_2DF) as Sca_Flt
	return this.x*v1.x+this.y*v1.y
end function

function vec_2df.dotnormal(byref v1 as Vec_2DF) as Sca_Flt
	return Dot(v1.Normal)
end function


'*******************************************************************************
'   2D INTEGER VECTOR GLOBAL OPERATORS
'*******************************************************************************

''  Unary operators
operator - (byref v1 as Vec_2DI) as Vec_2DI
  return Vec_2DI(-v1.x, -v1.y)
end operator


''  Binary operators
operator - (byref v1 as Vec_2DI, byref v2 as Vec_2DI) as Vec_2DI
  return Vec_2DI(v1.x-v2.x, v1.y-v2.y)
end operator

operator + (byref v1 as Vec_2DI, byref v2 as Vec_2DI) as Vec_2DI
  return Vec_2DI(v1.x+v2.x, v1.y+v2.y)
end operator

operator * (byref v1 as Vec_2DI, byval s1 as Sca_Int) as Vec_2DI
  return Vec_2DI(v1.x*s1, v1.y*s1)
end operator

operator * (byval s1 as Sca_Int, byref v1 as Vec_2DI) as Vec_2DI
  return Vec_2DI(s1*v1.x, s1*v1.y)
end operator

operator / (byref v1 as Vec_2DI, byval s1 as Sca_Flt) as Vec_2DI
  return Vec_2DI(v1.x/s1, v1.y/s1)
end operator

operator \ (byref v1 as Vec_2DI, byval s1 as Sca_Int) as Vec_2DI
  return Vec_2DI(v1.x\s1, v1.y\s1)
end operator


''  Relational operators
operator = (byref v1 as Vec_2DI, byref v2 as Vec_2DI) as Sca_Bte
  return (v1.x = v2.x) and (v1.y = v2.y)
end operator

operator <> (byref v1 as Vec_2DI, byref v2 as Vec_2DI) as Sca_Bte
  return (v1.x <> v2.x) or (v1.y <> v2.y)
end operator


'*******************************************************************************
'   2D FLOATING POINT VECTOR GLOBAL OPERATORS
'*******************************************************************************

''  Unary operators
operator - (byref v1 as Vec_2DF) as Vec_2DF
  return Vec_2DF(-v1.x, -v1.y)
end operator


''  Binary operators
operator - (byref v1 as Vec_2DF, byref v2 as Vec_2DF) as Vec_2DF
  return Vec_2DF(v1.x-v2.x, v1.y-v2.y)
end operator

operator + (byref v1 as Vec_2DF, byref v2 as Vec_2DF) as Vec_2DF
  return Vec_2DF(v1.x+v2.x, v1.y+v2.y)
end operator

operator * (byref v1 as Vec_2DF, byval s1 as Sca_Flt) as Vec_2DF
  return Vec_2DF(v1.x*s1, v1.y*s1)
end operator

operator * (byval s1 as Sca_Flt, byref v1 as Vec_2DF) as Vec_2DF
  return Vec_2DF(s1*v1.x, s1*v1.y)
end operator

operator * (byref v1 as Vec_2DF, byref v2 as Vec_2DF) as Vec_2DF
  return Vec_2DF(v1.x*v2.x, v1.y*v2.y)
end operator

operator / (byref v1 as Vec_2DF, byval s1 as Sca_Flt) as Vec_2DF
  return Vec_2DF(v1.x/s1, v1.y/s1)
end operator

operator \ (byref v1 as Vec_2DF, byval s1 as Sca_Flt) as Vec_2DF
  return Vec_2DF(v1.x\s1, v1.y\s1)
end operator


''  Relational operators
operator = (byref v1 as Vec_2DF, byref v2 as Vec_2DF) as Sca_Bte
  return (v1.x = v2.x) and (v1.y = v2.y)
end operator

operator <> (byref v1 as Vec_2DF, byref v2 as Vec_2DF) as Sca_Bte
  return (v1.x <> v2.x) or (v1.y <> v2.y)
end operator


'*******************************************************************************
'   2D FLOATING POINT VECTOR FUNCTIONS
'*******************************************************************************

function vec_set (s1 as Sca_Flt, s2 as Sca_Flt) as Vec_2DF
  return Vec_2DF(s1, s2)
end function

function vec_rnd (s1 as Sca_Flt) as Vec_2DF
  return Vec_2DF((rnd-rnd)*s1, (rnd-rnd)*s1)
end function

function vec_rnd (s1 as Sca_Flt, s2 as Sca_Flt) as Vec_2DF
  return Vec_2DF((rnd-rnd)*s1, (rnd-rnd)*s2)
end function

function vec_abs (v1 as Vec_2DF) as Vec_2DF
  return Vec_2DF(abs(v1.x), abs(v1.y))
end function

function vec_sgn (v1 as Vec_2DF) as Vec_2DF
  return Vec_2DF(sgn(v1.x), sgn(v1.y))
end function

function vec_mag (v1 as Vec_2DF) as Sca_Flt
  return sqr(vec_mag_sqa(v1))
end function

function vec_mag_sqa (v1 as Vec_2DF) as Sca_Flt
  return vec_dot(v1, v1)
end function

function vec_mag_cub (v1 as Vec_2DF) as Sca_Flt
  return vec_mag(v1)*vec_mag_sqa(v1)
end function

function vec_dst (v1 as Vec_2DF, v2 as Vec_2DF) as Sca_Flt
  return vec_mag(v2-v1)
end function

function vec_dst_sqa (v1 as Vec_2DF, v2 as Vec_2DF) as Sca_Flt
  return vec_mag_sqa(v2-v1)
end function

function vec_dst_cub (v1 as Vec_2DF, v2 as Vec_2DF) as Sca_Flt
  return vec_mag_cub(v2-v1)
end function

function vec_hat (v1 as Vec_2DF) as Vec_2DF
  return v1/vec_mag(v1)
end function

function vec_nor (v1 as Vec_2DF) as Vec_2DF
  return Vec_2DF(v1.y, -v1.x)
end function

function vec_nor_lft (v1 as Vec_2DF) as Vec_2DF
  return vec_nor(v1)
end function

function vec_nor_rgt (v1 as Vec_2DF) as Vec_2DF
  return vec_nor(-v1)
end function

function vec_nor_hat (v1 as Vec_2DF) as Vec_2DF
  return vec_nor(v1)/vec_mag(v1)
end function

function vec_dot (v1 as Vec_2DF, v2 as Vec_2DF) as Sca_Flt
  return v1.x*v2.x+v1.y*v2.y
end function

function vec_nor_dot (v1 as Vec_2DF, v2 as Vec_2DF) as Sca_Flt
  return v1.x*v2.y-v1.y*v2.x
end function

function vec_crs (v1 as Vec_2DF, v2 as Vec_2DF, v3 as Vec_2DF) as Sca_Flt
  return (v2.x-v1.x)*(v3.y-v1.y)-(v3.x-v1.x)*(v2.y-v1.y)
end function

function vec_ang (v1 as Vec_2DF, v2 as Vec_2DF) as Sca_Flt
  return acos(vec_dot(v1, v2)/(vec_mag(v1)*vec_mag(v2)))
end function

function vec_cos_ang (v1 as Vec_2DF, v2 as Vec_2DF) as Sca_Flt
  return vec_dot(v1, v2)/(vec_mag(v1)*vec_mag(v2))
end function

function vec_sin_ang (v1 as Vec_2DF, v2 as Vec_2DF) as Sca_Flt
  return vec_nor_dot(v1, v2)/(vec_mag(v1)*vec_mag(v2))
end function

function vec_pro (v1 as Vec_2DF, v2 as Vec_2DF) as Sca_Flt
  return vec_dot(v1, v2)/vec_mag(v2)
end function

function vec_com (v1 as Vec_2DF, v2 as Vec_2DF) as Vec_2DF
  return (vec_dot(v1, v2)/vec_mag_sqa(v2))*v2
end function

function vec_nor_pro (v1 as Vec_2DF, v2 as Vec_2DF) as Sca_Flt
  return vec_nor_dot(v1, v2)/vec_mag(v2)
end function

function vec_nor_com (v1 as Vec_2DF, v2 as Vec_2DF) as Vec_2DF
  return (vec_nor_dot(v1, v2)/vec_mag_sqa(v2))*v2
end function

function vec_rot (v1 as Vec_2DF, Cos_Ang as Sca_Flt, Sin_Ang as Sca_Flt) as Vec_2DF
  return Vec_2DF(Cos_Ang*v1.x-Sin_Ang*v1.y, Cos_Ang*v1.y+Sin_Ang*v1.x)
end function

function vec_int_boo (a1 as Vec_2DF, a2 as Vec_2DF, b1 as Vec_2DF, b2 as Vec_2DF) as Sca_Bte
  dim as Vec_2DF a = a2-a1
  dim as Vec_2DF b = b2-b1
  dim as Sca_Flt d = vec_nor_dot(b, a)
  dim as Sca_Flt s = (a.x*(b1.y-a1.y) + a.y*(a1.x-b1.x)) / d
  dim as Sca_Flt t = (b.x*(a1.y-b1.y) + b.y*(b1.x-a1.x)) / -d
  return (s >= 0 and s <= 1 and t >= 0 and t <= 1)
end function

function vec_int_pos (a1 as Vec_2DF, a2 as Vec_2DF, b1 as Vec_2DF, b2 as Vec_2DF) as Vec_2DF
  dim as Vec_2DF a = a2-a1
  dim as Vec_2DF b = b2-b1
  dim as Sca_Flt d = vec_nor_dot(b, a)
  dim as Sca_Flt s = (a.x*(b1.y-a1.y) + a.y*(a1.x-b1.x)) / d
  dim as Sca_Flt t = (b.x*(a1.y-b1.y) + b.y*(b1.x-a1.x)) / -d
  if (s >= 0 and s <= 1 and t >= 0 and t <= 1) = -1 then
    return a1+t*a
  else
    return 0
  end if
end function

function vec_pnt_lin(a1 as Vec_2DF, a2 as Vec_2DF, p1 as Vec_2DF) as Vec_2DF
  dim as Vec_2DF ab = a2-a1
  dim as Vec_2DF ap = p1-a1
  dim as Sca_Flt t = vec_dot(ap, ab)/vec_mag_sqa(ab)
  if t < 0 then t = 0
  if t > 1 then t = 1
  return a1+ab*t
end function

function vec_pnt_pln(a1 as Vec_2DF, a2 as Vec_2DF, p1 as Vec_2DF) as Vec_2DF
  dim as Vec_2DF ab = a2-a1
  dim as Vec_2DF ap = p1-a1
  dim as Sca_Flt t = vec_dot(ap, ab)/vec_mag_sqa(ab)
  return a1+ab*t
end function

function vec_pnt_tri (a1 as Vec_2DF, a2 as Vec_2DF, a3 as Vec_2DF, p1 as Vec_2DF) as Sca_Bte
  dim as Vec_2DF v0 = a3 - a1
  dim as Vec_2DF v1 = a2 - a1
  dim as Vec_2DF v2 = p1 - a1
  dim as Sca_Flt dot00 = vec_dot(v0, v0)
  dim as Sca_Flt dot01 = vec_dot(v0, v1)
  dim as Sca_Flt dot02 = vec_dot(v0, v2)
  dim as Sca_Flt dot11 = vec_dot(v1, v1)
  dim as Sca_Flt dot12 = vec_dot(v1, v2)
  dim as Sca_Flt invDenom = 1 / (dot00 * dot11 - dot01 * dot01)
  dim as Sca_Flt u = (dot11 * dot02 - dot01 * dot12) * invDenom
  dim as Sca_Flt v = (dot00 * dot12 - dot01 * dot02) * invDenom
  return (u > 0) and (v > 0) and (u + v < 1)
end function

function vec_pnt_lft (p0 as Vec_2DF, p1 as Vec_2DF, p2 as Vec_2DF) as Sca_Bte
	return sgn(vec_crs(p0, p1, p2))
end function
