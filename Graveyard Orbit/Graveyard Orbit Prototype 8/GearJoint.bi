''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 2, september 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''  Gear Joint class
''
''*******************************************************************************

Type GearJointType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub ComputeRestImpulse()
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	
	As Single accumulated_impulse
	As Single gear_ratio
	As Single radius_a
	As Single radius_b
	As Single rest_impulse
	As Single rest_velocity
	As Single M
	
	As Single c_stiffness
	As Single c_damping
	As Single c_warmstart
	
	As AngularStateType Ptr body_a
	As AngularStateType Ptr body_b
	
End Type


''
Constructor GearJointType()

End Constructor

Destructor GearJointType()

End Destructor


''
Sub GearJointType.ComputeRestImpulse()
	
	'' State
	
	'' Error
	Dim As Single velocity_error = body_b->angular_velocity - body_a->angular_velocity
	
	'' Correction
	rest_impulse = -velocity_error
	
End Sub

Sub GearJointType.ApplyCorrectiveImpulse()
	
	Dim As Single current_impulse = body_b->angular_impulse - body_a->angular_impulse
	
	Dim As Single impulse_error = current_impulse - rest_impulse
	
	Dim As Single corrective_impulse = -impulse_error * M
	
	body_a->angular_impulse -= corrective_impulse * body_a->inv_inertia
	body_b->angular_impulse += corrective_impulse * body_b->inv_inertia
	
	accumulated_impulse += corrective_impulse
	
End Sub

Sub GearJointType.ApplyWarmStart()
	
	Dim As Single warmstart_impulse = c_warmstart * accumulated_impulse
	
	body_a->angular_impulse -= warmstart_impulse * body_a->inv_inertia
	body_b->angular_impulse += warmstart_impulse * body_b->inv_inertia
	
	accumulated_impulse = 0.0
	
End Sub