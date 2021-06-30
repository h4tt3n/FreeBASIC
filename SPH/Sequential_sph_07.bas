''*******************************************************************************
''
''  Sequential Smoothed Particle Hydrodynamics (SPH) fluid World
''
''  Version 0.7.0, october 2016
''	 Written in FreeBASIC v. 1.05 & FbEdit 1.0.7.6c
''  Michael "h4tt3n" Schmidt Nissen
''  michaelschmidtnissen@gmail.com
''
''  Description:
''
''  Very fast, stable, and square-root free SPH World.
''
''  Controls:
''
''  -Press left mouse button to stir fluid
''  -Press right mouse button to repel fluid
''  -Roll mouse wheel up / down to create current eddies
''	 -Press F1, F2, F3 for different visualizations
''  -Press escape key to exit
''
''  Todo-list:
''
''	 -Clean up code!
''  -Finish constructors and assignment operators
''  -Randomizeable arrays of ptrs to particles, pairs, & cells
''
''
''*******************************************************************************


''   Includes
#Include Once "fbgfx.bi"
#Include Once "../Math/Vector2.bi"


''   global constants
Const As Single  DT                     = 1.0 / 60.0                                  ''
Const As Single  INV_DT                 = 1.0 / DT                                     ''

Const As Single  MIN_DISTANCE           = 2.0                                       '' minimum distance
Const As Single  PI                     = 4.0 * Atn( 1.0 )                             ''	pi
Const As Single  G                      = 10.0                                         ''

Const As Integer  ITERATIONS            = 4                                      ''

Const As Single  PARTICLE_RADIUS        = 15.0                                          '' particle radius
Const As Single  PARTICLE_DIAMETER      = PARTICLE_RADIUS * 2.0                        ''

Const As Single  LOCAL_PRESSURE_COEFF   = 0.0004	  '64                                  ''
Const As Single  GLOBAL_PRESSURE_COEFF  = 0.1	  '4                                   ''
Const As Single  LOCAL_DAMPING_COEFF    = 1.0	  '64                                  ''

Const As Single  REST_DISTANCE          = 32.0    '' 30                                  ''

Const As Single  REST_DENSITY           = 10000.0 '12000                               '' rest pressure
Const As Single  COLOR_PRESSURE_SCALE   = 255 / ( REST_DENSITY * 0.6 )                          ''

Const As Integer BLOCK_WID              = 100                                           ''
Const As Integer BLOCK_HGT              = 20                                          ''
Const As Integer MAX_PARTICLES          = BLOCK_WID * BLOCK_HGT                        '' number of particles
Const As Integer MAX_PAIRS_LOCAL        = 32                                           '' max number of neighbors per particles
Const As Integer MAX_PAIRS_GLOBAL       = MAX_PARTICLES * MAX_PAIRS_LOCAL              '' global max number of neighbors

Const As Integer SCREEN_HGT             = 800                                          '' screen height
Const As Integer SCREEN_WID             = 1600                                         '' screen wiDTh
 
Const As Integer CELL_DIAMETER          = Cast ( Integer, 1.0 * PARTICLE_DIAMETER )    '' cell diameter
Const As Integer MAX_PARTICLES_PER_CELL = 32                                          '' max number of particles held by one cell
Const As Integer NUM_CELLS_X            = Cast ( Integer, SCREEN_WID / CELL_DIAMETER ) '' number of cells per row / on x axis
Const As Integer NUM_CELLS_Y            = Cast ( Integer, SCREEN_HGT / CELL_DIAMETER ) '' number of cells per column / on y axis
Const As Integer NUM_CELLS              = NUM_CELLS_X * NUM_CELLS_Y                ''
Const As Integer NUM_CELL_PAIRS         = NUM_CELLS * 6' - NUM_CELLS_X                            ''

Const As Integer BORDER                 = 32                                            ''
Const As Integer RADIUS_PLUS_BORDER     = PARTICLE_RADIUS + BORDER                     ''
Const As Single  BORDER_STIFFNES        = 0.5                                         ''
Const As Single  BORDER_DAMPING         = 0.0                                        ''

