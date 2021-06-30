''*******************************************************************************
''    
''   Squishy2D Memory Management Class
''   Written in FreeBASIC 1.04
''   version 0.1.0, November 2015, Michael "h4tt3n" Nissen
''
''   Arrays of objects
''	  These are used by the World class to store all objects.
''   The objects in these arrays cannot be moved or deleted 
''   at runtime,or the pointers to them will be invalidated.
''
''*******************************************************************************


''
#Ifndef __S2_MEMORY_BI__
#Define __S2_MEMORY_BI__


''
Type AngularSpringArray
	
	Public:
	
	Private:
	
	As Integer size_            '' number of elements in use
	As Integer capacity_        '' number of Reserved elements
	As AngularSpring Ptr back_  '' pointer to last elemet
	As AngularSpring Ptr front_ '' pointer to first element
	As AngularSpring Ptr index_ '' array index
	
End Type

Type BodyArray
	
	As Integer size_      '' number of elements in use
	As Integer capacity_  '' number of Reserved elements
	As Body Ptr back_     '' pointer to last elemet
	As Body Ptr front_    '' pointer to first element
	As Body Ptr index_    '' array index
	
End Type

Type FixedAngleSpringArray
	
	Public:
	
	Private:
	
	As Integer size_               '' number of elements in use
	As Integer capacity_           '' number of Reserved elements
	As FixedAngleSpring Ptr back_  '' pointer to last elemet
	As FixedAngleSpring Ptr front_ '' pointer to first element
	As FixedAngleSpring Ptr index_ '' array index
	
End Type

Type LinearSpringArray
	
	Public:
	
	Private:
	
	As Integer size_           '' number of elements in use
	As Integer capacity_       '' number of Reserved elements
	As LinearSpring Ptr back_  '' pointer to last elemet
	As LinearSpring Ptr front_ '' pointer to first element
	As LinearSpring Ptr index_ '' array index
	
End Type

Type LineSegmentArray
	
	Public:
	
	Private:
	
	As Integer size_          '' number of elements in use
	As Integer capacity_      '' number of Reserved elements
	As LineSegment Ptr back_  '' pointer to last elemet
	As LineSegment Ptr front_ '' pointer to first element
	As LineSegment Ptr index_ '' array index
	
End Type

Type PointMassArray
	
	Public:
	
	Declare Constructor()
	Declare Constructor( ByRef P As PointMassArray )
	
	Declare Destructor()
	
	Declare Operator Let( ByRef P As PointMassArray )
	Declare Operator [] ( ByVal i as Integer ) As PointMass Ptr
	
	Declare Function size     () As Integer
	Declare Function capacity () As Integer
	Declare Function back     () As PointMass Ptr
	Declare Function front    () As PointMass Ptr
	Declare Function push_back( ByRef P As PointMass ) As PointMass Ptr
	
	Declare Sub reserve( ByVal C As Integer )
	Declare Sub clear()
	
	Private:
	
	As Integer size_        '' number of elements in use
	As Integer capacity_    '' number of reserved elements
	As PointMass Ptr back_  '' pointer to last elemet
	As PointMass Ptr front_ '' pointer to first element
	As PointMass Ptr index_ '' array index
	
End Type


'' Constructors
Constructor PointMassArray()
	
	Clear()
	
End Constructor

Constructor PointMassArray( ByRef P As PointMassArray )
	
	Clear()
	
	This = P
	
End Constructor


'' Destructor
Destructor PointMassArray()
	
	Clear()
	
End Destructor


'' Operators
Operator PointMassArray.Let( ByRef P As PointMassArray )
	
	''	TO-do: reorganize to make self-assignment safe
	
	Clear()
		
	Capacity_ = P.Capacity
	
	Reserve( Capacity_ )
	
	For I As PointMass Ptr = P.Front To P.Back
		
		Push_Back( *I )
		
	Next
	
End Operator

Operator PointMassArray.[]( ByVal i as Integer ) As PointMass Ptr
	
	Return @index_[ i ]
	
End Operator


'' Functions
Function PointMassArray.push_back( ByRef P As PointMass ) As PointMass Ptr
	
	If ( Size_ >= Capacity_ ) Then Return 0
		
	Back_ = @Index_[ Size_ ]
	
	*Back_ = P
	
	Size_ += 1
	
	Return Back_
	
End Function

Function PointMassArray.size() As Integer
	
	Return Size_
	
End Function

Function PointMassArray.Capacity() As Integer
	
	Return Capacity_
	
End Function

Function PointMassArray.Back() As PointMass Ptr
	
	Return Back_
	
End Function

Function PointMassArray.Front() As PointMass Ptr
	
	Return Front_
	
End Function


''
Sub PointMassArray.Reserve( ByVal C As Integer )
	
	If ( C > 0 ) Then
		
		Capacity_ = C
		Size_     = 0
		
		Index_ = New PointMass[ Capacity_ ]
		
		Back_  = @Index_[ 0 ]
		Front_ = @Index_[ 0 ]
		
	End If
	
End Sub

Sub PointMassArray.Clear()
	
	Capacity_ = 0
	Size_     = 0
	Back_     = 0
	Front_    = 0
	
	If ( Index_ > 0 ) Then Delete[] Index_
	
	Index_ = 0
	
End Sub


#EndIf ''__S2_MEMORY_BI__
