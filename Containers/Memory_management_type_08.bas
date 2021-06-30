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
	Declare Operator [] ( ByVal i As Integer ) As UDT Ptr
	
	'' Get
	Declare Function size     () As Integer
	Declare Function capacity () As Integer
	Declare Function i_back   () As Integer
	Declare Function i_front  () As Integer
	Declare Function p_back   () As UDT Ptr
	Declare Function p_front  () As UDT Ptr
	
	'' Functions
	Declare Function Clear    () As Boolean
	Declare Function empty    () As Boolean
	Declare Function Flip     ( ByVal i As Integer, ByVal j As Integer ) As Boolean
	Declare Function insert   ( ByVal p As UDT Ptr, ByVal i As Integer ) As Boolean
	Declare Function pop_back () As Boolean
	Declare Function push_back( ByRef P As UDT ) As UDT Ptr
	Declare Function remove   ( ByVal i As Integer ) As Boolean
	Declare Function remove   ( ByVal p As UDT ) As Boolean
	Declare Function reserve  ( ByVal c As Integer ) As Boolean
	Declare Function resize   ( ByVal c As Integer ) As Boolean
	Declare Function shuffle  ( ByVal _seed As Single = 1.0 ) As Boolean
	
	''
	Declare Sub PrintArray()
	Declare Sub PrintVariables()
	
	Private:
	
	'' Variables
	As Integer size_      '' number of elements in use
	As Integer capacity_  '' number of Reserved elements
	As Integer i_back_    '' index / iterator to last element
	As Integer i_front_   '' index / iterator to first element
	As UDT Ptr p_back_    '' pointer to last elemet
	As UDT Ptr p_front_   '' pointer to first element
	As UDT Ptr index_     '' array index
	
End Type



'' Test program

Randomize

'' Dim array

Dim As UDTArray Array1

Array1.PrintVariables()
Array1.PrintArray()

Array1.reserve( 5 )

Array1.PrintVariables()
Array1.PrintArray()

Array1.push_back( UDT( 0 ) )

Array1.PrintVariables()
Array1.PrintArray()


Array1.push_back( UDT( 1 ) )

Array1.PrintVariables()
Array1.PrintArray()


Array1.push_back( UDT( 2 ) )

Array1.PrintVariables()
Array1.PrintArray()

Array1.push_back( UDT( 3 ) )

Array1.PrintVariables()
Array1.PrintArray()

Array1.push_back( UDT( 4 ) )

Array1.PrintVariables()
Array1.PrintArray()

Array1.push_back( UDT( 5 ) )

Array1.PrintVariables()
Array1.PrintArray()

Array1.pop_back()

Array1.PrintVariables()
Array1.PrintArray()

Array1.pop_back()

Array1.PrintVariables()
Array1.PrintArray()

Array1.pop_back()

Array1.PrintVariables()
Array1.PrintArray()

Array1.pop_back()

Array1.PrintVariables()
Array1.PrintArray()

Array1.pop_back()

Array1.PrintVariables()
Array1.PrintArray()



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
		
		If Reserve( P.Capacity ) Then
			
			For i As UDT Ptr = P.p_front To P.p_back
				
				Push_back( *i )
				
			Next
			
		End If
		
	End If
	
End Operator

Operator UDTArray.[]( ByVal i As Integer ) As UDT Ptr
	
	If ( i_front <= i ) And ( i <= i_back ) Then
		
		Return index_ + i
		
	EndIf
	
End Operator


'' Get
Function UDTArray.size() As Integer
	
	Return Size_
	
End Function

Function UDTArray.Capacity() As Integer
	
	Return Capacity_
	
End Function

Function UDTArray.i_back() As Integer
	
	Return i_back_

End Function

Function UDTArray.i_front() As Integer
	
	Return i_front_
	
End Function

Function UDTArray.p_back() As UDT Ptr
	
	Return p_back_
	
End Function

Function UDTArray.p_front() As UDT Ptr
	
	Return p_front_
	
End Function


'' Functions
Function UDTArray.Clear() As Boolean
		
	Delete[] Index_
	
	Index_    = 0
	Capacity_ = 0
	Size_     = 0
	i_back_   = 0
	i_front_  = 0
	p_back_   = 0
	p_front_  = 0
	
	Return TRUE	
	
End Function