Const As Single  INTERACT_RADIUS        = 64.0                                         ''
Const As Single  INTERACT_RADIUS_SQD    = INTERACT_RADIUS ^ 2.0                          ''


''
Type ParticleType

	Public:
	
	Declare Constructor()
	
	As Integer num_pairs_
	
	As Vec2 impulse_
	As Vec2 position_
	As Vec2 velocity_

	As Single density_

End Type


''
Type ParticlePairType

	Public:
	
	Declare Constructor()
	
	As Vec2 nOverDistance_
	
	As Single density_
	As Single density2_
	As Single rest_impulse_
	
	As ParticleType Ptr particleA_
	As ParticleType Ptr particleB_
	
End Type


''
Type FluidType

	Public:
	
	Declare Constructor()
	
	Declare Constructor( ByVal globalpressure As Single, _
		                  ByVal localpressure  As Single, _
		                  ByVal localdamping   As Single, _
		                  ByVal particleradius As Single, _
		                  ByVal restdistance   As Single, _
		                  ByVal restdensity    As Single )
	
	Declare Sub ComputeReusableData()
	Declare Sub ComputeCorrectiveImpulse()
	Declare Sub resetParticles()
	
	As Single  globalPressureCoefficient_
	As Single  localDampingCoefficient_
	As Single  localPressureCoefficient_
	As Integer numParticles_
	As Integer numParticlePairs_
	As Single  particleDiameter_
	As Single  particleDiameterSquared_
	As Single  particleRadius_
	As Single  restDistance_
	As Single  restDistanceSquared_
	As Single  restDensity_
	
	As ParticleType Ptr firstParticle_
	As ParticleType Ptr lastParticle_

	As ParticleType     particles     ( 1 To MAX_PARTICLES    )
	As ParticlePairType particlePairs ( 1 To MAX_PAIRS_GLOBAL )
	
End Type


''
Type CellType
	
	Public:
	
	Declare Constructor()
	
	As Integer numParticles_
	
	As ParticleType Ptr particles( 1 To MAX_PARTICLES_PER_CELL )
	
End Type


''
Type CellPairType
	
	Public:
	
	Declare Constructor()
	
	As CellType Ptr cellA_
	As CellType Ptr cellB_
	
End Type


''
Type GridType

	Public:
	
	Declare Constructor()
	
	Declare Constructor( ByVal celldiameter As Single,  _
	 	                  ByVal screenwidth  As Integer, _
	 	                  ByVal screenheight As Integer )
	
	Declare Sub computeCellPairs()
	Declare Sub resetCells()
	
	As Integer  cellHeight_
	As Integer  cellWidth_
	As Single   invCellHeight_
	As Single   invCellWidth_
	As Integer  numCellPairs_
	As Integer  numCells_
	As Integer  numCellsX_
	As Integer  numCellsY_
	As Integer  numParticlesPerCell_
	
	As CellType     cells     ( 0 To NUM_CELLS_X, 0 To NUM_CELLS_Y )
	As CellPairType cellPairs ( 0 To NUM_CELL_PAIRS )
	
End Type


''
Type ScreenType

	Public:
	
	Declare Constructor()
	
	Declare Sub CreateScreen( ByVal w As Integer,   _
		                       ByVal h As Integer,   _
		                       ByVal r As Integer,   _
		                       ByVal g As Integer,   _
		                       ByVal b As Integer,   _
		                       ByVal a As Integer,   _
		                       ByVal d As Integer,   _
		                       ByVal s As Integer,   _
		                       ByVal m As Integer )
	
	As Integer width_    '' not
	As Integer height_   '' in
	As Integer bitDepth_ '' use
	
End Type


''
Type MouseType

	Public:
	
	Declare Constructor()
	
	As Vec2 position_
	As Vec2 prevPosition_

	As Vec2 velocity_

	As Integer button_
	As Integer prevButton_
	As Integer wheel_
	As Integer prevWheel_
	
