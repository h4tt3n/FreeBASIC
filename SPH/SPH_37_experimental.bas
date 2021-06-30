''*******************************************************************************
''  Smoothed Particle Hydrodynamics (SPH) fluid Simulation
''
''  Version 37, february 2014
''  Mike "h4tt3n", micha3l_niss3n@yahoo.dk
''
''  Description:
''
''  very fast, square root free SPH simulation.
''
''  Controls:
''
''  press left mouse button to stir fluid
''  roll mouse wheel up / down to create current eddies
''  press escape key to exit
''
''  Todo-list:
''
''  add particle emitter
''  add obstacles
''  different types of fluids (fluid type)
''
''
''*******************************************************************************


''   Includes
#Include Once "fbgfx.bi"
#Include Once "vec2.bi"


''   global constants
Const As Single  DT                         = 0.01                                   ''
Const As Single  DT_SQRD                    = DT * DT                                ''
Const As Single  INV_DT                     = 1.0 / DT                               ''
Const As Single  INV_DT_SQRD                = 1.0 / DT_SQRD                          ''
Const As Single  HALF_DT                    = 0.5 * DT                               ''
Const As Single  HALF_DT_SQRD               = 0.5 * DT_SQRD                          ''

Const As Single  G                          = 00.0                                   ''
Const As Single  ZERO                       = 1.0                                    ''   min Single value
Const As Single  PI                         = 4*Atn(1)                               ''   PI


Const As Single  PARTICLE_RADIUS            = 15.0                                   '' particle radius
Const As Single  PARTICLE_DIAMETER          = PARTICLE_RADIUS * 2.0                  '' 
Const As Single  INV_PARTICLE_RADIUS        = 1.0 / PARTICLE_RADIUS                  '' 
Const As Single  PARTICLE_RADIUS_SQRD       = PARTICLE_RADIUS * PARTICLE_RADIUS      '' radius squared
Const As Single  PARTICLE_DIAMETER_SQRD     = PARTICLE_DIAMETER * PARTICLE_DIAMETER  '' 
Const As Single  INV_PARTICLE_RADIUS_sqrd   = 1.0 / PARTICLE_RADIUS_SQRD             '' inverse radius squared
Const As Single  INV_PARTICLE_DIAMETER_SQRD = 1.0 / PARTICLE_DIAMETER_SQRD           '' 

Const As Single  REST_DISTANCE              = 25.0                                   ''
Const As Single  REST_DISTANCE_SQRD         = REST_DISTANCE * REST_DISTANCE          ''

Const As float   REST_DENSITY               = 10000.0                                ''   rest density
Const As float   color_density_Scale        = 255 / rest_density                     ''

Const As Integer block_wiDTh                = 100                                     ''
Const As Integer block_height               = 100                                     ''
Const As Integer numParticles_              = block_wiDTh * block_height             ''   number of particles
Const As Integer max_neighbors              = 48                                     ''   max number of neighbors per particles
Const As Integer max_num_neighbors          = numParticles_ * max_neighbors          ''   global max number of neighbors

Const As Integer screen_wid                 = 800                                   ''   screen wiDTh
Const As Integer screen_hgt                 = 800                                    ''   screen height

Const As Integer CELL_DIAMETER              = CInt(2.0 * PARTICLE_RADIUS)            ''   cell diameter
Const As Integer MAX_CELL_PARTICLES         = 48                                     ''   max number of particles held by one cell
Const As Integer num_cells_row              = CInt(screen_wid / CELL_DIAMETER)       ''   number of cells per row / on x axis
Const As Integer num_cells_col              = CInt(screen_hgt / CELL_DIAMETER )      ''   number of cells per column / on y axis
Const As Integer num_cells                  = num_cells_row * num_cells_col          ''
Const As Integer cell_wid                   = CInt(screen_wid / num_cells_row)       ''
Const As Integer cell_hgt                   = CInt(screen_hgt / num_cells_col)       ''
Const As Single  inv_cell_wid               = 1.0 / cell_wid
Const As Single  inv_cell_hgt               = 1.0 / cell_hgt

