#define END_OF_MESSAGE_CHAR 10
#define MAX_MESSAGE_LENGTH 40

type MessageBuffer
   private:
      as ubyte msg_buffer(0 to MAX_MESSAGE_LENGTH) = { 0 }
      as ubyte msg_length = 0
      as short last_char = -1
   public:
      declare sub clear()
      declare function addChar( byval ch as short ) as boolean
      declare function backChar() as boolean
      declare function isComplete() as boolean
      declare function buffer() as ubyte ptr
      declare function length() as ubyte
      declare function text() as string
end type

private sub MessageBuffer.clear()
      msg_buffer(0) = 0
      msg_length = 0
      last_char = -1
end sub

private function MessageBuffer.addChar( byval ch as short ) as boolean

   '' invalid char? do nothing
   if( ch < 0 or ch > 255 ) then
      return false
   end if

   last_char = ch

   '' end of message char? we have a complete message
   if( ch = END_OF_MESSAGE_CHAR ) then
      return true
   end if

   '' have space in the buffer? add the char
   if( msg_length < MAX_MESSAGE_LENGTH ) then
      msg_buffer(msg_length) = ch
      msg_length += 1
      msg_buffer(msg_length) = 0
   end if

   return false

end function

private function MessageBuffer.backChar() as boolean
   if( msg_length > 0 ) then
      msg_length -= 1
      msg_buffer(msg_length) = 0
      last_char = -1
      return true
   end if
   return false
end function

private function MessageBuffer.isComplete() as boolean
   return (last_char = END_OF_MESSAGE_CHAR)
end function

private function MessageBuffer.buffer() as ubyte ptr
   return @msg_buffer(0)
end function

private function MessageBuffer.length() as ubyte
   return msg_length
end function

private function MessageBuffer.text() as string
   return *cast( zstring ptr, buffer() )
end Function