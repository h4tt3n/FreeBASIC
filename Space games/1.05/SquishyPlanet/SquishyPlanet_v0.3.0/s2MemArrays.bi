''******************************************************************************
''    
''   Squishy2D Memory Management Classes
''   Written in FreeBASIC 1.04
''   version 0.1.0, November 2015, Michael "h4tt3n" Nissen
''
''   Arrays of objects
''	  These are used by the World class to store all object instances.
''   All complex objects are composed of pointers to these arrays.
''   The objects in these arrays *can not* be moved or deleted at runtime, 
''   or the pointers to them will be invalidated.
''
''******************************************************************************


''
#Ifndef __S2_MEM_ARRAYS_BI__
#Define __S2_MEM_ARRAYS_BI__


''
Type AngularSpringArray
	
	Public:
	
	Declare Constructor()
	Declare Constructor( ByRef P As AngularSpringArray )
	
	Declare Destructor()
	
	Declare Operator Let( ByRef P As AngularSpringArray )
	Declare Operator [] ( ByVal i as Integer ) As AngularSpring Ptr
	
	Declare Function size     () As Integer
	Declare Function capacity () As Integer
	Declare Function back     () As AngularSpring Ptr
	Declare Function front    () As AngularSpring Ptr
	Declare Function push_back( ByRef P As AngularSpring ) As AngularSpring Ptr
	
	Declare Sub reserve( ByVal C As Integer )
	Declare Sub clear()
	
	Private:
	
	As Integer size_            '' number of elements in use
	As Integer capacity_        '' number of Reserved elements
	As AngularSpring Ptr back_  '' Ptr to last elemet
	As AngularSpring Ptr front_ '' Ptr to first element
	As AngularSpring Ptr index_ '' array index
	
End Type


''
Type RotateArray
		
	Public:
	
	Declare Constructor()
	Declare Constructor( ByRef P As RotateArray )
	
	Declare Destructor()
	
	Declare Operator Let( ByRef P As RotateArray )
	Declare Operator [] ( ByVal i as Integer ) As Rotate Ptr
	
	Declare Function size     () As Integer
	Declare Function capacity () As Integer
	Declare Function back     () As Rotate Ptr
	Declare Function front    () As Rotate Ptr
	Declare Function push_back( ByRef P As Rotate ) As Rotate Ptr
	
	Declare Sub reserve( ByVal C As Integer )
	Declare Sub clear()
	
	Private:
	
	As Integer size_     '' number of elements in use
	As Integer capacity_ '' number of Reserved elements
	As Rotate Ptr back_  '' Ptr to last elemet
	As Rotate Ptr front_ '' Ptr to first element
	As Rotate Ptr index_ '' array index
	
End Type


''
Type FixedSpringArray
	
	Public:
	
	Declare Constructor()
	Declare Constructor( ByRef P As FixedSpringArray )
	
	Declare Destructor()
	
	Declare Operator Let( ByRef P As FixedSpringArray )
	Declare Operator [] ( ByVal i as Integer ) As FixedSpring Ptr
	
	Declare Function size     () As Integer
	Declare Function capacity () As Integer
	Declare Function back     () As FixedSpring Ptr
	Declare Function front    () As FixedSpring Ptr
	Declare Function push_back( ByRef P As FixedSpring ) As FixedSpring Ptr
	
	Declare Sub reserve( ByVal C As Integer )
	Declare Sub clear()
	
	Private:
	
	As Integer size_          '' number of elements in use
	As Integer capacity_      '' number of Reserved elements
	As FixedSpring Ptr back_  '' Ptr to last elemet
	As FixedSpring Ptr front_ '' Ptr to first element
	As FixedSpring Ptr index_ '' array index
	
End Type


