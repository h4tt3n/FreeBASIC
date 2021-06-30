''*******************************************************************************
''
''  Smoothed Particle Hydrodynamics (SPH) fluid Simulation
''
''  Version 0.4.0, february 2014
''	 Written in FreeBASIC v. 0.90
''  Mike "h4tt3n", micha3l_niss3n@yahoo.dk
''
''  Description:
''
''  Very fast, stable, and square-root free SPH simulation.
''
''  Controls:
''
''  -Press left mouse button to stir fluid
''  -Press right mouse button to
''  -Roll mouse wheel up / down to create current eddies
''  -Press escape key to exit
''
''  Todo-list:
''
''	 add particle emitter
''  add obstacles
''  different types of fluids (fluid type)
''
''
''*******************************************************************************


''   Includes
#Include Once "fbgfx.bi"
#Include Once "vec2.bi"


''   global constants
Const As Single  DT                     = 1.0 / 100.0                                  ''
Const As Single  DT_SQD                 = DT * DT                                      ''
Const As Single  INV_DT                 = 1.0 / DT                                     ''
Const As Single  INV_DT_SQD             = 1.0 / DT_SQD                                 ''

Const As Single  G                      = 1600.0                                      ''
'Const As Single  G_TIMES_DT             = G * DT                                       '' 
Const As Single  MIN_DISTANCE           = 1.0                                          '' minimum distance
Const As Single  PI                     = 4.0 * Atn( 1.0 )                             ''	pi

Const As Single  PARTICLE_RADIUS        = 15.0 '15.0                                         '' particle radius
Const As Single  PARTICLE_DIAMETER      = PARTICLE_RADIUS * 2.0                        ''
'Const As Single  PARTICLE_DIAMETER_SQD  = PARTICLE_DIAMETER * PARTICLE_DIAMETER        ''

Const As Single  LOCAL_PRESSURE_COEFF   = 64.0	  '64                                  ''
Const As Single  GLOBAL_PRESSURE_COEFF  = 4.0	  '4                                   ''
Const As Single  LOCAL_DAMPING_COEFF    = 64.0	  '64                                  ''

Const As Single  REST_DISTANCE          = 25.0    '26                                  ''
'Const As Single  REST_DISTANCE_SQD      = REST_DISTANCE * REST_DISTANCE                ''

Const As Single  REST_DENSITY           = 12000.0 '11000                               '' rest pressure
Const As Single  COLOR_PRESSURE_SCALE   = 255 / REST_DENSITY                           ''

Const As Integer BLOCK_WID              = 50                                           ''
Const As Integer BLOCK_HGT              = 50                                         ''
Const As Integer MAX_PARTICLES          = BLOCK_WID * BLOCK_HGT                        '' number of particles
Const As Integer MAX_PAIRS_LOCAL        = 64                                           '' max number of neighbors per particles
Const As Integer MAX_PAIRS_GLOBAL       = MAX_PARTICLES * MAX_PAIRS_LOCAL * 0.75        '' global max number of neighbors

Const As Integer SCREEN_HGT             = 600                                          '' screen height
Const As Integer SCREEN_WID             = 800                                         '' screen wiDTh
 
Const As Integer CELL_DIAMETER          = Cast ( Integer, 1.0 * PARTICLE_DIAMETER )    '' cell diameter
Const As Integer MAX_PARTICLES_PER_CELL = 64                                           '' max number of particles held by one cell
Const As Integer NUM_CELLS_X            = Cast ( Integer, SCREEN_WID / CELL_DIAMETER ) '' number of cells per row / on x axis
Const As Integer NUM_CELLS_Y            = Cast ( Integer, SCREEN_HGT / CELL_DIAMETER ) '' number of cells per column / on y axis
Const As Integer NUM_CELLS              = (NUM_CELLS_X) * (NUM_CELLS_Y)                ''
Const As Integer NUM_CELL_PAIRS         = NUM_CELLS * 5                                ''
'Const As Integer CELL_WID               = Cast ( Integer, SCREEN_WID / NUM_CELLS_X )   ''
'Const As Integer CELL_HGT               = Cast ( Integer, SCREEN_HGT / NUM_CELLS_Y )   ''
'Const As Single  INV_CELL_WID           = 1.0 / CELL_WID
'Const As Single  INV_CELL_HGT           = 1.0 / CELL_HGT