Const As Integer  BORDER                    = 16                                     ''
Const As Integer  r_plus_BORDER             = PARTICLE_RADIUS + BORDER               ''
Const As Single  BORDER_STIFFNES            = 0.33                                   ''
Const As Single  BORDER_DAMPING             = 0.33                                   ''

Const As Single  INTERACTION_RADIUS         = 32                                     ''
Const As Single  int_radius_sqrd            = INTERACTION_RADIUS^2                   ''

''
Type ParticleType

  Public:

  As Vec2f  position_
  As Vec2f  prevPosition_
  As Vec2f  velocity_
  As Vec2f  force_
  As Single density_

End Type

''
Type NeighborType

  Public:

  As Single           density_
  As Single           distanceSquared_
  As vec2f            nOverDistance_
  As ParticleType Ptr particleA_
  As ParticleType Ptr particleB_

End Type

''
Type CellType

  Public:

  As Integer          numParticles_
  As Integer          numCellNeighbors
  As ParticleType Ptr Particles(1 To MAX_CELL_PARTICLES)
  As CellType Ptr     CellNeighbor(1 To 4)

End Type

''
Type FluidType

  Public:

  As Integer numParticles_

  As Single  restDensity_
  As Single  restDistance_


End Type

''
Type ScreenType

  Declare Sub CreateScreen(w As Integer, h As Integer, r As Integer, g As Integer, _
  b As Integer, a As Integer, d As Integer, s As Integer, m As Integer)

  Declare Sub DeleteScreen()

  As Integer wid
  As Integer Hgt
  As Integer Bpp

End Type

''
Type MouseType
  As vec2i Psn
  As vec2i Psn_Old
  As vec2f velocity_
  As Integer Btn
  As Integer Btn_Old
  As Integer Whl
  As Integer Whl_Old

  Declare Sub Update()

End Type


Dim Shared As ScreenType Scr
Dim Shared As MouseType Mouse

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

Declare Sub Check_if_neighbor(ByVal A As ParticleType Ptr, ByVal B As ParticleType Ptr)

Dim Shared As CellType cell(1 To num_cells_row, 1 To num_cells_col)
Dim Shared As ParticleType particle(1 To numParticles_)
Dim Shared As NeighborType Neighbor(1 To max_num_neighbors)

Dim Shared As Integer num_neighbors

Dim Shared As ParticleType Ptr Lo = @Particle(1)
Dim Shared As ParticleType Ptr Hi = @Particle(numParticles_)

Dim Shared As Integer num_particles_in_cell
Dim Shared As Integer num_particle_neighbors

''   run simulation
initiate_simulation()
Scr.CreateScreen(screen_wid, screen_hgt, 8, 8, 8, 8, 0, 0, 0)
run_simulation()
Scr.DeleteScreen

End


Sub run_simulation()

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

End Sub