''
Type LinearSpringArray
	
	Public:
	
	Declare Constructor()
	Declare Constructor( ByRef P As LinearSpringArray )
	
	Declare Destructor()
	
	Declare Operator Let( ByRef P As LinearSpringArray )
	Declare Operator [] ( ByVal i as Integer ) As LinearSpring Ptr
	
	Declare Function size     () As Integer
	Declare Function capacity () As Integer
	Declare Function back     () As LinearSpring Ptr
	Declare Function front    () As LinearSpring Ptr
	Declare Function push_back( ByRef P As LinearSpring ) As LinearSpring Ptr
	
	Declare Sub reserve( ByVal C As Integer )
	Declare Sub clear()
	
	Private:
	
	As Integer size_           '' number of elements in use
	As Integer capacity_       '' number of Reserved elements
	As LinearSpring Ptr back_  '' Ptr to last elemet
	As LinearSpring Ptr front_ '' Ptr to first element
	As LinearSpring Ptr index_ '' array index
	
End Type


''
Type LineSegmentArray
	
	Public:
	
	Declare Constructor()
	Declare Constructor( ByRef P As LineSegmentArray )
	
	Declare Destructor()
	
	Declare Operator Let( ByRef P As LineSegmentArray )
	Declare Operator [] ( ByVal i as Integer ) As LineSegment Ptr
	
	Declare Function size     () As Integer
	Declare Function capacity () As Integer
	Declare Function back     () As LineSegment Ptr
	Declare Function front    () As LineSegment Ptr
	Declare Function push_back( ByRef P As LineSegment ) As LineSegment Ptr
	
	Declare Sub reserve( ByVal C As Integer )
	Declare Sub clear()
	
	Private:
	
	As Integer size_          '' number of elements in use
	As Integer capacity_      '' number of Reserved elements
	As LineSegment Ptr back_  '' Ptr to last elemet
	As LineSegment Ptr front_ '' Ptr to first element
	As LineSegment Ptr index_ '' array index
	
End Type


''
Type ParticleArray
	
	Public:
	
	Declare Constructor()
	Declare Constructor( ByRef P As ParticleArray )
	
	Declare Destructor()
	
	Declare Operator Let( ByRef P As ParticleArray )
	Declare Operator [] ( ByVal i as Integer ) As Particle Ptr
	
	Declare Function size     () As Integer
	Declare Function capacity () As Integer
	Declare Function back     () As Particle Ptr
	Declare Function front    () As Particle Ptr
	Declare Function push_back( ByRef P As Particle ) As Particle Ptr
	
	Declare Sub reserve( ByVal C As Integer )
	Declare Sub clear()
	
	Private:
	
	As Integer size_        '' number of elements in use
	As Integer capacity_    '' number of reserved elements
	As Particle Ptr back_  '' Ptr to last elemet
	As Particle Ptr front_ '' Ptr to first element
	As Particle Ptr index_ '' array index
	
End Type


''
Type BodyArray
	
	Public:
	
	Declare Constructor()
	Declare Constructor( ByRef P As BodyArray )
	
	Declare Destructor()
	
	Declare Operator Let( ByRef P As BodyArray )
	Declare Operator [] ( ByVal i as Integer ) As Body Ptr
	
	Declare Function size     () As Integer
	Declare Function capacity () As Integer
	Declare Function back     () As Body Ptr
	Declare Function front    () As Body Ptr
	Declare Function push_back( ByRef P As Body ) As Body Ptr
	
	Declare Sub reserve( ByVal C As Integer )
	Declare Sub clear()
	
	Private:
	
	As Integer size_        '' number of elements in use
	As Integer capacity_    '' number of reserved elements
	As Body Ptr back_  '' Ptr to last elemet
	As Body Ptr front_ '' Ptr to first element
	As Body Ptr index_ '' array index
	
End Type


''
Type SpringBodyArray
	
	Public:
	
	Declare Constructor()
	Declare Constructor( ByRef P As SpringBodyArray )
	
	Declare Destructor()
	
	Declare Operator Let( ByRef P As SpringBodyArray )
	Declare Operator [] ( ByVal i as Integer ) As SpringBody Ptr
	
	Declare Function size     () As Integer
	Declare Function capacity () As Integer
	Declare Function back     () As SpringBody Ptr
	Declare Function front    () As SpringBody Ptr
	Declare Function push_back( ByRef P As SpringBody ) As SpringBody Ptr
	
	Declare Sub reserve( ByVal C As Integer )
	Declare Sub clear()
	
	Private:
	
	As Integer size_        '' number of elements in use
	As Integer capacity_    '' number of reserved elements
	As SpringBody Ptr back_  '' Ptr to last elemet
	As SpringBody Ptr front_ '' Ptr to first element
	As SpringBody Ptr index_ '' array index
	
