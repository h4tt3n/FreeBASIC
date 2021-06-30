'' https://www.freebasic.net/forum/viewtopic.php?f=18&t=27764&start=30

#ifdef __FB_LINUX__
   const DEVICE_COM = "/dev/ttyACM0"
#else
   const DEVICE_COM = "COM5"
#endif
const DEVICE_FILE_NO = 1

/'
One Byte Serial Protocol

GENERAL I/O

   7 654 3210
   - --- ---- -------------------------
   0 100 mmmm general message (request)
   0 000 mmmm general message (false)
   0 001 mmmm general message (true)

   mmmm = message number (0 to 15)

ADDRESSABLE BIT I/O

   7 654 3210
   - --- ---- -----------------
   0 101 aaaa read bit request
   0 110 aaaa clear bit request
   0 111 aaaa set bit request

   0 010 aaaa status = false
   0 011 aaaa status = true

   aaaa = address (0 to 15)

RESERVED

   7 654 3210
   - --- ---- --------
   1 ddd dddd reserved

'/

function msgToString( byval msg as ubyte ) as string

   '' command is upper 4 bits
   dim cmd as ubyte = msg and &hf0

   '' address is lower 4 bits
   dim adr as ubyte = msg and &h0f

   select case cmd
   case &h00: function = "general NAK"
   case &h10: function = "general ACK"
   case &h20: function = "bit " & adr & " is false"
   case &h30: function = "bit " & adr & " is true"
   case &h40: function = "general msg #" & adr
   case &h50: function = "read bit " & adr
   case &h60: function = "clear bit " & adr
   case &h70: function = "set bit " & adr
   case else
      function = "reserved"
   end select

end function

'' show request on screen and send to device
sub request( byval msg as ubyte )

   '' show a human readable string for the command
   color 10
   print "command = " & hex(msg,2) & ", " & msgToString( msg )

   '' write to the device
   put #DEVICE_FILE_NO,,msg
end sub

'' show response on screen
sub response( byval msg as ubyte )

   '' show a human readable string for the command
   color 13
   print "response = " & hex(msg,2) & ", " & msgToString( msg )

end sub

'' ----------------
'' MAIN
'' ----------------

if( open com(DEVICE_COM & ":9600,n,8,1,cs0,ds0,cd0,rs" As #DEVICE_FILE_NO) <> 0 ) then
   print "error connecting to arduino"
   end 1
end if

print "press F1 for help, ESCAPE to exit"

do
   dim k as string = inkey

   select case k
   case chr(27) '' escape
      exit do
   case chr(&hff, &h3b) '' F1 - help
      color 7
      print "Commands:"
      print
      print "ESC          Exit program"
      print "0, 1, 2, 3   Read bit 0, 1, 2, 3   (buttons)"
      print "a, b, c, d   Set bit 4, 5, 6, 7    (LEDs)"
      print "A, B, C, D   Clear bit 4, 5, 6, 7  (LEDs)"
      print
   case "0": request( &h50 ) '' read bit 0
   case "1": request( &h51 ) '' read bit 1
   case "2": request( &h52 ) '' read bit 2
   case "3": request( &h53 ) '' read bit 3
   case "A": request( &h64 ) '' clear bit 4
   case "B": request( &h65 ) '' clear bit 5
   case "C": request( &h66 ) '' clear bit 6
   case "D": request( &h67 ) '' clear bit 7
   case "a": request( &h74 ) '' set bit 4
   case "b": request( &h75 ) '' set bit 5
   case "c": request( &h76 ) '' set bit 6
   case "d": request( &h77 ) '' set bit 7
   case is > ""
      color 7
      print "key = ";
      for i as integer = 1 to len(k)
         print hex(asc(k,i),2); " ";
      next
      print
   end select

   dim msg as ubyte = 0

   while( loc(DEVICE_FILE_NO) > 0 )
      get #DEVICE_FILE_NO,,msg
      response( msg )
   wend

   sleep 25

loop

close #DEVICE_FILE_NO
color 7