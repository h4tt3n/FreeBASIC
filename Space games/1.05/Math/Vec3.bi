''*******************************************************************************
''    
''   FreeBASIC 3D Floating Point Vector Library
''   Version 1.1.0, October 2015, Michael "h4tt3n" Nissen
''   
''   Function syntax:
''    
''   (Return Type) (Name) (Argument Type (, ...)) (Description)
''    
''   Function syntax:
''
''   Library supports both member and non-member function useage:
''
''   A.function(B) <=> function(A, B)
''
''*******************************************************************************

Type Vec3
	
	Public:
	
	''  constructor declarations
	Declare Constructor ()
	Declare Constructor ( ByRef A As Const Vec3 )
	Declare Constructor ( ByVal x As Const Single, _
	                      ByVal y As Const Single, _
	                      ByVal z As Const Single )
	
	''
	Declare Operator Let ( ByRef v As Vec3 )
	
	''  compound arithmetic member operator declarations
	Declare Operator +=  ( ByRef A As Const Vec3   )
	Declare Operator -=  ( ByRef A As Const Vec3   )
	Declare Operator *=  ( ByVal A As Const Single )
	Declare Operator /=  ( ByVal A As Const Single )
	
	''  member function declarations
	Declare Const Function Absolute      () As Vec3
	Declare Const Function Normalized    () As Vec3
	Declare Const Function Length        () As Single
	Declare Const Function LengthSquared () As Single
	Declare Const Function Dot           ( ByRef B As Const Vec3 ) As Single
	Declare Const Function Cross         ( ByRef B As Const Vec3 ) As Vec3
	
	''	variables
	As Single x, y, z

End Type


''  Vec3 unary arithmetic non-member operator declarations
Declare Operator - ( ByRef B As Const Vec3 ) As Vec3


''  Vec3 binary arithmetic non-member operator declarations
Declare Operator + ( ByRef A As Const Vec3  , ByRef B As Const Vec3   ) As Vec3
Declare Operator - ( ByRef A As Const Vec3  , ByRef B As Const Vec3   ) As Vec3
Declare Operator * ( ByVal A As Const Single, ByRef B As Const Vec3   ) As Vec3
Declare Operator * ( ByRef A As Const Vec3  , ByVal B As Const Single ) As Vec3
Declare Operator / ( ByRef A As Const Vec3  , ByVal B As Const Single ) As Vec3


''  Vec3 non-member function declarations
Declare Function Absolute      ( ByRef A As Const Vec3 ) As Vec3
Declare Function Normalized    ( ByRef A As Const Vec3 ) As Vec3
Declare Function Length        ( ByRef A As Const Vec3 ) As Single
Declare Function LengthSquared ( ByRef A As Const Vec3 ) As Single
Declare Function Dot           ( ByVal A As Const Vec3, ByRef B As Const Vec3 ) As Single
Declare Function Cross         ( ByVal A As Const Vec3, ByRef B As Const Vec3 ) As Vec3


''  Vec3 constructors
Constructor Vec3()
	
	This.x = 0.0 : This.y = 0.0 : This.z = 0.0
	  
End Constructor

Constructor Vec3( ByVal x As Const Single, _
                  ByVal y As Const Single, _
                  ByVal z As Const Single )
	
	This.x = x : This.y = y : This.z = z
	
End Constructor

Constructor Vec3( ByRef v As Const Vec3 )
	
	This = v
	
End Constructor


''  Vec3 compound arithmetic member operators
Operator Vec3.Let ( ByRef A As Const Vec3 )
	
	If ( @This <> @A ) Then
		
		This.x = A.x : This.y = A.y : This.z = A.z
		
	EndIf
	
End Operator

Operator Vec3.+= ( ByRef A As Const Vec3 )
	
	If ( @This <> @A ) Then
		
		This.x += A.x : This.y += A.y : This.z += A.z
		
	EndIf
	
End Operator

Operator Vec3.-= ( ByRef A As Const Vec3 )
	
	If ( @This <> @A ) Then
		
		This.x -= A.x : This.y -= A.y : This.z -= A.z
		
	EndIf
	
End Operator

Operator Vec3.*= ( ByVal A As Const Single )
	
	This.x *= A : This.y *= A: This.z *= A
	
End Operator

Operator Vec3./= ( ByVal A As Const Single )
	
	This.x /= A : This.y /= A : This.z /= A
	
End Operator


''
Function Vec3.Normalized() As Vec3
	
	Return IIf( This = Vec3( 0.0, 0.0, 0.0 ) , Vec3( 0.0, 0.0, 0.0 ) , This / This.Length() )
	
End Function

Function Vec3.Length() As Single
	
	Return sqr( This.LengthSquared() )
	
End Function

Function Vec3.LengthSquared() As Single
	
	Return This.Dot( This )
	
End Function

Function Vec3.Dot( ByRef B As Const Vec3 ) As Single
	
	Return ( This.x * B.x + This.y * B.y + This.z * B.z )
	
End Function

Function Vec3.Cross( ByRef B As Const Vec3 ) As Vec3
	
	Return Vec3( This.y * B.z - This.z * B.y, _
					 This.z * B.x - This.x * B.z, _
					 This.x * B.y - This.y * B.x )
								
End Function


''  Vec3 unary arithmetic non-member operators
Operator - ( ByRef B As Vec3 ) As Vec3
	
	Return Vec3( -B.x, -B.y, -B.z) 
	
End Operator


''  Vec3 binary arithmetic non-member operators
Operator + ( ByRef A As Const Vec3, ByRef B As Const Vec3 ) As Vec3
	
	Return Vec3( A.x + B.x, A.y + B.y, A.z + B.z )
	
End Operator

Operator - ( ByRef A As Const Vec3, ByRef B As Const Vec3 ) As Vec3
	
	Return Vec3( A.x - B.x, A.y - B.y, A.z - B.z )
	
End Operator

Operator * ( ByVal A As Const Single, ByRef B As Const Vec3 ) As Vec3
	
	Return Vec3( A * B.x, A * B.y, A * B.z )
	
End Operator

Operator * ( ByRef A As Const Vec3, ByVal B As Const Single) As Vec3
	
	Return Vec3( A.x * B, A.y * B, A.z * B )
	
End Operator

Operator / ( ByRef A As Const Vec3, ByVal B As Const Single) As Vec3
	
	Return Vec3( A.x / B, A.y / B, A.z / B )
	
End Operator


''  Vec3 non-member functions
Function Normalized( ByRef A As Const Vec3 ) As Vec3
	
	Return A.Normalized()
	
End Function

Function Length( ByRef A As Const Vec3 ) As Single
	
	Return A.Length()
	
End Function

Function LengthSquared( ByRef A As Const Vec3 ) As Single
	
	Return A.LengthSquared()
	
End Function

Function Dot( ByRef A As Const Vec3, ByRef B As Const Vec3 ) As Single
	
	Return A.Dot()
	
End Function

Function Cross( ByRef A As Const Vec3, ByRef B As Const Vec3 ) As Vec3
	
	Return A.Cross()
	
End Function
