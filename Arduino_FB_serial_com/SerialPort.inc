#define DEFAULT_BAUD_RATE 9600

type SerialPort
   private:
      file_no as long

   public:
      declare constructor()
      declare destructor()
      declare function getFbFileNo() as long
      declare operator cast() as boolean
      declare sub open( byref port as const string, byval baud as const uinteger = DEFAULT_BAUD_RATE )
      declare sub close()
      declare function available() as longint
      declare function read() as integer
      declare function write( byval value as const integer ) as integer
      declare function write( byref s as const string ) as integer
      declare function write( byval buffer as const ubyte const ptr, byval length as const uinteger ) as integer
      declare function print( byref s as const string ) as integer
end type

private constructor SerialPort()
   file_no = 0
end constructor

private destructor SerialPort()
   this.close()
end destructor

private function SerialPort.getFbFileNo() as long
   return file_no
end function

private operator SerialPort.cast() as boolean
   return cbool( file_no <> 0 )
end operator

private sub SerialPort.open( byref port as const string, byval baud as const uinteger = DEFAULT_BAUD_RATE )
   dim h as long = freefile
   if( ..open com( port & ":" & baud & ",n,8,1,cs0,ds0,cd0,rs" as #h ) = 0 ) then
      if( file_no ) then
         ..close #file_no
      end if
      file_no = h
   end if
end sub

private sub SerialPort.close()
   if( file_no > 0 ) then
      ..close #file_no
      file_no = 0
   end if
end sub

private function SerialPort.available() as longint
   if( file_no > 0 ) then
      return loc( file_no )
   else
      return 0
   end if
end function

private function SerialPort.read() as integer
   if( file_no > 0 ) then
      if( loc( file_no ) > 0 ) then
         return asc( input( 1, #file_no ) )
      end if
   end if
   return -1
end function

private function SerialPort.write( byval value as const integer ) as integer
   if( file_no > 0 ) then
      if( put( #file_no, , cubyte(value) ) = 0 ) then
         return 1
      end if
   end if
   return 0
end function

private function SerialPort.write( byref s as const string ) as integer
   if( file_no > 0 ) then
      if( put( #file_no, , s ) = 0 ) then
         return len(s)
      end if
   end if
   return 0
end function

private function SerialPort.write( byval buffer as const ubyte const ptr, byval length as const uinteger ) as integer
   if( file_no > 0 ) then
      if( put( #file_no, , *buffer, length ) = 0 ) then
         return length
      end if
   end if
   return 0
end function

private function SerialPort.print( byref s as const string ) as integer
   return write( s )
end Function