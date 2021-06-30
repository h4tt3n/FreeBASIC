
#Include "Squishy2D.bi"


''
Dim As World ThisWorld


ThisWorld.PointMasses.Reserve( 100 )

For i As Integer = 0 To 99
	
	ThisWorld.PointMasses.push_back( PointMass( i ) )
	
Next

Dim As PointMassArray PointMasses1

PointMasses1 = ThisWorld.PointMasses

Dim As PointMassArray PointMasses2 = PointMassArray( PointMasses1 )

Print ThisWorld.PointMasses.Size()
Print ThisWorld.PointMasses.Capacity()

Print PointMasses1.Size()
Print PointMasses1.Capacity()

Print PointMasses2.Size()
Print PointMasses2.Capacity()

For i As pointmass Ptr = PointMasses2.Front To PointMasses2.Back
	
	'Print ThisWorld.PointMasses.Index[i].getMass()
	'Print PointMasses1.Index[i].getMass()
	Print i->getMass()
	
Next


Sleep