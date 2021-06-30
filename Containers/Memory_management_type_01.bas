'' Generic UDT Array memory management type


''	some type for demonstration
Type UDT
	Declare Constructor()
	Declare Constructor( ByVal D As Integer )
	As Integer Dummy_
End Type

Constructor UDT()
	Dummy_ = 0
End Constructor

Constructor UDT( ByVal D As Integer )
	Dummy_ = D
End Constructor



'' UDT Array memory management type
Type UDTArray
	
	Public:
	
	'' Constructors
	Declare Constructor()
	Declare Constructor( ByRef P As UDTArray )
	
	'' Destructor
	Declare Destructor()
	
	'' Operators
	Declare Operator Let( ByRef P As UDTArray )
	Declare Operator []( ByVal i as Integer ) As UDT Ptr
	
	'' Add
	Declare Function Add( ByRef P As UDT ) As UDT Ptr
	
	'' Get
	Declare Function Num   () As Integer
	Declare Function Max   () As Integer
	Declare Function Hi    () As UDT Ptr
	Declare Function Lo    () As UDT Ptr
	'Declare Function Index () As UDT Ptr
	
	'' 
	Declare Sub Allocate( ByVal Max As Integer )
	Declare Sub ResetAll()
	
	Private:
	
	'' Variables
	As Integer Num_   '' number of elements in use
	As Integer Max_   '' number of allocated elements
	As UDT Ptr Hi_    '' pointer to last elemet
	As UDT Ptr Lo_    '' pointer to first element
	As UDT Ptr Index_ '' array index
	
End Type



'' Main test program

Dim As UDTArray Array1

Print Array1.Num()
Print Array1.Max()

Array1.Allocate( 10 )

For i As Integer = 0 To 9
	
	Array1.Add( UDT( i ) )
	
Next

Dim As UDTArray Array2 = Array1

Dim As UDTArray Array3 = UDTArray( Array2 )

Print Array1.Num()
Print Array1.Max()

Print Array2.Num()
Print Array2.Max()

Print Array3.Num()
Print Array3.Max()

''	for-loop using udt pointers directly. Is this safe?
For i As UDT Ptr = Array3.Lo To Array3.Hi
	
	Print i->Dummy_
	
Next

''
For i As Integer = 0 To Array1.Num
	
	Print Array1[i]->Dummy_
	
Next


Sleep



'' Constructors
Constructor UDTArray()
	
	'ResetAll()
	
End Constructor

Constructor UDTArray( ByRef P As UDTArray )
	
	'ResetAll()
	
	This = P
	
End Constructor


'' Destructor
Destructor UDTArray()
	
	ResetAll()
	
End Destructor


'' Operators
Operator UDTArray.Let( ByRef P As UDTArray )
	
	''	TO-do: reorganize to make self-assignment safe
	
	ResetAll()
		
	Max_ = P.Max
	
	Allocate( Max_ )
	
	For I As UDT Ptr = P.Lo To P.Hi
		
		Add( *I )
		
	Next
	
End Operator

Operator UDTArray.[]( ByVal i as Integer ) As UDT Ptr
	
	If ( i < 0 Or i > Num_ ) Then Return 0
	
	Return @index_[ i ]
	
End Operator


'' Functions
Function UDTArray.Add( ByRef P As UDT ) As UDT Ptr
	
	If ( Num_ >= Max_ ) Then Return 0
	
	Hi_ = @Index_[ Num_ ]
	
	*Hi_ = P
	
	Num_ += 1
	
	Return Hi_
	
End Function


'' Get
Function UDTArray.Num() As Integer
	
	Return Num_
	
End Function

Function UDTArray.Max() As Integer
	
	Return Max_
	
End Function

Function UDTArray.Hi() As UDT Ptr
	
	Return Hi_
	
End Function

Function UDTArray.Lo() As UDT Ptr
	
	Return Lo_
	
End Function

'Function UDTArray.Index() As UDT Ptr
'	
'	Return Index_
'	
'End Function


''
Sub UDTArray.Allocate( ByVal M As Integer )
	
	If ( M > 0 ) Then
		
		Max_ = M
		Num_ = 0
		
		Index_ = New UDT[ Max_ ]
		
		Hi_ = @Index_[ 0 ]
		Lo_ = @Index_[ 0 ]
		
	End If
	
End Sub

Sub UDTArray.ResetAll()
	
	Max_   = 0
	Num_   = 0
	Hi_    = 0
	Lo_    = 0
	
	If ( Index_ > 0 ) Then Delete[] Index_
	
	Index_ = 0
	
End Sub
