eggs={}
egg_wanim=split"124,125"
function spawn_egg(py)
 local e={}
 mk_en(e,py,2,4,2,1,1,6,6)
 e.spd,e.anim,e.vy=1.5,1,(rnd(1)-.5)*.4
 add(eggs,e)
end

function update_eggs()
 for e in all(eggs) do
  e.x-=e.spd
  e.y+=e.vy
  if e.y<8 or e.y>100 then e.vy=-e.vy end
  if e.x<-10 then del(eggs,e) end
  if frame_count%8==0 then e.anim=e.anim%2+1 end
  e:update_hitbox()
 end
end

function draw_eggs()
 for e in all(eggs) do
  blink_sprite(e)
  spr(egg_wanim[e.anim],e.x,e.y)
  pal()
  setpalt()
 end
end
