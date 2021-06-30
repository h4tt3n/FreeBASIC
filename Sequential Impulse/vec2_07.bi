''*******************************************************************************
''		
''		Freebasic 2d Floating point and Integer vector library
''		version 0.7b, august 2011, Michael "h4tt3n" Nissen, jernmager@yahoo.dk
''		Integer vectors have been added for screen and mouse operations.   
''		
''		function syntax:
''		
''   	(return type) (function name) (argument type (, ...) (description))
''		
''	 	Floating point vector function list:
''		
''   	vector absolute          	(vector)          				- absolute value
''   	vector normal            	(vector)          				- normal vector
''   	vector rightnormal        (vector)          				- right hand normal vector
''   	vector leftnormal        	(vector)          				- left hand normal vector
''   	vector normalised        	(vector)          				- normalised vector
''		vector normalisednormal		(vector)									-	normalised normal vector
''   	scalar magnitude         	(vector)          				- magnitude
''   	scalar magnitudesquared		(vector)          				- magnitude squared
''   	scalar distance          	(vector, vector)  				- vector distance
''   	scalar distancesquared   	(vector, vector)  				- vector distance squared
''   	scalar dot               	(vector, vector)  				- dot product
''   	scalar dotnormal         	(vector, vector)  				- normal dot product
''   	vector project           	(vector, vector)					-	vector projection
''		vector component					(vector, vector)					-	vector component
''		vector randomise					(scalar)									-	randomise in range +/- value
''		vector lerp								(vector, vector, scalar)	- linear interpolation
''		vector rotate							(vector, vector)					-	rotates vector 
''		vector rotate							(vector, scalar)					-	rotates vector 
''
''		Integer vector function list:
''		
''		
''	 	function useage, member and non-member style:
''
''		vector_a.function(vector_b),	function(vector_a, vector_b)
''
''		
''*******************************************************************************

''	
Type Float As Double
Type Integ As INTEGER

''  Vec2f 2d Float vector structure
Type Vec2f
	
  ''  Vec2f variables
  As Float x, y
	
  ''  Vec2f constructor declarations
	Declare Constructor ()
  Declare Constructor (ByVal x As Float = 0, ByVal y As Float = 0)
  Declare Constructor (ByRef vec As Vec2f)
	
  ''  Vec2f compound arithmetic member operator declarations
  Declare Operator += (ByRef rhs As Vec2f)
  Declare Operator -= (ByRef rhs As Vec2f)
  Declare Operator *= (ByRef rhs As Vec2f)
  Declare Operator *= (ByRef rhs As Float)
  Declare Operator /= (ByRef rhs As Float)
  Declare Operator Let (ByRef rhs As Vec2f)
	
	''	Vec2f member function declarations
  Declare Function absolute() As Vec2f
  Declare Function normal() As Vec2f 
  Declare Function rightnormal() As Vec2f 
  Declare Function leftnormal() As Vec2f 
  Declare Function normalised() As Vec2f
  Declare Function normalisednormal() As Vec2f
  Declare Function magnitude() As Float
  Declare Function magnitudesquared() As Float
  Declare Function distance(ByRef rhs As Vec2f) As Float
  Declare Function distancesquared(ByRef rhs As Vec2f) As Float
  Declare Function dot(ByRef rhs As Vec2f) As Float
  Declare Function dotnormal(ByRef rhs As Vec2f) As Float
  Declare Function project(ByRef rhs As Vec2f) As Vec2f
  Declare Function component(ByRef rhs As Vec2f) As Vec2f
  Declare Function randomise(ByVal rhs As Float) As Vec2f
  Declare Function lerp(ByRef rhs As Vec2f, ByVal i As Float) As Vec2f
  Declare Function rotate(ByRef rhs As Vec2f) As Vec2f
  Declare Function rotate(ByRef rhs As Float) As Vec2f
  
End Type

''  Vec2f unary arithmetic non-member operator declarations
Declare Operator - (ByRef rhs As Vec2f) As Vec2f

