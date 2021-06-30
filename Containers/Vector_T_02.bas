''bluatigro
''trying to create a templated vector class
''as exsist in c++ stl
''20 okt 2015 : first try

#define T integer

type vector
private :
  dim as T ptr q_
  dim as integer size_
public :
  declare constructor
  declare destructor
  declare sub push_back( byval in as T )
  declare function size() as integer
  declare function at( byval i as integer ) as T
  declare function find( byval in as T ) as integer
end type
constructor vector
  q_ = 0
  size_ = 0
end constructor
destructor vector
  deallocate( q_ )
  q_ = 0
  size_ = 0
end destructor
sub vector.push_back( byval in as T )
  size_ += 1
  q_ = reallocate( q_, size_ * sizeof( T ) )
  q_[ size_-1 ] = in
end sub
function vector.size() as integer
  return size_
end function
function vector.at( byval i as integer ) as T
  if i < 0 or i > size_-1 then return 0
  return q_[ i ]
end function
function vector.find( byval in as T ) as integer
  dim as integer i = 0
  while i < size_ andalso q_[ i ] <> in
    i += 1
  wend
  if i = size_ then return -1
  return i
end function

dim as vector v
v.push_back(11)
v.push_back(22)
v.push_back(33)
print v.size()
print
print v.at(0)
print v.at(1)
print v.at(2)
print
print v.find(00)
print v.find(11)
print v.find(22)
print v.find(33)
print v.find(44)

sleep
 