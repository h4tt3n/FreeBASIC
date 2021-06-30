''*******************************************************************************
''    
''   Squishy2D Memory Management
''   Written in FreeBASIC 1.04
''   version 0.1.0, November 2015, Michael "h4tt3n" Nissen
''
''   Arrays of pointers to objects
''   These are used by complex objects to keep track of the
''   simple objects (point masses, springs) they are composed of.
''   The content of these can safely be moved or deleted at runtime.
''   
''
''*******************************************************************************


''


'Type AngularSpringPointerArray
'	
'	Public:
'	
'	Private:
'	
'	As Integer size_                '' number of elements in use
'	As Integer capacity_            '' number of Reserved elements
'	As AngularSpring Ptr back_      '' pointer to last elemet
'	As AngularSpring Ptr front_     '' pointer to first element
'	As AngularSpring Ptr Ptr index_ '' array index
'	
'End Type

Type FixedAngleSpringPointerArray
	
	Public:
	
	Private:
	
	As Integer size_                   '' number of elements in use
	As Integer capacity_               '' number of Reserved elements
	As FixedAngleSpring Ptr back_      '' pointer to last elemet
	As FixedAngleSpring Ptr front_     '' pointer to first element
	As FixedAngleSpring Ptr Ptr index_ '' array index
	
End Type

Type LinearSpringPointerArray
	
	Public:
	
	Private:
	
	As Integer size_               '' number of elements in use
	As Integer capacity_           '' number of Reserved elements
	As LinearSpring Ptr back_      '' pointer to last elemet
	As LinearSpring Ptr front_     '' pointer to first element
	As LinearSpring Ptr Ptr index_ '' array index
	
End Type

Type PointMassPointerArray
	
	Public:
	
	Private:
	
	As Integer size_            '' number of elements in use
	As Integer capacity_        '' number of Reserved elements
	As PointMass Ptr back_      '' pointer to last elemet
	As PointMass Ptr front_     '' pointer to first element
	As PointMass Ptr Ptr index_ '' array index
	
End Type