Const As Integer BORDER                 = 8                                            ''
Const As Integer RADIUS_PLUS_BORDER     = PARTICLE_RADIUS + BORDER                     ''
Const As Single  BORDER_STIFFNES        = 0.5                                          ''
Const As Single  BORDER_DAMPING         = 0.0                                         ''

Const As Single  INTERACT_RADIUS        = 32.0                                         ''
Const As Single  INTERACT_RADIUS_SQD    = INTERACT_RADIUS ^ 2                          ''



''
Type ParticleType

	Public:

	As Vec2f   force_
	As Vec2f   position_
	As Vec2f   prevPosition_
	As Vec2f   velocity_

	As Single  density_

	Private:

End Type


''
Type ParticlePairType

	Public:

	As Single           density_
	As Single           distanceSquared_

	As Vec2f            nOverDistance_

	As ParticleType Ptr particleA_
	As ParticleType Ptr particleB_

	Private:

End Type


''
Type FluidType

	Public:
	
	Declare Constructor()
	
	Declare Constructor                _
	(                                  _
		ByVal globalpressure As Single, _
		ByVal localpressure  As Single, _
		ByVal localdamping   As Single, _
		ByVal particleradius As Single, _
		ByVal restdistance   As Single, _
		ByVal restdensity    As Single  _
	)
	
	Declare Sub computeForce   ()
	Declare Sub resetParticles ()
	
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

	Private:

End Type


''
Type CellType

	Public:

	As Integer numParticles_

	As ParticleType Ptr particles ( 1 To MAX_PARTICLES_PER_CELL )
	
	Private:

End Type


''
Type CellPairType
	
	Public:
	
	As CellType Ptr cellA_
	As CellType Ptr cellB_
	
	Private:

End Type


''
Type GridType

	Public:
	
	Declare Constructor ()
	
	Declare Constructor               _
	(                                 _
		ByVal celldiameter As Single,  _
	 	ByVal screenwidth  As Integer, _
	 	ByVal screenheight As Integer  _
	)
	
	Declare Sub computeCellPairs ()
	Declare Sub resetCells       ()
	
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

	Private:

End Type


''
Type ScreenType

	Public:

	Declare Sub CreateScreen _
	(                        _
		ByVal w As Integer,   _
		ByVal h As Integer,   _
		ByVal r As Integer,   _
		ByVal g As Integer,   _
		ByVal b As Integer,   _
		ByVal a As Integer,   _
		ByVal d As Integer,   _
		ByVal s As Integer,   _
		ByVal m As Integer    _
	)

	As Integer width_    '' not
	As Integer height_   '' in
	As Integer bitDepth_ '' use

	Private:

End Type


''
Type MouseType

	Public:

	As vec2i   position_
	As vec2i   prevPosition_

	As Vec2f   velocity_

	As Integer button_
	As Integer prevButton_
	As Integer wheel_
	As Integer prevWheel_

	Private:

End Type


''
Type SimulationType

	Public:
	
	Declare Sub computeBorderForces      ()
	Declare Sub main                     ()
	Declare Sub drawFluid                ()
	Declare Sub integrateSymplecticEuler ( ByVal F As FluidType Ptr )
	Declare Sub integrateVerlet          ( ByVal F As FluidType Ptr )
	Declare Sub initiateSimulation       ()
	
	Declare Sub computeBroadPhase        ( ByVal F As FluidType Ptr, ByVal G As GridType Ptr )
	
	Declare Sub checkPair                ( ByVal A As ParticleType Ptr, ByVal B As ParticleType Ptr )
	Declare Sub computeNarrowPhase       ( ByVal F As FluidType Ptr, ByVal G As GridType Ptr )
	Declare Sub UpdateMouse              ()
	
	As Integer renderMethod_ 
	
	As Single  gravity_
	
	As FluidType  fluid
	As GridType   grid
	
	As ScreenType scr
	As MouseType  mouse

	Private:

End Type


''
Dim Shared As SimulationType simulation

simulation.main()

''
Constructor GridType ()

End Constructor

Constructor GridType                 _
	(                                 _
		ByVal celldiameter As Single,  _
	 	ByVal screenwidth  As Integer, _
	 	ByVal screenheight As Integer  _
	)

	numCellsX_           = Cast ( Integer, screenwidth  / celldiameter )
	numCellsY_           = Cast ( Integer, screenheight / celldiameter )
	
	numCells_            = numCellsX_ * numCellsY_

	cellWidth_           = Cast ( Integer, screenwidth  / numCellsX_ )
	cellHeight_          = Cast ( Integer, screenheight / numCellsY_ )

	invCellWidth_        = 1.0 / cellWidth_	
	invCellHeight_       = 1.0 / cellHeight_
	
	numCellPairs_        = numCells_ * 5 '' fix to numCells_ * 4

	numParticlesPerCell_ = 32

