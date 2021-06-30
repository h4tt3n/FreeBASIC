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
	Declare Operator [] ( ByVal i as Integer ) As UDT Ptr
	
	'' 
	Declare Function push_back( ByRef P As UDT ) As UDT Ptr
	Declare Function size     () As Integer
	Declare Function capacity () As Integer
	Declare Function back     () As UDT Ptr
	Declare Function front    () As UDT Ptr
	
	'' 
	Declare Sub reserve( ByVal C As Integer )
	Declare Sub clear()
	Declare Sub shuffle()
	
	Private:
	
	'' Variables
	As Integer size_      '' number of elements in use
	As Integer capacity_  '' number of Reserved elements
	As UDT Ptr back_      '' pointer to last elemet
	As UDT Ptr front_     '' pointer to first element
	As UDT Ptr index_     '' array index
	
End Type



'' Test program

Randomize

Dim As UDTArray Array1

Print Array1.size()
Print Array1.capacity()

Array1.reserve( 10 )

For i As Integer = 0 To 9
	
	Array1.push_back( UDT( i ) )
	
Next

Dim As UDTArray Array2 = Array1

Dim As UDTArray Array3 = UDTArray( Array2 )

Print Array3.size()
Print Array3.capacity()

''	for-next loop using front-back UDT pointers (Safe)
For i As UDT Ptr = Array3.front To Array3.back
	
	Print i->Dummy_ ;
	
Next

Do
	
	Array3.shuffle()
	
	Print
	
	''	for-next loop using operator[] (Unsafe, no boundary check)
	For i As Integer = 0 To Array3.size - 1
		
		'If Array3[i]->Dummy_ = 9 Then
			
			Print Array3[i]->Dummy_ ;
			
		'Else
			
		'	Print "  ";
			
		'End If
		
	Next
	
	Sleep 200, 1

Loop Until MultiKey(1)

Sleep



'' Constructors
Constructor UDTArray()
	
	Clear()
	
End Constructor

Constructor UDTArray( ByRef P As UDTArray )
	
	Clear()
	
	This = P
	
End Constructor


'' Destructor
Destructor UDTArray()
	
	Clear()
	
End Destructor


'' Operators
Operator UDTArray.Let( ByRef P As UDTArray )
	
	''	TO-do: reorganize to make self-assignment safe
	
	Clear()
		
	Capacity_ = P.Capacity
	
	Reserve( Capacity_ )
	
	For I As UDT Ptr = P.Front To P.Back
		
		Push_Back( *I )
		
	Next
	
End Operator

Operator UDTArray.[]( ByVal i as Integer ) As UDT Ptr
	
	Return index_ + i
	
End Operator


'' Functions
Function UDTArray.push_back( ByRef P As UDT ) As UDT Ptr
	
	If ( Size_ >= Capacity_ ) Then Return 0
		
	Back_ = Index_ + Size_
	
	*Back_ = P
	
	Size_ += 1
	
	Return Back_
	
End Function


'' Get
Function UDTArray.size() As Integer
	
	Return Size_
	
End Function

Function UDTArray.Capacity() As Integer
	
	Return Capacity_
	
End Function

Function UDTArray.Back() As UDT Ptr
	
	Return Back_
	
End Function

Function UDTArray.Front() As UDT Ptr
	
	Return Front_
	
End Function


''
Sub UDTArray.Reserve( ByVal C As Integer )
	
	If ( C > 0 ) Then
		
		Capacity_ = C
		Size_     = 0
		
		Index_ = New UDT[ Capacity_ ]
		
		Back_  = Index_
		Front_ = Index_
		
	End If
	
End Sub

Sub UDTArray.Clear()
	
	Capacity_ = 0
	Size_     = 0
	Back_     = 0
	Front_    = 0
	
	If ( Index_ > 0 ) Then Delete[] Index_
	
	Index_ = 0
	
End Sub

Sub UDTArray.shuffle()
	
	''	Hi-to-Lo Fisher-Yates shuffle
	
	For I As Integer = Size_ - 1 To 1 Step - 1
		
		Dim As Integer J = Cast( Integer, Rnd() * I ) 
		
		Dim As UDT temp = Index_[I]
		
		Index_[I] = Index_[J]
		Index_[J] = temp
		
	Next
	
End Sub
