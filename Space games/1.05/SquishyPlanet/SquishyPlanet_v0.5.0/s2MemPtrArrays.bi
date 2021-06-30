''******************************************************************************
''    
''   Squishy2D Memory Management Classes
''   Written in FreeBASIC 1.05
''   version 0.2.0, May 2016, Michael "h4tt3n" Nissen
''
''   Arrays of pointers to objects
''   These are used by complex objects to keep track of the simpler objects 
''   ( particles and springs ) they are composed of.
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


''
Type AngularSpringPtrArray
	
	Public:
	
	Declare Constructor()
	Declare Constructor( ByRef P As AngularSpringPtrArray )
	
	Declare Destructor()
	
	Declare Operator Let( ByRef P As AngularSpringPtrArray )
	Declare Operator [] ( ByVal i as Integer ) As AngularSpring Ptr Ptr 
	
	Declare Function size     () As Integer
	Declare Function capacity () As Integer
	Declare Function back     () As AngularSpring Ptr Ptr 
	Declare Function front    () As AngularSpring Ptr Ptr 
	Declare Function push_back( ByRef P As AngularSpring Ptr ) As AngularSpring Ptr Ptr 
	
	Declare Sub clear  ()
	Declare Sub erase  ( ByVal n As Integer )
	Declare Sub reserve( ByVal n As Integer )
	Declare Sub shuffle()
	
	Private:
	
	As Integer size_                '' number of elements in use
	As Integer capacity_            '' number of Reserved elements
	As AngularSpring Ptr Ptr back_  '' Ptr to last elemet
	As AngularSpring Ptr Ptr front_ '' Ptr to first element
	As AngularSpring Ptr Ptr index_ '' array index
	
End Type


''
Type FixedSpringPtrArray
	
	Public:
	
	Declare Constructor()
	Declare Constructor( ByRef P As FixedSpringPtrArray )
	
	Declare Destructor()
	
	Declare Operator Let( ByRef P As FixedSpringPtrArray )
	Declare Operator [] ( ByVal i as Integer ) As FixedSpring Ptr Ptr 
	
	Declare Function size     () As Integer
	Declare Function capacity () As Integer
	Declare Function back     () As FixedSpring Ptr Ptr 
	Declare Function front    () As FixedSpring Ptr Ptr 
	Declare Function push_back( ByRef P As FixedSpring Ptr ) As FixedSpring Ptr Ptr 
	
	Declare Sub clear  ()
	Declare Sub erase  ( ByVal n As Integer )
	Declare Sub reserve( ByVal n As Integer )
	Declare Sub shuffle()
	
	Private:
	
	As Integer size_              '' number of elements in use
	As Integer capacity_          '' number of Reserved elements
	As FixedSpring Ptr Ptr back_  '' Ptr to last elemet
	As FixedSpring Ptr Ptr front_ '' Ptr to first element
	As FixedSpring Ptr Ptr index_ '' array index
	
End Type


''
Type LinearSpringPtrArray
	
	Public:
	
	Declare Constructor()
	Declare Constructor( ByRef P As LinearSpringPtrArray )
	
	Declare Destructor()
	
	Declare Operator Let( ByRef P As LinearSpringPtrArray )
	Declare Operator [] ( ByVal i as Integer ) As LinearSpring Ptr Ptr 
	
	Declare Function size     () As Integer
	Declare Function capacity () As Integer
	Declare Function back     () As LinearSpring Ptr Ptr 
	Declare Function front    () As LinearSpring Ptr Ptr 
	Declare Function push_back( ByRef P As LinearSpring Ptr ) As LinearSpring Ptr Ptr 
	
	Declare Sub clear  ()
	Declare Sub erase  ( ByVal n As Integer )
	Declare Sub reserve( ByVal n As Integer )
	Declare Sub shuffle()
	
	Private:
	
	As Integer size_               '' number of elements in use
	As Integer capacity_           '' number of Reserved elements
	As LinearSpring Ptr Ptr back_  '' Ptr to last elemet
	As LinearSpring Ptr Ptr front_ '' Ptr to first element
	As LinearSpring Ptr Ptr index_ '' array index
	
End Type