''  Vec2f binary arithmetic non-member operator declarations
Declare Operator + (ByRef lhs As Vec2f, ByRef rhs As Vec2f) As Vec2f
Declare Operator - (ByRef lhs As Vec2f, ByRef rhs As Vec2f) As Vec2f
Declare Operator * (ByVal lhs As Float, ByRef rhs As Vec2f) As Vec2f
Declare Operator * (ByRef lhs As Vec2f, ByVal rhs As Float) As Vec2f
Declare Operator * (ByRef lhs As vec2f, ByVal rhs As vec2f) As vec2f
Declare Operator / (ByRef lhs As Vec2f, ByVal rhs As Float) As Vec2f
Declare Operator / (ByRef lhs As Vec2f, ByVal rhs As Vec2f) As Vec2f

''  Vec2f binary relational non-member operator declarations
Declare Operator = (ByRef lhs As Vec2f, ByVal rhs As Vec2f) As Integ
Declare Operator = (ByRef lhs As Float, ByVal rhs As Vec2f) As Integ
Declare Operator = (ByRef lhs As Vec2f, ByVal rhs As Float) As Integ
Declare Operator < (ByRef lhs As Vec2f, ByVal rhs As Vec2f) As Integ
Declare Operator < (ByRef lhs As Float, ByVal rhs As Vec2f) As Integ
Declare Operator < (ByRef lhs As Vec2f, ByVal rhs As Float) As Integ
Declare Operator > (ByRef lhs As Vec2f, ByVal rhs As Vec2f) As Integ
Declare Operator > (ByRef lhs As Float, ByVal rhs As Vec2f) As Integ
Declare Operator > (ByRef lhs As Vec2f, ByVal rhs As Float) As Integ

''  Vec2f non-member function declarations
Declare Function absolute (ByRef lhs As Vec2f) As Vec2f
Declare Function normal (ByRef lhs As Vec2f) As Vec2f
Declare Function rightnormal (ByRef lhs As Vec2f) As Vec2f
Declare Function leftnormal (ByRef lhs As Vec2f) As Vec2f
Declare Function normalised (ByRef lhs As Vec2f) As Vec2f
Declare Function normalisednormal(ByRef lhs As Vec2f) As Vec2f
Declare Function magnitude (ByRef lhs As Vec2f) As Float
Declare Function magnitudesquared (ByRef lhs As Vec2f) As Float
Declare Function distance (ByVal lhs As Vec2f, ByRef rhs As Vec2f) As Float
Declare Function distancesquared (ByVal lhs As Vec2f, ByRef rhs As Vec2f) As Float
Declare Function dot (ByVal lhs As Vec2f, ByRef rhs As Vec2f) As Float
Declare Function dotnormal (ByVal lhs As Vec2f, ByRef rhs As Vec2f) As Float
Declare Function project (ByVal lhs As Vec2f, ByRef rhs As Vec2f) As Vec2f
Declare Function component(ByVal lhs As Vec2f, ByRef rhs As Vec2f) As Vec2f
Declare Function randomise(ByVal lhs As Float) As Vec2f
Declare Function lerp(ByVal lhs As Vec2f, ByRef rhs As Vec2f, ByVal i As Float) As Vec2f
Declare Function rotate(ByVal lhs As Vec2f, ByRef rhs As Vec2f) As Vec2f

''  Vec2f constructors
Constructor Vec2f(): This.x = 0.0: This.y = 0.0: End Constructor
Constructor Vec2f(ByVal x As Float, ByVal y As Float): This.x = x: This.y = y: End Constructor
Constructor Vec2f(ByRef vec As Vec2f): This.x = vec.x: This.y = vec.y: End Constructor

''  Vec2f compound arithmetic member operators
Operator Vec2f.+= (ByRef rhs As Vec2f): This.x += rhs.x: This.y += rhs.y: End Operator
Operator Vec2f.-= (ByRef rhs As Vec2f): This.x -= rhs.x: This.y -= rhs.y: End Operator
Operator Vec2f.*= (ByRef rhs As Vec2f): This.x *= rhs.x: This.y *= rhs.y: End Operator
Operator Vec2f.*= (ByRef rhs As Float): This.x *= rhs: This.y *= rhs: End Operator
Operator Vec2f./= (ByRef rhs As Float): This.x /= rhs: This.y /= rhs: End Operator
Operator Vec2f.Let (ByRef rhs As Vec2f): This.x = rhs.x: This.y = rhs.y: End Operator

