'' include fbgfx.bi for some useful definitions
#include "fbgfx.bi"

Dim As String driver

#ifdef __FB_WIN32__
'' set graphics driver to GDI (Win32 only), before calling ScreenRes
ScreenControl FB.SET_DRIVER_NAME, "GDI"
#endif

ScreenRes 640, 480

'' fetch graphics driver name and display it to user
ScreenControl FB.GET_DRIVER_NAME, driver
Print "Graphics driver name: " & driver

'' wait for a keypress before closing the window
Sleep