''
Type LineSegmentPtrArray
	
	Public:
	
	Declare Constructor()
	Declare Constructor( ByRef P As LineSegmentPtrArray )
	
	Declare Destructor()
	
	Declare Operator Let( ByRef P As LineSegmentPtrArray )
	Declare Operator [] ( ByVal i as Integer ) As LineSegment Ptr Ptr 
	
	Declare Function size     () As Integer
	Declare Function capacity () As Integer
	Declare Function back     () As LineSegment Ptr Ptr 
	Declare Function front    () As LineSegment Ptr Ptr 
	Declare Function push_back( ByRef P As LineSegment Ptr ) As LineSegment Ptr Ptr 
	
	Declare Sub clear  ()
	Declare Sub erase  ( ByVal n As Integer )
	Declare Sub reserve( ByVal n As Integer )
	Declare Sub shuffle()
	
	Private:
	
	As Integer size_              '' number of elements in use
	As Integer capacity_          '' number of Reserved elements
	As LineSegment Ptr Ptr back_  '' Ptr to last elemet
	As LineSegment Ptr Ptr front_ '' Ptr to first element
	As LineSegment Ptr Ptr index_ '' array index
	
End Type


''
Type ParticlePtrArray
	
	Public:
	
	Declare Constructor()
	Declare Constructor( ByRef P As ParticlePtrArray )
	
	Declare Destructor()
	
	Declare Operator Let( ByRef P As ParticlePtrArray )
	Declare Operator [] ( ByVal i as Integer ) As Particle Ptr Ptr 
	
	Declare Function size     () As Integer
	Declare Function capacity () As Integer
	Declare Function back     () As Particle Ptr Ptr 
	Declare Function front    () As Particle Ptr Ptr 
	Declare Function push_back( ByRef P As Particle Ptr ) As Particle Ptr Ptr 
	
	Declare Sub clear  ()
	Declare Sub erase  ( ByVal n As Integer )
	Declare Sub reserve( ByVal n As Integer )
	Declare Sub shuffle()
	
	Private:
	
	As Integer size_           '' number of elements in use
	As Integer capacity_       '' number of Reserved elements
	As Particle Ptr Ptr back_  '' Ptr to last elemet
	As Particle Ptr Ptr front_ '' Ptr to first element
	As Particle Ptr Ptr index_ '' array index
	
End Type


''******************************************************************************
'' AngularSpringPtrArray
''******************************************************************************

'' Constructors
Constructor AngularSpringPtrArray()
	
	Clear()
	
End Constructor

Constructor AngularSpringPtrArray( ByRef P As AngularSpringPtrArray )
	
	Clear()
	
	This = P
	
End Constructor


'' Destructor
Destructor AngularSpringPtrArray()
	
	Clear()
	
End Destructor


'' Operators
Operator AngularSpringPtrArray.Let( ByRef P As AngularSpringPtrArray )
	
	''	TO-do: reorganize to make self-assignment safe
	
	Clear()
		
	Reserve( P.Capacity )
	
	For I As AngularSpring Ptr Ptr = P.Front To P.Back
		
		Push_Back( *I )
		
	Next
	
End Operator

Operator AngularSpringPtrArray.[]( ByVal i as Integer ) As AngularSpring Ptr Ptr 
	
	Return index_ + i
	
End Operator


'' Functions
Function AngularSpringPtrArray.push_back( ByRef P As AngularSpring Ptr ) As AngularSpring Ptr Ptr 
	
	If ( Size_ >= Capacity_ ) Then Return 0
		
	Back_ = Index_ + Size_
	
	*Back_ = P
	
	Size_ += 1
	
	Return Back_
	
End Function

Function AngularSpringPtrArray.size() As Integer
	
	Return Size_
	
End Function

Function AngularSpringPtrArray.Capacity() As Integer
	
	Return Capacity_
	
End Function

Function AngularSpringPtrArray.Back() As AngularSpring Ptr Ptr 
	
	Return Back_
	
End Function

Function AngularSpringPtrArray.Front() As AngularSpring Ptr Ptr 
	
	Return Front_
	
End Function


'' Subs
Sub AngularSpringPtrArray.Clear()
	
	Capacity_ = 0
	Size_     = 0
	Back_     = 0
	Front_    = 0
	
	If ( Index_ > 0 ) Then Delete[] Index_
	
	Index_ = 0
	
