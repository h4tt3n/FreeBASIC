''*******************************************************************************
''
''  Smoothed Particle Hydrodynamics (SPH) fluid Simulation
''
''  Version 0.3.8, february 2014
''  Mike "h4tt3n", micha3l_niss3n@yahoo.dk
''
''  Description:
''
''  very fast, square root free SPH simulation.
''
''  Controls:
''
''  press left mouse button to stir fluid
''  press right mouse button to
''  roll mouse wheel up / down to create current eddies
''  press escape key to exit
''
''  Todo-list:
''
''  rewrite with OOP
''	 add particle emitter
''  add obstacles
''  different types of fluids (fluid type)
''	 array of cellPair like particlePair?
''
''
''*******************************************************************************


''   Includes
#Include Once "fbgfx.bi"
#Include Once "vec2.bi"


''   global constants
Const As Single  DT                     = 1.0 / 100.0                                  ''
Const As Single  DT_SQRD                = DT * DT                                      ''
Const As Single  INV_DT                 = 1.0 / DT                                     ''
Const As Single  INV_DT_SQRD            = 1.0 / DT_SQRD                                ''

Const As Single  G                      = 1600.0                                        ''
Const As Single  MIN_DISTANCE           = 1.0                                          ''   minimum distance
Const As Single  PI                     = 4*Atn(1)                                     ''   PI

Const As Single  PARTICLE_RADIUS        = 15.0                                         '' particle radius
Const As Single  PARTICLE_DIAMETER      = PARTICLE_RADIUS * 2.0                        ''
Const As Single  PARTICLE_DIAMETER_SQRD = PARTICLE_DIAMETER * PARTICLE_DIAMETER        ''

Const As Single  LOCAL_PRESSURE_COEFF   = 50.0	'50
Const As Single  GLOBAL_PRESSURE_COEFF  = 4.0	'4
Const As Single  DAMPING_COEFF          = 50.0	'50

Const As Single  REST_DISTANCE          = 25.0                                         ''
Const As Single  REST_DISTANCE_SQRD     = REST_DISTANCE * REST_DISTANCE                ''

Const As Single  REST_PRESSURE          = 10000.0                                      ''   rest pressure
Const As Single  COLOR_PRESSURE_SCALE   = 255 / REST_PRESSURE                          ''

Const As Integer BLOCK_WID              = 30                                          ''
Const As Integer BLOCK_HGT              = 100                                           ''
Const As Integer NUM_PARTICLES          = BLOCK_WID * BLOCK_HGT                        ''   number of particles
Const As Integer MAX_PAIRS_LOCAL        = 64                                           ''   max number of neighbors per particles
Const As Integer MAX_PAIRS_GLOBAL       = NUM_PARTICLES * MAX_PAIRS_LOCAL * 0.5        ''   global max number of neighbors

Const As Integer SCREEN_HGT             = 800                                          ''   screen height
Const As Integer SCREEN_WID             = 1600                                          ''   screen wiDTh
 
Const As Integer CELL_DIAMETER          = Cast ( Integer, PARTICLE_DIAMETER )          ''   cell diameter
Const As Integer MAX_CELL_PARTICLES     = 64                                           ''   max number of particles held by one cell
Const As Integer NUM_CELLS_X            = Cast ( Integer, SCREEN_WID / CELL_DIAMETER ) ''   number of cells per row / on x axis
Const As Integer NUM_CELLS_Y            = Cast ( Integer, SCREEN_HGT / CELL_DIAMETER ) ''   number of cells per column / on y axis
Const As Integer NUM_CELLS              = (NUM_CELLS_X) * (NUM_CELLS_Y)                    ''
Const As Integer NUM_CELL_PAIRS         = NUM_CELLS * 5                                ''
Const As Integer CELL_WID               = Cast ( Integer, SCREEN_WID / NUM_CELLS_X )   ''
Const As Integer CELL_HGT               = Cast ( Integer, SCREEN_HGT / NUM_CELLS_Y )   ''
Const As Single  INV_CELL_WID           = 1.0 / CELL_WID
Const As Single  INV_CELL_HGT           = 1.0 / CELL_HGT