End Constructor

Constructor Fluidtype()

End Constructor

Constructor Fluidtype                 _
	(                                  _
		ByVal globalpressure As Single, _
		ByVal localpressure  As Single, _
		ByVal localdamping   As Single, _
		ByVal particleradius As Single, _
		ByVal restdistance   As Single, _
		ByVal restdensity    As Single  _
	)
	
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
	

	'As Integer          numParticles_
	'As Integer          numParticlePairs_
	'
	'As ParticleType Ptr firstParticle_
	'As ParticleType Ptr lastParticle_

	'As ParticleType     particles     ( 1 To MAX_PARTICLES      )
	'As ParticlePairType particlePairs ( 1 To MAX_PAIRS_GLOBAL )
	
End Constructor

''
Sub SimulationType.main()
	
	Scr.CreateScreen( SCREEN_WID, SCREEN_HGT, 8, 8, 8, 8, 0, 0, 0 )
	
	initiateSimulation()
	
	''  main program loop
	Do
		
		''	reset
		fluid.resetParticles()
		grid.resetCells()
		
		''	input
		If MultiKey( FB.SC_F1 ) Then renderMethod_ = 1
		If MultiKey( FB.SC_F2 ) Then renderMethod_ = 2
		If MultiKey( FB.SC_F3 ) Then renderMethod_ = 3
		If MultiKey( FB.SC_F4 ) Then renderMethod_ = 4
		
		updateMouse()
		
		''	collision detection
		computeBroadPhase  ( @fluid, @grid )
		computeNarrowPhase ( @fluid, @grid )
		
		''	forces
		fluid.computeForce()
		computeBorderForces()
		
		''	integrate
		'integrateSymplecticEuler( @fluid )
		integrateVerlet ( @fluid )
		
		''	draw
		drawFluid()
	
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
			If x < numCellsX_ And y < numCellsY_ Then
			
				numCellPairs_ += 1
				cellPairs( numCellPairs_ ).cellA_ = @cells( x, y )
				cellPairs( numCellPairs_ ).cellB_ = @cells( x + 1, y + 1 )					
			
			EndIf
		
			''  cell(x, y) -> cell(x - 1, y + 1)
			If x > 0 And y < numCellsY_ Then
			
				numCellPairs_ += 1
				cellPairs( numCellPairs_ ).cellA_ = @cells( x, y )
				cellPairs( numCellPairs_ ).cellB_ = @cells( x - 1, y + 1 )		
			
			EndIf
		
		Next
	
	Next

End Sub


Sub SimulationType.initiateSimulation()

	grid = GridType       _
	(                     _
		PARTICLE_DIAMETER, _
		SCREEN_WID       , _
		SCREEN_HGT         _
	)
	
	fluid.globalPressureCoefficient_ = GLOBAL_PRESSURE_COEFF
	fluid.localPressureCoefficient_  = LOCAL_PRESSURE_COEFF
	fluid.localDampingCoefficient_   = LOCAL_DAMPING_COEFF
	fluid.particleRadius_            = PARTICLE_RADIUS
	fluid.restDistance_              = REST_DISTANCE
	fluid.restDensity_               = REST_DENSITY
	
	fluid.restDistanceSquared_       = fluid.restDistance_ ^ 2
	fluid.particleDiameter_          = fluid.particleRadius_ * 2.0
	fluid.particleDiameterSquared_   = fluid.particleDiameter_ ^ 2
	
	'fluid = FluidType	        _
	'(                         _
	'	GLOBAL_PRESSURE_COEFF, _
	'	LOCAL_PRESSURE_COEFF , _
	'	LOCAL_DAMPING_COEFF  , _
	'	PARTICLE_RADIUS      , _
	'	REST_DISTANCE        , _
	'	REST_DENSITY           _
	')

	''  Grid
	grid.computeCellPairs()	
	
	''	Fluid 
	
	Randomize Timer

	Dim As Integer n = 0

	''   place particles
	For x As Integer = 1 To BLOCK_WID

		For y As Integer = 1 To BLOCK_HGT

			n += 1

			With fluid.particles (n)

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
	
	fluid.firstParticle_  = @fluid.particles ( 1 )
	fluid.lastParticle_   = @fluid.particles ( MAX_PARTICLES )
	
	''	simulation
	renderMethod_  = 2