''  Vec2f member functions
Function Vec2f.absolute() As Vec2f: Return Vec2f(Abs(This.x), Abs(This.y)): End Function
Function Vec2f.normal() As Vec2f: Return Vec2f(This.y, -This.x): End Function 
Function Vec2f.rightnormal() As Vec2f: Return This.normal: End Function 
Function Vec2f.leftnormal() As Vec2f: Return -This.normal: End Function
Function Vec2f.normalised() As Vec2f: If (This.x = 0) And (This.y = 0) Then Return Vec2f(0,0): Else Return This/This.magnitude(): End If: End Function
Function Vec2f.normalisednormal() As Vec2f: Return This.normal()/magnitude(): End Function
Function Vec2f.magnitude() As Float: Return Sqr(This.magnitudesquared()): End Function
Function Vec2f.magnitudesquared() As Float: Return This.dot(This): End Function
Function Vec2f.distance(ByRef rhs As Vec2f) As Float: Return Sqr(This.distancesquared(rhs)): End Function
Function Vec2f.distancesquared(ByRef rhs As Vec2f) As Float: Return (This-rhs).dot(This-rhs): End Function
Function Vec2f.dot(ByRef rhs As Vec2f) As Float: Return (This.x*rhs.x+This.y*rhs.y): End Function
Function Vec2f.dotnormal(ByRef rhs As Vec2f) As Float: Return This.dot(rhs.normal()): End Function
Function Vec2f.project(ByRef rhs As Vec2f) As Vec2f: Return (This.dot(rhs)/This.magnitudesquared)*This: End Function
Function Vec2f.component(ByRef rhs As Vec2f) As Vec2f: Return (This.dot(rhs)/rhs.magnitudesquared)*rhs: End Function
Function Vec2f.randomise(ByVal rhs As Float) As Vec2f: Return Vec2f((Rnd-Rnd)*rhs, (Rnd-Rnd)*rhs): End Function
Function Vec2f.lerp(ByRef rhs As Vec2f, ByVal i As Float) As Vec2f: Return This+(rhs-This)*i: End Function
Function Vec2f.rotate(ByRef rhs As Vec2f) As Vec2f: Return Vec2f(rhs.dot(This), rhs.dotnormal(This)): End Function

''  Vec2f unary arithmetic non-member operators
Operator - (ByRef rhs As Vec2f) As Vec2f: Return Vec2f(-rhs.x, -rhs.y): End Operator

''  Vec2f binary arithmetic non-member operators
Operator + (ByRef lhs As Vec2f, ByRef rhs As Vec2f) As Vec2f: Return Vec2f(lhs.x+rhs.x, lhs.y+rhs.y): End Operator
Operator - (ByRef lhs As Vec2f, ByRef rhs As Vec2f) As Vec2f: Return Vec2f(lhs.x-rhs.x, lhs.y-rhs.y): End Operator
Operator * (ByVal lhs As Float, ByRef rhs As Vec2f) As Vec2f: Return Vec2f(lhs*rhs.x, lhs*rhs.y): End Operator
Operator * (ByRef lhs As Vec2f, ByVal rhs As Float) As Vec2f: Return Vec2f(lhs.x*rhs, lhs.y*rhs): End Operator
Operator * (ByRef lhs As vec2f, ByVal rhs As vec2f) As vec2f: Return vec2f(lhs.x*rhs.y, lhs.y*rhs.y): End Operator
Operator / (ByRef lhs As Vec2f, ByVal rhs As Float) As Vec2f: Return Vec2f(lhs.x/rhs, lhs.y/rhs): End Operator
Operator / (ByRef lhs As Vec2f, ByVal rhs As Vec2f) As Vec2f: Return Vec2f(lhs.x/rhs.x, lhs.y/rhs.y): End Operator