End Sub

Sub AngularSpringPtrArray.erase( ByVal n As Integer )
	
End Sub

Sub AngularSpringPtrArray.Reserve( ByVal n As Integer )
	
	Clear()
	
	If ( C > 0 ) Then
		
		Capacity_ = n
		Size_     = 0
		
		Index_ = New AngularSpring Ptr [ Capacity_ ]
		
		Back_  = Index_
		Front_ = Index_
		
	End If
	
End Sub

Sub AngularSpringPtrArray.shuffle()
	
	''	Hi-to-Lo Fisher-Yates shuffle
	For I As Integer = Size_ - 1 To 1 Step - 1
		
		Dim As Integer J = Cast( Integer, Rnd() * I ) 
		
		Dim As AngularSpring Ptr temp = Index_[I]
		
		Index_[I] = Index_[J]
		Index_[J] = temp
		
	Next
	
End Sub


''******************************************************************************
'' FixedSpringPtrArray
''******************************************************************************

'' Constructors
Constructor FixedSpringPtrArray()
	
	Clear()
	
End Constructor

Constructor FixedSpringPtrArray( ByRef P As FixedSpringPtrArray )
	
	Clear()
	
	This = P
	
End Constructor


'' Destructor
Destructor FixedSpringPtrArray()
	
	Clear()
	
End Destructor


'' Operators
Operator FixedSpringPtrArray.Let( ByRef P As FixedSpringPtrArray )
	
	''	TO-do: reorganize to make self-assignment safe
	
	Clear()
		
	Reserve( P.Capacity )
	
	For I As FixedSpring Ptr Ptr = P.Front To P.Back
		
		Push_Back( *I )
		
	Next
	
End Operator

Operator FixedSpringPtrArray.[]( ByVal i as Integer ) As FixedSpring Ptr Ptr 
	
	Return index_ + i
	
End Operator


'' Functions
Function FixedSpringPtrArray.push_back( ByRef P As FixedSpring Ptr ) As FixedSpring Ptr Ptr 
	
	If ( Size_ >= Capacity_ ) Then Return 0
		
	Back_ = Index_ + Size_
	
	*Back_ = P
	
	Size_ += 1
	
	Return Back_
	
End Function

Function FixedSpringPtrArray.size() As Integer
	
	Return Size_
	
End Function

Function FixedSpringPtrArray.Capacity() As Integer
	
	Return Capacity_
	
End Function

Function FixedSpringPtrArray.Back() As FixedSpring Ptr Ptr 
	
	Return Back_
	
End Function

Function FixedSpringPtrArray.Front() As FixedSpring Ptr Ptr 
	
	Return Front_
	
End Function


'' Subs
Sub FixedSpringPtrArray.Clear()
	
	Capacity_ = 0
	Size_     = 0
	Back_     = 0
	Front_    = 0
	
	If ( Index_ > 0 ) Then Delete[] Index_
	
	Index_ = 0
	
End Sub

Sub FixedSpringPtrArray.erase( ByVal n As Integer )
	
End Sub

Sub FixedSpringPtrArray.Reserve( ByVal n As Integer )
	
	Clear()
	
	If ( C > 0 ) Then
		
		Capacity_ = n
		Size_     = 0
		
		Index_ = New FixedSpring Ptr [ Capacity_ ]
		
		Back_  = Index_
		Front_ = Index_
		
	End If
	
End Sub

Sub FixedSpringPtrArray.shuffle()
	
	''	Hi-to-Lo Fisher-Yates shuffle
	For I As Integer = Size_ - 1 To 1 Step - 1
		
		Dim As Integer J = Cast( Integer, Rnd() * I ) 
		
		Dim As FixedSpring Ptr temp = Index_[I]
		
		Index_[I] = Index_[J]
		Index_[J] = temp
		
	Next
	
End Sub


''******************************************************************************
'' LinearSpringPtrArray
''******************************************************************************

'' Constructors
Constructor LinearSpringPtrArray()
	
	Clear()
	
End Constructor

Constructor LinearSpringPtrArray( ByRef P As LinearSpringPtrArray )
	
	Clear()
	
	This = P
	
