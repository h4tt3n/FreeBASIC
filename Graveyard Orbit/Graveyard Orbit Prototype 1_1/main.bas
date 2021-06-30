''*******************************************************************************
''
''  Graveyard Orbit - a 2D space physics puzzle game
''
''  Prototype Version 1.1, August 2017
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  Controls:
''  
''  Puzzles                    :  F1 - F6
''  Double / halve iterations  :  1 - 9
''  Inc. / dec. iterations     :  I + up / down
''  Inc. / dec. stiffness      :  S + up / down
''  Inc. / dec. damping        :  D + up / down
''  Inc. / dec. warmstart      :  W + up / down
''  Warmstart on / off         :  Space bar
''  Exit demo                  :  Escape key
''  
''******************************************************************************* 


''   Global constants
Const As Single  DT                 = 1.0 / 60.0       ''  timestep
Const As Single  INV_DT             = 1.0 / DT         ''  inverse timestep
Const As Single  cgravity           = 2.0             ''  gravity
Const As Single  density            = 0.05             ''  ball density
Const As Single  pi                 = 4.0 * Atn( 1.0 ) ''  pi
Const As Integer screen_wid         = 1200             ''  screen wiDTh
Const As Integer screen_hgt         = 900              ''  screen height
Const As Integer pick_distance      = 128^2            ''  mouse pick up distance

Const As Integer MAX_LINEAR_STATES       = 2048            '' 
Const As Integer MAX_ANGULAR_STATES      = 2048            ''  
Const As Integer MAX_LINEAR_LINKS        = 1024            ''
Const As Integer MAX_ANGULAR_LINKS       = 128            ''
Const As Integer MAX_ROXELS              = 4096             ''  particles
Const As Integer MAX_ROXELS_IN_BODY      = 256             ''  particles
Const As Integer MAX_RIGID_BODYS         = 128             ''  rigid bodys
Const As Integer MAX_GRAVITYS            = 2048             ''  gravitys
Const As Integer MAX_FIXED_CONSTRAINTS   = 2048             ''  
Const As Integer MAX_LL_CONSTRAINTS      = 4096             ''  
Const As Integer MAX_LA_CONSTRAINTS      = 512             ''  
Const As Integer MAX_ANGULAR_CONSTRAINTS = 2048             ''  angular springs

Enum GIRDER_TYPES
	
	S_TRUSS = 0
	Z_TRUSS
	V_TRUSS
	X_TRUSS
	K_TRUSS
	O_TRUSS
	W_TRUSS
	
End Enum


'' Includes
#Include Once "fbgfx.bi"
#Include Once "../../Math/Vec2.bi"

#Include Once "containers.bi"
#Include Once "types.bi"
#Include Once "create.bi"
#Include Once "puzzles.bi"


''	Create instance and run Game
Scope

	Static As GameType ThisGame

End Scope

'' 
Function RigidBodyType.AddRoxel( ByVal R As RoxelType Ptr ) As Boolean
	
	If ( Not R = 0 ) Then
		
		Roxels.push_back( *R )
		
		Return TRUE
		
	EndIf
	
	Return FALSE
	
End Function

Sub RigidBodyType.computeData()
	
	If ( Not Roxels.Empty ) Then
		
		'' compute mass and inverse
		Linear.Mass = 0.0
		Linear.inverse_Mass = 0.0
		
		For R As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			Linear.Mass += R->Linear.mass
			
		Next
		
		Linear.inverse_mass = IIf( Linear.Mass > 0.0 , 1.0 / Linear.Mass , 0.0 )
		
		'' compute linear state
		Linear.Position = Vec2( 0.0, 0.0 )
		Linear.Velocity = Vec2( 0.0, 0.0 )
		
		For R As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			Linear.Position += R->Linear.position * R->Linear.mass
			Linear.Velocity += R->Linear.velocity * R->Linear.mass
			
		Next
		
		Linear.Position *= Linear.inverse_mass
		Linear.Velocity *= Linear.inverse_mass
		
		'' compute moment of inertial and inverse
		Angular.inertia = 0.0
		Angular.inverse_inertia = 0.0
		
		For R As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			Dim As Vec2 local_position = R->Linear.Position - Linear.Position
			
			Angular.inertia += local_position.LengthSquared() * R->linear.mass 
			
		Next
		
		Angular.inverse_inertia = IIf( Angular.inertia > 0.0 , 1.0 / Angular.inertia , 0.0 )
		
		'' compute angular state
		Angular.velocity = 0.0
		
		For R As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			Dim As Vec2 local_position = R->Linear.Position - Linear.Position
			Dim As Vec2 local_velocity = R->Linear.Velocity - Linear.Velocity
			
			Angular.velocity += local_position.Perpdot( local_velocity * R->linear.mass )
			
		Next
		
		Angular.velocity *= Angular.inverse_inertia
		
	EndIf
	