Const As Integer BORDER                 = 0                                           ''
Const As Integer RADIUS_PLUS_BORDER     = PARTICLE_RADIUS + BORDER                     ''
Const As Single  BORDER_STIFFNES        = 0.5                                          ''
Const As Single  BORDER_DAMPING         = 0.5                                          ''

Const As Single  INTERACTION_RADIUS     = 48                                           ''
Const As Single  int_radius_sqrd        = INTERACTION_RADIUS ^ 2                       ''



''
Type ParticleType

	Public:

	As Vec2f   force_
	As Vec2f   position_
	As Vec2f   prevPosition_
	As Vec2f   velocity_

	As Single  pressure_

End Type


''
Type ParticlePairType

	Public:

	Declare Sub computePressure()


	As Single           pressure_
	As Single           distanceSquared_

	As Vec2f            nOverDistance_

	As ParticleType Ptr particleA_
	As ParticleType Ptr particleB_

End Type


''
Type FluidType

	Public:

	Declare Sub resetParticles()
	Declare Sub computePressure()

	As Integer          numParticles_
	As Integer          numParticlePairs_

	As Single           localDampingCoefficient_
	As Single           localPressureCoefficient_
	As Single           globalPressureCoefficient_

	As Single           particleRadius_
	As Single           particleRadiusSquared_
	As Single           particleDiameter_

	As Single           restDistance_
	As Single           restDistanceSqared_
	As Single           restPressure_

	As ParticleType     particles     ( 1 To NUM_PARTICLES )
	As ParticlePairType particlePairs ( 1 To MAX_PAIRS_GLOBAL )

End Type


''
Type CellType

	Public:

	As Integer          numParticles_
	As Integer			  maxParticlesPerCell_

	As ParticleType Ptr particles     ( 1 To MAX_CELL_PARTICLES )

End Type

Type CellPairType
	
	As CellType Ptr cellA_
	As CellType Ptr cellB_
	
End Type


''
Type GridType

	Public:

	Declare Sub computeBroadPhase()
	Declare Sub computeCellNeighbors()
	Declare Sub computeNarrowPhase()
	
	Declare Sub resetCells()

	As Integer  cellHeight_
	As Integer  cellWidth_
	As Single   invCellHeight_
	As Single   invCellWidth_
	As Integer  numCells_
	As Integer  numCellsX_
	As Integer  numCellsY_
	As Integer  numParticlesPerCell_


	As CellType cells ( 0 To NUM_CELLS_X, 0 To NUM_CELLS_Y )

End Type


''
Type ScreenType

	Public:

	Declare Sub CreateScreen(w As Integer, h As Integer, r As Integer, g As Integer, _
	b As Integer, a As Integer, d As Integer, s As Integer, m As Integer)

	As Integer wid
	As Integer Hgt
	As Integer Bpp

End Type


''
Type MouseType

	Public:

	Declare Sub Update()

	As vec2i   position_
	As vec2i   prevPosition_

	As Vec2f   velocity_

	As Integer button_
	As Integer prevButton_
	As Integer wheel_
	As Integer prevWheel_

End Type


''
Type SimulationType

	Public:
	
	Declare Sub computeData()
	Declare Sub computeForces()
	Declare Sub runSimulation()
	Declare Sub drawToScreen()
	Declare Sub integrateSymplecticEuler()
	Declare Sub integrateVerlet()

	As UByte dummy_

End Type



Declare Sub run_simulation()
Declare Sub initiate_simulation()
Declare Sub broad_phase_collision()
Declare Sub narrow_phase_collision()
Declare Sub reset_cells()
Declare Sub reset_particles()
Declare Sub calculate_internal_force()
Declare Sub screen_border_force()
Declare Sub Integrate()
Declare Sub draw_particles()
Declare Sub check_if_pair(ByVal A As ParticleType Ptr, ByVal B As ParticleType Ptr)



