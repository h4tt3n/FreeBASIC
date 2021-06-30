''*******************************************************************************
''     
''   FreeBASIC Three by Three Column Vector Matrix Library
''   Version 0.1.0, September 2019, Michael "h4tt3n" Nissen
''
''       [ m(1,1)   m(1,2)   m(1,3) ]
''       [                          ]
''   M = [ m(2,1)   m(2,2)   m(2,3) ]
''       [                          ]
''       [ m(3,1)   m(3,2)   m(3,3) ]
''
''   Function syntax:
''   
''   (Return Type) (Name) (Argument Type (, ...)) (Description)
''
''   Matrix  Absolute     ( Matrix )         Absolute (positive) values
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
#Include "Vec3.bi"


Type Mat33
	
	Public:
	
	''
	Declare Constructor ()
	
	Declare Constructor ( ByRef M As Const Mat33 )
	
	Declare Constructor ( ByRef C1 As Const Vec3, ByRef C2 As Const Vec3, ByRef C3 As Const Vec3 )
	
	Declare Constructor ( ByVal C1_x As Const Single, ByVal C2_x As Const Single, ByVal C3_x As Const Single, _
	                      ByVal C1_y As Const Single, ByVal C2_y As Const Single, ByVal C3_y As Const Single, _
	                      ByVal C1_Z As Const Single, ByVal C2_Z As Const Single, ByVal C3_Z As Const Single )
	
	''
	Declare Destructor()
	
	''
	Declare Operator Let ( ByRef M As Const Mat33 )
	
	''
   Declare Operator +=  ( ByRef M As Const Mat33  )
   Declare Operator -=  ( ByRef M As Const Mat33  )
   Declare Operator *=  ( ByVal A As Const Single )
   
   ''
	Declare Const Function Absolute_   () As Mat33
	Declare Const Function Determinant () As Single
	Declare Const Function Inverse     () As Mat33
	Declare Const Function Transpose   () As Mat33
	
	''
	Declare Sub MakeIdentity ()
	Declare Sub MakeZero     ()
	
	'Private:
	
	'' Column vectors
	As Vec3 C1, C2, C3
	
End Type

''
Declare Operator - ( ByRef M As Const Mat33 ) As Mat33

''
Declare Operator + ( ByRef A As Const Mat33 , ByRef B As Const Mat33  ) As Mat33
Declare Operator - ( ByRef A As Const Mat33 , ByRef B As Const Mat33  ) As Mat33

''
Declare Function Absolute_ OverLoad ( ByRef A As Const Mat33 ) As Mat33
Declare Function Determinant        ( ByRef A As Const Mat33 ) As Single
Declare Function Inverse            ( ByRef A As Const Mat33 ) As Mat33
Declare Function Transpose          ( ByRef A As Const Mat33 ) As Mat33

''
Declare Sub MakeIdentity           ( ByRef A As Mat33 )
Declare Sub MakeZero               ( ByRef A As Mat33 )


''
Constructor Mat33()
	
	This.C1.x = 0.0 : This.C2.x = 0.0 : This.C3.x = 0.0
	This.C1.y = 0.0 : This.C2.y = 0.0 : This.C3.y = 0.0
	This.C1.z = 0.0 : This.C2.z = 0.0 : This.C3.z = 0.0
	
End Constructor

Constructor Mat33( ByRef M As Const Mat33 )
	
	This = M
	
End Constructor

Constructor Mat33( ByRef C1 As Const Vec3, ByRef C2 As Const Vec3, ByRef C3 As Const Vec3 )
	
	This.C1 = C1 : This.C2 = C2 : This.C3 = C3
	
End Constructor

Constructor Mat33( ByVal C1_x As Const Single, ByVal C2_x As Const Single, ByVal C3_x As Const Single, _
                   ByVal C1_y As Const Single, ByVal C2_y As Const Single, ByVal C3_y As Const Single, _
	                ByVal C1_Z As Const Single, ByVal C2_Z As Const Single, ByVal C3_Z As Const Single )
	
	This.C1.x = C1_x : This.C2.x = C2_x : This.C3_x = C3_x
	This.C1.y = C1_y : This.C2.y = C2_y : This.C3_y = C3_y
	This.C1.z = C1_z : This.C2.z = C2_z : This.C3_z = C3_z
	
End Constructor


''
Destructor Mat33()

End Destructor


''
Operator Mat33.Let ( ByRef M As Const Mat33 )
	
	If ( @This <> @M ) Then
		
		This.C1 = M.C1 : This.C2 = M.C2 : This.C3 = M.C3
		
	EndIf
	
End Operator

Operator Mat33.+= ( ByRef M As Const Mat33 )
	
	If ( @This <> @M ) Then
		
		This.C1 += M.C1 : This.C2 += M.C2 : This.C3 += M.C3
		
	End If
	
End Operator

Operator Mat33.-= ( ByRef M As Const Mat33 )
	
	If ( @This <> @M ) Then
		
		This.C1 -= M.C1 : This.C2 -= M.C2 : This.C3 -= M.C3
		
	End If
	
End Operator

Operator Mat33.*= ( ByVal A As Const Single )
	
	This.C1 *= A : This.C2 *= A : This.C3 *= A
	
End Operator


''
Function Mat33.Absolute_() As Mat33
	
	Return Mat33( This.C1.Absolute_(), This.C2.Absolute_(), This.C3.Absolute_() )
	
End Function

Function Mat33.Determinant() As Single
	
	Return 0.0
	
End Function

Function Mat33.Inverse() As Mat33
	
   Return Mat33()
   
End Function

Function Mat33.Transpose() As Mat33
	
	Return Mat33()
	
End Function


''
Sub Mat33.MakeIdentity()
	
	This = Mat33( Vec3( 1.0, 0.0, 0.0 ), Vec3( 0.0, 1.0, 0.0 ), Vec3( 0.0, 0.0, 1.0 ) )
	
End Sub

Sub Mat33.MakeZero()
	
	This = Mat33( Vec3( 0.0, 0.0, 0.0 ), Vec3( 0.0, 0.0, 0.0 ), Vec3( 0.0, 0.0, 0.0 ) )
	
End Sub


''
Operator - ( ByRef M As Const Mat33 ) As Mat33
	
	Return Mat33( -M.C1, -M.C2, -M.C3 )
	
End Operator


'' 
Operator + ( ByRef A As Const Mat33, ByRef B As Const Mat33 ) As Mat33
	
	Return Mat33( Vec3( A.C1 + B.C1 ), Vec3( A.C2 + B.C2 ), Vec3( A.C3 + B.C3 ) )
	
End Operator

Operator - ( ByRef A As Const Mat33, ByRef B As Const Mat33 ) As Mat33
	
	Return Mat33( Vec3( A.C1 - B.C1 ), Vec3( A.C2 - B.C2 ), Vec3( A.C3 - B.C3 ) )
	
End Operator


''
Function Absolute_( ByRef A As Const Mat33 ) As Mat33
	
	Return A.Absolute_()
	
End Function

Function Determinant( ByRef A As Const Mat33 ) As Single
	
	Return A.Determinant()
	
End Function

Function Inverse( ByRef A As Const Mat33 ) As Mat33
	
	Return A.Inverse()
	
End Function

Function Transpose( ByRef A As Const Mat33 ) As Mat33
	
	Return A.Transpose()
	
End Function


''
Sub MakeIdentity( ByRef A As Mat33 )
	
	A.MakeIdentity()
	
End Sub

Sub MakeZero( ByRef A As Mat33 )
	
	A.MakeZero()
	
End Sub
