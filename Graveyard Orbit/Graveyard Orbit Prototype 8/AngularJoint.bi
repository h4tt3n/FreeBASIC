''*******************************************************************************
''
''  Steam and railway physics engine
''
''  Prototype version 2, september 2019
''
''  By Michael Schmidt Nissen aka. "h4tt3n", michaelschmidtnissen@gmail.com
''
''  
''  Anglar Joint class
''
''*******************************************************************************

Type AngularJointType
	
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub ComputeRestImpulse()
	Declare Sub ApplyCorrectiveImpulse()
	Declare Sub ApplyWarmStart()
	
	As Single accumulated_impulse
	As Single rest_angle
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
Constructor AngularJointType()
	
	accumulated_impulse = 0.0
	rest_angle          = 0.0
	rest_impulse        = 0.0
	rest_velocity       = 0.0
	M                   = 0.0
	
	c_stiffness = 0.0
	c_damping   = 0.0
	c_warmstart = 0.0
	
	body_a = 0
	body_b = 0
	
End Constructor

Destructor AngularJointType()

End Destructor


''
Sub AngularJointType.ComputeRestImpulse()
	
	'' State
	Dim As Single angle = body_b->angle - body_a->angle
	Dim As Single velocity = body_b->angular_velocity - body_a->angular_velocity
	
	'' error
	Dim As Single angle_error = angle - rest_angle
	Dim As Single velocity_error = velocity - rest_velocity
	
	'' Correction
	rest_impulse = -( c_stiffness * angle_error * inv_dt + c_damping * velocity_error )
	
End Sub

Sub AngularJointType.ApplyCorrectiveImpulse()
	
	Dim As Single current_impulse = body_b->angular_impulse - body_a->angular_impulse
	
	Dim As Single impulse_error = current_impulse - rest_impulse
	
	Dim As Single corrective_impulse = -impulse_error * M
	
	body_a->angular_impulse -= corrective_impulse * body_a->inv_inertia
	body_b->angular_impulse += corrective_impulse * body_b->inv_inertia
	
	accumulated_impulse += corrective_impulse
	
End Sub

Sub AngularJointType.ApplyWarmStart()
	
	Dim As Single warmstart_impulse = c_warmstart * accumulated_impulse
	
	body_a->angular_impulse -= warmstart_impulse * body_a->inv_inertia
	body_b->angular_impulse += warmstart_impulse * body_b->inv_inertia
	
	accumulated_impulse = 0.0
	
End Sub
	