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
  declare sub push_back( in as T )
  declare function size() as integer
  declare function at( i as integer ) as T
  declare function find( in as T ) as integer
end type
constructor vector
  q_ = 0
  size_ = 0
end constructor
destructor vector
  q_ = 0
end destructor
sub vector.push_back( in as T )
  size_ += 1
  q_ = allocate( size_ * sizeof( T ) )
end sub
function vector.size() as integer
  return size_
end function
function vector.at( i as integer ) as T
  if i < 0 or i > size_ then return 0
  return q_( i )
end function
function vector.find( in as T ) as integer
  dim as integer i = 0
  while i <= size_ and q_( i ) <> in
    i += 1
  wend
  if i > size_ then return -1
  return i
end function
 