End Type


''
Type PressureBodyArray
	
	Public:
	
	Declare Constructor()
	Declare Constructor( ByRef P As PressureBodyArray )
	
	Declare Destructor()
	
	Declare Operator Let( ByRef P As PressureBodyArray )
	Declare Operator [] ( ByVal i as Integer ) As PressureBody Ptr
	
	Declare Function size     () As Integer
	Declare Function capacity () As Integer
	Declare Function back     () As PressureBody Ptr
	Declare Function front    () As PressureBody Ptr
	Declare Function push_back( ByRef P As PressureBody ) As PressureBody Ptr
	
	Declare Sub reserve( ByVal C As Integer )
	Declare Sub clear()
	
	Private:
	
	As Integer size_           '' number of elements in use
	As Integer capacity_       '' number of reserved elements
	As PressureBody Ptr back_  '' Ptr to last elemet
	As PressureBody Ptr front_ '' Ptr to first element
	As PressureBody Ptr index_ '' array index
	
End Type


''******************************************************************************
'' AngularSpringArray
''******************************************************************************

'' Constructors
Constructor AngularSpringArray()
	
	Clear()
	
End Constructor

Constructor AngularSpringArray( ByRef P As AngularSpringArray )
	
	Clear()
	
	This = P
	
End Constructor


'' Destructor
Destructor AngularSpringArray()
	
	Clear()
	
End Destructor


'' Operators
Operator AngularSpringArray.Let( ByRef P As AngularSpringArray )
	
	''	TO-do: reorganize to make self-assignment safe
	
	Clear()
		
	Reserve( P.Capacity )
	
	For I As AngularSpring Ptr = P.Front To P.Back
		
		Push_Back( *I )
		
	Next
	
End Operator

Operator AngularSpringArray.[]( ByVal i as Integer ) As AngularSpring Ptr
	
	Return index_ + i
	
End Operator


'' Functions
Function AngularSpringArray.push_back( ByRef P As AngularSpring ) As AngularSpring Ptr
	
	If ( Size_ >= Capacity_ ) Then Return 0
		
	Back_ = Index_ + Size_
	
	*Back_ = P
	
	Size_ += 1
	
	Return Back_
	
End Function

Function AngularSpringArray.size() As Integer
	
	Return Size_
	
End Function

Function AngularSpringArray.Capacity() As Integer
	
	Return Capacity_
	
End Function

Function AngularSpringArray.Back() As AngularSpring Ptr
	
	Return Back_
	
End Function

Function AngularSpringArray.Front() As AngularSpring Ptr
	
	Return Front_
	
End Function


''
Sub AngularSpringArray.Reserve( ByVal C As Integer )
	
	Clear()
	
	If ( C > 0 ) Then
		
		Capacity_ = C
		Size_     = 0
		
		Index_ = New AngularSpring[ Capacity_ ]
		
		Back_  = Index_
		Front_ = Index_
		
	End If
	
End Sub

Sub AngularSpringArray.Clear()
	
	Capacity_ = 0
	Size_     = 0
	Back_     = 0
	Front_    = 0
	
	If ( Index_ > 0 ) Then Delete[] Index_
	
	Index_ = 0
	
End Sub


''******************************************************************************
'' RotateArray
''******************************************************************************

Constructor RotateArray()
	
	Clear()
	
End Constructor

Constructor RotateArray( ByRef P As RotateArray )
	
	Clear()
	
	This = P
	
End Constructor


'' Destructor
Destructor RotateArray()
	
	Clear()
	
End Destructor


'' Operators
Operator RotateArray.Let( ByRef P As RotateArray )
	
	''	TO-do: reorganize to make self-assignment safe
	
	Clear()
		
	Reserve( P.Capacity )
	
	For I As Rotate Ptr = P.Front To P.Back
		
		Push_Back( *I )
		
	Next
	
