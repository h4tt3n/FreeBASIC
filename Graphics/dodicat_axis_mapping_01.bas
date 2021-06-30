

sleep 200
#define map(a,b,x,c,d)  ((d)-(c))*((x)-(a))/((b)-(a))+(c)
const white=rgb(255,255,255)
const red=rgb(200,0,0)
dim as integer xres,yres
screen 19,32,,1

screeninfo xres,yres
width 600\8,800\16

dim as single CentreX=4.05,CentreY=6.75,radius=2.200107
dim as long lim=10000
dim as double t,t1,t2

window  (0,0)-(10,10) 'cartesian

t=timer
for n as long=1 to lim
circle(CentreX,CentreY),radius,white
next
t1= timer-t 
sleep 200

window 'back to normal window

t=timer
for n as long=1 to lim
circle(map(0,10,CentreX,0,xres),map(0,10,CentreY,yres,0)),map(0,10,radius,0,xres),red 'cartesian
next
t2= timer-t

print "window ";t1;" seconds"
print "custom ";t2;" seconds"


sleep
 