End Sub


Sub SimulationType.computeBroadPhase( ByVal F As FluidType Ptr, ByVal G As GridType Ptr  )

	''
	For P As ParticleType Ptr = F->firstParticle_ To F->lastParticle_
	
		Dim As Integer cell_col = P->position_.x * G->invCellWidth_
	
		If ( cell_col < 0 ) Or ( cell_col > G->numCellsX_ ) Then Continue For
	
		Dim As Integer cell_row = P->position_.y * G->invCellHeight_
	
		If ( cell_row < 0 ) Or ( cell_row > G->numCellsY_ ) Then Continue For
	
		Dim As CellType Ptr C = @G->cells( cell_col, cell_row )
	
		''If C->numParticles_ >= G->numParticlesPerCell_ Then Continue For
	
		C->numParticles_ += 1
	
		C->Particles( C->numParticles_ ) = P
	
	Next

End Sub


Sub SimulationType.computeNarrowPhase( ByVal F As FluidType Ptr, ByVal G As GridType Ptr )

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
	
		P->density_   = 0.0			          '' ?!?
		'P->force_     = Vec2f()                 ''
		P->force_     = Vec2f( 0.0, G )                 ''
		'P->velocity_ += Vec2f( 0.0, G_TIMES_DT) ''
	
	Next

End Sub


Sub FluidType.computeForce()

	For pair As ParticlePairType Ptr = @particlePairs( 1 ) To @particlePairs( numParticlePairs_ )
	
		''   velocity vector projected onto distance vector
		Dim As Single velocity = ( pair->particleB_->velocity_ - pair->particleA_->velocity_ ).dot( pair->nOverDistance_ )
	
		If pair->distanceSquared_ > MIN_DISTANCE Then
		
			''   force vector
			Dim As Vec2f force = pair->nOverDistance_ * ( _
			pair->density_                                                                * localPressureCoefficient_  - _  '' local pressure
			( restDensity_ - ( pair->particleA_->density_ + pair->particleB_->density_) ) * globalPressureCoefficient_ - _  '' global pressure
			velocity                                                                      * localDampingCoefficient_     )  '' damping
		
			''   apply opposite equal forces
			pair->particleA_->force_ -= force
			pair->particleB_->force_ += force
		
		End If
	
	Next
	
End Sub


Sub SimulationType.computeBorderForces()

	For P As ParticleType Ptr = fluid.firstParticle_ To fluid.lastParticle_
	
		If P->position_.x < RADIUS_PLUS_BORDER Then
		
			P->force_.x -= ( P->position_.x - RADIUS_PLUS_BORDER ) * INV_DT_SQD * BORDER_STIFFNES + _
			                 P->velocity_.x                        * INV_DT     * BORDER_DAMPING
		
		EndIf
	
		If P->position_.x > ( SCREEN_WID - RADIUS_PLUS_BORDER ) Then
		
			P->force_.x -= ( P->position_.x - ( SCREEN_WID - RADIUS_PLUS_BORDER ) ) * INV_DT_SQD * BORDER_STIFFNES + _
			                 P->velocity_.x                                         * INV_DT     * BORDER_DAMPING
		
		EndIf
	
		If P->position_.y < RADIUS_PLUS_BORDER Then
		
			P->force_.y -= ( P->position_.y - RADIUS_PLUS_BORDER ) * INV_DT_SQD * BORDER_STIFFNES + _
			                 P->velocity_.y                        * INV_DT     * BORDER_DAMPING
		
		EndIf
	
		If P->position_.y > ( SCREEN_HGT - RADIUS_PLUS_BORDER ) Then
		
			P->force_.y -= ( P->position_.y - ( SCREEN_HGT - RADIUS_PLUS_BORDER ) ) * INV_DT_SQD * BORDER_STIFFNES + _
			                 P->velocity_.y                                         * INV_DT     * BORDER_DAMPING
		
		EndIf
	
	Next

End Sub


Sub SimulationType.integrateSymplecticEuler( ByVal F As FluidType Ptr )

	For P As ParticleType Ptr = F->firstParticle_ To F->lastParticle_
	
		P->prevPosition_ = P->position_
		
		P->velocity_    += P->force_    * DT
		P->position_    += P->velocity_ * DT
	
	Next

