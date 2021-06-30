'#include "crt/mem.bi"

#macro DEFINE_AUTO_ARRAY(_TYPE_)
type AUTO_ARRAY##_TYPE_
  declare destructor
  declare operator [](index as uinteger) byref as _TYPE_
  declare function count as uinteger
  private:
  declare sub grow
  as uinteger    m_reserved ' will grow by 1,2,4,8,16 ....
  as _TYPE_ ptr ptr m_items
  as uinteger    m_count
end type
destructor AUTO_ARRAY##_TYPE_
  if m_items then
    if m_reserved then
      for i as uinteger=0 to m_reserved-1
        if m_items[i] then deallocate m_items[i]
      next
    end if
   deallocate m_items
  end if
end destructor
operator AUTO_ARRAY##_TYPE_ .[](index as uinteger) byref as _TYPE_
  if index>=m_count then m_count = index + 1: grow
  return *cptr(_TYPE_ ptr,m_items[index])
end operator
sub AUTO_ARRAY##_TYPE_ .grow
  if m_count>m_reserved then
    dim as integer r = m_reserved
    if m_reserved=0 then m_reserved=1
    while m_reserved<m_count: m_reserved shl=1 : wend
    m_items=reallocate(m_items,sizeof(any ptr)*m_reserved)
    for index as uinteger = r to m_reserved - 1
      m_items[index]=callocate(sizeof(_TYPE_))
    next
  end if
end sub
function AUTO_ARRAY##_TYPE_ .count as uinteger
  return m_count
end function
#endmacro

#macro DIM_ARRAY(_TYPE_)
  DEFINE_AUTO_ARRAY(_TYPE_)
  dim as AUTO_ARRAY##_TYPE_
#endmacro

#macro DIM_SHARED_ARRAY(_TYPE_)
  DEFINE_AUTO_ARRAY(_TYPE_)
  dim shared as AUTO_ARRAY##_TYPE_
#endmacro

' simple test
DIM_ARRAY(SINGLE) Singles

Singles[0]=ATN(1)*4

for i as uinteger=0 to Singles.Count -1 
  print i,singles[i]
next
print

for i as SINGLE = 1 to 4
  Singles[i]=i
next

for i as uinteger=0 to Singles.Count -1 
  print i,singles[i]
next
print

type VECTOR
  declare operator cast as string 
  as single x,y,z
end type
type PVECTOR as VECTOR ptr

operator VECTOR .cast as string 
  return "" & x & "," & y & "," & z
end operator


dim as VECTOR a,b,c
b=type(1,2,3)
c=type(3,3,3)

DIM_ARRAY(VECTOR) Vectors
Vectors[0] = a
Vectors[1] = b
Vectors[5] = c

for i as uinteger=0 to Vectors.Count -1 
  print i,Vectors[i]
next
print

DIM_ARRAY(PVECTOR) pVectors
pVectors[0]=@a
pVectors[1]=@b
pVectors[5]=@c

for i as uinteger=0 to pVectors.Count-1 
  if pVectors[i] then print i,*pVectors[i]
next

Sleep