End Type


''
Type WorldType

	Public:
	
	Declare Constructor()
	
	Declare Sub computeBorderImpulses()
	Declare Sub RunWorld()
	Declare Sub drawFluid()
	Declare Sub ComputeNewState( ByVal F As FluidType Ptr )
	Declare Sub initiateWorld()
	
	Declare Sub computeBroadPhase( ByVal F As FluidType Ptr, ByVal G As GridType Ptr )
	
	Declare Sub checkPair( ByVal A As ParticleType Ptr, ByVal B As ParticleType Ptr )
	Declare Sub ComputeParticlePairs( ByVal F As FluidType Ptr, ByVal G As GridType Ptr )
	
	Declare Sub UpdateMouse()
	
	As Integer renderMethod_ 
	
	As Single  gravity_
	
	As FluidType  fluid
	As GridType   grid
	
	As ScreenType scr
	As MouseType  mouse
	
End Type


''
Dim Shared As WorldType World
	

''
Constructor ParticleType()
	
	impulse_  = Vec2( 0.0, 0.0 )
	position_ = Vec2( 0.0, 0.0 )
	velocity_ = Vec2( 0.0, 0.0 )
	
	density_ = 0.0
	
End Constructor


''
Constructor ParticlePairType()
	
	density_ = 0.0

	nOverDistance_ = Vec2( 0.0, 0.0 )

	particleA_ = 0
	particleB_ = 0
	
End Constructor


''
Constructor GridType()
	
	cellHeight_          = 0
	cellWidth_           = 0
	invCellHeight_       = 0.0
	invCellWidth_        = 0.0
	numCellPairs_        = 0
	numCells_            = 0
	numCellsX_           = 0
	numCellsY_           = 0
	numParticlesPerCell_ = 0
	
End Constructor


Constructor GridType( ByVal celldiameter As Single, _
                      ByVal screenwidth  As Integer, _
	 	                ByVal screenheight As Integer )

	numCellsX_           = Cast ( Integer, screenwidth  / celldiameter )
	numCellsY_           = Cast ( Integer, screenheight / celldiameter )
	
	numCells_            = numCellsX_ * numCellsY_

	cellWidth_           = Cast ( Integer, screenwidth  / numCellsX_ )
	cellHeight_          = Cast ( Integer, screenheight / numCellsY_ ) 

	invCellWidth_        = 1.0 / cellWidth_	
	invCellHeight_       = 1.0 / cellHeight_
	
	numCellPairs_        = numCells_ * 4 '' fix to numCells_ * 4
	
	numParticlesPerCell_ = MAX_PARTICLES_PER_CELL
	
End Constructor


''
Constructor Fluidtype()
	
	globalPressureCoefficient_ = 0.0
	localDampingCoefficient_   = 0.0
	localPressureCoefficient_  = 0.0
	numParticles_              = 0
	numParticlePairs_          = 0
	particleDiameter_          = 0.0
	particleDiameterSquared_   = 0.0
	particleRadius_            = 0.0
	restDistance_              = 0.0
	restDistanceSquared_       = 0.0
	restDensity_               = 0.0
	
	firstParticle_             = 0
	lastParticle_              = 0
	
End Constructor

Constructor Fluidtype( ByVal globalpressure As Single, _
		                 ByVal localpressure  As Single, _
		                 ByVal localdamping   As Single, _
		                 ByVal particleradius As Single, _
		                 ByVal restdistance   As Single, _
		                 ByVal restdensity    As Single )
	
	''
	globalPressureCoefficient_ = globalpressure
	localDampingCoefficient_   = localdamping
	localPressureCoefficient_  = localpressure
	particleRadius_            = particleradius
	restDistance_              = restdistance
	restDensity_               = restdensity
	
	''
	particleDiameter_          = 2.0 * particleRadius_
	particleDiameterSquared_   = particleDiameter_ * particleDiameter_
	restDistanceSquared_       = restDistance_ * restDistance_
	
	firstParticle_  = @particles ( 1 )
	lastParticle_   = @particles ( MAX_PARTICLES )
	
