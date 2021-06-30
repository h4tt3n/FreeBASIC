''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 7, february 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''*******************************************************************************


Function GameType.CreateLinearState( ByVal _mass  As Single, _
	                                  ByVal _array As LinearStateArray Ptr ) As LinearStateType Ptr
	
	Dim As LinearStateType L
	
	Dim As LinearStateType Ptr LP = _array->push_back( L )
	
	LP->mass = _mass
	
	LP->ComputeInvMass()
	
	Return LP
	
End Function

Function GameType.CreateLinearState( ByVal _position As Vec2, _
	                                  ByVal _mass     As Single, _
	                                  ByVal _array    As LinearStateArray Ptr ) As LinearStateType Ptr
	
	Dim As LinearStateType L
	
	Dim As LinearStateType Ptr LP = _array->push_back( L )
	
	LP->position = _position
	LP->mass     = _mass
	
	LP->ComputeInvMass()
	
	Return LP
	
End Function
	
Function GameType.CreateRoxel( ByVal _position As Vec2, _
	                            ByVal _mass     As Single, _
	                            ByVal _radius   As Single ) As RoxelType Ptr
	
	Dim As RoxelType R
	
	Dim As RoxelType Ptr RP = Roxels.push_back( R )
	
	RP->position = _position
	RP->mass     = _mass
	
	RP->ComputeInvMass()
	
	RP->radius = IIf( _radius > 0.0, _radius , ( ( _mass / C_DENSITY ) / (4/3) * PI ) ^ (1/3) )
	
	Return RP
	
End Function
	
Function GameType.CreateGravity( ByVal _linear1 As LinearStateType Ptr, _
	                              ByVal _linear2 As LinearStateType Ptr ) As GravityType Ptr
	
	Dim As GravityType G
	
	Dim As GravityType Ptr GP = Gravitys.push_back( G )
	
	GP->LinearLink.a = _linear1
	GP->LinearLink.b = _linear2
	
	GP->LinearLink.mass = GP->LinearLink.a->mass + GP->LinearLink.b->mass
		
	GP->LinearLink.ComputeInvMass()
		
	GP->LinearLink.ComputeReducedMass()
	
	GP->LinearLink.ComputeStateVectors()
	
	GP->LinearLink.ComputeUnitVector()
	
	GP->ComputeForceScale()
	
	GP->ComputeData()
	
	Return GP
	
End Function

Function GameType.CreateOrbit( ByVal Position       As Vec2, _
	                            ByVal Eccentricity   As Single, _
	                            ByVal SemiMajorAxis  As Single, _
	                            ByVal Periapsis      As Single, _
	                            ByVal MeanAnomaly    As Single, _
	                            ByVal OrbitDirection As Single, _
	                            ByVal linear1 As LinearStateType Ptr, _
	                            ByVal linear2 As LinearStateType Ptr  ) As OrbitType Ptr
	
	Dim As OrbitType O
	
	Dim As OrbitType Ptr OP = Orbits.push_back( O )
	
	OP->LinearLink.a = linear1
	OP->LinearLink.b = linear2
	
	OP->LinearLink.mass = OP->LinearLink.a->mass + OP->LinearLink.b->mass
	
	OP->LinearLink.ComputeInvMass()
	
	OP->LinearLink.ComputeReducedMass()
	
	OP->ApplyOrbit( Position, Eccentricity, SemiMajorAxis, Periapsis, MeanAnomaly, OrbitDirection )
	
	OP->LinearLink.ComputeStateVectors()
	
	OP->LinearLink.ComputeUnitVector()
	
	'OP->ComputeData()
	
	Return OP
	
End Function

Function GameType.CreateAngularSpring( ByVal _stiffness As Single, _
	                                    ByVal _damping   As Single, _
	                                    ByVal _warmstart As Single, _
	                                    ByVal _linear1   As LinearLinkType Ptr, _
	                                    ByVal _linear2   As LinearLinkType Ptr, _
	                                    ByVal _array     As AngularSpringArray Ptr ) As AngularSpringType Ptr
	
	Dim As AngularSpringType A
	
	Dim As AngularSpringType Ptr AP = _array->push_back( A )
	
	AP->c_stiffness = _stiffness
	AP->c_damping   = _damping
	AP->c_warmstart = _warmstart
	
	AP->a = _linear1
	AP->b = _linear2
	
	AP->rest_angle = Vec2( AP->a->unit_vector.dot( AP->b->unit_vector ), _
	                       AP->a->unit_vector.perpdot( AP->b->unit_vector ) )
	
	'AP->ComputeReducedIntertia()
	
	Return AP
	
End Function

Function GameType.CreateFixedSpring( ByVal _stiffness As Single, _
	                                  ByVal _damping   As Single, _
	                                  ByVal _warmstart As Single, _
	                                  ByVal _linear1   As LinearStateType Ptr, _
	                                  ByVal _linear2   As LinearStateType Ptr, _
	                                  ByVal _array     As FixedSpringArray Ptr ) As FixedSpringType Ptr
	
	Dim As FixedSpringType F
	
	Dim As FixedSpringType Ptr FP = _array->push_back( F )
	
	FP->c_stiffness = _stiffness
	FP->c_damping   = _damping
	FP->c_warmstart = _warmstart
	
	FP->LinearLink.a = _linear1
	FP->LinearLink.b = _linear2
	
	FP->rest_distance = FP->LinearLink.b->position - FP->LinearLink.a->position

	FP->LinearLink.mass = FP->LinearLink.a->mass + FP->LinearLink.b->mass
		
	FP->LinearLink.ComputeInvMass()
	
	FP->LinearLink.ComputeReducedMass()
	
	FP->ComputeData()
	
	Return FP
	
End Function

Function GameType.CreateLinearSpring( ByVal _stiffness  As Single, _
	                                   ByVal _damping    As Single, _
	                                   ByVal _warmstart  As Single, _
	                                   ByVal _linear1    As LinearStateType Ptr, _
	                                   ByVal _linear2    As LinearStateType Ptr, _
	                                   ByVal _array      As LinearSpringArray Ptr ) As LinearSpringType Ptr
	
	Dim As LinearSpringType L
	
	Dim As LinearSpringType Ptr LP = _array->push_back( L )
	
	LP->c_stiffness = _stiffness
	LP->c_damping   = _damping
	LP->c_warmstart = _warmstart
	
	LP->LinearLink.a = _linear1
	LP->LinearLink.b = _linear2
	
	LP->rest_distance = ( LP->LinearLink.b->position - LP->LinearLink.a->position ).length()

	LP->LinearLink.mass = LP->LinearLink.a->mass + LP->LinearLink.b->mass
		
	LP->LinearLink.ComputeInvMass()
		
	LP->LinearLink.ComputeReducedMass()
	
	LP->LinearLink.ComputeStateVectors()
	
	LP->LinearLink.ComputeUnitVector()
	
	LP->ComputeData()
	
	Return LP
	
End Function
