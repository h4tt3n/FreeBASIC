''*******************************************************************************
''  Smoothed Particle Hydrodynamics (SPH) fluid Simulation
''
''  Version 12, march 2012
''  Mike "h4tt3n", micha3l_niss3n@yahoo.dk
''
''  Description:
''
''  very fast, square root free SPH simulation
''
''  Controls:
''
''  press left mouse button to stir fluid
''  roll mouse wheel up / down to create current eddies
''  press escape key to exit
''
''  Reference:
''
''  http://image.diku.dk/projects/media/kelager.06.pdf
''  http://www8.cs.umu.se/kurser/5DV058/VT10/lectures/Lecture8.pdf
''  http://www.cs.clemson.edu/~bpelfre/sph_tutorial.pdf
''  http://graphics.stanford.edu/projects/lgl/papers/apkg-aspf-sig07/apkg-aspf-sig07.pdf
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
Const As Integer TRUE               = -1                           ''   boolean true
Const As Integer FALSE              = Not TRUE                     ''   boolean false
Const As Single  dt                 = 0.01                       ''
Const As Single  dt_Sqrd            = dt * dt                      ''
Const As Single  inv_dt             = 1.0 / dt                       ''
Const As Single  inv_dt_sqrd        = 1.0 / dt_Sqrd                     ''
Const As Single  half_dt            = 0.5 * dt                     ''

Const As Single  half_dt_Sqrd       = 0.5 * dt_Sqrd                    ''
Const As Single  G                  = 400.0                          ''
Const As Single  zero               = 0.5                            ''   min Single value
Const As Single  pi                 = 4*Atn(1)                     ''   pi



Const As Single  r                  = 15.0                           ''   particle interaction radius
Const As Single  r2                 = r * 2.0                           ''   particle interaction radius
Const As Single  inv_r              = 1.0 / r                        ''   particle interaction radius
Const As Single  r_sqrd             = r * r                        ''  radius squared
Const As Single  r2_sqrd            = r2 * r2                        ''  radius squared
Const As Single  r2_cubed           = r2 * r2 * r2                      ''  radius cubed
Const As Single  inv_r_sqrd         = 1.0 / r_sqrd                   ''  inverse radius squared
Const As Single  inv_r2_sqrd        = 1.0 / r2_sqrd                   ''  inverse radius squared
Const As Single  inv_r2_cubed       = 1.0 / r2_cubed                   ''  inverse radius squared


Const As Single  rest_r					= 20 '29.0
Const As Single  rest_r_sqrd		   = rest_r * rest_r


Const As float   rest_density       = 20.0 '25.0                         ''   rest density
Const As Integer color_density_Scale  = 255 / rest_density


Const As Integer block_width        = 50                          ''
Const As Integer block_height       = 50                          ''
Const As Integer NumParticles       = block_width * block_height     ''   number of particles
Const As Integer max_neighbors      = 32                           ''   max number of neighbors per particles
Const As Integer max_num_neighbors  = NumParticles * max_neighbors   ''   global max number of neighbors

Const As Integer screen_wid         = 800                         ''   screen width
Const As Integer screen_hgt         = 800                          ''   screen height

Const As Integer cell_dia           = CInt(2.0 * r)                            ''   cell diameter
Const As Integer max_cell_particles = 64                           ''   max number of particles held by one cell
Const As Integer num_cells_row      = CInt(screen_wid / cell_dia)          ''   number of cells per row / on x axis
Const As Integer num_cells_col      = CInt(screen_hgt / cell_dia )         ''   number of cells per column / on y axis
Const As Integer num_cells          = num_cells_row * num_cells_col  ''
Const As Integer  cell_wid          = CInt(screen_wid / num_cells_row)   ''
Const As Integer  cell_hgt          = CInt(screen_hgt / num_cells_col)   ''
Const As Single  inv_cell_wid       = 1.0 / cell_wid
Const As Single  inv_cell_hgt       = 1.0 / cell_hgt

Const As Integer  border            = 2 * r                            ''
Const As Integer  r_plus_border     = r + border                   ''
Const As Single  border_k           = 0                         ''
Const As Single  border_d           = 0                            ''

Const As Single  interaction_radius = 32                           ''
Const As Single  int_radius_sqrd    = interaction_radius^2         ''

''
Type ParticleType
  As Vec2f psn
  As Vec2f psn_old
  As Vec2f vel
  As Vec2f frc
  As Single density

End Type

''
Type NeighborType
  As ParticleType Ptr A
  As ParticleType Ptr B
  As Single density
  As Single distance_squared
  As vec2f n_over_distance
End Type

''
Type CellType
  As Integer NumParticles
  As Integer numCellNeighbors
  As ParticleType Ptr P(1 To max_cell_particles)
  As CellType Ptr CellNeighbor(1 To 4)