End Constructor


''
Constructor CellType()

End Constructor


''
Constructor CellPairType()

End Constructor


''
Constructor ScreenType()

End Constructor


''
Constructor MouseType()

End Constructor


''
Constructor WorldType()
	
	RunWorld()
	
End Constructor


''
Sub WorldType.RunWorld()
	
	Scr.CreateScreen( SCREEN_WID, SCREEN_HGT, 8, 8, 8, 8, 0, 0, 0 )
	
	initiateWorld()
	
	''  Main program loop
	Do
		
		''	reset
		fluid.resetParticles()
		grid.resetCells()
		
		''	input
		If MultiKey( FB.SC_F1 ) Then renderMethod_ = 1
		If MultiKey( FB.SC_F2 ) Then renderMethod_ = 2
		If MultiKey( FB.SC_F3 ) Then renderMethod_ = 3
		
		updateMouse()
		
		''	collision detection
		computeBroadPhase ( @fluid, @grid )
		
		''
		ComputeParticlePairs ( @fluid, @grid )
		
		''
		fluid.ComputeReusableData()
		
		''
		For i As Integer = 1 To ITERATIONS
			
			fluid.ComputeCorrectiveImpulse()
			
		Next
		
		''
		computeBorderImpulses()
		
		''
		ComputeNewState( @fluid )
		
		''
		drawFluid()
		
		'Sleep 200, 1
	
	Loop Until MultiKey( FB.SC_ESCAPE )
	
	End
	
End Sub


Sub GridType.computeCellPairs()

	numCellPairs_ = 0

	For x As Integer = 0 To numCellsX_
	
		For y As Integer = 0 To numCellsY_
		
			''  cell(x, y) -> cell(x + 1, y)
			If x < numCellsX_ Then
			
				numCellPairs_ += 1
				cellPairs( numCellPairs_ ).cellA_ = @cells( x, y )
				cellPairs( numCellPairs_ ).cellB_ = @cells( x + 1, y )
			
			EndIf
		
			''  cell(x, y) -> cell(x, y + 1)
			If y < numCellsY_ Then
			
				numCellPairs_ += 1
				cellPairs( numCellPairs_ ).cellA_ = @cells( x, y )
				cellPairs( numCellPairs_ ).cellB_ = @cells( x, y + 1 )					
			
			EndIf
		
			''  cell(x, y) -> cell(x + 1, y + 1)
			If ( x < numCellsX_ ) And ( y < numCellsY_ ) Then
			
				numCellPairs_ += 1
				cellPairs( numCellPairs_ ).cellA_ = @cells( x, y )
				cellPairs( numCellPairs_ ).cellB_ = @cells( x + 1, y + 1 )					
			
			EndIf
		
			''  cell(x, y) -> cell(x - 1, y + 1)
			If ( x > 0 ) And ( y < numCellsY_ ) Then
			
				numCellPairs_ += 1
				cellPairs( numCellPairs_ ).cellA_ = @cells( x, y )
				cellPairs( numCellPairs_ ).cellB_ = @cells( x - 1, y + 1 )		
			
			EndIf
		
		Next
	
	Next

End Sub


