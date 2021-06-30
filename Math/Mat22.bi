''*******************************************************************************
''     
''   FreeBASIC Two by Two Column Vector Matrix Library
''   Version 1.2.0, October 2016, Michael "h4tt3n" Nissen
''
''       [ m(1,1)   m(1,2) ]
''   M = [                 ]
''       [ m(2,1)   m(2,2) ]
''
''   Function syntax:
''   
''   (Return Type) (Name) (Argument Type (, ...)) (Description)
''
''   Matrix  Absolute_     ( Matrix )         Absolute_ (positive) values
''   Scalar  Determinant  ( Matrix )         Determinant
''   Matrix  Inverse      ( Matrix )         Inverse Matrix
''   Matrix  Transpose    ( Matrix )         Transpose
''
''   (void)  MakeIdentity ( Matrix )         Creates idendity matrix
''   (void)  MakeRotation ( Matrix, Scalar ) Creates rotation matrix from angle
''   (void)  MakeRotation ( Matrix, Vector ) Creates rotation matrix from unit vector
''   (void)  MakeZero     ( Matrix )         Creates Zero Matrix
''
''   Library supports both member and non-member function useage:
''
''   A.function(B) <=> function(A, B)
''
''*******************************************************************************

#Pragma Once

''
#Include "Vec2.bi"

''
Type Mat22
	
	Public:
	
	''
	Declare Constructor ()
	
	Declare Constructor ( ByRef M As Const Mat22 )
	
	Declare Constructor ( ByRef C1 As Const Vec2, ByRef C2 As Const Vec2 )
	
	Declare Constructor ( ByVal C1_x As Const Single, ByVal C2_x As Const Single, _
	                      ByVal C1_y As Const Single, ByVal C2_y As Const Single )
	
	''
	Declare Destructor()
	
	''
	Declare Operator Let ( ByRef M As Const Mat22  )
	
	''
   Declare Operator +=  ( ByRef M As Const Mat22  )
   Declare Operator -=  ( ByRef M As Const Mat22  )
   Declare Operator *=  ( ByVal A As Const Single )
	
	''
	Declare Const Function Absolute_    () As Mat22
	Declare Const Function Determinant () As Single
	Declare Const Function Inverse     () As Mat22
	Declare Const Function Transpose   () As Mat22
	
	''
	Declare Const Function Row1() As Vec2
	Declare Const Function Row2() As Vec2
	
	''
	Declare Sub MakeIdentity ()
	Declare Sub MakeRotation ( ByRef A As Const Vec2   )
	Declare Sub MakeRotation ( ByVal A As Const Single )
	Declare Sub MakeZero     ()
	
	''
	Declare Sub PrintMatrix
	
	''	
	As Vec2 C1, C2
	
End Type

''
Declare Operator - ( ByRef M As Const Mat22 ) As Mat22

''
Declare Operator + ( ByRef A As Const Mat22 , ByRef B As Const Mat22  ) As Mat22
Declare Operator - ( ByRef A As Const Mat22 , ByRef B As Const Mat22  ) As Mat22
Declare Operator * ( ByRef A As Const Mat22 , ByRef B As Const Mat22  ) As Mat22
Declare Operator * ( ByRef A As Const Mat22 , ByRef B As Const Vec2   ) As Vec2
Declare Operator * ( ByRef A As Const Vec2  , ByRef B As Const Mat22  ) As Vec2
Declare Operator * ( ByRef A As Const Mat22 , ByVal B As Const Single ) As Mat22
Declare Operator * ( ByVal A As Const Single, ByRef B As Const Mat22  ) As Mat22

''
Declare Function Absolute_ OverLoad ( ByRef A As Const Mat22 ) As Mat22
Declare Function Determinant       ( ByRef A As Const Mat22 ) As Single
Declare Function Inverse           ( ByRef A As Const Mat22 ) As Mat22
Declare Function Transpose         ( ByRef A As Const Mat22 ) As Mat22

''
Declare Sub MakeIdentity           ( ByRef A As Mat22 )
Declare Sub MakeRotation  OverLoad ( ByRef A As Mat22, ByRef B As Const Vec2   )
Declare Sub MakeRotation           ( ByRef A As Mat22, ByVal B As Const Single )
Declare Sub MakeZero               ( ByRef A As Mat22 )


''
Constructor Mat22
	
	This.C1.x = 0.0 : This.C2.x = 0.0
	This.C1.y = 0.0 : This.C2.y = 0.0
	
End Constructor

Constructor Mat22 ( ByRef M As Const Mat22 )
	
	This = M
	
End Constructor

Constructor Mat22 ( ByRef C1 As Const Vec2, ByRef C2 As Const Vec2 )
	
	This.C1 = C1 : This.C2 = C2
	
End Constructor

Constructor Mat22 ( ByVal C1_x As Const Single, ByVal C2_x As Const Single, _
	                 ByVal C1_y As Const Single, ByVal C2_y As Const Single )
	
	This.C1.x = C1_x : This.C2.x = C2_x
	This.C1.y = C1_y : This.C2.y = C2_y
	
End Constructor


''
Destructor Mat22()
	
End Destructor


''
Operator Mat22.Let ( ByRef M As Const Mat22 )
	
	If ( @This <> @M ) Then
		
		This.C1 = M.C1 : This.C2 = M.C2
		
	EndIf
	
End Operator

Operator Mat22.+= ( ByRef M As Const Mat22 )
	
	If ( @This <> @M ) Then
		
		This.C1 += M.C1 : This.C2 += M.C2
		
	End If
	
End Operator

