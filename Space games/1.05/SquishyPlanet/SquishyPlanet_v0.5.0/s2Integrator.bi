''***************************************************************************
''
''   Squishy2D Integration Class
''   Written in FreeBASIC 1.04
''   Version 0.1.0, October 2015, Michael "h4tt3n" Nissen
''
''***************************************************************************


''
#Ifndef __S2_INTEGRATOR_BI__
#Define __S2_INTEGRATOR_BI__


''
Type Solver Extends Object
	
	''	Base object, only used for inheritance
	
	Declare Abstract Sub Solve( Byref P As ParticleArray )
	
End Type

Type ImpulseSolver Extends Solver
	
	'' Impulse based solver
	
	Declare Sub Solve( Byref P As ParticleArray )
	
End Type
 
Type Integrator
	
	Declare Sub Solve( Byref P As ParticleArray , _
                      ByRef F As Solver )
	
	As ImpulseSolver IM1
	
End Type


''
Sub ImpulseSolver.Solve( Byref P As ParticleArray )
	
	For I As Particle Ptr = P.front To P.back
		
		I->AddVelocity( I->Impulse )
		I->AddPosition( I->Velocity * DT )
		
		I->Impulse( Vec2( 0.0, 0.0 ) )
		
	Next
	
End Sub

Sub Integrator.Solve( Byref P As ParticleArray , _
                      ByRef F As Solver )
   
   F.Solve( P )
   
End Sub


#EndIf ''__S2_INTEGRATOR_BI__