Sub WorldType.initiateWorld()

	''  Grid
	grid = GridType( PARTICLE_DIAMETER, SCREEN_WID, SCREEN_HGT )

	grid.computeCellPairs()	
	
	'fluid = FluidType	        _
	'(                         _
	'	GLOBAL_PRESSURE_COEFF, _
	'	LOCAL_PRESSURE_COEFF , _
	'	LOCAL_DAMPING_COEFF  , _
	'	PARTICLE_RADIUS      , _
	'	REST_DISTANCE        , _
	'	REST_DENSITY           _
	')
	
	''	Fluid 
	fluid.globalPressureCoefficient_ = GLOBAL_PRESSURE_COEFF
	fluid.localPressureCoefficient_  = LOCAL_PRESSURE_COEFF
	fluid.localDampingCoefficient_   = LOCAL_DAMPING_COEFF
	fluid.particleRadius_            = PARTICLE_RADIUS
	fluid.restDistance_              = REST_DISTANCE
	fluid.restDensity_               = REST_DENSITY
	
	fluid.restDistanceSquared_       = fluid.restDistance_ ^ 2.0
	fluid.particleDiameter_          = fluid.particleRadius_ * 2.0
	fluid.particleDiameterSquared_   = fluid.particleDiameter_ ^ 2.0
	
	fluid.firstParticle_  = @fluid.particles ( 1 )
	fluid.lastParticle_   = @fluid.particles ( MAX_PARTICLES )
	
	Randomize Timer

	Dim As Integer n = 0

	''   place particles
	For x As Integer = 1 To BLOCK_WID

		For y As Integer = 1 To BLOCK_HGT

			n += 1

			With fluid.particles (n)

				'.position_.x = BORDER + PARTICLE_RADIUS * 0.5 + x * PARTICLE_RADIUS * 0.6
				'.position_.y = SCREEN_HGT - BORDER - PARTICLE_RADIUS * 0.5 - y * PARTICLE_RADIUS * 0.6

				.position_.x = BORDER + PARTICLE_RADIUS * 0.5 + x * REST_DISTANCE * 0.5
				.position_.y = SCREEN_HGT - BORDER - PARTICLE_RADIUS * 0.5 - y * REST_DISTANCE * 0.5

				'.velocity_.x += (Rnd-Rnd) * 10.0
				'.velocity_.y += (Rnd-Rnd) * 10.0

				.position_.x += ( Rnd - Rnd ) * 0.001
				.position_.y += ( Rnd - Rnd ) * 0.001

'				.prevPosition_.x = .position_.x
'				.prevPosition_.y = .position_.y

			End With

		Next

	Next
	

	''	World
	renderMethod_  = 3

End Sub


Sub WorldType.computeBroadPhase( ByVal F As FluidType Ptr, ByVal G As GridType Ptr  )

	''
	For P As ParticleType Ptr = F->firstParticle_ To F->lastParticle_
	
		Dim As Integer cell_col = Cast( Integer, P->position_.x * G->invCellWidth_ )
	
		If ( cell_col < 0 ) Or ( cell_col > G->numCellsX_ ) Then Continue For
	
		Dim As Integer cell_row = Cast( Integer, P->position_.y * G->invCellHeight_ )
	
		If ( cell_row < 0 ) Or ( cell_row > G->numCellsY_ ) Then Continue For
	
		Dim As CellType Ptr C = @G->cells( cell_col, cell_row )
	
		If C->numParticles_ >= G->numParticlesPerCell_ Then Continue For
	
		C->numParticles_ += 1
	
		C->Particles( C->numParticles_ ) = P
	
	Next

End Sub


Sub WorldType.ComputeParticlePairs( ByVal F As FluidType Ptr, ByVal G As GridType Ptr )

	''   reset number of neighbors
	F->numParticlePairs_ = 0

	'' cell(x, y) - self
	For x As Integer = 0 To G->numCellsX_
	
		For y As Integer = 0 To G->numCellsY_
		
			Dim As CellType Ptr C = @G->cells( x, y )
		
			If C->numParticles_ = 0 Then Continue For
		
			For i As Integer = 1 To C->numParticles_ - 1
			
				For j As Integer = i + 1 To C->numParticles_
				
					checkPair( C->Particles( i ), C->Particles( j ) )
				
				Next
			
			Next
		
		Next
	
	Next

	'' cell(x, y) - neighbors
	For CP As CellPairType Ptr = @G->cellPairs( 1 ) To @G->cellPairs( grid.numCellPairs_ )	
	
		If CP->cellA_->numParticles_ = 0 Then Continue For
		If CP->cellB_->numParticles_ = 0 Then Continue For
	
		For i As Integer = 1 To CP->cellA_->numParticles_
		
			For j As Integer = 1 To CP->cellB_->numParticles_
			
				checkPair( CP->cellA_->Particles( i ), CP->cellB_->Particles( j ) )
			
			Next
		
		Next
	
	Next