End Type

''
Type ScreenType

  Declare Function CreateScreen(w As Integer, h As Integer, r As Integer, g As Integer, _
  b As Integer, a As Integer, d As Integer, s As Integer, m As Integer) As Integer
  Declare Function DeleteScreen() As Integer

  As Integer wid
  As Integer Hgt
  As Integer Bpp

End Type

''
Type MouseType
  As vec2i Psn
  As vec2i Psn_Old
  As vec2f vel
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

Declare sub Check_if_neighbor(ByVal A As ParticleType Ptr, ByVal B As ParticleType Ptr)

Dim Shared As CellType cell(1 To num_cells_row, 1 To num_cells_col)
Dim Shared As ParticleType particle(1 To NumParticles)
Dim Shared As NeighborType Neighbor(1 To max_num_neighbors)

Dim Shared As Integer num_neighbors

Dim Shared As ParticleType Ptr Lo = @Particle(1)
Dim Shared As ParticleType Ptr Hi = @Particle(NumParticles)

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
  For x As Integer = 1 To block_width
    For y As Integer = 1 To block_height

      n += 1

      With Particle(n)

        .psn.x = border + r + 1 * 0.5 + x * r * 0.7
        .psn.y = screen_hgt - border - r - 1 * 0.5 - y * r * 0.7
        
        '.vel.x += (Rnd-Rnd) * 10.0
        '.vel.y += (Rnd-Rnd) * 10.0

        .psn.x += (Rnd-Rnd) * 0.01
        .psn.y += (Rnd-Rnd) * 0.01
        
        .psn_old.x = .psn.x
        .psn_old.y = .psn.y

      End With
    Next
  Next

End Sub

Sub broad_phase_collision()

  ''
  For P As ParticleType Ptr = Lo To Hi
    
    Dim As Integer cell_col = P->Psn.y * inv_cell_hgt

    If (cell_col < 1) Or (cell_col > num_cells_col) Then Continue For

    Dim As Integer cell_row = P->Psn.x * inv_cell_wid

    If (cell_row < 1) Or (cell_row > num_cells_row) Then Continue For
    
    Dim As CellType Ptr C = @cell(cell_row, cell_col)

    If C->NumParticles >= max_cell_particles Then Continue For

    C->NumParticles += 1
    C->P(C->NumParticles) = P
    
    'If cell(cell_row, cell_col).NumParticles >= max_cell_particles Then Continue For

    'cell(cell_row, cell_col).NumParticles += 1
    'cell(cell_row, cell_col).P(cell(cell_row, cell_col).NumParticles) = P

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

      If C->NumParticles = 0 Then Continue For
      
      If num_particles_in_cell < C->NumParticles Then num_particles_in_cell = C->NumParticles

      '' cell(x, y) - self
      For i As Integer = 1 To C->NumParticles - 1

        For j As Integer = i + 1 To C->NumParticles

          Check_if_neighbor(C->p(i), C->p(j))

        Next

      Next

      '' cell(x, y) - neighboring cells
      For i As Integer = 1 To C->NumParticles

        For j As Integer = 1 To C->numCellNeighbors

          For k_ As Integer = 1 To C->CellNeighbor(j)->NumParticles

            Check_if_neighbor(C->P(i), C->CellNeighbor(j)->P(k_))

          Next

        Next

      Next

    Next
  Next

End Sub

Sub reset_cells()

  For x As Integer = 1 To num_cells_row
    For y As Integer = 1 To num_cells_col
      cell(x, y).NumParticles = 0
    Next
  Next

End Sub

Sub reset_particles()

  For P As ParticleType Ptr = Lo To Hi
    P->density = 1.0
    P->frc = Vec2f(0.0f, G)
  Next

End Sub

Sub calculate_internal_force()

  For N As NeighborType Ptr = @neighbor(1) To @neighbor(num_neighbors)
    
      ''   velocity vector projected onto distance vector
   'Dim As Single vel = ( N->A->vel - N->B->vel ).dot( N->n_over_distance )
   
   Dim As Vec2f vel  = N->A->vel - N->B->vel
   Dim As Vec2f dist = N->A->psn - N->B->psn
   
   Dim As Vec2f projected_vel = ( dist.dot(vel) / dist.dot(dist) ) * dist
   
    
   If N->distance_squared > zero Then

    ''   force vector
    'Dim As Vec2f F = N->n_over_distance * (F_pressure + F_viscosity)
    
    'Dim As Vec2f F = N->n_over_distance * ( _
    '							( rest_r_sqrd - N->distance_squared )                * 50.0   -  _	''	50    50
    '						   ( rest_density - ( N->A->density + N->B->density) )  * 2000.0 +  _	''	2000  4000
    '						 	  vel                                                * 30.0	)		   ''	30    50

    Dim As Vec2f F = N->n_over_distance * ( _
    							( N->distance_squared * N->distance_squared  )       * 0.01   -  _	''	50    50
    						   ( rest_density - ( N->A->density + N->B->density) )  * 0000.0 )' +  _	''	2000  4000
    						 	 ' vel                                                * 50.0	)		   ''	30    50
	
	F += projected_vel * N->n_over_distance * 10.0
	
    ''   apply opposite equal forces
    N->A->frc -= F
    N->B->frc += F
    
    End if

  Next