Sub initiate_simulation()

  ''  dereference cell neighbor pointers
  For x As Integer = 1 To num_cells_row
    For y As Integer = 1 To num_cells_col

      With Cell(x, y)

        .numCellNeighbors = 0

        ''  cell(x, y) - cell(x+1, y)
        If x < num_cells_row Then
          .numCellNeighbors += 1
          .CellNeighbor(.numCellNeighbors) = @Cell(x + 1, y)
        EndIf

        ''  cell(x, y) - cell(x, y+1)
        If y < num_cells_col Then
          .numCellNeighbors += 1
          .CellNeighbor(.numCellNeighbors) = @Cell(x, y + 1)
        EndIf
        '
        ''  cell(x, y) - cell(x+1, y+1)
        If x < num_cells_row And y < num_cells_col Then
          .numCellNeighbors += 1
          .CellNeighbor(.numCellNeighbors) = @Cell(x + 1, y + 1)
        EndIf

        ''  cell(x, y) - cell(x-1, y+1)
        If x > 1 And y < num_cells_col Then
          .numCellNeighbors += 1
          .CellNeighbor(.numCellNeighbors) = @Cell(x - 1, y + 1)
        EndIf

      End With

    Next
  Next


  Randomize Timer

  Dim As Integer n = 0

  ''   place particles
  For x As Integer = 1 To block_wiDTh
    For y As Integer = 1 To block_height

      n += 1

      With Particle(n)

        .position_.x = BORDER + PARTICLE_RADIUS + 10 * 0.5 + x * PARTICLE_RADIUS * 0.5
        .position_.y = screen_hgt - BORDER - PARTICLE_RADIUS - 10 * 0.5 - y * PARTICLE_RADIUS * 0.5

        '.velocity_.x += (Rnd-Rnd) * 10.0
        '.velocity_.y += (Rnd-Rnd) * 10.0

        '.position_.x += (Rnd-Rnd) * 0.01
        '.position_.y += (Rnd-Rnd) * 0.01

        .prevPosition_.x = .position_.x
        .prevPosition_.y = .position_.y

      End With
    Next
  Next

End Sub

Sub broad_phase_collision()
	
	''
	For P As ParticleType Ptr = Lo To Hi
		
		Dim As Integer cell_col = P->position_.y * inv_cell_hgt
		
		If ( cell_col < 1 ) Or ( cell_col > num_cells_col ) Then Continue For
		
		Dim As Integer cell_row = P->position_.x * inv_cell_wid
		
		If ( cell_row < 1 ) Or ( cell_row > num_cells_row ) Then Continue For
		
		Dim As CellType Ptr C = @cell( cell_row, cell_col )
		
		If C->numParticles_ >= MAX_CELL_PARTICLES Then Continue For
		
		C->numParticles_ += 1
		
		C->Particles( C->numParticles_ ) = P
		
	Next

End Sub

Sub narrow_phase_collision()
	
	''   reset number of neighbors
	num_neighbors = 0
	
	' num_particles_in_cell = 0
	
	''   loop through all cells and their neighbors to find particles within interaction radius
	For x As Integer = 1 To num_cells_row
		
		For y As Integer = 1 To num_cells_col
			
			Dim As CellType Ptr C = @cell(x, y)
			
			If C->numParticles_ = 0 Then Continue For
			
			'If num_particles_in_cell < C->numParticles_ Then num_particles_in_cell = C->numParticles_
			
			'' cell(x, y) - self
			For i As Integer = 1 To C->numParticles_ - 1
				
				For j As Integer = i + 1 To C->numParticles_
				
					Check_if_neighbor(C->Particles(i), C->Particles(j))
				
				Next
				
			Next
				
				'' cell(x, y) - neighboring cells
			For i As Integer = 1 To C->numParticles_
					
				For j As Integer = 1 To C->numCellNeighbors
					
					For k_ As Integer = 1 To C->CellNeighbor(j)->numParticles_
						
						Check_if_neighbor(C->Particles(i), C->CellNeighbor(j)->Particles(k_))
						
					Next
				
				Next
			
			Next
			
		Next
	Next

End Sub

Sub reset_cells()
	
	For x As Integer = 1 To num_cells_row
			
		For y As Integer = 1 To num_cells_col
				
			cell(x, y).numParticles_ = 0
			
		Next
		
	Next

End Sub

Sub reset_particles()
	
	For P As ParticleType Ptr = Lo To Hi
		
		P->density_ = 1.0
		
		P->force_ = Vec2f(0.0f, G)
		
	Next

End Sub

