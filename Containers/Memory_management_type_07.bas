'' Generic UDT Array memory management type

'' In this version, add delete function


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
	Declare Sub Remove ( ByVal e As Integer )
	Declare Sub Remove ( ByVal p As UDT Ptr )
	
	Declare Sub reserve ( ByVal c As Integer )
	Declare Sub resize  ( ByVal c As Integer )
	Declare Sub Clear   ()
	Declare Sub shuffle ()
	
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


Array1.reserve( 10 )

For i As Integer = 0 To Array1.Capacity-1
	
	Array1.push_back( UDT( i ) )
	
Next


Dim As UDTArray Array2 = Array1


For i As UDT Ptr = Array2.front To Array2.back
	
	Print i->Dummy_ ;
	
Next

Print

Print Array2.Size

Print


'' program crashes when removing last element.
Array2.Remove( 9 )
'Array2.Remove( 0 )
'Array2.Remove( 0 )
'Array2.Remove( 0 )
'Array2.Remove( 0 )
'Array2.Remove( 0 )
'Array2.Remove( 0 )
'Array2.Remove( 0 )
'Array2.Remove( 0 )

''
Dim As UDT Ptr x = Array2[0]

''
Array2.Remove( x )

Print Array2.Size

Print

For i As UDT Ptr = Array2.front To Array2.back
	
	Print i->Dummy_ ;
	
Next

'Array2.resize(5)
Array2.Shuffle

Print

For i As UDT Ptr = Array2.front To Array2.back
	
	Print i->Dummy_ ;
	
Next


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
	
	If ( @This <> @p ) Then
		
		Reserve( P.Capacity )
		
		For I As UDT Ptr = P.Front To P.Back
			
			Push_Back( *I )
			
		Next
		
	End If
	
End Operator

Operator UDTArray.[]( ByVal i as Integer ) As UDT Ptr
	
	If ( i >= 0 ) And ( i < Size_ ) Then
		
		Return index_ + i
		
	EndIf
	
End Operator


'' Functions
Function UDTArray.push_back( ByRef P As UDT ) As UDT Ptr
	
	If ( Size_ < Capacity_ ) Then
			
		Back_ = Index_ + Size_
		
		*Back_ = P
		
		Size_ += 1
		
		Return Back_
		
	Else
			
		Return FALSE
	
	End If
	
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
Sub UDTArray.Remove( ByVal e As Integer )
	
	If ( e >= 0 ) And ( e < Size_ ) Then
		
		Dim As UDTArray temp
		
		temp.Reserve( Size_ - 1 )
		
		For i As Integer = 0 To Size_ - 1
			
			If ( i <> e ) Then temp.Push_Back( *This[i] )
			
		Next
		
		This = temp
		
	End If
	
End Sub

Sub UDTArray.Remove( ByVal p As UDT Ptr )
	
	For i As Integer = 0 To Size_ - 1
		
		If ( p = This[i] ) Then 
			
			Remove(i)
			
			Exit Sub
			
		EndIf
		
	Next
	
End Sub

Sub UDTArray.Reserve( ByVal C As Integer )
	
	If ( C > 0 ) Then
		
		Clear()
		
		Capacity_ = C
		Size_     = 0
		
		Index_ = New UDT[ Capacity_ ]
		
		Back_  = Index_
		Front_ = Index_
		
	End If
	
End Sub

Sub UDTArray.resize( ByVal c As Integer )
	
	Dim As UDTarray temp
	
	temp.reserve( c )
	
	For I As UDT Ptr = Front To Back
		
		temp.Push_Back( *I )
		
	Next
	
	This = temp
	
End Sub

Sub UDTArray.Clear()
	
	'Delete[] Index_
	'
	'Index_    = 0
	'Capacity_ = 0
	'Size_     = 0
	'Back_     = 0
	'Front_    = 0

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
