''*******************************************************************************
''
''   FreeBASIC Controls Class
''   Written in FreeBASIC 1.05
''   Version 0.1.0, October 2015, Michael "h4tt3n" Nissen
''
''
''*******************************************************************************


''
#Ifndef __G2_JOYSTICK_BI__
#Define __G2_JOYSTICK_BI__


''
Type Joystick
	
	Public:
	
	''
	Declare Constructor()
	Declare Constructor( ByRef J As Joystick )
	
	''
	Declare Operator Let( ByRef J As Joystick )
	
	'' Get
	Declare Const Function Button( ByVal b As Integer ) As Boolean
	Declare Const Function Id() As Integer
	Declare Const Function State() As Integer
	Declare Const Function Axis( ByVal a As Integer ) As Vec2
	
	'' Set
	Declare Sub Id( ByVal i As Integer )
	
	''
	Declare Function Update() As Boolean
	
	Private:
	
	Dim As Long Id_              '' Device number ( 0-15 ). Set by User.
	
	Dim As Integer State_        '' 1 on failure, 0 on success
	Dim As Integer Buttons_      '' 0-26
	
	Dim As Vec2 Axes_( 1 To 4 )  ''
	
End Type


''
Constructor Joystick()
	
	Id_      = 0
	State_   = 0
	Buttons_ = 0
	
	Erase Axes_
	
End Constructor

Constructor Joystick( ByRef J As Joystick )
	
	This = J
	
End Constructor


'' 
Operator Joystick.Let( ByRef J As Joystick )
	
	Id_      = J.Id_
	State_   = J.State_
	Buttons_ = J.Buttons_
	
End Operator


'' Get
Function Joystick.Button( ByVal b As Integer ) As Boolean
	
	Return IIf( Buttons_ And ( 1 Shl b ) , TRUE , FALSE )
	
End Function

Function Joystick.Id() As Integer
	
	Return Id_
	
End Function

Function Joystick.State() As Integer
	
	Return State_
	
End Function
	
Function Joystick.Axis( ByVal a As Integer ) As Vec2
	
	Return Axes_(a)
	
End Function


'' Set
Sub Joystick.Id( ByVal i As Integer )
	
	Id_ = i
	
End Sub


''
Function Joystick.Update() As Boolean
	
	State_ = GetJoystick( Id_, Buttons_, _
	                      Axes_(1).x, Axes_(1).y, _
	                      Axes_(2).x, Axes_(2).y, _
	                      Axes_(3).x, Axes_(3).y, _
	                      Axes_(4).x, Axes_(4).y )
	
	Return State_
	
End Function


''
#Endif __G2_JOYSTICK_BI__