Dim Shared As ScreenType Scr
Dim Shared As MouseType Mouse

Dim Shared As CellType         cell          ( 0 To NUM_CELLS_X, 0 To NUM_CELLS_Y )
Dim Shared As CellPairType     cellPairs     ( 1 To NUM_CELL_PAIRS   )
Dim Shared As ParticleType     particles     ( 1 To NUM_PARTICLES    )
Dim Shared As ParticlePairType particlePairs ( 1 To MAX_PAIRS_GLOBAL )

Dim Shared As Integer numCellPairs
Dim Shared As Integer numParticlePairs

Dim Shared As ParticleType Ptr Lo = @particles (1)
Dim Shared As ParticleType Ptr Hi = @particles (NUM_PARTICLES)



''   run simulation
run_simulation()



Sub run_simulation()

	initiate_simulation()
	Scr.CreateScreen(SCREEN_WID, SCREEN_HGT, 8, 8, 8, 8, 0, 0, 0)

	''  main program loop
	Do

		reset_particles()
		reset_cells()

		broad_phase_collision()
		narrow_phase_collision()

		calculate_internal_force()
		screen_border_force()
		mouse.Update()

		Integrate()

		draw_particles()

	Loop Until MultiKey(1)

	End

End Sub

Sub initiate_simulation()

	''  dereference cell neighbor pointers
	
	numCellPairs = 0
	
	For x As Integer = 0 To NUM_CELLS_X

		For y As Integer = 0 To NUM_CELLS_Y

			With cell(x, y)

				''  cell(x, y) - cell(x + 1, y)
				If x < NUM_CELLS_X Then
	
					numCellPairs += 1
					cellPairs( numCellPairs ).cellA_ = @cell(x, y)
					cellPairs( numCellPairs ).cellB_ = @cell(x + 1, y)
					
				EndIf

				''  cell(x, y) - cell(x, y + 1)
				If y < NUM_CELLS_Y Then

					numCellPairs += 1
					cellPairs( numCellPairs ).cellA_ = @cell(x, y)
					cellPairs( numCellPairs ).cellB_ = @cell(x, y + 1)					
					
				EndIf
				'
				''  cell(x, y) - cell(x + 1, y + 1)
				If x < NUM_CELLS_X And y < NUM_CELLS_Y Then

					numCellPairs += 1
					cellPairs( numCellPairs ).cellA_ = @cell(x, y)
					cellPairs( numCellPairs ).cellB_ = @cell(x + 1, y + 1)					
					
				EndIf

				''  cell(x, y) - cell(x - 1, y + 1)
				If x > 0 And y < NUM_CELLS_Y Then

					numCellPairs += 1
					cellPairs( numCellPairs ).cellA_ = @cell(x, y)
					cellPairs( numCellPairs ).cellB_ = @cell(x - 1, y + 1)		
					
				EndIf

			End With

		Next

	Next


	Randomize Timer

	Dim As Integer n = 0

	''   place particles
	For x As Integer = 1 To BLOCK_WID

		For y As Integer = 1 To BLOCK_HGT

			n += 1

			With particles(n)

				.position_.x = BORDER + PARTICLE_RADIUS + 10 * 0.5 + x * PARTICLE_RADIUS * 0.5
				.position_.y = SCREEN_HGT - BORDER - PARTICLE_RADIUS - 10 * 0.5 - y * PARTICLE_RADIUS * 0.5

				'.velocity_.x += (Rnd-Rnd) * 10.0
				'.velocity_.y += (Rnd-Rnd) * 10.0

				.position_.x += ( Rnd - Rnd ) * 0.1
				.position_.y += ( Rnd - Rnd ) * 0.1

				.prevPosition_.x = .position_.x
				.prevPosition_.y = .position_.y

			End With

		Next

	Next