End Sub

Sub SimulationType.integrateVerlet( ByVal F As FluidType Ptr )

	For P As ParticleType Ptr = F->firstParticle_ To F->lastParticle_
	
	  Dim As Vec2f temp = P->position_
	  
	  P->position_ += ( P->position_ - P->prevPosition_ ) + P->force_ * DT_SQD
	  
	  P->prevPosition_ = temp
	  
	  'P->velocity_ = ( P->position_ - P->prevPosition_ ) * INV_DT
	  
	  P->velocity_ += P->force_ * DT
	
	Next

End Sub


Sub SimulationType.drawFluid()

	ScreenLock
	
		''
		If renderMethod_ = 1 Then
		
			Line(0, 0)-(SCREEN_WID, SCREEN_HGT), RGBA(0, 0, 0, 32), bf
		
			For P As ParticleType Ptr = fluid.firstParticle_ To fluid.lastParticle_
			
				Dim As Single col_r = P->density_ * COLOR_PRESSURE_SCALE
				Dim As Single col_g
				Dim As Single col_b
			
				If col_r > 255 Then
				
					col_g = col_r - 255
					col_r = 255
				
				EndIf
			
				col_b = 255 - col_r
			
				If col_g > 255 Then col_g = 255
				If col_b > 255 Then col_b = 255
			
				Line(P->prevPosition_.x, P->prevPosition_.y)-(P->position_.x, P->position_.y), RGB(col_r, col_g, col_b)
			
			Next
		
		End If
		
		''
		If renderMethod_ = 2 Then
		
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
			
				Line( P->position_.x-1.5, P->position_.y-1.5 )-( P->position_.x+1.5, P->position_.y+1.5 ), RGB(col_r, col_g, col_b), bf
				'PSet( P->position_.x, P->position_.y ), RGB(col_r, col_g, col_b)
			
			Next
		
		EndIf
		
		''
		If renderMethod_ = 3 Then
		
			Line(0, 0)-(SCREEN_WID, SCREEN_HGT), RGB(255, 255, 255), bf
		
			For N As ParticlePairType Ptr = @fluid.particlePairs( 1 ) To @fluid.particlePairs( fluid.numParticlePairs_ )
			
				Line(N->particleA_->position_.x, N->particleA_->position_.y)-(N->particleB_->position_.x,N->particleB_->position_.y), RGBA(0, 0, 0, 32)
			
			Next
			
			'For P As ParticleType Ptr = fluid.firstParticle_ To fluid.lastParticle_
			'	
			'	Pset( P->position_.x, P->position_.y ), RGB(0, 0, 0)
			'	
			'Next
			
		
		EndIf
		
		''
		If renderMethod_ = 4 Then
			
			Cls
			'Line(0, 0)-(SCREEN_WID, SCREEN_HGT), RGB(255, 255, 255), bf
			
			For P As ParticleType Ptr = fluid.firstParticle_ To fluid.lastParticle_
				
				'Dim As Integer col_r = 0
				'Dim As Integer col_g = 128
				'Dim As Integer col_b = P->density_ * COLOR_PRESSURE_SCALE
			
				'If col_b > 255 Then
				'
				'	col_g = col_b - 255
				'	col_b = 255
				'
				'EndIf
			
				'If col_g > 255 Then col_g = 255
				'If col_b > 255 Then col_b = 255
				'
				'If col_r < 0 Then col_r = 0
				'If col_g < 0 Then col_g = 0
				'If col_b < 0 Then col_b = 0
				
				
				'circle( P->position_.x, P->position_.y ), PARTICLE_RADIUS, RGB(col_r, col_g, col_b),,, 1, f
				circle( P->position_.x, P->position_.y ), PARTICLE_RADIUS, RGB(0, 128, 255),,, 1, f
				
			Next
			
			'For P As ParticleType Ptr = fluid.firstParticle_ To fluid.lastParticle_
			'	
			'	'circle( P->position_.x, P->position_.y ), 2, RGB(0, 0, 0),,, 1, f
			'	Pset( P->position_.x, P->position_.y ), RGB(0, 0, 0)
			'	
			'Next
			
		
		EndIf
	
		''
		Locate 2, 2: Print "particles:     " ; MAX_PARTICLES
		Locate 4, 2: Print "particle pairs:" ; fluid.numParticlePairs_
	
	ScreenUnLock