End Sub

Sub GameType.DistributeImpulses()
	
	''
	''
	
	
	''' Angular springs
	'If ( Not AngularConstraints.Empty ) Then 
	'	
	'	For A As AngularConstraintType Ptr = AngularConstraints.P_front To AngularConstraints.P_back
	'		
	'		
	'		
	'	Next
	'
	'EndIF
	
	
	'' Rigid bodys - distribute impulses - Finally working 6/12/2016 !!!
	If ( Not Rigidbodys.empty ) Then
		
		''
		For R As RigidBodyType Ptr = rigidbodys.p_front To rigidbodys.p_back
				
			If ( Not R->Roxels.Empty ) Then 
				
				'' Sum up local impulses
				Dim As Vec2   local_linear  = Vec2( 0.0, 0.0 )
				Dim As Single local_angular = 0.0
				
				For P As RoxelType Ptr = R->Roxels.p_front To R->Roxels.p_back
					
					Dim As vec2 local_position = P->Linear.position - R->Linear.position
					
					local_linear += P->Linear.impulse * P->Linear.mass
					
					local_angular += local_position.perpdot( P->Linear.impulse * P->Linear.mass )
					
				Next
				
				'' Update global impulses (subtract previous)
				R->Linear.impulse  += local_linear  * R->Linear.Inverse_mass     - R->Linear_prev
				R->Angular.impulse += local_angular * R->angular.inverse_inertia - R->Angular_prev
				
				'' disperse global impulse
				For P As RoxelType Ptr = R->Roxels.p_front To R->Roxels.p_back
					
					Dim As vec2 local_position = P->Linear.position - R->Linear.position
					
					P->Linear.impulse = R->Linear.impulse + local_position.perpdot( R->Angular.impulse )
					
				Next
				
				'' Save global for next iteration
				R->Linear_prev  = R->Linear.impulse
				R->Angular_prev = R->Angular.impulse
				
			EndIf
		
		Next
		
	EndIf
	
End Sub

Sub RocketType.ApplyThrustImpulse( ByVal _throttle As Single )
	
	''
	Dim As Single needed_fuel = Abs( _throttle ) * FuelFlowRate_ * DT
	
	Dim As Single burned_fuel = IIf( FuelMass_ < needed_fuel , FuelMass_ , needed_fuel )
	
	Dim As Single thrust_impulse = burned_fuel * ExhaustVelocity_ * Linear.inverse_mass
	
	Linear.Impulse += thrust_impulse * Angular.direction_vector * Sgn( _throttle )
	
	FuelMass_ -= burned_fuel
	
	Linear.Mass = DryMass_ + FuelMass_
	
	Linear.inverse_mass = IIf( Linear.Mass > 0.0 , 1.0 / Linear.Mass , 0.0 )
	
End Sub


''	Main loop
Sub GameType.RunGame()
	
	Puzzle6()
	
	Do
		
		UpdateInput()
		
		ComputeData()
		
		''
		If ( warmstart ) Then 
			
			ApplyWarmStart()
			
		Else
			
			ClearWarmstart()
			
		EndIf
		
		''
		For i As Integer = 1 To iterations
			
			ApplyCorrectiveImpulse()
			DistributeImpulses()
		
		Next
		
		UpdateScreen()
		
		''
		ComputeNewState()
		
		Sleep 1, 1
		
	Loop

End Sub


'' Core physics functions
Sub GameType.ComputeData()
	
	'' Rigid bodys
	If ( Not Rigidbodys.empty ) Then
		
		''
		For R As RigidBodyType Ptr = rigidbodys.p_front To rigidbodys.p_back
			
			If ( Not R->Roxels.Empty ) Then 
				
				For P As RoxelType Ptr = R->Roxels.p_front To R->Roxels.p_back
					
					
				Next
				
			EndIf
		
		Next
		
	EndIf
	
	'' Gravity
	If ( Not Gravitys.Empty ) Then 
		
		For G As GravityType Ptr = Gravitys.P_front To Gravitys.P_back
			
			Dim As Vec2 distance_vector = G->particle_b->position - G->particle_a->position
			
			G->unit = distance_vector.Unit()
			
			Dim As Single distance_squared = distance_vector.lengthsquared()
			
			Dim As Single gravity_impulse = -( cgravity * INV_DT * G->particle_a->mass * G->particle_b->mass ) / distance_squared
			
			G->particle_a->impulse -= gravity_impulse * G->particle_a->inverse_mass * G->unit
			G->particle_b->impulse += gravity_impulse * G->particle_b->inverse_mass * G->unit
			
		Next
		
	EndIf 
	
	
	''	Linear springs
	If ( Not LL_constraints.Empty ) Then 
		
		For S As LL_constraintType Ptr = LL_constraints.P_front To LL_constraints.P_back
			
			'' desired "rest impulse" needed to satisfy the constraint
			Dim As Vec2 distance = S->particle_b->position - S->particle_a->position
			Dim As Vec2 velocity = S->particle_b->velocity - S->particle_a->velocity
			
			S->unit = distance.Unit()
			
			Dim As Single distance_error = S->unit.dot( distance ) - S->rest_distance
			Dim As Single velocity_error = S->unit.dot( velocity )
			
			S->rest_impulse = - cstiffness * distance_error * INV_DT - cdamping * velocity_error
			
			'' spring state vectors
			If ( S->particle_a->inverse_mass = 0.0 ) Then
				
				S->Linear.position = S->particle_a->position
				S->Linear.velocity = Vec2( 0.0, 0.0 )
				
			ElseIf ( S->particle_b->inverse_mass = 0.0 ) Then
				
				S->Linear.position = S->particle_b->position
				S->Linear.velocity = Vec2( 0.0, 0.0 )
				
			Else
				
				S->Linear.position = ( S->particle_a->position * S->particle_a->mass + _
			                          S->particle_b->position * S->particle_b->mass ) / _
			                        ( S->particle_a->mass + S->particle_b->mass )
				
				S->Linear.velocity = ( S->particle_a->velocity * S->particle_a->mass + _
			                          S->particle_b->velocity * S->particle_b->mass ) / _
			                        ( S->particle_a->mass + S->particle_b->mass )
				
			End If
			
			'' particle local state vectors relative to spring state vector
			S->local_position_a = S->Particle_a->Position - S->Linear.Position
			S->local_position_b = S->Particle_b->Position - S->Linear.Position
			
			S->local_velocity_a = S->Particle_a->Velocity - S->Linear.Velocity
			S->local_velocity_b = S->Particle_b->Velocity - S->Linear.Velocity
			
			'' moment of inertia and inverse
			S->inertia = S->local_position_a.lengthsquared() * S->particle_a->mass + _
			             S->local_position_b.lengthsquared() * S->particle_b->mass
			
			S->inverse_inertia = IIf( S->inertia > 0.0 , 1.0 / S->inertia, 0.0 )
			
			'' angular velocity
			S->angular_velocity = ( S->local_position_a.PerpDot( S->local_velocity_a * S->particle_a->mass ) + _
		                           S->local_position_b.PerpDot( S->local_velocity_b * S->particle_b->Mass ) ) * _
		                           S->inverse_inertia
			
		Next
		
	EndIf
	
	'' Angular springs
	If ( Not AngularConstraints.Empty ) Then 
		
		For A As AngularConstraintType Ptr = AngularConstraints.P_front To AngularConstraints.P_back
			
			'' direction between springs, Vec2( cos direction, sin direction )
			A->direction = Vec2( A->spring_a->unit.dot( A->spring_b->unit ), _
			                     A->spring_a->unit.perpdot( A->spring_b->unit ) )
			
			'' errors
			'Dim As Single direction_error = ATan2( A->direction.perpdot( A->rest_direction ), _
			'                                       A->direction.dot( A->rest_direction ) )
			Dim As Single direction_error = A->rest_direction.perpdot( A->direction )
			
			Dim As Single velocity_error = A->spring_b->angular_velocity - A->spring_a->angular_velocity
			
			'' reduced moment of inertia
			Dim As Single inverse_inertia = A->spring_a->inverse_inertia + A->spring_b->inverse_inertia
			
			A->reduced_inertia = IIf( inverse_inertia > 0.0 , 1.0 / inverse_inertia , 0.0 )
			
			'' desired "rest impulse" needed to satisfy the constraint
			A->rest_impulse = - castiffness * direction_error * INV_DT - cadamping * velocity_error 
			
		Next
	
	EndIf
		
End Sub

Sub GameType.ApplyCorrectiveimpulse()
	
	'' Angular springs
	If ( Not AngularConstraints.Empty ) Then 
		
		For A As AngularConstraintType Ptr = AngularConstraints.P_front To AngularConstraints.P_back
			
			'' 
			Dim As LL_ConstraintType Ptr S_a = A->spring_a
			Dim As LL_ConstraintType Ptr S_b = A->spring_b
			
			'' current impulse
			Dim As Single AngularImpulse_a = S_a->Local_Position_a.PerpDot( S_a->particle_a->Impulse ) * S_a->inverse_Inertia * S_a->particle_a->Mass +_
			                                 S_a->Local_Position_b.PerpDot( S_a->particle_b->Impulse ) * S_a->inverse_Inertia * S_a->particle_b->Mass
			
			Dim As Single AngularImpulse_b = S_b->Local_position_a.PerpDot( S_b->particle_a->Impulse ) * S_b->inverse_Inertia * S_b->particle_a->Mass + _
			                                 S_b->Local_position_b.PerpDot( S_b->particle_b->Impulse ) * S_b->inverse_Inertia * S_b->particle_b->Mass
			
			                                 
			'' corrective impulse
			Dim As Single delta_impulse = AngularImpulse_b - AngularImpulse_a
			Dim As Single impulse_error = delta_impulse - A->Rest_Impulse
			Dim As Single corrective_impulse = - impulse_error * A->Reduced_Inertia
			
			''
			Dim As Single new_Angular_Impulse_a = corrective_impulse * S_a->Inverse_Inertia 
			Dim As Single new_Angular_Impulse_b = corrective_impulse * S_b->Inverse_Inertia
			
			'' save for warmstart
			A->Accumulated_Impulse += corrective_impulse
			
			'' apply linear impulse
			
			S_a->particle_a->Impulse -= S_a->Local_Position_a.PerpDot( new_Angular_Impulse_a )
			S_a->particle_b->Impulse -= S_a->Local_Position_b.PerpDot( new_Angular_Impulse_a )
		
			S_b->particle_a->Impulse += S_b->Local_Position_a.PerpDot( new_Angular_Impulse_b )
			S_b->particle_b->Impulse += S_b->Local_Position_b.PerpDot( new_Angular_Impulse_b )
				
		Next
	
	EndIf
	
	'' Linear springs
	If ( Not LL_constraints.Empty ) Then 
		
		For S As LL_constraintType Ptr = LL_constraints.P_front To LL_constraints.P_back
			
			''	delta impulse
			Dim As Vec2 delta_impulse = S->particle_b->impulse - S->particle_a->impulse
			
			'' impulse error
			Dim As Single impulse_error = S->unit.dot( delta_impulse ) - S->rest_impulse
			
			'' corrective impulse
		   Dim As Vec2 corrective_impulse = -impulse_error * S->reduced_mass * S->unit
			
			S->particle_a->impulse -= corrective_impulse * S->particle_a->inverse_mass
			S->particle_b->impulse += corrective_impulse * S->particle_b->inverse_mass
			
			'' save for warmstart
			S->accumulated_impulse += corrective_impulse
			
		Next
	
	EndIf
	
End Sub

Sub GameType.ApplyWarmStart()
	
	'' Warm starting. Use the sum of previously applied impulses
	'' projected onto new normal vector as initial iteration value.
	''	This is roughly equivalent of doubling the number of iterations.
	
	'' Angular springs
	If ( Not AngularConstraints.Empty ) Then 
		
		For A As AngularConstraintType Ptr = AngularConstraints.P_front To AngularConstraints.P_back
			
			Dim As LL_ConstraintType Ptr S_a = A->spring_a
			Dim As LL_ConstraintType Ptr S_b = A->spring_b
			
			Dim As Single warmstart_impulse = cawarmstart * A->Accumulated_Impulse
			
			Dim As Single new_Angular_Impulse_a = warmstart_impulse * A->spring_a->Inverse_Inertia 
			Dim As Single new_Angular_Impulse_b = warmstart_impulse * A->spring_b->Inverse_Inertia
			
			'' apply linear
			A->spring_a->particle_a->Impulse -= S_a->Local_Position_a.PerpDot( new_Angular_Impulse_a )
			A->spring_a->particle_b->Impulse -= S_a->Local_Position_b.PerpDot( new_Angular_Impulse_a )
			
			A->spring_b->particle_a->Impulse += S_b->Local_Position_a.PerpDot( new_Angular_Impulse_b )
			A->spring_b->particle_b->Impulse += S_b->Local_Position_b.PerpDot( new_Angular_Impulse_b )
			
			''
			A->Accumulated_Impulse = 0.0
			
		Next
	
	EndIf
	
	'' Linear springs
	If ( Not LL_constraints.Empty ) Then 
		
		For S As LL_constraintType Ptr = LL_constraints.P_front To LL_constraints.P_back
			
			Dim As Single projected_impulse = S->unit.dot( S->accumulated_impulse )
			
			If ( projected_impulse < 0.0 ) Then
				
				Dim As Vec2 warmstart_impulse = cwarmstart * projected_impulse * S->unit
				
				S->particle_a->impulse -= warmstart_impulse * S->particle_a->inverse_mass 
				S->particle_b->impulse += warmstart_impulse * S->particle_b->inverse_mass
				
			End If
			
			S->accumulated_impulse = Vec2( 0.0, 0.0 )
			
		Next
	
	EndIf
	
End Sub

Sub GameType.ComputeNewState()
	
	''	Compute new state vectors
	
	'' LinearStates
	If ( Not LinearStates.Empty ) Then 
		
		For P As LinearStateType Ptr = LinearStates.p_front To LinearStates.p_back
			
			If ( P->inverse_mass > 0.0 And P <> picked ) Then
				
				P->velocity += P->impulse
				P->position += P->velocity * DT 
				
			End If
			
			P->impulse = Vec2( 0.0, 0.0 )
			
		Next
	
	EndIf
	
	'' Roxels
	If ( Not Roxels.Empty ) Then 
		
		For P As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			If ( P->Linear.inverse_mass > 0.0 And P <> picked ) Then
				
				P->Linear.velocity += P->Linear.impulse
				P->Linear.position += P->Linear.velocity * DT 
				
			End If
			
			P->Linear.impulse = Vec2( 0.0, 0.0 )
			
		Next
	
	EndIf
	
	'' Rigid Bodys
	If ( Not Rigidbodys.empty ) Then
		
		''
		For R As RigidBodyType Ptr = rigidbodys.p_front To rigidbodys.p_back
			
			'' Linear
			R->Linear.velocity += R->Linear.impulse
			
			Dim As Vec2 delta_position = R->Linear.velocity * DT
			
			R->Linear.position += delta_position
			
			'' Angular
			If ( R->Angular.impulse <> 0.0 ) Then
				
				R->Angular.velocity += R->Angular.impulse
				
				R->Angular.velocity_vector = Vec2( Cos( R->Angular.velocity * DT ), _
				                                   Sin( R->Angular.velocity * DT ) )
			
			EndIf
			
			R->Angular.direction += R->Angular.velocity * DT
			R->Angular.direction_Vector = R->Angular.direction_Vector.RotateCCW( R->Angular.velocity_vector )
			
			'' Roxels
			If ( Not R->Roxels.Empty ) Then
				
				For P As RoxelType Ptr = R->Roxels.p_front To R->Roxels.p_back
					
					' Linear
					P->linear.position += delta_position
					
					' Angular
					Dim As vec2 local_position = P->linear.position - R->Linear.position
					
					P->linear.position = R->Linear.position + local_position.RotateCCW( R->Angular.velocity_vector )
					P->linear.velocity = R->Linear.velocity + local_position.PerpDot( R->Angular.velocity ) 
					
					P->linear.impulse = Vec2( 0.0, 0.0 )
					
				Next
				
			EndIf
			
			R->Linear.impulse  = Vec2( 0.0, 0.0 )
			R->Angular.impulse = 0.0
			
			R->Linear_prev  = Vec2( 0.0, 0.0 )
			R->Angular_prev = 0.0
			
		Next
		
	EndIf

End Sub

'' Graphics and interaction
Sub GameType.UpdateScreen()
		
	Cls
	
	''
	Locate  4, 2: Print PuzzleText
	Locate  8, 2: Print Using "(I)terations ###"; iterations
	Locate 10, 2: Print Using "(S)tiffness  #.##"; cStiffness
	Locate 12, 2: Print Using "(D)amping    #.##"; cDamping
	
	If ( warmstart = 0 ) Then 
		
		Locate 14, 2: Print "(W)armstart  OFF"
		
	Else
		
		Locate 14, 2: Print Using "(W)armstart  #.##"; cWarmstart
		
	EndIf
	
	
	''  draw particles background ( black)
	If ( Not Roxels.Empty  ) Then 
		
		For P As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			If ( P->radius > 0.0 ) Then
				
				'' draw impulse ( purple )
				'Dim As vec2 impulse = P->linear.position + ( P->linear.impulse + P->linear.velocity ) * DT
				'Line (P->linear.position.x, P->linear.position.y)-(impulse.x, impulse.y), RGBA( 0, 255, 0 , 128 )
				
				Circle(P->linear.position.x, P->linear.position.y), P->radius + 10, RGB(0, 0, 0) ,,, 1, f
				
			End If
			
		Next
		
	EndIf
	
	
	'' draw rigid bodys
	If ( Not Rigidbodys.empty ) Then
		
		''
		For R As RigidBodyType Ptr = rigidbodys.p_front To rigidbodys.p_back
			
			If ( Not R->Roxels.Empty ) Then
				
				'' roxel background ( black)
				For P As RoxelType Ptr = R->Roxels.p_front To R->Roxels.p_back
						
					Circle( P->linear.position.x, P->linear.position.y ), P->radius + 10, RGB(0, 0, 0),,, 1, f
					
				Next
				
				'' roxel foreground
				For P As RoxelType Ptr = R->Roxels.p_front To R->Roxels.p_back
						
					Circle( P->linear.position.x, P->linear.position.y ), P->radius, P->colour,,, 1, f
					
					'' velocity (yellow)
					'Line( P->linear.position.x, P->linear.position.y )-_
					'    ( P->linear.position.x + P->linear.velocity.x * 10, P->linear.position.y + P->linear.velocity.y * 10), RGB(255,255,0)
					'
					'' impulse ( purple )
					Line( P->linear.position.x, P->linear.position.y )-_
					    ( P->linear.position.x + P->linear.impulse.x * 10, P->linear.position.y + P->linear.impulse.y * 10), RGB(255,0,255)
					
				Next
				
				'' global
				Circle( R->Linear.position.x, R->Linear.position.y ), 2, RGB( 255, 255, 0 ),,, 1, f
			
				Dim As Vec2 r1   = R->Linear.position + R->Angular.direction_Vector          * 16.0
				Dim As Vec2 r1cw  = R->Linear.position + R->Angular.direction_Vector.PerpCW  * 16.0
				Dim As Vec2 r1ccw = R->Linear.position + R->Angular.direction_Vector.PerpCCW * 16.0
				
				Line( R->Linear.position.x, R->Linear.position.y )-( r1.x, r1.y )      , RGB( 255, 255, 0 )
				Line( R->Linear.position.x, R->Linear.position.y )-( r1cw.x, r1cw.y )  , RGB( 0, 255, 0 )
				Line( R->Linear.position.x, R->Linear.position.y )-( r1ccw.x, r1ccw.y ), RGB( 255, 0, 0 )
				
				'' impulse ( purple )
				Line( R->linear.position.x, R->linear.position.y )-_
					 ( R->linear.position.x + R->linear.impulse.x * 10, R->linear.position.y + R->linear.impulse.y * 10), RGB(255,0,255)
				
			EndIf
			
		Next
		
	EndIf
	
	
	''  draw gravitys ( purple )
	If ( Not Gravitys.Empty ) Then 
		
		For G As GravityType Ptr = Gravitys.P_front To Gravitys.P_back
			
			Line(G->particle_a->position.x, G->particle_a->position.y)-_
				 (G->particle_b->position.x, G->particle_b->position.y), RGB(255, 0, 255)
			
		Next
		
	EndIf
	
	
	''  draw springs ( grey )
	If ( Not LL_constraints.Empty ) Then 
		
		For S As LL_constraintType Ptr = LL_constraints.P_front To LL_constraints.P_back Step 1
			
			Line(S->particle_a->position.x, S->particle_a->position.y)-_
				 (S->particle_b->position.x, S->particle_b->position.y), RGB(192, 192, 192)
			
			'Circle(S->Linear.position.x, S->Linear.position.y), 2, RGB( 160, 160, 160 ),,, 1, f
			
		Next
		
	EndIf
	
	
	''	draw particles foreground
	If ( Not Roxels.Empty ) Then 
		
		For P As RoxelType Ptr = Roxels.p_front To Roxels.p_back
			
			If ( P->radius > 0.0 ) Then
				
				Dim As UInteger Col = IIf( P->Linear.inverse_mass = 0.0, RGB(160, 160, 160), RGB(255, 0, 0) )
				
				Circle(P->Linear.position.x, P->Linear.position.y), P->radius, Col,,, 1, f
				
			Else
				
				Dim As UInteger Col = IIf( P->Linear.inverse_mass = 0.0, RGB(160, 160, 160), RGB(160, 160, 160) )
				
				Circle(P->Linear.position.x, P->Linear.position.y), 2, Col,,, 1, f
				
			End If
			
		Next
		
	EndIf
	
	
	'' draw linearstates
	If ( Not LinearStates.Empty ) Then 
		
		For P As LinearStateType Ptr = LinearStates.p_front To LinearStates.p_back
			
			Circle(P->position.x, P->position.y), 2, RGB( 128, 128, 128 ),,, 1, f
			
		Next
		
	EndIf
	
	If ( Nearest <> 0 ) Then Circle(Nearest->position.x, Nearest->position.y), 32, RGB(255, 255, 255),,, 1
	If ( Picked <> 0 ) Then Circle(Picked->position.x, Picked->position.y), 32, RGB(255, 255, 0),,, 1
	
	ScreenCopy()
	
End Sub

Sub GameType.CreateScreen( ByVal Wid As Integer, ByVal Hgt As Integer )
   
	'Dim As Integer top = hgt
	'Dim As Integer lft = 0
	'Dim As Integer btm = 0
	'Dim As Integer rgt = wid
   
   ScreenRes( Wid, Hgt, 24, 2 )
   'Window ( lft, top )-( rgt, btm )
   'Window ( 0, Hgt )-( wid, 0 )
	View ( 0, 0 )-( wid, hgt )
   ScreenSet( 0, 1 )
   
   WindowTitle "Graveyard Orbit - a 2D space physics puzzle game by Michael Schmidt Nissen. Prototype # 1, nov. 2016"
   
   Color RGB( 255, 160, 160 ), RGB( 60, 64, 68 )
   
End Sub

Sub GameType.UpdateInput()
	
	Dim As Integer mouse_x, mouse_y
	Dim As Vec2 DistanceVector
	Dim As Single  Distance
	Dim As Single  MinDIst
	
	''
	position_prev = position
	button_prev   = button
	
	''
	GetMouse mouse_x, mouse_y,, button
	
	position = Vec2( Cast( Single, mouse_x) , Cast( Single, mouse_y ) )
	
	''
	MinDist  = pick_distance
	
	nearest = 0
	
	If ( Not LinearStates.Empty ) Then
		
		If ( picked = 0 ) Then
			
			For P As LinearStateType Ptr = LinearStates.p_front To LinearStates.p_back
				
				DistanceVector = P->Position - Vec2( Cast( Single, mouse_x) , Cast( Single, mouse_y ) )
				Distance = DistanceVector.LengthSquared()
				
				If ( Distance < MinDist ) Then
					
					MinDist = Distance
					nearest = P
					
				EndIf
			
			Next
		
		End If
		
		If ( button = 1 And button_prev = 0 ) Then picked = nearest
		
		If ( button = 0 And picked <> 0 ) Then
			
			picked->velocity.x = ( position.x - position_prev.x ) * INV_DT * 0.5
			picked->velocity.y = ( position.y - position_prev.y ) * INV_DT * 0.5
			
		EndIf
		
		If ( button = 0 ) Then picked = 0
	
	EndIf
	
	''
	If ( picked <> 0 ) Then
	
		picked->velocity = Vec2( 0.0, 0.0 )
	
		picked->position.x += ( position.x - position_prev.x )
		picked->position.y += ( position.y - position_prev.y )
		
	End If
	
	If ( ScreenEvent( @e ) ) Then
		
		Select Case e.type
		
		Case fb.EVENT_KEY_PRESS
			
			If ( e.scancode = fb.SC_F1 ) Then Puzzle1()
			If ( e.scancode = fb.SC_F2 ) Then Puzzle2()
			If ( e.scancode = fb.SC_F3 ) Then Puzzle3()
			If ( e.scancode = fb.SC_F4 ) Then Puzzle4()
			If ( e.scancode = fb.SC_F5 ) Then Puzzle5()
			If ( e.scancode = fb.SC_F6 ) Then Puzzle6()
			If ( e.scancode = fb.SC_F7 ) Then Puzzle7()
			
			'' Iterations
			If ( MultiKey( fb.SC_I ) And ( e.scancode = fb.SC_UP   ) ) Then iterations += 1
			If ( MultiKey( fb.SC_I ) And ( e.scancode = fb.SC_DOWN ) ) Then iterations -= 1
			
			If ( e.scancode = fb.SC_SPACE ) Then warmstart Xor= 1
			
			If ( e.scancode = fb.SC_ESCAPE ) Then End
			
		Case fb.EVENT_KEY_RELEASE
		
		Case fb.EVENT_KEY_REPEAT
			
			'' 
			If ( MultiKey( fb.SC_S ) And ( e.scancode = fb.SC_UP   ) ) Then cStiffness += 0.002
			If ( MultiKey( fb.SC_S ) And ( e.scancode = fb.SC_DOWN ) ) Then cStiffness -= 0.002
			
			'' 
			If ( MultiKey( fb.SC_D ) And ( e.scancode = fb.SC_UP   ) ) Then cDamping += 0.002
			If ( MultiKey( fb.SC_D ) And ( e.scancode = fb.SC_DOWN ) ) Then cDamping -= 0.002
			
			'' 
			If ( MultiKey( fb.SC_W ) And ( e.scancode = fb.SC_UP   ) ) Then cWarmstart += 0.002
			If ( MultiKey( fb.SC_W ) And ( e.scancode = fb.SC_DOWN ) ) Then cWarmstart -= 0.002
			
			''' 
			'If ( MultiKey( fb.SC_S ) And ( e.scancode = fb.SC_UP   ) ) Then caStiffness += 0.002
			'If ( MultiKey( fb.SC_S ) And ( e.scancode = fb.SC_DOWN ) ) Then caStiffness -= 0.002
			'
			''' 
			'If ( MultiKey( fb.SC_D ) And ( e.scancode = fb.SC_UP   ) ) Then caDamping += 0.002
			'If ( MultiKey( fb.SC_D ) And ( e.scancode = fb.SC_DOWN ) ) Then caDamping -= 0.002
			'
			''' 
			'If ( MultiKey( fb.SC_W ) And ( e.scancode = fb.SC_UP   ) ) Then caWarmstart += 0.002
			'If ( MultiKey( fb.SC_W ) And ( e.scancode = fb.SC_DOWN ) ) Then caWarmstart -= 0.002
			
		Case fb.EVENT_MOUSE_MOVE
		
		Case fb.EVENT_MOUSE_BUTTON_PRESS
			
			If (e.button = fb.BUTTON_LEFT) Then
			
			End If
			
			If (e.button = fb.BUTTON_RIGHT) Then
			
			End If
			
		Case fb.EVENT_MOUSE_BUTTON_RELEASE
			
			If (e.button = fb.BUTTON_LEFT) Then
			
			End If
			
			If (e.button = fb.BUTTON_RIGHT) Then
			
			End If
			
		Case fb.EVENT_MOUSE_WHEEL
		
		Case fb.EVENT_WINDOW_CLOSE
			
			End
			
		End Select
		
	End If
	
	If MultiKey( fb.SC_1 ) Then iterations = 1
	If MultiKey( fb.SC_2 ) Then iterations = 2
	If MultiKey( fb.SC_3 ) Then iterations = 4
	If MultiKey( fb.SC_4 ) Then iterations = 8
	If MultiKey( fb.SC_5 ) Then iterations = 16
	If MultiKey( fb.SC_6 ) Then iterations = 32
	If MultiKey( fb.SC_7 ) Then iterations = 64
	If MultiKey( fb.SC_8 ) Then iterations = 128
	If MultiKey( fb.SC_9 ) Then iterations = 256
	
	If iterations < 1 Then iterations = 1
	
	If cStiffness < 0.0 Then cStiffness = 0.0
	If cStiffness > 1.0 Then cStiffness = 1.0
	
	If cDamping < 0.0 Then cDamping = 0.0
	If cDamping > 1.0 Then cDamping = 1.0
	
	If cWarmstart < 0.0 Then cWarmstart = 0.0
	If cWarmstart > 1.0 Then cWarmstart = 1.0
	
	If caStiffness < 0.0 Then caStiffness = 0.0
	If caStiffness > 1.0 Then caStiffness = 1.0
	
	If caDamping < 0.0 Then caDamping = 0.0
	If caDamping > 1.0 Then caDamping = 1.0
	
	If caWarmstart < 0.0 Then caWarmstart = 0.0
	If caWarmstart > 1.0 Then caWarmstart = 1.0
	
End Sub

Sub GameType.ClearWarmstart()
	
	If ( Not LL_constraints.Empty ) Then 
		
		For S As LL_constraintType Ptr = LL_constraints.P_front To LL_constraints.P_back
		
			S->accumulated_impulse = Vec2( 0.0, 0.0 )
			
		Next
	
	EndIf
	
	If ( Not AngularConstraints.Empty ) Then 
		
		For A As AngularConstraintType Ptr = AngularConstraints.P_front To AngularConstraints.P_back
	
			A->accumulated_impulse = 0.0
			
		Next
		
	EndIf
	
End Sub