End Sub

Sub broad_phase_collision()

	''
	For P As ParticleType Ptr = Lo To Hi

		Dim As Integer cell_col = P->position_.x * INV_CELL_WID

		If ( cell_col < 0 ) Or ( cell_col > NUM_CELLS_X ) Then Continue For

		Dim As Integer cell_row = P->position_.y * INV_CELL_HGT

		If ( cell_row < 0 ) Or ( cell_row > NUM_CELLS_Y ) Then Continue For

		Dim As CellType Ptr C = @cell( cell_col, cell_row )

		If C->numParticles_ >= MAX_CELL_PARTICLES Then Continue For

		C->numParticles_ += 1

		C->Particles( C->numParticles_ ) = P

	Next

End Sub

Sub narrow_phase_collision()

	''   reset number of neighbors
	numParticlePairs = 0
	
	For x As Integer = 0 To NUM_CELLS_X

		For y As Integer = 0 To NUM_CELLS_Y

			Dim As CellType Ptr C = @cell(x, y)

			If C->numParticles_ = 0 Then Continue For

			'' cell(x, y) - self
			For i As Integer = 1 To C->numParticles_ - 1

				For j As Integer = i + 1 To C->numParticles_

					check_if_pair(C->Particles(i), C->Particles(j))

				Next

			Next
			
		Next
		
	Next
	
	'For CP As CellPairType Ptr = @cellPairs( 1 ) To @cellPairs( NUM_CELL_PAIRS )	
	For k As Integer = 1 To numCellPairs
		
		Dim As CellPairType Ptr CP = @cellPairs( k )
		
		If CP->cellA_->numParticles_ = 0 Then Continue For
		If CP->cellB_->numParticles_ = 0 Then Continue For
		
		For i As Integer = 1 To CP->cellA_->numParticles_
			
			For j As Integer = 1 To CP->cellB_->numParticles_
			
				check_if_pair( CP->cellA_->Particles( i ), CP->cellB_->Particles( j ) )
			
			Next
			
		Next
		
		
	Next

End Sub

Sub reset_cells()

	For x As Integer = 0 To NUM_CELLS_X

		For y As Integer = 0 To NUM_CELLS_Y

			cell(x, y).numParticles_ = 0

		Next

	Next

End Sub

Sub reset_particles()

	For P As ParticleType Ptr = Lo To Hi

		'P->numPairs_ = 0
		P->pressure_ = 0.0
		P->force_    = Vec2f(0.0f, G)

	Next

End Sub

Sub calculate_internal_force()

	For N As ParticlePairType Ptr = @particlePairs(1) To @particlePairs(numParticlePairs)

		''   velocity vector projected onto distance vector
		Dim As Single velocity = ( N->particleB_->velocity_ - N->particleA_->velocity_ ).dot( N->nOverDistance_ )

		If N->distanceSquared_ > MIN_DISTANCE Then

			''   force vector
			Dim As Vec2f force = N->nOverDistance_ * ( _
			N->pressure_                                                               * LOCAL_PRESSURE_COEFF  -  _  '' local pressure
			( REST_PRESSURE - ( N->particleA_->pressure_ + N->particleB_->pressure_) ) * GLOBAL_PRESSURE_COEFF -  _  '' global pressure
			velocity                                                                   * DAMPING_COEFF            )  '' damping

			''   apply opposite equal forces
			N->particleA_->force_ -= force
			N->particleB_->force_ += force

		End If

	Next

End Sub

