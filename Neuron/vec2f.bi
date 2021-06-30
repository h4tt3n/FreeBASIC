''*******************************************************************************
''		
''		Freebasic 2d floating point vector library
''		version 0.4b, may 2009, Michael "h4tt3n" Nissen, jernmager@yahoo.dk
''		
''		function syntax:
''		
''   	(return type) (function name) (argument type (, ...))
''		
''	 	function list:
''		
''   	vector absolute          	(vector)          - absolute value
''   	vector normal            	(vector)          - normal vector
''   	vector normalised        	(vector)          - normalised vector
''		vector normalisednormal		(vector)					-	normalised normal vector
''   	scalar magnitude         	(vector)          - magnitude
''   	scalar magnitudesquared		(vector)          - magnitude squared
''   	scalar distance          	(vector, vector)  - vector distance
''   	scalar distancesquared   	(vector, vector)  - vector distance squared
''   	scalar dot               	(vector, vector)  - dot product
''   	scalar dotnormal         	(vector, vector)  - normal dot product
''   	vector project           	(vector, vector)	-	vector projection
''		vector component					(vector, vector)	-	vector component
''		vector randomise					(scalar)					-	randomise in range +/- value
''		
''	 	function useage, member and non-member style:
''
''		vector_a.function(vector_b),	function(vector_a, vector_b)
''		
''*******************************************************************************

type float as single

''  2d float vector structure
type vec2f
	
  ''  variables
  as float x, y
	
  ''  ructor declarations
	declare constructor ()
  declare constructor (byval X as float, byval Y as float)
	
  ''  compound arithmetic member operator declarations
  declare operator += (byref rhs as vec2f)
  declare operator -= (byref rhs as vec2f)
  declare operator *= (byref rhs as vec2f)
  declare operator *= (byref rhs as float)
  declare operator /= (byref rhs as float)
  declare operator let (byref rhs as vec2f)
	
	''  member function declarations
  declare function absolute() as vec2f
  declare function normal() as vec2f 
  declare function normalised() as vec2f
  declare function normalisednormal() as vec2f
  declare function magnitude() as float
  declare function magnitudesquared() as float
  declare function distance(byref rhs as vec2f) as float
  declare function distancesquared(byref rhs as vec2f) as float
  declare function dot(byref rhs as vec2f) as float
  declare function dotnormal(byref rhs as vec2f) as float
  declare function project(byref rhs as vec2f) as vec2f
  declare function component(byref rhs as vec2f) as vec2f
  declare function randomise(byval rhs as float) as vec2f
  
end type

''  unary arithmetic non-member operator declarations
declare operator - (byref rhs as vec2f) as  vec2f

''  binary arithmetic non-member operator declarations
declare operator + (byval lhs as vec2f, byref rhs as vec2f) as vec2f
declare operator - (byval lhs as vec2f, byref rhs as vec2f) as vec2f
declare operator * (byval lhs as vec2f, byref rhs as vec2f) as vec2f
declare operator * (byval lhs as float, byref rhs as vec2f) as vec2f
declare operator * (byval lhs as vec2f, byval rhs as float) as vec2f
declare operator / (byval lhs as vec2f, byval rhs as float) as vec2f

''  non-member function declarations
declare function absolute (byref lhs as vec2f) as vec2f
declare function normal (byref lhs as vec2f) as vec2f
declare function normalised (byref lhs as vec2f) as vec2f
declare function normalisednormal(byref lhs as vec2f) as vec2f
declare function magnitude (byref lhs as vec2f) as float
declare function magnitudesquared (byref lhs as vec2f) as float
declare function distance (byval lhs as vec2f, byref rhs as vec2f) as float
declare function distancesquared (byval lhs as vec2f, byref rhs as vec2f) as float
declare function dot (byval lhs as vec2f, byref rhs as vec2f) as float
declare function dotnormal (byval lhs as vec2f, byref rhs as vec2f) as float
declare function project (byval lhs as vec2f, byref rhs as vec2f) as vec2f
declare function component(byval lhs as vec2f, byref rhs as vec2f) as vec2f
declare function trigonometry(byref lhs as float) as vec2f

''  constructors
constructor vec2f(): this.x = 0.0: this.y = 0.0: end constructor
constructor vec2f(byval x as float, byval y as float): this.x = x: this.y = y: end constructor