End Operator

Operator RotateArray.[]( ByVal i as Integer ) As Rotate Ptr
	
	Return index_ + i
	
End Operator


'' Functions
Function RotateArray.push_back( ByRef P As Rotate ) As Rotate Ptr
	
	If ( Size_ >= Capacity_ ) Then Return 0
		
	Back_ = Index_ + Size_
	
	*Back_ = P
	
	Size_ += 1
	
	Return Back_
	
End Function

Function RotateArray.size() As Integer
	
	Return Size_
	
End Function

Function RotateArray.Capacity() As Integer
	
	Return Capacity_
	
End Function

Function RotateArray.Back() As Rotate Ptr
	
	Return Back_
	
End Function

Function RotateArray.Front() As Rotate Ptr
	
	Return Front_
	
End Function


''
Sub RotateArray.Reserve( ByVal C As Integer )
	
	Clear()
	
	If ( C > 0 ) Then
		
		Capacity_ = C
		Size_     = 0
		
		Index_ = New Rotate[ Capacity_ ]
		
		Back_  = Index_
		Front_ = Index_
		
	End If
	
End Sub

Sub RotateArray.Clear()
	
	Capacity_ = 0
	Size_     = 0
	Back_     = 0
	Front_    = 0
	
	If ( Index_ > 0 ) Then Delete[] Index_
	
	Index_ = 0
	
End Sub


''******************************************************************************
'' FixedSpringArray
''******************************************************************************

Constructor FixedSpringArray()
	
	Clear()
	
End Constructor

Constructor FixedSpringArray( ByRef P As FixedSpringArray )
	
	Clear()
	
	This = P
	
End Constructor


'' Destructor
Destructor FixedSpringArray()
	
	Clear()
	
End Destructor


'' Operators
Operator FixedSpringArray.Let( ByRef P As FixedSpringArray )
	
	''	TO-do: reorganize to make self-assignment safe
	
	Clear()
		
	Reserve( P.Capacity )
	
	For I As FixedSpring Ptr = P.Front To P.Back
		
		Push_Back( *I )
		
	Next
	
End Operator

Operator FixedSpringArray.[]( ByVal i as Integer ) As FixedSpring Ptr
	
	Return index_ + i
	
End Operator


'' Functions
Function FixedSpringArray.push_back( ByRef P As FixedSpring ) As FixedSpring Ptr
	
	If ( Size_ >= Capacity_ ) Then Return 0
		
	Back_ = Index_ + Size_
	
	*Back_ = P
	
	Size_ += 1
	
	Return Back_
	
End Function

Function FixedSpringArray.size() As Integer
	
	Return Size_
	
End Function

Function FixedSpringArray.Capacity() As Integer
	
	Return Capacity_
	
End Function

Function FixedSpringArray.Back() As FixedSpring Ptr
	
	Return Back_
	
End Function

Function FixedSpringArray.Front() As FixedSpring Ptr
	
	Return Front_
	
End Function


''
Sub FixedSpringArray.Reserve( ByVal C As Integer )
	
	Clear()
	
	If ( C > 0 ) Then
		
		Capacity_ = C
		Size_     = 0
		
		Index_ = New FixedSpring[ Capacity_ ]
		
		Back_  = Index_
		Front_ = Index_
		
	End If
	
End Sub

Sub FixedSpringArray.Clear()
	
	Capacity_ = 0
	Size_     = 0
	Back_     = 0
	Front_    = 0
	
	If ( Index_ > 0 ) Then Delete[] Index_
	
	Index_ = 0
	
End Sub


''******************************************************************************
'' LinearSpringArray
''******************************************************************************

'' Constructors
Constructor LinearSpringArray()
	
	Clear()
	
End Constructor

Constructor LinearSpringArray( ByRef P As LinearSpringArray )
	
	Clear()
	
	This = P
	
End Constructor


'' Destructor
Destructor LinearSpringArray()
	
	Clear()
	
End Destructor


