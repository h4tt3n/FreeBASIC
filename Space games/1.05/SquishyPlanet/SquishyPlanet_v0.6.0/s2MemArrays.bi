''******************************************************************************
''    
''   Squishy2D Memory Management Classes
''   Written in FreeBASIC 1.05
''   version 0.2.0, May 2016, Michael "h4tt3n" Nissen
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


DynamicArrayType( AngularSpringArray, AngularSpring )
DynamicArrayType( BodyArray, Body )
DynamicArrayType( CellArray, Cell )
DynamicArrayType( FixedSpringArray, FixedSpring )
DynamicArrayType( KeplerOrbitArray, KeplerOrbit )
DynamicArrayType( LineSegmentArray, LineSegment )
DynamicArrayType( LinearSpringArray, LinearSpring )
DynamicArrayType( NewtonGravityArray, NewtonGravity )
DynamicArrayType( ParticleArray, Particle )
DynamicArrayType( PressureBodyArray, PressureBody )
DynamicArrayType( RotateArray, Rotate )
DynamicArrayType( SpringBodyArray, SpringBody )


#EndIf ''__S2_MEM_ARRAYS_BI__
