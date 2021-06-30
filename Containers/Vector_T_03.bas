''bluatigro
''trying to create a templated vector class
''as exsist in c++ stl
''20 okt 2015 : first try
''23 okt 2015 : try at [] operator

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
  declare function find( byval in as T ) as integer
  declare operator []( byval i as integer ) as integer
end Type

constructor vector
  q_ = 0
  size_ = 0
end Constructor

destructor vector
  deallocate( q_ )
  q_ = 0
  size_ = 0
end Destructor

sub vector.push_back( byval in as T )
  size_ += 1
  q_ = reallocate( q_, size_ * sizeof( T ) )
  q_[ size_-1 ] = in
end Sub

function vector.size() as integer
  return size_
end Function

function vector.find( byval in as T ) as integer
  dim as integer i = 0
  while i < size_ andalso q_[ i ] <> in
    i += 1
  wend
  if i = size_ then return -1
  return i
end Function

operator vector.[]( byval i as integer ) as T
  if i < 0 or i > size_-1 then return 0
  return q_[ i ]
end operator

dim as vector v
v.push_back(11)
v.push_back(22)
v.push_back(33)

print "size = " ; v.size()
print "v[ 0 ] = " ; v[ 0 ]
print "v[ 1 ] = " ; v[ 1 ]
print "v[ 2 ] = " ; v[ 2 ]
print "v.find( 00 ) = " ; v.find( 00 )
print "v.find( 11 ) = " ; v.find( 11 )
print "v.find( 22 ) = " ; v.find( 22 )
print "v.find( 33 ) = " ; v.find( 33 )
print "v.find( 44 ) = " ; v.find( 44 )

sleep

 