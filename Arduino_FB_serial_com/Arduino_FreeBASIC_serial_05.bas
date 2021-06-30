#ifdef __FB_LINUX__
   const DEVICE_COM = "/dev/ttyACM0"
#else
   const DEVICE_COM = "COM8"
#endif
const DEVICE_FILE_NO = 1

'' ----------------
'' MAIN
'' ----------------

if( open com(DEVICE_COM & ":9600,n,8,1,cs0,ds0,cd0,rs" for binary As #DEVICE_FILE_NO) <> 0 ) then
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
      print "t            show current time"
      print "w            write current time to arduino"
      print

   '' display current time? or write timecode to device?
   case "t", "w"
      dim as string aTime, sHour, sMinute, sSecond, sTimeCode
      aTime   = time
      sHour   = bin(val(mid(aTime,1,2)), 6)
      sMinute = bin(val(mid(aTime,4,2)), 6)
      sSecond = bin(val(mid(aTime,7,2)), 6)
      sTimeCode = sHour+sMinute+sSecond+chr(13)

      color 12
      print "Time     = "; aTime

      if( k = "w" ) then
         color 10
         print "TimeCode = "; sTimeCode
         put #DEVICE_FILE_NO,,sTimeCode
      end if
   end select

   '' show whatever the device sends us...
   while( loc(DEVICE_FILE_NO) > 0 )
      dim b as ubyte
      get #DEVICE_FILE_NO,,b
      color 13
      select case b
      case 32 to 127
         print chr(b);
      case else
         print "<"; hex(b,2); ">";
      end select

      '' CR or LF?  don't care, just print a new line
      if( b = 10 or b = 13 ) then
         print
      end if
   wend

   sleep 25, 1

loop

close #DEVICE_FILE_NO
color 7