Function UDTArray.empty() As Boolean
	
	Return IIf( Size_ = 0 , TRUE , FALSE )
	
End Function

Function UDTArray.flip( ByVal i As Integer, ByVal j As Integer ) As Boolean
	
	If ( i_front <= i ) And ( i <= i_back ) Then
		
		If ( i_front <= j ) And ( j <= i_back ) Then
			
			Dim As UDT temp = Index_[i]
			
			Index_[i] = Index_[j]
			Index_[j] = temp
			
			Return TRUE
			
		EndIf
		
	EndIf
	
	Return FALSE
	
End Function

Function UDTArray.insert( ByVal p As UDT Ptr, ByVal i As Integer ) As Boolean
	
	If ( Size_ < Capacity_ ) Then
		
		If push_back( *p ) Then
			
			Flip( i, size_ - 1 )
			
			Return TRUE
			
		EndIf
		
	EndIf
	
	Return FALSE
	
End Function

Function UDTArray.pop_back() As Boolean
	
	If ( Size_ > 0 ) Then
		
		Size_ -= 1
		
		i_back_ = IIf( Size_ - 1 < 0 , 0 , Size_ - 1 )
		
		p_back_ = Index_ + i_back_
		
		Return TRUE
	
	EndIf
	
	Return FALSE
	
End Function

Function UDTArray.push_back( ByRef P As UDT ) As UDT Ptr
	
	If ( Size_ < Capacity_ ) Then
		
		Size_ += 1
		
		i_back_ = Size_ - 1
		
		p_back_ = Index_ + i_back_
		
		*p_back_ = P
		
		Return p_back_
		
	End If
	
	Return 0
	
End Function

Function UDTArray.Remove( ByVal i As Integer ) As Boolean
	
	If ( i_front <= i ) And ( i <= i_back ) Then
		
		Flip( i, i_back )
		
		pop_back()
	
	End If
	
	Return FALSE
	
End Function

Function UDTArray.Remove( ByVal p As UDT ) As Boolean
	
	If ( Size_ > 0 ) Then
	
		For i As Integer = i_front To i_back
			
			If ( @p = This[ i ] ) Then 
				
				If Remove( i ) Then Return TRUE
				
			EndIf
			
		Next
	
	EndIf
	
	Return FALSE
	
End Function

Function UDTArray.Reserve( ByVal C As Integer ) As Boolean
	
	Clear()
		
	If ( index_ = 0 ) Then
		
		If ( C > 0 ) Then
			
			Capacity_ = C
			Size_     = 0
			
			Index_ = New UDT[ Capacity_ ]
			
			i_back_  = 0
			i_front_ = 0
			
			p_back_  = Index_
			p_front_ = Index_
			
			Return TRUE
			
		EndIf
		
	EndIf
	
	Return FALSE
	
End Function

Function UDTArray.resize( ByVal c As Integer ) As Boolean
	
	Dim As UDTarray temp
	
	If temp.reserve( c ) Then
		
		For i As UDT Ptr = p_front To p_back
			
			temp.Push_back( *i )
			
		Next
		
		This = temp
		
		Return TRUE
		
	End If
	
	Return FALSE
	
End Function

Function UDTArray.shuffle( ByVal _seed As Single ) As Boolean
	
	''	Hi-to-Lo Fisher-Yates shuffle
	
	If ( Size_ > 0 ) Then
		
		For i As Integer = i_back To i_front + 1 Step - 1
			
			Dim As Integer j = Cast( Integer, Rnd( _seed ) * i ) 
			
			Flip( i , j )
			
		Next
		
		Return TRUE
		
	EndIf
	
	Return FALSE
	
End Function


'' Print ( for dev / debug purpose)
Sub UDTArray.PrintArray()
	
	If ( size_ > 0 ) Then
		
		Print
		
		For i As UDT Ptr = p_front To p_back
			
			Print i->Dummy_ ;
			
		Next
	
	EndIf
	
End Sub

Sub UDTArray.PrintVariables()
	
	Print
	
	Print " Size:     " & size_
	Print " Capacity: " & capacity_
	Print " i_back:   " & i_back_
	Print " i_front:  " & i_front_
	Print " p_back:   " & p_back_
	Print " p_front:  " & p_front_
	Print " Index:    " & index_
	
End Sub
