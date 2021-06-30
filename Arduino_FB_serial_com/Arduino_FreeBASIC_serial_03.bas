#Include "SerialPort.inc"
#include "TerminalDisplay.inc"
#include "MessageBuffer.inc"

#ifdef __FB_LINUX__
   const DEVICE_COM = "/dev/ttyACM0"
#else
   const DEVICE_COM = "COM4"
#endif

const KEYBOARD_ESCAPE = 27
const KEYBOARD_ENTER = 13
const KEYBOARD_BACKSPACE = 8

#if defined(__FB_DOS__) or defined(__FB_WIN32__)
   const TERMINAL_EOL = chr(13, 10)
#else
   const TERMINAL_EOL = chr(10)
#endif

const KEYBOARD_EOL = chr(13)
const DEVICE_EOL = chr(10)

'' ----------------
'' MAIN
'' ----------------

dim shared serial as SerialPort
dim shared terminal as TerminalDisplay
dim shared cmd as MessageBuffer
dim shared response as MessageBuffer

'' setup()
with terminal
   .color( COLOR_KEYBOARD )
   .print( "keyboard" & KEYBOARD_EOL )
   .color( COLOR_TERMINAL )
   .print( "terminal" & TERMINAL_EOL )
   .color( COLOR_OUTPUT )
   .print( "output" & DEVICE_EOL )
   .color( COLOR_INPUT )
   .print( "input" & DEVICE_EOL )
   .color( COLOR_TERMINAL )
end with

serial.open( DEVICE_COM, 9600 )

if( serial ) then
   terminal.print( "connected" & TERMINAL_EOL )
else
   terminal.print( "error connecting to arduino" )
   end 1
end if

'' loop()
do
   '' read keyboard until we have complete command
   '' or escape, or no more keys to read

   dim k as string = inkey
   for i as integer = 1 to len(k)
      dim as integer ch = asc( k, i )

      '' escape? immediately exit
      if( ch = KEYBOARD_ESCAPE ) then
         exit do
      end if

      terminal.color( COLOR_KEYBOARD )
      terminal.write( ch )

      '' CR=>LF translation
      if( ch = KEYBOARD_ENTER ) then
         ch = END_OF_MESSAGE_CHAR
      end if

      if( ch = KEYBOARD_BACKSPACE ) then
         cmd.backChar()
      
      '' add char to command, and exit if we have full command
      elseif( cmd.addChar( ch ) ) then
         exit for
      end if
   next

   '' have a complete command? then send it
   if( cmd.isComplete() ) then
      terminal.color( COLOR_OUTPUT )
      terminal.write( cmd.buffer(), cmd.length() )
      terminal.write( DEVICE_EOL )

      serial.write( cmd.buffer(), cmd.length() )
      serial.write( DEVICE_EOL )

      '' done with the command, so clear it
      cmd.clear()
   end if

   '' read everything from the serial port until we have
   '' have a full response, or no more to read
   while( serial.available() > 0 )
      dim as integer ch = serial.read()
      if( response.addChar( ch ) ) then
         exit while
      end if
   wend

   '' have a complete response? then show it
   if( response.isComplete() ) then
      terminal.color( COLOR_INPUT )
      terminal.write( response.buffer(), response.length() )
      terminal.write( DEVICE_EOL )

      '' done with the response to clear it
      response.clear()
   end if

loop

'' exit()
serial.close()

with terminal
   .color( COLOR_TERMINAL )
   .print( "disconnected" & TERMINAL_EOL )
   .color( COLOR_TERMINAL )
end With