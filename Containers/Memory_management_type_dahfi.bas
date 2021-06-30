
Type stackvars
  as integer            used = -1, ub
  As Single             expansion_coeff = 1.5
  declare function      expand as integer
 private:
  declare sub           preserve
End Type

Sub stackvars.preserve
  ub=used*expansion_coeff+1
End Sub

function stackvars.expand as integer
  used += 1:  If used=ub Then preserve: return ub
  return 0
End function

type mytype
  as single             a(any)
  as stackvars          sv
  declare sub           push(val as single)
end Type

sub mytype.push(val as single)
  if sv.expand then redim preserve a(sv.ub)
  a(sv.used) = val
end sub


dim as mytype a

a.push 1
a.push 0

for i as integer = 0 to a.sv.used
  ? a.a(i)
Next

Sleep