'' Operators
Operator LinearSpringArray.Let( ByRef P As LinearSpringArray )
	
	''	TO-do: reorganize to make self-assignment safe
	
	Clear()
		
	Reserve( P.Capacity )
	
	For I As LinearSpring Ptr = P.Front To P.Back
		
		Push_Back( *I )
		
	Next
	
End Operator

Operator LinearSpringArray.[]( ByVal i as Integer ) As LinearSpring Ptr
	
	Return index_ + i
	
End Operator


'' Functions
Function LinearSpringArray.push_back( ByRef P As LinearSpring ) As LinearSpring Ptr
	
	If ( Size_ >= Capacity_ ) Then Return 0
		
	Back_ = Index_ + Size_
	
	*Back_ = P
	
	Size_ += 1
	
	Return Back_
	
End Function

Function LinearSpringArray.size() As Integer
	
	Return Size_
	
End Function

Function LinearSpringArray.Capacity() As Integer
	
	Return Capacity_
	
End Function

Function LinearSpringArray.Back() As LinearSpring Ptr
	
	Return Back_
	
End Function

Function LinearSpringArray.Front() As LinearSpring Ptr
	
	Return Front_
	
End Function


''
Sub LinearSpringArray.Reserve( ByVal C As Integer )
	
	Clear()
	
	If ( C > 0 ) Then
		
		Capacity_ = C
		Size_     = 0
		
		Index_ = New LinearSpring[ Capacity_ ]
		
		Back_  = Index_
		Front_ = Index_
		
	End If
	
End Sub

Sub LinearSpringArray.Clear()
	
	Capacity_ = 0
	Size_     = 0
	Back_     = 0
	Front_    = 0
	
	If ( Index_ > 0 ) Then Delete[] Index_
	
	Index_ = 0
	
End Sub


''******************************************************************************
'' LineSegmentArray
''******************************************************************************

'' Constructors
Constructor LineSegmentArray()
	
	Clear()
	
End Constructor

Constructor LineSegmentArray( ByRef P As LineSegmentArray )
	
	Clear()
	
	This = P
	
End Constructor


'' Destructor
Destructor LineSegmentArray()
	
	Clear()
	
End Destructor


'' Operators
Operator LineSegmentArray.Let( ByRef P As LineSegmentArray )
	
	''	TO-do: reorganize to make self-assignment safe
	
	Clear()
		
	Reserve( P.Capacity )
	
	For I As LineSegment Ptr = P.Front To P.Back
		
		Push_Back( *I )
		
	Next
	
End Operator

Operator LineSegmentArray.[]( ByVal i as Integer ) As LineSegment Ptr
	
	Return index_ + i
	
End Operator


'' Functions
Function LineSegmentArray.push_back( ByRef P As LineSegment ) As LineSegment Ptr
	
	If ( Size_ >= Capacity_ ) Then Return 0
		
	Back_ = Index_ + Size_
	
	*Back_ = P
	
	Size_ += 1
	
	Return Back_
	
End Function

Function LineSegmentArray.size() As Integer
	
	Return Size_
	
End Function

Function LineSegmentArray.Capacity() As Integer
	
	Return Capacity_
	
End Function

Function LineSegmentArray.Back() As LineSegment Ptr
	
	Return Back_
	
End Function

Function LineSegmentArray.Front() As LineSegment Ptr
	
	Return Front_
	
End Function


''
Sub LineSegmentArray.Reserve( ByVal C As Integer )
	
	Clear()
	
	If ( C > 0 ) Then
		
		Capacity_ = C
		Size_     = 0
		
		Index_ = New LineSegment[ Capacity_ ]
		
		Back_  = Index_
		Front_ = Index_
		
	End If
	
End Sub

Sub LineSegmentArray.Clear()
	
	Capacity_ = 0
	Size_     = 0
	Back_     = 0
	Front_    = 0
	
	If ( Index_ > 0 ) Then Delete[] Index_
	
	Index_ = 0
	
End Sub


''******************************************************************************
'' ParticleArray
''******************************************************************************

'' Constructors
Constructor ParticleArray()
	
	Clear()
	
End Constructor

Constructor ParticleArray( ByRef P As ParticleArray )
	
	Clear()
	
	This = P
	
