
''
#Include Once "Matrix22.bi"

Dim As Single S

Dim As Vec2 V
Dim As Vec2 Col1 = Vec2( 1.0, 2.0 )
Dim As Vec2 Col2 = Vec2( 3.0, 4.0 )


'' Construct from Scalars
Dim As Mat22 A = Mat22( 1.0, 3.0, _
								2.0, 4.0 ) 

''	Construct from Vectors
Dim As Mat22 B = Mat22( Col1, Col2 )

'' Construct from Matrix
Dim As Mat22 C = -Mat22( B ) 

''	Default constructor
Dim As Mat22 D

''	Print Matrices
A.PrintMatrix: Print
B.PrintMatrix: Print
C.PrintMatrix: Print
D.PrintMatrix: Print

''	Let ( = )
D = A
D.PrintMatrix: Print

''	Matrix-Matrix +=
D += B
D.PrintMatrix: Print

''	Matrix-Matrix -=
D -= C
D.PrintMatrix: Print

''	Matrix-Scalar *=
D *= 10.0
D.PrintMatrix: Print

'' Determinant
Print D.Determinant(): Print

'' Inverse
B.PrintMatrix: Print
D = B.Inverse()
D.PrintMatrix: Print

B = Mat22( 42.0, 66.6, _
			 -11.0, 76.0 ) 
			 
D = B.Inverse()
D.PrintMatrix: Print

''	Transpose
D = A.Transpose()

D = D.Transpose()
D.PrintMatrix: Print

''	Matrix-Matrix Multiply
B = Mat22( 1.0, 3.0, _
			  2.0, 4.0 ) 

A.PrintMatrix: Print
B.PrintMatrix: Print
D = A * B
D.PrintMatrix: Print

B = Mat22(  42.0, 66.6, _
			  -11.0, 76.0 ) 
D = A * B
D.PrintMatrix: Print

D = B * A
D.PrintMatrix: Print

Col1 = Vec2( 9.0, 8.0 )

B = Mat22( 7.0, 5.0, _
			  6.0, 4.0 ) 

'' Matrix-Vector Multiply
B.PrintMatrix: Print
Print Col1.x; Col1.y

'V = B * Col1
V = Col1 * B

Print V.x; V.y

'' Matrix-scalar multiplication
S = 0.5

B.PrintMatrix: Print
Print S

A = S * B

A.PrintMAtrix(): Print

''
A.MakeIdentity()
A.PrintMAtrix(): Print

A.MakeZero()
A.PrintMAtrix(): Print

A.MakeRotation( 0.5 * Atn(1.0) )
A.PrintMAtrix(): Print

Dim As Vec2 Ang = Vec2( 205.7, -876.9 ).Unit()

A.MakeRotation( Ang )
A.PrintMAtrix(): Print

Sleep

End