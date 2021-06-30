'' Serial Communication Simulation
''
'' displays graphical simulation of
'' host communicating with device
'' over serial

'' character size
const SX = 8, SY = 8

'' helper macro to clamp values
#macro clamp( arg, min, max )
   if( arg < min ) then
      arg = min
   elseif( arg > max ) then
      arg = max
   end if
#endmacro

'' Timer class to help manage timers
'' when created or after reset()
'' counts number of ticks
'' status is true (signalled) when
'' current time > duration
type OnDelayTimer
   static time0 as integer
   declare static sub nexttick()

   time1 as integer
   duration as integer
   declare constructor( byval ondelay as integer )
   declare function status() as boolean
   declare sub reset()
end type
dim shared OnDelayTimer.time0 as integer

constructor OnDelayTimer( byval in_duration as integer )
   duration = in_duration
end constructor

function OnDelayTimer.status() as boolean
   return (time0 >= time1+duration)
end function

sub OnDelayTimer.nexttick()
   time0 += 1
end sub

sub OnDelayTimer.reset()
   time1 = time0
end sub

enum TIMER_ENUM
   TIMER_NONE = -1
   TIMER_GLOBAL = 0
   TIMER_HOST
   TIMER_SERIAL
   TIMER_DEVICE
   TIMER_COUNT
end enum

dim timers( 0 to TIMER_COUNT-1 ) as OnDelayTimer = _
   { _
      OnDelayTimer( 0 ), _
      OnDelayTimer( 10 ), _
      OnDelayTimer( 30 ), _
      OnDelayTimer( 20 ) _
   }

enum STYLE_ENUM
   STYLE_BOX
   STYLE_WIRE
end enum

'' component class to manage the on-screen components

type Component
   title as string
   row1 as integer
   col1 as integer
   rows as integer
   cols as integer
   text as string
   scroll as boolean
   maxRemoveChar as integer
   timerId as TIMER_ENUM
   style as STYLE_ENUM
   eolChar as integer
   borderColor as integer
   declare constructor _
      ( _
         byref in_title as string, _
         byval in_row1 as integer, byval in_col1 as integer, _
         byval in_rows as integer, byval in_cols as integer, _
         byval in_color as integer, _
         byval in_timerId as TIMER_ENUM = TIMER_NONE, _
         byval in_style as STYLE_ENUM = STYLE_BOX _
      )
   declare sub add( byref k as const string )
   declare function remove( byval count as integer = 0, byval eol as integer = 0 ) as string
   declare sub render()
end type

constructor Component _
   ( _
      byref in_title as string, _
      byval in_row1 as integer, byval in_col1 as integer, _
      byval in_rows as integer, byval in_cols as integer, _
      byval in_color as integer, _
      byval in_timerId as TIMER_ENUM = TIMER_NONE, _
      byval in_style as STYLE_ENUM = STYLE_BOX _
   )
   title = in_title
   row1 = in_row1
   col1 = in_col1
   rows = in_rows
   cols = in_cols
   borderColor = in_color
   timerId = in_timerId
   style = in_style
end constructor

sub Component.add( byref k as const string )
   if( scroll ) then
      text &= k
      while( len(text) > rows * cols )
         text = mid( text, cols+1 )   
      wend
   else
      text = left( text & k, rows * cols )
   end if
end sub

function Component.remove( byval count as integer = 0, byval eol as integer = 0 ) as string
   if( count <= 0 ) then
      count = len(text)
   end if
   if( eol > 0 ) then
      count = instr( text, chr(eol) )
   end if
   function = left( text, count )
   text = mid( text, count + 1 )
end function

sub Component.render()
   dim x1 as single = (col1-1) * SX
   dim y1 as single = (row1-1) * SY
   dim x2 as single = (col1+cols-1) * SX
   dim y2 as single = (row1+rows-1) * SY

   if( style = STYLE_WIRE ) then
      line ( x1+SX\2, y1+SY\2 ) - ( x2, y2-SY\2 ), 8, , &hf0f0

      '' text
      for row as integer = 0 to rows-1
         dim s as string = mid( text, row*cols+1, cols )
         draw string ( (x1 + x2 + len(s)*SX)\2, y1+(row*SY) ), s, 15
      next

   else
      '' title
      dim s as string = title
      if( eolChar <> 0 ) then
         s &= " (need CR)"
      end if

      draw string( x1 - SX\2, y1-(2*SY) ), s, 7

      '' fill
      if( text > "" ) then
         line ( x1-2, y1-2 ) - ( x2+2, y2+2 ), 1, bf
      end if

      '' border
      line ( x1-3, y1-3 ) - ( x2+3, y2+3 ), borderColor, b

      '' text
      for row as integer = 0 to rows-1
         draw string ( x1, y1+(row*SY) ), mid( text, row*cols+1, cols ), 15
      next
   end if

end sub

enum COMPONENT_ID
   CMP_DISPLAY
   CMP_HOST_IN
   CMP_HOST_RX
   CMP_WIRE1
   CMP_DEV_TX
   CMP_DEV_OUT
   CMP_DEV_IN
   CMP_DEV_RX
   CMP_WIRE2
   CMP_HOST_TX
   CMP_HOST_OUT
   CMP_KEYBOARD

   COMPONENT_COUNT
end enum

'' ----
'' MAIN
'' ----