End Sub

Sub screen_border_force()

  For P As ParticleType Ptr = Lo To Hi

    If P->psn.x < r_plus_border Then 
    	
    	P->frc.x -= (P->psn.x - r_plus_border) * inv_dt_sqrd * 0.33 + P->vel.x * inv_dt * 0.33
    	
    EndIf
    
    If P->psn.x > ( screen_wid - r_plus_border ) Then 
    	
    	P->frc.x -= ( P->psn.x - ( screen_wid - r_plus_border )) * inv_dt_sqrd * 0.33 + P->vel.x * inv_dt * 0.33
    	
    EndIf

    If P->psn.y < r_plus_border Then 
    	
    	P->frc.y -= (P->psn.y - r_plus_border) * inv_dt_sqrd * 0.33 + P->vel.y * inv_dt * 0.33
    	
    EndIf
    
    If P->psn.y > ( screen_hgt - r_plus_border ) Then 
    	
    	P->frc.y -= (P->psn.y - (screen_hgt - r_plus_border)) * inv_dt_sqrd * 0.33 + P->vel.y * inv_dt * 0.33
    	
    EndIf

  Next

End Sub

Sub Integrate()

  ''   symplectic Euler
  For P As ParticleType Ptr = Lo To Hi
    P->vel += P->frc * dt
    P->psn += P->vel * dt
  Next

  ''   midpoint / leapfrog
  'For P As ParticleType Ptr = Lo To Hi
  '    P->vel += P->frc * half_dt
  '    P->psn += P->vel * dt + P->frc * half_dt_Sqrd
  '    P->vel += P->frc * half_dt
  'Next

  ''   verlet
  'For P As ParticleType Ptr = Lo To Hi
  '  Dim As vec2f temp = P->psn
  '  'P->psn = 2.0 * P->psn - P->psn_old + P->frc * dt_Sqrd
  '  P->psn += P->psn - P->psn_old + P->frc * dt_Sqrd
  '  P->psn_old = temp
  '  P->vel = (P->psn - P->psn_old) * inv_dt
  'Next

End Sub

Sub draw_particles()
   
   ScreenLock
   
   Cls
   
   For P As ParticleType Ptr = Lo To Hi
        
     Dim As UByte col_r = P->density * color_density_Scale
     Dim As UByte col_g 
     Dim As UByte col_b 
     
     If col_r > 255 Then 
     	
     	col_g = col_r - 255
     	
     	col_r = 255
     	
     EndIf
     
     col_b = 255 - col_r
     
     If col_g > 255 Then col_g = 255
     If col_b > 255 Then col_b = 255
     
     If col_r < 0 Then col_r = 0
     If col_g < 0 Then col_g = 0
     If col_b < 0 Then col_b = 0

		Line(P->psn.x-4, P->psn.y-4)-(P->psn.x+4, P->psn.y+4), RGB(col_r, col_g, col_b), bf
      'Circle(P->psn.x, P->psn.y), r, RGBA(col_r, col_g, col_b, 128),,, 1, f
      'Circle(P->psn.x, P->psn.y), r, RGBA(255, 255, 255, 16),,, 1, f
      'Circle(P->psn.x, P->psn.y), 2, RGB (255, 0, 0),,, 1, f
      'pset(P->psn.x, P->psn.y), RGB(Col, 0, 255 - col)
      'pset(.psn.x, .psn.y), RGB(0, 0, 0)
      
   Next
   
   'For P As ParticleType Ptr = Lo To Hi
   '     
   '  'Dim As float col = P->density * 25

   '   'Circle(P->psn.x, P->psn.y), 4, RGBA(col, 0.0, 255 - col, 64),,, 1, f
   '   'Line(P->psn.x-1, P->psn.y-1)-(P->psn.x+1, P->psn.y+1), RGB(col, 0, 255 - col), bf
   '   Line(P->psn.x-1, P->psn.y-1)-(P->psn.x+1, P->psn.y+1), RGB(255, 255, 255), bf
   '   'Circle(P->psn.x, P->psn.y), 2, RGB (255, 0, 0),,, 1, f
   '   'pset(P->psn.x, P->psn.y), RGB(Col, 0, 255 - col)
   '   'pset(.psn.x, .psn.y), RGB(0, 0, 0)
   '   
   'Next
   
   Locate 2, 2: Print num_particles_in_cell
   'Locate 3, 2: Print cell_hgt
   
   ScreenUnLock
   
