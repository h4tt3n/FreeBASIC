''******************************************************************************
''    
''  Graveyard Orbit - A 2D space physics puzzle game
''
''  Prototype #1
''
''  Written in FreeBASIC 1.05 with the FbEdit 1.0.7.6c editor
''  Version 0.1.0, October 31. 2016
''  
''  Author:
''  Michael "h4tt3n" Schmidt Nissen, michaelschmidtnissen@gmail.com
''    
''  Description:
''  Game object container macro
''
''******************************************************************************


''
#Ifndef __GO_ARRAY_BI__
#Define __GO_ARRAY_BI__


#Macro CreateArray( _Name, _Type )
	
	''
	Type _Name
		
		Public:
		
		Declare Constructor()
		Declare Constructor( ByRef a As _Name )
		
		Declare Destructor()
		
		Declare Operator Let( ByRef P As _Name )
		Declare Operator [] ( ByVal i as Integer ) As _Type Ptr 
		
		Declare Const Function size     () As Integer
		Declare Const Function capacity () As Integer
		Declare Const Function back     () As _Type Ptr 
		Declare Const Function front    () As _Type Ptr 
		
		Declare Function push_back( ByRef P As _Type ) As _Type Ptr 
		
		Declare Sub Clear   ()
		Declare Sub Erase   ( ByVal n As Integer )
		Declare Sub reserve ( ByVal n As Integer )
		Declare Sub shuffle ()
		
		Protected:
		
		As Integer size_      '' number of elements in use
		As Integer capacity_  '' number of Reserved elements
		As _Type Ptr back_  '' Ptr to last elemet
		As _Type Ptr front_ '' Ptr to first element
		As _Type Ptr index_ '' array index
		
	End Type
	
	
	
	'' Constructors
	Constructor _Name()
		
		Clear()
		
	End Constructor
	
	Constructor _Name( ByRef a As _Name )
		
		Clear()
		
		This = a
		
	End Constructor
	
	
	'' Destructor
	Destructor _Name()
		
		Clear()
		
	End Destructor
	
	
	'' Operators
	Operator _Name.Let( ByRef P As _Name )
		
		''	TO-do: reorganize to make self-assignment safe
		
		Clear()
			
		Reserve( P.Capacity )
		
		For I As _Type Ptr = P.Front To P.Back
			
			Push_Back( *I )
			
		Next
		
	End Operator
	
	Operator _Name.[]( ByVal i as Integer ) As _Type Ptr 
		
		Return index_ + i
		
	End Operator
	
	
	'' Functions
	Function _Name.push_back( ByRef P As _Type ) As _Type Ptr 
		
		If ( Size_ >= Capacity_ ) Then Return 0
			
		Back_ = Index_ + Size_
		
		*Back_ = P
		
		Size_ += 1
		
		Return Back_
		
	End Function
	
	Function _Name.size() As Integer
		
		Return Size_
		
	End Function
	
	Function _Name.Capacity() As Integer
		
		Return Capacity_
		
	End Function
	
	Function _Name.Back() As _Type Ptr 
		
		Return Back_
		
	End Function
	
	Function _Name.Front() As _Type Ptr 
		
		Return Front_
		
	End Function
	
	
	'' Subs
	Sub _Name.Clear()
		
		Capacity_ = 0
		Size_     = 0
		Back_     = 0
		Front_    = 0
		
		If ( Index_ > 0 ) Then Delete[] Index_
		
		Index_ = 0
		
	End Sub
	
	Sub _Name.erase( ByVal n As Integer )
		
	End Sub
	
	Sub _Name.Reserve( ByVal n As Integer )
		
		Clear()
		
		If ( n > 0 ) Then
			
			Capacity_ = n
			Size_     = 0
			
			Index_ = New _Type [ Capacity_ ]
			
			Back_  = Index_
			Front_ = Index_
			
		End If
		
	End Sub
	
	Sub _Name.shuffle()
		
		''	Hi-to-Lo Fisher-Yates shuffle
		For I As Integer = Size_ - 1 To 1 Step - 1
			
			Dim As Integer J = Cast( Integer, Rnd() * I ) 
			
			Dim As _Type temp = Index_[I]
			
			Index_[I] = Index_[J]
			Index_[J] = temp
			
		Next
		
	End Sub

#EndMacro


#EndIf ''__GO_ARRAY_BI__