End Constructor


'' Destructor
Destructor LinearSpringPtrArray()
	
	Clear()
	
End Destructor


'' Operators
Operator LinearSpringPtrArray.Let( ByRef P As LinearSpringPtrArray )
	
	''	TO-do: reorganize to make self-assignment safe
	
	Clear()
		
	Reserve( P.Capacity )
	
	For I As LinearSpring Ptr Ptr = P.Front To P.Back
		
		Push_Back( *I )
		
	Next
	
End Operator

Operator LinearSpringPtrArray.[]( ByVal i as Integer ) As LinearSpring Ptr Ptr 
	
	Return index_ + i
	
End Operator


'' Functions
Function LinearSpringPtrArray.push_back( ByRef P As LinearSpring Ptr ) As LinearSpring Ptr Ptr 
	
	If ( Size_ >= Capacity_ ) Then Return 0
		
	Back_ = Index_ + Size_
	
	*Back_ = P
	
	Size_ += 1
	
	Return Back_
	
End Function

Function LinearSpringPtrArray.size() As Integer
	
	Return Size_
	
End Function

Function LinearSpringPtrArray.Capacity() As Integer
	
	Return Capacity_
	
End Function

Function LinearSpringPtrArray.Back() As LinearSpring Ptr Ptr 
	
	Return Back_
	
End Function

Function LinearSpringPtrArray.Front() As LinearSpring Ptr Ptr 
	
	Return Front_
	
End Function


'' Sub
Sub LinearSpringPtrArray.Clear()
	
	Capacity_ = 0
	Size_     = 0
	Back_     = 0
	Front_    = 0
	
	If ( Index_ > 0 ) Then Delete[] Index_
	
	Index_ = 0
	
End Sub

Sub LinearSpringPtrArray.erase( ByVal n As Integer )
	
End Sub

Sub LinearSpringPtrArray.Reserve( ByVal n As Integer )
	
	Clear()
	
	If ( C > 0 ) Then
		
		Capacity_ = n
		Size_     = 0
		
		Index_ = New LinearSpring Ptr [ Capacity_ ]
		
		Back_  = Index_
		Front_ = Index_
		
	End If
	
End Sub

Sub LinearSpringPtrArray.shuffle()
	
	''	Hi-to-Lo Fisher-Yates shuffle
	For I As Integer = Size_ - 1 To 1 Step - 1
		
		Dim As Integer J = Cast( Integer, Rnd() * I ) 
		
		Dim As LinearSpring Ptr temp = Index_[I]
		
		Index_[I] = Index_[J]
		Index_[J] = temp
		
	Next
	
End Sub


''******************************************************************************
'' LineSegmentPtrArray
''******************************************************************************

'' Constructors
Constructor LineSegmentPtrArray()
	
	Clear()
	
End Constructor

Constructor LineSegmentPtrArray( ByRef P As LineSegmentPtrArray )
	
	Clear()
	
	This = P
	
End Constructor


'' Destructor
Destructor LineSegmentPtrArray()
	
	Clear()
	
End Destructor


'' Operators
Operator LineSegmentPtrArray.Let( ByRef P As LineSegmentPtrArray )
	
	''	TO-do: reorganize to make self-assignment safe
	
	Clear()
		
	Reserve( P.Capacity )
	
	For I As LineSegment Ptr Ptr = P.Front To P.Back
		
		Push_Back( *I )
		
	Next
	
End Operator

Operator LineSegmentPtrArray.[]( ByVal i as Integer ) As LineSegment Ptr Ptr 
	
	Return index_ + i
	
End Operator


'' Functions
Function LineSegmentPtrArray.push_back( ByRef P As LineSegment Ptr ) As LineSegment Ptr Ptr 
	
	If ( Size_ >= Capacity_ ) Then Return 0
		
	Back_ = Index_ + Size_
	
	*Back_ = P
	
	Size_ += 1
	
	Return Back_
	
End Function

Function LineSegmentPtrArray.size() As Integer
	
	Return Size_
	
End Function

Function LineSegmentPtrArray.Capacity() As Integer
	
	Return Capacity_
	
End Function

