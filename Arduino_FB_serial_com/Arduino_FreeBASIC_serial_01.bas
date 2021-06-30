'' https://www.freebasic.net/forum/viewtopic.php?f=18&t=27764

const DEVICE_COM = "COM4"
const DEVICE_FILE_NO = 1

const KEYBOARD_ESCAPE = chr(27)
const KEYBOARD_EOL = chr(13)

const TERMINAL_EOL = chr(13, 10)

const DEVICE_EOL = chr(10)

const COLOR_KEYBOARD = 7
const COLOR_TERMINAL = 12
const COLOR_OUTPUT   = 10
const COLOR_INPUT    = 13

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

function keyboard_read_key() as string
   function = inkey
end function

sub terminal_write_string( byval clr as integer, byref s as const string )
   static last_ch as integer = 0
   color clr
   for i as integer = 1 to len(s)
      dim ch as integer = asc(mid(s,i,1))
      select case ch
      case 0 to 31
         if( ch <> 10 and last_ch = 13 ) then
            print
         end if
         print "<" & rtrim(code(ch)) & ">";
         if( ch = 10 ) then
            print
         end if
      case else
         print chr(ch);
      end select
      last_ch = ch
   next
   color 7
end sub

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


terminal_write_string( COLOR_KEYBOARD, "keyboard" & TERMINAL_EOL )
terminal_write_string( COLOR_TERMINAL, "terminal" & TERMINAL_EOL )
terminal_write_string( COLOR_OUTPUT, "output" & TERMINAL_EOL )
terminal_write_string( COLOR_INPUT, "input" & TERMINAL_EOL )

terminal_write_string( COLOR_TERMINAL, TERMINAL_EOL )
terminal_write_string( COLOR_TERMINAL, TERMINAL_EOL )

terminal_write_string( COLOR_TERMINAL, "connected" & TERMINAL_EOL )


dim as string k, r

do
   k = keyboard_read_key()

   '' write keyboard input to terminal and arduino
   select case k
   case KEYBOARD_ESCAPE
      exit do
   case KEYBOARD_EOL
      terminal_write_string( COLOR_KEYBOARD, k )
      terminal_write_string( COLOR_TERMINAL, TERMINAL_EOL )
      terminal_write_string( COLOR_OUTPUT, DEVICE_EOL )
      arduino_write_string( DEVICE_EOL )
   case else
      terminal_write_string( COLOR_KEYBOARD, k )
      terminal_write_string( COLOR_TERMINAL, k )
      terminal_write_string( COLOR_OUTPUT, k )
      arduino_write_string( k )
   end select

   '' read any response from arduino
   do
      r = arduino_read_byte()
      terminal_write_string( COLOR_INPUT, r )
   loop until r = ""

   sleep 20

loop

arduino_close()

terminal_write_string( COLOR_TERMINAL, "disconnected" & TERMINAL_EOL )