Sub calculate_internal_force()
	
	For N As NeighborType Ptr = @neighbor(1) To @neighbor(num_neighbors)
		
		''   velocity vector projected onto distance vector
		Dim As Single velocity_ = ( N->particleA_->velocity_ - N->particleB_->velocity_ ).dot( N->nOverDistance_ )
		
		If N->distanceSquared_ > ZERO Then
			
			''   force vector
			Dim As Vec2f force = N->nOverDistance_ * ( _  
			N->density_                                                             *   50.0 -  _  ''  
			( REST_DENSITY - ( N->particleA_->density_ + N->particleB_->density_) ) *    4.0 +  _  ''  
			velocity_                                                               *  100.0    )  ''  
			
			''   apply opposite equal forces
			N->particleA_->force_ -= force
			N->particleB_->force_ += force
			
		End If
		
	Next

End Sub

Sub screen_border_force()
	
	For P As ParticleType Ptr = Lo To Hi
		
		If P->position_.x < r_plus_BORDER Then
		
			P->force_.x -= (P->position_.x - r_plus_BORDER) * INV_DT_SQRD * 0.33 + P->velocity_.x * INV_DT * 0.33
		
		EndIf
		
		If P->position_.x > ( screen_wid - r_plus_BORDER ) Then
		
			P->force_.x -= ( P->position_.x - ( screen_wid - r_plus_BORDER )) * INV_DT_SQRD * 0.33 + P->velocity_.x * INV_DT * 0.33
		
		EndIf
		
		If P->position_.y < r_plus_BORDER Then
		
			P->force_.y -= (P->position_.y - r_plus_BORDER) * INV_DT_SQRD * 0.33 + P->velocity_.y * INV_DT * 0.33
		
		EndIf
		
		If P->position_.y > ( screen_hgt - r_plus_BORDER ) Then
		
			P->force_.y -= (P->position_.y - (screen_hgt - r_plus_BORDER)) * INV_DT_SQRD * 0.33 + P->velocity_.y * INV_DT * 0.33
		
		EndIf
		
	Next

End Sub

Sub Integrate()
	
	''   symplectic Euler
	For P As ParticleType Ptr = Lo To Hi
		P->velocity_ += P->force_    * DT
		P->prevPosition_ = P->position_
		P->position_ += P->velocity_ * DT
	Next
	
	''   verlet
	'For P As ParticleType Ptr = Lo To Hi
	'  Dim As vec2f temp = P->position_
	'  P->position_ += P->position_ - P->prevPosition_ + P->force_ * DT_SQRD
	'  P->prevPosition_ = temp
	'  P->velocity_ = (P->position_ - P->prevPosition_) * INV_DT
	'Next

End Sub

Sub draw_particles()
	
	ScreenLock
		
		'Cls
		Line(0, 0)-(screen_wid, screen_hgt), RGBA(0, 0, 0, 24), bf
		
		''
		'For N As NeighborType Ptr = @neighbor(1) To @neighbor(num_neighbors)
		'	
		'	Line(N->particleA_->position_.x, N->particleA_->position_.y)-(N->particleB_->position_.x,N->particleB_->position_.y), RGBA(255, 255, 255, 16)
		'	
		'Next
		
		For P As ParticleType Ptr = Lo To Hi
			
			Dim As float col_r = P->density_ * color_density_Scale
			Dim As float col_g
			Dim As float col_b
			
			If col_r > 255 Then
			
			col_g = col_r - 255
			
			col_r = 255
			
			EndIf
			
			col_b = 255 - col_r
			
			If col_g > 255 Then col_g = 255
			If col_b > 255 Then col_b = 255
			
			'Line(P->position_.x-1, P->position_.y-1)-(P->position_.x+1, P->position_.y+1), RGB(col_r, col_g, col_b), bf
			Line(P->prevPosition_.x, P->prevPosition_.y)-(P->position_.x, P->position_.y), RGB(col_r, col_g, col_b)
			
		Next
	
	ScreenUnLock

End Sub