End Constructor


'' Destructor
Destructor ParticleArray()
	
	Clear()
	
End Destructor


'' Operators
Operator ParticleArray.Let( ByRef P As ParticleArray )
	
	''	TO-do: reorganize to make self-assignment safe
	
	Clear()
		
	Reserve( P.Capacity )
	
	For I As Particle Ptr = P.Front To P.Back
		
		Push_Back( *I )
		
	Next
	
End Operator

Operator ParticleArray.[]( ByVal i as Integer ) As Particle Ptr
	
	Return index_ + i
	
End Operator


'' Functions
Function ParticleArray.push_back( ByRef P As Particle ) As Particle Ptr
	
	If ( Size_ >= Capacity_ ) Then Return 0
		
	Back_ = Index_ + Size_
	
	*Back_ = P
	
	Size_ += 1
	
	Return Back_
	
End Function

Function ParticleArray.size() As Integer
	
	Return Size_
	
End Function

Function ParticleArray.Capacity() As Integer
	
	Return Capacity_
	
End Function

Function ParticleArray.Back() As Particle Ptr
	
	Return Back_
	
End Function

Function ParticleArray.Front() As Particle Ptr
	
	Return Front_
	
End Function


''
Sub ParticleArray.Reserve( ByVal C As Integer )
	
	Clear()
	
	If ( C > 0 ) Then
		
		Capacity_ = C
		Size_     = 0
		
		Index_ = New Particle[ Capacity_ ]
		
		Back_  = Index_
		Front_ = Index_
		
	End If
	
End Sub

Sub ParticleArray.Clear()
	
	Capacity_ = 0
	Size_     = 0
	Back_     = 0
	Front_    = 0
	
	If ( Index_ > 0 ) Then Delete[] Index_
	
	Index_ = 0
	
End Sub


''******************************************************************************
'' BodyArray
''******************************************************************************

'' Constructors
Constructor BodyArray()
	
	Clear()
	
End Constructor

Constructor BodyArray( ByRef P As BodyArray )
	
	Clear()
	
	This = P
	
End Constructor


'' Destructor
Destructor BodyArray()
	
	Clear()
	
End Destructor


'' Operators
Operator BodyArray.Let( ByRef P As BodyArray )
	
	''	TO-do: reorganize to make self-assignment safe
	
	Clear()
		
	Reserve( P.Capacity )
	
	For I As Body Ptr = P.Front To P.Back
		
		Push_Back( *I )
		
	Next
	
End Operator

Operator BodyArray.[]( ByVal i as Integer ) As Body Ptr
	
	Return index_ + i
	
End Operator


'' Functions
Function BodyArray.push_back( ByRef P As Body ) As Body Ptr
	
	If ( Size_ >= Capacity_ ) Then Return 0
		
	Back_ = Index_ + Size_
	
	*Back_ = P
	
	Size_ += 1
	
	Return Back_
	
End Function

Function BodyArray.size() As Integer
	
	Return Size_
	
End Function

Function BodyArray.Capacity() As Integer
	
	Return Capacity_
	
End Function

Function BodyArray.Back() As Body Ptr
	
	Return Back_
	
End Function

Function BodyArray.Front() As Body Ptr
	
	Return Front_
	
End Function


''
Sub BodyArray.Reserve( ByVal C As Integer )
	
	Clear()
	
	If ( C > 0 ) Then
		
		Capacity_ = C
		Size_     = 0
		
		Index_ = New Body[ Capacity_ ]
		
		Back_  = Index_
		Front_ = Index_
		
	End If
	
End Sub

Sub BodyArray.Clear()
	
	Capacity_ = 0
	Size_     = 0
	Back_     = 0
	Front_    = 0
	
	If ( Index_ > 0 ) Then Delete[] Index_
	
	Index_ = 0
	
End Sub


''******************************************************************************
'' SpringBodyArray
''******************************************************************************

'' Constructors
Constructor SpringBodyArray()
	
	Clear()
	
End Constructor

Constructor SpringBodyArray( ByRef P As SpringBodyArray )
	
	Clear()
	
	This = P
	
End Constructor