''  Vec2f binary relational non-member operators
Operator = (ByRef lhs As Vec2f, ByVal rhs As Vec2f) As Integ: Return (lhs.x = rhs.x) And (lhs.y = rhs.y): End Operator
Operator = (ByRef lhs As Float, ByVal rhs As Vec2f) As Integ: Return (lhs = rhs.x) And (lhs = rhs.y): End Operator
Operator = (ByRef lhs As Vec2f, ByVal rhs As Float) As Integ: Return (lhs.x = rhs) And (lhs.y = rhs): End Operator
Operator < (ByRef lhs As Vec2f, ByVal rhs As Vec2f) As Integ: Return (lhs.x > rhs.x) And (lhs.y > rhs.y): End Operator
Operator < (ByRef lhs As Float, ByVal rhs As Vec2f) As Integ: Return (lhs > rhs.x) And (lhs > rhs.y): End Operator
Operator < (ByRef lhs As Vec2f, ByVal rhs As Float) As Integ: Return (lhs.x > rhs) And (lhs.y > rhs): End Operator
Operator > (ByRef lhs As Vec2f, ByVal rhs As Vec2f) As Integ: Return (lhs.x > rhs.x) And (lhs.y > rhs.y): End Operator
Operator > (ByRef lhs As Float, ByVal rhs As Vec2f) As Integ: Return (lhs > rhs.x) And (lhs > rhs.y): End Operator
Operator > (ByRef lhs As Vec2f, ByVal rhs As Float) As Integ: Return (lhs.x > rhs) And (lhs.y > rhs): End Operator

''  Vec2f non-member functions
Function absolute (ByRef lhs As Vec2f) As Vec2f: Return lhs.absolute(): End Function
Function normal (ByRef lhs As Vec2f) As Vec2f: Return lhs.normal(): End Function
Function rightnormal (ByRef lhs As Vec2f) As Vec2f: Return lhs.rightnormal(): End Function
Function leftnormal (ByRef lhs As Vec2f) As Vec2f: Return lhs.leftnormal(): End Function
Function normalised (ByRef lhs As Vec2f) As Vec2f: Return lhs.normalised(): End Function
Function normalisednormal(ByRef lhs As Vec2f) As Vec2f: Return lhs.normalisednormal(): End Function
Function magnitude (ByRef lhs As Vec2f) As Float: Return lhs.magnitude(): End Function
Function magnitudesquared (ByRef lhs As Vec2f) As Float: Return lhs.magnitudesquared(): End Function
Function distance (ByVal lhs As Vec2f, ByRef rhs As Vec2f) As Float: Return lhs.distance(rhs): End Function
Function distancesquared (ByVal lhs As Vec2f, ByRef rhs As Vec2f) As Float: Return lhs.distancesquared(rhs): End Function
Function dot (ByVal lhs As Vec2f, ByRef rhs As Vec2f) As Float: Return lhs.dot(rhs): End Function
Function dotnormal (ByVal lhs As Vec2f, ByRef rhs As Vec2f) As Float: Return lhs.dotnormal(rhs): End Function
Function project (ByVal lhs As Vec2f, ByRef rhs As Vec2f) As Vec2f: Return lhs.project(rhs): End Function
Function component(ByVal lhs As Vec2f, ByRef rhs As Vec2f) As Vec2f: Return lhs.component(rhs): End Function
Function randomise(ByVal lhs As Float) As Vec2f: Return Vec2f((Rnd-Rnd)*lhs, (Rnd-Rnd)*lhs): End Function
Function lerp(ByVal lhs As Vec2f, ByRef rhs As Vec2f, ByVal i As Float) As Vec2f: Return lhs.lerp(rhs, i): End Function
Function rotate(ByVal lhs As Vec2f, ByRef rhs As Vec2f) As Vec2f: Return lhs.rotate(rhs): End Function

''  Vec2i 2d Integer vector structure
Type Vec2i
	
  ''  Vec2i variables
  As Integ x, y
	
  ''  Vec2i constructor declarations
	Declare Constructor ()
  Declare Constructor (ByVal x As Integ, ByVal y As Integ)
  Declare Constructor (ByRef vec As Vec2i)
	
  ''  Vec2i compound arithmetic member operator declarations
  Declare Operator += (ByRef rhs As Vec2i)
  Declare Operator -= (ByRef rhs As Vec2i)
  Declare Operator *= (ByRef rhs As Vec2i)
  Declare Operator *= (ByVal rhs As Integ)
  Declare Operator \= (ByVal rhs As Integ)
  Declare Operator Let (ByRef rhs As Vec2i)
  
  ''  Vec2i member function declarations
  
End Type

''  Vec2i unary arithmetic non-member operator declarations
Declare Operator - (ByRef rhs As Vec2i) As  Vec2i