End Sub


Sub GridType.resetCells()

	For x As Integer = 0 To numCellsX_
	
		For y As Integer = 0 To numCellsY_
		
			cells( x, y ).numParticles_ = 0
		
		Next
	
	Next

End Sub


Sub FluidType.resetParticles()

	For P As ParticleType Ptr = firstParticle_ To lastParticle_
		
		P->num_pairs_ = 0
		
		P->density_ = 0.0
		
		P->impulse_ = Vec2( 0.0, G )
		
	Next

End Sub


Sub FluidType.ComputeCorrectiveImpulse()

	For PP As ParticlePairType Ptr = @particlePairs( 1 ) To @particlePairs( numParticlePairs_ )
		
		''	delta impulse
		Dim As Vec2 delta_impulse = PP->particleB_->impulse_ - PP->particleA_->impulse_
		
		'' impulse error
		Dim As Single impulse_error = PP->nOverDistance_.dot( delta_impulse ) - PP->rest_impulse_
		
		'' corrective impulse
	   Dim As Vec2 corrective_impulse = impulse_error * PP->nOverDistance_
		
		PP->particleA_->impulse_ += corrective_impulse
		PP->particleB_->impulse_ -= corrective_impulse
	
	Next
	
End Sub

Sub WorldType.computeBorderImpulses()

	For P As ParticleType Ptr = fluid.firstParticle_ To fluid.lastParticle_
	
		If P->position_.x < RADIUS_PLUS_BORDER Then
		
			P->impulse_.x -= ( P->position_.x - RADIUS_PLUS_BORDER ) * INV_DT * BORDER_STIFFNES + _
			                   P->velocity_.x * BORDER_DAMPING
		
		ElseIf P->position_.x > ( SCREEN_WID - RADIUS_PLUS_BORDER ) Then
		
			P->impulse_.x -= ( P->position_.x - ( SCREEN_WID - RADIUS_PLUS_BORDER ) ) * INV_DT * BORDER_STIFFNES + _
			                   P->velocity_.x * BORDER_DAMPING
		
		EndIf
	
		If P->position_.y < RADIUS_PLUS_BORDER Then
		
			P->impulse_.y -= ( P->position_.y - RADIUS_PLUS_BORDER ) * INV_DT * BORDER_STIFFNES + _
			                   P->velocity_.y * BORDER_DAMPING
		
		ElseIf P->position_.y > ( SCREEN_HGT - RADIUS_PLUS_BORDER ) Then
		
			P->impulse_.y -= ( P->position_.y - ( SCREEN_HGT - RADIUS_PLUS_BORDER ) ) * INV_DT * BORDER_STIFFNES + _
			                   P->velocity_.y * BORDER_DAMPING
		
		EndIf
	
	Next

End Sub


Sub WorldType.ComputeNewState( ByVal F As FluidType Ptr )

	For P As ParticleType Ptr = F->firstParticle_ To F->lastParticle_
		
		P->velocity_ += P->impulse_
		P->position_ += P->velocity_ * DT
		
	Next

End Sub


Sub WorldType.drawFluid()

	ScreenLock
	
		''
		If renderMethod_ = 1 Then
		
			Line(0, 0)-(SCREEN_WID, SCREEN_HGT), RGBA(255, 255, 255, 32), bf
		
			For P As ParticleType Ptr = fluid.firstParticle_ To fluid.lastParticle_
				
				Dim As Single col_r = 0
				Dim As Single col_g = 0
				Dim As Single col_b = 0
			