End Sub


Sub SimulationType.checkPair(ByVal A As ParticleType Ptr, ByVal B As ParticleType Ptr)

	If fluid.numParticlePairs_ >= MAX_PAIRS_GLOBAL Then Exit Sub

	Dim As Vec2f distance_vector = B->position_ - A->position_

	If Abs( distance_vector.x ) > fluid.particleDiameter_ Then Exit Sub
	If Abs( distance_vector.y ) > fluid.particleDiameter_ Then Exit Sub

	Dim As Single distance_squared = distance_vector.magnitudesquared()

	If ( distance_squared > fluid.particleDiameterSquared_ ) Then Exit Sub

	'' okay, we are interacting - create neighbor
	fluid.numParticlePairs_ += 1

	Dim As ParticlePairType Ptr particlepair = @fluid.particlePairs( fluid.numParticlePairs_ )

	particlepair->particleA_ = A
	particlepair->particleB_ = B

	particlepair->distanceSquared_ = distance_squared

	particlepair->density_ = fluid.restDistanceSquared_ - distance_squared

	If distance_squared > MIN_DISTANCE Then
	
		particlepair->nOverDistance_ = distance_vector / distance_squared
	
	Else
	
		particlepair->nOverDistance_ = Vec2f(0,0)
	
	End If

	''  add pressure to particles
	A->density_ += particlepair->density_
	B->density_ += particlepair->density_

End Sub


Sub ScreenType.CreateScreen(w As Integer, h As Integer, r As Integer, g As Integer, _
	b As Integer, a As Integer, d As Integer, s As Integer, m As Integer)

	ScreenRes w, h, 24,, fb.GFX_ALPHA_PRIMITIVES

	'Color RGB(0, 0, 0), RGB(255, 255, 255)
	Color RGB(255, 255, 255), RGB(0, 0, 0)

End Sub


Sub SimulationType.UpdateMouse

	''
	mouse.prevPosition_ = mouse.position_
	mouse.prevButton_   = mouse.button_
	mouse.prevWheel_    = mouse.wheel_

	''
	GetMouse mouse.position_.x, mouse.position_.y, mouse.wheel_, mouse.button_

	''
	'velocity_ = ( position_ - prevPosition_ ) * INV_DT

	mouse.velocity_.x = ( mouse.position_.x - mouse.prevPosition_.x ) * INV_DT
	mouse.velocity_.y = ( mouse.position_.y - mouse.prevPosition_.y ) * INV_DT

	''
	If ( mouse.button_ = 1 ) Then
	
		For P As ParticleType Ptr = fluid.firstParticle_ To fluid.lastParticle_
		
			Dim As Vec2f dst = P->position_ - mouse.position_
		
			If Abs( dst.x ) > INTERACT_RADIUS Then Continue For
			If Abs( dst.y ) > INTERACT_RADIUS Then Continue For
		
			Dim As Single distance_squared = dst.magnitudeSquared()
		
			If distance_squared > INTERACT_RADIUS_SQD Then Continue For
		
			P->force_ -= ( ( P->velocity_ - mouse.velocity_ ) * INV_DT ) * ( 1 - distance_squared / INTERACT_RADIUS_SQD ) * 0.25
		
		Next
	
	End If

	''
	If ( mouse.button_ = 2 ) Then
	
		For P As ParticleType Ptr = fluid.firstParticle_ To fluid.lastParticle_
		
			Dim As Vec2f dst = P->position_ - mouse.position_
		
			Dim As Single distance_squared = dst.magnitudeSquared()
		
			P->force_ += dst / distance_squared * 300000.0
		
		Next
	
	End If

	''
	If mouse.wheel_ <> mouse.prevWheel_ Then
	
		For P As ParticleType Ptr = fluid.firstParticle_ To fluid.lastParticle_
		
			Dim As Vec2f dst = P->position_ - mouse.position_
		
			If Abs( dst.x ) < MIN_DISTANCE Then Continue For
			If Abs( dst.y ) < MIN_DISTANCE Then Continue For
		
			Dim As Single distance_squared = dst.magnitudeSquared()
		
			Dim As Single magnitude = Sgn( mouse.wheel_ - mouse.prevWheel_ )
		
			P->force_ += ( dst / distance_squared ).normal() * 300000.0 * magnitude
		
		Next
	
	EndIf

End Sub