''  compound arithmetic member operators
operator vec2f.+= (byref rhs as  vec2f): x += rhs.x: y += rhs.y: end operator
operator vec2f.-= (byref rhs as  vec2f): x -= rhs.x: y -= rhs.y: end operator
operator vec2f.*= (byref rhs as  vec2f): x *= rhs.x: y *= rhs.y: end operator
operator vec2f.*= (byref rhs as  float): x *= rhs: y *= rhs: end operator
operator vec2f./= (byref rhs as  float): x /= rhs: y /= rhs: end operator
operator vec2f.let (byref rhs as  vec2f): x = rhs.x: y = rhs.y: end operator

''  member functions
function vec2f.absolute() as vec2f: return vec2f(abs(x), abs(y)): end function
function vec2f.normal() as vec2f: return vec2f(y, -x): end function 
function vec2f.normalised() as vec2f: return this/magnitude(): end function
function vec2f.normalisednormal() as vec2f: return this.normal()/magnitude(): end function
function vec2f.magnitude() as float: return sqr(magnitudesquared()): end function
function vec2f.magnitudesquared() as float: return this.dot(this): end function
function vec2f.distance(byref rhs as vec2f) as float: return sqr(distancesquared(rhs)): end function
function vec2f.distancesquared(byref rhs as vec2f) as float: return (x-rhs.x)*(x-rhs.x)+(y-rhs.y)*(y-rhs.y): end function
function vec2f.dot(byref rhs as vec2f) as float: return (x*rhs.x+y*rhs.y): end function
function vec2f.dotnormal(byref rhs as vec2f) as float: return this.dot(rhs.normal()): end function
function vec2f.project(byref rhs as vec2f) as vec2f: return (dot(rhs)/magnitudesquared())*rhs: end function
function vec2f.component(byref rhs as vec2f) as vec2f: return (dot(rhs)/rhs.magnitudesquared)*rhs: end function
function vec2f.randomise(byval rhs as float) as vec2f: return vec2f((rnd-rnd)*rhs, (rnd-rnd)*rhs): end function

''  unary arithmetic non-member operators
operator - (byref rhs as vec2f) as vec2f: return vec2f(-rhs.x, -rhs.y): end operator

''  binary arithmetic non-member operators
operator + (byval lhs as vec2f, byref rhs as vec2f) as vec2f: return vec2f(lhs.x+rhs.x, lhs.y+rhs.y): end operator
operator - (byval lhs as vec2f, byref rhs as vec2f) as vec2f: return vec2f(lhs.x-rhs.x, lhs.y-rhs.y): end operator
operator * (byval lhs as vec2f, byref rhs as vec2f) as vec2f: return vec2f(lhs.x*rhs.x, lhs.y*rhs.y): end operator
operator * (byval lhs as float, byref rhs as vec2f) as vec2f: return vec2f(lhs*rhs.x, lhs*rhs.y): end operator
operator * (byval lhs as vec2f, byval rhs as float) as vec2f: return vec2f(lhs.x*rhs, lhs.y*rhs): end operator
operator / (byval lhs as vec2f, byval rhs as float) as vec2f: return vec2f(lhs.x/rhs, lhs.y/rhs): end operator

''  non-member functions
function absolute (byref lhs as vec2f) as vec2f: return lhs.absolute(): end function
function normal (byref lhs as vec2f) as vec2f: return lhs.normal(): end function
function normalised (byref lhs as vec2f) as vec2f: return lhs.normalised(): end function
function normalisednormal(byref lhs as vec2f) as vec2f: return lhs.normalisednormal(): end function
function magnitude (byref lhs as vec2f) as float: return lhs.magnitude(): end function
function magnitudesquared (byref lhs as vec2f) as float: return lhs.magnitudesquared(): end function
function distance (byval lhs as vec2f, byref rhs as vec2f) as float: return lhs.distance(rhs): end function
function distancesquared (byval lhs as vec2f, byref rhs as vec2f) as float: return lhs.distancesquared(rhs): end function
function dot (byval lhs as vec2f, byref rhs as vec2f) as float: return lhs.dot(rhs): end function
function dotnormal (byval lhs as vec2f, byref rhs as vec2f) as float: return lhs.dotnormal(rhs): end function
function project (byval lhs as vec2f, byref rhs as vec2f) as vec2f: return lhs.project(rhs): end function
function component(byval lhs as vec2f, byref rhs as vec2f) as vec2f: return lhs.component(rhs): end function
function trigonometry(byref lhs as float) as vec2f: return vec2f(cos(lhs), sin(lhs)): end function