Operator Mat22.-= ( ByRef M As Const Mat22 )
	
	If ( @This <> @M ) Then
		
		This.C1 -= M.C1 : This.C2 -= M.C2
		
	End If
	
End Operator

Operator Mat22.*= ( ByVal A As Const Single )
	
	This.C1 *= A : This.C2 *= A
	
End Operator


''
Function Mat22.Absolute_() As Mat22
	
	Return Mat22( This.C1.Absolute_(), This.C2.Absolute_() )
	
End Function

Function Mat22.Determinant() As Single
	
	Return This.C1.PerpDot( This.C2 )
	
End Function

Function Mat22.Inverse() As Mat22
	
	''
	Dim As Mat22  T = This.Transpose()
	Dim As Single d = This.Determinant()
	Dim As Single inv_d = IIf( d <> 0.0 , 1.0 / d , 0.0 )
	
   Return Mat22( Mat22( -T.C2.PerpCCW(), T.C1.PerpCCW() ) * inv_d )
   
   ''
   'Dim As Single a, b, c, d
	'
	'a = c1.x : b = c2.x
	'c = c1.y : d = c2.y
	'
	'Dim As Mat22 M
	'Dim As Single det = a * d - b * c
	''Dim As Single det = Cross(col1, col2)
	'
	'Dim As Single inv_det = IIf( det <> 0.0 , 1.0 / det , 0.0 )
	'
	'M.c1.x =  d : M.c2.x = -b
	'M.c1.y = -c : M.c2.y =  a

	'Return inv_det * M
   
End Function

Function Mat22.Transpose() As Mat22
	
	Return Mat22( Vec2( This.C1.x, This.C2.x ), Vec2( This.C1.y, This.C2.y ) )
	
End Function


''
Sub Mat22.MakeIdentity()
	
	This = Mat22( Vec2( 1.0, 0.0 ), Vec2( 0.0, 1.0 ) )
	
End Sub

Sub Mat22.MakeRotation( ByRef A As Const Vec2 )
	
	This = Mat22( A, A.PerpCCW() )
	
End Sub

Sub Mat22.MakeRotation( ByVal A As Const Single )
	
	Dim As Vec2 n = Vec2( Cos( A ), Sin( A ) )
	
	This = Mat22( n, n.PerpCCW() )
	
End Sub

Sub Mat22.MakeZero()
	
	This = Mat22( Vec2( 0.0, 0.0 ), Vec2( 0.0, 0.0 ) )
	
End Sub

''
Sub Mat22.PrintMatrix()
	
	Print Using " ###.### "; This.C1.x; " ###.### "; This.C2.x
	Print Using " ###.### "; This.C1.y; " ###.### "; This.C2.y
	
End Sub


''
Operator - ( ByRef M As Const Mat22 ) As Mat22
	
	Return Mat22( -M.C1, -M.C2 )
	
End Operator


'' 
Operator + ( ByRef A As Const Mat22, ByRef B As Const Mat22 ) As Mat22
	
	Return Mat22( Vec2( A.C1 + B.C1 ),  Vec2( A.C2 + B.C2 ) )
	
End Operator

Operator - ( ByRef A As Const Mat22, ByRef B As Const Mat22 ) As Mat22
	
	Return Mat22( Vec2( A.C1 - B.C1 ),  Vec2( A.C2 - B.C2 ) )
	
End Operator

Operator * ( ByRef A As Const Mat22, ByRef B As Const Mat22 ) As Mat22
	
	Return Mat22( Vec2( A * B.C1 ), Vec2( A * B.C2 ) )
	
End Operator

Operator * ( ByRef A As Const Mat22, ByRef B As Const Vec2 ) As Vec2
	
	Return Vec2( A.C1.Dot( B ), A.C2.Dot( B ) )
	
End Operator

Operator * ( ByRef A As Const Vec2, ByRef B As Const Mat22 ) As Vec2
	
	Dim As Mat22 M = B.Transpose()
	
	Return Vec2( A.Dot( M.C1 ), A.Dot( M.C2 ) )
	
End Operator

Operator * ( ByRef A As Const Mat22, ByVal B As Const Single ) As Mat22
	
	Return Mat22( Vec2( A.C1 * B ), Vec2( A.C2 * B ) )
	
End Operator

Operator * ( ByVal A As Const Single, ByRef B As Const Mat22 ) As Mat22
	
	Return Mat22( B * A )
	
End Operator


''
Function Absolute_( ByRef A As Const Mat22 ) As Mat22
	
	Return A.Absolute_()
	
End Function

Function Determinant( ByRef A As Const Mat22 ) As Single
	
	Return A.Determinant()
	
End Function

Function Inverse( ByRef A As Const Mat22 ) As Mat22
	
	Return A.Inverse()
	
End Function

Function Transpose( ByRef A As Const Mat22 ) As Mat22
	
	Return A.Transpose()
	
End Function


''
Function Mat22.Row1() As Vec2
	
	Return Vec2( C1.x, C2.x )
	
End Function

Function Mat22.Row2() As Vec2
	
	Return Vec2( C1.y, C2.y )
	
End Function


''
Sub MakeIdentity( ByRef A As Mat22 )
	
	A.MakeIdentity()
	
End Sub

Sub MakeRotation( ByRef A As Mat22, ByRef B As Const Vec2 )
	
	A.MakeRotation( B )
	
End Sub

Sub MakeRotation( ByRef A As Mat22, ByVal B As Const Single )
	
	A.MakeRotation( B )
	
End Sub

Sub MakeZero( ByRef A As Mat22 )
	
	A.MakeZero()
	
End Sub