End Sub


Sub Check_if_neighbor(ByVal A As ParticleType Ptr, ByVal B As ParticleType Ptr)
  
  If num_neighbors = max_num_neighbors Then Exit Sub

  Dim As vec2f distance_vector = B->psn - A->psn

  If Abs(distance_vector.x) > r2 Then Exit Sub
  If Abs(distance_vector.y) > r2 Then Exit Sub

  'Dim As Single distance_squared = distance_vector.magnitudesquared()
  Dim As Single distance_squared = distance_vector.x * distance_vector.x + distance_vector.y * distance_vector.y
  'Dim As Single distance_cubed = distance_vector.x * distance_vector.x * distance_vector.x + distance_vector.y * distance_vector.y * distance_vector.y

  If (distance_squared > r2_sqrd) Then Exit Sub

  ''  density kernel W(Xij, r) = ( 1 - Xij^2 / r^2 )
  Dim As Single density = 1.0 - distance_squared * inv_r2_sqrd
  'Dim As Single density = 1.0 - distance_cubed * inv_r2_cubed

  '' create neighbor
  num_neighbors += 1
  
  Dim As NeighborType Ptr N = @neighbor(num_neighbors)
  
  N->a = A
  N->b = B
  
  N->distance_squared = distance_squared
  
  N->density = density

  If distance_squared > zero Then
    N->n_over_distance = distance_vector / distance_squared
  Else
    N->n_over_distance = vec2f(0,0)
  End If
  
  ''  add density to particles
  A->density += density
  B->density += density

End Sub

Function ScreenType.CreateScreen(w As Integer, h As Integer, r As Integer, g As Integer, _
   b As Integer, a As Integer, d As Integer, s As Integer, m As Integer) As Integer
   
   ScreenRes w, h, 24,, fb.GFX_ALPHA_PRIMITIVES
   
   'Color RGB(0, 0, 0), RGB(255, 255, 255)
   Color RGB(255, 255, 255), RGB(0, 0, 0)
   
   Return TRUE
   
End Function

Function ScreenType.DeleteScreen() As Integer
  
   Return TRUE
   
End Function

Sub MouseType.Update
   
   ''
   Psn_Old = Psn
   Btn_Old = Btn
   Whl_Old = Whl
   
   ''
   GetMouse Psn.x, Psn.y, Whl, Btn
   
   ''
   vel.x = (psn.x-psn_old.x) * inv_dt
   vel.y = (psn.y-psn_old.y) * inv_dt
   
   If (Btn = 1) Then
     
     For i as Integer = 1 to numparticles
      
       Dim As vec2f dst = Particle(i).psn - psn
       
       If Abs(dst.x) > interaction_radius then continue for
       If Abs(dst.y) > interaction_radius then continue For
       
       Dim As float dst_Sqrd = dst.x*dst.x+dst.y*dst.y
       
       If dst_Sqrd > int_radius_sqrd then continue For
       
       If vel.x <> 0.0 Then Particle(i).frc.x -= ( (Particle(i).vel.x - vel.x) * inv_dt ) * ( 1 - dst_Sqrd / int_radius_sqrd ) * 0.2
       If vel.y <> 0.0 Then Particle(i).frc.y -= ( (Particle(i).vel.y - vel.y) * inv_dt ) * ( 1 - dst_Sqrd / int_radius_sqrd ) * 0.2
       

     Next
     
   End If
   
   If whl > whl_old Then
     
     For i as Integer = 1 to numparticles
    
       Dim As vec2f dst = Particle(i).psn - psn
       
       If Abs(dst.x) < 1 then continue for
       If Abs(dst.y) < 1 then continue For
       
       Dim As float dst_Sqrd = dst.x*dst.x+dst.y*dst.y
       
       Particle(i).frc.x +=  dst.y * ( 1 / dst_Sqrd ) * 300000
       Particle(i).frc.y -=  dst.x * ( 1 / dst_Sqrd ) * 300000
        
     Next
     
   EndIf
   
   If whl < whl_old Then
     
     For i as Integer = 1 to numparticles
    
       Dim As vec2f dst = Particle(i).psn - psn
       
       If Abs(dst.x) < 1 then continue for
       If Abs(dst.y) < 1 then continue For
       
       Dim As float dst_Sqrd = dst.x*dst.x+dst.y*dst.y
       
       Particle(i).frc.x -=  dst.y * ( 1 / dst_Sqrd ) * 300000
       Particle(i).frc.y +=  dst.x * ( 1 / dst_Sqrd ) * 300000
        
     Next
     
   EndIf
   
End Sub