'				Line(P->prevPosition_.x, P->prevPosition_.y)-(P->position_.x, P->position_.y), RGBA(col_r, col_g, col_b, 192)
			
			Next
		
		End If
		
		''
		If renderMethod_ = 2 Then
			
			Color RGB( 255, 255, 255 ), RGB( 0, 0, 0 )
			
			Cls
		
			For P As ParticleType Ptr = fluid.firstParticle_ To fluid.lastParticle_
				
				Dim As Integer col_r = P->density_ * COLOR_PRESSURE_SCALE
				Dim As Integer col_g
				Dim As Integer col_b
			
				If col_r > 255 Then
				
					col_g = col_r - 255
					col_r = 255
				
				EndIf
			
				col_b = 255 - col_r
			
				If col_g > 255 Then col_g = 255
				If col_b > 255 Then col_b = 255
			
				Line( P->position_.x-2, P->position_.y-2 )-_
				    ( P->position_.x+2, P->position_.y+2 ), RGB(col_r, col_g, col_b), bf
				
				'Circle( P->position_.x, P->position_.y ), PARTICLE_RADIUS, RGB(col_r, col_g, col_b),,,1
				
			Next
		
		EndIf
		
		''
		If renderMethod_ = 3 Then
			
			Color RGB( 0, 0, 0 ), RGB( 255, 255, 255 )
			
			Cls
			
			'Line(0, 0)-(SCREEN_WID, SCREEN_HGT), RGB(255, 255, 255), bf
		
			For N As ParticlePairType Ptr = @fluid.particlePairs( 1 ) To @fluid.particlePairs( fluid.numParticlePairs_ )
			
				Line(N->particleA_->position_.x, N->particleA_->position_.y)-(N->particleB_->position_.x,N->particleB_->position_.y), RGBA( 0, 0, 0, 128 )
			
			Next
			
			For P As ParticleType Ptr = fluid.firstParticle_ To fluid.lastParticle_
			
				Line( P->position_.x-1, P->position_.y-1 )-_
				    ( P->position_.x+1, P->position_.y+1 ), RGB( 0, 0, 0 ), bf
			
			Next
		
		EndIf
	
		''
		Locate 2, 2: Print "particles:     " ; MAX_PARTICLES
		Locate 4, 2: Print "particle pairs:" ; fluid.numParticlePairs_
	
	ScreenUnLock

End Sub


Sub WorldType.checkPair( ByVal A As ParticleType Ptr, ByVal B As ParticleType Ptr )

	If ( fluid.numParticlePairs_ >= MAX_PAIRS_GLOBAL ) Then Exit Sub

	If ( A->num_pairs_ >= MAX_PAIRS_LOCAL ) Then Exit Sub
	If ( B->num_pairs_ >= MAX_PAIRS_LOCAL ) Then Exit Sub
	
	Dim As Vec2 distance_vector = B->position_ - A->position_

	If Abs( distance_vector.x ) > fluid.particleDiameter_ Then Exit Sub
	If Abs( distance_vector.y ) > fluid.particleDiameter_ Then Exit Sub

	Dim As Single distance_squared = distance_vector.lengthsquared()

	If ( distance_squared > fluid.particleDiameterSquared_ ) Then Exit Sub
	If ( distance_squared < MIN_DISTANCE ) Then Exit Sub
	
	'' okay, we are interacting - create neighbor
	fluid.numParticlePairs_ += 1
	
	A->num_pairs_ += 1
	B->num_pairs_ += 1

	Dim As ParticlePairType Ptr PP = @fluid.particlePairs( fluid.numParticlePairs_ )

	PP->particleA_ = A
	PP->particleB_ = B
	
	''	density kernel, density = d_rest^2 - d^2
	PP->density_  = fluid.restDistanceSquared_ - distance_squared
	PP->density2_ = PP->density_ * PP->density_
	
	''  add pressure to particles
	A->density_ += PP->density_
	B->density_ += PP->density_
	
	''
	PP->nOverDistance_ = ( distance_vector * distance_squared ) / ( distance_squared * distance_squared )
	