dim components( 0 to COMPONENT_COUNT-1 ) as Component = _
   { _
      Component( "Display",     5,  5, 5, 16, 15, TIMER_HOST ), _
      Component( "Host In",    15,  5, 1, 16, 14, TIMER_HOST ), _
      Component( "Serial In",  20,  5, 1, 16,  8, TIMER_SERIAL ), _
      Component( "Wire 1",     20, 21, 1, 38,  8, TIMER_SERIAL, STYLE_WIRE ), _
      Component( "Serial Out", 20, 60, 1, 16,  8, TIMER_DEVICE ), _
      Component( "Device Out", 25, 60, 1, 16, 14, TIMER_DEVICE ), _
      Component( "Device In",  30, 60, 1, 16, 14, TIMER_DEVICE ), _
      Component( "Serial In",  35, 60, 1, 16,  8, TIMER_SERIAL ), _
      Component( "Wire 2",     35, 21, 1, 38,  8, TIMER_SERIAL, STYLE_WIRE ), _
      Component( "Serial Out", 35,  5, 1, 16,  8, TIMER_HOST ), _
      Component( "Host Out",   40,  5, 1, 16, 14, TIMER_HOST ), _
      Component( "Keyboard",   45,  5, 1, 16, 15, TIMER_NONE ) _
   }

components( CMP_DISPLAY ).scroll = true
components( CMP_HOST_TX ).maxRemoveChar = 1
components( CMP_DEV_TX ).maxRemoveChar = 1
components( CMP_WIRE1 ).maxRemoveChar = 1
components( CMP_WIRE2 ).maxRemoveChar = 1

dim page as integer = 0
screenres 640, 480, 8, 2
screenset 1-page, page
dim paused as boolean

do
   if( not paused ) then
      timers( TIMER_GLOBAL ).nexttick()
   end if
      
   dim k as string = inkey

   '' input
   select case k
   case chr(27) '' escape
      exit do
   case chr(9)
      paused = not paused
   case chr(13) '' enter
      components( CMP_KEYBOARD ).add( k )
   case chr(&hff,&h3b) '' F1
      timers( TIMER_HOST ).duration += 1
   case chr(&hff,&h54) '' Shift+F1
      timers( TIMER_HOST ).duration -= 1
   case chr(&hff,&h3c) '' F2
      timers( TIMER_SERIAL ).duration += 1
   case chr(&hff,&h55) '' Shift+F2
      timers( TIMER_SERIAL ).duration -= 1
   case chr(&hff,&h3d) '' F3
      timers( TIMER_DEVICE ).duration += 1
   case chr(&hff,&h56) '' Shift+F3
      timers( TIMER_DEVICE ).duration -= 1
   case chr(&hff,&h3e) '' F4
      components( CMP_DISPLAY ).remove()
   case chr(&hff,&h3f) '' F5
      components( CMP_HOST_OUT ).eolChar xor=13
   case chr(&hff,&h40) '' F6
      components( CMP_DEV_IN ).eolChar xor=13
   case chr(&hff,&h41) '' F7
      components( CMP_DEV_OUT ).eolChar xor=13
   case chr(&hff,&h42) '' F8
      components( CMP_HOST_IN ).eolChar xor=13
   case chr(&hff,&h43) '' F9
      for i as integer = 0 to COMPONENT_COUNT-1
         components( i ).text = ""
         components( i ).eolChar = 0
      next
   case chr(32) to chr(126)
      components( CMP_KEYBOARD ).add( k )
   end select

   clamp( timers( TIMER_HOST ).duration, 0, 100 )
   clamp( timers( TIMER_SERIAL ).duration, 0, 100 )
   clamp( timers( TIMER_DEVICE ).duration, 0, 100 )

   '' simulation - move the data through the pipe line
   for i as integer = 0 to COMPONENT_COUNT-2
      if( timers( components(i).timerId ).status() ) then
         components(i).add( components(i+1).remove( components(i+1).maxRemoveChar, components(i+1).eolChar ) )
      end if
   next

   '' reset all elapsed timers
   for i as integer = 1 to TIMER_COUNT-1
      if( timers(i).status() ) then
         timers(i).reset()
      end if
   next

   '' render
   cls
   for i as integer = 0 to COMPONENT_COUNT-1
      components(i).render()
   next

   if( paused ) then
      color 12: locate 27, 20: print "---<<< P A U S E D >>>---"
   end if

   locate 5, 30
   color 15: print using "Host Speed  : ###%"; 100 - timers( TIMER_HOST ).duration;
   color  7: print "  (F1/Shift+F1 to adjust)"

   locate 7, 30
   color 15: print using "Serial Speed: ###%"; 100 - timers( TIMER_SERIAL ).duration;
   color  7: print "  (F2/Shift+F2 to adjust)"

   locate 9, 30
   color 15: print using "Device Speed: ###%"; 100 - timers( TIMER_DEVICE ).duration;
   color  7: print "  (F3/Shift+F3 to adjust)"

   color 10: locate 48, 5: print "Type keys to start"
   color  7: locate 50, 5: print "ESC to EXIT"

   color  7: locate 40, 30: print "F4 to clear display"
   color 14
   locate 42, 30: print "F5 to toggle 'Host Out' buffering"
   locate 44, 30: print "F6 to toggle 'Device In' buffering"
   locate 46, 30: print "F7 to toggle 'Device Out' buffering"
   locate 48, 30: print "F8 to toggle 'Host In' buffering"

   color 7
   locate 50, 30: print "F9 to reset everything"

   '' page flip
   page = 1-page
   screenset 1-page, page
   sleep 25, 1
Loop