Sub Check_if_neighbor(ByVal A As ParticleType Ptr, ByVal B As ParticleType Ptr)

  If num_neighbors = max_num_neighbors Then Exit Sub

  Dim As vec2f distance_vector = B->position_ - A->position_

  If Abs( distance_vector.x ) > PARTICLE_DIAMETER Then Exit Sub
  If Abs( distance_vector.y ) > PARTICLE_DIAMETER Then Exit Sub

  Dim As Single distance_squared = distance_vector.magnitudesquared()

  If ( distance_squared > PARTICLE_DIAMETER_SQRD ) Then Exit Sub

  '' create neighbor
  num_neighbors += 1

  Dim As NeighborType Ptr N = @neighbor(num_neighbors)

  N->particleA_ = A
  N->particleB_ = B

  N->distanceSquared_ = distance_squared

  N->density_  =  REST_DISTANCE_SQRD - distance_squared

  If distance_squared > ZERO Then
    N->nOverDistance_ = distance_vector / distance_squared
  Else
    N->nOverDistance_ = distance_vector
    'N->nOverDistance_ = vec2f()
  End If

  ''  add density_ to particles
  A->density_ += N->density_
  B->density_ += N->density_

End Sub

Sub ScreenType.CreateScreen(w As Integer, h As Integer, r As Integer, g As Integer, _
  b As Integer, a As Integer, d As Integer, s As Integer, m As Integer)

  ScreenRes w, h, 24,, fb.GFX_ALPHA_PRIMITIVES

  'Color RGB(0, 0, 0), RGB(255, 255, 255)
  Color RGB(255, 255, 255), RGB(0, 0, 0)

End Sub

Sub ScreenType.DeleteScreen()

End Sub

Sub MouseType.Update

  ''
  Psn_Old = Psn
  Btn_Old = Btn
  Whl_Old = Whl

  ''
  GetMouse Psn.x, Psn.y, Whl, Btn

  ''
  velocity_.x = (Psn.x-Psn_Old.x) * INV_DT
  velocity_.y = (Psn.y-Psn_Old.y) * INV_DT

  If (Btn = 1) Then

    For i As Integer = 1 To numParticles_

      Dim As vec2f dst = Particle(i).position_ - Psn

      If Abs(dst.x) > INTERACTION_RADIUS Then Continue For
      If Abs(dst.y) > INTERACTION_RADIUS Then Continue For

      Dim As float dst_Sqrd = dst.x*dst.x+dst.y*dst.y

      If dst_Sqrd > int_radius_sqrd Then Continue For

      If velocity_.x <> 0.0 Then Particle(i).force_.x -= ( (Particle(i).velocity_.x - velocity_.x) * INV_DT ) * ( 1 - dst_Sqrd / int_radius_sqrd ) * 0.2
      If velocity_.y <> 0.0 Then Particle(i).force_.y -= ( (Particle(i).velocity_.y - velocity_.y) * INV_DT ) * ( 1 - dst_Sqrd / int_radius_sqrd ) * 0.2


    Next

  End If

  If whl > whl_old Then

    For i As Integer = 1 To numParticles_

      Dim As vec2f dst = Particle(i).position_ - Psn

      If Abs(dst.x) < 1 Then Continue For
      If Abs(dst.y) < 1 Then Continue For

      Dim As float dst_Sqrd = dst.x*dst.x+dst.y*dst.y

      Particle(i).force_.x +=  dst.y * ( 1 / dst_Sqrd ) * 300000
      Particle(i).force_.y -=  dst.x * ( 1 / dst_Sqrd ) * 300000

    Next

  EndIf

  If whl < whl_old Then

    For i As Integer = 1 To numParticles_

      Dim As vec2f dst = Particle(i).position_ - Psn

      If Abs(dst.x) < 1 Then Continue For
      If Abs(dst.y) < 1 Then Continue For

      Dim As float dst_Sqrd = dst.x*dst.x+dst.y*dst.y

      Particle(i).force_.x -=  dst.y * ( 1 / dst_Sqrd ) * 300000
      Particle(i).force_.y +=  dst.x * ( 1 / dst_Sqrd ) * 300000

    Next

  EndIf

End Sub