Sub screen_border_force()

	For P As ParticleType Ptr = Lo To Hi

		If P->position_.x < RADIUS_PLUS_BORDER Then

			P->force_.x -= ( P->position_.x - RADIUS_PLUS_BORDER ) * INV_DT_SQRD * BORDER_STIFFNES + _
			P->velocity_.x                        * INV_DT      * BORDER_DAMPING

		EndIf

		If P->position_.x > ( SCREEN_WID - RADIUS_PLUS_BORDER ) Then

			P->force_.x -= ( P->position_.x - ( SCREEN_WID - RADIUS_PLUS_BORDER ) ) * INV_DT_SQRD * BORDER_STIFFNES + _
			P->velocity_.x                                         * INV_DT      * BORDER_DAMPING

		EndIf

		If P->position_.y < RADIUS_PLUS_BORDER Then

			P->force_.y -= ( P->position_.y - RADIUS_PLUS_BORDER ) * INV_DT_SQRD * BORDER_STIFFNES + _
			P->velocity_.y                        * INV_DT      * BORDER_DAMPING

		EndIf

		If P->position_.y > ( SCREEN_HGT - RADIUS_PLUS_BORDER ) Then

			P->force_.y -= ( P->position_.y - ( SCREEN_HGT - RADIUS_PLUS_BORDER ) ) * INV_DT_SQRD * BORDER_STIFFNES + _
			P->velocity_.y                                         * INV_DT      * BORDER_DAMPING

		EndIf

	Next

End Sub

Sub Integrate()

	''   symplectic Euler
	For P As ParticleType Ptr = Lo To Hi
		
		P->velocity_    += P->force_    * DT
		P->prevPosition_ = P->position_
		P->position_    += P->velocity_ * DT
		
	Next

	''   verlet
	'For P As ParticleType Ptr = Lo To Hi
	
	'  Dim As Vec2f temp = P->position_
	'  P->position_ += P->position_ - P->prevPosition_ + P->force_ * DT_SQRD
	'  P->prevPosition_ = temp
	'  P->velocity_ = (P->position_ - P->prevPosition_) * INV_DT
	
	'Next

End Sub

Sub draw_particles()

	ScreenLock

	Cls
	'Line(0, 0)-(SCREEN_WID, SCREEN_HGT), RGBA(0, 0, 0, 128), bf

	''
	'For N As ParticlePairType Ptr = @particlePairs(1) To @particlePairs(numParticlePairs)

	'	Line(N->particleA_->position_.x, N->particleA_->position_.y)-(N->particleB_->position_.x,N->particleB_->position_.y), RGBA(255, 255, 255, 64)

	'Next

	For P As ParticleType Ptr = Lo To Hi
	
		Dim As Single col_r = P->pressure_ * COLOR_PRESSURE_SCALE
		Dim As Single col_g
		Dim As Single col_b
	
		If col_r > 255 Then
	
			col_g = col_r - 255
			col_r = 255
	
		EndIf
	
		col_b = 255 - col_r
	
		If col_g > 255 Then col_g = 255
		If col_b > 255 Then col_b = 255
	
		'Pset( P->position_.x, P->position_.y ), RGB(col_r, col_g, col_b)
		Line( P->position_.x-1, P->position_.y-1 )-( P->position_.x+1, P->position_.y+1 ), RGB(col_r, col_g, col_b), bf
		'Line(P->prevPosition_.x, P->prevPosition_.y)-(P->position_.x, P->position_.y), RGB(col_r, col_g, col_b)
		'Circle(P->position_.x, P->position_.y), 3, RGB(col_r, col_g, col_b),,, 1, f
	
	Next

	'Dim As Integer cell_row = mouse.position_.y * INV_CELL_HGT
	'Dim As Integer cell_col = mouse.position_.x * INV_CELL_WID

	'Locate 2, 2: Print NUM_CELLS_X; NUM_CELLS_Y
	'Locate 4, 2: Print cell_col; cell_row
	Locate 2, 2: Print "particle pairs:"; numParticlePairs ; "of" ; MAX_PAIRS_GLOBAL
	Locate 4, 2: Print "cell pairs:"; numCellPairs ; "of" ; NUM_CELL_PAIRS

	ScreenUnLock

End Sub