Function LineSegmentPtrArray.Back() As LineSegment Ptr Ptr 
	
	Return Back_
	
End Function

Function LineSegmentPtrArray.Front() As LineSegment Ptr Ptr 
	
	Return Front_
	
End Function


'' Subs
Sub LineSegmentPtrArray.erase( ByVal n As Integer )
	
End Sub

Sub LineSegmentPtrArray.Reserve( ByVal n As Integer )
	
	Clear()
	
	If ( C > 0 ) Then
		
		Capacity_ = n
		Size_     = 0
		
		Index_ = New LineSegment Ptr [ Capacity_ ]
		
		Back_  = Index_
		Front_ = Index_
		
	End If
	
End Sub

Sub LineSegmentPtrArray.Clear()
	
	Capacity_ = 0
	Size_     = 0
	Back_     = 0
	Front_    = 0
	
	If ( Index_ > 0 ) Then Delete[] Index_
	
	Index_ = 0
	
End Sub

Sub LineSegmentPtrArray.shuffle()
	
	''	Hi-to-Lo Fisher-Yates shuffle
	For I As Integer = Size_ - 1 To 1 Step - 1
		
		Dim As Integer J = Cast( Integer, Rnd() * I ) 
		
		Dim As LineSegment Ptr temp = Index_[I]
		
		Index_[I] = Index_[J]
		Index_[J] = temp
		
	Next
	
End Sub


''******************************************************************************
'' ParticlePtrArray
''******************************************************************************

'' Constructors
Constructor ParticlePtrArray()
	
	Clear()
	
End Constructor

Constructor ParticlePtrArray( ByRef P As ParticlePtrArray )
	
	Clear()
	
	This = P
	
End Constructor


'' Destructor
Destructor ParticlePtrArray()
	
	Clear()
	
End Destructor


'' Operators
Operator ParticlePtrArray.Let( ByRef P As ParticlePtrArray )
	
	''	TO-do: reorganize to make self-assignment safe
	
	Clear()
	
	Reserve( P.Capacity )
	
	For I As Particle Ptr Ptr = P.Front To P.Back
		
		Push_Back( *I )
		
	Next
	
End Operator

Operator ParticlePtrArray.[]( ByVal i as Integer ) As Particle Ptr Ptr 
	
	Return index_ + i
	
End Operator


'' Functions
Function ParticlePtrArray.push_back( ByRef P As Particle Ptr ) As Particle Ptr Ptr 
	
	If ( Size_ >= Capacity_ ) Then Return 0
		
	Back_ = Index_ + Size_
	
	*Back_ = P
	
	Size_ += 1
	
	Return Back_
	
End Function

Function ParticlePtrArray.size() As Integer
	
	Return Size_
	
End Function

Function ParticlePtrArray.Capacity() As Integer
	
	Return Capacity_
	
End Function

Function ParticlePtrArray.Back() As Particle Ptr Ptr 
	
	Return Back_
	
End Function

Function ParticlePtrArray.Front() As Particle Ptr Ptr 
	
	Return Front_
	
End Function


'' Subs
Sub ParticlePtrArray.Clear()
	
	Capacity_ = 0
	Size_     = 0
	Back_     = 0
	Front_    = 0
	
	If ( Index_ > 0 ) Then Delete[] Index_
	
	Index_ = 0
	
End Sub

Sub ParticlePtrArray.erase( ByVal n As Integer )
	
End Sub

Sub ParticlePtrArray.Reserve( ByVal n As Integer )
	
	Clear()
	
	If ( C > 0 ) Then
		
		Capacity_ = n
		Size_     = 0
		
		Index_ = New Particle Ptr [ Capacity_ ]
		
		Back_  = Index_
		Front_ = Index_
		
	End If
	
End Sub

Sub ParticlePtrArray.shuffle()
	
	''	Hi-to-Lo Fisher-Yates shuffle
	For I As Integer = Size_ - 1 To 1 Step - 1
		
		Dim As Integer J = Cast( Integer, Rnd() * I ) 
		
		Dim As Particle Ptr temp = Index_[I]
		
		Index_[I] = Index_[J]
		Index_[J] = temp
		
	Next
	
End Sub


#EndIf ''__S2_MEM_PTR_ARRAYS_BI__
