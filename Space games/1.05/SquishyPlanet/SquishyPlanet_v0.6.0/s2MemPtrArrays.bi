''******************************************************************************
''    
''   Squishy2D Memory Management Classes
''   Written in FreeBASIC 1.05
''   version 0.2.0, May 2016, Michael "h4tt3n" Nissen
''
''   Arrays of pointers to objects
''   These are used by complex objects to keep track of the simpler objects 
''   ( like particles and springs ) they are composed of.
''   The content of these can safely be moved or deleted at runtime.
''
''   By composing complex objects from pointers to simple objects rather than
''   from simple objects directly, any simple object can be part of more 
''   complex objects at the same time, thereby making it possible to link any 
''   combination of simple and complex objects together into large structures.
''
''******************************************************************************


''
#Ifndef __S2_MEM_PTR_ARRAYS_BI__
#Define __S2_MEM_PTR_ARRAYS_BI__


#Macro DynamicArrayType( _Name, _Type )
	
	''
	Type _Name
		
		Public:
		
		'' Constructors
		Declare Constructor()
		Declare Constructor( ByRef P As _Name )
		
		'' Destructor
		Declare Destructor()
		
		'' Operators
		Declare Operator Let( ByRef P As _Name )
		Declare Operator [] ( ByVal i As Integer ) As _Type Ptr
		
		'' Get
		Declare Function size     () As Integer
		Declare Function capacity () As Integer
		Declare Function i_back   () As Integer
		Declare Function i_front  () As Integer
		Declare Function p_back   () As _Type Ptr
		Declare Function p_front  () As _Type Ptr
		
		'' Functions
		Declare Function Clear    () As Boolean
		Declare Function empty    () As Boolean
		Declare Function Flip     ( ByVal i As Integer, ByVal j As Integer ) As Boolean
		Declare Function insert   ( ByVal p As _Type Ptr, ByVal i As Integer ) As Boolean
		Declare Function pop_back () As Boolean
		Declare Function push_back( ByRef P As _Type ) As _Type Ptr
		Declare Function remove   ( ByVal i As Integer ) As Boolean
		Declare Function remove   ( ByVal p As _Type ) As Boolean
		Declare Function reserve  ( ByVal c As Integer ) As Boolean
		Declare Function resize   ( ByVal c As Integer ) As Boolean
		Declare Function shuffle  ( ByVal _seed As Single = 1.0 ) As Boolean
		
		Private:
		
		'' Variables
		As Integer   size_      '' number of elements in use
		As Integer   capacity_  '' number of Reserved elements
		As Integer   i_back_    '' index / iterator to last element
		As Integer   i_front_   '' index / iterator to first element
		As _Type Ptr p_back_    '' pointer to last elemet
		As _Type Ptr p_front_   '' pointer to first element
		As _Type Ptr index_     '' array index
		
	End Type
	
	
	'' Constructors
	Constructor _Name()
		
		Clear()
		
	End Constructor
	
	Constructor _Name( ByRef P As _Name )
		
		Clear()
		
		This = P
		
	End Constructor
	
	
	'' Destructor
	Destructor _Name()
		
		Clear()
		
	End Destructor
	
	
	'' Operators
	Operator _Name.Let( ByRef P As _Name )
		
		If ( @This <> @p ) Then
			
			If Reserve( P.Capacity ) Then
				
				For i As _Type Ptr = P.p_front To P.p_back
					
					push_back( *i )
					
				Next
				
			End If
			
		End If
		
	End Operator
	
	Operator _Name.[]( ByVal i As Integer ) As _Type Ptr
		
		'If ( i >= 0 ) And ( i < Size_ ) Then
		If ( i_front_ <= i ) And ( i <= i_back_ ) Then
		
			Return index_ + i
			
		EndIf
		
	End Operator
	
	
	'' Get
	Function _Name.size() As Integer
		
		Return Size_
		
	End Function
	
	Function _Name.Capacity() As Integer
		
		Return Capacity_
		
	End Function
	
	Function _Name.i_back() As Integer
		
		Return i_back_
	
	End Function
	
	Function _Name.i_front() As Integer
		
		Return i_front_
		
	End Function
	
	Function _Name.p_back() As _Type Ptr
		
		Return p_back_
		
	End Function
	
	Function _Name.p_front() As _Type Ptr
		
		Return p_front_
		
	End Function
	
	
	'' Functions
	Function _Name.Clear() As Boolean
			
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
	
	Function _Name.empty() As Boolean
		
		Return IIf( Size_ = 0 , TRUE , FALSE )
		
	End Function
	
	Function _Name.flip( ByVal i As Integer, ByVal j As Integer ) As Boolean
		
		If ( i_front_ <= i ) And ( i <= i_back_ ) Then
			
			If ( i_front_ <= j ) And ( j <= i_back_ ) Then
				
				Dim As _Type temp = Index_[i]
				
				Index_[i] = Index_[j]
				Index_[j] = temp
				
				Return TRUE
				
			EndIf
			
		EndIf
		
		Return FALSE
		
	End Function
	
	Function _Name.insert( ByVal p As _Type Ptr, ByVal i As Integer ) As Boolean
		
		If ( Size_ < Capacity_ ) Then
			
			If push_back( *p ) Then
				
				Flip( i, i_back_ )
				
				Return TRUE
				
			EndIf
			
		EndIf
		
		Return FALSE
		
	End Function
	
	Function _Name.pop_back() As Boolean
		
		If ( Size_ > 0 ) Then
			
			Size_ -= 1
			
			i_back_ = IIf( Size_ - 1 < 0 , 0 , Size_ - 1 )
			
			p_back_ = Index_ + i_back_
			
			Return TRUE
		
		EndIf
		
		Return FALSE
		
	End Function
	
	Function _Name.push_back( ByRef P As _Type ) As _Type Ptr
		
		If ( Size_ < Capacity_ ) Then
			
			Size_ += 1
			
			i_back_ = Size_ - 1
			
			p_back_ = Index_ + i_back_
			
			*p_back_ = P
			
			Return p_back_
			
		End If
		
		Return 0
		
	End Function
	
	Function _Name.Remove( ByVal i As Integer ) As Boolean
		
		If ( i_front_ <= i ) And ( i <= i_back_ ) Then
			
			Flip( i, i_back_ )
			
			pop_back()
			
			Return TRUE
		
		End If
		
		Return FALSE
		
	End Function
	
	Function _Name.Remove( ByVal p As _Type ) As Boolean
		
		If ( Size_ > 0 ) Then
		
			For i As Integer = i_front_ To i_back_
				
				If ( @p = This[i] ) Then 
					
					If Remove( i ) Then Return TRUE
					
				EndIf
				
			Next
		
		EndIf
		
		Return FALSE
		
	End Function
	
	Function _Name.Reserve( ByVal C As Integer ) As Boolean
		
		Clear()
			
		If ( index_ = 0 ) Then
			
			If ( C > 0 ) Then
				
				Capacity_ = C
				Size_     = 0
				
				Index_ = New _Type[ Capacity_ ]
				
				i_back_  = 0
				i_front_ = 0
				
				p_back_  = Index_
				p_front_ = Index_
				
				Return TRUE
				
			EndIf
			
		EndIf
		
		Return FALSE
		
	End Function
	
	Function _Name.resize( ByVal c As Integer ) As Boolean
		
		Dim As _Name temp
		
		If temp.reserve( c ) Then
			
			For i As _Type Ptr = p_front_ To p_back_
				
				temp.push_back( *i )
				
			Next
			
			This = temp
			
			Return TRUE
			
		End If
		
		Return FALSE
		
	End Function
	
	Function _Name.shuffle( ByVal _seed As Single ) As Boolean
		
		''	Hi-to-Lo Fisher-Yates shuffle
		
		If ( Size_ > 0 ) Then
			
			For i As Integer = i_back_ To i_front_ + 1 Step -1
				
				Dim As Integer j = Cast( Integer, Rnd( _seed ) * i ) 
				
				Flip( i , j )
				
			Next
			
			Return TRUE
			
		EndIf
		
		Return FALSE
		
	End Function

#EndMacro


#EndIf ''__S2_MEM_PTR_ARRAYS_BI__
