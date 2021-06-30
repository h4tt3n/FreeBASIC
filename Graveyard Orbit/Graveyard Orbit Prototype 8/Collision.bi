

''
Function GameType.ClosestPointOnLinearLink( ByVal LP As LinearLinkType Ptr, ByVal P As Vec2 ) As Vec2
	
	Dim As Vec2 ab = LP->b->position - LP->a->position
	
	Dim As Vec2 ap = p - LP->a->position
	
	Dim As Single t = ap.dot( ab ) / ab.dot( ab )
	
	If t < 0.0 Then t = 0.0
   If t > 1.0 Then t = 1.0
   
   Return LP->a->position + ab * t
	
End Function

''
Sub GameType.CollisionResponse( ByVal R1 As RoxelType Ptr, ByVal R2 As RoxelType Ptr )
	
	
	
End Sub

Sub GameType.CollisionResponse( ByVal B1 As BoxType Ptr, ByVal B2 As BoxType Ptr )
	
End Sub

Sub GameType.CollisionResponse( ByVal BP As BoxType Ptr, Byval LP As LinearLinkType Ptr )
	
End Sub

Sub GameType.CollisionResponse( ByVal BP As BoxType Ptr, ByVal WP As WheelType Ptr )
	
End Sub

Sub GameType.CollisionResponse( ByVal WP As WheelType Ptr, Byval LP As LinearLinkType Ptr )
	
End Sub

Sub GameType.CollisionResponse( ByVal W1 As WheelType Ptr, ByVal W2 As WheelType Ptr )
	
	'' State
	Dim As AngularStateType Ptr body_a = @(W1->AngularState)
	Dim As AngularStateType Ptr body_b = @(W2->AngularState)
	
	
	
	'Dim As Vec2 position_a = body_a->position + r_a
	'Dim As Vec2 position_b = body_b->position + r_b
	'
	'Dim As Vec2 velocity_a = body_a->velocity + r_a.Perpdot( body_a->angular_velocity )
	'Dim As Vec2 velocity_b = body_b->velocity + r_b.Perpdot( body_b->angular_velocity )
	'
	'Dim As Vec2 distance = position_b - position_a
	'Dim As Vec2 velocity = velocity_b - velocity_a
	'
	'unit = distance.Unit()
	'
	''' Error
	'Dim As Single distance_error = unit.dot( distance ) - rest_distance
	'Dim As Single velocity_error = unit.dot( velocity )
	'
	''' Correction
	'rest_impulse = -( c_stiffness * distance_error * inv_dt + c_damping * velocity_error )
	'
	''' Reduced mass scalar
	'Dim As Single K1 = body_a->inv_mass + body_b->inv_mass
	'Dim As Single K2 = body_a->inv_inertia * unit.perpdot( r_a ) * unit.perpdot( r_a )
	'Dim As Single K3 = body_b->inv_inertia * unit.perpdot( r_b ) * unit.perpdot( r_b )
	'
	'Dim As Single K = K1 + K2 + K3
	'
	'M = IIf( K > 0.0 , 1.0 / K , 0.0 )
	
End Sub
