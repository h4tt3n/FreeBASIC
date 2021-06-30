'' https://www.freebasic.net/forum/viewtopic.php?f=18&t=27764&start=15

#ifdef __FB_LINUX__
const DEVICE_COM = "/dev/ttyACM0"
#else
const DEVICE_COM = "COM4"
#endif

const DEVICE_FILE_NO = 1

const KEYBOARD_ESCAPE = chr(27)
const KEYBOARD_EOL = chr(13)
const KEYBOARD_BACKSPACE = chr(8)

#if defined(__FB_DOS__) or defined(__FB_WIN32__)
   const TERMINAL_EOL = chr(13, 10)
#else
   const TERMINAL_EOL = chr(10)
#endif

const DEVICE_EOL = chr(10)

const COLOR_KEYBOARD = 7
const COLOR_TERMINAL = 12
const COLOR_OUTPUT   = 10
const COLOR_INPUT    = 13

const MAX_BUFFER = 40

dim shared code(0 to 31) as zstring * 4 = _
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

sub terminal_write_string( byval clr as integer, byref s as const string )
   static last_ch as integer = 0
   color clr
   for i as integer = 1 to len(s)
      dim ch as integer = asc(mid(s,i,1))
      select case ch
      case 0 to 31
         if( last_ch = 13 and ch <> 10 ) then
            print
         end if
         print "<" & rtrim(code(ch)) & ">";
         if( ch = 10 ) then
            print
         end if
      case else
         if( last_ch = 13 ) then
            print
         end if
         print chr(ch);
      end select
      last_ch = ch
   next
   color 7
end sub

function keyboard_read_key() as string
   function = inkey
end function

function keyboard_read_string( byref buffer as string, byref k as string = "" ) as boolean

   '' no key? then get one
   if( k = "" ) then
      k = keyboard_read_key()
   end if

   select case k
   case KEYBOARD_BACKSPACE
      buffer = left( buffer, len(buffer) - 1 )
      terminal_write_string( COLOR_KEYBOARD, k )
   
   case KEYBOARD_EOL
      terminal_write_string( COLOR_KEYBOARD, KEYBOARD_EOL )
      return true

   case else
      if( len(buffer) < MAX_BUFFER ) then
         buffer += k
         terminal_write_string( COLOR_KEYBOARD, k )
      end if

   end select

   return false

end function

function arduino_open() as boolean
   dim s as string
   s = DEVICE_COM & ":9600,n,8,1,cs0,ds0,cd0,rs"
   function = not cbool( open com(s As #DEVICE_FILE_NO ) )
end function

sub arduino_close()
   close #DEVICE_FILE_NO
end sub

function arduino_read_byte() as string
   if loc(DEVICE_FILE_NO) > 0 THEN
      function = input( 1, #DEVICE_FILE_NO )
   end if
end function

function arduino_read_string( byref buffer as string ) as boolean
   dim r as string
   
   '' read any response from arduino
   do
      r = arduino_read_byte()
      select case r

      '' end of response/string?
      case DEVICE_EOL
         return true

      '' otherwise add to the buffer
      case else
         if( len( buffer ) < MAX_BUFFER ) then
            buffer &= r
         end if
      end select
   loop until r = ""

   return false
end function

sub arduino_write_string( byref s as string )
   print #DEVICE_FILE_NO, s;
end sub


'' ----------------
'' MAIN
'' ----------------

if arduino_open() = false then
   print "error connecting to arduino"
   end 1
end if

const COLOR_KEYBOARD = 7
const COLOR_TERMINAL = 12
const COLOR_INPUT    = 13
const COLOR_OUTPUT   = 10

terminal_write_string( COLOR_KEYBOARD, "keyboard" & KEYBOARD_EOL )
terminal_write_string( COLOR_TERMINAL, "terminal" & TERMINAL_EOL )
terminal_write_string( COLOR_OUTPUT, "output" & DEVICE_EOL )
terminal_write_string( COLOR_INPUT, "input" & DEVICE_EOL )

terminal_write_string( COLOR_TERMINAL, "connected" & TERMINAL_EOL )

dim as string k, cmd_buffer
dim as string r, dev_buffer

do
   k = keyboard_read_key()

   if( k = KEYBOARD_ESCAPE ) then
      exit do
   end if

   '' read keyboard in to cmd_buffer, and then write it
   '' to the device when we have a full command
   if( keyboard_read_string( cmd_buffer, k ) ) then
      terminal_write_string( COLOR_OUTPUT, cmd_buffer & DEVICE_EOL )
      arduino_write_string( cmd_buffer & DEVICE_EOL )

      '' done with command buffer, so clear it
      cmd_buffer = ""
   end if
   
   '' read from the device and print the results only when
   '' we have the full response
   if( arduino_read_string( dev_buffer) ) then
      terminal_write_string( COLOR_INPUT, dev_buffer & DEVICE_EOL )
   
      '' done with the response buffer, so clear it
      dev_buffer = ""
   end if

   sleep 20

loop

arduino_close()

terminal_write_string( COLOR_TERMINAL, "disconnected" & TERMINAL_EOL )