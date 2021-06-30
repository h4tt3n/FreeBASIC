const COLOR_KEYBOARD = 7
const COLOR_TERMINAL = 12
const COLOR_INPUT    = 13
const COLOR_OUTPUT   = 10

type TerminalDisplay
   private:
      last_ch as integer = 0

   public:
      declare operator cast() as boolean
      declare sub color( byval clr as integer )
      declare function write( byval value as const integer ) as integer
      declare function write( byref s as const string ) as integer
      declare function write( byval buffer as const ubyte const ptr, byval length as const uinteger ) as integer
      declare function print( byref s as const string ) as integer
end type

private sub TerminalDisplay.color( byval clr as integer )
   ..color clr
end sub

private function TerminalDisplay.write( byval value as const integer ) as integer
   dim s as string = chr(value)
   return write( strptr(s), len(s) )
end function

private function TerminalDisplay.write( byref s as const string ) as integer
   return write( strptr(s), len(s) )
end function

private function TerminalDisplay.write( byval buffer as const ubyte const ptr, byval length as const uinteger ) as integer

   static code(0 to 31) as zstring * 4 = _
       { _
         "NUL", "SOH", "STX", "ETX", _
         "EOT", "ENQ", "ACK", "BEL", _
         "BS ", "HT ", "LF ", "VT ", _
         "FF ", "CR ", "SO ", "SI ", _
         "DLE", "DC1", "DC2", "DC3", _
         "DC4", "NAK", "SYN", "ETB", _
         "CAN", "EM" , "SUB", "ESC", _
         "FS ", "GS ", "RS ", "US "  _
      }

   dim count as integer = 0

   for i as integer = 0 to length-1
      dim ch as integer = buffer[i]
      select case ch
      case 0 to 31
         if( last_ch = 13 and ch <> 10 ) then
            ..print
         end if
         ..print "<" & rtrim(code(ch)) & ">";
         if( ch = 10 ) then
            ..print
         end if
      case else
         if( last_ch = 13 ) then
            ..print
         end if
         ..print chr(ch);
         count += 1
      end select
      last_ch = ch
   next
   return count
end function

private function TerminalDisplay.print( byref s as const string ) as integer
   return write( strptr(s), len(s) )
end Function