'' Destructor
Destructor SpringBodyArray()
	
	Clear()
	
End Destructor


'' Operators
Operator SpringBodyArray.Let( ByRef P As SpringBodyArray )
	
	''	TO-do: reorganize to make self-assignment safe
	
	Clear()
		
	Reserve( P.Capacity )
	
	For I As SpringBody Ptr = P.Front To P.Back
		
		Push_Back( *I )
		
	Next
	
End Operator

Operator SpringBodyArray.[]( ByVal i as Integer ) As SpringBody Ptr
	
	Return index_ + i
	
End Operator


'' Functions
Function SpringBodyArray.push_back( ByRef P As SpringBody ) As SpringBody Ptr
	
	If ( Size_ >= Capacity_ ) Then Return 0
		
	Back_ = Index_ + Size_
	
	*Back_ = P
	
	Size_ += 1
	
	Return Back_
	
End Function

Function SpringBodyArray.size() As Integer
	
	Return Size_
	
End Function

Function SpringBodyArray.Capacity() As Integer
	
	Return Capacity_
	
End Function

Function SpringBodyArray.Back() As SpringBody Ptr
	
	Return Back_
	
End Function

Function SpringBodyArray.Front() As SpringBody Ptr
	
	Return Front_
	
End Function


''
Sub SpringBodyArray.Reserve( ByVal C As Integer )
	
	Clear()
	
	If ( C > 0 ) Then
		
		Capacity_ = C
		Size_     = 0
		
		Index_ = New SpringBody[ Capacity_ ]
		
		Back_  = Index_
		Front_ = Index_
		
	End If
	
End Sub

Sub SpringBodyArray.Clear()
	
	Capacity_ = 0
	Size_     = 0
	Back_     = 0
	Front_    = 0
	
	If ( Index_ > 0 ) Then Delete[] Index_
	
	Index_ = 0
	
End Sub


''******************************************************************************
'' PressureBodyArray
''******************************************************************************

'' Constructors
Constructor PressureBodyArray()
	
	Clear()
	
End Constructor

Constructor PressureBodyArray( ByRef P As PressureBodyArray )
	
	Clear()
	
	This = P
	
End Constructor


'' Destructor
Destructor PressureBodyArray()
	
	Clear()
	
End Destructor


'' Operators
Operator PressureBodyArray.Let( ByRef P As PressureBodyArray )
	
	''	TO-do: reorganize to make self-assignment safe
	
	Clear()
	
	Reserve( P.Capacity )
	
	For I As PressureBody Ptr = P.Front To P.Back
		
		Push_Back( *I )
		
	Next
	
End Operator

Operator PressureBodyArray.[]( ByVal i as Integer ) As PressureBody Ptr
	
	Return index_ + i
	
End Operator


'' Functions
Function PressureBodyArray.push_back( ByRef P As PressureBody ) As PressureBody Ptr
	
	If ( Size_ >= Capacity_ ) Then Return 0
		
	Back_ = Index_ + Size_
	
	*Back_ = P
	
	Size_ += 1
	
	Return Back_
	
End Function

Function PressureBodyArray.size() As Integer
	
	Return Size_
	
End Function

Function PressureBodyArray.Capacity() As Integer
	
	Return Capacity_
	
End Function

Function PressureBodyArray.Back() As PressureBody Ptr
	
	Return Back_
	
End Function

Function PressureBodyArray.Front() As PressureBody Ptr
	
	Return Front_
	
End Function


''
Sub PressureBodyArray.Reserve( ByVal C As Integer )
	
	Clear()
	
	If ( C > 0 ) Then
		
		Capacity_ = C
		Size_     = 0
		
		Index_ = New PressureBody[ Capacity_ ]
		
		Back_  = Index_
		Front_ = Index_
		
	End If
	
End Sub

Sub PressureBodyArray.Clear()
	
	Capacity_ = 0
	Size_     = 0
	Back_     = 0
	Front_    = 0
	
	If ( Index_ > 0 ) Then Delete[] Index_
	
	Index_ = 0
	
End Sub

#EndIf ''__S2_MEM_ARRAYS_BI__