End Sub

Sub FluidType.ComputeReusableData()
	
	For N As ParticlePairType Ptr = @particlePairs( 1 ) To @particlePairs( numParticlePairs_ )
		
		Dim As Single local_pressure_impulse = N->density2_ * localPressureCoefficient_
		
		Dim As Single global_pressure_impulse = ( ( N->particleA_->density_ + N->particleB_->density_) - restDensity_ ) * ( 1.0 / N->density_ ) * globalPressureCoefficient_ 
		
		Dim As Single local_damping_impulse = - N->nOverDistance_.dot( N->particleB_->velocity_ - N->particleA_->velocity_ ) * localDampingCoefficient_ 
		
		N->rest_impulse_ = local_pressure_impulse + global_pressure_impulse + local_damping_impulse
		
	Next
	
End Sub


Sub ScreenType.CreateScreen(w As Integer, h As Integer, r As Integer, g As Integer, _
	b As Integer, a As Integer, d As Integer, s As Integer, m As Integer)

	ScreenRes w, h, 24,, fb.GFX_ALPHA_PRIMITIVES

	'Color RGB(0, 0, 0), RGB(255, 255, 255)
	Color RGB(255, 255, 255), RGB(0, 0, 0)

End Sub


Sub WorldType.UpdateMouse

	''
	mouse.prevPosition_ = mouse.position_
	mouse.prevButton_   = mouse.button_
	mouse.prevWheel_    = mouse.wheel_
	
	Dim As Integer mouse_x, mouse_y
	
	''
	GetMouse ( mouse_x, mouse_y, mouse.wheel_, mouse.button_ )
	
	mouse.position_ = Vec2( Cast( Single, mouse_x ), Cast( Single, mouse_y ) )
	
	''
	'velocity_ = ( position_ - prevPosition_ ) * INV_DT

	mouse.velocity_.x = ( mouse.position_.x - mouse.prevPosition_.x ) * INV_DT
	mouse.velocity_.y = ( mouse.position_.y - mouse.prevPosition_.y ) * INV_DT

	''
	If ( mouse.button_ = 1 ) Then
	
		For P As ParticleType Ptr = fluid.firstParticle_ To fluid.lastParticle_
		
			Dim As Vec2 dst = P->position_ - mouse.position_
		
			If Abs( dst.x ) > INTERACT_RADIUS Then Continue For
			If Abs( dst.y ) > INTERACT_RADIUS Then Continue For
		
			Dim As Single distance_squared = dst.lengthsquared()
		
			If distance_squared > INTERACT_RADIUS_SQD Then Continue For
		
			P->impulse_ -= ( ( P->velocity_ - mouse.velocity_ ) * INV_DT ) * ( 1.0 - distance_squared / INTERACT_RADIUS_SQD ) * 0.005
		
		Next
	
	End If

	''
	If ( mouse.button_ = 2 ) Then
	
		For P As ParticleType Ptr = fluid.firstParticle_ To fluid.lastParticle_
		
			Dim As Vec2 dst = P->position_ - mouse.position_
		
			Dim As Single distance_squared = dst.lengthsquared()
		
			P->impulse_ += dst / distance_squared * 5000.0
		
		Next
	
	End If

	''
	If mouse.wheel_ <> mouse.prevWheel_ Then
	
		For P As ParticleType Ptr = fluid.firstParticle_ To fluid.lastParticle_
		
			Dim As Vec2 dst = P->position_ - mouse.position_
		
			If Abs( dst.x ) < MIN_DISTANCE Then Continue For
			If Abs( dst.y ) < MIN_DISTANCE Then Continue For
		
			Dim As Single distance_squared = dst.lengthsquared()
		
			Dim As Single direction = Sgn( mouse.wheel_ - mouse.prevWheel_ )
		
			P->impulse_ += ( dst / distance_squared ).perp() * 5000.0 * direction
		
		Next
	
	EndIf

End Sub