Sub check_if_pair(ByVal A As ParticleType Ptr, ByVal B As ParticleType Ptr)

	If numParticlePairs >= MAX_PAIRS_GLOBAL Then Exit Sub

	Dim As Vec2f distance_vector = B->position_ - A->position_

	If Abs( distance_vector.x ) > PARTICLE_DIAMETER Then Exit Sub
	If Abs( distance_vector.y ) > PARTICLE_DIAMETER Then Exit Sub

	Dim As Single distance_squared = distance_vector.magnitudesquared()

	If ( distance_squared > PARTICLE_DIAMETER_SQRD ) Then Exit Sub

	'' okay, we are interacting - create neighbor
	numParticlePairs += 1

	Dim As ParticlePairType Ptr N = @particlePairs( numParticlePairs )

	N->particleA_ = A
	N->particleB_ = B

	N->distanceSquared_ = distance_squared

	N->pressure_ = REST_DISTANCE_SQRD - distance_squared

	If distance_squared > MIN_DISTANCE Then

		N->nOverDistance_ = distance_vector / distance_squared

	Else

		N->nOverDistance_ = Vec2f(0,0)

	End If

	''  add pressure to particles
	A->pressure_ += N->pressure_
	B->pressure_ += N->pressure_

End Sub

Sub ScreenType.CreateScreen(w As Integer, h As Integer, r As Integer, g As Integer, _
	b As Integer, a As Integer, d As Integer, s As Integer, m As Integer)

	ScreenRes w, h, 24,, fb.GFX_ALPHA_PRIMITIVES

	'Color RGB(0, 0, 0), RGB(255, 255, 255)
	Color RGB(255, 255, 255), RGB(0, 0, 0)

End Sub

Sub MouseType.Update

	''
	prevPosition_ = position_
	prevButton_   = button_
	prevWheel_    = wheel_

	''
	GetMouse position_.x, position_.y, wheel_, button_

	''
	'velocity_ = ( position_ - prevPosition_ ) * INV_DT

	velocity_.x = ( position_.x - prevPosition_.x ) * INV_DT
	velocity_.y = ( position_.y - prevPosition_.y ) * INV_DT

	''
	If (button_ = 1) Then

		For i As Integer = 1 To NUM_PARTICLES

			Dim As Vec2f dst = particles(i).position_ - position_

			If Abs(dst.x) > INTERACTION_RADIUS Then Continue For
			If Abs(dst.y) > INTERACTION_RADIUS Then Continue For

			Dim As Single dst_Sqrd = dst.magnitudeSquared()

			If dst_Sqrd > int_radius_sqrd Then Continue For

			If velocity_.x <> 0.0 Then particles(i).force_.x -= ( (particles(i).velocity_.x - velocity_.x) * INV_DT ) * ( 1 - dst_Sqrd / int_radius_sqrd ) * 0.2
			If velocity_.y <> 0.0 Then particles(i).force_.y -= ( (particles(i).velocity_.y - velocity_.y) * INV_DT ) * ( 1 - dst_Sqrd / int_radius_sqrd ) * 0.2


		Next

	End If

	''
	If (button_ = 2) Then

		For i As Integer = 1 To NUM_PARTICLES

			Dim As Vec2f dst = particles(i).position_ - position_

			Dim As Single dst_Sqrd = dst.magnitudeSquared()

			particles(i).force_ += dst / dst_Sqrd * 300000.0

		Next

	End If

	''
	If wheel_ <> prevWheel_ Then

		For i As Integer = 1 To NUM_PARTICLES

			Dim As Vec2f dst = particles(i).position_ - position_

			If Abs(dst.x) < MIN_DISTANCE Then Continue For
			If Abs(dst.y) < MIN_DISTANCE Then Continue For

			Dim As Single dst_Sqrd = dst.magnitudeSquared()

			Dim As Single magnitude = Sgn( wheel_ - prevWheel_ )

			particles(i).force_ += ( dst / dst_Sqrd ).normal() * 300000 * magnitude

		Next

	EndIf

End Sub