''  Vec2i binary arithmetic non-member operator declarations
Declare Operator + (ByRef lhs As Vec2i, ByRef rhs As Vec2i) As Vec2i
Declare Operator - (ByRef lhs As Vec2i, ByRef rhs As Vec2i) As Vec2i
Declare Operator * (ByVal lhs As Float, ByRef rhs As Vec2i) As Vec2i
Declare Operator * (ByRef lhs As Vec2i, ByVal rhs As Float) As Vec2i
Declare Operator \ (ByRef lhs As Vec2i, ByVal rhs As Float) As Vec2i

''  Vec2i non-member function declarations

''  Vec2i constructors
Constructor Vec2i(): This.x = 0: This.y = 0: End Constructor
Constructor Vec2i(ByVal x As Integ, ByVal y As Integ): This.x = x: This.y = y: End Constructor
Constructor Vec2i(ByRef vec As Vec2i): This.x = vec.x: This.y = vec.y: End Constructor

''  Vec2i compound arithmetic member operators
Operator Vec2i.+= (ByRef rhs As  Vec2i): This.x += rhs.x: This.y += rhs.y: End Operator
Operator Vec2i.-= (ByRef rhs As  Vec2i): This.x -= rhs.x: This.y -= rhs.y: End Operator
Operator Vec2i.*= (ByRef rhs As  Vec2i): This.x *= rhs.x: This.y *= rhs.y: End Operator
Operator Vec2i.*= (ByVal rhs As  Integ): This.x *= rhs: This.y *= rhs: End Operator
Operator Vec2i.\= (ByVal rhs As  Integ): This.x \= rhs: This.y \= rhs: End Operator
Operator Vec2i.let (ByRef rhs As  Vec2i): This.x = rhs.x: This.y = rhs.y: End Operator

''  Vec2i member functions

''  Vec2i unary arithmetic non-member operators
Operator - (ByRef rhs As Vec2i) As Vec2i: Return Vec2i(-rhs.x, -rhs.y): End Operator

''  Vec2i binary arithmetic non-member operators
Operator + (ByRef lhs As Vec2i, ByRef rhs As Vec2i) As Vec2i: Return Vec2i(lhs.x+rhs.x, lhs.y+rhs.y): End Operator
Operator - (ByRef lhs As Vec2i, ByRef rhs As Vec2i) As Vec2i: Return Vec2i(lhs.x-rhs.x, lhs.y-rhs.y): End Operator
Operator * (ByVal lhs As Integ, ByRef rhs As Vec2i) As Vec2i: Return Vec2i(lhs*rhs.x, lhs*rhs.y): End Operator
Operator * (ByRef lhs As Vec2i, ByVal rhs As Integ) As Vec2i: Return Vec2i(lhs.x*rhs, lhs.y*rhs): End Operator
Operator \ (ByRef lhs As Vec2i, ByVal rhs As Integ) As Vec2i: Return Vec2i(lhs.x\rhs, lhs.y\rhs): End Operator

''  Vec2i non-member functions

''  shared binary arithmetic non-member operator declarations
Declare Operator + (ByRef lhs As Vec2f, ByRef rhs As Vec2i) As Vec2f
Declare Operator + (ByRef lhs As Vec2i, ByRef rhs As Vec2f) As Vec2f
Declare Operator - (ByRef lhs As Vec2f, ByRef rhs As Vec2i) As Vec2f
Declare Operator - (ByRef lhs As Vec2i, ByRef rhs As Vec2f) As Vec2f

''  shared non-member function declarations

''  shared binary arithmetic non-member operators
Operator + (ByRef lhs As Vec2f, ByRef rhs As Vec2i) As Vec2f: Return Vec2f(lhs.x+rhs.x, lhs.y+rhs.y): End Operator
Operator + (ByRef lhs As Vec2i, ByRef rhs As Vec2f) As Vec2f: Return Vec2f(lhs.x+rhs.x, lhs.y+rhs.y): End Operator
Operator - (ByRef lhs As Vec2f, ByRef rhs As Vec2i) As Vec2f: Return Vec2f(lhs.x-rhs.x, lhs.y-rhs.y): End Operator
Operator - (ByRef lhs As Vec2i, ByRef rhs As Vec2f) As Vec2f: Return Vec2f(lhs.x-rhs.x, lhs.y-rhs.y): End Operator

''  shared non-member functions

