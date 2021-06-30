  var   iphys_fps = 1/67, phys_t = 0f
  var   ianim_fps = 1/57, anim_t = 0f
  var   tp = Timer
  Var   pi = Atn(1.0) * 4.0
 
  while inkey=""
    if anim_t <= 0 then
      screenlock
        ' ..
      screenunlock
      while anim_t < 0
        anim_t += ianim_fps
      wend
    endif
   
    sleep 1
   
    var t=timer, dt=t-tp
    tp=t
   
    anim_t -= dt
    phys_t += dt

    var frames=0
    while phys_t>0
      frames += 1
      phys_t -= iphys_fps
    wend
   
    'var rate = pi*iphys_fps*frames
   ' incr axis.a0, .1*rate, twopi
    ' ..
  Wend